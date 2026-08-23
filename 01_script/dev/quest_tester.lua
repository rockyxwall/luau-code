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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({38,40,27,75},40))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({45,72,72,61,74,44,71,74,75,71},40))
local prompt = torso and torso:FindFirstChild(_d({40,74,71,69,72,76},40))
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
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,38,71,248,73,77,61,75,76,248,38,40,27,248,62,71,77,70,60,248,79,65,76,64,65,70,248,9,10,248,75,76,77,60,75,6},40))
return
end
local torso = npc.UpperTorso
local prompt = torso:FindFirstChild(_d({40,74,71,69,72,76},40))
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,33,70,76,61,74,57,59,76,65,70,63,248,79,65,76,64,248,38,40,27,18,248},40) .. npc.Name)
if fireproximityprompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,43,65,69,77,68,57,76,65,70,63,248,64,71,68,60,248,60,77,74,57,76,65,71,70,18,248},40) .. tostring(holdTime) .. "s")
task.wait(holdTime + 0.1)
end
pcall(fireproximityprompt, prompt)
else
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,29,42,42,39,42,18,248,62,65,74,61,72,74,71,80,65,69,65,76,81,72,74,71,69,72,76,248,65,75,248,70,71,76,248,75,77,72,72,71,74,76,61,60,248,58,81,248,81,71,77,74,248,61,80,61,59,77,76,71,74,249},40))
return
end
task.wait(1.0)
local playerGui = LocalPlayer:FindFirstChild(_d({40,68,57,81,61,74,31,77,65},40))
local chatGui = playerGui and playerGui:FindFirstChild(_d({38,40,27,27,32,25,44},40))
if not chatGui then
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,29,42,42,39,42,18,248,38,40,27,27,32,25,44,248,43,59,74,61,61,70,31,77,65,248,70,71,76,248,62,71,77,70,60,248,65,70,248,40,68,57,81,61,74,31,77,65,6},40))
return
end
if not chatGui.Enabled then
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,29,42,42,39,42,18,248,38,40,27,27,32,25,44,248,31,45,33,248,65,75,248,70,71,76,248,61,70,57,58,68,61,60,7,78,65,75,65,58,68,61,6},40))
return
end
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,38,40,27,27,32,25,44,248,71,72,61,70,61,60,248,75,77,59,59,61,75,75,62,77,68,68,81,249,248,43,76,57,74,76,65,70,63,248,59,68,65,59,67,248,75,61,73,77,61,70,59,61,6,6,6},40))
local tries = 0
while chatGui.Enabled and tries < 10 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({30,74,57,69,61},40))
local goBtn = frame and frame:FindFirstChild(_d({63,71},40))
local endChatBtn = frame and frame:FindFirstChild(_d({61,70,60,27,64,57,76},40))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,27,68,65,59,67,65,70,63,248,255,63,71,255,248,58,77,76,76,71,70,18,248},40) .. tostring(goBtn.Text))
if getconnections then
local clickConns = getconnections(goBtn.MouseButton1Click)
local activatedConns = getconnections(goBtn.Activated)
print(string.format(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,255,63,71,255,248,59,71,70,70,61,59,76,65,71,70,75,248,62,71,77,70,60,18,248,37,71,77,75,61,26,77,76,76,71,70,9,27,68,65,59,67,248,0,253,60,1,4,248,25,59,76,65,78,57,76,61,60,248,0,253,60,1},40), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,29,42,42,39,42,18,248,63,61,76,59,71,70,70,61,59,76,65,71,70,75,248,70,71,76,248,75,77,72,72,71,74,76,61,60,248,58,81,248,61,80,61,59,77,76,71,74,249},40))
end
elseif endChatBtn and endChatBtn.Visible then
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,27,68,65,59,67,65,70,63,248,255,61,70,60,27,64,57,76,255,248,0,25,60,78,57,70,59,61,248,28,65,57,68,71,63,1,248,58,77,76,76,71,70,6},40))
if getconnections then
local clickConns = getconnections(endChatBtn.MouseButton1Click)
local activatedConns = getconnections(endChatBtn.Activated)
print(string.format(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,255,61,70,60,27,64,57,76,255,248,59,71,70,70,61,59,76,65,71,70,75,248,62,71,77,70,60,18,248,37,71,77,75,61,26,77,76,76,71,70,9,27,68,65,59,67,248,0,253,60,1,4,248,25,59,76,65,78,57,76,61,60,248,0,253,60,1},40), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,29,42,42,39,42,18,248,63,61,76,59,71,70,70,61,59,76,65,71,70,75,248,70,71,76,248,75,77,72,72,71,74,76,61,60,248,58,81,248,61,80,61,59,77,76,71,74,249},40))
end
else
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,47,57,65,76,65,70,63,248,62,71,74,248,60,65,57,68,71,63,77,61,248,58,77,76,76,71,70,248,76,71,248,58,61,59,71,69,61,248,78,65,75,65,58,68,61,6,6,6},40))
end
task.wait(0.8)
end
if not chatGui.Enabled then
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,28,65,57,68,71,63,77,61,248,59,68,71,75,61,60,6,248,41,77,61,75,76,248,57,59,59,61,72,76,61,60,248,75,77,59,59,61,75,75,62,77,68,68,81,249},40))
else
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,43,61,73,77,61,70,59,61,248,62,65,70,65,75,64,61,60,4,248,58,77,76,248,60,65,57,68,71,63,77,61,248,65,75,248,75,76,65,68,68,248,71,72,61,70,6},40))
end
end
testQuestAcceptance()
end)()