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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({32,34,21,69},46))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({39,66,66,55,68,38,65,68,69,65},46))
local prompt = torso and torso:FindFirstChild(_d({34,68,65,63,66,70},46))
if not prompt then
warn(_d({45,35,71,55,69,70,242,26,51,64,54,62,55,68,47,242,32,65,242,66,68,65,63,66,70,242,56,65,71,64,54,242,56,65,68,242,32,34,21,12,242},46) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({45,35,71,55,69,70,242,26,51,64,54,62,55,68,47,242,34,62,51,75,55,68,242,70,65,65,242,56,51,68,242,56,68,65,63,242,32,34,21,12,242},46) .. tostring(npcName) .. _d({242,250,22,59,69,70,12,242},46) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({34,62,51,75,55,68,25,71,59},46))
local chatGui = playerGui and playerGui:FindFirstChild(_d({32,34,21,21,26,19,38},46))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({45,35,71,55,69,70,242,26,51,64,54,62,55,68,47,242,56,59,68,55,66,68,65,74,59,63,59,70,75,66,68,65,63,66,70,242,64,65,70,242,69,71,66,66,65,68,70,55,54,242,52,75,242,55,74,55,53,71,70,65,68,243},46))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({32,34,21,21,26,19,38},46))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({24,68,51,63,55},46))
local goBtn = frame and frame:FindFirstChild(_d({57,65},46))
local endChatBtn = frame and frame:FindFirstChild(_d({55,64,54,21,58,51,70},46))
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