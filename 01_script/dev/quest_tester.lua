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
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({22,24,11,59},56))
if not npcsFolder then return nil end
local nearest, minDist = nil, 25
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({29,56,56,45,58,28,55,58,59,55},56))
local prompt = torso and torso:FindFirstChild(_d({24,58,55,53,56,60},56))
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
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,22,55,232,57,61,45,59,60,232,22,24,11,232,46,55,61,54,44,232,63,49,60,48,49,54,232,250,253,232,59,60,61,44,59,246},56))
return
end
local torso = npc.UpperTorso
local prompt = torso:FindFirstChild(_d({24,58,55,53,56,60},56))
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,17,54,60,45,58,41,43,60,49,54,47,232,63,49,60,48,232,22,24,11,2,232},56) .. npc.Name)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,13,26,26,23,26,2,232,46,49,58,45,56,58,55,64,49,53,49,60,65,56,58,55,53,56,60,232,49,59,232,54,55,60,232,59,61,56,56,55,58,60,45,44,232,42,65,232,65,55,61,58,232,45,64,45,43,61,60,55,58,233},56))
return
end
task.wait(1.0)
local playerGui = LocalPlayer:FindFirstChild(_d({24,52,41,65,45,58,15,61,49},56))
local chatGui = playerGui and playerGui:FindFirstChild(_d({22,24,11,11,16,9,28},56))
if not chatGui then
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,13,26,26,23,26,2,232,22,24,11,11,16,9,28,232,27,43,58,45,45,54,15,61,49,232,54,55,60,232,46,55,61,54,44,232,49,54,232,24,52,41,65,45,58,15,61,49,246},56))
return
end
if not chatGui.Enabled then
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,13,26,26,23,26,2,232,22,24,11,11,16,9,28,232,15,29,17,232,49,59,232,54,55,60,232,45,54,41,42,52,45,44,247,62,49,59,49,42,52,45,246},56))
return
end
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,22,24,11,11,16,9,28,232,55,56,45,54,45,44,232,59,61,43,43,45,59,59,46,61,52,52,65,233,232,27,60,41,58,60,49,54,47,232,43,52,49,43,51,232,59,45,57,61,45,54,43,45,246,246,246},56))
local tries = 0
while chatGui.Enabled and tries < 10 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({47,55},56))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({45,54,44,11,48,41,60},56))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({246,246,246},56) then
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,11,52,49,43,51,49,54,47,232,239,47,55,239,232,240,9,43,43,45,56,60,232,23,56,60,49,55,54,241,232,42,61,60,60,55,54,2,232},56) .. tostring(goBtn.Text))
if getconnections then
local clickConns = getconnections(goBtn.MouseButton1Click)
local activatedConns = getconnections(goBtn.Activated)
print(string.format(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,239,47,55,239,232,43,55,54,54,45,43,60,49,55,54,59,232,46,55,61,54,44,2,232,21,55,61,59,45,10,61,60,60,55,54,249,11,52,49,43,51,232,240,237,44,241,244,232,9,43,60,49,62,41,60,45,44,232,240,237,44,241},56), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,13,26,26,23,26,2,232,47,45,60,43,55,54,54,45,43,60,49,55,54,59,232,54,55,60,232,59,61,56,56,55,58,60,45,44,232,42,65,232,45,64,45,43,61,60,55,58,233},56))
end
elseif endChatBtn and endChatBtn.Visible then
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,11,52,49,43,51,49,54,47,232,239,45,54,44,11,48,41,60,239,232,240,9,44,62,41,54,43,45,232,12,49,41,52,55,47,241,232,42,61,60,60,55,54,246},56))
if getconnections then
local clickConns = getconnections(endChatBtn.MouseButton1Click)
local activatedConns = getconnections(endChatBtn.Activated)
print(string.format(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,239,45,54,44,11,48,41,60,239,232,43,55,54,54,45,43,60,49,55,54,59,232,46,55,61,54,44,2,232,21,55,61,59,45,10,61,60,60,55,54,249,11,52,49,43,51,232,240,237,44,241,244,232,9,43,60,49,62,41,60,45,44,232,240,237,44,241},56), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,13,26,26,23,26,2,232,47,45,60,43,55,54,54,45,43,60,49,55,54,59,232,54,55,60,232,59,61,56,56,55,58,60,45,44,232,42,65,232,45,64,45,43,61,60,55,58,233},56))
end
else
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,31,41,49,60,49,54,47,232,46,55,58,232,44,49,41,52,55,47,61,45,232,42,61,60,60,55,54,232,60,55,232,42,45,43,55,53,45,232,62,49,59,49,42,52,45,246,246,246},56))
end
task.wait(0.5)
end
if not chatGui.Enabled then
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,12,49,41,52,55,47,61,45,232,43,52,55,59,45,44,246,232,25,61,45,59,60,232,41,43,43,45,56,60,45,44,232,59,61,43,43,45,59,59,46,61,52,52,65,233},56))
else
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,27,45,57,61,45,54,43,45,232,46,49,54,49,59,48,45,44,244,232,42,61,60,232,44,49,41,52,55,47,61,45,232,49,59,232,59,60,49,52,52,232,55,56,45,54,246},56))
end
end
testQuestAcceptance()
end)()