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
local Players = game:GetService(_d({36,64,53,77,57,70,71},44))
local RunService = game:GetService(_d({38,73,66,39,57,70,74,61,55,57},44))
local PathfindingService = game:GetService(_d({36,53,72,60,58,61,66,56,61,66,59,39,57,70,74,61,55,57},44))
local TweenService = game:GetService(_d({40,75,57,57,66,39,57,70,74,61,55,57},44))
local UserInputService = game:GetService(_d({41,71,57,70,29,66,68,73,72,39,57,70,74,61,55,57},44))
local LocalPlayer = Players.LocalPlayer
local PathRecorder = {
IsRecording = false,
IsReplaying = false,
RecordedPoints = {},
ReplayMode = _d({39,72,57,53,64,72,60},44),
RecordConnection = nil,
LastRecordTime = 0,
TotalRecordTime = 0,
}
local function GetCharacter()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild(_d({28,73,65,53,66,67,61,56},44), 5)
local rootPart = character:WaitForChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44), 5)
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
statusCallback(string.format(_d({21,64,61,59,66,61,66,59,244,72,67,244,71,72,53,70,72,244,252,249,2,5,58,65,244,53,75,53,77,253,2,2,2},44), dist))
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
if statusCallback then statusCallback(_d({34,67,244,70,57,55,67,70,56,57,56,244,68,53,72,60,244,53,74,53,61,64,53,54,64,57,245},44)) end
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
local modeText = reverse and _d({38,57,74,57,70,71,57,244,38,57,68,64,53,77},44) or _d({38,57,68,64,53,77},44)
statusCallback(string.format(_d({249,71,14,244,249,56,3,249,56,244,68,72,71},44), modeText, pointsProcessed, totalPoints))
end
if pt.Jump then
humanoid.Jump = true
end
if PathRecorder.ReplayMode == _d({39,72,57,53,64,72,60},44) then
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
statusCallback(_d({38,57,68,64,53,77,244,23,67,65,68,64,57,72,57,56,245},44))
end
end)
end
local function CreateUI()
local playerGui = LocalPlayer:WaitForChild(_d({36,64,53,77,57,70,27,73,61},44), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({36,53,72,60,38,57,55,67,70,56,57,70,27,73,61},44))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({39,55,70,57,57,66,27,73,61},44))
screenGui.Name = _d({36,53,72,60,38,57,55,67,70,56,57,70,27,73,61},44)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({26,70,53,65,57},44))
frame.Name = _d({33,53,61,66,26,70,53,65,57},44)
frame.Size = UDim2.new(0, 300, 0, 260)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({41,29,23,67,70,66,57,70},44))
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame
local uiStroke = Instance.new(_d({41,29,39,72,70,67,63,57},44))
uiStroke.Color = Color3.fromRGB(55, 62, 78)
uiStroke.Thickness = 1.5
uiStroke.Parent = frame
local title = Instance.new(_d({40,57,76,72,32,53,54,57,64},44))
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({182,110,117,244,39,72,57,53,64,72,60,244,36,53,72,60,244,38,57,55,67,70,56,57,70},44)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({40,57,76,72,32,53,54,57,64},44))
statusLabel.Name = _d({39,72,53,72,73,71,32,53,54,57,64},44)
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 40)
statusLabel.BackgroundColor3 = Color3.fromRGB(34, 38, 48)
statusLabel.BorderSizePixel = 0
statusLabel.Text = _d({39,72,53,72,73,71,14,244,29,56,64,57,244,80,244,4,244,36,67,61,66,72,71},44)
statusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 12
statusLabel.Parent = frame
local statusCorner = Instance.new(_d({41,29,23,67,70,66,57,70},44))
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusLabel
local modeBtn = Instance.new(_d({40,57,76,72,22,73,72,72,67,66},44))
modeBtn.Size = UDim2.new(1, -20, 0, 28)
modeBtn.Position = UDim2.new(0, 10, 0, 72)
modeBtn.BackgroundColor3 = Color3.fromRGB(42, 50, 65)
modeBtn.BorderSizePixel = 0
modeBtn.Text = _d({33,67,56,57,14,244,196,115,111,117,195,140,99,244,39,72,57,53,64,72,60,244,36,60,77,71,61,55,71,244,252,33,67,74,57,40,67,253},44)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
modeBtn.Font = Enum.Font.GothamSemibold
modeBtn.TextSize = 11
modeBtn.Parent = frame
local modeCorner = Instance.new(_d({41,29,23,67,70,66,57,70},44))
modeCorner.CornerRadius = UDim.new(0, 6)
modeCorner.Parent = modeBtn
modeBtn.MouseButton1Click:Connect(function()
if PathRecorder.ReplayMode == _d({39,72,57,53,64,72,60},44) then
PathRecorder.ReplayMode = _d({25,76,53,55,72},44)
modeBtn.Text = _d({33,67,56,57,14,244,196,115,98,131,244,25,76,53,55,72,244,23,26,70,53,65,57,244,29,66,72,57,70,68,67,64,53,72,61,67,66},44)
modeBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
else
PathRecorder.ReplayMode = _d({39,72,57,53,64,72,60},44)
modeBtn.Text = _d({33,67,56,57,14,244,196,115,111,117,195,140,99,244,39,72,57,53,64,72,60,244,36,60,77,71,61,55,71,244,252,33,67,74,57,40,67,253},44)
modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
end
end)
local function CreateButton(text, pos, bgColor, textColor)
local btn = Instance.new(_d({40,57,76,72,22,73,72,72,67,66},44))
btn.Size = UDim2.new(0.46, 0, 0, 34)
btn.Position = pos
btn.BackgroundColor3 = bgColor
btn.BorderSizePixel = 0
btn.Text = text
btn.TextColor3 = textColor
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.Parent = frame
local btnCorner = Instance.new(_d({41,29,23,67,70,66,57,70},44))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
return btn
end
local recBtn = CreateButton(_d({182,99,142,244,38,57,55,67,70,56},44), UDim2.new(0, 10, 0, 110), Color3.fromRGB(220, 50, 60), Color3.new(1,1,1))
local stopBtn = CreateButton(_d({182,99,141,244,39,72,67,68},44), UDim2.new(0.52, 0, 0, 110), Color3.fromRGB(80, 85, 95), Color3.new(1,1,1))
local playFwdBtn = CreateButton(_d({182,106,138,244,36,64,53,77,244,26,67,70,75,53,70,56},44), UDim2.new(0, 10, 0, 152), Color3.fromRGB(40, 160, 90), Color3.new(1,1,1))
local playRevBtn = CreateButton(_d({182,107,84,244,36,64,53,77,244,38,57,74,57,70,71,57},44), UDim2.new(0.52, 0, 0, 152), Color3.fromRGB(160, 100, 40), Color3.new(1,1,1))
local clearBtn = CreateButton(_d({196,115,107,101,244,23,64,57,53,70,244,36,53,72,60},44), UDim2.new(0, 10, 0, 194), Color3.fromRGB(50, 55, 65), Color3.fromRGB(200, 200, 200))
clearBtn.Size = UDim2.new(1, -20, 0, 30)
RunService.RenderStepped:Connect(function()
if PathRecorder.IsRecording then
statusLabel.Text = string.format(_d({196,115,104,136,244,38,57,55,67,70,56,61,66,59,14,244,249,56,244,68,72,71,244,252,249,2,5,58,71,253},44), #PathRecorder.RecordedPoints, PathRecorder.TotalRecordTime)
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
elseif not PathRecorder.IsReplaying then
statusLabel.Text = string.format(_d({39,72,53,72,73,71,14,244,29,56,64,57,244,80,244,249,56,244,36,67,61,66,72,71,244,39,53,74,57,56},44), #PathRecorder.RecordedPoints)
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
statusLabel.Text = _d({39,72,53,72,73,71,14,244,39,72,67,68,68,57,56},44)
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
statusLabel.Text = _d({39,72,53,72,73,71,14,244,36,53,72,60,244,23,64,57,53,70,57,56},44)
end)
end
CreateUI()
print(_d({47,39,72,57,53,64,72,60,36,53,72,60,38,57,55,67,70,56,57,70,49,244,32,67,53,56,57,56,244,71,73,55,55,57,71,71,58,73,64,64,77,2},44))
end)()