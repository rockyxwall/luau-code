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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({34,79,77,73},32)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)) then
Core = loadstring(readfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
else
Core = loadstring(game:HttpGet(_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
end
end)
if not Core then warn(_d({59,35,79,82,69,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({46,48,35,83},32))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({53,80,80,69,82,52,79,82,83,79},32))
local prompt = torso and torso:FindFirstChild(_d({48,82,79,77,80,84},32))
if not prompt then
warn(_d({59,49,85,69,83,84,0,40,65,78,68,76,69,82,61,0,46,79,0,80,82,79,77,80,84,0,70,79,85,78,68,0,70,79,82,0,46,48,35,26,0},32) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({59,49,85,69,83,84,0,40,65,78,68,76,69,82,61,0,48,76,65,89,69,82,0,84,79,79,0,70,65,82,0,70,82,79,77,0,46,48,35,26,0},32) .. tostring(npcName) .. _d({0,8,36,73,83,84,26,0},32) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({48,76,65,89,69,82,39,85,73},32))
local chatGui = playerGui and playerGui:FindFirstChild(_d({46,48,35,35,40,33,52},32))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({59,49,85,69,83,84,0,40,65,78,68,76,69,82,61,0,70,73,82,69,80,82,79,88,73,77,73,84,89,80,82,79,77,80,84,0,78,79,84,0,83,85,80,80,79,82,84,69,68,0,66,89,0,69,88,69,67,85,84,79,82,1},32))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({46,48,35,35,40,33,52},32))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({38,82,65,77,69},32))
local goBtn = frame and frame:FindFirstChild(_d({71,79},32))
local endChatBtn = frame and frame:FindFirstChild(_d({69,78,68,35,72,65,84},32))
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
if not Safeguard then warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({59,49,85,69,83,84,0,40,65,78,68,76,69,82,61,0,33,84,84,69,77,80,84,73,78,71,0,84,79,0,84,65,76,75,0,84,79,0,84,69,83,84,0,46,48,35,26},32), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({59,49,85,69,83,84,0,40,65,78,68,76,69,82,61,0,51,84,79,80,80,69,68,14},32))
end
Core.SetupStandalone(
QuestHandler,
_d({49,85,69,83,84,0,40,65,78,68,76,69,82},32),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()