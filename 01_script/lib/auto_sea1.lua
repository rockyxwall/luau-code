--[[
    Auto Teleport to Sea 1 / Private Server Library
    Automatically executes homescreen -> Sea 1 private server teleport.
    Place Guard: Only executes on GPO Homescreen (PlaceId: 1730877806).
    Completely silent & safe if executed in Sea 1 or anywhere else.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
    print(string.format("[AutoSea1] Homescreen detected. Auto-teleporting to Sea 1 PS (Code: %s)...", tostring(code)))

    task.spawn(function()
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
        if not PlayerGui then
            return
        end

        local events = ReplicatedStorage:WaitForChild("Events", 10)
        local takeStamRemote = events and events:FindFirstChild("takestam")
        local reservedRemote = events and events:FindFirstChild("reserved")

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local cframe = hrp and hrp.CFrame or CFrame.new(307.57, 8.01, -11449.29, 0.05, 0, -0.99, 0, 1, 0, 0.99, 0, 0.05)

        -- Step 1: Dash Remote
        if takeStamRemote then
            pcall(function()
                takeStamRemote:FireServer(1, "dash", cframe)
            end)
        end

        task.wait(0.1)

        -- Step 2: Submit custom VIP code if set
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

        -- Step 3: Open Private Servers Menu
        local startMenu = PlayerGui:FindFirstChild("Start")
        local privateBtn = startMenu
            and startMenu:FindFirstChild("Menu")
            and startMenu.Menu:FindFirstChild("Main")
            and startMenu.Menu.Main:FindFirstChild("List")
            and startMenu.Menu.Main.List:FindFirstChild("PrivateServersButton")
        if privateBtn then
            clickGuiButton(privateBtn)
        end

        task.wait(0.15)

        -- Step 4: Fire Regular Server Remote & click button
        local chooseType = PlayerGui:FindFirstChild("chooseType")
        if chooseType then
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
