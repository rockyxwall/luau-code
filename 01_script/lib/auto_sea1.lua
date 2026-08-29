--[[
    Auto Teleport to Sea 1 / Private Server Library
    Robust state-checked pipeline from homescreen boot to Sea 1 private server.
    Place Guard: Only executes on GPO Homescreen (PlaceId: 1730877806).
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
    print(string.format("[AutoSea1] Starting homescreen sequence (VIP Code: %s)...", tostring(code)))

    task.spawn(function()
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 30)
        if not PlayerGui then
            return
        end

        -- Step 1: Wait for Loading Screen to completely finish
        while true do
            local loadingGui = PlayerGui:FindFirstChild("LoadingGUI")
            if not loadingGui or not loadingGui.Enabled then
                break
            end
            task.wait(0.3)
        end

        -- Step 2: Wait for "Press any key to continue" / StartScreen UI to appear
        print("[AutoSea1] Waiting for StartScreen / Press Any Key text...")
        local startGui = PlayerGui:WaitForChild("Start", 30)
        if not startGui then
            warn("[AutoSea1] Start GUI not found!")
            return
        end

        -- Step 3: Dismiss "Press any key to continue" by spamming space/click until Start.Menu is visible
        print("[AutoSea1] Dismissing 'Press any key' title screen...")
        while startGui.Parent == PlayerGui do
            local menu = startGui:FindFirstChild("Menu")
            if menu and menu.Visible then
                break
            end
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            task.wait(0.2)
        end
        print("[AutoSea1] Start Menu is now visible!")

        -- Step 4: Fire Dash Remote (required by game anticheat/state)
        local events = ReplicatedStorage:WaitForChild("Events", 15)
        local takeStamRemote = events and events:WaitForChild("takestam", 5)
        local reservedRemote = events and events:WaitForChild("reserved", 5)

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local cframe = hrp and hrp.CFrame or CFrame.new(307.57, 8.01, -11449.29, 0.05, 0, -0.99, 0, 1, 0, 0.99, 0, 0.05)

        if takeStamRemote then
            pcall(function()
                takeStamRemote:FireServer(1, "dash", cframe)
            end)
        end

        task.wait(0.2)

        -- Step 5: Submit custom VIP code if set
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

        -- Step 6: Wait for and Click "PrivateServersButton"
        print("[AutoSea1] Clicking PrivateServersButton...")
        while true do
            local menu = startGui:FindFirstChild("Menu")
            local list = menu and menu:FindFirstChild("Main") and menu.Main:FindFirstChild("List")
            local privateBtn = list and list:FindFirstChild("PrivateServersButton")
            if privateBtn and privateBtn.Visible then
                clickGuiButton(privateBtn)
                break
            end
            task.wait(0.2)
        end

        -- Step 7: Wait for chooseType dialog and click "Regular"
        print("[AutoSea1] Waiting for chooseType dialog...")
        local chooseType = PlayerGui:WaitForChild("chooseType", 15)
        if chooseType then
            while chooseType.Parent == PlayerGui and chooseType.Enabled do
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
                    print("[AutoSea1] 🚀 Selected Regular VIP server! Joining...")
                    break
                end
                task.wait(0.2)
            end
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
