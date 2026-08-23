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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local RunService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({40,54,59,58,35,54,75,62,60,54,73,68,71,42,30},43))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({40,56,71,58,58,67,28,74,62},43))
screenGui.Name = _d({40,54,59,58,35,54,75,62,60,54,73,68,71,42,30},43)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({27,71,54,66,58},43))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({42,30,24,68,71,67,58,71},43), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({42,30,40,73,71,68,64,58},43))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({41,58,77,73,33,54,55,58,65},43))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({40,54,59,58,245,35,54,75,62,60,54,73,62,68,67,245,33,54,55},43)
title.Parent = main
local closeBtn = Instance.new(_d({41,58,77,73,23,74,73,73,68,67},43))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({42,30,24,68,71,67,58,71},43), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({41,58,77,73,33,54,55,58,65},43))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({42,30,24,68,71,67,58,71},43), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({34,36,43,30,35,28,245,41,36,245,37,33,22,24,26,245,22},43) or _d({30,25,33,26},43)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({27,71,54,66,58},43))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({41,58,77,73,23,68,77},43))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({42,30,24,68,71,67,58,71},43), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({41,58,77,73,23,74,73,73,68,67},43))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({42,30,24,68,71,67,58,71},43), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({40,58,73,245,37,65,54,56,58,245,22,245,18,245,8,5,245,40,73,74,57,72,245,22,61,58,54,57},43), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({40,73,54,71,73,245,34,68,75,58,245,73,68,245,37,65,54,56,58,245,22},43), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({40,73,68,69,245,34,68,75,58,66,58,67,73},43), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({250,3,6,59},43), target.X)
inputY.Text = string.format(_d({250,3,6,59},43), target.Y)
inputZ.Text = string.format(_d({250,3,6,59},43), target.Z)
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
print(_d({48,40,54,59,58,35,54,75,62,60,54,73,68,71,245,26,67,60,62,67,58,50,245,33,68,54,57,58,57,245,76,62,73,61,245,40,54,59,58,245,37,65,54,78,58,71,28,74,62,245,30,67,73,58,71,59,54,56,58,3},43))
return SafeNavigator
end)()