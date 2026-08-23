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
local QuestHandler = {}
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
local playerGui = LocalPlayer:FindFirstChild(_d({16,44,33,57,37,50,7,53,41},64))
local chatGui = playerGui and playerGui:FindFirstChild(_d({14,16,3,3,8,1,20},64))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
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
_G.QuestHandler = QuestHandler
return QuestHandler
end)()