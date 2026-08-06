local _bxor = (bit32 and bit32.bxor) or function(a, b) return a ~ b end
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(_bxor(b[i], k))
end
return _concat(t)
end
local PathfindingService = game:GetService(_d({13,60,41,53,59,52,51,57,52,51,58,14,56,47,43,52,62,56},93))
local Players = game:GetService(_d({13,49,60,36,56,47,46},93))
local RunService = game:GetService(_d({15,40,51,14,56,47,43,52,62,56},93))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator = {
IsNavigating = false,
TargetPosition = nil,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({21,40,48,60,51,50,52,57},93), 5)
local rootPart = character:WaitForChild(_d({21,40,48,60,51,50,52,57,15,50,50,41,13,60,47,41},93), 5)
return character, humanoid, rootPart
end
function SafeNavigator.Stop()
SafeNavigator.IsNavigating = false
local _, humanoid, rootPart = GetCharacter()
if humanoid and rootPart then
humanoid:MoveTo(rootPart.Position)
end
end
function SafeNavigator.MoveTo(targetPosition, onComplete)
SafeNavigator.Stop()
task.wait(0.05)
local character, humanoid, rootPart = GetCharacter()
if not character or not humanoid or not rootPart then
warn(_d({6,14,60,59,56,19,60,43,52,58,60,41,50,47,0,125,16,52,46,46,52,51,58,125,62,53,60,47,60,62,41,56,47,125,62,50,48,45,50,51,56,51,41,46,115},93))
return
end
SafeNavigator.IsNavigating = true
SafeNavigator.TargetPosition = targetPosition
task.spawn(function()
local path = PathfindingService:CreatePath({
AgentRadius = 2.5,
AgentHeight = 5.0,
AgentCanJump = true,
})
local success, _ = pcall(function()
path:ComputeAsync(rootPart.Position, targetPosition)
end)
local waypoints = {}
if success and path.Status == Enum.PathStatus.Success then
waypoints = path:GetWaypoints()
else
table.insert(waypoints, {Position = targetPosition, Action = Enum.PathWaypointAction.Walk})
end
for idx, waypoint in ipairs(waypoints) do
if not SafeNavigator.IsNavigating or humanoid.Health <= 0 then
break
end
if waypoint.Action == Enum.PathWaypointAction.Jump then
humanoid.Jump = true
end
humanoid:MoveTo(waypoint.Position)
local timeOut = 12
local startTime = os.clock()
while SafeNavigator.IsNavigating do
local currentPos = rootPart.Position
local dist = (Vector3.new(currentPos.X, 0, currentPos.Z) - Vector3.new(waypoint.Position.X, 0, waypoint.Position.Z)).Magnitude
if dist <= 3.0 or (os.clock() - startTime) > timeOut then
break
end
task.wait(0.05)
end
if idx < #waypoints then
task.wait(math.random(15, 35) / 1000)
end
end
SafeNavigator.IsNavigating = false
if onComplete and type(onComplete) == _d({59,40,51,62,41,52,50,51},93) then
onComplete()
end
end)
end
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({13,49,60,36,56,47,26,40,52},93), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({14,60,59,56,19,60,43,52,58,60,41,50,47,8,20},93))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({14,62,47,56,56,51,26,40,52},93))
screenGui.Name = _d({14,60,59,56,19,60,43,52,58,60,41,50,47,8,20},93)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({27,47,60,48,56},93))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({8,20,30,50,47,51,56,47},93), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({8,20,14,41,47,50,54,56},93))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({9,56,37,41,17,60,63,56,49},93))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({14,60,59,56,125,19,60,43,52,58,60,41,52,50,51,125,17,60,63},93)
title.Parent = main
local closeBtn = Instance.new(_d({9,56,37,41,31,40,41,41,50,51},93))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({8,20,30,50,47,51,56,47},93), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({9,56,37,41,17,60,63,56,49},93))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({8,20,30,50,47,51,56,47},93), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({16,18,11,20,19,26,125,9,18,125,13,17,28,30,24,125,28},93) or _d({20,25,17,24},93)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({27,47,60,48,56},93))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({9,56,37,41,31,50,37},93))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({8,20,30,50,47,51,56,47},93), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({9,56,37,41,31,40,41,41,50,51},93))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({8,20,30,50,47,51,56,47},93), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({14,56,41,125,13,49,60,62,56,125,28,125,96,125,110,109,125,14,41,40,57,46,125,28,53,56,60,57},93), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({14,41,60,47,41,125,16,50,43,56,125,41,50,125,13,49,60,62,56,125,28},93), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({14,41,50,45,125,16,50,43,56,48,56,51,41},93), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({120,115,108,59},93), target.X)
inputY.Text = string.format(_d({120,115,108,59},93), target.Y)
inputZ.Text = string.format(_d({120,115,108,59},93), target.Z)
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
print(_d({6,14,60,59,56,19,60,43,52,58,60,41,50,47,125,24,51,58,52,51,56,0,125,17,50,60,57,56,57,125,42,52,41,53,125,14,60,59,56,125,13,49,60,36,56,47,26,40,52,125,20,51,41,56,47,59,60,62,56,115},93))
return SafeNavigator