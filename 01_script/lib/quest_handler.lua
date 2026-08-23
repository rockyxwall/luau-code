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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({24,51,51,40,53,23,50,53,54,50},61))
local prompt = torso and torso:FindFirstChild(_d({19,53,50,48,51,55},61))
if not prompt then
warn(_d({30,20,56,40,54,55,227,11,36,49,39,47,40,53,32,227,17,50,227,51,53,50,48,51,55,227,41,50,56,49,39,227,41,50,53,227,17,19,6,253,227},61) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({30,20,56,40,54,55,227,11,36,49,39,47,40,53,32,227,19,47,36,60,40,53,227,55,50,50,227,41,36,53,227,41,53,50,48,227,17,19,6,253,227},61) .. tostring(npcName) .. _d({227,235,7,44,54,55,253,227},61) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({19,47,36,60,40,53,10,56,44},61))
local chatGui = playerGui and playerGui:FindFirstChild(_d({17,19,6,6,11,4,23},61))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({30,20,56,40,54,55,227,11,36,49,39,47,40,53,32,227,41,44,53,40,51,53,50,59,44,48,44,55,60,51,53,50,48,51,55,227,49,50,55,227,54,56,51,51,50,53,55,40,39,227,37,60,227,40,59,40,38,56,55,50,53,228},61))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({17,19,6,6,11,4,23},61))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({9,53,36,48,40},61))
local goBtn = frame and frame:FindFirstChild(_d({42,50},61))
local endChatBtn = frame and frame:FindFirstChild(_d({40,49,39,6,43,36,55},61))
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