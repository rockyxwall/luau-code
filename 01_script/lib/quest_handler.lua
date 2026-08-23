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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({31,33,20,68},47))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({38,65,65,54,67,37,64,67,68,64},47))
local prompt = torso and torso:FindFirstChild(_d({33,67,64,62,65,69},47))
if not prompt then
warn(_d({44,34,70,54,68,69,241,25,50,63,53,61,54,67,46,241,31,64,241,65,67,64,62,65,69,241,55,64,70,63,53,241,55,64,67,241,31,33,20,11,241},47) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({44,34,70,54,68,69,241,25,50,63,53,61,54,67,46,241,33,61,50,74,54,67,241,69,64,64,241,55,50,67,241,55,67,64,62,241,31,33,20,11,241},47) .. tostring(npcName) .. _d({241,249,21,58,68,69,11,241},47) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({33,61,50,74,54,67,24,70,58},47))
local chatGui = playerGui and playerGui:FindFirstChild(_d({31,33,20,20,25,18,37},47))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({44,34,70,54,68,69,241,25,50,63,53,61,54,67,46,241,55,58,67,54,65,67,64,73,58,62,58,69,74,65,67,64,62,65,69,241,63,64,69,241,68,70,65,65,64,67,69,54,53,241,51,74,241,54,73,54,52,70,69,64,67,242},47))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({31,33,20,20,25,18,37},47))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({23,67,50,62,54},47))
local goBtn = frame and frame:FindFirstChild(_d({56,64},47))
local endChatBtn = frame and frame:FindFirstChild(_d({54,63,53,20,57,50,69},47))
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