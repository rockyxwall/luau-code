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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({35,37,24,72},43))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({42,69,69,58,71,41,68,71,72,68},43))
local prompt = torso and torso:FindFirstChild(_d({37,71,68,66,69,73},43))
if not prompt then
warn(_d({48,38,74,58,72,73,245,29,54,67,57,65,58,71,50,245,35,68,245,69,71,68,66,69,73,245,59,68,74,67,57,245,59,68,71,245,35,37,24,15,245},43) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({48,38,74,58,72,73,245,29,54,67,57,65,58,71,50,245,37,65,54,78,58,71,245,73,68,68,245,59,54,71,245,59,71,68,66,245,35,37,24,15,245},43) .. tostring(npcName) .. _d({245,253,25,62,72,73,15,245},43) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({37,65,54,78,58,71,28,74,62},43))
local chatGui = playerGui and playerGui:FindFirstChild(_d({35,37,24,24,29,22,41},43))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({48,38,74,58,72,73,245,29,54,67,57,65,58,71,50,245,59,62,71,58,69,71,68,77,62,66,62,73,78,69,71,68,66,69,73,245,67,68,73,245,72,74,69,69,68,71,73,58,57,245,55,78,245,58,77,58,56,74,73,68,71,246},43))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({35,37,24,24,29,22,41},43))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({27,71,54,66,58},43))
local goBtn = frame and frame:FindFirstChild(_d({60,68},43))
local endChatBtn = frame and frame:FindFirstChild(_d({58,67,57,24,61,54,73},43))
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