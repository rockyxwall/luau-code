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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
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
if v:IsA(_d({56,90,87,96,81,85,81,92,97,56,90,87,85,88,92},24)) then
local action = v.ActionText or ""
if action:find(_d({56,77,84,81,8,43,80,77,91,92},24)) then
local part = v.Parent
if part and part:IsA(_d({42,73,91,77,56,73,90,92},24)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({16,13,22,24,78,20,8,13,22,24,78,20,8,13,22,24,78,17},24), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({24,25,21,79,88,87,23,84,81,74,23,75,87,90,77,22,84,93,73},24)) then
Core = loadstring(readfile(_d({24,25,21,79,88,87,23,84,81,74,23,75,87,90,77,22,84,93,73},24)))()
else
Core = loadstring(game:HttpGet(_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,75,87,90,77,22,84,93,73},24)))()
end
end)
if not Core then warn(_d({67,43,87,90,77,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,9},24)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,59,92,87,88,88,77,76,22},24))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,41,84,90,77,73,76,97,8,90,93,86,86,81,86,79,9},24)); return end
if not Safeguard then warn(_d({67,59,73,78,77,79,93,73,90,76,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,9},24)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,46,87,93,86,76,8,13,76,8,56,77,84,81,8,43,80,77,91,92,91,8,92,87,92,73,84,8,81,86,8,95,87,90,83,91,88,73,75,77,22},24), #allChests))
if #allChests == 0 then
warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,54,87,8,75,80,77,91,92,91,8,78,87,93,86,76,8,202,104,124,8,73,90,77,8,97,87,93,8,81,86,8,92,80,77,8,90,81,79,80,92,8,73,90,77,73,39},24))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,43,87,93,84,76,8,86,87,92,8,78,81,86,76,8,75,80,73,90,73,75,92,77,90,8,90,87,87,92,9,8,41,74,87,90,92,81,86,79,22},24))
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
print(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,13,76,8,75,80,77,91,92,91,8,89,93,77,93,77,76,8,100,8,13,76,8,87,93,92,91,81,76,77,8,81,91,84,73,86,76,8,100,8,13,76,8,92,87,87,8,80,81,79,80,22},24), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,54,87,8,90,77,73,75,80,73,74,84,77,8,75,80,77,91,92,91,8,73,78,92,77,90,8,78,81,84,92,77,90,81,86,79,22},24))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({24,25,21,79,88,87,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24))
if not EasyTravel then
error(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24))
end
EasyTravel.Start()
print(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,45,73,91,97,8,60,90,73,94,77,84,8,91,92,73,90,92,77,76,22},24))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,67,13,76,23,13,76,69,8,60,90,73,94,77,84,84,81,86,79,8,92,87,8,75,80,77,91,92,8,73,92,8,13,91},24), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,52,87,91,92,8,75,80,73,90,73,75,92,77,90,8,202,104,124,8,88,73,93,91,81,86,79,22},24))
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
print(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,41,84,84,8,75,80,77,91,92,91,8,88,90,87,75,77,91,91,77,76,9},24))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({55,88,77,86,43,80,77,91,92,91},24),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()