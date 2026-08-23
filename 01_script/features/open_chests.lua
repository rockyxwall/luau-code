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
warn(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,40,83,89,76,72,75,96,7,89,92,85,85,80,85,78,8,7,40,73,86,89,91,80,85,78,7,75,92,87,83,80,74,72,91,76,7,83,72,92,85,74,79,21},25))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({55,83,72,96,76,89,90},25))
local RunService       = game:GetService(_d({57,92,85,58,76,89,93,80,74,76},25))
local UserInputService = game:GetService(_d({60,90,76,89,48,85,87,92,91,58,76,89,93,80,74,76},25))
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
if v:IsA(_d({55,89,86,95,80,84,80,91,96,55,89,86,84,87,91},25)) then
local action = v.ActionText
if action:find(_d({55,76,83,80,7,42,79,76,90,91},25)) then
local part = v.Parent
if part and part:IsA(_d({41,72,90,76,55,72,89,91},25)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({15,12,21,23,77,19,7,12,21,23,77,19,7,12,21,23,77,16},25), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
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
print(string.format(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,45,86,92,85,75,7,12,75,7,55,76,83,80,7,42,79,76,90,91,90,7,91,86,91,72,83,7,80,85,7,94,86,89,82,90,87,72,74,76,21},25), #allChests))
if #allChests == 0 then
warn(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,53,86,7,74,79,76,90,91,90,7,77,86,92,85,75,7,201,103,123,7,72,89,76,7,96,86,92,7,80,85,7,91,79,76,7,89,80,78,79,91,7,72,89,76,72,38},25))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,42,86,92,83,75,7,85,86,91,7,77,80,85,75,7,74,79,72,89,72,74,91,76,89,7,89,86,86,91,8,7,40,73,86,89,91,80,85,78,21},25))
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
print(string.format(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,58,82,80,87,87,80,85,78,7,86,92,91,20,86,77,20,73,86,92,85,75,90,7,74,79,76,90,91,7,72,91,7,12,90,7,15,86,92,91,90,80,75,76,7,59,86,94,85,7,86,77,7,41,76,78,80,85,85,80,85,78,90,16},25), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,58,82,80,87,87,80,85,78,7,76,83,76,93,72,91,76,75,7,74,79,76,90,91,7,72,91,7,12,90,7,15,64,36,12,21,23,77,7,37,7,83,80,84,80,91,7,12,21,23,77,16},25),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,21,21,21,7,72,85,75,7,12,75,7,84,86,89,76,7,74,79,76,90,91,90,7,90,82,80,87,87,76,75,7,15,86,92,91,90,80,75,76,7,59,86,94,85,7,86,77,7,41,76,78,80,85,85,80,85,78,90,16,21},25), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({66,54,87,76,85,42,79,76,90,91,90,68,7,12,75,7,74,79,76,90,91,90,7,88,92,76,92,76,75,7,15,85,76,72,89,76,90,91,20,77,80,89,90,91,16,7,99,7,12,75,7,86,92,91,90,80,75,76,7,80,90,83,72,85,75,7,99,7,12,75,7,91,86,86,7,79,80,78,79,21},25),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,53,86,7,89,76,72,74,79,72,73,83,76,7,74,79,76,90,91,90,7,72,77,91,76,89,7,77,80,83,91,76,89,80,85,78,21,7,40,89,76,7,96,86,92,7,72,91,7,59,86,94,85,7,86,77,7,41,76,78,80,85,85,80,85,78,90,38},25))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({83,80,73,22,76,72,90,96,70,91,89,72,93,76,83,21,83,92,72},25))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,45,72,80,83,76,75,7,91,86,7,83,86,72,75,7,76,72,90,96,70,91,89,72,93,76,83,21,83,92,72,7,201,103,123,7,74,79,76,74,82,7,94,86,89,82,90,87,72,74,76,7,77,80,83,76,8},25))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,76,72,90,96,70,91,89,72,93,76,83,7,40,55,48,7,85,86,91,7,89,76,91,92,89,85,76,75,7,74,86,89,89,76,74,91,83,96,21},25))
end
task.wait(0.2)
ET.Start()
print(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,44,72,90,96,7,59,89,72,93,76,83,7,90,91,72,89,91,76,75,7,80,85,7,79,76,83,87,76,89,7,84,86,75,76,21},25))
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
print(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,58,91,86,87,87,76,75,33,7},25) .. (reason or _d({75,86,85,76},25)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,55,7,87,89,76,90,90,76,75,7,201,103,123,7,72,73,86,89,91,80,85,78,8},25))
cleanup(_d({55,7,82,76,96,7,72,73,86,89,91},25))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,66,12,75,22,12,75,68,7,59,89,72,93,76,83,83,80,85,78,7,91,86,7,74,79,76,90,91,7,72,91,7,12,90},25), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,51,86,90,91,7,74,79,72,89,72,74,91,76,89,7,201,103,123,7,87,72,92,90,80,85,78,21},25))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,40,89,89,80,93,76,75,8,7,15,75,80,90,91,36,12,21,24,77,16},25), dist))
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
print(string.format(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,54,87,76,85,76,75,7,74,79,76,90,91,7,12,75,8},25), i))
else
warn(string.format(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,77,80,89,76,87,89,86,95,80,84,80,91,96,87,89,86,84,87,91,7,77,72,80,83,76,75,33,7,12,90},25), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,42,79,76,90,91,7,12,75,7,87,89,86,84,87,91,7,85,86,7,83,86,85,78,76,89,7,76,95,80,90,91,90,7,15,84,72,96,7,79,72,93,76,7,75,76,90,87,72,94,85,76,75,16,21},25), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({66,54,87,76,85,42,79,76,90,91,90,68,7,40,83,83,7,74,79,76,90,91,90,7,87,89,86,74,76,90,90,76,75,8},25))
cleanup(_d({72,83,83,7,75,86,85,76},25))
end
end)()