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
warn(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,42,85,91,78,74,77,98,9,91,94,87,87,82,87,80,10,9,42,75,88,91,93,82,87,80,9,77,94,89,85,82,76,74,93,78,9,85,74,94,87,76,81,23},23))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({57,85,74,98,78,91,92},23))
local RunService       = game:GetService(_d({59,94,87,60,78,91,95,82,76,78},23))
local UserInputService = game:GetService(_d({62,92,78,91,50,87,89,94,93,60,78,91,95,82,76,78},23))
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
if v:IsA(_d({57,91,88,97,82,86,82,93,98,57,91,88,86,89,93},23)) then
local action = v.ActionText
if action:find(_d({57,78,85,82,9,44,81,78,92,93},23)) then
local part = v.Parent
if part and part:IsA(_d({43,74,92,78,57,74,91,93},23)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({17,14,23,25,79,21,9,14,23,25,79,21,9,14,23,25,79,18},23), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
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
print(string.format(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,47,88,94,87,77,9,14,77,9,57,78,85,82,9,44,81,78,92,93,92,9,93,88,93,74,85,9,82,87,9,96,88,91,84,92,89,74,76,78,23},23), #allChests))
if #allChests == 0 then
warn(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,55,88,9,76,81,78,92,93,92,9,79,88,94,87,77,9,203,105,125,9,74,91,78,9,98,88,94,9,82,87,9,93,81,78,9,91,82,80,81,93,9,74,91,78,74,40},23))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,44,88,94,85,77,9,87,88,93,9,79,82,87,77,9,76,81,74,91,74,76,93,78,91,9,91,88,88,93,10,9,42,75,88,91,93,82,87,80,23},23))
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
print(string.format(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,60,84,82,89,89,82,87,80,9,88,94,93,22,88,79,22,75,88,94,87,77,92,9,76,81,78,92,93,9,74,93,9,14,92,9,17,88,94,93,92,82,77,78,9,61,88,96,87,9,88,79,9,43,78,80,82,87,87,82,87,80,92,18},23), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,60,84,82,89,89,82,87,80,9,78,85,78,95,74,93,78,77,9,76,81,78,92,93,9,74,93,9,14,92,9,17,66,38,14,23,25,79,9,39,9,85,82,86,82,93,9,14,23,25,79,18},23),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,23,23,23,9,74,87,77,9,14,77,9,86,88,91,78,9,76,81,78,92,93,92,9,92,84,82,89,89,78,77,9,17,88,94,93,92,82,77,78,9,61,88,96,87,9,88,79,9,43,78,80,82,87,87,82,87,80,92,18,23},23), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({68,56,89,78,87,44,81,78,92,93,92,70,9,14,77,9,76,81,78,92,93,92,9,90,94,78,94,78,77,9,17,87,78,74,91,78,92,93,22,79,82,91,92,93,18,9,101,9,14,77,9,88,94,93,92,82,77,78,9,82,92,85,74,87,77,9,101,9,14,77,9,93,88,88,9,81,82,80,81,23},23),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,55,88,9,91,78,74,76,81,74,75,85,78,9,76,81,78,92,93,92,9,74,79,93,78,91,9,79,82,85,93,78,91,82,87,80,23,9,42,91,78,9,98,88,94,9,74,93,9,61,88,96,87,9,88,79,9,43,78,80,82,87,87,82,87,80,92,40},23))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,9,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74,9,203,105,125,9,76,81,78,76,84,9,96,88,91,84,92,89,74,76,78,9,79,82,85,78,10},23))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,78,74,92,98,72,93,91,74,95,78,85,9,42,57,50,9,87,88,93,9,91,78,93,94,91,87,78,77,9,76,88,91,91,78,76,93,85,98,23},23))
end
task.wait(0.2)
ET.Start()
print(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,46,74,92,98,9,61,91,74,95,78,85,9,92,93,74,91,93,78,77,9,82,87,9,81,78,85,89,78,91,9,86,88,77,78,23},23))
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
print(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,60,93,88,89,89,78,77,35,9},23) .. (reason or _d({77,88,87,78},23)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,57,9,89,91,78,92,92,78,77,9,203,105,125,9,74,75,88,91,93,82,87,80,10},23))
cleanup(_d({57,9,84,78,98,9,74,75,88,91,93},23))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,68,14,77,24,14,77,70,9,61,91,74,95,78,85,85,82,87,80,9,93,88,9,76,81,78,92,93,9,74,93,9,14,92},23), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,53,88,92,93,9,76,81,74,91,74,76,93,78,91,9,203,105,125,9,89,74,94,92,82,87,80,23},23))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,42,91,91,82,95,78,77,10,9,17,77,82,92,93,38,14,23,26,79,18},23), dist))
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
print(string.format(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,56,89,78,87,78,77,9,76,81,78,92,93,9,14,77,10},23), i))
else
warn(string.format(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,79,82,91,78,89,91,88,97,82,86,82,93,98,89,91,88,86,89,93,9,79,74,82,85,78,77,35,9,14,92},23), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,44,81,78,92,93,9,14,77,9,89,91,88,86,89,93,9,87,88,9,85,88,87,80,78,91,9,78,97,82,92,93,92,9,17,86,74,98,9,81,74,95,78,9,77,78,92,89,74,96,87,78,77,18,23},23), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({68,56,89,78,87,44,81,78,92,93,92,70,9,42,85,85,9,76,81,78,92,93,92,9,89,91,88,76,78,92,92,78,77,10},23))
cleanup(_d({74,85,85,9,77,88,87,78},23))
end
end)()