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
local Players = game:GetService(_d({51,79,68,92,72,85,86},29))
local RunService = game:GetService(_d({53,88,81,54,72,85,89,76,70,72},29))
local PathfindingService = game:GetService(_d({51,68,87,75,73,76,81,71,76,81,74,54,72,85,89,76,70,72},29))
local TweenService = game:GetService(_d({55,90,72,72,81,54,72,85,89,76,70,72},29))
local UserInputService = game:GetService(_d({56,86,72,85,44,81,83,88,87,54,72,85,89,76,70,72},29))
local LocalPlayer = Players.LocalPlayer
local PathRecorder = {
IsRecording = false,
IsReplaying = false,
RecordedPoints = {},
ReplayMode = _d({54,87,72,68,79,87,75},29),
RecordConnection = nil,
LastRecordTime = 0,
TotalRecordTime = 0,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({43,88,80,68,81,82,76,71},29), 5)
local rootPart = character:WaitForChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29), 5)
return character, humanoid, rootPart
end
function PathRecorder.StartRecording()
if PathRecorder.IsReplaying then return end
PathRecorder.RecordedPoints = {}
PathRecorder.IsRecording = true
PathRecorder.LastRecordTime = os.clock()
PathRecorder.TotalRecordTime = 0
local _, humanoid, rootPart = GetCharacter()
if not rootPart or not humanoid then return end
local lastPosition = rootPart.Position
PathRecorder.RecordConnection = RunService.Heartbeat:Connect(function()
if not PathRecorder.IsRecording then return end
local char, hum, root = GetCharacter()
if not root or not hum then return end
local currentTime = os.clock()
local dt = currentTime - PathRecorder.LastRecordTime
PathRecorder.LastRecordTime = currentTime
PathRecorder.TotalRecordTime = PathRecorder.TotalRecordTime + dt
local currentPos = root.Position
local distMoved = (currentPos - lastPosition).Magnitude
if distMoved > 0.15 or dt > 0.1 then
table.insert(PathRecorder.RecordedPoints, {
CFrame = root.CFrame,
Position = currentPos,
Jump = hum.Jump or (hum:GetState() == Enum.HumanoidStateType.Jumping),
DeltaTime = dt,
MoveDirection = hum.MoveDirection,
})
lastPosition = currentPos
end
end)
end
function PathRecorder.StopRecording()
PathRecorder.IsRecording = false
if PathRecorder.RecordConnection then
PathRecorder.RecordConnection:Disconnect()
PathRecorder.RecordConnection = nil
end
end
function PathRecorder.ClearData()
PathRecorder.StopRecording()
PathRecorder.StopReplay()
PathRecorder.RecordedPoints = {}
PathRecorder.TotalRecordTime = 0
end
local function AlignToStart(targetPos, statusCallback)
local _, humanoid, rootPart = GetCharacter()
if not rootPart or not humanoid then return false end
local dist = (rootPart.Position - targetPos).Magnitude
if dist <= 3.5 then
return true
end
if statusCallback then
statusCallback(string.format(_d({36,79,76,74,81,76,81,74,3,87,82,3,86,87,68,85,87,3,11,8,17,20,73,80,3,68,90,68,92,12,17,17,17},29), dist))
end
humanoid:MoveTo(targetPos)
local startTime = os.clock()
local timeout = math.clamp(dist / 10, 3, 15)
while PathRecorder.IsReplaying do
local cDist = (rootPart.Position - targetPos).Magnitude
if cDist <= 3.5 or (os.clock() - startTime) > timeout then
break
end
task.wait(0.05)
end
local endDist = (rootPart.Position - targetPos).Magnitude
if endDist > 3.5 and endDist < 25 then
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 0.5, 0))
end
return true
end
function PathRecorder.StopReplay()
PathRecorder.IsReplaying = false
local _, humanoid, rootPart = GetCharacter()
if humanoid and rootPart then
humanoid:MoveTo(rootPart.Position)
end
end
function PathRecorder.StartReplay(reverse, statusCallback)
if PathRecorder.IsRecording or #PathRecorder.RecordedPoints == 0 then
if statusCallback then statusCallback(_d({49,82,3,85,72,70,82,85,71,72,71,3,83,68,87,75,3,68,89,68,76,79,68,69,79,72,4},29)) end
return
end
PathRecorder.IsReplaying = true
local points = PathRecorder.RecordedPoints
local totalPoints = #points
local startIndex = reverse and totalPoints or 1
local endIndex = reverse and 1 or totalPoints
local stepDir = reverse and -1 or 1
local startPos = points[startIndex].Position
local aligned = AlignToStart(startPos, statusCallback)
if not aligned or not PathRecorder.IsReplaying then
PathRecorder.IsReplaying = false
return
end
task.spawn(function()
local _, humanoid, rootPart = GetCharacter()
local currentIndex = startIndex
local pointsProcessed = 0
while PathRecorder.IsReplaying do
if currentIndex < 1 or currentIndex > totalPoints or humanoid.Health <= 0 then
break
end
pointsProcessed = pointsProcessed + 1
local pt = points[currentIndex]
if statusCallback then
local modeText = reverse and _d({53,72,89,72,85,86,72,3,53,72,83,79,68,92},29) or _d({53,72,83,79,68,92},29)
statusCallback(string.format(_d({8,86,29,3,8,71,18,8,71,3,83,87,86},29), modeText, pointsProcessed, totalPoints))
end
if pt.Jump then
humanoid.Jump = true
end
if PathRecorder.ReplayMode == _d({54,87,72,68,79,87,75},29) then
humanoid:MoveTo(pt.Position)
local startTime = os.clock()
local timeOut = math.clamp(pt.DeltaTime * 2.5, 0.1, 1.5)
while PathRecorder.IsReplaying do
local dist = (Vector3.new(rootPart.Position.X, 0, rootPart.Position.Z) - Vector3.new(pt.Position.X, 0, pt.Position.Z)).Magnitude
if dist <= 2.5 or (os.clock() - startTime) > timeOut then
break
end
task.wait(0.03)
end
else
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.CFrame = pt.CFrame
task.wait(math.clamp(pt.DeltaTime, 0.03, 0.2))
end
currentIndex = currentIndex + stepDir
end
PathRecorder.IsReplaying = false
if statusCallback then
statusCallback(_d({53,72,83,79,68,92,3,38,82,80,83,79,72,87,72,71,4},29))
end
end)
end
local function CreateUI()
local playerGui = LocalPlayer:WaitForChild(_d({51,79,68,92,72,85,42,88,76},29), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({51,68,87,75,53,72,70,82,85,71,72,85,42,88,76},29))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({54,70,85,72,72,81,42,88,76},29))
screenGui.Name = _d({51,68,87,75,53,72,70,82,85,71,72,85,42,88,76},29)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({41,85,68,80,72},29))
frame.Name = _d({48,68,76,81,41,85,68,80,72},29)
frame.Size = UDim2.new(0, 300, 0, 260)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({56,44,38,82,85,81,72,85},29))
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame
local uiStroke = Instance.new(_d({56,44,54,87,85,82,78,72},29))
uiStroke.Color = Color3.fromRGB(55, 62, 78)
uiStroke.Thickness = 1.5
uiStroke.Parent = frame
local title = Instance.new(_d({55,72,91,87,47,68,69,72,79},29))
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({197,125,132,3,54,87,72,68,79,87,75,3,51,68,87,75,3,53,72,70,82,85,71,72,85},29)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({55,72,91,87,47,68,69,72,79},29))
statusLabel.Name = _d({54,87,68,87,88,86,47,68,69,72,79},29)
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 40)
statusLabel.BackgroundColor3 = Color3.fromRGB(34, 38, 48)
statusLabel.BorderSizePixel = 0
statusLabel.Text = _d({54,87,68,87,88,86,29,3,44,71,79,72,3,95,3,19,3,51,82,76,81,87,86},29)
statusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 12
statusLabel.Parent = frame
local statusCorner = Instance.new(_d({56,44,38,82,85,81,72,85},29))
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusLabel
local modeBtn = Instance.new(_d({55,72,91,87,37,88,87,87,82,81},29))
modeBtn.Size = UDim2.new(1, -20, 0, 28)
modeBtn.Position = UDim2.new(0, 10, 0, 72)
modeBtn.BackgroundColor3 = Color3.fromRGB(42, 50, 65)
modeBtn.BorderSizePixel = 0
modeBtn.Text = _d({48,82,71,72,29,3,211,130,126,132,210,155,114,3,54,87,72,68,79,87,75,3,51,75,92,86,76,70,86,3,11,48,82,89,72,55,82,12},29)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
modeBtn.Font = Enum.Font.GothamSemibold
modeBtn.TextSize = 11
modeBtn.Parent = frame
local modeCorner = Instance.new(_d({56,44,38,82,85,81,72,85},29))
modeCorner.CornerRadius = UDim.new(0, 6)
modeCorner.Parent = modeBtn
modeBtn.MouseButton1Click:Connect(function()
if PathRecorder.ReplayMode == _d({54,87,72,68,79,87,75},29) then
PathRecorder.ReplayMode = _d({40,91,68,70,87},29)
modeBtn.Text = _d({48,82,71,72,29,3,211,130,113,146,3,40,91,68,70,87,3,38,41,85,68,80,72,3,44,81,87,72,85,83,82,79,68,87,76,82,81},29)
modeBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
else
PathRecorder.ReplayMode = _d({54,87,72,68,79,87,75},29)
modeBtn.Text = _d({48,82,71,72,29,3,211,130,126,132,210,155,114,3,54,87,72,68,79,87,75,3,51,75,92,86,76,70,86,3,11,48,82,89,72,55,82,12},29)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
end
end)
local function CreateButton(text, pos, bgColor, textColor)
local btn = Instance.new(_d({55,72,91,87,37,88,87,87,82,81},29))
btn.Size = UDim2.new(0.46, 0, 0, 34)
btn.Position = pos
btn.BackgroundColor3 = bgColor
btn.BorderSizePixel = 0
btn.Text = text
btn.TextColor3 = textColor
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.Parent = frame
local btnCorner = Instance.new(_d({56,44,38,82,85,81,72,85},29))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
return btn
end
local recBtn = CreateButton(_d({197,114,157,3,53,72,70,82,85,71},29), UDim2.new(0, 10, 0, 110), Color3.fromRGB(220, 50, 60), Color3.new(1,1,1))
local stopBtn = CreateButton(_d({197,114,156,3,54,87,82,83},29), UDim2.new(0.52, 0, 0, 110), Color3.fromRGB(80, 85, 95), Color3.new(1,1,1))
local playFwdBtn = CreateButton(_d({197,121,153,3,51,79,68,92,3,41,82,85,90,68,85,71},29), UDim2.new(0, 10, 0, 152), Color3.fromRGB(40, 160, 90), Color3.new(1,1,1))
local playRevBtn = CreateButton(_d({197,122,99,3,51,79,68,92,3,53,72,89,72,85,86,72},29), UDim2.new(0.52, 0, 0, 152), Color3.fromRGB(160, 100, 40), Color3.new(1,1,1))
local clearBtn = CreateButton(_d({211,130,122,116,3,38,79,72,68,85,3,51,68,87,75},29), UDim2.new(0, 10, 0, 194), Color3.fromRGB(50, 55, 65), Color3.fromRGB(200, 200, 200))
clearBtn.Size = UDim2.new(1, -20, 0, 30)
RunService.RenderStepped:Connect(function()
if PathRecorder.IsRecording then
statusLabel.Text = string.format(_d({211,130,119,151,3,53,72,70,82,85,71,76,81,74,29,3,8,71,3,83,87,86,3,11,8,17,20,73,86,12},29), #PathRecorder.RecordedPoints, PathRecorder.TotalRecordTime)
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
elseif not PathRecorder.IsReplaying then
statusLabel.Text = string.format(_d({54,87,68,87,88,86,29,3,44,71,79,72,3,95,3,8,71,3,51,82,76,81,87,86,3,54,68,89,72,71},29), #PathRecorder.RecordedPoints)
statusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
end
end)
recBtn.MouseButton1Click:Connect(function()
if PathRecorder.IsRecording then
PathRecorder.StopRecording()
else
PathRecorder.StartRecording()
end
end)
stopBtn.MouseButton1Click:Connect(function()
PathRecorder.StopRecording()
PathRecorder.StopReplay()
statusLabel.Text = _d({54,87,68,87,88,86,29,3,54,87,82,83,83,72,71},29)
end)
playFwdBtn.MouseButton1Click:Connect(function()
PathRecorder.StartReplay(false, function(msg)
statusLabel.Text = msg
end)
end)
playRevBtn.MouseButton1Click:Connect(function()
PathRecorder.StartReplay(true, function(msg)
statusLabel.Text = msg
end)
end)
clearBtn.MouseButton1Click:Connect(function()
PathRecorder.ClearData()
statusLabel.Text = _d({54,87,68,87,88,86,29,3,51,68,87,75,3,38,79,72,68,85,72,71},29)
end)
end
CreateUI()
print(_d({62,54,87,72,68,79,87,75,51,68,87,75,53,72,70,82,85,71,72,85,64,3,47,82,68,71,72,71,3,86,88,70,70,72,86,86,73,88,79,79,92,17},29))
end)()