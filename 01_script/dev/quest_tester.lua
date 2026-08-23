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
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({49,51,38,86},29))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({56,83,83,72,85,55,82,85,86,82},29))
local prompt = torso and torso:FindFirstChild(_d({51,85,82,80,83,87},29))
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
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,49,82,3,84,88,72,86,87,3,49,51,38,3,73,82,88,81,71,3,90,76,87,75,76,81,3,20,21,3,86,87,88,71,86,17},29))
return
end
local torso = npc.UpperTorso
local prompt = torso:FindFirstChild(_d({51,85,82,80,83,87},29))
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,44,81,87,72,85,68,70,87,76,81,74,3,90,76,87,75,3,49,51,38,29,3},29) .. npc.Name)
if fireproximityprompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,54,76,80,88,79,68,87,76,81,74,3,75,82,79,71,3,71,88,85,68,87,76,82,81,29,3},29) .. tostring(holdTime) .. "s")
task.wait(holdTime + 0.1)
end
pcall(fireproximityprompt, prompt)
else
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,40,53,53,50,53,29,3,73,76,85,72,83,85,82,91,76,80,76,87,92,83,85,82,80,83,87,3,76,86,3,81,82,87,3,86,88,83,83,82,85,87,72,71,3,69,92,3,92,82,88,85,3,72,91,72,70,88,87,82,85,4},29))
return
end
task.wait(1.0)
local playerGui = LocalPlayer:FindFirstChild(_d({51,79,68,92,72,85,42,88,76},29))
local chatGui = playerGui and playerGui:FindFirstChild(_d({49,51,38,38,43,36,55},29))
if not chatGui then
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,40,53,53,50,53,29,3,49,51,38,38,43,36,55,3,54,70,85,72,72,81,42,88,76,3,81,82,87,3,73,82,88,81,71,3,76,81,3,51,79,68,92,72,85,42,88,76,17},29))
return
end
if not chatGui.Enabled then
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,40,53,53,50,53,29,3,49,51,38,38,43,36,55,3,42,56,44,3,76,86,3,81,82,87,3,72,81,68,69,79,72,71,18,89,76,86,76,69,79,72,17},29))
return
end
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,49,51,38,38,43,36,55,3,82,83,72,81,72,71,3,86,88,70,70,72,86,86,73,88,79,79,92,4,3,54,87,68,85,87,76,81,74,3,70,79,76,70,78,3,86,72,84,88,72,81,70,72,17,17,17},29))
local tries = 0
while chatGui.Enabled and tries < 10 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({41,85,68,80,72},29))
local goBtn = frame and frame:FindFirstChild(_d({74,82},29))
local endChatBtn = frame and frame:FindFirstChild(_d({72,81,71,38,75,68,87},29))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,38,79,76,70,78,76,81,74,3,10,74,82,10,3,69,88,87,87,82,81,29,3},29) .. tostring(goBtn.Text))
if getconnections then
local clickConns = getconnections(goBtn.MouseButton1Click)
local activatedConns = getconnections(goBtn.Activated)
print(string.format(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,10,74,82,10,3,70,82,81,81,72,70,87,76,82,81,86,3,73,82,88,81,71,29,3,48,82,88,86,72,37,88,87,87,82,81,20,38,79,76,70,78,3,11,8,71,12,15,3,36,70,87,76,89,68,87,72,71,3,11,8,71,12},29), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,40,53,53,50,53,29,3,74,72,87,70,82,81,81,72,70,87,76,82,81,86,3,81,82,87,3,86,88,83,83,82,85,87,72,71,3,69,92,3,72,91,72,70,88,87,82,85,4},29))
end
elseif endChatBtn and endChatBtn.Visible then
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,38,79,76,70,78,76,81,74,3,10,72,81,71,38,75,68,87,10,3,11,36,71,89,68,81,70,72,3,39,76,68,79,82,74,12,3,69,88,87,87,82,81,17},29))
if getconnections then
local clickConns = getconnections(endChatBtn.MouseButton1Click)
local activatedConns = getconnections(endChatBtn.Activated)
print(string.format(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,10,72,81,71,38,75,68,87,10,3,70,82,81,81,72,70,87,76,82,81,86,3,73,82,88,81,71,29,3,48,82,88,86,72,37,88,87,87,82,81,20,38,79,76,70,78,3,11,8,71,12,15,3,36,70,87,76,89,68,87,72,71,3,11,8,71,12},29), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,40,53,53,50,53,29,3,74,72,87,70,82,81,81,72,70,87,76,82,81,86,3,81,82,87,3,86,88,83,83,82,85,87,72,71,3,69,92,3,72,91,72,70,88,87,82,85,4},29))
end
else
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,58,68,76,87,76,81,74,3,73,82,85,3,71,76,68,79,82,74,88,72,3,69,88,87,87,82,81,3,87,82,3,69,72,70,82,80,72,3,89,76,86,76,69,79,72,17,17,17},29))
end
task.wait(0.8)
end
if not chatGui.Enabled then
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,39,76,68,79,82,74,88,72,3,70,79,82,86,72,71,17,3,52,88,72,86,87,3,68,70,70,72,83,87,72,71,3,86,88,70,70,72,86,86,73,88,79,79,92,4},29))
else
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,54,72,84,88,72,81,70,72,3,73,76,81,76,86,75,72,71,15,3,69,88,87,3,71,76,68,79,82,74,88,72,3,76,86,3,86,87,76,79,79,3,82,83,72,81,17},29))
end
end
testQuestAcceptance()
end)()