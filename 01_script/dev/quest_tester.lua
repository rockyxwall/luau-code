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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({50,52,39,87},28))
if not npcsFolder then return nil end
local nearest, minDist = nil, 4
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({57,84,84,73,86,56,83,86,87,83},28))
local prompt = torso and torso:FindFirstChild(_d({52,86,83,81,84,88},28))
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
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,50,83,4,85,89,73,87,88,4,50,52,39,4,74,83,89,82,72,4,91,77,88,76,77,82,4,24,4,87,88,89,72,87,18},28))
return
end
local torso = npc.UpperTorso
local prompt = torso:FindFirstChild(_d({52,86,83,81,84,88},28))
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,45,82,88,73,86,69,71,88,77,82,75,4,91,77,88,76,4,50,52,39,30,4},28) .. npc.Name)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,41,54,54,51,54,30,4,74,77,86,73,84,86,83,92,77,81,77,88,93,84,86,83,81,84,88,4,77,87,4,82,83,88,4,87,89,84,84,83,86,88,73,72,4,70,93,4,93,83,89,86,4,73,92,73,71,89,88,83,86,5},28))
return
end
task.wait(1.0)
local playerGui = LocalPlayer:FindFirstChild(_d({52,80,69,93,73,86,43,89,77},28))
local chatGui = playerGui and playerGui:FindFirstChild(_d({50,52,39,39,44,37,56},28))
if not chatGui then
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,41,54,54,51,54,30,4,50,52,39,39,44,37,56,4,55,71,86,73,73,82,43,89,77,4,82,83,88,4,74,83,89,82,72,4,77,82,4,52,80,69,93,73,86,43,89,77,18},28))
return
end
if not chatGui.Enabled then
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,41,54,54,51,54,30,4,50,52,39,39,44,37,56,4,43,57,45,4,77,87,4,82,83,88,4,73,82,69,70,80,73,72,19,90,77,87,77,70,80,73,18},28))
return
end
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,50,52,39,39,44,37,56,4,83,84,73,82,73,72,4,87,89,71,71,73,87,87,74,89,80,80,93,5,4,55,88,69,86,88,77,82,75,4,71,80,77,71,79,4,87,73,85,89,73,82,71,73,18,18,18},28))
local tries = 0
while chatGui.Enabled and tries < 10 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({75,83},28))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({73,82,72,39,76,69,88},28))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({18,18,18},28) then
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,39,80,77,71,79,77,82,75,4,11,75,83,11,4,12,37,71,71,73,84,88,4,51,84,88,77,83,82,13,4,70,89,88,88,83,82,30,4},28) .. tostring(goBtn.Text))
if getconnections then
local clickConns = getconnections(goBtn.MouseButton1Click)
local activatedConns = getconnections(goBtn.Activated)
print(string.format(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,11,75,83,11,4,71,83,82,82,73,71,88,77,83,82,87,4,74,83,89,82,72,30,4,49,83,89,87,73,38,89,88,88,83,82,21,39,80,77,71,79,4,12,9,72,13,16,4,37,71,88,77,90,69,88,73,72,4,12,9,72,13},28), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,41,54,54,51,54,30,4,75,73,88,71,83,82,82,73,71,88,77,83,82,87,4,82,83,88,4,87,89,84,84,83,86,88,73,72,4,70,93,4,73,92,73,71,89,88,83,86,5},28))
end
elseif endChatBtn and endChatBtn.Visible then
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,39,80,77,71,79,77,82,75,4,11,73,82,72,39,76,69,88,11,4,12,37,72,90,69,82,71,73,4,40,77,69,80,83,75,13,4,70,89,88,88,83,82,18},28))
if getconnections then
local clickConns = getconnections(endChatBtn.MouseButton1Click)
local activatedConns = getconnections(endChatBtn.Activated)
print(string.format(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,11,73,82,72,39,76,69,88,11,4,71,83,82,82,73,71,88,77,83,82,87,4,74,83,89,82,72,30,4,49,83,89,87,73,38,89,88,88,83,82,21,39,80,77,71,79,4,12,9,72,13,16,4,37,71,88,77,90,69,88,73,72,4,12,9,72,13},28), #clickConns, #activatedConns))
for _, conn in ipairs(clickConns) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(activatedConns) do
pcall(function() conn:Fire() end)
end
else
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,41,54,54,51,54,30,4,75,73,88,71,83,82,82,73,71,88,77,83,82,87,4,82,83,88,4,87,89,84,84,83,86,88,73,72,4,70,93,4,73,92,73,71,89,88,83,86,5},28))
end
else
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,59,69,77,88,77,82,75,4,74,83,86,4,72,77,69,80,83,75,89,73,4,70,89,88,88,83,82,4,88,83,4,70,73,71,83,81,73,4,90,77,87,77,70,80,73,18,18,18},28))
end
task.wait(0.5)
end
if not chatGui.Enabled then
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,40,77,69,80,83,75,89,73,4,71,80,83,87,73,72,18,4,53,89,73,87,88,4,69,71,71,73,84,88,73,72,4,87,89,71,71,73,87,87,74,89,80,80,93,5},28))
else
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,55,73,85,89,73,82,71,73,4,74,77,82,77,87,76,73,72,16,4,70,89,88,4,72,77,69,80,83,75,89,73,4,77,87,4,87,88,77,80,80,4,83,84,73,82,18},28))
end
end
testQuestAcceptance()
end)()