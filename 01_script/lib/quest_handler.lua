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
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({22,24,11,59},56))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({29,56,56,45,58,28,55,58,59,55},56))
local prompt = torso and torso:FindFirstChild(_d({24,58,55,53,56,60},56))
if not prompt then
warn(_d({35,25,61,45,59,60,232,16,41,54,44,52,45,58,37,232,22,55,232,56,58,55,53,56,60,232,46,55,61,54,44,232,46,55,58,232,22,24,11,2,232},56) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({35,25,61,45,59,60,232,16,41,54,44,52,45,58,37,232,24,52,41,65,45,58,232,60,55,55,232,46,41,58,232,46,58,55,53,232,22,24,11,2,232},56) .. tostring(npcName) .. _d({232,240,12,49,59,60,2,232},56) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({24,52,41,65,45,58,15,61,49},56))
local chatGui = playerGui and playerGui:FindFirstChild(_d({22,24,11,11,16,9,28},56))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({35,25,61,45,59,60,232,16,41,54,44,52,45,58,37,232,46,49,58,45,56,58,55,64,49,53,49,60,65,56,58,55,53,56,60,232,54,55,60,232,59,61,56,56,55,58,60,45,44,232,42,65,232,45,64,45,43,61,60,55,58,233},56))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({22,24,11,11,16,9,28},56))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({14,58,41,53,45},56))
local goBtn = frame and frame:FindFirstChild(_d({47,55},56))
local endChatBtn = frame and frame:FindFirstChild(_d({45,54,44,11,48,41,60},56))
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