-- [UPD] +1 Banana Monkey Destruction - Self-Contained Mobile Hub
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- Cleanup existing instances
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
if parentGui:FindFirstChild("BananaMonkeyHubGui") then
    parentGui.BananaMonkeyHubGui:Destroy()
end

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaMonkeyHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui

-- State Variables
local autoDestroying = false
local autoJumping = false
local autoMoving = false
local destroyDelay = 0.1
local punchPower = 2
local radiusSize = 3.5

-- 1. FLOATING MOBILE TOGGLE BUTTON (🍌)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "FloatingToggle"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleBtn.Text = "🍌"
ToggleBtn.TextSize = 28
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0.5, 0)
toggleCorner.Parent = ToggleBtn

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 2
toggleStroke.Parent = ToggleBtn

-- 2. MAIN WINDOW FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 310)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 165, 0)
mainStroke.Thickness = 1.5
mainStroke.Parent = MainFrame

-- Header Title
local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, -40, 0, 36)
Header.Position = UDim2.new(0, 12, 0, 4)
Header.BackgroundTransparency = 1
Header.Text = "Banana Monkey Hub 🍌"
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 18
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -40, 0, 16)
Subtitle.Position = UDim2.new(0, 12, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Auto-Destroy, Jump & Walk Around"
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.SourceSans
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame

-- Close Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Divider Line
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 52)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- 3. AUTO-DESTROY WIDE RADIUS TOGGLE
local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(1, -24, 0, 38)
AutoBtn.Position = UDim2.new(0, 12, 0, 60)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
AutoBtn.Text = "Auto-Destroy Ground: OFF"
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.TextSize = 14
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.Parent = MainFrame

local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = AutoBtn

local autoStroke = Instance.new("UIStroke")
autoStroke.Color = Color3.fromRGB(60, 60, 80)
autoStroke.Thickness = 1
autoStroke.Parent = AutoBtn

-- Define 3x3 Offset Pattern around character
local function getOffsets(r)
    return {
        Vector3.new(0, 0, 0), -- Center (Character Position)
        Vector3.new(0, -2, 0), -- Directly under
        Vector3.new(r, 0, 0), -- Right
        Vector3.new(-r, 0, 0), -- Left
        Vector3.new(0, 0, r), -- Front
        Vector3.new(0, 0, -r), -- Back
        Vector3.new(r * 0.7, 0, r * 0.7), -- Front-Right
        Vector3.new(-r * 0.7, 0, r * 0.7), -- Front-Left
        Vector3.new(r * 0.7, 0, -r * 0.7), -- Back-Right
        Vector3.new(-r * 0.7, 0, -r * 0.7), -- Back-Left
    }
end

AutoBtn.MouseButton1Click:Connect(function()
    autoDestroying = not autoDestroying
    if autoDestroying then
        AutoBtn.Text = "Auto-Destroy Ground: ON ⚡"
        AutoBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
        AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 35)
        autoStroke.Color = Color3.fromRGB(90, 255, 140)

        task.spawn(function()
            while autoDestroying do
                local character = LocalPlayer.Character
                if character then
                    local root = character:FindFirstChild("HumanoidRootPart")
                    if root then
                        local punchEvent = ReplicatedStorage:FindFirstChild("Destruction_Punch", true)
                        if punchEvent and punchEvent:IsA("RemoteEvent") then
                            local basePos = root.Position
                            local offsets = getOffsets(radiusSize)

                            for _, offset in ipairs(offsets) do
                                if not autoDestroying then
                                    break
                                end
                                pcall(function()
                                    punchEvent:FireServer(punchPower, basePos + offset)
                                end)
                            end
                        end
                    end
                end
                task.wait(destroyDelay)
            end
        end)
    else
        AutoBtn.Text = "Auto-Destroy Ground: OFF"
        AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
        AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
        autoStroke.Color = Color3.fromRGB(60, 60, 80)
    end
end)

-- 4. AUTO JUMP TOGGLE (INDEPENDENT LOOP)
local JumpBtn = Instance.new("TextButton")
JumpBtn.Size = UDim2.new(1, -24, 0, 32)
JumpBtn.Position = UDim2.new(0, 12, 0, 104)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
JumpBtn.Text = "Auto Jump: OFF"
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.TextSize = 13
JumpBtn.Font = Enum.Font.SourceSansBold
JumpBtn.Parent = MainFrame

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(0, 8)
jumpCorner.Parent = JumpBtn

local jumpStroke = Instance.new("UIStroke")
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
jumpStroke.Thickness = 1
jumpStroke.Parent = JumpBtn

