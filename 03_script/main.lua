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
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local CoreGui = game:GetService(_d({51,95,98,85,55,101,89},16))
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({64,92,81,105,85,98,55,101,89},16))
if parentGui:FindFirstChild(_d({50,81,94,81,94,81,61,95,94,91,85,105,56,101,82,55,101,89},16)) then
parentGui.BananaMonkeyHubGui:Destroy()
end
local ScreenGui = Instance.new(_d({67,83,98,85,85,94,55,101,89},16))
ScreenGui.Name = _d({50,81,94,81,94,81,61,95,94,91,85,105,56,101,82,55,101,89},16)
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui
local autoDestroying = false
local autoJumping = false
local autoMoving = false
local destroyDelay = 0.1
local punchPower = 2
local radiusSize = 3.5
local ToggleBtn = Instance.new(_d({68,85,104,100,50,101,100,100,95,94},16))
ToggleBtn.Name = _d({54,92,95,81,100,89,94,87,68,95,87,87,92,85},16)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleBtn.Text = _d({224,143,125,124},16)
ToggleBtn.TextSize = 28
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
local toggleCorner = Instance.new(_d({69,57,51,95,98,94,85,98},16))
toggleCorner.CornerRadius = UDim.new(0.5, 0)
toggleCorner.Parent = ToggleBtn
local toggleStroke = Instance.new(_d({69,57,67,100,98,95,91,85},16))
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 2
toggleStroke.Parent = ToggleBtn
local MainFrame = Instance.new(_d({54,98,81,93,85},16))
MainFrame.Name = _d({61,81,89,94,54,98,81,93,85},16)
MainFrame.Size = UDim2.new(0, 280, 0, 310)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new(_d({69,57,51,95,98,94,85,98},16))
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame
local mainStroke = Instance.new(_d({69,57,67,100,98,95,91,85},16))
mainStroke.Color = Color3.fromRGB(255, 165, 0)
mainStroke.Thickness = 1.5
mainStroke.Parent = MainFrame
local Header = Instance.new(_d({68,85,104,100,60,81,82,85,92},16))
Header.Size = UDim2.new(1, -40, 0, 36)
Header.Position = UDim2.new(0, 12, 0, 4)
Header.BackgroundTransparency = 1
Header.Text = _d({50,81,94,81,94,81,16,61,95,94,91,85,105,16,56,101,82,16,224,143,125,124},16)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 18
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame
local Subtitle = Instance.new(_d({68,85,104,100,60,81,82,85,92},16))
Subtitle.Size = UDim2.new(1, -40, 0, 16)
Subtitle.Position = UDim2.new(0, 12, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = _d({49,101,100,95,29,52,85,99,100,98,95,105,28,16,58,101,93,96,16,22,16,71,81,92,91,16,49,98,95,101,94,84},16)
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.SourceSans
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame
local CloseBtn = Instance.new(_d({68,85,104,100,50,101,100,100,95,94},16))
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame
local closeCorner = Instance.new(_d({69,57,51,95,98,94,85,98},16))
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = false
end)
ToggleBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = not MainFrame.Visible
end)
local Divider = Instance.new(_d({54,98,81,93,85},16))
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 52)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame
local AutoBtn = Instance.new(_d({68,85,104,100,50,101,100,100,95,94},16))
AutoBtn.Size = UDim2.new(1, -24, 0, 38)
AutoBtn.Position = UDim2.new(0, 12, 0, 60)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
AutoBtn.Text = _d({49,101,100,95,29,52,85,99,100,98,95,105,16,55,98,95,101,94,84,42,16,63,54,54},16)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.TextSize = 14
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.Parent = MainFrame
local autoCorner = Instance.new(_d({69,57,51,95,98,94,85,98},16))
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = AutoBtn
local autoStroke = Instance.new(_d({69,57,67,100,98,95,91,85},16))
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
AutoBtn.Text = _d({49,101,100,95,29,52,85,99,100,98,95,105,16,55,98,95,101,94,84,42,16,63,62,16,210,138,145},16)
AutoBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 35)
autoStroke.Color = Color3.fromRGB(90, 255, 140)
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
if root then
local punchEvent = ReplicatedStorage:FindFirstChild(_d({52,85,99,100,98,101,83,100,89,95,94,79,64,101,94,83,88},16), true)
if punchEvent and punchEvent:IsA(_d({66,85,93,95,100,85,53,102,85,94,100},16)) then
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
AutoBtn.Text = _d({49,101,100,95,29,52,85,99,100,98,95,105,16,55,98,95,101,94,84,42,16,63,54,54},16)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
autoStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local JumpBtn = Instance.new(_d({68,85,104,100,50,101,100,100,95,94},16))
JumpBtn.Size = UDim2.new(1, -24, 0, 32)
JumpBtn.Position = UDim2.new(0, 12, 0, 104)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
JumpBtn.Text = _d({49,101,100,95,16,58,101,93,96,42,16,63,54,54},16)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.TextSize = 13
JumpBtn.Font = Enum.Font.SourceSansBold
JumpBtn.Parent = MainFrame
local jumpCorner = Instance.new(_d({69,57,51,95,98,94,85,98},16))
jumpCorner.CornerRadius = UDim.new(0, 8)
jumpCorner.Parent = JumpBtn
local jumpStroke = Instance.new(_d({69,57,67,100,98,95,91,85},16))
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
jumpStroke.Thickness = 1
jumpStroke.Parent = JumpBtn
JumpBtn.MouseButton1Click:Connect(function()
autoJumping = not autoJumping
if autoJumping then
JumpBtn.Text = _d({49,101,100,95,16,58,101,93,96,42,16,63,62,16,224,143,150,136},16)
JumpBtn.TextColor3 = Color3.fromRGB(255, 200, 90)
JumpBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 20)
jumpStroke.Color = Color3.fromRGB(255, 200, 90)
task.spawn(function()
while autoJumping do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({56,101,93,81,94,95,89,84},16))
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
JumpBtn.Text = _d({49,101,100,95,16,58,101,93,96,42,16,63,54,54},16)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local MoveBtn = Instance.new(_d({68,85,104,100,50,101,100,100,95,94},16))
MoveBtn.Size = UDim2.new(1, -24, 0, 32)
MoveBtn.Position = UDim2.new(0, 12, 0, 142)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
MoveBtn.Text = _d({49,101,100,95,29,61,95,102,85,16,24,71,81,92,91,16,49,98,95,101,94,84,25,42,16,63,54,54},16)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.TextSize = 13
MoveBtn.Font = Enum.Font.SourceSansBold
MoveBtn.Parent = MainFrame
local moveCorner = Instance.new(_d({69,57,51,95,98,94,85,98},16))
moveCorner.CornerRadius = UDim.new(0, 8)
moveCorner.Parent = MoveBtn
local moveStroke = Instance.new(_d({69,57,67,100,98,95,91,85},16))
moveStroke.Color = Color3.fromRGB(60, 60, 80)
moveStroke.Thickness = 1
moveStroke.Parent = MoveBtn
MoveBtn.MouseButton1Click:Connect(function()
autoMoving = not autoMoving
if autoMoving then
MoveBtn.Text = _d({49,101,100,95,29,61,95,102,85,16,24,71,81,92,91,16,49,98,95,101,94,84,25,42,16,63,62,16,224,143,138,166},16)
MoveBtn.TextColor3 = Color3.fromRGB(90, 200, 255)
MoveBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 60)
moveStroke.Color = Color3.fromRGB(90, 200, 255)
task.spawn(function()
local angle = 0
while autoMoving do
local character = LocalPlayer.Character
if character then
local humanoid = character:FindFirstChildOfClass(_d({56,101,93,81,94,95,89,84},16))
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
MoveBtn.Text = _d({49,101,100,95,29,61,95,102,85,16,24,71,81,92,91,16,49,98,95,101,94,84,25,42,16,63,54,54},16)
MoveBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
moveStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local SpeedLabel = Instance.new(_d({68,85,104,100,60,81,82,85,92},16))
SpeedLabel.Size = UDim2.new(1, -24, 0, 18)
SpeedLabel.Position = UDim2.new(0, 12, 0, 180)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = _d({64,101,94,83,88,16,52,85,92,81,105,42,16,32,30,33,32,99,16,24,54,81,99,100,25},16)
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame
local speedContainer = Instance.new(_d({54,98,81,93,85},16))
speedContainer.Size = UDim2.new(1, -24, 0, 28)
speedContainer.Position = UDim2.new(0, 12, 0, 200)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = MainFrame
local speeds = {
{ label = _d({32,30,32,37,99},16), delay = 0.05 },
{ label = _d({32,30,33,32,99},16), delay = 0.10 },
{ label = _d({32,30,34,37,99},16), delay = 0.25 },
{ label = _d({32,30,37,32,99},16), delay = 0.50 }
}
for i, opt in ipairs(speeds) do
local btn = Instance.new(_d({68,85,104,100,50,101,100,100,95,94},16))
btn.Size = UDim2.new(0.23, -2, 1, 0)
btn.Position = UDim2.new((i - 1) * 0.25, 0, 0, 0)
btn.BackgroundColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(40, 40, 55)
btn.Text = opt.label
btn.TextColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(25, 25, 32) or Color3.fromRGB(200, 200, 200)
btn.TextSize = 12
btn.Font = Enum.Font.SourceSansBold
btn.Parent = speedContainer
local btnCorner = Instance.new(_d({69,57,51,95,98,94,85,98},16))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
destroyDelay = opt.delay
SpeedLabel.Text = _d({64,101,94,83,88,16,52,85,92,81,105,42,16},16) .. string.format(_d({21,30,34,86,99},16), destroyDelay)
for _, child in ipairs(speedContainer:GetChildren()) do
if child:IsA(_d({68,85,104,100,50,101,100,100,95,94},16)) then
child.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
child.TextColor3 = Color3.fromRGB(200, 200, 200)
end
end
btn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
btn.TextColor3 = Color3.fromRGB(25, 25, 32)
end)
end
local DestroyBtn = Instance.new(_d({68,85,104,100,50,101,100,100,95,94},16))
DestroyBtn.Size = UDim2.new(1, -24, 0, 28)
DestroyBtn.Position = UDim2.new(0, 12, 0, 268)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
DestroyBtn.Text = _d({69,94,92,95,81,84,16,56,101,82,16,67,83,98,89,96,100},16)
DestroyBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
DestroyBtn.TextSize = 12
DestroyBtn.Font = Enum.Font.SourceSans
DestroyBtn.Parent = MainFrame
local destroyCorner = Instance.new(_d({69,57,51,95,98,94,85,98},16))
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = DestroyBtn
DestroyBtn.MouseButton1Click:Connect(function()
autoDestroying = false
autoJumping = false
autoMoving = false
ScreenGui:Destroy()
end)
print(_d({75,50,81,94,81,94,81,16,61,95,94,91,85,105,16,56,101,82,77,16,60,95,81,84,85,84,16,99,101,83,83,85,99,99,86,101,92,92,105,17},16))
end)()