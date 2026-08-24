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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local UserInputService = game:GetService(_d({45,75,61,74,33,70,72,77,76,43,61,74,78,65,59,61},40))
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
if v:IsA(_d({40,74,71,80,65,69,65,76,81,40,74,71,69,72,76},40)) then
local action = v.ActionText or ""
if action:find(_d({40,61,68,65,248,27,64,61,75,76},40)) then
local part = v.Parent
if part and part:IsA(_d({26,57,75,61,40,57,74,76},40)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({0,253,6,8,62,4,248,253,6,8,62,4,248,253,6,8,62,1},40), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({8,9,5,63,72,71,7,68,65,58,7,59,71,74,61,6,68,77,57},40)) then
Core = loadstring(readfile(_d({8,9,5,63,72,71,7,68,65,58,7,59,71,74,61,6,68,77,57},40)))()
else
Core = loadstring(game:HttpGet(_d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,74,71,59,67,81,80,79,57,68,68,7,68,77,57,77,5,59,71,60,61,7,69,57,65,70,7,8,9,55,75,59,74,65,72,76,7,68,65,58,7,59,71,74,61,6,68,77,57},40)))()
end
end)
if not Core then warn(_d({51,27,71,74,61,53,248,30,57,65,68,61,60,248,76,71,248,68,71,57,60,249},40)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,43,76,71,72,72,61,60,6},40))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,25,68,74,61,57,60,81,248,74,77,70,70,65,70,63,249},40)); return end
if not Safeguard then warn(_d({51,43,57,62,61,63,77,57,74,60,53,248,30,57,65,68,61,60,248,76,71,248,68,71,57,60,249},40)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,30,71,77,70,60,248,253,60,248,40,61,68,65,248,27,64,61,75,76,75,248,76,71,76,57,68,248,65,70,248,79,71,74,67,75,72,57,59,61,6},40), #allChests))
if #allChests == 0 then
warn(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,38,71,248,59,64,61,75,76,75,248,62,71,77,70,60,248,186,88,108,248,57,74,61,248,81,71,77,248,65,70,248,76,64,61,248,74,65,63,64,76,248,57,74,61,57,23},40))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,27,71,77,68,60,248,70,71,76,248,62,65,70,60,248,59,64,57,74,57,59,76,61,74,248,74,71,71,76,249,248,25,58,71,74,76,65,70,63,6},40))
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
print(string.format(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,253,60,248,59,64,61,75,76,75,248,73,77,61,77,61,60,248,84,248,253,60,248,71,77,76,75,65,60,61,248,65,75,68,57,70,60,248,84,248,253,60,248,76,71,71,248,64,65,63,64,6},40), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,38,71,248,74,61,57,59,64,57,58,68,61,248,59,64,61,75,76,75,248,57,62,76,61,74,248,62,65,68,76,61,74,65,70,63,6},40))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({8,9,5,63,72,71,7,68,65,58,7,61,57,75,81,55,76,74,57,78,61,68,6,68,77,57},40), _d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,74,71,59,67,81,80,79,57,68,68,7,68,77,57,77,5,59,71,60,61,7,69,57,65,70,7,8,9,55,75,59,74,65,72,76,7,68,65,58,7,61,57,75,81,55,76,74,57,78,61,68,6,68,77,57},40))
if not EasyTravel then
error(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,30,57,65,68,61,60,248,76,71,248,68,71,57,60,248,61,57,75,81,55,76,74,57,78,61,68,6,68,77,57},40))
end
EasyTravel.Start()
print(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,29,57,75,81,248,44,74,57,78,61,68,248,75,76,57,74,76,61,60,6},40))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,51,253,60,7,253,60,53,248,44,74,57,78,61,68,68,65,70,63,248,76,71,248,59,64,61,75,76,248,57,76,248,253,75},40), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,36,71,75,76,248,59,64,57,74,57,59,76,61,74,248,186,88,108,248,72,57,77,75,65,70,63,6},40))
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
print(_d({51,39,72,61,70,27,64,61,75,76,75,53,248,25,68,68,248,59,64,61,75,76,75,248,72,74,71,59,61,75,75,61,60,249},40))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({39,72,61,70,27,64,61,75,76,75},40),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()