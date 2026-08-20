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
local PathfindingService = game:GetService(_d({43,60,79,67,65,68,73,63,68,73,66,46,64,77,81,68,62,64},37))
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator = {
IsNavigating = false,
TargetPosition = nil,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({35,80,72,60,73,74,68,63},37), 5)
local rootPart = character:WaitForChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37), 5)
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
warn(_d({54,46,60,65,64,41,60,81,68,66,60,79,74,77,56,251,40,68,78,78,68,73,66,251,62,67,60,77,60,62,79,64,77,251,62,74,72,75,74,73,64,73,79,78,9},37))
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
if onComplete and type(onComplete) == _d({65,80,73,62,79,68,74,73},37) then
onComplete()
end
end)
end
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({43,71,60,84,64,77,34,80,68},37), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({46,60,65,64,41,60,81,68,66,60,79,74,77,48,36},37))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({46,62,77,64,64,73,34,80,68},37))
screenGui.Name = _d({46,60,65,64,41,60,81,68,66,60,79,74,77,48,36},37)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({33,77,60,72,64},37))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({48,36,30,74,77,73,64,77},37), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({48,36,46,79,77,74,70,64},37))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({47,64,83,79,39,60,61,64,71},37))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({46,60,65,64,251,41,60,81,68,66,60,79,68,74,73,251,39,60,61},37)
title.Parent = main
local closeBtn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({48,36,30,74,77,73,64,77},37), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({47,64,83,79,39,60,61,64,71},37))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({48,36,30,74,77,73,64,77},37), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({40,42,49,36,41,34,251,47,42,251,43,39,28,30,32,251,28},37) or _d({36,31,39,32},37)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({33,77,60,72,64},37))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({47,64,83,79,29,74,83},37))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({48,36,30,74,77,73,64,77},37), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({48,36,30,74,77,73,64,77},37), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({46,64,79,251,43,71,60,62,64,251,28,251,24,251,14,11,251,46,79,80,63,78,251,28,67,64,60,63},37), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({46,79,60,77,79,251,40,74,81,64,251,79,74,251,43,71,60,62,64,251,28},37), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({46,79,74,75,251,40,74,81,64,72,64,73,79},37), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({0,9,12,65},37), target.X)
inputY.Text = string.format(_d({0,9,12,65},37), target.Y)
inputZ.Text = string.format(_d({0,9,12,65},37), target.Z)
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
print(_d({54,46,60,65,64,41,60,81,68,66,60,79,74,77,251,32,73,66,68,73,64,56,251,39,74,60,63,64,63,251,82,68,79,67,251,46,60,65,64,251,43,71,60,84,64,77,34,80,68,251,36,73,79,64,77,65,60,62,64,9},37))
return SafeNavigator
end)()