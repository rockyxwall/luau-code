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
local ChestFarmer = {}
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local LocalPlayer = Players.LocalPlayer
local ARRIVE_DIST = 6
local TRAVEL_HEIGHT = 4
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(pos)
return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X
and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({11,52,60},58)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({22,56,53,62,47,51,47,58,63,22,56,53,51,54,58},58)) then
local action = v.ActionText or ""
if action:find(_d({22,43,50,47,230,9,46,43,57,58},58)) then
local part = v.Parent
if part and part:IsA(_d({8,39,57,43,22,39,56,58},58)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({238,235,244,246,44,242,230,235,244,246,44,242,230,235,244,246,44,239},58), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({33,9,46,43,57,58,12,39,56,51,43,56,35,230,25,58,39,56,58,43,42,230,41,46,43,57,58,230,44,39,56,51,244,230,26,39,56,45,43,58,230,22,43,50,47,0,230},58) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({33,9,46,43,57,58,12,39,56,51,43,56,35,230,20,53,230,41,46,43,57,58,57,230,44,53,59,52,42,244,230,29,39,47,58,47,52,45,230,248,246,230,57,43,41,53,52,42,57,230,44,53,56,230,57,54,39,61,52,244,244,244},58))
local waited = 0
while isRunningCallback() and waited < 20 do
task.wait(1)
waited = waited + 1
if getPeliCallback() >= targetPeli then
return true
end
end
else
local root = getRoot()
if root then
local startPos = root.Position
table.sort(chests, function(a, b)
return (a.position - startPos).Magnitude < (b.position - startPos).Magnitude
end)
end
print(string.format(_d({33,9,46,43,57,58,12,39,56,51,43,56,35,230,12,53,59,52,42,230,235,42,230,41,46,43,57,58,57,244,230,12,39,56,51,47,52,45,230,52,43,39,56,43,57,58,230,44,47,56,57,58,244,244,244},58), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({33,9,46,43,57,58,12,39,56,51,43,56,35,230,26,56,39,60,43,50,47,52,45,230,58,53,230,41,46,43,57,58,230,39,58,230},58) .. chest.label)
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
end
local elapsed = 0
local reached = false
while isRunningCallback() and elapsed < 20 do
task.wait(0.1)
elapsed = elapsed + 0.1
local myRoot = getRoot()
if myRoot then
local dist = (myRoot.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
reached = true
break
end
else
task.wait(1)
end
end
if reached and isRunningCallback() then
print(_d({33,9,46,43,57,58,12,39,56,51,43,56,35,230,7,56,56,47,60,43,42,244,230,21,54,43,52,47,52,45,230,41,46,43,57,58,244,244,244},58))
if _G.EasyTravel then
local myRoot = getRoot()
if myRoot then
_G.EasyTravel.TargetPosition = myRoot.Position
end
end
if chest.prompt and chest.prompt.Parent then
local holdTime = chest.prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, chest.prompt)
else
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
task.wait(2.5)
end
end
end
end
task.wait(0.2)
end
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
return getPeliCallback() >= targetPeli
end
_G.ChestFarmer = ChestFarmer
return ChestFarmer
end)()