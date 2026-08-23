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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({48,62,67,66,43,62,83,70,68,62,81,76,79,50,38},35))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({48,64,79,66,66,75,36,82,70},35))
screenGui.Name = _d({48,62,67,66,43,62,83,70,68,62,81,76,79,50,38},35)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({35,79,62,74,66},35))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({50,38,32,76,79,75,66,79},35), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({50,38,48,81,79,76,72,66},35))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({48,62,67,66,253,43,62,83,70,68,62,81,70,76,75,253,41,62,63},35)
title.Parent = main
local closeBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({50,38,32,76,79,75,66,79},35), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({50,38,32,76,79,75,66,79},35), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({42,44,51,38,43,36,253,49,44,253,45,41,30,32,34,253,30},35) or _d({38,33,41,34},35)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({35,79,62,74,66},35))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({49,66,85,81,31,76,85},35))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({50,38,32,76,79,75,66,79},35), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({50,38,32,76,79,75,66,79},35), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({48,66,81,253,45,73,62,64,66,253,30,253,26,253,16,13,253,48,81,82,65,80,253,30,69,66,62,65},35), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({48,81,62,79,81,253,42,76,83,66,253,81,76,253,45,73,62,64,66,253,30},35), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({48,81,76,77,253,42,76,83,66,74,66,75,81},35), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({2,11,14,67},35), target.X)
inputY.Text = string.format(_d({2,11,14,67},35), target.Y)
inputZ.Text = string.format(_d({2,11,14,67},35), target.Z)
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
print(_d({56,48,62,67,66,43,62,83,70,68,62,81,76,79,253,34,75,68,70,75,66,58,253,41,76,62,65,66,65,253,84,70,81,69,253,48,62,67,66,253,45,73,62,86,66,79,36,82,70,253,38,75,81,66,79,67,62,64,66,11},35))
return SafeNavigator
end)()