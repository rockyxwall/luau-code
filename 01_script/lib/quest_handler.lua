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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({39,41,28,76},39))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({46,73,73,62,75,45,72,75,76,72},39))
local prompt = torso and torso:FindFirstChild(_d({41,75,72,70,73,77},39))
if not prompt then
warn(_d({52,42,78,62,76,77,249,33,58,71,61,69,62,75,54,249,39,72,249,73,75,72,70,73,77,249,63,72,78,71,61,249,63,72,75,249,39,41,28,19,249},39) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({52,42,78,62,76,77,249,33,58,71,61,69,62,75,54,249,41,69,58,82,62,75,249,77,72,72,249,63,58,75,249,63,75,72,70,249,39,41,28,19,249},39) .. tostring(npcName) .. _d({249,1,29,66,76,77,19,249},39) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({41,69,58,82,62,75,32,78,66},39))
local chatGui = playerGui and playerGui:FindFirstChild(_d({39,41,28,28,33,26,45},39))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({52,42,78,62,76,77,249,33,58,71,61,69,62,75,54,249,63,66,75,62,73,75,72,81,66,70,66,77,82,73,75,72,70,73,77,249,71,72,77,249,76,78,73,73,72,75,77,62,61,249,59,82,249,62,81,62,60,78,77,72,75,250},39))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({39,41,28,28,33,26,45},39))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({31,75,58,70,62},39))
local goBtn = frame and frame:FindFirstChild(_d({64,72},39))
local endChatBtn = frame and frame:FindFirstChild(_d({62,71,61,28,65,58,77},39))
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