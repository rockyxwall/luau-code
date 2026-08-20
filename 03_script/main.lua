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
local ReplicatedStorage = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local CoreGui = game:GetService(_d({27,71,74,61,31,77,65},40))
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({40,68,57,81,61,74,31,77,65},40))
if parentGui:FindFirstChild(_d({26,57,70,57,70,57,37,71,70,67,61,81,32,77,58,31,77,65},40)) then
parentGui.BananaMonkeyHubGui:Destroy()
end
local ScreenGui = Instance.new(_d({43,59,74,61,61,70,31,77,65},40))
ScreenGui.Name = _d({26,57,70,57,70,57,37,71,70,67,61,81,32,77,58,31,77,65},40)
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui
local autoDestroying = false
local autoJumping = false
local autoMoving = false
local destroyDelay = 0.1
local punchPower = 2
local radiusSize = 3.5
local ToggleBtn = Instance.new(_d({44,61,80,76,26,77,76,76,71,70},40))
ToggleBtn.Name = _d({30,68,71,57,76,65,70,63,44,71,63,63,68,61},40)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleBtn.Text = _d({200,119,101,100},40)
ToggleBtn.TextSize = 28
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
local toggleCorner = Instance.new(_d({45,33,27,71,74,70,61,74},40))
toggleCorner.CornerRadius = UDim.new(0.5, 0)
toggleCorner.Parent = ToggleBtn
local toggleStroke = Instance.new(_d({45,33,43,76,74,71,67,61},40))
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 2
toggleStroke.Parent = ToggleBtn
local MainFrame = Instance.new(_d({30,74,57,69,61},40))
MainFrame.Name = _d({37,57,65,70,30,74,57,69,61},40)
MainFrame.Size = UDim2.new(0, 280, 0, 310)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new(_d({45,33,27,71,74,70,61,74},40))
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame
local mainStroke = Instance.new(_d({45,33,43,76,74,71,67,61},40))
mainStroke.Color = Color3.fromRGB(255, 165, 0)
mainStroke.Thickness = 1.5
mainStroke.Parent = MainFrame
local Header = Instance.new(_d({44,61,80,76,36,57,58,61,68},40))
Header.Size = UDim2.new(1, -40, 0, 36)
Header.Position = UDim2.new(0, 12, 0, 4)
Header.BackgroundTransparency = 1
Header.Text = _d({26,57,70,57,70,57,248,37,71,70,67,61,81,248,32,77,58,248,200,119,101,100},40)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 18
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame
local Subtitle = Instance.new(_d({44,61,80,76,36,57,58,61,68},40))
Subtitle.Size = UDim2.new(1, -40, 0, 16)
Subtitle.Position = UDim2.new(0, 12, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = _d({25,77,76,71,5,28,61,75,76,74,71,81,4,248,34,77,69,72,248,254,248,47,57,68,67,248,25,74,71,77,70,60},40)
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.SourceSans
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame
local CloseBtn = Instance.new(_d({44,61,80,76,26,77,76,76,71,70},40))
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame
local closeCorner = Instance.new(_d({45,33,27,71,74,70,61,74},40))
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = false
end)
ToggleBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = not MainFrame.Visible
end)
local Divider = Instance.new(_d({30,74,57,69,61},40))
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 52)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame
local AutoBtn = Instance.new(_d({44,61,80,76,26,77,76,76,71,70},40))
AutoBtn.Size = UDim2.new(1, -24, 0, 38)
AutoBtn.Position = UDim2.new(0, 12, 0, 60)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
AutoBtn.Text = _d({25,77,76,71,5,28,61,75,76,74,71,81,248,31,74,71,77,70,60,18,248,39,30,30},40)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.TextSize = 14
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.Parent = MainFrame
local autoCorner = Instance.new(_d({45,33,27,71,74,70,61,74},40))
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = AutoBtn
local autoStroke = Instance.new(_d({45,33,43,76,74,71,67,61},40))
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
AutoBtn.Text = _d({25,77,76,71,5,28,61,75,76,74,71,81,248,31,74,71,77,70,60,18,248,39,38,248,186,114,121},40)
AutoBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 35)
autoStroke.Color = Color3.fromRGB(90, 255, 140)
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if root then
local punchEvent = ReplicatedStorage:FindFirstChild(_d({28,61,75,76,74,77,59,76,65,71,70,55,40,77,70,59,64},40), true)
if punchEvent and punchEvent:IsA(_d({42,61,69,71,76,61,29,78,61,70,76},40)) then
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
AutoBtn.Text = _d({25,77,76,71,5,28,61,75,76,74,71,81,248,31,74,71,77,70,60,18,248,39,30,30},40)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
autoStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local JumpBtn = Instance.new(_d({44,61,80,76,26,77,76,76,71,70},40))
JumpBtn.Size = UDim2.new(1, -24, 0, 32)
JumpBtn.Position = UDim2.new(0, 12, 0, 104)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
JumpBtn.Text = _d({25,77,76,71,248,34,77,69,72,18,248,39,30,30},40)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.TextSize = 13
JumpBtn.Font = Enum.Font.SourceSansBold
JumpBtn.Parent = MainFrame
local jumpCorner = Instance.new(_d({45,33,27,71,74,70,61,74},40))
jumpCorner.CornerRadius = UDim.new(0, 8)
jumpCorner.Parent = JumpBtn
local jumpStroke = Instance.new(_d({45,33,43,76,74,71,67,61},40))
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
jumpStroke.Thickness = 1
jumpStroke.Parent = JumpBtn
JumpBtn.MouseButton1Click:Connect(function()
autoJumping = not autoJumping
if autoJumping then
JumpBtn.Text = _d({25,77,76,71,248,34,77,69,72,18,248,39,38,248,200,119,126,112},40)
JumpBtn.TextColor3 = Color3.fromRGB(255, 200, 90)
JumpBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 20)
jumpStroke.Color = Color3.fromRGB(255, 200, 90)
task.spawn(function()
while autoJumping do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({32,77,69,57,70,71,65,60},40))
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
JumpBtn.Text = _d({25,77,76,71,248,34,77,69,72,18,248,39,30,30},40)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local MoveBtn = Instance.new(_d({44,61,80,76,26,77,76,76,71,70},40))
MoveBtn.Size = UDim2.new(1, -24, 0, 32)
MoveBtn.Position = UDim2.new(0, 12, 0, 142)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
MoveBtn.Text = _d({25,77,76,71,5,37,71,78,61,248,0,47,57,68,67,248,25,74,71,77,70,60,1,18,248,39,30,30},40)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.TextSize = 13
MoveBtn.Font = Enum.Font.SourceSansBold
MoveBtn.Parent = MainFrame
local moveCorner = Instance.new(_d({45,33,27,71,74,70,61,74},40))
moveCorner.CornerRadius = UDim.new(0, 8)
moveCorner.Parent = MoveBtn
local moveStroke = Instance.new(_d({45,33,43,76,74,71,67,61},40))
moveStroke.Color = Color3.fromRGB(60, 60, 80)
moveStroke.Thickness = 1
moveStroke.Parent = MoveBtn
MoveBtn.MouseButton1Click:Connect(function()
autoMoving = not autoMoving
if autoMoving then
MoveBtn.Text = _d({25,77,76,71,5,37,71,78,61,248,0,47,57,68,67,248,25,74,71,77,70,60,1,18,248,39,38,248,200,119,114,142},40)
MoveBtn.TextColor3 = Color3.fromRGB(90, 200, 255)
MoveBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 60)
moveStroke.Color = Color3.fromRGB(90, 200, 255)
task.spawn(function()
local angle = 0
while autoMoving do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({32,77,69,57,70,71,65,60},40))
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
MoveBtn.Text = _d({25,77,76,71,5,37,71,78,61,248,0,47,57,68,67,248,25,74,71,77,70,60,1,18,248,39,30,30},40)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
moveStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local SpeedLabel = Instance.new(_d({44,61,80,76,36,57,58,61,68},40))
SpeedLabel.Size = UDim2.new(1, -24, 0, 18)
SpeedLabel.Position = UDim2.new(0, 12, 0, 180)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = _d({40,77,70,59,64,248,28,61,68,57,81,18,248,8,6,9,8,75,248,0,30,57,75,76,1},40)
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame
local speedContainer = Instance.new(_d({30,74,57,69,61},40))
speedContainer.Size = UDim2.new(1, -24, 0, 28)
speedContainer.Position = UDim2.new(0, 12, 0, 200)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = MainFrame
local speeds = {
{ label = _d({8,6,8,13,75},40), delay = 0.05 },
{ label = _d({8,6,9,8,75},40), delay = 0.10 },
{ label = _d({8,6,10,13,75},40), delay = 0.25 },
{ label = _d({8,6,13,8,75},40), delay = 0.50 }
}
for i, opt in ipairs(speeds) do
local btn = Instance.new(_d({44,61,80,76,26,77,76,76,71,70},40))
btn.Size = UDim2.new(0.23, -2, 1, 0)
btn.Position = UDim2.new((i - 1) * 0.25, 0, 0, 0)
btn.BackgroundColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(40, 40, 55)
btn.Text = opt.label
btn.TextColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(25, 25, 32) or Color3.fromRGB(200, 200, 200)
btn.TextSize = 12
btn.Font = Enum.Font.SourceSansBold
btn.Parent = speedContainer
local btnCorner = Instance.new(_d({45,33,27,71,74,70,61,74},40))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
destroyDelay = opt.delay
SpeedLabel.Text = _d({40,77,70,59,64,248,28,61,68,57,81,18,248},40) .. string.format(_d({253,6,10,62,75},40), destroyDelay)
for _, child in ipairs(speedContainer:GetChildren()) do
if child:IsA(_d({44,61,80,76,26,77,76,76,71,70},40)) then
child.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
child.TextColor3 = Color3.fromRGB(200, 200, 200)
end
end
btn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
btn.TextColor3 = Color3.fromRGB(25, 25, 32)
end)
end
local DestroyBtn = Instance.new(_d({44,61,80,76,26,77,76,76,71,70},40))
DestroyBtn.Size = UDim2.new(1, -24, 0, 28)
DestroyBtn.Position = UDim2.new(0, 12, 0, 268)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
DestroyBtn.Text = _d({45,70,68,71,57,60,248,32,77,58,248,43,59,74,65,72,76},40)
DestroyBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
DestroyBtn.TextSize = 12
DestroyBtn.Font = Enum.Font.SourceSans
DestroyBtn.Parent = MainFrame
local destroyCorner = Instance.new(_d({45,33,27,71,74,70,61,74},40))
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = DestroyBtn
DestroyBtn.MouseButton1Click:Connect(function()
autoDestroying = false
autoJumping = false
autoMoving = false
ScreenGui:Destroy()
end)
print(_d({51,26,57,70,57,70,57,248,37,71,70,67,61,81,248,32,77,58,53,248,36,71,57,60,61,60,248,75,77,59,59,61,75,75,62,77,68,68,81,249},40))
end)()