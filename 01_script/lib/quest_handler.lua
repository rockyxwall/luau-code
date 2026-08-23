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
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({56,58,45,93},22))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({63,90,90,79,92,62,89,92,93,89},22))
local prompt = torso and torso:FindFirstChild(_d({58,92,89,87,90,94},22))
if not prompt then
warn(_d({69,59,95,79,93,94,10,50,75,88,78,86,79,92,71,10,56,89,10,90,92,89,87,90,94,10,80,89,95,88,78,10,80,89,92,10,56,58,45,36,10},22) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({69,59,95,79,93,94,10,50,75,88,78,86,79,92,71,10,58,86,75,99,79,92,10,94,89,89,10,80,75,92,10,80,92,89,87,10,56,58,45,36,10},22) .. tostring(npcName) .. _d({10,18,46,83,93,94,36,10},22) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({58,86,75,99,79,92,49,95,83},22))
local chatGui = playerGui and playerGui:FindFirstChild(_d({56,58,45,45,50,43,62},22))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({69,59,95,79,93,94,10,50,75,88,78,86,79,92,71,10,80,83,92,79,90,92,89,98,83,87,83,94,99,90,92,89,87,90,94,10,88,89,94,10,93,95,90,90,89,92,94,79,78,10,76,99,10,79,98,79,77,95,94,89,92,11},22))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({56,58,45,45,50,43,62},22))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({48,92,75,87,79},22))
local goBtn = frame and frame:FindFirstChild(_d({81,89},22))
local endChatBtn = frame and frame:FindFirstChild(_d({79,88,78,45,82,75,94},22))
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