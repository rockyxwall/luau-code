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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({32,34,21,69},46))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({39,66,66,55,68,38,65,68,69,65},46))
local prompt = torso and torso:FindFirstChild(_d({34,68,65,63,66,70},46))
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
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,32,65,242,67,71,55,69,70,242,32,34,21,242,56,65,71,64,54,242,73,59,70,58,59,64,242,3,4,242,69,70,71,54,69,0},46))
return
end
local torso = npc.UpperTorso
local prompt = torso:FindFirstChild(_d({34,68,65,63,66,70},46))
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,27,64,70,55,68,51,53,70,59,64,57,242,73,59,70,58,242,32,34,21,12,242},46) .. npc.Name)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,23,36,36,33,36,12,242,56,59,68,55,66,68,65,74,59,63,59,70,75,66,68,65,63,66,70,242,59,69,242,64,65,70,242,69,71,66,66,65,68,70,55,54,242,52,75,242,75,65,71,68,242,55,74,55,53,71,70,65,68,243},46))
return
end
task.wait(1.0)
local playerGui = LocalPlayer:FindFirstChild(_d({34,62,51,75,55,68,25,71,59},46))
local chatGui = playerGui and playerGui:FindFirstChild(_d({32,34,21,21,26,19,38},46))
if not chatGui then
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,23,36,36,33,36,12,242,32,34,21,21,26,19,38,242,37,53,68,55,55,64,25,71,59,242,64,65,70,242,56,65,71,64,54,242,59,64,242,34,62,51,75,55,68,25,71,59,0},46))
return
end
if not chatGui.Enabled then
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,23,36,36,33,36,12,242,32,34,21,21,26,19,38,242,25,39,27,242,59,69,242,64,65,70,242,55,64,51,52,62,55,54,1,72,59,69,59,52,62,55,0},46))
return
end
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,32,34,21,21,26,19,38,242,65,66,55,64,55,54,242,69,71,53,53,55,69,69,56,71,62,62,75,243,242,37,70,51,68,70,59,64,57,242,53,62,59,53,61,242,69,55,67,71,55,64,53,55,0,0,0},46))
local tries = 0
while chatGui.Enabled and tries < 10 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({57,65},46))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({55,64,54,21,58,51,70},46))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,21,62,59,53,61,59,64,57,242,249,57,65,249,242,52,71,70,70,65,64,12,242},46) .. tostring(goBtn.Text))
if getconnections then
local clickConns = getconnections(goBtn.MouseButton1Click)
local activatedConns = getconnections(goBtn.Activated)
print(string.format(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,249,57,65,249,242,53,65,64,64,55,53,70,59,65,64,69,242,56,65,71,64,54,12,242,31,65,71,69,55,20,71,70,70,65,64,3,21,62,59,53,61,242,250,247,54,251,254,242,19,53,70,59,72,51,70,55,54,242,250,247,54,251},46), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,23,36,36,33,36,12,242,57,55,70,53,65,64,64,55,53,70,59,65,64,69,242,64,65,70,242,69,71,66,66,65,68,70,55,54,242,52,75,242,55,74,55,53,71,70,65,68,243},46))
end
elseif endChatBtn and endChatBtn.Visible then
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,21,62,59,53,61,59,64,57,242,249,55,64,54,21,58,51,70,249,242,250,19,54,72,51,64,53,55,242,22,59,51,62,65,57,251,242,52,71,70,70,65,64,0},46))
if getconnections then
local clickConns = getconnections(endChatBtn.MouseButton1Click)
local activatedConns = getconnections(endChatBtn.Activated)
print(string.format(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,249,55,64,54,21,58,51,70,249,242,53,65,64,64,55,53,70,59,65,64,69,242,56,65,71,64,54,12,242,31,65,71,69,55,20,71,70,70,65,64,3,21,62,59,53,61,242,250,247,54,251,254,242,19,53,70,59,72,51,70,55,54,242,250,247,54,251},46), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,23,36,36,33,36,12,242,57,55,70,53,65,64,64,55,53,70,59,65,64,69,242,64,65,70,242,69,71,66,66,65,68,70,55,54,242,52,75,242,55,74,55,53,71,70,65,68,243},46))
end
else
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,41,51,59,70,59,64,57,242,56,65,68,242,54,59,51,62,65,57,71,55,242,52,71,70,70,65,64,242,70,65,242,52,55,53,65,63,55,242,72,59,69,59,52,62,55,0,0,0},46))
end
task.wait(0.5)
end
if not chatGui.Enabled then
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,22,59,51,62,65,57,71,55,242,53,62,65,69,55,54,0,242,35,71,55,69,70,242,51,53,53,55,66,70,55,54,242,69,71,53,53,55,69,69,56,71,62,62,75,243},46))
else
print(_d({45,35,71,55,69,70,242,38,55,69,70,55,68,47,242,37,55,67,71,55,64,53,55,242,56,59,64,59,69,58,55,54,254,242,52,71,70,242,54,59,51,62,65,57,71,55,242,59,69,242,69,70,59,62,62,242,65,66,55,64,0},46))
end
end
testQuestAcceptance()
end)()