JumpBtn.MouseButton1Click:Connect(function()
    autoJumping = not autoJumping
    if autoJumping then
        JumpBtn.Text = "Auto Jump: ON 🦘"
        JumpBtn.TextColor3 = Color3.fromRGB(255, 200, 90)
        JumpBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 20)
        jumpStroke.Color = Color3.fromRGB(255, 200, 90)

        task.spawn(function()
            while autoJumping do
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        pcall(function()
                            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                            humanoid.Jump = true
                        end)
                    end
                end
                task.wait(0.25)
            end
        end)
    else
        JumpBtn.Text = "Auto Jump: OFF"
        JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
        jumpStroke.Color = Color3.fromRGB(60, 60, 80)
    end
end)

-- 5. AUTO-MOVE / WALK AROUND TOGGLE (INDEPENDENT LOOP)
local MoveBtn = Instance.new("TextButton")
MoveBtn.Size = UDim2.new(1, -24, 0, 32)
MoveBtn.Position = UDim2.new(0, 12, 0, 142)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
MoveBtn.Text = "Auto-Move (Walk Around): OFF"
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.TextSize = 13
MoveBtn.Font = Enum.Font.SourceSansBold
MoveBtn.Parent = MainFrame

local moveCorner = Instance.new("UICorner")
moveCorner.CornerRadius = UDim.new(0, 8)
moveCorner.Parent = MoveBtn

local moveStroke = Instance.new("UIStroke")
moveStroke.Color = Color3.fromRGB(60, 60, 80)
moveStroke.Thickness = 1
moveStroke.Parent = MoveBtn

MoveBtn.MouseButton1Click:Connect(function()
    autoMoving = not autoMoving
    if autoMoving then
        MoveBtn.Text = "Auto-Move (Walk Around): ON 🚶"
        MoveBtn.TextColor3 = Color3.fromRGB(90, 200, 255)
        MoveBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 60)
        moveStroke.Color = Color3.fromRGB(90, 200, 255)

        task.spawn(function()
            local angle = 0
            while autoMoving do
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        angle = angle + 0.8
                        local moveDir = Vector3.new(math.cos(angle), 0, math.sin(angle))
                        humanoid:Move(moveDir, false)
                    end
                end
                task.wait(0.1)
            end
        end)
    else
        MoveBtn.Text = "Auto-Move (Walk Around): OFF"
        MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
        moveStroke.Color = Color3.fromRGB(60, 60, 80)
    end
end)

-- 6. SPEED CONTROLS
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -24, 0, 18)
SpeedLabel.Position = UDim2.new(0, 12, 0, 180)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Punch Delay: 0.10s (Fast)"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame

local speedContainer = Instance.new("Frame")
speedContainer.Size = UDim2.new(1, -24, 0, 28)
speedContainer.Position = UDim2.new(0, 12, 0, 200)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = MainFrame

local speeds = {
    { label = "0.05s", delay = 0.05 },
    { label = "0.10s", delay = 0.10 },
    { label = "0.25s", delay = 0.25 },
    { label = "0.50s", delay = 0.50 },
}

for i, opt in ipairs(speeds) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.23, -2, 1, 0)
    btn.Position = UDim2.new((i - 1) * 0.25, 0, 0, 0)
    btn.BackgroundColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(40, 40, 55)
    btn.Text = opt.label
    btn.TextColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(25, 25, 32) or Color3.fromRGB(200, 200, 200)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = speedContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        destroyDelay = opt.delay
        SpeedLabel.Text = "Punch Delay: " .. string.format("%.2fs", destroyDelay)
        for _, child in ipairs(speedContainer:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
                child.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        btn.TextColor3 = Color3.fromRGB(25, 25, 32)
    end)
end

-- 7. UNLOAD SCRIPT BUTTON
local DestroyBtn = Instance.new("TextButton")
DestroyBtn.Size = UDim2.new(1, -24, 0, 28)
DestroyBtn.Position = UDim2.new(0, 12, 0, 268)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
DestroyBtn.Text = "Unload Hub Script"
DestroyBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
DestroyBtn.TextSize = 12
DestroyBtn.Font = Enum.Font.SourceSans
DestroyBtn.Parent = MainFrame

local destroyCorner = Instance.new("UICorner")
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = DestroyBtn

DestroyBtn.MouseButton1Click:Connect(function()
    autoDestroying = false
    autoJumping = false
    autoMoving = false
    ScreenGui:Destroy()
end)

print("[Banana Monkey Hub] Loaded successfully!")
