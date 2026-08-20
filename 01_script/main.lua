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
local PathfindingService = game:GetService(_d({63,80,99,87,85,88,93,83,88,93,86,66,84,97,101,88,82,84},17))
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
local RunService = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator = {
IsNavigating = false,
TargetPosition = nil,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({55,100,92,80,93,94,88,83},17), 5)
local rootPart = character:WaitForChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17), 5)
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
warn(_d({74,66,80,85,84,61,80,101,88,86,80,99,94,97,76,15,60,88,98,98,88,93,86,15,82,87,80,97,80,82,99,84,97,15,82,94,92,95,94,93,84,93,99,98,29},17))
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
if onComplete and type(onComplete) == _d({85,100,93,82,99,88,94,93},17) then
onComplete()
end
end)
end
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({63,91,80,104,84,97,54,100,88},17), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({66,80,85,84,61,80,101,88,86,80,99,94,97,68,56},17))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({66,82,97,84,84,93,54,100,88},17))
screenGui.Name = _d({66,80,85,84,61,80,101,88,86,80,99,94,97,68,56},17)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({53,97,80,92,84},17))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({68,56,50,94,97,93,84,97},17), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({68,56,66,99,97,94,90,84},17))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({67,84,103,99,59,80,81,84,91},17))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({66,80,85,84,15,61,80,101,88,86,80,99,88,94,93,15,59,80,81},17)
title.Parent = main
local closeBtn = Instance.new(_d({67,84,103,99,49,100,99,99,94,93},17))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({68,56,50,94,97,93,84,97},17), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({67,84,103,99,59,80,81,84,91},17))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({68,56,50,94,97,93,84,97},17), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({60,62,69,56,61,54,15,67,62,15,63,59,48,50,52,15,48},17) or _d({56,51,59,52},17)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({53,97,80,92,84},17))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({67,84,103,99,49,94,103},17))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({68,56,50,94,97,93,84,97},17), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({67,84,103,99,49,100,99,99,94,93},17))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({68,56,50,94,97,93,84,97},17), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({66,84,99,15,63,91,80,82,84,15,48,15,44,15,34,31,15,66,99,100,83,98,15,48,87,84,80,83},17), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({66,99,80,97,99,15,60,94,101,84,15,99,94,15,63,91,80,82,84,15,48},17), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({66,99,94,95,15,60,94,101,84,92,84,93,99},17), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({20,29,32,85},17), target.X)
inputY.Text = string.format(_d({20,29,32,85},17), target.Y)
inputZ.Text = string.format(_d({20,29,32,85},17), target.Z)
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
print(_d({74,66,80,85,84,61,80,101,88,86,80,99,94,97,15,52,93,86,88,93,84,76,15,59,94,80,83,84,83,15,102,88,99,87,15,66,80,85,84,15,63,91,80,104,84,97,54,100,88,15,56,93,99,84,97,85,80,82,84,29},17))
return SafeNavigator
end)()