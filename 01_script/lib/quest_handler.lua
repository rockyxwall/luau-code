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
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({60,62,49,97},18))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({67,94,94,83,96,66,93,96,97,93},18))
local prompt = torso and torso:FindFirstChild(_d({62,96,93,91,94,98},18))
if not prompt then
warn(_d({73,63,99,83,97,98,14,54,79,92,82,90,83,96,75,14,60,93,14,94,96,93,91,94,98,14,84,93,99,92,82,14,84,93,96,14,60,62,49,40,14},18) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({73,63,99,83,97,98,14,54,79,92,82,90,83,96,75,14,62,90,79,103,83,96,14,98,93,93,14,84,79,96,14,84,96,93,91,14,60,62,49,40,14},18) .. tostring(npcName) .. _d({14,22,50,87,97,98,40,14},18) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({62,90,79,103,83,96,53,99,87},18))
local chatGui = playerGui and playerGui:FindFirstChild(_d({60,62,49,49,54,47,66},18))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({73,63,99,83,97,98,14,54,79,92,82,90,83,96,75,14,84,87,96,83,94,96,93,102,87,91,87,98,103,94,96,93,91,94,98,14,92,93,98,14,97,99,94,94,93,96,98,83,82,14,80,103,14,83,102,83,81,99,98,93,96,15},18))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({60,62,49,49,54,47,66},18))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({52,96,79,91,83},18))
local goBtn = frame and frame:FindFirstChild(_d({85,93},18))
local endChatBtn = frame and frame:FindFirstChild(_d({83,92,82,49,86,79,98},18))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.Activated)) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
pcall(function() conn:Fire() end)
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
for _, conn in ipairs(getconnections(endChatBtn.Activated)) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
pcall(function() conn:Fire() end)
end
end
end
task.wait(0.8)
end
end
return true
end
_G.QuestHandler = QuestHandler
return QuestHandler
end)()