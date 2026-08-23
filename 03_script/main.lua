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
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local CoreGui = game:GetService(_d({30,74,77,64,34,80,68},37))
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({43,71,60,84,64,77,34,80,68},37))
if parentGui:FindFirstChild(_d({29,60,73,60,73,60,40,74,73,70,64,84,35,80,61,34,80,68},37)) then
parentGui.BananaMonkeyHubGui:Destroy()
end
local ScreenGui = Instance.new(_d({46,62,77,64,64,73,34,80,68},37))
ScreenGui.Name = _d({29,60,73,60,73,60,40,74,73,70,64,84,35,80,61,34,80,68},37)
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui
local autoDestroying = false
local autoJumping = false
local autoMoving = false
local destroyDelay = 0.1
local punchPower = 2
local radiusSize = 3.5
local ToggleBtn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
ToggleBtn.Name = _d({33,71,74,60,79,68,73,66,47,74,66,66,71,64},37)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleBtn.Text = _d({203,122,104,103},37)
ToggleBtn.TextSize = 28
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
local toggleCorner = Instance.new(_d({48,36,30,74,77,73,64,77},37))
toggleCorner.CornerRadius = UDim.new(0.5, 0)
toggleCorner.Parent = ToggleBtn
local toggleStroke = Instance.new(_d({48,36,46,79,77,74,70,64},37))
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 2
toggleStroke.Parent = ToggleBtn
local MainFrame = Instance.new(_d({33,77,60,72,64},37))
MainFrame.Name = _d({40,60,68,73,33,77,60,72,64},37)
MainFrame.Size = UDim2.new(0, 280, 0, 310)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new(_d({48,36,30,74,77,73,64,77},37))
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame
local mainStroke = Instance.new(_d({48,36,46,79,77,74,70,64},37))
mainStroke.Color = Color3.fromRGB(255, 165, 0)
mainStroke.Thickness = 1.5
mainStroke.Parent = MainFrame
local Header = Instance.new(_d({47,64,83,79,39,60,61,64,71},37))
Header.Size = UDim2.new(1, -40, 0, 36)
Header.Position = UDim2.new(0, 12, 0, 4)
Header.BackgroundTransparency = 1
Header.Text = _d({29,60,73,60,73,60,251,40,74,73,70,64,84,251,35,80,61,251,203,122,104,103},37)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 18
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame
local Subtitle = Instance.new(_d({47,64,83,79,39,60,61,64,71},37))
Subtitle.Size = UDim2.new(1, -40, 0, 16)
Subtitle.Position = UDim2.new(0, 12, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = _d({28,80,79,74,8,31,64,78,79,77,74,84,7,251,37,80,72,75,251,1,251,50,60,71,70,251,28,77,74,80,73,63},37)
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.SourceSans
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame
local CloseBtn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame
local closeCorner = Instance.new(_d({48,36,30,74,77,73,64,77},37))
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = false
end)
ToggleBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = not MainFrame.Visible
end)
local Divider = Instance.new(_d({33,77,60,72,64},37))
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 52)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame
local AutoBtn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
AutoBtn.Size = UDim2.new(1, -24, 0, 38)
AutoBtn.Position = UDim2.new(0, 12, 0, 60)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
AutoBtn.Text = _d({28,80,79,74,8,31,64,78,79,77,74,84,251,34,77,74,80,73,63,21,251,42,33,33},37)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.TextSize = 14
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.Parent = MainFrame
local autoCorner = Instance.new(_d({48,36,30,74,77,73,64,77},37))
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = AutoBtn
local autoStroke = Instance.new(_d({48,36,46,79,77,74,70,64},37))
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
AutoBtn.Text = _d({28,80,79,74,8,31,64,78,79,77,74,84,251,34,77,74,80,73,63,21,251,42,41,251,189,117,124},37)
AutoBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 35)
autoStroke.Color = Color3.fromRGB(90, 255, 140)
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if root then
local punchEvent = ReplicatedStorage:FindFirstChild(_d({31,64,78,79,77,80,62,79,68,74,73,58,43,80,73,62,67},37), true)
if punchEvent and punchEvent:IsA(_d({45,64,72,74,79,64,32,81,64,73,79},37)) then
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
AutoBtn.Text = _d({28,80,79,74,8,31,64,78,79,77,74,84,251,34,77,74,80,73,63,21,251,42,33,33},37)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
autoStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local JumpBtn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
JumpBtn.Size = UDim2.new(1, -24, 0, 32)
JumpBtn.Position = UDim2.new(0, 12, 0, 104)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
JumpBtn.Text = _d({28,80,79,74,251,37,80,72,75,21,251,42,33,33},37)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.TextSize = 13
JumpBtn.Font = Enum.Font.SourceSansBold
JumpBtn.Parent = MainFrame
local jumpCorner = Instance.new(_d({48,36,30,74,77,73,64,77},37))
jumpCorner.CornerRadius = UDim.new(0, 8)
jumpCorner.Parent = JumpBtn
local jumpStroke = Instance.new(_d({48,36,46,79,77,74,70,64},37))
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
jumpStroke.Thickness = 1
jumpStroke.Parent = JumpBtn
JumpBtn.MouseButton1Click:Connect(function()
autoJumping = not autoJumping
if autoJumping then
JumpBtn.Text = _d({28,80,79,74,251,37,80,72,75,21,251,42,41,251,203,122,129,115},37)
JumpBtn.TextColor3 = Color3.fromRGB(255, 200, 90)
JumpBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 20)
jumpStroke.Color = Color3.fromRGB(255, 200, 90)
task.spawn(function()
while autoJumping do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({35,80,72,60,73,74,68,63},37))
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
JumpBtn.Text = _d({28,80,79,74,251,37,80,72,75,21,251,42,33,33},37)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local MoveBtn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
MoveBtn.Size = UDim2.new(1, -24, 0, 32)
MoveBtn.Position = UDim2.new(0, 12, 0, 142)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
MoveBtn.Text = _d({28,80,79,74,8,40,74,81,64,251,3,50,60,71,70,251,28,77,74,80,73,63,4,21,251,42,33,33},37)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.TextSize = 13
MoveBtn.Font = Enum.Font.SourceSansBold
MoveBtn.Parent = MainFrame
local moveCorner = Instance.new(_d({48,36,30,74,77,73,64,77},37))
moveCorner.CornerRadius = UDim.new(0, 8)
moveCorner.Parent = MoveBtn
local moveStroke = Instance.new(_d({48,36,46,79,77,74,70,64},37))
moveStroke.Color = Color3.fromRGB(60, 60, 80)
moveStroke.Thickness = 1
moveStroke.Parent = MoveBtn
MoveBtn.MouseButton1Click:Connect(function()
autoMoving = not autoMoving
if autoMoving then
MoveBtn.Text = _d({28,80,79,74,8,40,74,81,64,251,3,50,60,71,70,251,28,77,74,80,73,63,4,21,251,42,41,251,203,122,117,145},37)
MoveBtn.TextColor3 = Color3.fromRGB(90, 200, 255)
MoveBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 60)
moveStroke.Color = Color3.fromRGB(90, 200, 255)
task.spawn(function()
local angle = 0
while autoMoving do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({35,80,72,60,73,74,68,63},37))
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
MoveBtn.Text = _d({28,80,79,74,8,40,74,81,64,251,3,50,60,71,70,251,28,77,74,80,73,63,4,21,251,42,33,33},37)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
moveStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local SpeedLabel = Instance.new(_d({47,64,83,79,39,60,61,64,71},37))
SpeedLabel.Size = UDim2.new(1, -24, 0, 18)
SpeedLabel.Position = UDim2.new(0, 12, 0, 180)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = _d({43,80,73,62,67,251,31,64,71,60,84,21,251,11,9,12,11,78,251,3,33,60,78,79,4},37)
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame
local speedContainer = Instance.new(_d({33,77,60,72,64},37))
speedContainer.Size = UDim2.new(1, -24, 0, 28)
speedContainer.Position = UDim2.new(0, 12, 0, 200)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = MainFrame
local speeds = {
{ label = _d({11,9,11,16,78},37), delay = 0.05 },
{ label = _d({11,9,12,11,78},37), delay = 0.10 },
{ label = _d({11,9,13,16,78},37), delay = 0.25 },
{ label = _d({11,9,16,11,78},37), delay = 0.50 }
}
for i, opt in ipairs(speeds) do
local btn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
btn.Size = UDim2.new(0.23, -2, 1, 0)
btn.Position = UDim2.new((i - 1) * 0.25, 0, 0, 0)
btn.BackgroundColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(40, 40, 55)
btn.Text = opt.label
btn.TextColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(25, 25, 32) or Color3.fromRGB(200, 200, 200)
btn.TextSize = 12
btn.Font = Enum.Font.SourceSansBold
btn.Parent = speedContainer
local btnCorner = Instance.new(_d({48,36,30,74,77,73,64,77},37))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
destroyDelay = opt.delay
SpeedLabel.Text = _d({43,80,73,62,67,251,31,64,71,60,84,21,251},37) .. string.format(_d({0,9,13,65,78},37), destroyDelay)
for _, child in ipairs(speedContainer:GetChildren()) do
if child:IsA(_d({47,64,83,79,29,80,79,79,74,73},37)) then
child.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
child.TextColor3 = Color3.fromRGB(200, 200, 200)
end
end
btn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
btn.TextColor3 = Color3.fromRGB(25, 25, 32)
end)
end
local DestroyBtn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
DestroyBtn.Size = UDim2.new(1, -24, 0, 28)
DestroyBtn.Position = UDim2.new(0, 12, 0, 268)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
DestroyBtn.Text = _d({48,73,71,74,60,63,251,35,80,61,251,46,62,77,68,75,79},37)
DestroyBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
DestroyBtn.TextSize = 12
DestroyBtn.Font = Enum.Font.SourceSans
DestroyBtn.Parent = MainFrame
local destroyCorner = Instance.new(_d({48,36,30,74,77,73,64,77},37))
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = DestroyBtn
DestroyBtn.MouseButton1Click:Connect(function()
autoDestroying = false
autoJumping = false
autoMoving = false
ScreenGui:Destroy()
end)
print(_d({54,29,60,73,60,73,60,251,40,74,73,70,64,84,251,35,80,61,56,251,39,74,60,63,64,63,251,78,80,62,62,64,78,78,65,80,71,71,84,252},37))
end)()