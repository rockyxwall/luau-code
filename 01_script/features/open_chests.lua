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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local UserInputService = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
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
if v:IsA(_d({65,99,96,105,90,94,90,101,106,65,99,96,94,97,101},15)) then
local action = v.ActionText or ""
if action:find(_d({65,86,93,90,17,52,89,86,100,101},15)) then
local part = v.Parent
if part and part:IsA(_d({51,82,100,86,65,82,99,101},15)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({25,22,31,33,87,29,17,22,31,33,87,29,17,22,31,33,87,26},15), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({33,34,30,88,97,96,32,93,90,83,32,84,96,99,86,31,93,102,82},15)) then
Core = loadstring(readfile(_d({33,34,30,88,97,96,32,93,90,83,32,84,96,99,86,31,93,102,82},15)))()
else
Core = loadstring(game:HttpGet(_d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,99,96,84,92,106,105,104,82,93,93,32,93,102,82,102,30,84,96,85,86,32,94,82,90,95,32,33,34,80,100,84,99,90,97,101,32,93,90,83,32,84,96,99,86,31,93,102,82},15)))()
end
end)
if not Core then warn(_d({76,52,96,99,86,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,18},15)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,68,101,96,97,97,86,85,31},15))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,50,93,99,86,82,85,106,17,99,102,95,95,90,95,88,18},15)); return end
if not Safeguard then warn(_d({76,68,82,87,86,88,102,82,99,85,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,18},15)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,55,96,102,95,85,17,22,85,17,65,86,93,90,17,52,89,86,100,101,100,17,101,96,101,82,93,17,90,95,17,104,96,99,92,100,97,82,84,86,31},15), #allChests))
if #allChests == 0 then
warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,63,96,17,84,89,86,100,101,100,17,87,96,102,95,85,17,211,113,133,17,82,99,86,17,106,96,102,17,90,95,17,101,89,86,17,99,90,88,89,101,17,82,99,86,82,48},15))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,52,96,102,93,85,17,95,96,101,17,87,90,95,85,17,84,89,82,99,82,84,101,86,99,17,99,96,96,101,18,17,50,83,96,99,101,90,95,88,31},15))
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
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,22,85,17,84,89,86,100,101,100,17,98,102,86,102,86,85,17,109,17,22,85,17,96,102,101,100,90,85,86,17,90,100,93,82,95,85,17,109,17,22,85,17,101,96,96,17,89,90,88,89,31},15), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,63,96,17,99,86,82,84,89,82,83,93,86,17,84,89,86,100,101,100,17,82,87,101,86,99,17,87,90,93,101,86,99,90,95,88,31},15))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({33,34,30,88,97,96,32,93,90,83,32,86,82,100,106,80,101,99,82,103,86,93,31,93,102,82},15), _d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,99,96,84,92,106,105,104,82,93,93,32,93,102,82,102,30,84,96,85,86,32,94,82,90,95,32,33,34,80,100,84,99,90,97,101,32,93,90,83,32,86,82,100,106,80,101,99,82,103,86,93,31,93,102,82},15))
if not EasyTravel then
error(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,17,86,82,100,106,80,101,99,82,103,86,93,31,93,102,82},15))
end
EasyTravel.Start()
print(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,54,82,100,106,17,69,99,82,103,86,93,17,100,101,82,99,101,86,85,31},15))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,76,22,85,32,22,85,78,17,69,99,82,103,86,93,93,90,95,88,17,101,96,17,84,89,86,100,101,17,82,101,17,22,100},15), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,61,96,100,101,17,84,89,82,99,82,84,101,86,99,17,211,113,133,17,97,82,102,100,90,95,88,31},15))
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
print(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,50,93,93,17,84,89,86,100,101,100,17,97,99,96,84,86,100,100,86,85,18},15))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({64,97,86,95,52,89,86,100,101,100},15),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()