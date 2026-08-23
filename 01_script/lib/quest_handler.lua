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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({50,52,39,87},28))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({57,84,84,73,86,56,83,86,87,83},28))
local prompt = torso and torso:FindFirstChild(_d({52,86,83,81,84,88},28))
if not prompt then
warn(_d({63,53,89,73,87,88,4,44,69,82,72,80,73,86,65,4,50,83,4,84,86,83,81,84,88,4,74,83,89,82,72,4,74,83,86,4,50,52,39,30,4},28) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({63,53,89,73,87,88,4,44,69,82,72,80,73,86,65,4,52,80,69,93,73,86,4,88,83,83,4,74,69,86,4,74,86,83,81,4,50,52,39,30,4},28) .. tostring(npcName) .. _d({4,12,40,77,87,88,30,4},28) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({63,53,89,73,87,88,4,44,69,82,72,80,73,86,65,4,74,77,86,73,84,86,83,92,77,81,77,88,93,84,86,83,81,84,88,4,82,83,88,4,87,89,84,84,83,86,88,73,72,4,70,93,4,73,92,73,71,89,88,83,86,5},28))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({52,80,69,93,73,86,43,89,77},28))
local chatGui = playerGui and playerGui:FindFirstChild(_d({50,52,39,39,44,37,56},28))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({42,86,69,81,73},28))
local goBtn = frame and frame:FindFirstChild(_d({75,83},28))
local endChatBtn = frame and frame:FindFirstChild(_d({73,82,72,39,76,69,88},28))
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