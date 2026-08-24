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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({4,49,47,43},62)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({242,243,239,41,50,49,241,46,43,36,241,37,49,52,39,240,46,55,35},62)) then
Core = loadstring(readfile(_d({242,243,239,41,50,49,241,46,43,36,241,37,49,52,39,240,46,55,35},62)))()
else
Core = loadstring(game:HttpGet(_d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,46,55,35,55,239,37,49,38,39,241,47,35,43,48,241,242,243,33,53,37,52,43,50,54,241,46,43,36,241,37,49,52,39,240,46,55,35},62)))()
end
end)
if not Core then warn(_d({29,5,49,52,39,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,227},62)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({16,18,5,53},62))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({23,50,50,39,52,22,49,52,53,49},62))
local prompt = torso and torso:FindFirstChild(_d({18,52,49,47,50,54},62))
if not prompt then
warn(_d({29,19,55,39,53,54,226,10,35,48,38,46,39,52,31,226,16,49,226,50,52,49,47,50,54,226,40,49,55,48,38,226,40,49,52,226,16,18,5,252,226},62) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({29,19,55,39,53,54,226,10,35,48,38,46,39,52,31,226,18,46,35,59,39,52,226,54,49,49,226,40,35,52,226,40,52,49,47,226,16,18,5,252,226},62) .. tostring(npcName) .. _d({226,234,6,43,53,54,252,226},62) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({18,46,35,59,39,52,9,55,43},62))
local chatGui = playerGui and playerGui:FindFirstChild(_d({16,18,5,5,10,3,22},62))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({29,19,55,39,53,54,226,10,35,48,38,46,39,52,31,226,40,43,52,39,50,52,49,58,43,47,43,54,59,50,52,49,47,50,54,226,48,49,54,226,53,55,50,50,49,52,54,39,38,226,36,59,226,39,58,39,37,55,54,49,52,227},62))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({16,18,5,5,10,3,22},62))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({8,52,35,47,39},62))
local goBtn = frame and frame:FindFirstChild(_d({41,49},62))
local endChatBtn = frame and frame:FindFirstChild(_d({39,48,38,5,42,35,54},62))
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
if not Safeguard then warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,227},62)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({29,19,55,39,53,54,226,10,35,48,38,46,39,52,31,226,3,54,54,39,47,50,54,43,48,41,226,54,49,226,54,35,46,45,226,54,49,226,54,39,53,54,226,16,18,5,252},62), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({29,19,55,39,53,54,226,10,35,48,38,46,39,52,31,226,21,54,49,50,50,39,38,240},62))
end
Core.SetupStandalone(
QuestHandler,
_d({19,55,39,53,54,226,10,35,48,38,46,39,52},62),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()