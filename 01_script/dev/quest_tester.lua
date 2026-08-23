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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({45,47,34,82},33))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({52,79,79,68,81,51,78,81,82,78},33))
local prompt = torso and torso:FindFirstChild(_d({47,81,78,76,79,83},33))
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
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,45,78,255,80,84,68,82,83,255,45,47,34,255,69,78,84,77,67,255,86,72,83,71,72,77,255,16,17,255,82,83,84,67,82,13},33))
return
end
local torso = npc.UpperTorso
local prompt = torso:FindFirstChild(_d({47,81,78,76,79,83},33))
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,40,77,83,68,81,64,66,83,72,77,70,255,86,72,83,71,255,45,47,34,25,255},33) .. npc.Name)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,36,49,49,46,49,25,255,69,72,81,68,79,81,78,87,72,76,72,83,88,79,81,78,76,79,83,255,72,82,255,77,78,83,255,82,84,79,79,78,81,83,68,67,255,65,88,255,88,78,84,81,255,68,87,68,66,84,83,78,81,0},33))
return
end
task.wait(1.0)
local playerGui = LocalPlayer:FindFirstChild(_d({47,75,64,88,68,81,38,84,72},33))
local chatGui = playerGui and playerGui:FindFirstChild(_d({45,47,34,34,39,32,51},33))
if not chatGui then
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,36,49,49,46,49,25,255,45,47,34,34,39,32,51,255,50,66,81,68,68,77,38,84,72,255,77,78,83,255,69,78,84,77,67,255,72,77,255,47,75,64,88,68,81,38,84,72,13},33))
return
end
if not chatGui.Enabled then
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,36,49,49,46,49,25,255,45,47,34,34,39,32,51,255,38,52,40,255,72,82,255,77,78,83,255,68,77,64,65,75,68,67,14,85,72,82,72,65,75,68,13},33))
return
end
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,45,47,34,34,39,32,51,255,78,79,68,77,68,67,255,82,84,66,66,68,82,82,69,84,75,75,88,0,255,50,83,64,81,83,72,77,70,255,66,75,72,66,74,255,82,68,80,84,68,77,66,68,13,13,13},33))
local tries = 0
while chatGui.Enabled and tries < 10 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({37,81,64,76,68},33))
local goBtn = frame and frame:FindFirstChild(_d({70,78},33))
local endChatBtn = frame and frame:FindFirstChild(_d({68,77,67,34,71,64,83},33))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,34,75,72,66,74,72,77,70,255,6,70,78,6,255,65,84,83,83,78,77,25,255},33) .. tostring(goBtn.Text))
if getconnections then
local clickConns = getconnections(goBtn.MouseButton1Click)
local activatedConns = getconnections(goBtn.Activated)
print(string.format(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,6,70,78,6,255,66,78,77,77,68,66,83,72,78,77,82,255,69,78,84,77,67,25,255,44,78,84,82,68,33,84,83,83,78,77,16,34,75,72,66,74,255,7,4,67,8,11,255,32,66,83,72,85,64,83,68,67,255,7,4,67,8},33), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,36,49,49,46,49,25,255,70,68,83,66,78,77,77,68,66,83,72,78,77,82,255,77,78,83,255,82,84,79,79,78,81,83,68,67,255,65,88,255,68,87,68,66,84,83,78,81,0},33))
end
elseif endChatBtn and endChatBtn.Visible then
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,34,75,72,66,74,72,77,70,255,6,68,77,67,34,71,64,83,6,255,7,32,67,85,64,77,66,68,255,35,72,64,75,78,70,8,255,65,84,83,83,78,77,13},33))
if getconnections then
local clickConns = getconnections(endChatBtn.MouseButton1Click)
local activatedConns = getconnections(endChatBtn.Activated)
print(string.format(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,6,68,77,67,34,71,64,83,6,255,66,78,77,77,68,66,83,72,78,77,82,255,69,78,84,77,67,25,255,44,78,84,82,68,33,84,83,83,78,77,16,34,75,72,66,74,255,7,4,67,8,11,255,32,66,83,72,85,64,83,68,67,255,7,4,67,8},33), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,36,49,49,46,49,25,255,70,68,83,66,78,77,77,68,66,83,72,78,77,82,255,77,78,83,255,82,84,79,79,78,81,83,68,67,255,65,88,255,68,87,68,66,84,83,78,81,0},33))
end
else
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,54,64,72,83,72,77,70,255,69,78,81,255,67,72,64,75,78,70,84,68,255,65,84,83,83,78,77,255,83,78,255,65,68,66,78,76,68,255,85,72,82,72,65,75,68,13,13,13},33))
end
task.wait(0.5)
end
if not chatGui.Enabled then
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,35,72,64,75,78,70,84,68,255,66,75,78,82,68,67,13,255,48,84,68,82,83,255,64,66,66,68,79,83,68,67,255,82,84,66,66,68,82,82,69,84,75,75,88,0},33))
else
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,50,68,80,84,68,77,66,68,255,69,72,77,72,82,71,68,67,11,255,65,84,83,255,67,72,64,75,78,70,84,68,255,72,82,255,82,83,72,75,75,255,78,79,68,77,13},33))
end
end
testQuestAcceptance()
end)()