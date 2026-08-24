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
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({41,86,84,80},25)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({23,24,20,78,87,86,22,83,80,73,22,74,86,89,76,21,83,92,72},25)) then
Core = loadstring(readfile(_d({23,24,20,78,87,86,22,83,80,73,22,74,86,89,76,21,83,92,72},25)))()
else
Core = loadstring(game:HttpGet(_d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,83,92,72,92,20,74,86,75,76,22,84,72,80,85,22,23,24,70,90,74,89,80,87,91,22,83,80,73,22,74,86,89,76,21,83,92,72},25)))()
end
end)
if not Core then warn(_d({66,42,86,89,76,68,7,45,72,80,83,76,75,7,91,86,7,83,86,72,75,8},25)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({53,55,42,90},25))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({60,87,87,76,89,59,86,89,90,86},25))
local prompt = torso and torso:FindFirstChild(_d({55,89,86,84,87,91},25))
if not prompt then
warn(_d({66,56,92,76,90,91,7,47,72,85,75,83,76,89,68,7,53,86,7,87,89,86,84,87,91,7,77,86,92,85,75,7,77,86,89,7,53,55,42,33,7},25) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({66,56,92,76,90,91,7,47,72,85,75,83,76,89,68,7,55,83,72,96,76,89,7,91,86,86,7,77,72,89,7,77,89,86,84,7,53,55,42,33,7},25) .. tostring(npcName) .. _d({7,15,43,80,90,91,33,7},25) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({55,83,72,96,76,89,46,92,80},25))
local chatGui = playerGui and playerGui:FindFirstChild(_d({53,55,42,42,47,40,59},25))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({66,56,92,76,90,91,7,47,72,85,75,83,76,89,68,7,77,80,89,76,87,89,86,95,80,84,80,91,96,87,89,86,84,87,91,7,85,86,91,7,90,92,87,87,86,89,91,76,75,7,73,96,7,76,95,76,74,92,91,86,89,8},25))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({53,55,42,42,47,40,59},25))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({45,89,72,84,76},25))
local goBtn = frame and frame:FindFirstChild(_d({78,86},25))
local endChatBtn = frame and frame:FindFirstChild(_d({76,85,75,42,79,72,91},25))
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
if not Safeguard then warn(_d({66,58,72,77,76,78,92,72,89,75,68,7,45,72,80,83,76,75,7,91,86,7,83,86,72,75,8},25)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({66,56,92,76,90,91,7,47,72,85,75,83,76,89,68,7,40,91,91,76,84,87,91,80,85,78,7,91,86,7,91,72,83,82,7,91,86,7,91,76,90,91,7,53,55,42,33},25), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({66,56,92,76,90,91,7,47,72,85,75,83,76,89,68,7,58,91,86,87,87,76,75,21},25))
end
Core.SetupStandalone(
QuestHandler,
_d({56,92,76,90,91,7,47,72,85,75,83,76,89},25),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()