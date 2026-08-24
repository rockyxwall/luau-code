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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({21,66,64,60},45)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({3,4,0,58,67,66,2,63,60,53,2,54,66,69,56,1,63,72,52},45)) then
Core = loadstring(readfile(_d({3,4,0,58,67,66,2,63,60,53,2,54,66,69,56,1,63,72,52},45)))()
else
Core = loadstring(game:HttpGet(_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,54,66,69,56,1,63,72,52},45)))()
end
end)
if not Core then warn(_d({46,22,66,69,56,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,244},45)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({33,35,22,70},45))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({40,67,67,56,69,39,66,69,70,66},45))
local prompt = torso and torso:FindFirstChild(_d({35,69,66,64,67,71},45))
if not prompt then
warn(_d({46,36,72,56,70,71,243,27,52,65,55,63,56,69,48,243,33,66,243,67,69,66,64,67,71,243,57,66,72,65,55,243,57,66,69,243,33,35,22,13,243},45) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({46,36,72,56,70,71,243,27,52,65,55,63,56,69,48,243,35,63,52,76,56,69,243,71,66,66,243,57,52,69,243,57,69,66,64,243,33,35,22,13,243},45) .. tostring(npcName) .. _d({243,251,23,60,70,71,13,243},45) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({35,63,52,76,56,69,26,72,60},45))
local chatGui = playerGui and playerGui:FindFirstChild(_d({33,35,22,22,27,20,39},45))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({46,36,72,56,70,71,243,27,52,65,55,63,56,69,48,243,57,60,69,56,67,69,66,75,60,64,60,71,76,67,69,66,64,67,71,243,65,66,71,243,70,72,67,67,66,69,71,56,55,243,53,76,243,56,75,56,54,72,71,66,69,244},45))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({33,35,22,22,27,20,39},45))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({25,69,52,64,56},45))
local goBtn = frame and frame:FindFirstChild(_d({58,66},45))
local endChatBtn = frame and frame:FindFirstChild(_d({56,65,55,22,59,52,71},45))
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
if not Safeguard then warn(_d({46,38,52,57,56,58,72,52,69,55,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,244},45)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({46,36,72,56,70,71,243,27,52,65,55,63,56,69,48,243,20,71,71,56,64,67,71,60,65,58,243,71,66,243,71,52,63,62,243,71,66,243,71,56,70,71,243,33,35,22,13},45), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({46,36,72,56,70,71,243,27,52,65,55,63,56,69,48,243,38,71,66,67,67,56,55,1},45))
end
Core.SetupStandalone(
QuestHandler,
_d({36,72,56,70,71,243,27,52,65,55,63,56,69},45),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()