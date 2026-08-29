local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- 1. LOAD RAYFIELD UI LIBRARY (Dual Source Fallback)
local Rayfield = nil
local rayfieldSources = {
    "https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua",
    "https://sirius.menu/rayfield",
    "https://raw.githubusercontent.com/shlexware/Rayfield/main/source",
}

for _, url in ipairs(rayfieldSources) do
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success and result then
        Rayfield = result
        break
    end
end

if not Rayfield then
    error("[Compact Hub] Failed to load Rayfield UI Library.")
end

local Window = Rayfield:CreateWindow({
    Name = "Compact Hub",
    LoadingTitle = "Loading Auto-Clicker...",
    LoadingSubtitle = "Optimized Version",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
})

-- 2. INJECT UI SCALE (Safely scales UI by 82% for compact view)
task.spawn(function()
    task.wait(1.2)
    pcall(function()
        local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
        local gui = parentGui:FindFirstChild("Rayfield")
            or LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Rayfield")
        if gui and gui:FindFirstChild("Main") then
            local scale = Instance.new("UIScale")
            scale.Scale = 0.82
            scale.Parent = gui.Main
        end
    end)
end)

-- 3. BUILD UI AND LOGIC
local MainTab = Window:CreateTab("Controls", 4483362458)
local autoFiring = false
local fireDelay = 0.1

local AutoToggle = MainTab:CreateToggle({
    Name = "Auto-Fire MouseClicked",
    CurrentValue = false,
    Flag = "AutoFire",
    Callback = function(Value)
        autoFiring = Value
        if autoFiring then
            task.spawn(function()
                while autoFiring do
                    local remote = ReplicatedStorage:FindFirstChild("MouseClicked")
                    if remote and remote:IsA("RemoteEvent") then
                        pcall(function()
                            remote:FireServer()
                        end)
                    end
                    task.wait(fireDelay)
                end
            end)
        end
    end,
})

MainTab:CreateSlider({
    Name = "Click Delay",
    Range = { 0, 1 },
    Increment = 0.05,
    Suffix = "s",
    CurrentValue = 0.1,
    Flag = "DelaySlider",
    Callback = function(Value)
        fireDelay = Value
    end,
})

MainTab:CreateButton({
    Name = "Destroy Script",
    Callback = function()
        autoFiring = false
        Rayfield:Destroy()
    end,
})

-- 4. FINALIZE
Rayfield:LoadConfiguration()
