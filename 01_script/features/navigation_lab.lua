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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local RunService = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({41,69,58,82,62,75,32,78,66},39), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({44,58,63,62,39,58,79,66,64,58,77,72,75,46,34},39))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({44,60,75,62,62,71,32,78,66},39))
screenGui.Name = _d({44,58,63,62,39,58,79,66,64,58,77,72,75,46,34},39)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({31,75,58,70,62},39))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({46,34,28,72,75,71,62,75},39), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({46,34,44,77,75,72,68,62},39))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({45,62,81,77,37,58,59,62,69},39))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({44,58,63,62,249,39,58,79,66,64,58,77,66,72,71,249,37,58,59},39)
title.Parent = main
local closeBtn = Instance.new(_d({45,62,81,77,27,78,77,77,72,71},39))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({46,34,28,72,75,71,62,75},39), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({45,62,81,77,37,58,59,62,69},39))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({46,34,28,72,75,71,62,75},39), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({38,40,47,34,39,32,249,45,40,249,41,37,26,28,30,249,26},39) or _d({34,29,37,30},39)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({31,75,58,70,62},39))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({45,62,81,77,27,72,81},39))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({46,34,28,72,75,71,62,75},39), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({45,62,81,77,27,78,77,77,72,71},39))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({46,34,28,72,75,71,62,75},39), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({44,62,77,249,41,69,58,60,62,249,26,249,22,249,12,9,249,44,77,78,61,76,249,26,65,62,58,61},39), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({44,77,58,75,77,249,38,72,79,62,249,77,72,249,41,69,58,60,62,249,26},39), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({44,77,72,73,249,38,72,79,62,70,62,71,77},39), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({254,7,10,63},39), target.X)
inputY.Text = string.format(_d({254,7,10,63},39), target.Y)
inputZ.Text = string.format(_d({254,7,10,63},39), target.Z)
end
end)
btnStart.MouseButton1Click:Connect(function()
local x = tonumber(inputX.Text)
local y = tonumber(inputY.Text)
local z = tonumber(inputZ.Text)
if x and y and z then
SafeNavigator.MoveTo(Vector3.new(x, y, z))
end
end)
btnStop.MouseButton1Click:Connect(function()
SafeNavigator.Stop()
end)
end
task.spawn(function()
task.wait(0.3)
CreateSafeUI()
end)
print(_d({52,44,58,63,62,39,58,79,66,64,58,77,72,75,249,30,71,64,66,71,62,54,249,37,72,58,61,62,61,249,80,66,77,65,249,44,58,63,62,249,41,69,58,82,62,75,32,78,66,249,34,71,77,62,75,63,58,60,62,7},39))
return SafeNavigator
end)()