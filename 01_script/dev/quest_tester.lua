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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({51,53,40,88},27))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({58,85,85,74,87,57,84,87,88,84},27))
local prompt = torso and torso:FindFirstChild(_d({53,87,84,82,85,89},27))
if prompt then
local dist = (torso.Position - myRoot.Position).Magnitude
if dist < minDist then
minDist = dist
nearest = npc
end
end
end
return nearest
end
local function testQuestAcceptance()
local npc = getNearestNPC()
if not npc then
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,51,84,5,86,90,74,88,89,5,51,53,40,5,75,84,90,83,73,5,92,78,89,77,78,83,5,22,23,5,88,89,90,73,88,19},27))
return
end
local torso = npc.UpperTorso
local prompt = torso:FindFirstChild(_d({53,87,84,82,85,89},27))
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,46,83,89,74,87,70,72,89,78,83,76,5,92,78,89,77,5,51,53,40,31,5},27) .. npc.Name)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,42,55,55,52,55,31,5,75,78,87,74,85,87,84,93,78,82,78,89,94,85,87,84,82,85,89,5,78,88,5,83,84,89,5,88,90,85,85,84,87,89,74,73,5,71,94,5,94,84,90,87,5,74,93,74,72,90,89,84,87,6},27))
return
end
task.wait(1.0)
local playerGui = LocalPlayer:FindFirstChild(_d({53,81,70,94,74,87,44,90,78},27))
local chatGui = playerGui and playerGui:FindFirstChild(_d({51,53,40,40,45,38,57},27))
if not chatGui then
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,42,55,55,52,55,31,5,51,53,40,40,45,38,57,5,56,72,87,74,74,83,44,90,78,5,83,84,89,5,75,84,90,83,73,5,78,83,5,53,81,70,94,74,87,44,90,78,19},27))
return
end
if not chatGui.Enabled then
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,42,55,55,52,55,31,5,51,53,40,40,45,38,57,5,44,58,46,5,78,88,5,83,84,89,5,74,83,70,71,81,74,73,20,91,78,88,78,71,81,74,19},27))
return
end
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,51,53,40,40,45,38,57,5,84,85,74,83,74,73,5,88,90,72,72,74,88,88,75,90,81,81,94,6,5,56,89,70,87,89,78,83,76,5,72,81,78,72,80,5,88,74,86,90,74,83,72,74,19,19,19},27))
local tries = 0
while chatGui.Enabled and tries < 10 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({76,84},27))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({74,83,73,40,77,70,89},27))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({19,19,19},27) then
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,40,81,78,72,80,78,83,76,5,12,76,84,12,5,13,38,72,72,74,85,89,5,52,85,89,78,84,83,14,5,71,90,89,89,84,83,31,5},27) .. tostring(goBtn.Text))
if getconnections then
local clickConns = getconnections(goBtn.MouseButton1Click)
local activatedConns = getconnections(goBtn.Activated)
print(string.format(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,12,76,84,12,5,72,84,83,83,74,72,89,78,84,83,88,5,75,84,90,83,73,31,5,50,84,90,88,74,39,90,89,89,84,83,22,40,81,78,72,80,5,13,10,73,14,17,5,38,72,89,78,91,70,89,74,73,5,13,10,73,14},27), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,42,55,55,52,55,31,5,76,74,89,72,84,83,83,74,72,89,78,84,83,88,5,83,84,89,5,88,90,85,85,84,87,89,74,73,5,71,94,5,74,93,74,72,90,89,84,87,6},27))
end
elseif endChatBtn and endChatBtn.Visible then
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,40,81,78,72,80,78,83,76,5,12,74,83,73,40,77,70,89,12,5,13,38,73,91,70,83,72,74,5,41,78,70,81,84,76,14,5,71,90,89,89,84,83,19},27))
if getconnections then
local clickConns = getconnections(endChatBtn.MouseButton1Click)
local activatedConns = getconnections(endChatBtn.Activated)
print(string.format(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,12,74,83,73,40,77,70,89,12,5,72,84,83,83,74,72,89,78,84,83,88,5,75,84,90,83,73,31,5,50,84,90,88,74,39,90,89,89,84,83,22,40,81,78,72,80,5,13,10,73,14,17,5,38,72,89,78,91,70,89,74,73,5,13,10,73,14},27), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,42,55,55,52,55,31,5,76,74,89,72,84,83,83,74,72,89,78,84,83,88,5,83,84,89,5,88,90,85,85,84,87,89,74,73,5,71,94,5,74,93,74,72,90,89,84,87,6},27))
end
else
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,60,70,78,89,78,83,76,5,75,84,87,5,73,78,70,81,84,76,90,74,5,71,90,89,89,84,83,5,89,84,5,71,74,72,84,82,74,5,91,78,88,78,71,81,74,19,19,19},27))
end
task.wait(0.5)
end
if not chatGui.Enabled then
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,41,78,70,81,84,76,90,74,5,72,81,84,88,74,73,19,5,54,90,74,88,89,5,70,72,72,74,85,89,74,73,5,88,90,72,72,74,88,88,75,90,81,81,94,6},27))
else
print(_d({64,54,90,74,88,89,5,57,74,88,89,74,87,66,5,56,74,86,90,74,83,72,74,5,75,78,83,78,88,77,74,73,17,5,71,90,89,5,73,78,70,81,84,76,90,74,5,78,88,5,88,89,78,81,81,5,84,85,74,83,19},27))
end
end
testQuestAcceptance()
end)()