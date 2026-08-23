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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({22,50,39,63,43,56,13,59,47},58), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({25,39,44,43,20,39,60,47,45,39,58,53,56,27,15},58))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({25,41,56,43,43,52,13,59,47},58))
screenGui.Name = _d({25,39,44,43,20,39,60,47,45,39,58,53,56,27,15},58)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({12,56,39,51,43},58))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({27,15,9,53,56,52,43,56},58), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({27,15,25,58,56,53,49,43},58))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({26,43,62,58,18,39,40,43,50},58))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({25,39,44,43,230,20,39,60,47,45,39,58,47,53,52,230,18,39,40},58)
title.Parent = main
local closeBtn = Instance.new(_d({26,43,62,58,8,59,58,58,53,52},58))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({27,15,9,53,56,52,43,56},58), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({26,43,62,58,18,39,40,43,50},58))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({27,15,9,53,56,52,43,56},58), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({19,21,28,15,20,13,230,26,21,230,22,18,7,9,11,230,7},58) or _d({15,10,18,11},58)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({12,56,39,51,43},58))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({26,43,62,58,8,53,62},58))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({27,15,9,53,56,52,43,56},58), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({26,43,62,58,8,59,58,58,53,52},58))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({27,15,9,53,56,52,43,56},58), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({25,43,58,230,22,50,39,41,43,230,7,230,3,230,249,246,230,25,58,59,42,57,230,7,46,43,39,42},58), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({25,58,39,56,58,230,19,53,60,43,230,58,53,230,22,50,39,41,43,230,7},58), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({25,58,53,54,230,19,53,60,43,51,43,52,58},58), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({235,244,247,44},58), target.X)
inputY.Text = string.format(_d({235,244,247,44},58), target.Y)
inputZ.Text = string.format(_d({235,244,247,44},58), target.Z)
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
print(_d({33,25,39,44,43,20,39,60,47,45,39,58,53,56,230,11,52,45,47,52,43,35,230,18,53,39,42,43,42,230,61,47,58,46,230,25,39,44,43,230,22,50,39,63,43,56,13,59,47,230,15,52,58,43,56,44,39,41,43,244},58))
return SafeNavigator
end)()