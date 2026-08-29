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
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
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
if v:IsA(_d({59,93,90,99,84,88,84,95,100,59,93,90,88,91,95},21)) then
local action = v.ActionText or ""
if action:find(_d({59,80,87,84,11,46,83,80,94,95},21)) then
local part = v.Parent
if part and part:IsA(_d({45,76,94,80,59,76,93,95},21)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({19,16,25,27,81,23,11,16,25,27,81,23,11,16,25,27,81,20},21), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({27,28,24,82,91,90,26,87,84,77,26,78,90,93,80,25,87,96,76},21)) then
Core = loadstring(readfile(_d({27,28,24,82,91,90,26,87,84,77,26,78,90,93,80,25,87,96,76},21)))()
else
Core = loadstring(game:HttpGet(_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,87,96,76,96,24,78,90,79,80,26,88,76,84,89,26,27,28,74,94,78,93,84,91,95,26,87,84,77,26,78,90,93,80,25,87,96,76},21)))()
end
end)
if not Core then warn(_d({70,46,90,93,80,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,12},21)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,62,95,90,91,91,80,79,25},21))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,44,87,93,80,76,79,100,11,93,96,89,89,84,89,82,12},21)); return end
if not Safeguard then warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,12},21)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,49,90,96,89,79,11,16,79,11,59,80,87,84,11,46,83,80,94,95,94,11,95,90,95,76,87,11,84,89,11,98,90,93,86,94,91,76,78,80,25},21), #allChests))
if #allChests == 0 then
warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,57,90,11,78,83,80,94,95,94,11,81,90,96,89,79,11,205,107,127,11,76,93,80,11,100,90,96,11,84,89,11,95,83,80,11,93,84,82,83,95,11,76,93,80,76,42},21))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,46,90,96,87,79,11,89,90,95,11,81,84,89,79,11,78,83,76,93,76,78,95,80,93,11,93,90,90,95,12,11,44,77,90,93,95,84,89,82,25},21))
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
print(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,16,79,11,78,83,80,94,95,94,11,92,96,80,96,80,79,11,103,11,16,79,11,90,96,95,94,84,79,80,11,84,94,87,76,89,79,11,103,11,16,79,11,95,90,90,11,83,84,82,83,25},21), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,57,90,11,93,80,76,78,83,76,77,87,80,11,78,83,80,94,95,94,11,76,81,95,80,93,11,81,84,87,95,80,93,84,89,82,25},21))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({27,28,24,82,91,90,26,87,84,77,26,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21), _d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,87,96,76,96,24,78,90,79,80,26,88,76,84,89,26,27,28,74,94,78,93,84,91,95,26,87,84,77,26,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21))
if not EasyTravel then
error(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,11,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21))
end
EasyTravel.Start()
print(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,48,76,94,100,11,63,93,76,97,80,87,11,94,95,76,93,95,80,79,25},21))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,70,16,79,26,16,79,72,11,63,93,76,97,80,87,87,84,89,82,11,95,90,11,78,83,80,94,95,11,76,95,11,16,94},21), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,55,90,94,95,11,78,83,76,93,76,78,95,80,93,11,205,107,127,11,91,76,96,94,84,89,82,25},21))
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
print(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,44,87,87,11,78,83,80,94,95,94,11,91,93,90,78,80,94,94,80,79,12},21))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({58,91,80,89,46,83,80,94,95,94},21),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()