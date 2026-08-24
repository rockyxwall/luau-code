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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local UserInputService = game:GetService(_d({23,53,39,52,11,48,50,55,54,21,39,52,56,43,37,39},62))
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
if v:IsA(_d({18,52,49,58,43,47,43,54,59,18,52,49,47,50,54},62)) then
local action = v.ActionText or ""
if action:find(_d({18,39,46,43,226,5,42,39,53,54},62)) then
local part = v.Parent
if part and part:IsA(_d({4,35,53,39,18,35,52,54},62)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({234,231,240,242,40,238,226,231,240,242,40,238,226,231,240,242,40,235},62), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({242,243,239,41,50,49,241,46,43,36,241,37,49,52,39,240,46,55,35},62)) then
Core = loadstring(readfile(_d({242,243,239,41,50,49,241,46,43,36,241,37,49,52,39,240,46,55,35},62)))()
else
Core = loadstring(game:HttpGet(_d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,46,55,35,55,239,37,49,38,39,241,47,35,43,48,241,242,243,33,53,37,52,43,50,54,241,46,43,36,241,37,49,52,39,240,46,55,35},62)))()
end
end)
if not Core then warn(_d({29,5,49,52,39,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,227},62)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,21,54,49,50,50,39,38,240},62))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,3,46,52,39,35,38,59,226,52,55,48,48,43,48,41,227},62)); return end
if not Safeguard then warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,227},62)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,8,49,55,48,38,226,231,38,226,18,39,46,43,226,5,42,39,53,54,53,226,54,49,54,35,46,226,43,48,226,57,49,52,45,53,50,35,37,39,240},62), #allChests))
if #allChests == 0 then
warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,16,49,226,37,42,39,53,54,53,226,40,49,55,48,38,226,164,66,86,226,35,52,39,226,59,49,55,226,43,48,226,54,42,39,226,52,43,41,42,54,226,35,52,39,35,1},62))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,5,49,55,46,38,226,48,49,54,226,40,43,48,38,226,37,42,35,52,35,37,54,39,52,226,52,49,49,54,227,226,3,36,49,52,54,43,48,41,240},62))
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
print(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,231,38,226,37,42,39,53,54,53,226,51,55,39,55,39,38,226,62,226,231,38,226,49,55,54,53,43,38,39,226,43,53,46,35,48,38,226,62,226,231,38,226,54,49,49,226,42,43,41,42,240},62), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,16,49,226,52,39,35,37,42,35,36,46,39,226,37,42,39,53,54,53,226,35,40,54,39,52,226,40,43,46,54,39,52,43,48,41,240},62))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({242,243,239,41,50,49,241,46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62), _d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,46,55,35,55,239,37,49,38,39,241,47,35,43,48,241,242,243,33,53,37,52,43,50,54,241,46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62))
if not EasyTravel then
error(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,226,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62))
end
EasyTravel.Start()
print(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,7,35,53,59,226,22,52,35,56,39,46,226,53,54,35,52,54,39,38,240},62))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,29,231,38,241,231,38,31,226,22,52,35,56,39,46,46,43,48,41,226,54,49,226,37,42,39,53,54,226,35,54,226,231,53},62), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,14,49,53,54,226,37,42,35,52,35,37,54,39,52,226,164,66,86,226,50,35,55,53,43,48,41,240},62))
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
print(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,3,46,46,226,37,42,39,53,54,53,226,50,52,49,37,39,53,53,39,38,227},62))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({17,50,39,48,5,42,39,53,54,53},62),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()