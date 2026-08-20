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
local PathfindingService = game:GetService(_d({49,66,85,73,71,74,79,69,74,79,72,52,70,83,87,74,68,70},31))
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local RunService = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator = {
IsNavigating = false,
TargetPosition = nil,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({41,86,78,66,79,80,74,69},31), 5)
local rootPart = character:WaitForChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31), 5)
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
warn(_d({60,52,66,71,70,47,66,87,74,72,66,85,80,83,62,1,46,74,84,84,74,79,72,1,68,73,66,83,66,68,85,70,83,1,68,80,78,81,80,79,70,79,85,84,15},31))
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
if onComplete and type(onComplete) == _d({71,86,79,68,85,74,80,79},31) then
onComplete()
end
end)
end
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({49,77,66,90,70,83,40,86,74},31), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({52,66,71,70,47,66,87,74,72,66,85,80,83,54,42},31))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({52,68,83,70,70,79,40,86,74},31))
screenGui.Name = _d({52,66,71,70,47,66,87,74,72,66,85,80,83,54,42},31)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({39,83,66,78,70},31))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({54,42,36,80,83,79,70,83},31), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({54,42,52,85,83,80,76,70},31))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({53,70,89,85,45,66,67,70,77},31))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({52,66,71,70,1,47,66,87,74,72,66,85,74,80,79,1,45,66,67},31)
title.Parent = main
local closeBtn = Instance.new(_d({53,70,89,85,35,86,85,85,80,79},31))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({54,42,36,80,83,79,70,83},31), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({53,70,89,85,45,66,67,70,77},31))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({54,42,36,80,83,79,70,83},31), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({46,48,55,42,47,40,1,53,48,1,49,45,34,36,38,1,34},31) or _d({42,37,45,38},31)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({39,83,66,78,70},31))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({53,70,89,85,35,80,89},31))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({54,42,36,80,83,79,70,83},31), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({53,70,89,85,35,86,85,85,80,79},31))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({54,42,36,80,83,79,70,83},31), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({52,70,85,1,49,77,66,68,70,1,34,1,30,1,20,17,1,52,85,86,69,84,1,34,73,70,66,69},31), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({52,85,66,83,85,1,46,80,87,70,1,85,80,1,49,77,66,68,70,1,34},31), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({52,85,80,81,1,46,80,87,70,78,70,79,85},31), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({6,15,18,71},31), target.X)
inputY.Text = string.format(_d({6,15,18,71},31), target.Y)
inputZ.Text = string.format(_d({6,15,18,71},31), target.Z)
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
print(_d({60,52,66,71,70,47,66,87,74,72,66,85,80,83,1,38,79,72,74,79,70,62,1,45,80,66,69,70,69,1,88,74,85,73,1,52,66,71,70,1,49,77,66,90,70,83,40,86,74,1,42,79,85,70,83,71,66,68,70,15},31))
return SafeNavigator
end)()