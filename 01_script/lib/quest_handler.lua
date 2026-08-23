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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({42,44,31,79},36))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({49,76,76,65,78,48,75,78,79,75},36))
local prompt = torso and torso:FindFirstChild(_d({44,78,75,73,76,80},36))
if not prompt then
warn(_d({55,45,81,65,79,80,252,36,61,74,64,72,65,78,57,252,42,75,252,76,78,75,73,76,80,252,66,75,81,74,64,252,66,75,78,252,42,44,31,22,252},36) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({55,45,81,65,79,80,252,36,61,74,64,72,65,78,57,252,44,72,61,85,65,78,252,80,75,75,252,66,61,78,252,66,78,75,73,252,42,44,31,22,252},36) .. tostring(npcName) .. _d({252,4,32,69,79,80,22,252},36) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({44,72,61,85,65,78,35,81,69},36))
local chatGui = playerGui and playerGui:FindFirstChild(_d({42,44,31,31,36,29,48},36))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({55,45,81,65,79,80,252,36,61,74,64,72,65,78,57,252,66,69,78,65,76,78,75,84,69,73,69,80,85,76,78,75,73,76,80,252,74,75,80,252,79,81,76,76,75,78,80,65,64,252,62,85,252,65,84,65,63,81,80,75,78,253},36))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({42,44,31,31,36,29,48},36))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({34,78,61,73,65},36))
local goBtn = frame and frame:FindFirstChild(_d({67,75},36))
local endChatBtn = frame and frame:FindFirstChild(_d({65,74,64,31,68,61,80},36))
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