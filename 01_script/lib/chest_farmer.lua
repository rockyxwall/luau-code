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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
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
return char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({5,46,54},64)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({16,50,47,56,41,45,41,52,57,16,50,47,45,48,52},64)) then
local action = v.ActionText or ""
if action:find(_d({16,37,44,41,224,3,40,37,51,52},64)) then
local part = v.Parent
if part and part:IsA(_d({2,33,51,37,16,33,50,52},64)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({232,229,238,240,38,236,224,229,238,240,38,236,224,229,238,240,38,233},64), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({27,3,40,37,51,52,6,33,50,45,37,50,29,224,19,52,33,50,52,37,36,224,35,40,37,51,52,224,38,33,50,45,238,224,20,33,50,39,37,52,224,16,37,44,41,250,224},64) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({27,3,40,37,51,52,6,33,50,45,37,50,29,224,14,47,224,35,40,37,51,52,51,224,38,47,53,46,36,238,224,23,33,41,52,41,46,39,224,242,240,224,51,37,35,47,46,36,51,224,38,47,50,224,51,48,33,55,46,238,238,238},64))
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
print(string.format(_d({27,3,40,37,51,52,6,33,50,45,37,50,29,224,6,47,53,46,36,224,229,36,224,35,40,37,51,52,51,238,224,6,33,50,45,41,46,39,224,46,37,33,50,37,51,52,224,38,41,50,51,52,238,238,238},64), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({27,3,40,37,51,52,6,33,50,45,37,50,29,224,20,50,33,54,37,44,41,46,39,224,52,47,224,35,40,37,51,52,224,33,52,224},64) .. chest.label)
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
print(_d({27,3,40,37,51,52,6,33,50,45,37,50,29,224,1,50,50,41,54,37,36,238,224,15,48,37,46,41,46,39,224,35,40,37,51,52,238,238,238},64))
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