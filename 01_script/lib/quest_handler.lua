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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({14,59,57,53},52)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({252,253,249,51,60,59,251,56,53,46,251,47,59,62,49,250,56,65,45},52)) then
Core = loadstring(readfile(_d({252,253,249,51,60,59,251,56,53,46,251,47,59,62,49,250,56,65,45},52)))()
else
Core = loadstring(game:HttpGet(_d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,47,59,62,49,250,56,65,45},52)))()
end
end)
if not Core then warn(_d({39,15,59,62,49,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({26,28,15,63},52))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({33,60,60,49,62,32,59,62,63,59},52))
local prompt = torso and torso:FindFirstChild(_d({28,62,59,57,60,64},52))
if not prompt then
warn(_d({39,29,65,49,63,64,236,20,45,58,48,56,49,62,41,236,26,59,236,60,62,59,57,60,64,236,50,59,65,58,48,236,50,59,62,236,26,28,15,6,236},52) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({39,29,65,49,63,64,236,20,45,58,48,56,49,62,41,236,28,56,45,69,49,62,236,64,59,59,236,50,45,62,236,50,62,59,57,236,26,28,15,6,236},52) .. tostring(npcName) .. _d({236,244,16,53,63,64,6,236},52) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({28,56,45,69,49,62,19,65,53},52))
local chatGui = playerGui and playerGui:FindFirstChild(_d({26,28,15,15,20,13,32},52))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({39,29,65,49,63,64,236,20,45,58,48,56,49,62,41,236,50,53,62,49,60,62,59,68,53,57,53,64,69,60,62,59,57,60,64,236,58,59,64,236,63,65,60,60,59,62,64,49,48,236,46,69,236,49,68,49,47,65,64,59,62,237},52))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({26,28,15,15,20,13,32},52))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({18,62,45,57,49},52))
local goBtn = frame and frame:FindFirstChild(_d({51,59},52))
local endChatBtn = frame and frame:FindFirstChild(_d({49,58,48,15,52,45,64},52))
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
if not Safeguard then warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({39,29,65,49,63,64,236,20,45,58,48,56,49,62,41,236,13,64,64,49,57,60,64,53,58,51,236,64,59,236,64,45,56,55,236,64,59,236,64,49,63,64,236,26,28,15,6},52), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({39,29,65,49,63,64,236,20,45,58,48,56,49,62,41,236,31,64,59,60,60,49,48,250},52))
end
if not _G.DisableStandalone then
table.insert(QuestHandler.Connections, game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52)).InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if QuestHandler.Running then
QuestHandler.Stop()
else
QuestHandler.Start()
end
end
end))
print(_d({39,29,65,49,63,64,236,20,45,58,48,56,49,62,41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243,41,243,236,64,59,236,64,49,63,64,236,26,28,15,236,53,58,64,49,62,45,47,64,53,59,58,250},52))
end
_G.QuestHandler = QuestHandler
return QuestHandler
end)()