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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({52,54,41,89},26))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({59,86,86,75,88,58,85,88,89,85},26))
local prompt = torso and torso:FindFirstChild(_d({54,88,85,83,86,90},26))
if not prompt then
warn(_d({65,55,91,75,89,90,6,46,71,84,74,82,75,88,67,6,52,85,6,86,88,85,83,86,90,6,76,85,91,84,74,6,76,85,88,6,52,54,41,32,6},26) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({65,55,91,75,89,90,6,46,71,84,74,82,75,88,67,6,54,82,71,95,75,88,6,90,85,85,6,76,71,88,6,76,88,85,83,6,52,54,41,32,6},26) .. tostring(npcName) .. _d({6,14,42,79,89,90,32,6},26) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({54,82,71,95,75,88,45,91,79},26))
local chatGui = playerGui and playerGui:FindFirstChild(_d({52,54,41,41,46,39,58},26))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({65,55,91,75,89,90,6,46,71,84,74,82,75,88,67,6,76,79,88,75,86,88,85,94,79,83,79,90,95,86,88,85,83,86,90,6,84,85,90,6,89,91,86,86,85,88,90,75,74,6,72,95,6,75,94,75,73,91,90,85,88,7},26))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({52,54,41,41,46,39,58},26))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({44,88,71,83,75},26))
local goBtn = frame and frame:FindFirstChild(_d({77,85},26))
local endChatBtn = frame and frame:FindFirstChild(_d({75,84,74,41,78,71,90},26))
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