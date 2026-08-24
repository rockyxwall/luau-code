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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
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
if v:IsA(_d({25,59,56,65,50,54,50,61,66,25,59,56,54,57,61},55)) then
local action = v.ActionText or ""
if action:find(_d({25,46,53,50,233,12,49,46,60,61},55)) then
local part = v.Parent
if part and part:IsA(_d({11,42,60,46,25,42,59,61},55)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({241,238,247,249,47,245,233,238,247,249,47,245,233,238,247,249,47,242},55), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({249,250,246,48,57,56,248,53,50,43,248,44,56,59,46,247,53,62,42},55)) then
Core = loadstring(readfile(_d({249,250,246,48,57,56,248,53,50,43,248,44,56,59,46,247,53,62,42},55)))()
else
Core = loadstring(game:HttpGet(_d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,59,56,44,52,66,65,64,42,53,53,248,53,62,42,62,246,44,56,45,46,248,54,42,50,55,248,249,250,40,60,44,59,50,57,61,248,53,50,43,248,44,56,59,46,247,53,62,42},55)))()
end
end)
if not Core then warn(_d({36,12,56,59,46,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,234},55)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,28,61,56,57,57,46,45,247},55))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,10,53,59,46,42,45,66,233,59,62,55,55,50,55,48,234},55)); return end
if not Safeguard then warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,234},55)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,15,56,62,55,45,233,238,45,233,25,46,53,50,233,12,49,46,60,61,60,233,61,56,61,42,53,233,50,55,233,64,56,59,52,60,57,42,44,46,247},55), #allChests))
if #allChests == 0 then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,23,56,233,44,49,46,60,61,60,233,47,56,62,55,45,233,171,73,93,233,42,59,46,233,66,56,62,233,50,55,233,61,49,46,233,59,50,48,49,61,233,42,59,46,42,8},55))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,12,56,62,53,45,233,55,56,61,233,47,50,55,45,233,44,49,42,59,42,44,61,46,59,233,59,56,56,61,234,233,10,43,56,59,61,50,55,48,247},55))
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
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,238,45,233,44,49,46,60,61,60,233,58,62,46,62,46,45,233,69,233,238,45,233,56,62,61,60,50,45,46,233,50,60,53,42,55,45,233,69,233,238,45,233,61,56,56,233,49,50,48,49,247},55), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,23,56,233,59,46,42,44,49,42,43,53,46,233,44,49,46,60,61,60,233,42,47,61,46,59,233,47,50,53,61,46,59,50,55,48,247},55))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({249,250,246,48,57,56,248,53,50,43,248,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42},55), _d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,59,56,44,52,66,65,64,42,53,53,248,53,62,42,62,246,44,56,45,46,248,54,42,50,55,248,249,250,40,60,44,59,50,57,61,248,53,50,43,248,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42},55))
if not EasyTravel then
error(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,233,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42},55))
end
EasyTravel.Start()
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,14,42,60,66,233,29,59,42,63,46,53,233,60,61,42,59,61,46,45,247},55))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,36,238,45,248,238,45,38,233,29,59,42,63,46,53,53,50,55,48,233,61,56,233,44,49,46,60,61,233,42,61,233,238,60},55), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,21,56,60,61,233,44,49,42,59,42,44,61,46,59,233,171,73,93,233,57,42,62,60,50,55,48,247},55))
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
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,10,53,53,233,44,49,46,60,61,60,233,57,59,56,44,46,60,60,46,45,234},55))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({24,57,46,55,12,49,46,60,61,60},55),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()