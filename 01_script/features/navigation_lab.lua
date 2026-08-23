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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local RunService = game:GetService(_d({36,71,64,37,55,68,72,59,53,55},46))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator =
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({34,62,51,75,55,68,25,71,59},46), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({37,51,56,55,32,51,72,59,57,51,70,65,68,39,27},46))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({37,53,68,55,55,64,25,71,59},46))
screenGui.Name = _d({37,51,56,55,32,51,72,59,57,51,70,65,68,39,27},46)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({24,68,51,63,55},46))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({39,27,21,65,68,64,55,68},46), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({39,27,37,70,68,65,61,55},46))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({38,55,74,70,30,51,52,55,62},46))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({37,51,56,55,242,32,51,72,59,57,51,70,59,65,64,242,30,51,52},46)
title.Parent = main
local closeBtn = Instance.new(_d({38,55,74,70,20,71,70,70,65,64},46))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({39,27,21,65,68,64,55,68},46), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({38,55,74,70,30,51,52,55,62},46))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({39,27,21,65,68,64,55,68},46), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({31,33,40,27,32,25,242,38,33,242,34,30,19,21,23,242,19},46) or _d({27,22,30,23},46)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({24,68,51,63,55},46))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({38,55,74,70,20,65,74},46))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({39,27,21,65,68,64,55,68},46), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({38,55,74,70,20,71,70,70,65,64},46))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({39,27,21,65,68,64,55,68},46), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({37,55,70,242,34,62,51,53,55,242,19,242,15,242,5,2,242,37,70,71,54,69,242,19,58,55,51,54},46), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({37,70,51,68,70,242,31,65,72,55,242,70,65,242,34,62,51,53,55,242,19},46), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({37,70,65,66,242,31,65,72,55,63,55,64,70},46), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({247,0,3,56},46), target.X)
inputY.Text = string.format(_d({247,0,3,56},46), target.Y)
inputZ.Text = string.format(_d({247,0,3,56},46), target.Z)
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
print(_d({45,37,51,56,55,32,51,72,59,57,51,70,65,68,242,23,64,57,59,64,55,47,242,30,65,51,54,55,54,242,73,59,70,58,242,37,51,56,55,242,34,62,51,75,55,68,25,71,59,242,27,64,70,55,68,56,51,53,55,0},46))
return SafeNavigator
end)()