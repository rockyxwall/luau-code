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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({25,70,68,64},41)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({7,8,4,62,71,70,6,67,64,57,6,58,70,73,60,5,67,76,56},41)) then
Core = loadstring(readfile(_d({7,8,4,62,71,70,6,67,64,57,6,58,70,73,60,5,67,76,56},41)))()
else
Core = loadstring(game:HttpGet(_d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,67,76,56,76,4,58,70,59,60,6,68,56,64,69,6,7,8,54,74,58,73,64,71,75,6,67,64,57,6,58,70,73,60,5,67,76,56},41)))()
end
end)
if not Core then warn(_d({50,26,70,73,60,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,248},41)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({44,71,71,60,73,43,70,73,74,70},41))
local prompt = torso and torso:FindFirstChild(_d({39,73,70,68,71,75},41))
if not prompt then
warn(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,37,70,247,71,73,70,68,71,75,247,61,70,76,69,59,247,61,70,73,247,37,39,26,17,247},41) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,39,67,56,80,60,73,247,75,70,70,247,61,56,73,247,61,73,70,68,247,37,39,26,17,247},41) .. tostring(npcName) .. _d({247,255,27,64,74,75,17,247},41) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({39,67,56,80,60,73,30,76,64},41))
local chatGui = playerGui and playerGui:FindFirstChild(_d({37,39,26,26,31,24,43},41))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,61,64,73,60,71,73,70,79,64,68,64,75,80,71,73,70,68,71,75,247,69,70,75,247,74,76,71,71,70,73,75,60,59,247,57,80,247,60,79,60,58,76,75,70,73,248},41))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({37,39,26,26,31,24,43},41))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({29,73,56,68,60},41))
local goBtn = frame and frame:FindFirstChild(_d({62,70},41))
local endChatBtn = frame and frame:FindFirstChild(_d({60,69,59,26,63,56,75},41))
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
if not Safeguard then warn(_d({50,42,56,61,60,62,76,56,73,59,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,248},41)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,24,75,75,60,68,71,75,64,69,62,247,75,70,247,75,56,67,66,247,75,70,247,75,60,74,75,247,37,39,26,17},41), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,42,75,70,71,71,60,59,5},41))
end
Core.SetupStandalone(
QuestHandler,
_d({40,76,60,74,75,247,31,56,69,59,67,60,73},41),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()