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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({30,32,19,67},48))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({37,64,64,53,66,36,63,66,67,63},48))
local prompt = torso and torso:FindFirstChild(_d({32,66,63,61,64,68},48))
if not prompt then
warn(_d({43,33,69,53,67,68,240,24,49,62,52,60,53,66,45,240,30,63,240,64,66,63,61,64,68,240,54,63,69,62,52,240,54,63,66,240,30,32,19,10,240},48) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({43,33,69,53,67,68,240,24,49,62,52,60,53,66,45,240,32,60,49,73,53,66,240,68,63,63,240,54,49,66,240,54,66,63,61,240,30,32,19,10,240},48) .. tostring(npcName) .. _d({240,248,20,57,67,68,10,240},48) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({32,60,49,73,53,66,23,69,57},48))
local chatGui = playerGui and playerGui:FindFirstChild(_d({30,32,19,19,24,17,36},48))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({43,33,69,53,67,68,240,24,49,62,52,60,53,66,45,240,54,57,66,53,64,66,63,72,57,61,57,68,73,64,66,63,61,64,68,240,62,63,68,240,67,69,64,64,63,66,68,53,52,240,50,73,240,53,72,53,51,69,68,63,66,241},48))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({30,32,19,19,24,17,36},48))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({22,66,49,61,53},48))
local goBtn = frame and frame:FindFirstChild(_d({55,63},48))
local endChatBtn = frame and frame:FindFirstChild(_d({53,62,52,19,56,49,68},48))
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