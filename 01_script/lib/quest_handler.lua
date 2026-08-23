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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({44,46,33,81},34))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({51,78,78,67,80,50,77,80,81,77},34))
local prompt = torso and torso:FindFirstChild(_d({46,80,77,75,78,82},34))
if not prompt then
warn(_d({57,47,83,67,81,82,254,38,63,76,66,74,67,80,59,254,44,77,254,78,80,77,75,78,82,254,68,77,83,76,66,254,68,77,80,254,44,46,33,24,254},34) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({57,47,83,67,81,82,254,38,63,76,66,74,67,80,59,254,46,74,63,87,67,80,254,82,77,77,254,68,63,80,254,68,80,77,75,254,44,46,33,24,254},34) .. tostring(npcName) .. _d({254,6,34,71,81,82,24,254},34) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({46,74,63,87,67,80,37,83,71},34))
local chatGui = playerGui and playerGui:FindFirstChild(_d({44,46,33,33,38,31,50},34))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({57,47,83,67,81,82,254,38,63,76,66,74,67,80,59,254,68,71,80,67,78,80,77,86,71,75,71,82,87,78,80,77,75,78,82,254,76,77,82,254,81,83,78,78,77,80,82,67,66,254,64,87,254,67,86,67,65,83,82,77,80,255},34))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({44,46,33,33,38,31,50},34))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({36,80,63,75,67},34))
local goBtn = frame and frame:FindFirstChild(_d({69,77},34))
local endChatBtn = frame and frame:FindFirstChild(_d({67,76,66,33,70,63,82},34))
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