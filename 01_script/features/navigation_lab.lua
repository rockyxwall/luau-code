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
local Players = game:GetService(_d({36,64,53,77,57,70,71},44))
local RunService = game:GetService(_d({38,73,66,39,57,70,74,61,55,57},44))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({36,64,53,77,57,70,27,73,61},44), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({39,53,58,57,34,53,74,61,59,53,72,67,70,41,29},44))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({39,55,70,57,57,66,27,73,61},44))
screenGui.Name = _d({39,53,58,57,34,53,74,61,59,53,72,67,70,41,29},44)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({26,70,53,65,57},44))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({41,29,23,67,70,66,57,70},44), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({41,29,39,72,70,67,63,57},44))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({40,57,76,72,32,53,54,57,64},44))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({39,53,58,57,244,34,53,74,61,59,53,72,61,67,66,244,32,53,54},44)
title.Parent = main
local closeBtn = Instance.new(_d({40,57,76,72,22,73,72,72,67,66},44))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({41,29,23,67,70,66,57,70},44), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({40,57,76,72,32,53,54,57,64},44))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({41,29,23,67,70,66,57,70},44), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({33,35,42,29,34,27,244,40,35,244,36,32,21,23,25,244,21},44) or _d({29,24,32,25},44)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({26,70,53,65,57},44))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({40,57,76,72,22,67,76},44))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({41,29,23,67,70,66,57,70},44), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({40,57,76,72,22,73,72,72,67,66},44))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({41,29,23,67,70,66,57,70},44), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({39,57,72,244,36,64,53,55,57,244,21,244,17,244,7,4,244,39,72,73,56,71,244,21,60,57,53,56},44), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({39,72,53,70,72,244,33,67,74,57,244,72,67,244,36,64,53,55,57,244,21},44), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({39,72,67,68,244,33,67,74,57,65,57,66,72},44), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({249,2,5,58},44), target.X)
inputY.Text = string.format(_d({249,2,5,58},44), target.Y)
inputZ.Text = string.format(_d({249,2,5,58},44), target.Z)
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
print(_d({47,39,53,58,57,34,53,74,61,59,53,72,67,70,244,25,66,59,61,66,57,49,244,32,67,53,56,57,56,244,75,61,72,60,244,39,53,58,57,244,36,64,53,77,57,70,27,73,61,244,29,66,72,57,70,58,53,55,57,2},44))
return SafeNavigator
end)()