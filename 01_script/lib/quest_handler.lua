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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({20,22,9,57},58))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({27,54,54,43,56,26,53,56,57,53},58))
local prompt = torso and torso:FindFirstChild(_d({22,56,53,51,54,58},58))
if not prompt then
warn(_d({33,23,59,43,57,58,230,14,39,52,42,50,43,56,35,230,20,53,230,54,56,53,51,54,58,230,44,53,59,52,42,230,44,53,56,230,20,22,9,0,230},58) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({33,23,59,43,57,58,230,14,39,52,42,50,43,56,35,230,22,50,39,63,43,56,230,58,53,53,230,44,39,56,230,44,56,53,51,230,20,22,9,0,230},58) .. tostring(npcName) .. _d({230,238,10,47,57,58,0,230},58) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({22,50,39,63,43,56,13,59,47},58))
local chatGui = playerGui and playerGui:FindFirstChild(_d({20,22,9,9,14,7,26},58))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({33,23,59,43,57,58,230,14,39,52,42,50,43,56,35,230,44,47,56,43,54,56,53,62,47,51,47,58,63,54,56,53,51,54,58,230,52,53,58,230,57,59,54,54,53,56,58,43,42,230,40,63,230,43,62,43,41,59,58,53,56,231},58))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({20,22,9,9,14,7,26},58))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({12,56,39,51,43},58))
local goBtn = frame and frame:FindFirstChild(_d({45,53},58))
local endChatBtn = frame and frame:FindFirstChild(_d({43,52,42,9,46,39,58},58))
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