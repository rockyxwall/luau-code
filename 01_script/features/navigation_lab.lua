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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local RunService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({24,38,43,42,19,38,59,46,44,38,57,52,55,26,14},59))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({24,40,55,42,42,51,12,58,46},59))
screenGui.Name = _d({24,38,43,42,19,38,59,46,44,38,57,52,55,26,14},59)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({11,55,38,50,42},59))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({26,14,8,52,55,51,42,55},59), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({26,14,24,57,55,52,48,42},59))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({25,42,61,57,17,38,39,42,49},59))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({24,38,43,42,229,19,38,59,46,44,38,57,46,52,51,229,17,38,39},59)
title.Parent = main
local closeBtn = Instance.new(_d({25,42,61,57,7,58,57,57,52,51},59))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({26,14,8,52,55,51,42,55},59), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({25,42,61,57,17,38,39,42,49},59))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({26,14,8,52,55,51,42,55},59), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({18,20,27,14,19,12,229,25,20,229,21,17,6,8,10,229,6},59) or _d({14,9,17,10},59)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({11,55,38,50,42},59))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({25,42,61,57,7,52,61},59))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({26,14,8,52,55,51,42,55},59), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({25,42,61,57,7,58,57,57,52,51},59))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({26,14,8,52,55,51,42,55},59), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({24,42,57,229,21,49,38,40,42,229,6,229,2,229,248,245,229,24,57,58,41,56,229,6,45,42,38,41},59), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({24,57,38,55,57,229,18,52,59,42,229,57,52,229,21,49,38,40,42,229,6},59), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({24,57,52,53,229,18,52,59,42,50,42,51,57},59), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({234,243,246,43},59), target.X)
inputY.Text = string.format(_d({234,243,246,43},59), target.Y)
inputZ.Text = string.format(_d({234,243,246,43},59), target.Z)
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
print(_d({32,24,38,43,42,19,38,59,46,44,38,57,52,55,229,10,51,44,46,51,42,34,229,17,52,38,41,42,41,229,60,46,57,45,229,24,38,43,42,229,21,49,38,62,42,55,12,58,46,229,14,51,57,42,55,43,38,40,42,243},59))
return SafeNavigator
end)()