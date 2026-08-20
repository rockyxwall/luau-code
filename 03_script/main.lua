(function()
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char((b[i] + k) % 256)
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local CoreGui = game:GetService(_d({32,76,79,66,36,82,70},35))
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35))
if parentGui:FindFirstChild(_d({31,62,75,62,75,62,42,76,75,72,66,86,37,82,63,36,82,70},35)) then
parentGui.BananaMonkeyHubGui:Destroy()
end
local ScreenGui = Instance.new(_d({48,64,79,66,66,75,36,82,70},35))
ScreenGui.Name = _d({31,62,75,62,75,62,42,76,75,72,66,86,37,82,63,36,82,70},35)
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui
local autoDestroying = false
local autoJumping = false
local autoMoving = false
local destroyDelay = 0.1
local punchPower = 2
local radiusSize = 3.5
local ToggleBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
ToggleBtn.Name = _d({35,73,76,62,81,70,75,68,49,76,68,68,73,66},35)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleBtn.Text = _d({205,124,106,105},35)
ToggleBtn.TextSize = 28
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
local toggleCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
toggleCorner.CornerRadius = UDim.new(0.5, 0)
toggleCorner.Parent = ToggleBtn
local toggleStroke = Instance.new(_d({50,38,48,81,79,76,72,66},35))
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 2
toggleStroke.Parent = ToggleBtn
local MainFrame = Instance.new(_d({35,79,62,74,66},35))
MainFrame.Name = _d({42,62,70,75,35,79,62,74,66},35)
MainFrame.Size = UDim2.new(0, 280, 0, 310)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame
local mainStroke = Instance.new(_d({50,38,48,81,79,76,72,66},35))
mainStroke.Color = Color3.fromRGB(255, 165, 0)
mainStroke.Thickness = 1.5
mainStroke.Parent = MainFrame
local Header = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
Header.Size = UDim2.new(1, -40, 0, 36)
Header.Position = UDim2.new(0, 12, 0, 4)
Header.BackgroundTransparency = 1
Header.Text = _d({31,62,75,62,75,62,253,42,76,75,72,66,86,253,37,82,63,253,205,124,106,105},35)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 18
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame
local Subtitle = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
Subtitle.Size = UDim2.new(1, -40, 0, 16)
Subtitle.Position = UDim2.new(0, 12, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = _d({30,82,81,76,10,33,66,80,81,79,76,86,9,253,39,82,74,77,253,3,253,52,62,73,72,253,30,79,76,82,75,65},35)
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.SourceSans
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame
local CloseBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame
local closeCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = false
end)
ToggleBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = not MainFrame.Visible
end)
local Divider = Instance.new(_d({35,79,62,74,66},35))
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 52)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame
local AutoBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
AutoBtn.Size = UDim2.new(1, -24, 0, 38)
AutoBtn.Position = UDim2.new(0, 12, 0, 60)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
AutoBtn.Text = _d({30,82,81,76,10,33,66,80,81,79,76,86,253,36,79,76,82,75,65,23,253,44,35,35},35)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.TextSize = 14
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.Parent = MainFrame
local autoCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = AutoBtn
local autoStroke = Instance.new(_d({50,38,48,81,79,76,72,66},35))
autoStroke.Color = Color3.fromRGB(60, 60, 80)
autoStroke.Thickness = 1
autoStroke.Parent = AutoBtn
local function getOffsets(r)
return {
Vector3.new(0, 0, 0),
Vector3.new(0, -2, 0),
Vector3.new(r, 0, 0),
Vector3.new(-r, 0, 0),
Vector3.new(0, 0, r),
Vector3.new(0, 0, -r),
Vector3.new(r*0.7, 0, r*0.7),
Vector3.new(-r*0.7, 0, r*0.7),
Vector3.new(r*0.7, 0, -r*0.7),
Vector3.new(-r*0.7, 0, -r*0.7)
}
end
AutoBtn.MouseButton1Click:Connect(function()
autoDestroying = not autoDestroying
if autoDestroying then
AutoBtn.Text = _d({30,82,81,76,10,33,66,80,81,79,76,86,253,36,79,76,82,75,65,23,253,44,43,253,191,119,126},35)
AutoBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 35)
autoStroke.Color = Color3.fromRGB(90, 255, 140)
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if root then
local punchEvent = ReplicatedStorage:FindFirstChild(_d({33,66,80,81,79,82,64,81,70,76,75,60,45,82,75,64,69},35), true)
if punchEvent and punchEvent:IsA(_d({47,66,74,76,81,66,34,83,66,75,81},35)) then
local basePos = root.Position
local offsets = getOffsets(radiusSize)
for _, offset in ipairs(offsets) do
if not autoDestroying then break end
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
AutoBtn.Text = _d({30,82,81,76,10,33,66,80,81,79,76,86,253,36,79,76,82,75,65,23,253,44,35,35},35)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
autoStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local JumpBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
JumpBtn.Size = UDim2.new(1, -24, 0, 32)
JumpBtn.Position = UDim2.new(0, 12, 0, 104)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
JumpBtn.Text = _d({30,82,81,76,253,39,82,74,77,23,253,44,35,35},35)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.TextSize = 13
JumpBtn.Font = Enum.Font.SourceSansBold
JumpBtn.Parent = MainFrame
local jumpCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
jumpCorner.CornerRadius = UDim.new(0, 8)
jumpCorner.Parent = JumpBtn
local jumpStroke = Instance.new(_d({50,38,48,81,79,76,72,66},35))
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
jumpStroke.Thickness = 1
jumpStroke.Parent = JumpBtn
JumpBtn.MouseButton1Click:Connect(function()
autoJumping = not autoJumping
if autoJumping then
JumpBtn.Text = _d({30,82,81,76,253,39,82,74,77,23,253,44,43,253,205,124,131,117},35)
JumpBtn.TextColor3 = Color3.fromRGB(255, 200, 90)
JumpBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 20)
jumpStroke.Color = Color3.fromRGB(255, 200, 90)
task.spawn(function()
while autoJumping do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({37,82,74,62,75,76,70,65},35))
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
JumpBtn.Text = _d({30,82,81,76,253,39,82,74,77,23,253,44,35,35},35)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local MoveBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
MoveBtn.Size = UDim2.new(1, -24, 0, 32)
MoveBtn.Position = UDim2.new(0, 12, 0, 142)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
MoveBtn.Text = _d({30,82,81,76,10,42,76,83,66,253,5,52,62,73,72,253,30,79,76,82,75,65,6,23,253,44,35,35},35)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.TextSize = 13
MoveBtn.Font = Enum.Font.SourceSansBold
MoveBtn.Parent = MainFrame
local moveCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
moveCorner.CornerRadius = UDim.new(0, 8)
moveCorner.Parent = MoveBtn
local moveStroke = Instance.new(_d({50,38,48,81,79,76,72,66},35))
moveStroke.Color = Color3.fromRGB(60, 60, 80)
moveStroke.Thickness = 1
moveStroke.Parent = MoveBtn
MoveBtn.MouseButton1Click:Connect(function()
autoMoving = not autoMoving
if autoMoving then
MoveBtn.Text = _d({30,82,81,76,10,42,76,83,66,253,5,52,62,73,72,253,30,79,76,82,75,65,6,23,253,44,43,253,205,124,119,147},35)
MoveBtn.TextColor3 = Color3.fromRGB(90, 200, 255)
MoveBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 60)
moveStroke.Color = Color3.fromRGB(90, 200, 255)
task.spawn(function()
local angle = 0
while autoMoving do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({37,82,74,62,75,76,70,65},35))
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
MoveBtn.Text = _d({30,82,81,76,10,42,76,83,66,253,5,52,62,73,72,253,30,79,76,82,75,65,6,23,253,44,35,35},35)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
moveStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local SpeedLabel = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
SpeedLabel.Size = UDim2.new(1, -24, 0, 18)
SpeedLabel.Position = UDim2.new(0, 12, 0, 180)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = _d({45,82,75,64,69,253,33,66,73,62,86,23,253,13,11,14,13,80,253,5,35,62,80,81,6},35)
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame
local speedContainer = Instance.new(_d({35,79,62,74,66},35))
speedContainer.Size = UDim2.new(1, -24, 0, 28)
speedContainer.Position = UDim2.new(0, 12, 0, 200)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = MainFrame
local speeds = {
{ label = _d({13,11,13,18,80},35), delay = 0.05 },
{ label = _d({13,11,14,13,80},35), delay = 0.10 },
{ label = _d({13,11,15,18,80},35), delay = 0.25 },
{ label = _d({13,11,18,13,80},35), delay = 0.50 }
}
for i, opt in ipairs(speeds) do
local btn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
btn.Size = UDim2.new(0.23, -2, 1, 0)
btn.Position = UDim2.new((i - 1) * 0.25, 0, 0, 0)
btn.BackgroundColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(40, 40, 55)
btn.Text = opt.label
btn.TextColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(25, 25, 32) or Color3.fromRGB(200, 200, 200)
btn.TextSize = 12
btn.Font = Enum.Font.SourceSansBold
btn.Parent = speedContainer
local btnCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
destroyDelay = opt.delay
SpeedLabel.Text = _d({45,82,75,64,69,253,33,66,73,62,86,23,253},35) .. string.format(_d({2,11,15,67,80},35), destroyDelay)
for _, child in ipairs(speedContainer:GetChildren()) do
if child:IsA(_d({49,66,85,81,31,82,81,81,76,75},35)) then
child.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
child.TextColor3 = Color3.fromRGB(200, 200, 200)
end
end
btn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
btn.TextColor3 = Color3.fromRGB(25, 25, 32)
end)
end
local DestroyBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
DestroyBtn.Size = UDim2.new(1, -24, 0, 28)
DestroyBtn.Position = UDim2.new(0, 12, 0, 268)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
DestroyBtn.Text = _d({50,75,73,76,62,65,253,37,82,63,253,48,64,79,70,77,81},35)
DestroyBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
DestroyBtn.TextSize = 12
DestroyBtn.Font = Enum.Font.SourceSans
DestroyBtn.Parent = MainFrame
local destroyCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = DestroyBtn
DestroyBtn.MouseButton1Click:Connect(function()
autoDestroying = false
autoJumping = false
autoMoving = false
ScreenGui:Destroy()
end)
print(_d({56,31,62,75,62,75,62,253,42,76,75,72,66,86,253,37,82,63,58,253,41,76,62,65,66,65,253,80,82,64,64,66,80,80,67,82,73,73,86,254},35))
end)()