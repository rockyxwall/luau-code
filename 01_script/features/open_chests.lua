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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
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
if v:IsA(_d({20,54,51,60,45,49,45,56,61,20,54,51,49,52,56},60)) then
local action = v.ActionText or ""
if action:find(_d({20,41,48,45,228,7,44,41,55,56},60)) then
local part = v.Parent
if part and part:IsA(_d({6,37,55,41,20,37,54,56},60)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({236,233,242,244,42,240,228,233,242,244,42,240,228,233,242,244,42,237},60), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({244,245,241,43,52,51,243,48,45,38,243,39,51,54,41,242,48,57,37},60)) then
Core = loadstring(readfile(_d({244,245,241,43,52,51,243,48,45,38,243,39,51,54,41,242,48,57,37},60)))()
else
Core = loadstring(game:HttpGet(_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,54,51,39,47,61,60,59,37,48,48,243,48,57,37,57,241,39,51,40,41,243,49,37,45,50,243,244,245,35,55,39,54,45,52,56,243,48,45,38,243,39,51,54,41,242,48,57,37},60)))()
end
end)
if not Core then warn(_d({31,7,51,54,41,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,229},60)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,23,56,51,52,52,41,40,242},60))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,5,48,54,41,37,40,61,228,54,57,50,50,45,50,43,229},60)); return end
if not Safeguard then warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,229},60)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,10,51,57,50,40,228,233,40,228,20,41,48,45,228,7,44,41,55,56,55,228,56,51,56,37,48,228,45,50,228,59,51,54,47,55,52,37,39,41,242},60), #allChests))
if #allChests == 0 then
warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,18,51,228,39,44,41,55,56,55,228,42,51,57,50,40,228,166,68,88,228,37,54,41,228,61,51,57,228,45,50,228,56,44,41,228,54,45,43,44,56,228,37,54,41,37,3},60))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,7,51,57,48,40,228,50,51,56,228,42,45,50,40,228,39,44,37,54,37,39,56,41,54,228,54,51,51,56,229,228,5,38,51,54,56,45,50,43,242},60))
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
print(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,233,40,228,39,44,41,55,56,55,228,53,57,41,57,41,40,228,64,228,233,40,228,51,57,56,55,45,40,41,228,45,55,48,37,50,40,228,64,228,233,40,228,56,51,51,228,44,45,43,44,242},60), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,18,51,228,54,41,37,39,44,37,38,48,41,228,39,44,41,55,56,55,228,37,42,56,41,54,228,42,45,48,56,41,54,45,50,43,242},60))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({244,245,241,43,52,51,243,48,45,38,243,41,37,55,61,35,56,54,37,58,41,48,242,48,57,37},60), _d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,54,51,39,47,61,60,59,37,48,48,243,48,57,37,57,241,39,51,40,41,243,49,37,45,50,243,244,245,35,55,39,54,45,52,56,243,48,45,38,243,41,37,55,61,35,56,54,37,58,41,48,242,48,57,37},60))
if not EasyTravel then
error(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,228,41,37,55,61,35,56,54,37,58,41,48,242,48,57,37},60))
end
EasyTravel.Start()
print(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,9,37,55,61,228,24,54,37,58,41,48,228,55,56,37,54,56,41,40,242},60))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,31,233,40,243,233,40,33,228,24,54,37,58,41,48,48,45,50,43,228,56,51,228,39,44,41,55,56,228,37,56,228,233,55},60), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,16,51,55,56,228,39,44,37,54,37,39,56,41,54,228,166,68,88,228,52,37,57,55,45,50,43,242},60))
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
print(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,5,48,48,228,39,44,41,55,56,55,228,52,54,51,39,41,55,55,41,40,229},60))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({19,52,41,50,7,44,41,55,56,55},60),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()