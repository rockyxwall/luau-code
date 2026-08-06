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
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local CoreGui = game:GetService(_d({12,56,59,46,16,62,50},55))
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({25,53,42,66,46,59,16,62,50},55))
if parentGui:FindFirstChild(_d({11,42,55,42,55,42,22,56,55,52,46,66,17,62,43,16,62,50},55)) then
parentGui.BananaMonkeyHubGui:Destroy()
end
local ScreenGui = Instance.new(_d({28,44,59,46,46,55,16,62,50},55))
ScreenGui.Name = _d({11,42,55,42,55,42,22,56,55,52,46,66,17,62,43,16,62,50},55)
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui
local autoDestroying = false
local autoJumping = false
local autoMoving = false
local destroyDelay = 0.1
local punchPower = 2
local radiusSize = 3.5
local ToggleBtn = Instance.new(_d({29,46,65,61,11,62,61,61,56,55},55))
ToggleBtn.Name = _d({15,53,56,42,61,50,55,48,29,56,48,48,53,46},55)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleBtn.Text = _d({185,104,86,85},55)
ToggleBtn.TextSize = 28
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
local toggleCorner = Instance.new(_d({30,18,12,56,59,55,46,59},55))
toggleCorner.CornerRadius = UDim.new(0.5, 0)
toggleCorner.Parent = ToggleBtn
local toggleStroke = Instance.new(_d({30,18,28,61,59,56,52,46},55))
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 2
toggleStroke.Parent = ToggleBtn
local MainFrame = Instance.new(_d({15,59,42,54,46},55))
MainFrame.Name = _d({22,42,50,55,15,59,42,54,46},55)
MainFrame.Size = UDim2.new(0, 280, 0, 310)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new(_d({30,18,12,56,59,55,46,59},55))
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame
local mainStroke = Instance.new(_d({30,18,28,61,59,56,52,46},55))
mainStroke.Color = Color3.fromRGB(255, 165, 0)
mainStroke.Thickness = 1.5
mainStroke.Parent = MainFrame
local Header = Instance.new(_d({29,46,65,61,21,42,43,46,53},55))
Header.Size = UDim2.new(1, -40, 0, 36)
Header.Position = UDim2.new(0, 12, 0, 4)
Header.BackgroundTransparency = 1
Header.Text = _d({11,42,55,42,55,42,233,22,56,55,52,46,66,233,17,62,43,233,185,104,86,85},55)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 18
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame
local Subtitle = Instance.new(_d({29,46,65,61,21,42,43,46,53},55))
Subtitle.Size = UDim2.new(1, -40, 0, 16)
Subtitle.Position = UDim2.new(0, 12, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = _d({10,62,61,56,246,13,46,60,61,59,56,66,245,233,19,62,54,57,233,239,233,32,42,53,52,233,10,59,56,62,55,45},55)
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.SourceSans
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame
local CloseBtn = Instance.new(_d({29,46,65,61,11,62,61,61,56,55},55))
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame
local closeCorner = Instance.new(_d({30,18,12,56,59,55,46,59},55))
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = false
end)
ToggleBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = not MainFrame.Visible
end)
local Divider = Instance.new(_d({15,59,42,54,46},55))
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 52)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame
local AutoBtn = Instance.new(_d({29,46,65,61,11,62,61,61,56,55},55))
AutoBtn.Size = UDim2.new(1, -24, 0, 38)
AutoBtn.Position = UDim2.new(0, 12, 0, 60)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
AutoBtn.Text = _d({10,62,61,56,246,13,46,60,61,59,56,66,233,16,59,56,62,55,45,3,233,24,15,15},55)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.TextSize = 14
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.Parent = MainFrame
local autoCorner = Instance.new(_d({30,18,12,56,59,55,46,59},55))
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = AutoBtn
local autoStroke = Instance.new(_d({30,18,28,61,59,56,52,46},55))
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
AutoBtn.Text = _d({10,62,61,56,246,13,46,60,61,59,56,66,233,16,59,56,62,55,45,3,233,24,23,233,171,99,106},55)
AutoBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 35)
autoStroke.Color = Color3.fromRGB(90, 255, 140)
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if root then
local punchEvent = ReplicatedStorage:FindFirstChild(_d({13,46,60,61,59,62,44,61,50,56,55,40,25,62,55,44,49},55), true)
if punchEvent and punchEvent:IsA(_d({27,46,54,56,61,46,14,63,46,55,61},55)) then
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
AutoBtn.Text = _d({10,62,61,56,246,13,46,60,61,59,56,66,233,16,59,56,62,55,45,3,233,24,15,15},55)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
autoStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local JumpBtn = Instance.new(_d({29,46,65,61,11,62,61,61,56,55},55))
JumpBtn.Size = UDim2.new(1, -24, 0, 32)
JumpBtn.Position = UDim2.new(0, 12, 0, 104)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
JumpBtn.Text = _d({10,62,61,56,233,19,62,54,57,3,233,24,15,15},55)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.TextSize = 13
JumpBtn.Font = Enum.Font.SourceSansBold
JumpBtn.Parent = MainFrame
local jumpCorner = Instance.new(_d({30,18,12,56,59,55,46,59},55))
jumpCorner.CornerRadius = UDim.new(0, 8)
jumpCorner.Parent = JumpBtn
local jumpStroke = Instance.new(_d({30,18,28,61,59,56,52,46},55))
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
jumpStroke.Thickness = 1
jumpStroke.Parent = JumpBtn
JumpBtn.MouseButton1Click:Connect(function()
autoJumping = not autoJumping
if autoJumping then
JumpBtn.Text = _d({10,62,61,56,233,19,62,54,57,3,233,24,23,233,185,104,111,97},55)
JumpBtn.TextColor3 = Color3.fromRGB(255, 200, 90)
JumpBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 20)
jumpStroke.Color = Color3.fromRGB(255, 200, 90)
task.spawn(function()
while autoJumping do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({17,62,54,42,55,56,50,45},55))
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
JumpBtn.Text = _d({10,62,61,56,233,19,62,54,57,3,233,24,15,15},55)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local MoveBtn = Instance.new(_d({29,46,65,61,11,62,61,61,56,55},55))
MoveBtn.Size = UDim2.new(1, -24, 0, 32)
MoveBtn.Position = UDim2.new(0, 12, 0, 142)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
MoveBtn.Text = _d({10,62,61,56,246,22,56,63,46,233,241,32,42,53,52,233,10,59,56,62,55,45,242,3,233,24,15,15},55)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.TextSize = 13
MoveBtn.Font = Enum.Font.SourceSansBold
MoveBtn.Parent = MainFrame
local moveCorner = Instance.new(_d({30,18,12,56,59,55,46,59},55))
moveCorner.CornerRadius = UDim.new(0, 8)
moveCorner.Parent = MoveBtn
local moveStroke = Instance.new(_d({30,18,28,61,59,56,52,46},55))
moveStroke.Color = Color3.fromRGB(60, 60, 80)
moveStroke.Thickness = 1
moveStroke.Parent = MoveBtn
MoveBtn.MouseButton1Click:Connect(function()
autoMoving = not autoMoving
if autoMoving then
MoveBtn.Text = _d({10,62,61,56,246,22,56,63,46,233,241,32,42,53,52,233,10,59,56,62,55,45,242,3,233,24,23,233,185,104,99,127},55)
MoveBtn.TextColor3 = Color3.fromRGB(90, 200, 255)
MoveBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 60)
moveStroke.Color = Color3.fromRGB(90, 200, 255)
task.spawn(function()
local angle = 0
while autoMoving do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({17,62,54,42,55,56,50,45},55))
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
MoveBtn.Text = _d({10,62,61,56,246,22,56,63,46,233,241,32,42,53,52,233,10,59,56,62,55,45,242,3,233,24,15,15},55)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
moveStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local SpeedLabel = Instance.new(_d({29,46,65,61,21,42,43,46,53},55))
SpeedLabel.Size = UDim2.new(1, -24, 0, 18)
SpeedLabel.Position = UDim2.new(0, 12, 0, 180)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = _d({25,62,55,44,49,233,13,46,53,42,66,3,233,249,247,250,249,60,233,241,15,42,60,61,242},55)
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame
local speedContainer = Instance.new(_d({15,59,42,54,46},55))
speedContainer.Size = UDim2.new(1, -24, 0, 28)
speedContainer.Position = UDim2.new(0, 12, 0, 200)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = MainFrame
local speeds = {
{ label = _d({249,247,249,254,60},55), delay = 0.05 },
{ label = _d({249,247,250,249,60},55), delay = 0.10 },
{ label = _d({249,247,251,254,60},55), delay = 0.25 },
{ label = _d({249,247,254,249,60},55), delay = 0.50 }
}
for i, opt in ipairs(speeds) do
local btn = Instance.new(_d({29,46,65,61,11,62,61,61,56,55},55))
btn.Size = UDim2.new(0.23, -2, 1, 0)
btn.Position = UDim2.new((i - 1) * 0.25, 0, 0, 0)
btn.BackgroundColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(40, 40, 55)
btn.Text = opt.label
btn.TextColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(25, 25, 32) or Color3.fromRGB(200, 200, 200)
btn.TextSize = 12
btn.Font = Enum.Font.SourceSansBold
btn.Parent = speedContainer
local btnCorner = Instance.new(_d({30,18,12,56,59,55,46,59},55))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
destroyDelay = opt.delay
SpeedLabel.Text = _d({25,62,55,44,49,233,13,46,53,42,66,3,233},55) .. string.format(_d({238,247,251,47,60},55), destroyDelay)
for _, child in ipairs(speedContainer:GetChildren()) do
if child:IsA(_d({29,46,65,61,11,62,61,61,56,55},55)) then
child.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
child.TextColor3 = Color3.fromRGB(200, 200, 200)
end
end
btn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
btn.TextColor3 = Color3.fromRGB(25, 25, 32)
end)
end
local DestroyBtn = Instance.new(_d({29,46,65,61,11,62,61,61,56,55},55))
DestroyBtn.Size = UDim2.new(1, -24, 0, 28)
DestroyBtn.Position = UDim2.new(0, 12, 0, 268)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
DestroyBtn.Text = _d({30,55,53,56,42,45,233,17,62,43,233,28,44,59,50,57,61},55)
DestroyBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
DestroyBtn.TextSize = 12
DestroyBtn.Font = Enum.Font.SourceSans
DestroyBtn.Parent = MainFrame
local destroyCorner = Instance.new(_d({30,18,12,56,59,55,46,59},55))
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = DestroyBtn
DestroyBtn.MouseButton1Click:Connect(function()
autoDestroying = false
autoJumping = false
autoMoving = false
ScreenGui:Destroy()
end)
print(_d({36,11,42,55,42,55,42,233,22,56,55,52,46,66,233,17,62,43,38,233,21,56,42,45,46,45,233,60,62,44,44,46,60,60,47,62,53,53,66,234},55))
end)()