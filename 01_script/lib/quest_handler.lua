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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({58,60,47,95},20))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({65,92,92,81,94,64,91,94,95,91},20))
local prompt = torso and torso:FindFirstChild(_d({60,94,91,89,92,96},20))
if not prompt then
warn(_d({71,61,97,81,95,96,12,52,77,90,80,88,81,94,73,12,58,91,12,92,94,91,89,92,96,12,82,91,97,90,80,12,82,91,94,12,58,60,47,38,12},20) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({71,61,97,81,95,96,12,52,77,90,80,88,81,94,73,12,60,88,77,101,81,94,12,96,91,91,12,82,77,94,12,82,94,91,89,12,58,60,47,38,12},20) .. tostring(npcName) .. _d({12,20,48,85,95,96,38,12},20) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({60,88,77,101,81,94,51,97,85},20))
local chatGui = playerGui and playerGui:FindFirstChild(_d({58,60,47,47,52,45,64},20))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({71,61,97,81,95,96,12,52,77,90,80,88,81,94,73,12,82,85,94,81,92,94,91,100,85,89,85,96,101,92,94,91,89,92,96,12,90,91,96,12,95,97,92,92,91,94,96,81,80,12,78,101,12,81,100,81,79,97,96,91,94,13},20))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({58,60,47,47,52,45,64},20))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({50,94,77,89,81},20))
local goBtn = frame and frame:FindFirstChild(_d({83,91},20))
local endChatBtn = frame and frame:FindFirstChild(_d({81,90,80,47,84,77,96},20))
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