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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({63,65,52,100},15))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({70,97,97,86,99,69,96,99,100,96},15))
local prompt = torso and torso:FindFirstChild(_d({65,99,96,94,97,101},15))
if not prompt then
warn(_d({76,66,102,86,100,101,17,57,82,95,85,93,86,99,78,17,63,96,17,97,99,96,94,97,101,17,87,96,102,95,85,17,87,96,99,17,63,65,52,43,17},15) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({76,66,102,86,100,101,17,57,82,95,85,93,86,99,78,17,65,93,82,106,86,99,17,101,96,96,17,87,82,99,17,87,99,96,94,17,63,65,52,43,17},15) .. tostring(npcName) .. _d({17,25,53,90,100,101,43,17},15) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({65,93,82,106,86,99,56,102,90},15))
local chatGui = playerGui and playerGui:FindFirstChild(_d({63,65,52,52,57,50,69},15))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({76,66,102,86,100,101,17,57,82,95,85,93,86,99,78,17,87,90,99,86,97,99,96,105,90,94,90,101,106,97,99,96,94,97,101,17,95,96,101,17,100,102,97,97,96,99,101,86,85,17,83,106,17,86,105,86,84,102,101,96,99,18},15))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({63,65,52,52,57,50,69},15))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({55,99,82,94,86},15))
local goBtn = frame and frame:FindFirstChild(_d({88,96},15))
local endChatBtn = frame and frame:FindFirstChild(_d({86,95,85,52,89,82,101},15))
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