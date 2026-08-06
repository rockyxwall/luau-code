local _bit = bit32 or {bxor = function(a,b) return a ~ b end}
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(_bit.bxor(b[i], k))
end
return _concat(t)
end
local PathfindingService = game:GetService(_d({134,183,162,190,176,191,184,178,191,184,177,133,179,164,160,191,181,179},214))
local Players = game:GetService(_d({134,186,183,175,179,164,165},214))
local RunService = game:GetService(_d({132,163,184,133,179,164,160,191,181,179},214))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator = {
IsNavigating = false,
TargetPosition = nil,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({158,163,187,183,184,185,191,178},214), 5)
local rootPart = character:WaitForChild(_d({158,163,187,183,184,185,191,178,132,185,185,162,134,183,164,162},214), 5)
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
warn(_d({141,133,183,176,179,152,183,160,191,177,183,162,185,164,139,246,155,191,165,165,191,184,177,246,181,190,183,164,183,181,162,179,164,246,181,185,187,166,185,184,179,184,162,165,248},214))
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
if onComplete and type(onComplete) == _d({176,163,184,181,162,191,185,184},214) then
onComplete()
end
end)
end
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({134,186,183,175,179,164,145,163,191},214), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({133,183,176,179,152,183,160,191,177,183,162,185,164,131,159},214))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({133,181,164,179,179,184,145,163,191},214))
screenGui.Name = _d({133,183,176,179,152,183,160,191,177,183,162,185,164,131,159},214)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({144,164,183,187,179},214))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({131,159,149,185,164,184,179,164},214), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({131,159,133,162,164,185,189,179},214))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({130,179,174,162,154,183,180,179,186},214))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({133,183,176,179,246,152,183,160,191,177,183,162,191,185,184,246,154,183,180},214)
title.Parent = main
local closeBtn = Instance.new(_d({130,179,174,162,148,163,162,162,185,184},214))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({131,159,149,185,164,184,179,164},214), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({130,179,174,162,154,183,180,179,186},214))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({131,159,149,185,164,184,179,164},214), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({155,153,128,159,152,145,246,130,153,246,134,154,151,149,147,246,151},214) or _d({159,146,154,147},214)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({144,164,183,187,179},214))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({130,179,174,162,148,185,174},214))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({131,159,149,185,164,184,179,164},214), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({130,179,174,162,148,163,162,162,185,184},214))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({131,159,149,185,164,184,179,164},214), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({133,179,162,246,134,186,183,181,179,246,151,246,235,246,229,230,246,133,162,163,178,165,246,151,190,179,183,178},214), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({133,162,183,164,162,246,155,185,160,179,246,162,185,246,134,186,183,181,179,246,151},214), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({133,162,185,166,246,155,185,160,179,187,179,184,162},214), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({243,248,231,176},214), target.X)
inputY.Text = string.format(_d({243,248,231,176},214), target.Y)
inputZ.Text = string.format(_d({243,248,231,176},214), target.Z)
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
print(_d({141,133,183,176,179,152,183,160,191,177,183,162,185,164,246,147,184,177,191,184,179,139,246,154,185,183,178,179,178,246,161,191,162,190,246,133,183,176,179,246,134,186,183,175,179,164,145,163,191,246,159,184,162,179,164,176,183,181,179,248},214))
return SafeNavigator