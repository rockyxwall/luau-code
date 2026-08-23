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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local RunService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local PathfindingService = game:GetService(_d({37,54,73,61,59,62,67,57,62,67,60,40,58,71,75,62,56,58},43))
local TweenService = game:GetService(_d({41,76,58,58,67,40,58,71,75,62,56,58},43))
local UserInputService = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
local LocalPlayer = Players.LocalPlayer
local PathRecorder = {
IsRecording = false,
IsReplaying = false,
RecordedPoints = {},
ReplayMode = _d({40,73,58,54,65,73,61},43),
RecordConnection = nil,
LastRecordTime = 0,
TotalRecordTime = 0,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({29,74,66,54,67,68,62,57},43), 5)
local rootPart = character:WaitForChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43), 5)
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
statusCallback(string.format(_d({22,65,62,60,67,62,67,60,245,73,68,245,72,73,54,71,73,245,253,250,3,6,59,66,245,54,76,54,78,254,3,3,3},43), dist))
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
if statusCallback then statusCallback(_d({35,68,245,71,58,56,68,71,57,58,57,245,69,54,73,61,245,54,75,54,62,65,54,55,65,58,246},43)) end
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
local modeText = reverse and _d({39,58,75,58,71,72,58,245,39,58,69,65,54,78},43) or _d({39,58,69,65,54,78},43)
statusCallback(string.format(_d({250,72,15,245,250,57,4,250,57,245,69,73,72},43), modeText, pointsProcessed, totalPoints))
end
if pt.Jump then
humanoid.Jump = true
end
if PathRecorder.ReplayMode == _d({40,73,58,54,65,73,61},43) then
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
statusCallback(_d({39,58,69,65,54,78,245,24,68,66,69,65,58,73,58,57,246},43))
end
end)
end
local function CreateUI()
local playerGui = LocalPlayer:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({37,54,73,61,39,58,56,68,71,57,58,71,28,74,62},43))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({40,56,71,58,58,67,28,74,62},43))
screenGui.Name = _d({37,54,73,61,39,58,56,68,71,57,58,71,28,74,62},43)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({27,71,54,66,58},43))
frame.Name = _d({34,54,62,67,27,71,54,66,58},43)
frame.Size = UDim2.new(0, 300, 0, 260)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({42,30,24,68,71,67,58,71},43))
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame
local uiStroke = Instance.new(_d({42,30,40,73,71,68,64,58},43))
uiStroke.Color = Color3.fromRGB(55, 62, 78)
uiStroke.Thickness = 1.5
uiStroke.Parent = frame
local title = Instance.new(_d({41,58,77,73,33,54,55,58,65},43))
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({183,111,118,245,40,73,58,54,65,73,61,245,37,54,73,61,245,39,58,56,68,71,57,58,71},43)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({41,58,77,73,33,54,55,58,65},43))
statusLabel.Name = _d({40,73,54,73,74,72,33,54,55,58,65},43)
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 40)
statusLabel.BackgroundColor3 = Color3.fromRGB(34, 38, 48)
statusLabel.BorderSizePixel = 0
statusLabel.Text = _d({40,73,54,73,74,72,15,245,30,57,65,58,245,81,245,5,245,37,68,62,67,73,72},43)
statusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 12
statusLabel.Parent = frame
local statusCorner = Instance.new(_d({42,30,24,68,71,67,58,71},43))
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusLabel
local modeBtn = Instance.new(_d({41,58,77,73,23,74,73,73,68,67},43))
modeBtn.Size = UDim2.new(1, -20, 0, 28)
modeBtn.Position = UDim2.new(0, 10, 0, 72)
modeBtn.BackgroundColor3 = Color3.fromRGB(42, 50, 65)
modeBtn.BorderSizePixel = 0
modeBtn.Text = _d({34,68,57,58,15,245,197,116,112,118,196,141,100,245,40,73,58,54,65,73,61,245,37,61,78,72,62,56,72,245,253,34,68,75,58,41,68,254},43)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
modeBtn.Font = Enum.Font.GothamSemibold
modeBtn.TextSize = 11
modeBtn.Parent = frame
local modeCorner = Instance.new(_d({42,30,24,68,71,67,58,71},43))
modeCorner.CornerRadius = UDim.new(0, 6)
modeCorner.Parent = modeBtn
modeBtn.MouseButton1Click:Connect(function()
if PathRecorder.ReplayMode == _d({40,73,58,54,65,73,61},43) then
PathRecorder.ReplayMode = _d({26,77,54,56,73},43)
modeBtn.Text = _d({34,68,57,58,15,245,197,116,99,132,245,26,77,54,56,73,245,24,27,71,54,66,58,245,30,67,73,58,71,69,68,65,54,73,62,68,67},43)
modeBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
else
PathRecorder.ReplayMode = _d({40,73,58,54,65,73,61},43)
modeBtn.Text = _d({34,68,57,58,15,245,197,116,112,118,196,141,100,245,40,73,58,54,65,73,61,245,37,61,78,72,62,56,72,245,253,34,68,75,58,41,68,254},43)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
end
end)
local function CreateButton(text, pos, bgColor, textColor)
local btn = Instance.new(_d({41,58,77,73,23,74,73,73,68,67},43))
btn.Size = UDim2.new(0.46, 0, 0, 34)
btn.Position = pos
btn.BackgroundColor3 = bgColor
btn.BorderSizePixel = 0
btn.Text = text
btn.TextColor3 = textColor
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.Parent = frame
local btnCorner = Instance.new(_d({42,30,24,68,71,67,58,71},43))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
return btn
end
local recBtn = CreateButton(_d({183,100,143,245,39,58,56,68,71,57},43), UDim2.new(0, 10, 0, 110), Color3.fromRGB(220, 50, 60), Color3.new(1,1,1))
local stopBtn = CreateButton(_d({183,100,142,245,40,73,68,69},43), UDim2.new(0.52, 0, 0, 110), Color3.fromRGB(80, 85, 95), Color3.new(1,1,1))
local playFwdBtn = CreateButton(_d({183,107,139,245,37,65,54,78,245,27,68,71,76,54,71,57},43), UDim2.new(0, 10, 0, 152), Color3.fromRGB(40, 160, 90), Color3.new(1,1,1))
local playRevBtn = CreateButton(_d({183,108,85,245,37,65,54,78,245,39,58,75,58,71,72,58},43), UDim2.new(0.52, 0, 0, 152), Color3.fromRGB(160, 100, 40), Color3.new(1,1,1))
local clearBtn = CreateButton(_d({197,116,108,102,245,24,65,58,54,71,245,37,54,73,61},43), UDim2.new(0, 10, 0, 194), Color3.fromRGB(50, 55, 65), Color3.fromRGB(200, 200, 200))
clearBtn.Size = UDim2.new(1, -20, 0, 30)
RunService.RenderStepped:Connect(function()
if PathRecorder.IsRecording then
statusLabel.Text = string.format(_d({197,116,105,137,245,39,58,56,68,71,57,62,67,60,15,245,250,57,245,69,73,72,245,253,250,3,6,59,72,254},43), #PathRecorder.RecordedPoints, PathRecorder.TotalRecordTime)
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
elseif not PathRecorder.IsReplaying then
statusLabel.Text = string.format(_d({40,73,54,73,74,72,15,245,30,57,65,58,245,81,245,250,57,245,37,68,62,67,73,72,245,40,54,75,58,57},43), #PathRecorder.RecordedPoints)
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
statusLabel.Text = _d({40,73,54,73,74,72,15,245,40,73,68,69,69,58,57},43)
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
statusLabel.Text = _d({40,73,54,73,74,72,15,245,37,54,73,61,245,24,65,58,54,71,58,57},43)
end)
end
CreateUI()
print(_d({48,40,73,58,54,65,73,61,37,54,73,61,39,58,56,68,71,57,58,71,50,245,33,68,54,57,58,57,245,72,74,56,56,58,72,72,59,74,65,65,78,3},43))
end)()