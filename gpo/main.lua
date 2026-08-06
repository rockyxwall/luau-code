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
local PathfindingService = game:GetService(_d({110,95,74,86,88,87,80,90,87,80,89,109,91,76,72,87,93,91},62))
local Players = game:GetService(_d({110,82,95,71,91,76,77},62))
local RunService = game:GetService(_d({108,75,80,109,91,76,72,87,93,91},62))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator = {
IsNavigating = false,
TargetPosition = nil,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({118,75,83,95,80,81,87,90},62), 5)
local rootPart = character:WaitForChild(_d({118,75,83,95,80,81,87,90,108,81,81,74,110,95,76,74},62), 5)
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
warn(_d({101,109,95,88,91,112,95,72,87,89,95,74,81,76,99,30,115,87,77,77,87,80,89,30,93,86,95,76,95,93,74,91,76,30,93,81,83,78,81,80,91,80,74,77,16},62))
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
if onComplete and type(onComplete) == _d({88,75,80,93,74,87,81,80},62) then
onComplete()
end
end)
end
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({110,82,95,71,91,76,121,75,87},62), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({109,95,88,91,112,95,72,87,89,95,74,81,76,107,119},62))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({109,93,76,91,91,80,121,75,87},62))
screenGui.Name = _d({109,95,88,91,112,95,72,87,89,95,74,81,76,107,119},62)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({120,76,95,83,91},62))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({107,119,125,81,76,80,91,76},62), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({107,119,109,74,76,81,85,91},62))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({106,91,70,74,114,95,92,91,82},62))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({109,95,88,91,30,112,95,72,87,89,95,74,87,81,80,30,114,95,92},62)
title.Parent = main
local closeBtn = Instance.new(_d({106,91,70,74,124,75,74,74,81,80},62))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({107,119,125,81,76,80,91,76},62), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({106,91,70,74,114,95,92,91,82},62))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({107,119,125,81,76,80,91,76},62), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({115,113,104,119,112,121,30,106,113,30,110,114,127,125,123,30,127},62) or _d({119,122,114,123},62)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({120,76,95,83,91},62))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({106,91,70,74,124,81,70},62))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({107,119,125,81,76,80,91,76},62), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({106,91,70,74,124,75,74,74,81,80},62))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({107,119,125,81,76,80,91,76},62), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({109,91,74,30,110,82,95,93,91,30,127,30,3,30,13,14,30,109,74,75,90,77,30,127,86,91,95,90},62), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({109,74,95,76,74,30,115,81,72,91,30,74,81,30,110,82,95,93,91,30,127},62), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({109,74,81,78,30,115,81,72,91,83,91,80,74},62), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({27,16,15,88},62), target.X)
inputY.Text = string.format(_d({27,16,15,88},62), target.Y)
inputZ.Text = string.format(_d({27,16,15,88},62), target.Z)
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
print(_d({101,109,95,88,91,112,95,72,87,89,95,74,81,76,30,123,80,89,87,80,91,99,30,114,81,95,90,91,90,30,73,87,74,86,30,109,95,88,91,30,110,82,95,71,91,76,121,75,87,30,119,80,74,91,76,88,95,93,91,16},62))
return SafeNavigator