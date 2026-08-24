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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local UserInputService = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
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
if v:IsA(_d({60,94,91,100,85,89,85,96,101,60,94,91,89,92,96},20)) then
local action = v.ActionText or ""
if action:find(_d({60,81,88,85,12,47,84,81,95,96},20)) then
local part = v.Parent
if part and part:IsA(_d({46,77,95,81,60,77,94,96},20)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({20,17,26,28,82,24,12,17,26,28,82,24,12,17,26,28,82,21},20), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
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
print(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,63,96,91,92,92,81,80,26},20))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,45,88,94,81,77,80,101,12,94,97,90,90,85,90,83,13},20)) return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,50,91,97,90,80,12,17,80,12,60,81,88,85,12,47,84,81,95,96,95,12,96,91,96,77,88,12,85,90,12,99,91,94,87,95,92,77,79,81,26},20), #allChests))
if #allChests == 0 then
warn(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,58,91,12,79,84,81,95,96,95,12,82,91,97,90,80,12,206,108,128,12,77,94,81,12,101,91,97,12,85,90,12,96,84,81,12,94,85,83,84,96,12,77,94,81,77,43},20))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,47,91,97,88,80,12,90,91,96,12,82,85,90,80,12,79,84,77,94,77,79,96,81,94,12,94,91,91,96,13,12,45,78,91,94,96,85,90,83,26},20))
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
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,17,80,12,79,84,81,95,96,95,12,93,97,81,97,81,80,12,104,12,17,80,12,91,97,96,95,85,80,81,12,85,95,88,77,90,80,12,104,12,17,80,12,96,91,91,12,84,85,83,84,26},20), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,58,91,12,94,81,77,79,84,77,78,88,81,12,79,84,81,95,96,95,12,77,82,96,81,94,12,82,85,88,96,81,94,85,90,83,26},20))
OpenChests.Stop()
return
end
local EasyTravel = importLib(_d({88,85,78,27,81,77,95,101,75,96,94,77,98,81,88,26,88,97,77},20), _d({84,96,96,92,95,38,27,27,94,77,99,26,83,85,96,84,97,78,97,95,81,94,79,91,90,96,81,90,96,26,79,91,89,27,94,91,79,87,101,100,99,77,88,88,27,88,97,77,97,25,79,91,80,81,27,89,77,85,90,27,28,29,75,95,79,94,85,92,96,27,88,85,78,27,81,77,95,101,75,96,94,77,98,81,88,26,88,97,77},20))
if not EasyTravel then
error(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,50,77,85,88,81,80,12,96,91,12,88,91,77,80,12,81,77,95,101,75,96,94,77,98,81,88,26,88,97,77},20))
end
EasyTravel.Start()
print(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,49,77,95,101,12,64,94,77,98,81,88,12,95,96,77,94,96,81,80,26},20))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,71,17,80,27,17,80,73,12,64,94,77,98,81,88,88,85,90,83,12,96,91,12,79,84,81,95,96,12,77,96,12,17,95},20), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,56,91,95,96,12,79,84,77,94,77,79,96,81,94,12,206,108,128,12,92,77,97,95,85,90,83,26},20))
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
print(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,45,88,88,12,79,84,81,95,96,95,12,92,94,91,79,81,95,95,81,80,13},20))
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
print(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,63,96,77,90,80,77,88,91,90,81,12,57,91,80,81,38,12,60,94,81,95,95,12,19,73,19,12,96,91,12,96,91,83,83,88,81,26},20))
end
return OpenChests
end)()