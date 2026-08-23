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
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({27,29,16,64},51))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({34,61,61,50,63,33,60,63,64,60},51))
local prompt = torso and torso:FindFirstChild(_d({29,63,60,58,61,65},51))
if not prompt then
warn(_d({40,30,66,50,64,65,237,21,46,59,49,57,50,63,42,237,27,60,237,61,63,60,58,61,65,237,51,60,66,59,49,237,51,60,63,237,27,29,16,7,237},51) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({40,30,66,50,64,65,237,21,46,59,49,57,50,63,42,237,29,57,46,70,50,63,237,65,60,60,237,51,46,63,237,51,63,60,58,237,27,29,16,7,237},51) .. tostring(npcName) .. _d({237,245,17,54,64,65,7,237},51) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({40,30,66,50,64,65,237,21,46,59,49,57,50,63,42,237,51,54,63,50,61,63,60,69,54,58,54,65,70,61,63,60,58,61,65,237,59,60,65,237,64,66,61,61,60,63,65,50,49,237,47,70,237,50,69,50,48,66,65,60,63,238},51))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({29,57,46,70,50,63,20,66,54},51))
local chatGui = playerGui and playerGui:FindFirstChild(_d({27,29,16,16,21,14,33},51))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({19,63,46,58,50},51))
local goBtn = frame and frame:FindFirstChild(_d({52,60},51))
local endChatBtn = frame and frame:FindFirstChild(_d({50,59,49,16,53,46,65},51))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
pcall(function() conn:Fire() end)
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
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