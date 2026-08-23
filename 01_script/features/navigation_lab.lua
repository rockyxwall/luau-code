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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local RunService = game:GetService(_d({20,55,48,21,39,52,56,43,37,39},62))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({18,46,35,59,39,52,9,55,43},62), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({21,35,40,39,16,35,56,43,41,35,54,49,52,23,11},62))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({21,37,52,39,39,48,9,55,43},62))
screenGui.Name = _d({21,35,40,39,16,35,56,43,41,35,54,49,52,23,11},62)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({8,52,35,47,39},62))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({23,11,5,49,52,48,39,52},62), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({23,11,21,54,52,49,45,39},62))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({22,39,58,54,14,35,36,39,46},62))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({21,35,40,39,226,16,35,56,43,41,35,54,43,49,48,226,14,35,36},62)
title.Parent = main
local closeBtn = Instance.new(_d({22,39,58,54,4,55,54,54,49,48},62))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({23,11,5,49,52,48,39,52},62), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({22,39,58,54,14,35,36,39,46},62))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({23,11,5,49,52,48,39,52},62), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({15,17,24,11,16,9,226,22,17,226,18,14,3,5,7,226,3},62) or _d({11,6,14,7},62)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({8,52,35,47,39},62))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({22,39,58,54,4,49,58},62))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({23,11,5,49,52,48,39,52},62), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({22,39,58,54,4,55,54,54,49,48},62))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({23,11,5,49,52,48,39,52},62), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({21,39,54,226,18,46,35,37,39,226,3,226,255,226,245,242,226,21,54,55,38,53,226,3,42,39,35,38},62), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({21,54,35,52,54,226,15,49,56,39,226,54,49,226,18,46,35,37,39,226,3},62), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({21,54,49,50,226,15,49,56,39,47,39,48,54},62), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({231,240,243,40},62), target.X)
inputY.Text = string.format(_d({231,240,243,40},62), target.Y)
inputZ.Text = string.format(_d({231,240,243,40},62), target.Z)
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
print(_d({29,21,35,40,39,16,35,56,43,41,35,54,49,52,226,7,48,41,43,48,39,31,226,14,49,35,38,39,38,226,57,43,54,42,226,21,35,40,39,226,18,46,35,59,39,52,9,55,43,226,11,48,54,39,52,40,35,37,39,240},62))
return SafeNavigator
end)()