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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({44,71,71,60,73,43,70,73,74,70},41))
local prompt = torso and torso:FindFirstChild(_d({39,73,70,68,71,75},41))
if not prompt then
warn(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,37,70,247,71,73,70,68,71,75,247,61,70,76,69,59,247,61,70,73,247,37,39,26,17,247},41) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,39,67,56,80,60,73,247,75,70,70,247,61,56,73,247,61,73,70,68,247,37,39,26,17,247},41) .. tostring(npcName) .. _d({247,255,27,64,74,75,17,247},41) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({39,67,56,80,60,73,30,76,64},41))
local chatGui = playerGui and playerGui:FindFirstChild(_d({37,39,26,26,31,24,43},41))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,61,64,73,60,71,73,70,79,64,68,64,75,80,71,73,70,68,71,75,247,69,70,75,247,74,76,71,71,70,73,75,60,59,247,57,80,247,60,79,60,58,76,75,70,73,248},41))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({37,39,26,26,31,24,43},41))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({29,73,56,68,60},41))
local goBtn = frame and frame:FindFirstChild(_d({62,70},41))
local endChatBtn = frame and frame:FindFirstChild(_d({60,69,59,26,63,56,75},41))
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