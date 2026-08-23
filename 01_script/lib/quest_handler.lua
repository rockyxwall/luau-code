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
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({25,27,14,62},53))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({32,59,59,48,61,31,58,61,62,58},53))
local prompt = torso and torso:FindFirstChild(_d({27,61,58,56,59,63},53))
if not prompt then
warn(_d({38,28,64,48,62,63,235,19,44,57,47,55,48,61,40,235,25,58,235,59,61,58,56,59,63,235,49,58,64,57,47,235,49,58,61,235,25,27,14,5,235},53) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({38,28,64,48,62,63,235,19,44,57,47,55,48,61,40,235,27,55,44,68,48,61,235,63,58,58,235,49,44,61,235,49,61,58,56,235,25,27,14,5,235},53) .. tostring(npcName) .. _d({235,243,15,52,62,63,5,235},53) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({27,55,44,68,48,61,18,64,52},53))
local chatGui = playerGui and playerGui:FindFirstChild(_d({25,27,14,14,19,12,31},53))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({38,28,64,48,62,63,235,19,44,57,47,55,48,61,40,235,49,52,61,48,59,61,58,67,52,56,52,63,68,59,61,58,56,59,63,235,57,58,63,235,62,64,59,59,58,61,63,48,47,235,45,68,235,48,67,48,46,64,63,58,61,236},53))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({25,27,14,14,19,12,31},53))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({17,61,44,56,48},53))
local goBtn = frame and frame:FindFirstChild(_d({50,58},53))
local endChatBtn = frame and frame:FindFirstChild(_d({48,57,47,14,51,44,63},53))
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
_G.QuestHandler = QuestHandler
return QuestHandler
end)()