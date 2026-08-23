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
if _G.OpenChestsRunning then
warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,50,93,99,86,82,85,106,17,99,102,95,95,90,95,88,18,17,50,83,96,99,101,90,95,88,17,85,102,97,93,90,84,82,101,86,17,93,82,102,95,84,89,31},15))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({65,93,82,106,86,99,100},15))
local RunService       = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local UserInputService = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
local LocalPlayer      = Players.LocalPlayer
local running = true
local ARRIVE_DIST      = 6
local TIMEOUT_PER_CHEST = 20
local OPEN_WAIT        = 2.5
local TRAVEL_HEIGHT    = 4
local CHECK_HZ         = 0.1
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
if v:IsA(_d({65,99,96,105,90,94,90,101,106,65,99,96,94,97,101},15)) then
local action = v.ActionText
if action:find(_d({65,86,93,90,17,52,89,86,100,101},15)) then
local part = v.Parent
if part and part:IsA(_d({51,82,100,86,65,82,99,101},15)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({25,22,31,33,87,29,17,22,31,33,87,29,17,22,31,33,87,26},15), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
local function getRoot()
local char = LocalPlayer.Character
if not char then return nil end
return char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
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
local allChests = collectChests()
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,55,96,102,95,85,17,22,85,17,65,86,93,90,17,52,89,86,100,101,100,17,101,96,101,82,93,17,90,95,17,104,96,99,92,100,97,82,84,86,31},15), #allChests))
if #allChests == 0 then
warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,63,96,17,84,89,86,100,101,100,17,87,96,102,95,85,17,211,113,133,17,82,99,86,17,106,96,102,17,90,95,17,101,89,86,17,99,90,88,89,101,17,82,99,86,82,48},15))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,52,96,102,93,85,17,95,96,101,17,87,90,95,85,17,84,89,82,99,82,84,101,86,99,17,99,96,96,101,18,17,50,83,96,99,101,90,95,88,31},15))
_G.OpenChestsRunning = false
return
end
local playerStartPos = startRoot.Position
local playerStartY   = playerStartPos.Y
local filtered = {}
local skippedIsland = 0
local skippedY      = 0
for _, c in ipairs(allChests) do
if not isInsideTownOfBeginnings(c.position) then
skippedIsland = skippedIsland + 1
if skippedIsland <= 5 then
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,68,92,90,97,97,90,95,88,17,96,102,101,30,96,87,30,83,96,102,95,85,100,17,84,89,86,100,101,17,82,101,17,22,100,17,25,96,102,101,100,90,85,86,17,69,96,104,95,17,96,87,17,51,86,88,90,95,95,90,95,88,100,26},15), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,68,92,90,97,97,90,95,88,17,86,93,86,103,82,101,86,85,17,84,89,86,100,101,17,82,101,17,22,100,17,25,74,46,22,31,33,87,17,47,17,93,90,94,90,101,17,22,31,33,87,26},15),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,31,31,31,17,82,95,85,17,22,85,17,94,96,99,86,17,84,89,86,100,101,100,17,100,92,90,97,97,86,85,17,25,96,102,101,100,90,85,86,17,69,96,104,95,17,96,87,17,51,86,88,90,95,95,90,95,88,100,26,31},15), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({76,64,97,86,95,52,89,86,100,101,100,78,17,22,85,17,84,89,86,100,101,100,17,98,102,86,102,86,85,17,25,95,86,82,99,86,100,101,30,87,90,99,100,101,26,17,109,17,22,85,17,96,102,101,100,90,85,86,17,90,100,93,82,95,85,17,109,17,22,85,17,101,96,96,17,89,90,88,89,31},15),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,63,96,17,99,86,82,84,89,82,83,93,86,17,84,89,86,100,101,100,17,82,87,101,86,99,17,87,90,93,101,86,99,90,95,88,31,17,50,99,86,17,106,96,102,17,82,101,17,69,96,104,95,17,96,87,17,51,86,88,90,95,95,90,95,88,100,48},15))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({93,90,83,32,86,82,100,106,80,101,99,82,103,86,93,31,93,102,82},15))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,17,86,82,100,106,80,101,99,82,103,86,93,31,93,102,82,17,211,113,133,17,84,89,86,84,92,17,104,96,99,92,100,97,82,84,86,17,87,90,93,86,18},15))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,86,82,100,106,80,101,99,82,103,86,93,17,50,65,58,17,95,96,101,17,99,86,101,102,99,95,86,85,17,84,96,99,99,86,84,101,93,106,31},15))
end
task.wait(0.2)
ET.Start()
print(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,54,82,100,106,17,69,99,82,103,86,93,17,100,101,82,99,101,86,85,17,90,95,17,89,86,93,97,86,99,17,94,96,85,86,31},15))
local function cleanup(reason)
running = false
if ET then
ET.TargetPosition = nil
pcall(ET.Stop)
end
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
_G.EasyTravelHelperMode = nil
_G.OpenChestsRunning = false
print(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,68,101,96,97,97,86,85,43,17},15) .. (reason or _d({85,96,95,86},15)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,65,17,97,99,86,100,100,86,85,17,211,113,133,17,82,83,96,99,101,90,95,88,18},15))
cleanup(_d({65,17,92,86,106,17,82,83,96,99,101},15))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,76,22,85,32,22,85,78,17,69,99,82,103,86,93,93,90,95,88,17,101,96,17,84,89,86,100,101,17,82,101,17,22,100},15), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,61,96,100,101,17,84,89,82,99,82,84,101,86,99,17,211,113,133,17,97,82,102,100,90,95,88,31},15))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,50,99,99,90,103,86,85,18,17,25,85,90,100,101,46,22,31,34,87,26},15), dist))
break
end
end
if not running then break end
local currentRoot = getRoot()
if currentRoot then
ET.TargetPosition = currentRoot.Position
end
if chest.prompt and chest.prompt.Parent then
local ok, err = pcall(function()
fireproximityprompt(chest.prompt)
end)
if ok then
print(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,64,97,86,95,86,85,17,84,89,86,100,101,17,22,85,18},15), i))
else
warn(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,87,90,99,86,97,99,96,105,90,94,90,101,106,97,99,96,94,97,101,17,87,82,90,93,86,85,43,17,22,100},15), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,52,89,86,100,101,17,22,85,17,97,99,96,94,97,101,17,95,96,17,93,96,95,88,86,99,17,86,105,90,100,101,100,17,25,94,82,106,17,89,82,103,86,17,85,86,100,97,82,104,95,86,85,26,31},15), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({76,64,97,86,95,52,89,86,100,101,100,78,17,50,93,93,17,84,89,86,100,101,100,17,97,99,96,84,86,100,100,86,85,18},15))
cleanup(_d({82,93,93,17,85,96,95,86},15))
end
end)()