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
local PathfindingService = game:GetService(_d({60,77,96,84,82,85,90,80,85,90,83,63,81,94,98,85,79,81},20))
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator = {
IsNavigating = false,
TargetPosition = nil,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({52,97,89,77,90,91,85,80},20), 5)
local rootPart = character:WaitForChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20), 5)
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
warn(_d({71,63,77,82,81,58,77,98,85,83,77,96,91,94,73,12,57,85,95,95,85,90,83,12,79,84,77,94,77,79,96,81,94,12,79,91,89,92,91,90,81,90,96,95,26},20))
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
if onComplete and type(onComplete) == _d({82,97,90,79,96,85,91,90},20) then
onComplete()
end
end)
end
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({63,77,82,81,58,77,98,85,83,77,96,91,94,65,53},20))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({63,79,94,81,81,90,51,97,85},20))
screenGui.Name = _d({63,77,82,81,58,77,98,85,83,77,96,91,94,65,53},20)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({50,94,77,89,81},20))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({65,53,47,91,94,90,81,94},20), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({65,53,63,96,94,91,87,81},20))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({64,81,100,96,56,77,78,81,88},20))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({63,77,82,81,12,58,77,98,85,83,77,96,85,91,90,12,56,77,78},20)
title.Parent = main
local closeBtn = Instance.new(_d({64,81,100,96,46,97,96,96,91,90},20))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({65,53,47,91,94,90,81,94},20), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({64,81,100,96,56,77,78,81,88},20))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({65,53,47,91,94,90,81,94},20), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({57,59,66,53,58,51,12,64,59,12,60,56,45,47,49,12,45},20) or _d({53,48,56,49},20)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({50,94,77,89,81},20))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({64,81,100,96,46,91,100},20))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({65,53,47,91,94,90,81,94},20), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({64,81,100,96,46,97,96,96,91,90},20))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({65,53,47,91,94,90,81,94},20), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({63,81,96,12,60,88,77,79,81,12,45,12,41,12,31,28,12,63,96,97,80,95,12,45,84,81,77,80},20), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({63,96,77,94,96,12,57,91,98,81,12,96,91,12,60,88,77,79,81,12,45},20), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({63,96,91,92,12,57,91,98,81,89,81,90,96},20), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({17,26,29,82},20), target.X)
inputY.Text = string.format(_d({17,26,29,82},20), target.Y)
inputZ.Text = string.format(_d({17,26,29,82},20), target.Z)
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
print(_d({71,63,77,82,81,58,77,98,85,83,77,96,91,94,12,49,90,83,85,90,81,73,12,56,91,77,80,81,80,12,99,85,96,84,12,63,77,82,81,12,60,88,77,101,81,94,51,97,85,12,53,90,96,81,94,82,77,79,81,26},20))
return SafeNavigator
end)()