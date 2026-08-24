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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({26,71,69,65},40)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({8,9,5,63,72,71,7,68,65,58,7,59,71,74,61,6,68,77,57},40)) then
Core = loadstring(readfile(_d({8,9,5,63,72,71,7,68,65,58,7,59,71,74,61,6,68,77,57},40)))()
else
Core = loadstring(game:HttpGet(_d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,74,71,59,67,81,80,79,57,68,68,7,68,77,57,77,5,59,71,60,61,7,69,57,65,70,7,8,9,55,75,59,74,65,72,76,7,68,65,58,7,59,71,74,61,6,68,77,57},40)))()
end
end)
if not Core then warn(_d({51,27,71,74,61,53,248,30,57,65,68,61,60,248,76,71,248,68,71,57,60,249},40)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({38,40,27,75},40))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({45,72,72,61,74,44,71,74,75,71},40))
local prompt = torso and torso:FindFirstChild(_d({40,74,71,69,72,76},40))
if not prompt then
warn(_d({51,41,77,61,75,76,248,32,57,70,60,68,61,74,53,248,38,71,248,72,74,71,69,72,76,248,62,71,77,70,60,248,62,71,74,248,38,40,27,18,248},40) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({51,41,77,61,75,76,248,32,57,70,60,68,61,74,53,248,40,68,57,81,61,74,248,76,71,71,248,62,57,74,248,62,74,71,69,248,38,40,27,18,248},40) .. tostring(npcName) .. _d({248,0,28,65,75,76,18,248},40) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({40,68,57,81,61,74,31,77,65},40))
local chatGui = playerGui and playerGui:FindFirstChild(_d({38,40,27,27,32,25,44},40))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({51,41,77,61,75,76,248,32,57,70,60,68,61,74,53,248,62,65,74,61,72,74,71,80,65,69,65,76,81,72,74,71,69,72,76,248,70,71,76,248,75,77,72,72,71,74,76,61,60,248,58,81,248,61,80,61,59,77,76,71,74,249},40))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({38,40,27,27,32,25,44},40))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({30,74,57,69,61},40))
local goBtn = frame and frame:FindFirstChild(_d({63,71},40))
local endChatBtn = frame and frame:FindFirstChild(_d({61,70,60,27,64,57,76},40))
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
if not Safeguard then warn(_d({51,43,57,62,61,63,77,57,74,60,53,248,30,57,65,68,61,60,248,76,71,248,68,71,57,60,249},40)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({51,41,77,61,75,76,248,32,57,70,60,68,61,74,53,248,25,76,76,61,69,72,76,65,70,63,248,76,71,248,76,57,68,67,248,76,71,248,76,61,75,76,248,38,40,27,18},40), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({51,41,77,61,75,76,248,32,57,70,60,68,61,74,53,248,43,76,71,72,72,61,60,6},40))
end
Core.SetupStandalone(
QuestHandler,
_d({41,77,61,75,76,248,32,57,70,60,68,61,74},40),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()