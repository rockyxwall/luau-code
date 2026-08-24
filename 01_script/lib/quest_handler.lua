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
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({35,80,78,74},31)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({17,18,14,72,81,80,16,77,74,67,16,68,80,83,70,15,77,86,66},31)) then
Core = loadstring(readfile(_d({17,18,14,72,81,80,16,77,74,67,16,68,80,83,70,15,77,86,66},31)))()
else
Core = loadstring(game:HttpGet(_d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,77,86,66,86,14,68,80,69,70,16,78,66,74,79,16,17,18,64,84,68,83,74,81,85,16,77,74,67,16,68,80,83,70,15,77,86,66},31)))()
end
end)
if not Core then warn(_d({60,36,80,83,70,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,2},31)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({47,49,36,84},31))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({54,81,81,70,83,53,80,83,84,80},31))
local prompt = torso and torso:FindFirstChild(_d({49,83,80,78,81,85},31))
if not prompt then
warn(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,47,80,1,81,83,80,78,81,85,1,71,80,86,79,69,1,71,80,83,1,47,49,36,27,1},31) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,49,77,66,90,70,83,1,85,80,80,1,71,66,83,1,71,83,80,78,1,47,49,36,27,1},31) .. tostring(npcName) .. _d({1,9,37,74,84,85,27,1},31) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({49,77,66,90,70,83,40,86,74},31))
local chatGui = playerGui and playerGui:FindFirstChild(_d({47,49,36,36,41,34,53},31))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,71,74,83,70,81,83,80,89,74,78,74,85,90,81,83,80,78,81,85,1,79,80,85,1,84,86,81,81,80,83,85,70,69,1,67,90,1,70,89,70,68,86,85,80,83,2},31))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({47,49,36,36,41,34,53},31))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({39,83,66,78,70},31))
local goBtn = frame and frame:FindFirstChild(_d({72,80},31))
local endChatBtn = frame and frame:FindFirstChild(_d({70,79,69,36,73,66,85},31))
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
if not Safeguard then warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,2},31)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,34,85,85,70,78,81,85,74,79,72,1,85,80,1,85,66,77,76,1,85,80,1,85,70,84,85,1,47,49,36,27},31), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,52,85,80,81,81,70,69,15},31))
end
Core.SetupStandalone(
QuestHandler,
_d({50,86,70,84,85,1,41,66,79,69,77,70,83},31),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()