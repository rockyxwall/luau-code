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
warn(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,43,86,92,79,75,78,99,10,92,95,88,88,83,88,81,11,10,43,76,89,92,94,83,88,81,10,78,95,90,86,83,77,75,94,79,10,86,75,95,88,77,82,24},22))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({58,86,75,99,79,92,93},22))
local RunService       = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local UserInputService = game:GetService(_d({63,93,79,92,51,88,90,95,94,61,79,92,96,83,77,79},22))
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
if v:IsA(_d({58,92,89,98,83,87,83,94,99,58,92,89,87,90,94},22)) then
local action = v.ActionText
if action:find(_d({58,79,86,83,10,45,82,79,93,94},22)) then
local part = v.Parent
if part and part:IsA(_d({44,75,93,79,58,75,92,94},22)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({18,15,24,26,80,22,10,15,24,26,80,22,10,15,24,26,80,19},22), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
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
print(string.format(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,48,89,95,88,78,10,15,78,10,58,79,86,83,10,45,82,79,93,94,93,10,94,89,94,75,86,10,83,88,10,97,89,92,85,93,90,75,77,79,24},22), #allChests))
if #allChests == 0 then
warn(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,56,89,10,77,82,79,93,94,93,10,80,89,95,88,78,10,204,106,126,10,75,92,79,10,99,89,95,10,83,88,10,94,82,79,10,92,83,81,82,94,10,75,92,79,75,41},22))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,45,89,95,86,78,10,88,89,94,10,80,83,88,78,10,77,82,75,92,75,77,94,79,92,10,92,89,89,94,11,10,43,76,89,92,94,83,88,81,24},22))
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
print(string.format(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,61,85,83,90,90,83,88,81,10,89,95,94,23,89,80,23,76,89,95,88,78,93,10,77,82,79,93,94,10,75,94,10,15,93,10,18,89,95,94,93,83,78,79,10,62,89,97,88,10,89,80,10,44,79,81,83,88,88,83,88,81,93,19},22), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,61,85,83,90,90,83,88,81,10,79,86,79,96,75,94,79,78,10,77,82,79,93,94,10,75,94,10,15,93,10,18,67,39,15,24,26,80,10,40,10,86,83,87,83,94,10,15,24,26,80,19},22),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,24,24,24,10,75,88,78,10,15,78,10,87,89,92,79,10,77,82,79,93,94,93,10,93,85,83,90,90,79,78,10,18,89,95,94,93,83,78,79,10,62,89,97,88,10,89,80,10,44,79,81,83,88,88,83,88,81,93,19,24},22), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({69,57,90,79,88,45,82,79,93,94,93,71,10,15,78,10,77,82,79,93,94,93,10,91,95,79,95,79,78,10,18,88,79,75,92,79,93,94,23,80,83,92,93,94,19,10,102,10,15,78,10,89,95,94,93,83,78,79,10,83,93,86,75,88,78,10,102,10,15,78,10,94,89,89,10,82,83,81,82,24},22),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,56,89,10,92,79,75,77,82,75,76,86,79,10,77,82,79,93,94,93,10,75,80,94,79,92,10,80,83,86,94,79,92,83,88,81,24,10,43,92,79,10,99,89,95,10,75,94,10,62,89,97,88,10,89,80,10,44,79,81,83,88,88,83,88,81,93,41},22))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({86,83,76,25,79,75,93,99,73,94,92,75,96,79,86,24,86,95,75},22))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,10,79,75,93,99,73,94,92,75,96,79,86,24,86,95,75,10,204,106,126,10,77,82,79,77,85,10,97,89,92,85,93,90,75,77,79,10,80,83,86,79,11},22))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,79,75,93,99,73,94,92,75,96,79,86,10,43,58,51,10,88,89,94,10,92,79,94,95,92,88,79,78,10,77,89,92,92,79,77,94,86,99,24},22))
end
task.wait(0.2)
ET.Start()
print(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,47,75,93,99,10,62,92,75,96,79,86,10,93,94,75,92,94,79,78,10,83,88,10,82,79,86,90,79,92,10,87,89,78,79,24},22))
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
print(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,61,94,89,90,90,79,78,36,10},22) .. (reason or _d({78,89,88,79},22)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,58,10,90,92,79,93,93,79,78,10,204,106,126,10,75,76,89,92,94,83,88,81,11},22))
cleanup(_d({58,10,85,79,99,10,75,76,89,92,94},22))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,69,15,78,25,15,78,71,10,62,92,75,96,79,86,86,83,88,81,10,94,89,10,77,82,79,93,94,10,75,94,10,15,93},22), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,54,89,93,94,10,77,82,75,92,75,77,94,79,92,10,204,106,126,10,90,75,95,93,83,88,81,24},22))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,43,92,92,83,96,79,78,11,10,18,78,83,93,94,39,15,24,27,80,19},22), dist))
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
print(string.format(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,57,90,79,88,79,78,10,77,82,79,93,94,10,15,78,11},22), i))
else
warn(string.format(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,80,83,92,79,90,92,89,98,83,87,83,94,99,90,92,89,87,90,94,10,80,75,83,86,79,78,36,10,15,93},22), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,45,82,79,93,94,10,15,78,10,90,92,89,87,90,94,10,88,89,10,86,89,88,81,79,92,10,79,98,83,93,94,93,10,18,87,75,99,10,82,75,96,79,10,78,79,93,90,75,97,88,79,78,19,24},22), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({69,57,90,79,88,45,82,79,93,94,93,71,10,43,86,86,10,77,82,79,93,94,93,10,90,92,89,77,79,93,93,79,78,11},22))
cleanup(_d({75,86,86,10,78,89,88,79},22))
end
end)()