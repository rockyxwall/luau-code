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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({41,43,30,78},37))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({48,75,75,64,77,47,74,77,78,74},37))
local prompt = torso and torso:FindFirstChild(_d({43,77,74,72,75,79},37))
if not prompt then
warn(_d({54,44,80,64,78,79,251,35,60,73,63,71,64,77,56,251,41,74,251,75,77,74,72,75,79,251,65,74,80,73,63,251,65,74,77,251,41,43,30,21,251},37) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({54,44,80,64,78,79,251,35,60,73,63,71,64,77,56,251,43,71,60,84,64,77,251,79,74,74,251,65,60,77,251,65,77,74,72,251,41,43,30,21,251},37) .. tostring(npcName) .. _d({251,3,31,68,78,79,21,251},37) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({43,71,60,84,64,77,34,80,68},37))
local chatGui = playerGui and playerGui:FindFirstChild(_d({41,43,30,30,35,28,47},37))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({54,44,80,64,78,79,251,35,60,73,63,71,64,77,56,251,65,68,77,64,75,77,74,83,68,72,68,79,84,75,77,74,72,75,79,251,73,74,79,251,78,80,75,75,74,77,79,64,63,251,61,84,251,64,83,64,62,80,79,74,77,252},37))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({41,43,30,30,35,28,47},37))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({33,77,60,72,64},37))
local goBtn = frame and frame:FindFirstChild(_d({66,74},37))
local endChatBtn = frame and frame:FindFirstChild(_d({64,73,63,30,67,60,79},37))
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