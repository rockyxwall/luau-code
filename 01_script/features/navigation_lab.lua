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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local RunService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({47,61,66,65,42,61,82,69,67,61,80,75,78,49,37},36))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({47,63,78,65,65,74,35,81,69},36))
screenGui.Name = _d({47,61,66,65,42,61,82,69,67,61,80,75,78,49,37},36)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({34,78,61,73,65},36))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({49,37,31,75,78,74,65,78},36), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({49,37,47,80,78,75,71,65},36))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({48,65,84,80,40,61,62,65,72},36))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({47,61,66,65,252,42,61,82,69,67,61,80,69,75,74,252,40,61,62},36)
title.Parent = main
local closeBtn = Instance.new(_d({48,65,84,80,30,81,80,80,75,74},36))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({49,37,31,75,78,74,65,78},36), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({48,65,84,80,40,61,62,65,72},36))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({49,37,31,75,78,74,65,78},36), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({41,43,50,37,42,35,252,48,43,252,44,40,29,31,33,252,29},36) or _d({37,32,40,33},36)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({34,78,61,73,65},36))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({48,65,84,80,30,75,84},36))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({49,37,31,75,78,74,65,78},36), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({48,65,84,80,30,81,80,80,75,74},36))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({49,37,31,75,78,74,65,78},36), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({47,65,80,252,44,72,61,63,65,252,29,252,25,252,15,12,252,47,80,81,64,79,252,29,68,65,61,64},36), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({47,80,61,78,80,252,41,75,82,65,252,80,75,252,44,72,61,63,65,252,29},36), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({47,80,75,76,252,41,75,82,65,73,65,74,80},36), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({1,10,13,66},36), target.X)
inputY.Text = string.format(_d({1,10,13,66},36), target.Y)
inputZ.Text = string.format(_d({1,10,13,66},36), target.Z)
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
print(_d({55,47,61,66,65,42,61,82,69,67,61,80,75,78,252,33,74,67,69,74,65,57,252,40,75,61,64,65,64,252,83,69,80,68,252,47,61,66,65,252,44,72,61,85,65,78,35,81,69,252,37,74,80,65,78,66,61,63,65,10},36))
return SafeNavigator
end)()