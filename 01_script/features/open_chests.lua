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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
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
if v:IsA(_d({32,66,63,72,57,61,57,68,73,32,66,63,61,64,68},48)) then
local action = v.ActionText or ""
if action:find(_d({32,53,60,57,240,19,56,53,67,68},48)) then
local part = v.Parent
if part and part:IsA(_d({18,49,67,53,32,49,66,68},48)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({248,245,254,0,54,252,240,245,254,0,54,252,240,245,254,0,54,249},48), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)) then
Core = loadstring(readfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
else
Core = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
end
end)
if not Core then warn(_d({43,19,63,66,53,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,35,68,63,64,64,53,52,254},48))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,17,60,66,53,49,52,73,240,66,69,62,62,57,62,55,241},48)); return end
if not Safeguard then warn(_d({43,35,49,54,53,55,69,49,66,52,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,22,63,69,62,52,240,245,52,240,32,53,60,57,240,19,56,53,67,68,67,240,68,63,68,49,60,240,57,62,240,71,63,66,59,67,64,49,51,53,254},48), #allChests))
if #allChests == 0 then
warn(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,30,63,240,51,56,53,67,68,67,240,54,63,69,62,52,240,178,80,100,240,49,66,53,240,73,63,69,240,57,62,240,68,56,53,240,66,57,55,56,68,240,49,66,53,49,15},48))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,19,63,69,60,52,240,62,63,68,240,54,57,62,52,240,51,56,49,66,49,51,68,53,66,240,66,63,63,68,241,240,17,50,63,66,68,57,62,55,254},48))
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
print(string.format(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,245,52,240,51,56,53,67,68,67,240,65,69,53,69,53,52,240,76,240,245,52,240,63,69,68,67,57,52,53,240,57,67,60,49,62,52,240,76,240,245,52,240,68,63,63,240,56,57,55,56,254},48), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,30,63,240,66,53,49,51,56,49,50,60,53,240,51,56,53,67,68,67,240,49,54,68,53,66,240,54,57,60,68,53,66,57,62,55,254},48))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48))
if not EasyTravel then
error(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,240,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48))
end
EasyTravel.Start()
print(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,21,49,67,73,240,36,66,49,70,53,60,240,67,68,49,66,68,53,52,254},48))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,43,245,52,255,245,52,45,240,36,66,49,70,53,60,60,57,62,55,240,68,63,240,51,56,53,67,68,240,49,68,240,245,67},48), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,28,63,67,68,240,51,56,49,66,49,51,68,53,66,240,178,80,100,240,64,49,69,67,57,62,55,254},48))
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
print(_d({43,31,64,53,62,19,56,53,67,68,67,45,240,17,60,60,240,51,56,53,67,68,67,240,64,66,63,51,53,67,67,53,52,241},48))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({31,64,53,62,19,56,53,67,68,67},48),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()