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
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local CoreGui = game:GetService(_d({46,90,93,80,50,96,84},21))
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21))
if parentGui:FindFirstChild(_d({45,76,89,76,89,76,56,90,89,86,80,100,51,96,77,50,96,84},21)) then
parentGui.BananaMonkeyHubGui:Destroy()
end
local ScreenGui = Instance.new(_d({62,78,93,80,80,89,50,96,84},21))
ScreenGui.Name = _d({45,76,89,76,89,76,56,90,89,86,80,100,51,96,77,50,96,84},21)
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui
local autoDestroying = false
local destroyDelay = 0.1
local punchPower = 2
local ToggleBtn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
ToggleBtn.Name = _d({49,87,90,76,95,84,89,82,63,90,82,82,87,80},21)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleBtn.Text = _d({219,138,120,119},21)
ToggleBtn.TextSize = 28
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
local toggleCorner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
toggleCorner.CornerRadius = UDim.new(0.5, 0)
toggleCorner.Parent = ToggleBtn
local toggleStroke = Instance.new(_d({64,52,62,95,93,90,86,80},21))
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Thickness = 2
toggleStroke.Parent = ToggleBtn
local MainFrame = Instance.new(_d({49,93,76,88,80},21))
MainFrame.Name = _d({56,76,84,89,49,93,76,88,80},21)
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame
local mainStroke = Instance.new(_d({64,52,62,95,93,90,86,80},21))
mainStroke.Color = Color3.fromRGB(255, 165, 0)
mainStroke.Thickness = 1.5
mainStroke.Parent = MainFrame
local Header = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
Header.Size = UDim2.new(1, -40, 0, 40)
Header.Position = UDim2.new(0, 12, 0, 4)
Header.BackgroundTransparency = 1
Header.Text = _d({45,76,89,76,89,76,11,56,90,89,86,80,100,11,51,96,77,11,219,138,120,119},21)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 18
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame
local Subtitle = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
Subtitle.Size = UDim2.new(1, -40, 0, 16)
Subtitle.Position = UDim2.new(0, 12, 0, 34)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = _d({44,96,95,90,24,47,80,94,95,93,90,100,11,56,90,77,84,87,80,11,46,90,89,95,93,90,87,94},21)
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.SourceSans
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame
local CloseBtn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame
local closeCorner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = false
end)
ToggleBtn.MouseButton1Click:Connect(function()
MainFrame.Visible = not MainFrame.Visible
end)
local Divider = Instance.new(_d({49,93,76,88,80},21))
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 56)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame
local AutoBtn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
AutoBtn.Size = UDim2.new(1, -24, 0, 42)
AutoBtn.Position = UDim2.new(0, 12, 0, 68)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
AutoBtn.Text = _d({44,96,95,90,24,47,80,94,95,93,90,100,11,50,93,90,96,89,79,37,11,58,49,49},21)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.TextSize = 15
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.Parent = MainFrame
local autoCorner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = AutoBtn
local autoStroke = Instance.new(_d({64,52,62,95,93,90,86,80},21))
autoStroke.Color = Color3.fromRGB(60, 60, 80)
autoStroke.Thickness = 1
autoStroke.Parent = AutoBtn
AutoBtn.MouseButton1Click:Connect(function()
autoDestroying = not autoDestroying
if autoDestroying then
AutoBtn.Text = _d({44,96,95,90,24,47,80,94,95,93,90,100,11,50,93,90,96,89,79,37,11,58,57,11,205,133,140},21)
AutoBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 35)
autoStroke.Color = Color3.fromRGB(90, 255, 140)
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if root then
local targetPos = root.Position - Vector3.new(0, 3.5, 0)
local punchEvent = ReplicatedStorage:FindFirstChild(_d({47,80,94,95,93,96,78,95,84,90,89,74,59,96,89,78,83},21), true)
if punchEvent and punchEvent:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) then
pcall(function()
punchEvent:FireServer(punchPower, targetPos)
end)
end
end
end
task.wait(destroyDelay)
end
end)
else
AutoBtn.Text = _d({44,96,95,90,24,47,80,94,95,93,90,100,11,50,93,90,96,89,79,37,11,58,49,49},21)
AutoBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
autoStroke.Color = Color3.fromRGB(60, 60, 80)
end
end)
local SpeedLabel = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
SpeedLabel.Size = UDim2.new(1, -24, 0, 20)
SpeedLabel.Position = UDim2.new(0, 12, 0, 120)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = _d({59,96,89,78,83,11,47,80,87,76,100,37,11,27,25,28,27,94,11,19,49,76,94,95,20},21)
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpeedLabel.TextSize = 13
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame
local speedContainer = Instance.new(_d({49,93,76,88,80},21))
speedContainer.Size = UDim2.new(1, -24, 0, 30)
speedContainer.Position = UDim2.new(0, 12, 0, 142)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = MainFrame
local speeds = {
{ label = _d({27,25,27,32,94},21), delay = 0.05 },
{ label = _d({27,25,28,27,94},21), delay = 0.10 },
{ label = _d({27,25,29,32,94},21), delay = 0.25 },
{ label = _d({27,25,32,27,94},21), delay = 0.50 }
}
for i, opt in ipairs(speeds) do
local btn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
btn.Size = UDim2.new(0.23, -2, 1, 0)
btn.Position = UDim2.new((i - 1) * 0.25, 0, 0, 0)
btn.BackgroundColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(40, 40, 55)
btn.Text = opt.label
btn.TextColor3 = (opt.delay == destroyDelay) and Color3.fromRGB(25, 25, 32) or Color3.fromRGB(200, 200, 200)
btn.TextSize = 12
btn.Font = Enum.Font.SourceSansBold
btn.Parent = speedContainer
local btnCorner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
destroyDelay = opt.delay
SpeedLabel.Text = _d({59,96,89,78,83,11,47,80,87,76,100,37,11},21) .. string.format(_d({16,25,29,81,94},21), destroyDelay)
for _, child in ipairs(speedContainer:GetChildren()) do
if child:IsA(_d({63,80,99,95,45,96,95,95,90,89},21)) then
child.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
child.TextColor3 = Color3.fromRGB(200, 200, 200)
end
end
btn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
btn.TextColor3 = Color3.fromRGB(25, 25, 32)
end)
end
local DestroyBtn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
DestroyBtn.Size = UDim2.new(1, -24, 0, 28)
DestroyBtn.Position = UDim2.new(0, 12, 0, 180)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
DestroyBtn.Text = _d({64,89,87,90,76,79,11,51,96,77,11,62,78,93,84,91,95},21)
DestroyBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
DestroyBtn.TextSize = 12
DestroyBtn.Font = Enum.Font.SourceSans
DestroyBtn.Parent = MainFrame
local destroyCorner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = DestroyBtn
DestroyBtn.MouseButton1Click:Connect(function()
autoDestroying = false
ScreenGui:Destroy()
end)
print(_d({70,45,76,89,76,89,76,11,56,90,89,86,80,100,11,51,96,77,72,11,55,90,76,79,80,79,11,94,96,78,78,80,94,94,81,96,87,87,100,12},21))
end)()