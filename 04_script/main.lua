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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local PathfindingService = game:GetService(_d({54,71,90,78,76,79,84,74,79,84,77,57,75,88,92,79,73,75},26))
local TweenService = game:GetService(_d({58,93,75,75,84,57,75,88,92,79,73,75},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
local LocalPlayer = Players.LocalPlayer
local PathRecorder = {
IsRecording = false,
IsReplaying = false,
RecordedPoints = {},
ReplayMode = _d({57,90,75,71,82,90,78},26),
RecordConnection = nil,
LastRecordTime = 0,
TotalRecordTime = 0,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({46,91,83,71,84,85,79,74},26), 5)
local rootPart = character:WaitForChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26), 5)
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
statusCallback(string.format(_d({39,82,79,77,84,79,84,77,6,90,85,6,89,90,71,88,90,6,14,11,20,23,76,83,6,71,93,71,95,15,20,20,20},26), dist))
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
if statusCallback then statusCallback(_d({52,85,6,88,75,73,85,88,74,75,74,6,86,71,90,78,6,71,92,71,79,82,71,72,82,75,7},26)) end
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
local modeText = reverse and _d({56,75,92,75,88,89,75,6,56,75,86,82,71,95},26) or _d({56,75,86,82,71,95},26)
statusCallback(string.format(_d({11,89,32,6,11,74,21,11,74,6,86,90,89},26), modeText, pointsProcessed, totalPoints))
end
if pt.Jump then
humanoid.Jump = true
end
if PathRecorder.ReplayMode == _d({57,90,75,71,82,90,78},26) then
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
statusCallback(_d({56,75,86,82,71,95,6,41,85,83,86,82,75,90,75,74,7},26))
end
end)
end
local function CreateUI()
local playerGui = LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({54,71,90,78,56,75,73,85,88,74,75,88,45,91,79},26))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({57,73,88,75,75,84,45,91,79},26))
screenGui.Name = _d({54,71,90,78,56,75,73,85,88,74,75,88,45,91,79},26)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({44,88,71,83,75},26))
frame.Name = _d({51,71,79,84,44,88,71,83,75},26)
frame.Size = UDim2.new(0, 300, 0, 260)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({59,47,41,85,88,84,75,88},26))
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame
local uiStroke = Instance.new(_d({59,47,57,90,88,85,81,75},26))
uiStroke.Color = Color3.fromRGB(55, 62, 78)
uiStroke.Thickness = 1.5
uiStroke.Parent = frame
local title = Instance.new(_d({58,75,94,90,50,71,72,75,82},26))
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({200,128,135,6,57,90,75,71,82,90,78,6,54,71,90,78,6,56,75,73,85,88,74,75,88},26)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({58,75,94,90,50,71,72,75,82},26))
statusLabel.Name = _d({57,90,71,90,91,89,50,71,72,75,82},26)
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 40)
statusLabel.BackgroundColor3 = Color3.fromRGB(34, 38, 48)
statusLabel.BorderSizePixel = 0
statusLabel.Text = _d({57,90,71,90,91,89,32,6,47,74,82,75,6,98,6,22,6,54,85,79,84,90,89},26)
statusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 12
statusLabel.Parent = frame
local statusCorner = Instance.new(_d({59,47,41,85,88,84,75,88},26))
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusLabel
local modeBtn = Instance.new(_d({58,75,94,90,40,91,90,90,85,84},26))
modeBtn.Size = UDim2.new(1, -20, 0, 28)
modeBtn.Position = UDim2.new(0, 10, 0, 72)
modeBtn.BackgroundColor3 = Color3.fromRGB(42, 50, 65)
modeBtn.BorderSizePixel = 0
modeBtn.Text = _d({51,85,74,75,32,6,214,133,129,135,213,158,117,6,57,90,75,71,82,90,78,6,54,78,95,89,79,73,89,6,14,51,85,92,75,58,85,15},26)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
modeBtn.Font = Enum.Font.GothamSemibold
modeBtn.TextSize = 11
modeBtn.Parent = frame
local modeCorner = Instance.new(_d({59,47,41,85,88,84,75,88},26))
modeCorner.CornerRadius = UDim.new(0, 6)
modeCorner.Parent = modeBtn
modeBtn.MouseButton1Click:Connect(function()
if PathRecorder.ReplayMode == _d({57,90,75,71,82,90,78},26) then
PathRecorder.ReplayMode = _d({43,94,71,73,90},26)
modeBtn.Text = _d({51,85,74,75,32,6,214,133,116,149,6,43,94,71,73,90,6,41,44,88,71,83,75,6,47,84,90,75,88,86,85,82,71,90,79,85,84},26)
modeBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
else
PathRecorder.ReplayMode = _d({57,90,75,71,82,90,78},26)
modeBtn.Text = _d({51,85,74,75,32,6,214,133,129,135,213,158,117,6,57,90,75,71,82,90,78,6,54,78,95,89,79,73,89,6,14,51,85,92,75,58,85,15},26)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
end
end)
local function CreateButton(text, pos, bgColor, textColor)
local btn = Instance.new(_d({58,75,94,90,40,91,90,90,85,84},26))
btn.Size = UDim2.new(0.46, 0, 0, 34)
btn.Position = pos
btn.BackgroundColor3 = bgColor
btn.BorderSizePixel = 0
btn.Text = text
btn.TextColor3 = textColor
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.Parent = frame
local btnCorner = Instance.new(_d({59,47,41,85,88,84,75,88},26))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
return btn
end
local recBtn = CreateButton(_d({200,117,160,6,56,75,73,85,88,74},26), UDim2.new(0, 10, 0, 110), Color3.fromRGB(220, 50, 60), Color3.new(1,1,1))
local stopBtn = CreateButton(_d({200,117,159,6,57,90,85,86},26), UDim2.new(0.52, 0, 0, 110), Color3.fromRGB(80, 85, 95), Color3.new(1,1,1))
local playFwdBtn = CreateButton(_d({200,124,156,6,54,82,71,95,6,44,85,88,93,71,88,74},26), UDim2.new(0, 10, 0, 152), Color3.fromRGB(40, 160, 90), Color3.new(1,1,1))
local playRevBtn = CreateButton(_d({200,125,102,6,54,82,71,95,6,56,75,92,75,88,89,75},26), UDim2.new(0.52, 0, 0, 152), Color3.fromRGB(160, 100, 40), Color3.new(1,1,1))
local clearBtn = CreateButton(_d({214,133,125,119,6,41,82,75,71,88,6,54,71,90,78},26), UDim2.new(0, 10, 0, 194), Color3.fromRGB(50, 55, 65), Color3.fromRGB(200, 200, 200))
clearBtn.Size = UDim2.new(1, -20, 0, 30)
RunService.RenderStepped:Connect(function()
if PathRecorder.IsRecording then
statusLabel.Text = string.format(_d({214,133,122,154,6,56,75,73,85,88,74,79,84,77,32,6,11,74,6,86,90,89,6,14,11,20,23,76,89,15},26), #PathRecorder.RecordedPoints, PathRecorder.TotalRecordTime)
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
elseif not PathRecorder.IsReplaying then
statusLabel.Text = string.format(_d({57,90,71,90,91,89,32,6,47,74,82,75,6,98,6,11,74,6,54,85,79,84,90,89,6,57,71,92,75,74},26), #PathRecorder.RecordedPoints)
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
statusLabel.Text = _d({57,90,71,90,91,89,32,6,57,90,85,86,86,75,74},26)
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
statusLabel.Text = _d({57,90,71,90,91,89,32,6,54,71,90,78,6,41,82,75,71,88,75,74},26)
end)
end
CreateUI()
print(_d({65,57,90,75,71,82,90,78,54,71,90,78,56,75,73,85,88,74,75,88,67,6,50,85,71,74,75,74,6,89,91,73,73,75,89,89,76,91,82,82,95,20},26))
end)()