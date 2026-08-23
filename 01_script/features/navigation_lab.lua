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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local RunService = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({35,63,52,76,56,69,26,72,60},45), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({38,52,57,56,33,52,73,60,58,52,71,66,69,40,28},45))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({38,54,69,56,56,65,26,72,60},45))
screenGui.Name = _d({38,52,57,56,33,52,73,60,58,52,71,66,69,40,28},45)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({25,69,52,64,56},45))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({40,28,22,66,69,65,56,69},45), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({40,28,38,71,69,66,62,56},45))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({39,56,75,71,31,52,53,56,63},45))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({38,52,57,56,243,33,52,73,60,58,52,71,60,66,65,243,31,52,53},45)
title.Parent = main
local closeBtn = Instance.new(_d({39,56,75,71,21,72,71,71,66,65},45))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({40,28,22,66,69,65,56,69},45), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({39,56,75,71,31,52,53,56,63},45))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({40,28,22,66,69,65,56,69},45), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({32,34,41,28,33,26,243,39,34,243,35,31,20,22,24,243,20},45) or _d({28,23,31,24},45)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({25,69,52,64,56},45))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({39,56,75,71,21,66,75},45))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({40,28,22,66,69,65,56,69},45), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({39,56,75,71,21,72,71,71,66,65},45))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({40,28,22,66,69,65,56,69},45), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({38,56,71,243,35,63,52,54,56,243,20,243,16,243,6,3,243,38,71,72,55,70,243,20,59,56,52,55},45), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({38,71,52,69,71,243,32,66,73,56,243,71,66,243,35,63,52,54,56,243,20},45), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({38,71,66,67,243,32,66,73,56,64,56,65,71},45), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({248,1,4,57},45), target.X)
inputY.Text = string.format(_d({248,1,4,57},45), target.Y)
inputZ.Text = string.format(_d({248,1,4,57},45), target.Z)
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
print(_d({46,38,52,57,56,33,52,73,60,58,52,71,66,69,243,24,65,58,60,65,56,48,243,31,66,52,55,56,55,243,74,60,71,59,243,38,52,57,56,243,35,63,52,76,56,69,26,72,60,243,28,65,71,56,69,57,52,54,56,1},45))
return SafeNavigator
end)()