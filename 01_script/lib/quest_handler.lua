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
local QuestHandler = {}
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
_G.QuestHandler = QuestHandler
return QuestHandler
end)()