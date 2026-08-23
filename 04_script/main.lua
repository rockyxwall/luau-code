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
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local RunService = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local PathfindingService = game:GetService(_d({29,46,65,53,51,54,59,49,54,59,52,32,50,63,67,54,48,50},51))
local TweenService = game:GetService(_d({33,68,50,50,59,32,50,63,67,54,48,50},51))
local UserInputService = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
local LocalPlayer = Players.LocalPlayer
local PathRecorder = {
IsRecording = false,
IsReplaying = false,
RecordedPoints = {},
ReplayMode = _d({32,65,50,46,57,65,53},51),
RecordConnection = nil,
LastRecordTime = 0,
TotalRecordTime = 0,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({21,66,58,46,59,60,54,49},51), 5)
local rootPart = character:WaitForChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51), 5)
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
statusCallback(string.format(_d({14,57,54,52,59,54,59,52,237,65,60,237,64,65,46,63,65,237,245,242,251,254,51,58,237,46,68,46,70,246,251,251,251},51), dist))
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
if statusCallback then statusCallback(_d({27,60,237,63,50,48,60,63,49,50,49,237,61,46,65,53,237,46,67,46,54,57,46,47,57,50,238},51)) end
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
local modeText = reverse and _d({31,50,67,50,63,64,50,237,31,50,61,57,46,70},51) or _d({31,50,61,57,46,70},51)
statusCallback(string.format(_d({242,64,7,237,242,49,252,242,49,237,61,65,64},51), modeText, pointsProcessed, totalPoints))
end
if pt.Jump then
humanoid.Jump = true
end
if PathRecorder.ReplayMode == _d({32,65,50,46,57,65,53},51) then
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
statusCallback(_d({31,50,61,57,46,70,237,16,60,58,61,57,50,65,50,49,238},51))
end
end)
end
local function CreateUI()
local playerGui = LocalPlayer:WaitForChild(_d({29,57,46,70,50,63,20,66,54},51), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({29,46,65,53,31,50,48,60,63,49,50,63,20,66,54},51))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({32,48,63,50,50,59,20,66,54},51))
screenGui.Name = _d({29,46,65,53,31,50,48,60,63,49,50,63,20,66,54},51)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({19,63,46,58,50},51))
frame.Name = _d({26,46,54,59,19,63,46,58,50},51)
frame.Size = UDim2.new(0, 300, 0, 260)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({34,22,16,60,63,59,50,63},51))
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame
local uiStroke = Instance.new(_d({34,22,32,65,63,60,56,50},51))
uiStroke.Color = Color3.fromRGB(55, 62, 78)
uiStroke.Thickness = 1.5
uiStroke.Parent = frame
local title = Instance.new(_d({33,50,69,65,25,46,47,50,57},51))
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({175,103,110,237,32,65,50,46,57,65,53,237,29,46,65,53,237,31,50,48,60,63,49,50,63},51)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({33,50,69,65,25,46,47,50,57},51))
statusLabel.Name = _d({32,65,46,65,66,64,25,46,47,50,57},51)
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 40)
statusLabel.BackgroundColor3 = Color3.fromRGB(34, 38, 48)
statusLabel.BorderSizePixel = 0
statusLabel.Text = _d({32,65,46,65,66,64,7,237,22,49,57,50,237,73,237,253,237,29,60,54,59,65,64},51)
statusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 12
statusLabel.Parent = frame
local statusCorner = Instance.new(_d({34,22,16,60,63,59,50,63},51))
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusLabel
local modeBtn = Instance.new(_d({33,50,69,65,15,66,65,65,60,59},51))
modeBtn.Size = UDim2.new(1, -20, 0, 28)
modeBtn.Position = UDim2.new(0, 10, 0, 72)
modeBtn.BackgroundColor3 = Color3.fromRGB(42, 50, 65)
modeBtn.BorderSizePixel = 0
modeBtn.Text = _d({26,60,49,50,7,237,189,108,104,110,188,133,92,237,32,65,50,46,57,65,53,237,29,53,70,64,54,48,64,237,245,26,60,67,50,33,60,246},51)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
modeBtn.Font = Enum.Font.GothamSemibold
modeBtn.TextSize = 11
modeBtn.Parent = frame
local modeCorner = Instance.new(_d({34,22,16,60,63,59,50,63},51))
modeCorner.CornerRadius = UDim.new(0, 6)
modeCorner.Parent = modeBtn
modeBtn.MouseButton1Click:Connect(function()
if PathRecorder.ReplayMode == _d({32,65,50,46,57,65,53},51) then
PathRecorder.ReplayMode = _d({18,69,46,48,65},51)
modeBtn.Text = _d({26,60,49,50,7,237,189,108,91,124,237,18,69,46,48,65,237,16,19,63,46,58,50,237,22,59,65,50,63,61,60,57,46,65,54,60,59},51)
modeBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
else
PathRecorder.ReplayMode = _d({32,65,50,46,57,65,53},51)
modeBtn.Text = _d({26,60,49,50,7,237,189,108,104,110,188,133,92,237,32,65,50,46,57,65,53,237,29,53,70,64,54,48,64,237,245,26,60,67,50,33,60,246},51)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
end
end)
local function CreateButton(text, pos, bgColor, textColor)
local btn = Instance.new(_d({33,50,69,65,15,66,65,65,60,59},51))
btn.Size = UDim2.new(0.46, 0, 0, 34)
btn.Position = pos
btn.BackgroundColor3 = bgColor
btn.BorderSizePixel = 0
btn.Text = text
btn.TextColor3 = textColor
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.Parent = frame
local btnCorner = Instance.new(_d({34,22,16,60,63,59,50,63},51))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
return btn
end
local recBtn = CreateButton(_d({175,92,135,237,31,50,48,60,63,49},51), UDim2.new(0, 10, 0, 110), Color3.fromRGB(220, 50, 60), Color3.new(1,1,1))
local stopBtn = CreateButton(_d({175,92,134,237,32,65,60,61},51), UDim2.new(0.52, 0, 0, 110), Color3.fromRGB(80, 85, 95), Color3.new(1,1,1))
local playFwdBtn = CreateButton(_d({175,99,131,237,29,57,46,70,237,19,60,63,68,46,63,49},51), UDim2.new(0, 10, 0, 152), Color3.fromRGB(40, 160, 90), Color3.new(1,1,1))
local playRevBtn = CreateButton(_d({175,100,77,237,29,57,46,70,237,31,50,67,50,63,64,50},51), UDim2.new(0.52, 0, 0, 152), Color3.fromRGB(160, 100, 40), Color3.new(1,1,1))
local clearBtn = CreateButton(_d({189,108,100,94,237,16,57,50,46,63,237,29,46,65,53},51), UDim2.new(0, 10, 0, 194), Color3.fromRGB(50, 55, 65), Color3.fromRGB(200, 200, 200))
clearBtn.Size = UDim2.new(1, -20, 0, 30)
RunService.RenderStepped:Connect(function()
if PathRecorder.IsRecording then
statusLabel.Text = string.format(_d({189,108,97,129,237,31,50,48,60,63,49,54,59,52,7,237,242,49,237,61,65,64,237,245,242,251,254,51,64,246},51), #PathRecorder.RecordedPoints, PathRecorder.TotalRecordTime)
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
elseif not PathRecorder.IsReplaying then
statusLabel.Text = string.format(_d({32,65,46,65,66,64,7,237,22,49,57,50,237,73,237,242,49,237,29,60,54,59,65,64,237,32,46,67,50,49},51), #PathRecorder.RecordedPoints)
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
statusLabel.Text = _d({32,65,46,65,66,64,7,237,32,65,60,61,61,50,49},51)
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
statusLabel.Text = _d({32,65,46,65,66,64,7,237,29,46,65,53,237,16,57,50,46,63,50,49},51)
end)
end
CreateUI()
print(_d({40,32,65,50,46,57,65,53,29,46,65,53,31,50,48,60,63,49,50,63,42,237,25,60,46,49,50,49,237,64,66,48,48,50,64,64,51,66,57,57,70,251},51))
end)()