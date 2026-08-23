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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({56,70,75,74,51,70,91,78,76,70,89,84,87,58,46},27))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({56,72,87,74,74,83,44,90,78},27))
screenGui.Name = _d({56,70,75,74,51,70,91,78,76,70,89,84,87,58,46},27)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({43,87,70,82,74},27))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({58,46,40,84,87,83,74,87},27), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({58,46,56,89,87,84,80,74},27))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({57,74,93,89,49,70,71,74,81},27))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({56,70,75,74,5,51,70,91,78,76,70,89,78,84,83,5,49,70,71},27)
title.Parent = main
local closeBtn = Instance.new(_d({57,74,93,89,39,90,89,89,84,83},27))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({58,46,40,84,87,83,74,87},27), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({57,74,93,89,49,70,71,74,81},27))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({58,46,40,84,87,83,74,87},27), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({50,52,59,46,51,44,5,57,52,5,53,49,38,40,42,5,38},27) or _d({46,41,49,42},27)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({43,87,70,82,74},27))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({57,74,93,89,39,84,93},27))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({58,46,40,84,87,83,74,87},27), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({57,74,93,89,39,90,89,89,84,83},27))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({58,46,40,84,87,83,74,87},27), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({56,74,89,5,53,81,70,72,74,5,38,5,34,5,24,21,5,56,89,90,73,88,5,38,77,74,70,73},27), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({56,89,70,87,89,5,50,84,91,74,5,89,84,5,53,81,70,72,74,5,38},27), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({56,89,84,85,5,50,84,91,74,82,74,83,89},27), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({10,19,22,75},27), target.X)
inputY.Text = string.format(_d({10,19,22,75},27), target.Y)
inputZ.Text = string.format(_d({10,19,22,75},27), target.Z)
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
print(_d({64,56,70,75,74,51,70,91,78,76,70,89,84,87,5,42,83,76,78,83,74,66,5,49,84,70,73,74,73,5,92,78,89,77,5,56,70,75,74,5,53,81,70,94,74,87,44,90,78,5,46,83,89,74,87,75,70,72,74,19},27))
return SafeNavigator
end)()