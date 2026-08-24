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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({33,78,76,72},33)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({15,16,12,70,79,78,14,75,72,65,14,66,78,81,68,13,75,84,64},33)) then
Core = loadstring(readfile(_d({15,16,12,70,79,78,14,75,72,65,14,66,78,81,68,13,75,84,64},33)))()
else
Core = loadstring(game:HttpGet(_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,75,84,64,84,12,66,78,67,68,14,76,64,72,77,14,15,16,62,82,66,81,72,79,83,14,75,72,65,14,66,78,81,68,13,75,84,64},33)))()
end
end)
if not Core then warn(_d({58,34,78,81,68,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,0},33)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({45,47,34,82},33))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({52,79,79,68,81,51,78,81,82,78},33))
local prompt = torso and torso:FindFirstChild(_d({47,81,78,76,79,83},33))
if not prompt then
warn(_d({58,48,84,68,82,83,255,39,64,77,67,75,68,81,60,255,45,78,255,79,81,78,76,79,83,255,69,78,84,77,67,255,69,78,81,255,45,47,34,25,255},33) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({58,48,84,68,82,83,255,39,64,77,67,75,68,81,60,255,47,75,64,88,68,81,255,83,78,78,255,69,64,81,255,69,81,78,76,255,45,47,34,25,255},33) .. tostring(npcName) .. _d({255,7,35,72,82,83,25,255},33) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({47,75,64,88,68,81,38,84,72},33))
local chatGui = playerGui and playerGui:FindFirstChild(_d({45,47,34,34,39,32,51},33))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({58,48,84,68,82,83,255,39,64,77,67,75,68,81,60,255,69,72,81,68,79,81,78,87,72,76,72,83,88,79,81,78,76,79,83,255,77,78,83,255,82,84,79,79,78,81,83,68,67,255,65,88,255,68,87,68,66,84,83,78,81,0},33))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({45,47,34,34,39,32,51},33))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({37,81,64,76,68},33))
local goBtn = frame and frame:FindFirstChild(_d({70,78},33))
local endChatBtn = frame and frame:FindFirstChild(_d({68,77,67,34,71,64,83},33))
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
if not Safeguard then warn(_d({58,50,64,69,68,70,84,64,81,67,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,0},33)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({58,48,84,68,82,83,255,39,64,77,67,75,68,81,60,255,32,83,83,68,76,79,83,72,77,70,255,83,78,255,83,64,75,74,255,83,78,255,83,68,82,83,255,45,47,34,25},33), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({58,48,84,68,82,83,255,39,64,77,67,75,68,81,60,255,50,83,78,79,79,68,67,13},33))
end
Core.SetupStandalone(
QuestHandler,
_d({48,84,68,82,83,255,39,64,77,67,75,68,81},33),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()