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
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local UserInputService = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
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
if v:IsA(_d({49,83,80,89,74,78,74,85,90,49,83,80,78,81,85},31)) then
local action = v.ActionText or ""
if action:find(_d({49,70,77,74,1,36,73,70,84,85},31)) then
local part = v.Parent
if part and part:IsA(_d({35,66,84,70,49,66,83,85},31)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({9,6,15,17,71,13,1,6,15,17,71,13,1,6,15,17,71,10},31), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({17,18,14,72,81,80,16,77,74,67,16,68,80,83,70,15,77,86,66},31)) then
Core = loadstring(readfile(_d({17,18,14,72,81,80,16,77,74,67,16,68,80,83,70,15,77,86,66},31)))()
else
Core = loadstring(game:HttpGet(_d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,77,86,66,86,14,68,80,69,70,16,78,66,74,79,16,17,18,64,84,68,83,74,81,85,16,77,74,67,16,68,80,83,70,15,77,86,66},31)))()
end
end)
if not Core then warn(_d({60,36,80,83,70,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,2},31)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,52,85,80,81,81,70,69,15},31))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,34,77,83,70,66,69,90,1,83,86,79,79,74,79,72,2},31)); return end
if not Safeguard then warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,2},31)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,39,80,86,79,69,1,6,69,1,49,70,77,74,1,36,73,70,84,85,84,1,85,80,85,66,77,1,74,79,1,88,80,83,76,84,81,66,68,70,15},31), #allChests))
if #allChests == 0 then
warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,47,80,1,68,73,70,84,85,84,1,71,80,86,79,69,1,195,97,117,1,66,83,70,1,90,80,86,1,74,79,1,85,73,70,1,83,74,72,73,85,1,66,83,70,66,32},31))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,36,80,86,77,69,1,79,80,85,1,71,74,79,69,1,68,73,66,83,66,68,85,70,83,1,83,80,80,85,2,1,34,67,80,83,85,74,79,72,15},31))
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
print(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,6,69,1,68,73,70,84,85,84,1,82,86,70,86,70,69,1,93,1,6,69,1,80,86,85,84,74,69,70,1,74,84,77,66,79,69,1,93,1,6,69,1,85,80,80,1,73,74,72,73,15},31), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,47,80,1,83,70,66,68,73,66,67,77,70,1,68,73,70,84,85,84,1,66,71,85,70,83,1,71,74,77,85,70,83,74,79,72,15},31))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({17,18,14,72,81,80,16,77,74,67,16,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31), _d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,77,86,66,86,14,68,80,69,70,16,78,66,74,79,16,17,18,64,84,68,83,74,81,85,16,77,74,67,16,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31))
if not EasyTravel then
error(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,1,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31))
end
EasyTravel.Start()
print(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,38,66,84,90,1,53,83,66,87,70,77,1,84,85,66,83,85,70,69,15},31))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,60,6,69,16,6,69,62,1,53,83,66,87,70,77,77,74,79,72,1,85,80,1,68,73,70,84,85,1,66,85,1,6,84},31), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,45,80,84,85,1,68,73,66,83,66,68,85,70,83,1,195,97,117,1,81,66,86,84,74,79,72,15},31))
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
print(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,34,77,77,1,68,73,70,84,85,84,1,81,83,80,68,70,84,84,70,69,2},31))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({48,81,70,79,36,73,70,84,85,84},31),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()