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
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local RunService = game:GetService(_d({59,94,87,60,78,91,95,82,76,78},23))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({57,85,74,98,78,91,48,94,82},23), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({60,74,79,78,55,74,95,82,80,74,93,88,91,62,50},23))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({60,76,91,78,78,87,48,94,82},23))
screenGui.Name = _d({60,74,79,78,55,74,95,82,80,74,93,88,91,62,50},23)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({47,91,74,86,78},23))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({62,50,44,88,91,87,78,91},23), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({62,50,60,93,91,88,84,78},23))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({61,78,97,93,53,74,75,78,85},23))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({60,74,79,78,9,55,74,95,82,80,74,93,82,88,87,9,53,74,75},23)
title.Parent = main
local closeBtn = Instance.new(_d({61,78,97,93,43,94,93,93,88,87},23))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({62,50,44,88,91,87,78,91},23), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({61,78,97,93,53,74,75,78,85},23))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({62,50,44,88,91,87,78,91},23), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({54,56,63,50,55,48,9,61,56,9,57,53,42,44,46,9,42},23) or _d({50,45,53,46},23)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({47,91,74,86,78},23))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({61,78,97,93,43,88,97},23))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({62,50,44,88,91,87,78,91},23), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({61,78,97,93,43,94,93,93,88,87},23))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({62,50,44,88,91,87,78,91},23), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({60,78,93,9,57,85,74,76,78,9,42,9,38,9,28,25,9,60,93,94,77,92,9,42,81,78,74,77},23), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({60,93,74,91,93,9,54,88,95,78,9,93,88,9,57,85,74,76,78,9,42},23), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({60,93,88,89,9,54,88,95,78,86,78,87,93},23), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({14,23,26,79},23), target.X)
inputY.Text = string.format(_d({14,23,26,79},23), target.Y)
inputZ.Text = string.format(_d({14,23,26,79},23), target.Z)
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
print(_d({68,60,74,79,78,55,74,95,82,80,74,93,88,91,9,46,87,80,82,87,78,70,9,53,88,74,77,78,77,9,96,82,93,81,9,60,74,79,78,9,57,85,74,98,78,91,48,94,82,9,50,87,93,78,91,79,74,76,78,23},23))
return SafeNavigator
end)()