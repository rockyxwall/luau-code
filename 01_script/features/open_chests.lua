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
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
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
if v:IsA(_d({24,58,55,64,49,53,49,60,65,24,58,55,53,56,60},56)) then
local action = v.ActionText or ""
if action:find(_d({24,45,52,49,232,11,48,45,59,60},56)) then
local part = v.Parent
if part and part:IsA(_d({10,41,59,45,24,41,58,60},56)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({240,237,246,248,46,244,232,237,246,248,46,244,232,237,246,248,46,241},56), part.Position.X, part.Position.Y, part.Position.Z)
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
if isfile and readfile and isfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)) then
Core = loadstring(readfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
else
Core = loadstring(game:HttpGet(_d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
end
end)
if not Core then warn(_d({35,11,55,58,45,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,27,60,55,56,56,45,44,246},56))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,9,52,58,45,41,44,65,232,58,61,54,54,49,54,47,233},56)); return end
if not Safeguard then warn(_d({35,27,41,46,45,47,61,41,58,44,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,14,55,61,54,44,232,237,44,232,24,45,52,49,232,11,48,45,59,60,59,232,60,55,60,41,52,232,49,54,232,63,55,58,51,59,56,41,43,45,246},56), #allChests))
if #allChests == 0 then
warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,22,55,232,43,48,45,59,60,59,232,46,55,61,54,44,232,170,72,92,232,41,58,45,232,65,55,61,232,49,54,232,60,48,45,232,58,49,47,48,60,232,41,58,45,41,7},56))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,11,55,61,52,44,232,54,55,60,232,46,49,54,44,232,43,48,41,58,41,43,60,45,58,232,58,55,55,60,233,232,9,42,55,58,60,49,54,47,246},56))
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
print(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,237,44,232,43,48,45,59,60,59,232,57,61,45,61,45,44,232,68,232,237,44,232,55,61,60,59,49,44,45,232,49,59,52,41,54,44,232,68,232,237,44,232,60,55,55,232,48,49,47,48,246},56), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,22,55,232,58,45,41,43,48,41,42,52,45,232,43,48,45,59,60,59,232,41,46,60,45,58,232,46,49,52,60,45,58,49,54,47,246},56))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({248,249,245,47,56,55,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
if not EasyTravel then
error(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,232,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
end
EasyTravel.Start()
print(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,13,41,59,65,232,28,58,41,62,45,52,232,59,60,41,58,60,45,44,246},56))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,35,237,44,247,237,44,37,232,28,58,41,62,45,52,52,49,54,47,232,60,55,232,43,48,45,59,60,232,41,60,232,237,59},56), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,20,55,59,60,232,43,48,41,58,41,43,60,45,58,232,170,72,92,232,56,41,61,59,49,54,47,246},56))
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
print(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,9,52,52,232,43,48,45,59,60,59,232,56,58,55,43,45,59,59,45,44,233},56))
OpenChests.Stop()
end
end)
end
if not _G.DisableStandalone then
table.insert(OpenChests.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if OpenChests.Running then
OpenChests.Stop()
else
OpenChests.Start()
end
end
end))
OpenChests.Start()
print(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,27,60,41,54,44,41,52,55,54,45,232,21,55,44,45,2,232,24,58,45,59,59,232,239,24,239,232,60,55,232,60,55,47,47,52,45,246},56))
end
return OpenChests
end)()