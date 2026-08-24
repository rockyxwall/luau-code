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
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({24,69,67,63},42)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({6,7,3,61,70,69,5,66,63,56,5,57,69,72,59,4,66,75,55},42)) then
Core = loadstring(readfile(_d({6,7,3,61,70,69,5,66,63,56,5,57,69,72,59,4,66,75,55},42)))()
else
Core = loadstring(game:HttpGet(_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,72,69,57,65,79,78,77,55,66,66,5,66,75,55,75,3,57,69,58,59,5,67,55,63,68,5,6,7,53,73,57,72,63,70,74,5,66,63,56,5,57,69,72,59,4,66,75,55},42)))()
end
end)
if not Core then warn(_d({49,25,69,72,59,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,247},42)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({36,38,25,73},42))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({43,70,70,59,72,42,69,72,73,69},42))
local prompt = torso and torso:FindFirstChild(_d({38,72,69,67,70,74},42))
if not prompt then
warn(_d({49,39,75,59,73,74,246,30,55,68,58,66,59,72,51,246,36,69,246,70,72,69,67,70,74,246,60,69,75,68,58,246,60,69,72,246,36,38,25,16,246},42) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({49,39,75,59,73,74,246,30,55,68,58,66,59,72,51,246,38,66,55,79,59,72,246,74,69,69,246,60,55,72,246,60,72,69,67,246,36,38,25,16,246},42) .. tostring(npcName) .. _d({246,254,26,63,73,74,16,246},42) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({38,66,55,79,59,72,29,75,63},42))
local chatGui = playerGui and playerGui:FindFirstChild(_d({36,38,25,25,30,23,42},42))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({49,39,75,59,73,74,246,30,55,68,58,66,59,72,51,246,60,63,72,59,70,72,69,78,63,67,63,74,79,70,72,69,67,70,74,246,68,69,74,246,73,75,70,70,69,72,74,59,58,246,56,79,246,59,78,59,57,75,74,69,72,247},42))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({36,38,25,25,30,23,42},42))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({28,72,55,67,59},42))
local goBtn = frame and frame:FindFirstChild(_d({61,69},42))
local endChatBtn = frame and frame:FindFirstChild(_d({59,68,58,25,62,55,74},42))
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
if not Safeguard then warn(_d({49,41,55,60,59,61,75,55,72,58,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,247},42)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({49,39,75,59,73,74,246,30,55,68,58,66,59,72,51,246,23,74,74,59,67,70,74,63,68,61,246,74,69,246,74,55,66,65,246,74,69,246,74,59,73,74,246,36,38,25,16},42), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({49,39,75,59,73,74,246,30,55,68,58,66,59,72,51,246,41,74,69,70,70,59,58,4},42))
end
if not _G.DisableStandalone then
table.insert(QuestHandler.Connections, game:GetService(_d({43,73,59,72,31,68,70,75,74,41,59,72,76,63,57,59},42)).InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if QuestHandler.Running then
QuestHandler.Stop()
else
QuestHandler.Start()
end
end
end))
print(_d({49,39,75,59,73,74,246,30,55,68,58,66,59,72,51,246,41,74,55,68,58,55,66,69,68,59,246,35,69,58,59,16,246,38,72,59,73,73,246,253,51,253,246,74,69,246,74,59,73,74,246,36,38,25,246,63,68,74,59,72,55,57,74,63,69,68,4},42))
end
_G.QuestHandler = QuestHandler
return QuestHandler
end)()