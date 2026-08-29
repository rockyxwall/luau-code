--[[
    Auto Teleport to Sea 1 / Private Server Library
    Matches natural game flow: StartScreen -> Menu -> PrivateServersButton -> chooseType -> Regular
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

        -- Step 1: Wait for Start.StartScreen
        print("[AutoSea1] 1/5 Waiting for PlayerGui.Start.StartScreen...")
        local startGui = PlayerGui:WaitForChild("Start", 30)
        if not startGui then
            warn("[AutoSea1] Start GUI not found!")
            return
        end

        local startScreen = startGui:WaitForChild("StartScreen", 30)
        while
            startScreen
            and not startScreen.Visible
            and not (startGui:FindFirstChild("Menu") and startGui.Menu.Visible)
        do
            task.wait(0.2)
        end

        -- Step 2: Press key (Space) until Start.Menu is visible
        print("[AutoSea1] 2/5 Pressing key to open Start.Menu...")
        while startGui.Parent == PlayerGui do
            local menu = startGui:FindFirstChild("Menu")
            if menu and menu.Visible then
                break
            end
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            task.wait(0.25)
        end
        print("[AutoSea1] 3/5 Start.Menu is open!")

        -- Step 3: Click PrivateServersButton (This opens chooseType dialog)
        print("[AutoSea1] 4/5 Clicking PrivateServersButton...")
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

        -- Step 4: Fire dash & reserved remote (VIP code backend)
        local events = ReplicatedStorage:WaitForChild("Events", 15)
        local takeStamRemote = events and events:FindFirstChild("takestam")
        local reservedRemote = events and events:FindFirstChild("reserved")

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local cframe = hrp and hrp.CFrame or CFrame.new(307.57, 8.01, -11449.29, 0.05, 0, -0.99, 0, 1, 0, 0.99, 0, 0.05)

        if takeStamRemote then
            pcall(function()
                takeStamRemote:FireServer(1, "dash", cframe)
            end)
        end

        if code and code ~= "" and reservedRemote and reservedRemote:IsA("RemoteFunction") then
            pcall(function()
                reservedRemote:InvokeServer(code)
            end)
        end

        -- Step 5: Wait for chooseType dialog and click "Regular"
        print("[AutoSea1] 5/5 Waiting for chooseType popup and clicking Regular...")
        local chooseType = PlayerGui:WaitForChild("chooseType", 20)
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
                    print("[AutoSea1] 🚀 Selected Regular VIP Server! Teleporting to Sea 1...")
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
