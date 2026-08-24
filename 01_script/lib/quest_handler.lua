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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({29,74,72,68},37)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({11,12,8,66,75,74,10,71,68,61,10,62,74,77,64,9,71,80,60},37)) then
Core = loadstring(readfile(_d({11,12,8,66,75,74,10,71,68,61,10,62,74,77,64,9,71,80,60},37)))()
else
Core = loadstring(game:HttpGet(_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,62,74,77,64,9,71,80,60},37)))()
end
end)
if not Core then warn(_d({54,30,74,77,64,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,252},37)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({41,43,30,78},37))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({48,75,75,64,77,47,74,77,78,74},37))
local prompt = torso and torso:FindFirstChild(_d({43,77,74,72,75,79},37))
if not prompt then
warn(_d({54,44,80,64,78,79,251,35,60,73,63,71,64,77,56,251,41,74,251,75,77,74,72,75,79,251,65,74,80,73,63,251,65,74,77,251,41,43,30,21,251},37) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({54,44,80,64,78,79,251,35,60,73,63,71,64,77,56,251,43,71,60,84,64,77,251,79,74,74,251,65,60,77,251,65,77,74,72,251,41,43,30,21,251},37) .. tostring(npcName) .. _d({251,3,31,68,78,79,21,251},37) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({43,71,60,84,64,77,34,80,68},37))
local chatGui = playerGui and playerGui:FindFirstChild(_d({41,43,30,30,35,28,47},37))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({54,44,80,64,78,79,251,35,60,73,63,71,64,77,56,251,65,68,77,64,75,77,74,83,68,72,68,79,84,75,77,74,72,75,79,251,73,74,79,251,78,80,75,75,74,77,79,64,63,251,61,84,251,64,83,64,62,80,79,74,77,252},37))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({41,43,30,30,35,28,47},37))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({33,77,60,72,64},37))
local goBtn = frame and frame:FindFirstChild(_d({66,74},37))
local endChatBtn = frame and frame:FindFirstChild(_d({64,73,63,30,67,60,79},37))
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
if not Safeguard then warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,252},37)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({54,44,80,64,78,79,251,35,60,73,63,71,64,77,56,251,28,79,79,64,72,75,79,68,73,66,251,79,74,251,79,60,71,70,251,79,74,251,79,64,78,79,251,41,43,30,21},37), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({54,44,80,64,78,79,251,35,60,73,63,71,64,77,56,251,46,79,74,75,75,64,63,9},37))
end
Core.SetupStandalone(
QuestHandler,
_d({44,80,64,78,79,251,35,60,73,63,71,64,77},37),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()