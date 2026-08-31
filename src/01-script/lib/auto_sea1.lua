--[[
    Auto Teleport to Sea 1 / Private Server Library
    Robust physical screen position & absolute pixel visibility verification.
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

-- Checks if GUI object is truly on screen (rendered on viewport and not hidden off-screen)
local function isGuiRenderedOnScreen(gui)
    if not gui or not gui:IsA("GuiObject") then
        return false
    end
    if not gui.Visible then
        return false
    end

    -- Verify ScreenGui container is enabled
    local screenGui = gui:FindFirstAncestorOfClass("ScreenGui")
    if screenGui and not screenGui.Enabled then
        return false
    end

    -- Verify parent hierarchy is all visible
    local parent = gui.Parent
    while parent and parent:IsA("GuiObject") do
        if not parent.Visible then
            return false
        end
        parent = parent.Parent
    end

    -- Check physical pixel size and on-screen coordinates
    local pos = gui.AbsolutePosition
    local size = gui.AbsoluteSize
    if size.X <= 0 or size.Y <= 0 then
        return false
    end
    if pos.Y < -50 or pos.X < -50 then
        return false
    end

    return true
end

local function clickGuiButton(btn)
    if not btn then
        return false
    end

    -- Method 1: Physical screen click at center of button via VirtualInputManager
    if btn:IsA("GuiObject") then
        local center = btn.AbsolutePosition + (btn.AbsoluteSize / 2)
        VIM:SendMouseMoveEvent(center.X, center.Y, game)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(center.X, center.Y, 0, true, game, 0)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(center.X, center.Y, 0, false, game, 0)
    end

    -- Method 2: firesignal engine fallback
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
    end
    return true
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

        -- Step 1: Wait for LoadingGUI to completely vanish
        while true do
            local loadingGui = PlayerGui:FindFirstChild("LoadingGUI")
            if not loadingGui or not loadingGui.Enabled then
                break
            end
            task.wait(0.5)
        end
        print("[AutoSea1] Step 1 passed: Loading screen finished.")

        -- Step 2: Wait for StartScreen TextLabel ("Press any key to continue") to be physically on screen
        local startGui = PlayerGui:WaitForChild("Start", 30)
        local startScreen = startGui and startGui:WaitForChild("StartScreen", 30)
        local splashText = startScreen and startScreen:WaitForChild("TextLabel", 10)

        print("[AutoSea1] Step 2: Waiting for 'Press any key to continue' text on screen...")
        while startScreen and not isGuiRenderedOnScreen(splashText) do
            local menu = startGui:FindFirstChild("Menu")
            local list = menu and menu:FindFirstChild("Main") and menu.Main:FindFirstChild("List")
            local privateBtn = list and list:FindFirstChild("PrivateServersButton")
            if isGuiRenderedOnScreen(privateBtn) then
                break
            end
            task.wait(0.3)
        end

        -- Step 3: Dismiss splash screen until Start.Menu is physically visible
        print("[AutoSea1] Step 3: Dismissing splash screen...")
        while true do
            local menu = startGui:FindFirstChild("Menu")
            local list = menu and menu:FindFirstChild("Main") and menu.Main:FindFirstChild("List")
            local privateBtn = list and list:FindFirstChild("PrivateServersButton")
            if isGuiRenderedOnScreen(privateBtn) then
                print("[AutoSea1] Start menu list is physically rendered on screen!")
                break
            end
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            task.wait(0.3)
        end

        -- Step 4: Click PrivateServersButton (Physical mouse click + firesignal)
        print("[AutoSea1] Step 4: Clicking PrivateServersButton...")
        while true do
            local menu = startGui:FindFirstChild("Menu")
            local list = menu and menu:FindFirstChild("Main") and menu.Main:FindFirstChild("List")
            local privateBtn = list and list:FindFirstChild("PrivateServersButton")
            if isGuiRenderedOnScreen(privateBtn) then
                clickGuiButton(privateBtn)
                break
            end
            task.wait(0.2)
        end

        -- Step 5: Backend Dash + Reserved VIP Code
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

        -- Step 6: Wait for chooseType dialog and click "Regular"
        print("[AutoSea1] Step 6: Waiting for chooseType dialog on screen...")
        local chooseType = PlayerGui:WaitForChild("chooseType", 20)
        while true do
            if chooseType and chooseType.Enabled then
                local regBtn = chooseType:FindFirstChild("Frame")
                    and chooseType.Frame:FindFirstChild("Options")
                    and chooseType.Frame.Options:FindFirstChild("Regular")
                if isGuiRenderedOnScreen(regBtn) then
                    local chooseRemote = chooseType:FindFirstChild("Frame")
                        and chooseType.Frame:FindFirstChild("RemoteEvent")
                    if chooseRemote then
                        pcall(function()
                            chooseRemote:FireServer(true)
                        end)
                    end
                    clickGuiButton(regBtn)
                    print("[AutoSea1] 🚀 Clicked Regular button! Joining Sea 1...")
                    break
                end
            end
            task.wait(0.2)
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
