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
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local CoreGui = game:GetService(_d({11,55,58,45,15,61,49},56))
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({24,52,41,65,45,58,15,61,49},56))
if parentGui:FindFirstChild(_d({10,41,54,41,54,41,21,55,54,51,45,65,16,61,42,15,61,49},56)) then
parentGui.BananaMonkeyHubGui:Destroy()
end
local ScreenGui = Instance.new(_d({27,43,58,45,45,54,15,61,49},56))
ScreenGui.Name = _d({10,41,54,41,54,41,21,55,54,51,45,65,16,61,42,15,61,49},56)
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui
local autoDestroying = false
local autoJumping = false
local destroyDelay = 0.1
local punchPower = 2
local radiusSize = 3.5
local ToggleBtn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
ToggleBtn.Name = _d({14,52,55,41,60,49,54,47,28,55,47,47,52,45},56)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleBtn.Text = _d({184,103,85,84},56)
ToggleBtn.TextSize = 28
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
local toggleCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
toggleCorner.CornerRadius = UDim.new(0.5, 0)
toggleCorner.Parent = ToggleBtn
local toggleStroke = Instance.new(_d({29,17,27,60,58,55,51,45},56))
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 2
toggleStroke.Parent = ToggleBtn
local MainFrame = Instance.new(_d({14,58,41,53,45},56))
MainFrame.Name = _d({21,41,49,54,14,58,41,53,45},56)
MainFrame.Size = UDim2.new(0, 280, 0, 270)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -135)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame
local mainStroke = Instance.new(_d({29,17,27,60,58,55,51,45},56))
mainStroke.Color = Color3.fromRGB(255, 165, 0)
mainStroke.Thickness = 1.5
mainStroke.Parent = MainFrame
local Header = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
Header.Size = UDim2.new(1, -40, 0, 36)
Header.Position = UDim2.new(0, 12, 0, 4)
Header.BackgroundTransparency = 1
Header.Text = _d({10,41,54,41,54,41,232,21,55,54,51,45,65,232,16,61,42,232,184,103,85,84},56)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 18
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame
local Subtitle = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
Subtitle.Size = UDim2.new(1, -40, 0, 16)
Subtitle.Position = UDim2.new(0, 12, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = _d({31,49,44,45,245,26,41,44,49,61,59,232,9,61,60,55,245,12,45,59,60,58,55,65,232,238,232,18,61,53,56},56)
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.SourceSans
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame
local CloseBtn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame
local closeCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = false
end)
ToggleBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = not MainFrame.Visible
end)
local Divider = Instance.new(_d({14,58,41,53,45},56))
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 52)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame
local AutoBtn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
AutoBtn.Size = UDim2.new(1, -24, 0, 40)
AutoBtn.Position = UDim2.new(0, 12, 0, 60)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
AutoBtn.Text = _d({9,61,60,55,245,12,45,59,60,58,55,65,232,240,31,49,44,45,232,26,41,44,49,61,59,241,2,232,23,14,14},56)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.TextSize = 14
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.Parent = MainFrame
local autoCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = AutoBtn
local autoStroke = Instance.new(_d({29,17,27,60,58,55,51,45},56))
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
AutoBtn.Text = _d({9,61,60,55,245,12,45,59,60,58,55,65,232,240,31,49,44,45,232,26,41,44,49,61,59,241,2,232,23,22,232,170,98,105},56)
AutoBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 35)
autoStroke.Color = Color3.fromRGB(90, 255, 140)
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
local humanoid = character:FindFirstChildOfClass(_d({16,61,53,41,54,55,49,44},56))
if root then
local punchEvent = ReplicatedStorage:FindFirstChild(_d({12,45,59,60,58,61,43,60,49,55,54,39,24,61,54,43,48},56), true)
if punchEvent and punchEvent:IsA(_d({26,45,53,55,60,45,13,62,45,54,60},56)) then
local basePos = root.Position
local offsets = getOffsets(radiusSize)
for _, offset in ipairs(offsets) do
if not autoDestroying then break end
pcall(function()
punchEvent:FireServer(punchPower, basePos + offset)
end)
end
end
if autoJumping and humanoid then
if humanoid.FloorMaterial ~= Enum.Material.Air then
humanoid.Jump = true
end
end
end
end
task.wait(destroyDelay)
end
end)
else
AutoBtn.Text = _d({9,61,60,55,245,12,45,59,60,58,55,65,232,240,31,49,44,45,232,26,41,44,49,61,59,241,2,232,23,14,14},56)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
autoStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local JumpBtn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
JumpBtn.Size = UDim2.new(1, -24, 0, 34)
JumpBtn.Position = UDim2.new(0, 12, 0, 108)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
JumpBtn.Text = _d({9,61,60,55,232,18,61,53,56,232,240,9,54,60,49,245,27,60,61,43,51,241,2,232,23,14,14},56)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.TextSize = 13
JumpBtn.Font = Enum.Font.SourceSansBold
JumpBtn.Parent = MainFrame
local jumpCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
jumpCorner.CornerRadius = UDim.new(0, 8)
jumpCorner.Parent = JumpBtn
local jumpStroke = Instance.new(_d({29,17,27,60,58,55,51,45},56))
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
jumpStroke.Thickness = 1
jumpStroke.Parent = JumpBtn
JumpBtn.MouseButton1Click:Connect(function()
autoJumping = not autoJumping
if autoJumping then
JumpBtn.Text = _d({9,61,60,55,232,18,61,53,56,232,240,9,54,60,49,245,27,60,61,43,51,241,2,232,23,22,232,184,103,110,96},56)
JumpBtn.TextColor3 = Color3.fromRGB(255, 200, 90)
JumpBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 20)
jumpStroke.Color = Color3.fromRGB(255, 200, 90)
else
JumpBtn.Text = _d({9,61,60,55,232,18,61,53,56,232,240,9,54,60,49,245,27,60,61,43,51,241,2,232,23,14,14},56)
JumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
jumpStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local SpeedLabel = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
SpeedLabel.Size = UDim2.new(1, -24, 0, 18)
SpeedLabel.Position = UDim2.new(0, 12, 0, 148)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = _d({24,61,54,43,48,232,12,45,52,41,65,2,232,248,246,249,248,59,232,240,14,41,59,60,241},56)
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame
local speedContainer = Instance.new(_d({14,58,41,53,45},56))
speedContainer.Size = UDim2.new(1, -24, 0, 28)
speedContainer.Position = UDim2.new(0, 12, 0, 168)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = MainFrame
local speeds = {
{ label = _d({248,246,248,253,59},56), delay = 0.05 },
{ label = _d({248,246,249,248,59},56), delay = 0.10 },
{ label = _d({248,246,250,253,59},56), delay = 0.25 },
{ label = _d({248,246,253,248,59},56), delay = 0.50 }
}
for i, opt in ipairs(speeds) do
local btn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
btn.Size = UDim2.new(0.23, -2, 1, 0)
btn.Position = UDim2.new((i - 1) * 0.25, 0, 0, 0)
btn.BackgroundColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(40, 40, 55)
btn.Text = opt.label
btn.TextColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(25, 25, 32) or Color3.fromRGB(200, 200, 200)
btn.TextSize = 12
btn.Font = Enum.Font.SourceSansBold
btn.Parent = speedContainer
local btnCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
destroyDelay = opt.delay
SpeedLabel.Text = _d({24,61,54,43,48,232,12,45,52,41,65,2,232},56) .. string.format(_d({237,246,250,46,59},56), destroyDelay)
for _, child in ipairs(speedContainer:GetChildren()) do
if child:IsA(_d({28,45,64,60,10,61,60,60,55,54},56)) then
child.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
child.TextColor3 = Color3.fromRGB(200, 200, 200)
end
end
btn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
btn.TextColor3 = Color3.fromRGB(25, 25, 32)
end)
end
local DestroyBtn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
DestroyBtn.Size = UDim2.new(1, -24, 0, 28)
DestroyBtn.Position = UDim2.new(0, 12, 0, 230)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
DestroyBtn.Text = _d({29,54,52,55,41,44,232,16,61,42,232,27,43,58,49,56,60},56)
DestroyBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
DestroyBtn.TextSize = 12
DestroyBtn.Font = Enum.Font.SourceSans
DestroyBtn.Parent = MainFrame
local destroyCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = DestroyBtn
DestroyBtn.MouseButton1Click:Connect(function()
autoDestroying = false
autoJumping = false
ScreenGui:Destroy()
end)
print(_d({35,10,41,54,41,54,41,232,21,55,54,51,45,65,232,16,61,42,37,232,20,55,41,44,45,44,232,59,61,43,43,45,59,59,46,61,52,52,65,233},56))
end)()