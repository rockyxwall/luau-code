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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
local LocalPlayer = Players.LocalPlayer
local OpenChests = {
Running = false,
Connections = {}
}
local ARRIVE_DIST = 6
local TIMEOUT_PER_CHEST = 20
local OPEN_WAIT = 2.5
local TRAVEL_HEIGHT = 4
local CHECK_HZ = 0.1
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(position)
return position.X >= ISLAND_MIN_X and position.X <= ISLAND_MAX_X
and position.Z >= ISLAND_MIN_Z and position.Z <= ISLAND_MAX_Z
end
local function collectChests()
local chests = {}
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA(_d({54,88,85,94,79,83,79,90,95,54,88,85,83,86,90},26)) then
local action = v.ActionText or ""
if action:find(_d({54,75,82,79,6,41,78,75,89,90},26)) then
local part = v.Parent
if part and part:IsA(_d({40,71,89,75,54,71,88,90},26)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({14,11,20,22,76,18,6,11,20,22,76,18,6,11,20,22,76,15},26), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
local function waitForRoot(timeout)
local t = 0
while t < timeout do
local r = Core.GetRoot(LocalPlayer)
if r then return r end
task.wait(0.1)
t = t + 0.1
end
return nil
end
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({22,23,19,77,86,85,21,82,79,72,21,73,85,88,75,20,82,91,71},26)) then
Core = loadstring(readfile(_d({22,23,19,77,86,85,21,82,79,72,21,73,85,88,75,20,82,91,71},26)))()
else
Core = loadstring(game:HttpGet(_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,82,91,71,91,19,73,85,74,75,21,83,71,79,84,21,22,23,69,89,73,88,79,86,90,21,82,79,72,21,73,85,88,75,20,82,91,71},26)))()
end
end)
if not Core then warn(_d({65,41,85,88,75,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,7},26)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,57,90,85,86,86,75,74,20},26))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,39,82,88,75,71,74,95,6,88,91,84,84,79,84,77,7},26)); return end
if not Safeguard then warn(_d({65,57,71,76,75,77,91,71,88,74,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,7},26)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,44,85,91,84,74,6,11,74,6,54,75,82,79,6,41,78,75,89,90,89,6,90,85,90,71,82,6,79,84,6,93,85,88,81,89,86,71,73,75,20},26), #allChests))
if #allChests == 0 then
warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,52,85,6,73,78,75,89,90,89,6,76,85,91,84,74,6,200,102,122,6,71,88,75,6,95,85,91,6,79,84,6,90,78,75,6,88,79,77,78,90,6,71,88,75,71,37},26))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,41,85,91,82,74,6,84,85,90,6,76,79,84,74,6,73,78,71,88,71,73,90,75,88,6,88,85,85,90,7,6,39,72,85,88,90,79,84,77,20},26))
OpenChests.Stop()
return
end
local playerStartPos = startRoot.Position
local playerStartY = playerStartPos.Y
local filtered = {}
local skippedIsland = 0
local skippedY = 0
for _, c in ipairs(allChests) do
if not isInsideTownOfBeginnings(c.position) then
skippedIsland = skippedIsland + 1
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
else
table.insert(filtered, c)
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,11,74,6,73,78,75,89,90,89,6,87,91,75,91,75,74,6,98,6,11,74,6,85,91,90,89,79,74,75,6,79,89,82,71,84,74,6,98,6,11,74,6,90,85,85,6,78,79,77,78,20},26), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,52,85,6,88,75,71,73,78,71,72,82,75,6,73,78,75,89,90,89,6,71,76,90,75,88,6,76,79,82,90,75,88,79,84,77,20},26))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({22,23,19,77,86,85,21,82,79,72,21,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71},26), _d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,82,91,71,91,19,73,85,74,75,21,83,71,79,84,21,22,23,69,89,73,88,79,86,90,21,82,79,72,21,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71},26))
if not EasyTravel then
error(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,6,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71},26))
end
EasyTravel.Start()
print(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,43,71,89,95,6,58,88,71,92,75,82,6,89,90,71,88,90,75,74,20},26))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,65,11,74,21,11,74,67,6,58,88,71,92,75,82,82,79,84,77,6,90,85,6,73,78,75,89,90,6,71,90,6,11,89},26), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,50,85,89,90,6,73,78,71,88,71,73,90,75,88,6,200,102,122,6,86,71,91,89,79,84,77,20},26))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then break end
end
if not OpenChests.Running then break end
local currentRoot = Core.GetRoot(LocalPlayer)
if currentRoot then EasyTravel.TargetPosition = currentRoot.Position end
if chest.prompt and chest.prompt.Parent then
local ok, err = pcall(function() fireproximityprompt(chest.prompt) end)
if not ok then
pcall(function() chest.prompt.Triggered:Fire(LocalPlayer) end)
end
end
task.wait(OPEN_WAIT)
end
if EasyTravel then
EasyTravel.TargetPosition = nil
pcall(EasyTravel.Stop)
end
if OpenChests.Running then
print(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,39,82,82,6,73,78,75,89,90,89,6,86,88,85,73,75,89,89,75,74,7},26))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({53,86,75,84,41,78,75,89,90,89},26),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()