--[[
    Auto Teleport to Sea 1 / Private Server Library
    Automatically executes homescreen -> Sea 1 private server teleport.
    Place Guard: Only executes on GPO Homescreen (PlaceId: 1730877806).
    Completely silent & safe if executed in Sea 1 or anywhere else.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

local Sea1Teleport = {
    HOMESCREEN_PLACE_ID = 1730877806,
    GPO_UNIVERSE_ID = 648454481,
    DefaultVipCode = "Jk2JKTAKCf",
}

local function clickGuiButton(btn)
    if not btn then
        return false
    end
    if typeof(firesignal) == "function" then
        if btn.MouseButton1Click then
            firesignal(btn.MouseButton1Click)
        end
        if btn.Activated then
            firesignal(btn.Activated)
        end
        if btn.MouseButton1Down then
            firesignal(btn.MouseButton1Down)
        end
        if btn.MouseButton1Up then
            firesignal(btn.MouseButton1Up)
        end
        return true
    end
    return false
end

function Sea1Teleport.IsOnHomescreen()
    return game.PlaceId == Sea1Teleport.HOMESCREEN_PLACE_ID
end

function Sea1Teleport.Join(vipCode)
    if not Sea1Teleport.IsOnHomescreen() then
        print("[AutoSea1] Already in-game (PlaceId: " .. tostring(game.PlaceId) .. "). No teleport needed.")
        return false
    end

    local code = vipCode or Sea1Teleport.DefaultVipCode
    print(string.format("[AutoSea1] Homescreen detected. Waiting for loading screen to complete...", tostring(code)))

    task.spawn(function()
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 30)
        if not PlayerGui then
            return
        end

        -- 1. Wait for actual LoadingGUI to disappear (inspected via MCP)
        local loadingGui = PlayerGui:WaitForChild("LoadingGUI", 3)
            or PlayerGui:FindFirstChild("LoadingScreen")
            or PlayerGui:FindFirstChild("Loading")
        if loadingGui then
            print("[AutoSea1] LoadingGUI active, waiting for it to finish...")
            while loadingGui.Parent == PlayerGui and loadingGui.Enabled do
                task.wait(0.5)
            end
            task.wait(0.5)
        end

        -- Direct Shortcut: If chooseType is ALREADY open, fire immediately!
        local chooseType = PlayerGui:FindFirstChild("chooseType")
        if chooseType and chooseType.Enabled then
            local chooseRemote = chooseType:FindFirstChild("Frame") and chooseType.Frame:FindFirstChild("RemoteEvent")
            if chooseRemote then
                pcall(function()
                    chooseRemote:FireServer(true)
                end)
            end
            local regBtn = chooseType:FindFirstChild("Frame")
                and chooseType.Frame:FindFirstChild("Options")
                and chooseType.Frame.Options:FindFirstChild("Regular")
            if regBtn then
                clickGuiButton(regBtn)
                print("[AutoSea1] 🚀 chooseType already open! Teleporting directly to Regular VIP...")
                return
            end
        end

        -- 2. Dismiss "Click anywhere / Press any key" overlay
        print("[AutoSea1] Dismissing splash screen...")
        for _ = 1, 15 do
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)

            local startMenu = PlayerGui:FindFirstChild("Start")
            if startMenu and startMenu:FindFirstChild("Menu") and startMenu.Menu.Visible then
                break
            end
            task.wait(0.3)
        end

        local events = ReplicatedStorage:WaitForChild("Events", 15)
        local takeStamRemote = events and events:FindFirstChild("takestam")
        local reservedRemote = events and events:FindFirstChild("reserved")

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local cframe = hrp and hrp.CFrame or CFrame.new(307.57, 8.01, -11449.29, 0.05, 0, -0.99, 0, 1, 0, 0.99, 0, 0.05)

        -- 3. Dash Remote
        if takeStamRemote then
            pcall(function()
                takeStamRemote:FireServer(1, "dash", cframe)
            end)
        end

        task.wait(0.2)

        -- 4. Submit custom VIP code if set
        if code and code ~= "" and reservedRemote and reservedRemote:IsA("RemoteFunction") then
            pcall(function()
                reservedRemote:InvokeServer(code)
            end)

            local privPanel = PlayerGui:FindFirstChild("PrivateServers")
                and PlayerGui.PrivateServers:FindFirstChild("PrivateServersPanel")
            if
                privPanel
                and privPanel:FindFirstChild("ServerCodeBox")
                and privPanel.ServerCodeBox:FindFirstChild("TextBox")
            then
                privPanel.ServerCodeBox.TextBox.Text = code
                if typeof(firesignal) == "function" and privPanel.ServerCodeBox.TextBox.FocusLost then
                    firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
                end
            end
        end

        -- 5. Open Private Servers Menu with extended retry
        for _ = 1, 40 do
            local startMenu = PlayerGui:FindFirstChild("Start")
            local privateBtn = startMenu
                and startMenu:FindFirstChild("Menu")
                and startMenu.Menu:FindFirstChild("Main")
                and startMenu.Menu.Main:FindFirstChild("List")
                and startMenu.Menu.Main.List:FindFirstChild("PrivateServersButton")
            if privateBtn and privateBtn.Visible then
                clickGuiButton(privateBtn)
                break
            end
            task.wait(0.25)
        end

        task.wait(0.25)

        -- 6. Fire Regular Server Remote & click button with extended retry
        for _ = 1, 40 do
            local chooseType = PlayerGui:FindFirstChild("chooseType")
            if chooseType and chooseType.Enabled then
                local chooseRemote = chooseType:FindFirstChild("Frame")
                    and chooseType.Frame:FindFirstChild("RemoteEvent")
                if chooseRemote then
                    pcall(function()
                        chooseRemote:FireServer(true)
                    end)
                end

                local regBtn = chooseType:FindFirstChild("Frame")
                    and chooseType.Frame:FindFirstChild("Options")
                    and chooseType.Frame.Options:FindFirstChild("Regular")
                if regBtn then
                    clickGuiButton(regBtn)
                    print("[AutoSea1] 🚀 VIP Server selected! Teleporting...")
                    break
                end
            end
            task.wait(0.25)
        end
    end)

    return true
end

-- Auto-run on inject if on homescreen
if Sea1Teleport.IsOnHomescreen() then
    task.spawn(function()
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        Sea1Teleport.Join()
    end)
end

return Sea1Teleport
