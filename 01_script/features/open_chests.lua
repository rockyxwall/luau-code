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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
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
if v:IsA(_d({26,60,57,66,51,55,51,62,67,26,60,57,55,58,62},54)) then
local action = v.ActionText or ""
if action:find(_d({26,47,54,51,234,13,50,47,61,62},54)) then
local part = v.Parent
if part and part:IsA(_d({12,43,61,47,26,43,60,62},54)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({242,239,248,250,48,246,234,239,248,250,48,246,234,239,248,250,48,243},54), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end
local function waitForRoot(timeout)
local t = 0
while t < timeout do
local r = getRoot()
if r then return r end
task.wait(0.1)
t = t + 0.1
end
return nil
end
local function importLib(localPath, rawUrl)
local loaded = false
local result = nil
local oldLazyHub = _G.lazyhub
_G.lazyhub = true
if isfile and readfile then
pcall(function()
if isfile(localPath) then
result = loadstring(readfile(localPath))()
loaded = true
end
end)
end
if not loaded then
pcall(function() result = loadstring(game:HttpGet(rawUrl))() end)
end
_G.lazyhub = oldLazyHub
return result
end
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,29,62,57,58,58,47,46,248},54))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,11,54,60,47,43,46,67,234,60,63,56,56,51,56,49,235},54)); return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,16,57,63,56,46,234,239,46,234,26,47,54,51,234,13,50,47,61,62,61,234,62,57,62,43,54,234,51,56,234,65,57,60,53,61,58,43,45,47,248},54), #allChests))
if #allChests == 0 then
warn(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,24,57,234,45,50,47,61,62,61,234,48,57,63,56,46,234,172,74,94,234,43,60,47,234,67,57,63,234,51,56,234,62,50,47,234,60,51,49,50,62,234,43,60,47,43,9},54))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,13,57,63,54,46,234,56,57,62,234,48,51,56,46,234,45,50,43,60,43,45,62,47,60,234,60,57,57,62,235,234,11,44,57,60,62,51,56,49,248},54))
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
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,239,46,234,45,50,47,61,62,61,234,59,63,47,63,47,46,234,70,234,239,46,234,57,63,62,61,51,46,47,234,51,61,54,43,56,46,234,70,234,239,46,234,62,57,57,234,50,51,49,50,248},54), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,24,57,234,60,47,43,45,50,43,44,54,47,234,45,50,47,61,62,61,234,43,48,62,47,60,234,48,51,54,62,47,60,51,56,49,248},54))
OpenChests.Stop()
return
end
local EasyTravel = importLib(_d({54,51,44,249,47,43,61,67,41,62,60,43,64,47,54,248,54,63,43},54), _d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,60,57,45,53,67,66,65,43,54,54,249,54,63,43,63,247,45,57,46,47,249,55,43,51,56,249,250,251,41,61,45,60,51,58,62,249,54,51,44,249,47,43,61,67,41,62,60,43,64,47,54,248,54,63,43},54))
if not EasyTravel then
error(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,234,47,43,61,67,41,62,60,43,64,47,54,248,54,63,43},54))
end
EasyTravel.Start()
print(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,15,43,61,67,234,30,60,43,64,47,54,234,61,62,43,60,62,47,46,248},54))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,37,239,46,249,239,46,39,234,30,60,43,64,47,54,54,51,56,49,234,62,57,234,45,50,47,61,62,234,43,62,234,239,61},54), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,22,57,61,62,234,45,50,43,60,43,45,62,47,60,234,172,74,94,234,58,43,63,61,51,56,49,248},54))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then break end
end
if not OpenChests.Running then break end
local currentRoot = getRoot()
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
print(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,11,54,54,234,45,50,47,61,62,61,234,58,60,57,45,47,61,61,47,46,235},54))
OpenChests.Stop()
end
end)
end
if not _G.lazyhub then
table.insert(OpenChests.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if OpenChests.Running then
OpenChests.Stop()
else
OpenChests.Start()
end
end
end))
OpenChests.Start()
print(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,29,62,43,56,46,43,54,57,56,47,234,23,57,46,47,4,234,26,60,47,61,61,234,241,39,241,234,62,57,234,62,57,49,49,54,47,248},54))
end
return OpenChests
end)()