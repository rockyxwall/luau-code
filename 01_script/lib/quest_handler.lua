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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({59,61,48,96},19))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({66,93,93,82,95,65,92,95,96,92},19))
local prompt = torso and torso:FindFirstChild(_d({61,95,92,90,93,97},19))
if not prompt then
warn(_d({72,62,98,82,96,97,13,53,78,91,81,89,82,95,74,13,59,92,13,93,95,92,90,93,97,13,83,92,98,91,81,13,83,92,95,13,59,61,48,39,13},19) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({72,62,98,82,96,97,13,53,78,91,81,89,82,95,74,13,61,89,78,102,82,95,13,97,92,92,13,83,78,95,13,83,95,92,90,13,59,61,48,39,13},19) .. tostring(npcName) .. _d({13,21,49,86,96,97,39,13},19) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({72,62,98,82,96,97,13,53,78,91,81,89,82,95,74,13,83,86,95,82,93,95,92,101,86,90,86,97,102,93,95,92,90,93,97,13,91,92,97,13,96,98,93,93,92,95,97,82,81,13,79,102,13,82,101,82,80,98,97,92,95,14},19))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({61,89,78,102,82,95,52,98,86},19))
local chatGui = playerGui and playerGui:FindFirstChild(_d({59,61,48,48,53,46,65},19))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({51,95,78,90,82},19))
local goBtn = frame and frame:FindFirstChild(_d({84,92},19))
local endChatBtn = frame and frame:FindFirstChild(_d({82,91,81,48,85,78,97},19))
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