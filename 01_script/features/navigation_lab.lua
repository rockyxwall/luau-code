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
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local RunService = game:GetService(_d({29,64,57,30,48,61,65,52,46,48},53))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({27,55,44,68,48,61,18,64,52},53), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({30,44,49,48,25,44,65,52,50,44,63,58,61,32,20},53))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({30,46,61,48,48,57,18,64,52},53))
screenGui.Name = _d({30,44,49,48,25,44,65,52,50,44,63,58,61,32,20},53)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({17,61,44,56,48},53))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({32,20,14,58,61,57,48,61},53), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({32,20,30,63,61,58,54,48},53))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({31,48,67,63,23,44,45,48,55},53))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({30,44,49,48,235,25,44,65,52,50,44,63,52,58,57,235,23,44,45},53)
title.Parent = main
local closeBtn = Instance.new(_d({31,48,67,63,13,64,63,63,58,57},53))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({32,20,14,58,61,57,48,61},53), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({31,48,67,63,23,44,45,48,55},53))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({32,20,14,58,61,57,48,61},53), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({24,26,33,20,25,18,235,31,26,235,27,23,12,14,16,235,12},53) or _d({20,15,23,16},53)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({17,61,44,56,48},53))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({31,48,67,63,13,58,67},53))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({32,20,14,58,61,57,48,61},53), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({31,48,67,63,13,64,63,63,58,57},53))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({32,20,14,58,61,57,48,61},53), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({30,48,63,235,27,55,44,46,48,235,12,235,8,235,254,251,235,30,63,64,47,62,235,12,51,48,44,47},53), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({30,63,44,61,63,235,24,58,65,48,235,63,58,235,27,55,44,46,48,235,12},53), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({30,63,58,59,235,24,58,65,48,56,48,57,63},53), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({240,249,252,49},53), target.X)
inputY.Text = string.format(_d({240,249,252,49},53), target.Y)
inputZ.Text = string.format(_d({240,249,252,49},53), target.Z)
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
print(_d({38,30,44,49,48,25,44,65,52,50,44,63,58,61,235,16,57,50,52,57,48,40,235,23,58,44,47,48,47,235,66,52,63,51,235,30,44,49,48,235,27,55,44,68,48,61,18,64,52,235,20,57,63,48,61,49,44,46,48,249},53))
return SafeNavigator
end)()