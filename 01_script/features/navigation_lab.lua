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
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local RunService = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({65,79,84,83,60,79,100,87,85,79,98,93,96,67,55},18))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({65,81,96,83,83,92,53,99,87},18))
screenGui.Name = _d({65,79,84,83,60,79,100,87,85,79,98,93,96,67,55},18)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({52,96,79,91,83},18))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({67,55,49,93,96,92,83,96},18), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({67,55,65,98,96,93,89,83},18))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({66,83,102,98,58,79,80,83,90},18))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({65,79,84,83,14,60,79,100,87,85,79,98,87,93,92,14,58,79,80},18)
title.Parent = main
local closeBtn = Instance.new(_d({66,83,102,98,48,99,98,98,93,92},18))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({67,55,49,93,96,92,83,96},18), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({66,83,102,98,58,79,80,83,90},18))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({67,55,49,93,96,92,83,96},18), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({59,61,68,55,60,53,14,66,61,14,62,58,47,49,51,14,47},18) or _d({55,50,58,51},18)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({52,96,79,91,83},18))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({66,83,102,98,48,93,102},18))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({67,55,49,93,96,92,83,96},18), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({66,83,102,98,48,99,98,98,93,92},18))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({67,55,49,93,96,92,83,96},18), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({65,83,98,14,62,90,79,81,83,14,47,14,43,14,33,30,14,65,98,99,82,97,14,47,86,83,79,82},18), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({65,98,79,96,98,14,59,93,100,83,14,98,93,14,62,90,79,81,83,14,47},18), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({65,98,93,94,14,59,93,100,83,91,83,92,98},18), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({19,28,31,84},18), target.X)
inputY.Text = string.format(_d({19,28,31,84},18), target.Y)
inputZ.Text = string.format(_d({19,28,31,84},18), target.Z)
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
print(_d({73,65,79,84,83,60,79,100,87,85,79,98,93,96,14,51,92,85,87,92,83,75,14,58,93,79,82,83,82,14,101,87,98,86,14,65,79,84,83,14,62,90,79,103,83,96,53,99,87,14,55,92,98,83,96,84,79,81,83,28},18))
return SafeNavigator
end)()