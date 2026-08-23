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
local Players = game:GetService(_d({31,59,48,72,52,65,66},49))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({29,31,18,66},49))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({36,63,63,52,65,35,62,65,66,62},49))
local prompt = torso and torso:FindFirstChild(_d({31,65,62,60,63,67},49))
if not prompt then
warn(_d({42,32,68,52,66,67,239,23,48,61,51,59,52,65,44,239,29,62,239,63,65,62,60,63,67,239,53,62,68,61,51,239,53,62,65,239,29,31,18,9,239},49) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({42,32,68,52,66,67,239,23,48,61,51,59,52,65,44,239,31,59,48,72,52,65,239,67,62,62,239,53,48,65,239,53,65,62,60,239,29,31,18,9,239},49) .. tostring(npcName) .. _d({239,247,19,56,66,67,9,239},49) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({31,59,48,72,52,65,22,68,56},49))
local chatGui = playerGui and playerGui:FindFirstChild(_d({29,31,18,18,23,16,35},49))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({42,32,68,52,66,67,239,23,48,61,51,59,52,65,44,239,53,56,65,52,63,65,62,71,56,60,56,67,72,63,65,62,60,63,67,239,61,62,67,239,66,68,63,63,62,65,67,52,51,239,49,72,239,52,71,52,50,68,67,62,65,240},49))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({29,31,18,18,23,16,35},49))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({21,65,48,60,52},49))
local goBtn = frame and frame:FindFirstChild(_d({54,62},49))
local endChatBtn = frame and frame:FindFirstChild(_d({52,61,51,18,55,48,67},49))
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