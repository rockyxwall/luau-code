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
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({30,75,73,69},36)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({12,13,9,67,76,75,11,72,69,62,11,63,75,78,65,10,72,81,61},36)) then
Core = loadstring(readfile(_d({12,13,9,67,76,75,11,72,69,62,11,63,75,78,65,10,72,81,61},36)))()
else
Core = loadstring(game:HttpGet(_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,63,75,78,65,10,72,81,61},36)))()
end
end)
if not Core then warn(_d({55,31,75,78,65,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
local Safeguard = Core.GetSafeguard()
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
function QuestHandler.Start()
if QuestHandler.Running then return end
if not Safeguard then warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({55,45,81,65,79,80,252,36,61,74,64,72,65,78,57,252,29,80,80,65,73,76,80,69,74,67,252,80,75,252,80,61,72,71,252,80,75,252,80,65,79,80,252,42,44,31,22},36), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({55,45,81,65,79,80,252,36,61,74,64,72,65,78,57,252,47,80,75,76,76,65,64,10},36))
end
Core.SetupStandalone(
QuestHandler,
_d({45,81,65,79,80,252,36,61,74,64,72,65,78},36),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()