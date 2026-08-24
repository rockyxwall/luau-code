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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local UserInputService = game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64))
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
if v:IsA(_d({16,50,47,56,41,45,41,52,57,16,50,47,45,48,52},64)) then
local action = v.ActionText or ""
if action:find(_d({16,37,44,41,224,3,40,37,51,52},64)) then
local part = v.Parent
if part and part:IsA(_d({2,33,51,37,16,33,50,52},64)) then
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
if isfile and readfile and isfile(_d({240,241,237,39,48,47,239,44,41,34,239,35,47,50,37,238,44,53,33},64)) then
Core = loadstring(readfile(_d({240,241,237,39,48,47,239,44,41,34,239,35,47,50,37,238,44,53,33},64)))()
else
Core = loadstring(game:HttpGet(_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,50,47,35,43,57,56,55,33,44,44,239,44,53,33,53,237,35,47,36,37,239,45,33,41,46,239,240,241,31,51,35,50,41,48,52,239,44,41,34,239,35,47,50,37,238,44,53,33},64)))()
end
end)
if not Core then warn(_d({27,3,47,50,37,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,225},64)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,19,52,47,48,48,37,36,238},64))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,1,44,50,37,33,36,57,224,50,53,46,46,41,46,39,225},64)); return end
if not Safeguard then warn(_d({27,19,33,38,37,39,53,33,50,36,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,225},64)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,6,47,53,46,36,224,229,36,224,16,37,44,41,224,3,40,37,51,52,51,224,52,47,52,33,44,224,41,46,224,55,47,50,43,51,48,33,35,37,238},64), #allChests))
if #allChests == 0 then
warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,14,47,224,35,40,37,51,52,51,224,38,47,53,46,36,224,162,64,84,224,33,50,37,224,57,47,53,224,41,46,224,52,40,37,224,50,41,39,40,52,224,33,50,37,33,255},64))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,3,47,53,44,36,224,46,47,52,224,38,41,46,36,224,35,40,33,50,33,35,52,37,50,224,50,47,47,52,225,224,1,34,47,50,52,41,46,39,238},64))
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
print(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,229,36,224,35,40,37,51,52,51,224,49,53,37,53,37,36,224,60,224,229,36,224,47,53,52,51,41,36,37,224,41,51,44,33,46,36,224,60,224,229,36,224,52,47,47,224,40,41,39,40,238},64), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,14,47,224,50,37,33,35,40,33,34,44,37,224,35,40,37,51,52,51,224,33,38,52,37,50,224,38,41,44,52,37,50,41,46,39,238},64))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({240,241,237,39,48,47,239,44,41,34,239,37,33,51,57,31,52,50,33,54,37,44,238,44,53,33},64), _d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,50,47,35,43,57,56,55,33,44,44,239,44,53,33,53,237,35,47,36,37,239,45,33,41,46,239,240,241,31,51,35,50,41,48,52,239,44,41,34,239,37,33,51,57,31,52,50,33,54,37,44,238,44,53,33},64))
if not EasyTravel then
error(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,224,37,33,51,57,31,52,50,33,54,37,44,238,44,53,33},64))
end
EasyTravel.Start()
print(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,5,33,51,57,224,20,50,33,54,37,44,224,51,52,33,50,52,37,36,238},64))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,27,229,36,239,229,36,29,224,20,50,33,54,37,44,44,41,46,39,224,52,47,224,35,40,37,51,52,224,33,52,224,229,51},64), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,12,47,51,52,224,35,40,33,50,33,35,52,37,50,224,162,64,84,224,48,33,53,51,41,46,39,238},64))
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
print(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,1,44,44,224,35,40,37,51,52,51,224,48,50,47,35,37,51,51,37,36,225},64))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({15,48,37,46,3,40,37,51,52,51},64),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()