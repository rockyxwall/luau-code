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
local PathfindingService = game:GetService(_d({144,161,180,168,166,169,174,164,169,174,167,147,165,178,182,169,163,165},192))
local Players = game:GetService(_d({144,172,161,185,165,178,179},192))
local RunService = game:GetService(_d({146,181,174,147,165,178,182,169,163,165},192))
local LocalPlayer = Players.LocalPlayer
local SafeNavigator = {
IsNavigating = false,
TargetPosition = nil,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({136,181,173,161,174,175,169,164},192), 5)
local rootPart = character:WaitForChild(_d({136,181,173,161,174,175,169,164,146,175,175,180,144,161,178,180},192), 5)
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
warn(_d({155,147,161,166,165,142,161,182,169,167,161,180,175,178,157,224,141,169,179,179,169,174,167,224,163,168,161,178,161,163,180,165,178,224,163,175,173,176,175,174,165,174,180,179,238},192))
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
if onComplete and type(onComplete) == _d({166,181,174,163,180,169,175,174},192) then
onComplete()
end
end)
end
local function CreateSafeUI()
local playerGui = LocalPlayer:WaitForChild(_d({144,172,161,185,165,178,135,181,169},192), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({147,161,166,165,142,161,182,169,167,161,180,175,178,149,137},192))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({147,163,178,165,165,174,135,181,169},192))
screenGui.Name = _d({147,161,166,165,142,161,182,169,167,161,180,175,178,149,137},192)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({134,178,161,173,165},192))
main.Size = UDim2.new(0, 320, 0, 290)
main.Position = UDim2.new(0.05, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new(_d({149,137,131,175,178,174,165,178},192), main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new(_d({149,137,147,180,178,175,171,165},192))
stroke.Color = Color3.fromRGB(60, 65, 80)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({148,165,184,180,140,161,162,165,172},192))
title.Size = UDim2.new(1, -30, 0, 36)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({147,161,166,165,224,142,161,182,169,167,161,180,169,175,174,224,140,161,162},192)
title.Parent = main
local closeBtn = Instance.new(_d({148,165,184,180,130,181,180,180,175,174},192))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({149,137,131,175,178,174,165,178},192), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local telemetry = Instance.new(_d({148,165,184,180,140,161,162,165,172},192))
telemetry.Size = UDim2.new(1, -24, 0, 42)
telemetry.Position = UDim2.new(0, 12, 0, 40)
telemetry.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
telemetry.Font = Enum.Font.Code
telemetry.TextSize = 11
telemetry.TextColor3 = Color3.fromRGB(100, 220, 150)
telemetry.TextXAlignment = Enum.TextXAlignment.Left
telemetry.Text = " Pos: X: 0 | Y: 0 | Z: 0\n Status: IDLE"
telemetry.Parent = main
Instance.new(_d({149,137,131,175,178,174,165,178},192), telemetry).CornerRadius = UDim.new(0, 6)
RunService.RenderStepped:Connect(function()
local _, _, root = GetCharacter()
if root then
local p = root.Position
local statusStr = SafeNavigator.IsNavigating and _d({141,143,150,137,142,135,224,148,143,224,144,140,129,131,133,224,129},192) or _d({137,132,140,133},192)
telemetry.Text = string.format(" Pos: X: %.1f | Y: %.1f | Z: %.1f\n Status: %s", p.X, p.Y, p.Z, statusStr)
end
end)
local inputContainer = Instance.new(_d({134,178,161,173,165},192))
inputContainer.Size = UDim2.new(1, -24, 0, 32)
inputContainer.Position = UDim2.new(0, 12, 0, 92)
inputContainer.BackgroundTransparency = 1
inputContainer.Parent = main
local function MakeBox(placeholder, xScale)
local box = Instance.new(_d({148,165,184,180,130,175,184},192))
box.Size = UDim2.new(0.31, 0, 1, 0)
box.Position = UDim2.new(xScale, 0, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(36, 40, 50)
box.Font = Enum.Font.Code
box.TextSize = 11
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Text = ""
box.Parent = inputContainer
Instance.new(_d({149,137,131,175,178,174,165,178},192), box).CornerRadius = UDim.new(0, 5)
return box
end
local inputX = MakeBox("X", 0)
local inputY = MakeBox("Y", 0.345)
local inputZ = MakeBox("Z", 0.69)
local function MakeBtn(text, color, yPos)
local btn = Instance.new(_d({148,165,184,180,130,181,180,180,175,174},192))
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = color
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = main
Instance.new(_d({149,137,131,175,178,174,165,178},192), btn).CornerRadius = UDim.new(0, 6)
return btn
end
local btnSetAhead = MakeBtn(_d({147,165,180,224,144,172,161,163,165,224,129,224,253,224,243,240,224,147,180,181,164,179,224,129,168,165,161,164},192), Color3.fromRGB(45, 85, 140), 132)
local btnStart = MakeBtn(_d({147,180,161,178,180,224,141,175,182,165,224,180,175,224,144,172,161,163,165,224,129},192), Color3.fromRGB(40, 140, 80), 174)
local btnStop = MakeBtn(_d({147,180,175,176,224,141,175,182,165,173,165,174,180},192), Color3.fromRGB(160, 50, 50), 216)
btnSetAhead.MouseButton1Click:Connect(function()
local _, _, root = GetCharacter()
if root then
local target = root.Position + (root.CFrame.LookVector * 30)
inputX.Text = string.format(_d({229,238,241,166},192), target.X)
inputY.Text = string.format(_d({229,238,241,166},192), target.Y)
inputZ.Text = string.format(_d({229,238,241,166},192), target.Z)
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
print(_d({155,147,161,166,165,142,161,182,169,167,161,180,175,178,224,133,174,167,169,174,165,157,224,140,175,161,164,165,164,224,183,169,180,168,224,147,161,166,165,224,144,172,161,185,165,178,135,181,169,224,137,174,180,165,178,166,161,163,165,238},192))
return SafeNavigator