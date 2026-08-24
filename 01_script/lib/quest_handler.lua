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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({2,47,45,41},64)
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({240,241,237,39,48,47,239,44,41,34,239,35,47,50,37,238,44,53,33},64)) then
Core = loadstring(readfile(_d({240,241,237,39,48,47,239,44,41,34,239,35,47,50,37,238,44,53,33},64)))()
else
Core = loadstring(game:HttpGet(_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,50,47,35,43,57,56,55,33,44,44,239,44,53,33,53,237,35,47,36,37,239,45,33,41,46,239,240,241,31,51,35,50,41,48,52,239,44,41,34,239,35,47,50,37,238,44,53,33},64)))()
end
end)
if not Core then warn(_d({27,3,47,50,37,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,225},64)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({14,16,3,51},64))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({21,48,48,37,50,20,47,50,51,47},64))
local prompt = torso and torso:FindFirstChild(_d({16,50,47,45,48,52},64))
if not prompt then
warn(_d({27,17,53,37,51,52,224,8,33,46,36,44,37,50,29,224,14,47,224,48,50,47,45,48,52,224,38,47,53,46,36,224,38,47,50,224,14,16,3,250,224},64) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({27,17,53,37,51,52,224,8,33,46,36,44,37,50,29,224,16,44,33,57,37,50,224,52,47,47,224,38,33,50,224,38,50,47,45,224,14,16,3,250,224},64) .. tostring(npcName) .. _d({224,232,4,41,51,52,250,224},64) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({16,44,33,57,37,50,7,53,41},64))
local chatGui = playerGui and playerGui:FindFirstChild(_d({14,16,3,3,8,1,20},64))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({27,17,53,37,51,52,224,8,33,46,36,44,37,50,29,224,38,41,50,37,48,50,47,56,41,45,41,52,57,48,50,47,45,48,52,224,46,47,52,224,51,53,48,48,47,50,52,37,36,224,34,57,224,37,56,37,35,53,52,47,50,225},64))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({14,16,3,3,8,1,20},64))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({6,50,33,45,37},64))
local goBtn = frame and frame:FindFirstChild(_d({39,47},64))
local endChatBtn = frame and frame:FindFirstChild(_d({37,46,36,3,40,33,52},64))
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
if not Safeguard then warn(_d({27,19,33,38,37,39,53,33,50,36,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,225},64)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({27,17,53,37,51,52,224,8,33,46,36,44,37,50,29,224,1,52,52,37,45,48,52,41,46,39,224,52,47,224,52,33,44,43,224,52,47,224,52,37,51,52,224,14,16,3,250},64), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({27,17,53,37,51,52,224,8,33,46,36,44,37,50,29,224,19,52,47,48,48,37,36,238},64))
end
if not _G.DisableStandalone then
table.insert(QuestHandler.Connections, game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64)).InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if QuestHandler.Running then
QuestHandler.Stop()
else
QuestHandler.Start()
end
end
end))
print(_d({27,17,53,37,51,52,224,8,33,46,36,44,37,50,29,224,19,52,33,46,36,33,44,47,46,37,224,13,47,36,37,250,224,16,50,37,51,51,224,231,16,231,224,52,47,224,52,37,51,52,224,14,16,3,224,41,46,52,37,50,33,35,52,41,47,46,238},64))
end
_G.QuestHandler = QuestHandler
return QuestHandler
end)()