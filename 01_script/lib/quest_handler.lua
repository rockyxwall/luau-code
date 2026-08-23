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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({15,17,4,52},63))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({22,49,49,38,51,21,48,51,52,48},63))
local prompt = torso and torso:FindFirstChild(_d({17,51,48,46,49,53},63))
if not prompt then
warn(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,15,48,225,49,51,48,46,49,53,225,39,48,54,47,37,225,39,48,51,225,15,17,4,251,225},63) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,17,45,34,58,38,51,225,53,48,48,225,39,34,51,225,39,51,48,46,225,15,17,4,251,225},63) .. tostring(npcName) .. _d({225,233,5,42,52,53,251,225},63) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({17,45,34,58,38,51,8,54,42},63))
local chatGui = playerGui and playerGui:FindFirstChild(_d({15,17,4,4,9,2,21},63))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,39,42,51,38,49,51,48,57,42,46,42,53,58,49,51,48,46,49,53,225,47,48,53,225,52,54,49,49,48,51,53,38,37,225,35,58,225,38,57,38,36,54,53,48,51,226},63))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({15,17,4,4,9,2,21},63))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({7,51,34,46,38},63))
local goBtn = frame and frame:FindFirstChild(_d({40,48},63))
local endChatBtn = frame and frame:FindFirstChild(_d({38,47,37,4,41,34,53},63))
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