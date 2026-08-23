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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({54,56,43,91},24))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({61,88,88,77,90,60,87,90,91,87},24))
local prompt = torso and torso:FindFirstChild(_d({56,90,87,85,88,92},24))
if not prompt then
warn(_d({67,57,93,77,91,92,8,48,73,86,76,84,77,90,69,8,54,87,8,88,90,87,85,88,92,8,78,87,93,86,76,8,78,87,90,8,54,56,43,34,8},24) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({67,57,93,77,91,92,8,48,73,86,76,84,77,90,69,8,56,84,73,97,77,90,8,92,87,87,8,78,73,90,8,78,90,87,85,8,54,56,43,34,8},24) .. tostring(npcName) .. _d({8,16,44,81,91,92,34,8},24) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({67,57,93,77,91,92,8,48,73,86,76,84,77,90,69,8,78,81,90,77,88,90,87,96,81,85,81,92,97,88,90,87,85,88,92,8,86,87,92,8,91,93,88,88,87,90,92,77,76,8,74,97,8,77,96,77,75,93,92,87,90,9},24))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({56,84,73,97,77,90,47,93,81},24))
local chatGui = playerGui and playerGui:FindFirstChild(_d({54,56,43,43,48,41,60},24))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({46,90,73,85,77},24))
local goBtn = frame and frame:FindFirstChild(_d({79,87},24))
local endChatBtn = frame and frame:FindFirstChild(_d({77,86,76,43,80,73,92},24))
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