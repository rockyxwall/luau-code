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
warn(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,27,70,76,63,59,62,83,250,76,79,72,72,67,72,65,251,250,27,60,73,76,78,67,72,65,250,62,79,74,70,67,61,59,78,63,250,70,59,79,72,61,66,8},38))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({42,70,59,83,63,76,77},38))
local RunService       = game:GetService(_d({44,79,72,45,63,76,80,67,61,63},38))
local UserInputService = game:GetService(_d({47,77,63,76,35,72,74,79,78,45,63,76,80,67,61,63},38))
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
if v:IsA(_d({42,76,73,82,67,71,67,78,83,42,76,73,71,74,78},38)) then
local action = v.ActionText
if action:find(_d({42,63,70,67,250,29,66,63,77,78},38)) then
local part = v.Parent
if part and part:IsA(_d({28,59,77,63,42,59,76,78},38)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({2,255,8,10,64,6,250,255,8,10,64,6,250,255,8,10,64,3},38), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
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
print(string.format(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,32,73,79,72,62,250,255,62,250,42,63,70,67,250,29,66,63,77,78,77,250,78,73,78,59,70,250,67,72,250,81,73,76,69,77,74,59,61,63,8},38), #allChests))
if #allChests == 0 then
warn(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,40,73,250,61,66,63,77,78,77,250,64,73,79,72,62,250,188,90,110,250,59,76,63,250,83,73,79,250,67,72,250,78,66,63,250,76,67,65,66,78,250,59,76,63,59,25},38))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,29,73,79,70,62,250,72,73,78,250,64,67,72,62,250,61,66,59,76,59,61,78,63,76,250,76,73,73,78,251,250,27,60,73,76,78,67,72,65,8},38))
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
print(string.format(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,45,69,67,74,74,67,72,65,250,73,79,78,7,73,64,7,60,73,79,72,62,77,250,61,66,63,77,78,250,59,78,250,255,77,250,2,73,79,78,77,67,62,63,250,46,73,81,72,250,73,64,250,28,63,65,67,72,72,67,72,65,77,3},38), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,45,69,67,74,74,67,72,65,250,63,70,63,80,59,78,63,62,250,61,66,63,77,78,250,59,78,250,255,77,250,2,51,23,255,8,10,64,250,24,250,70,67,71,67,78,250,255,8,10,64,3},38),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,8,8,8,250,59,72,62,250,255,62,250,71,73,76,63,250,61,66,63,77,78,77,250,77,69,67,74,74,63,62,250,2,73,79,78,77,67,62,63,250,46,73,81,72,250,73,64,250,28,63,65,67,72,72,67,72,65,77,3,8},38), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({53,41,74,63,72,29,66,63,77,78,77,55,250,255,62,250,61,66,63,77,78,77,250,75,79,63,79,63,62,250,2,72,63,59,76,63,77,78,7,64,67,76,77,78,3,250,86,250,255,62,250,73,79,78,77,67,62,63,250,67,77,70,59,72,62,250,86,250,255,62,250,78,73,73,250,66,67,65,66,8},38),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,40,73,250,76,63,59,61,66,59,60,70,63,250,61,66,63,77,78,77,250,59,64,78,63,76,250,64,67,70,78,63,76,67,72,65,8,250,27,76,63,250,83,73,79,250,59,78,250,46,73,81,72,250,73,64,250,28,63,65,67,72,72,67,72,65,77,25},38))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({70,67,60,9,63,59,77,83,57,78,76,59,80,63,70,8,70,79,59},38))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,32,59,67,70,63,62,250,78,73,250,70,73,59,62,250,63,59,77,83,57,78,76,59,80,63,70,8,70,79,59,250,188,90,110,250,61,66,63,61,69,250,81,73,76,69,77,74,59,61,63,250,64,67,70,63,251},38))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,63,59,77,83,57,78,76,59,80,63,70,250,27,42,35,250,72,73,78,250,76,63,78,79,76,72,63,62,250,61,73,76,76,63,61,78,70,83,8},38))
end
task.wait(0.2)
ET.Start()
print(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,31,59,77,83,250,46,76,59,80,63,70,250,77,78,59,76,78,63,62,250,67,72,250,66,63,70,74,63,76,250,71,73,62,63,8},38))
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
print(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,45,78,73,74,74,63,62,20,250},38) .. (reason or _d({62,73,72,63},38)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,42,250,74,76,63,77,77,63,62,250,188,90,110,250,59,60,73,76,78,67,72,65,251},38))
cleanup(_d({42,250,69,63,83,250,59,60,73,76,78},38))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,53,255,62,9,255,62,55,250,46,76,59,80,63,70,70,67,72,65,250,78,73,250,61,66,63,77,78,250,59,78,250,255,77},38), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,38,73,77,78,250,61,66,59,76,59,61,78,63,76,250,188,90,110,250,74,59,79,77,67,72,65,8},38))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,27,76,76,67,80,63,62,251,250,2,62,67,77,78,23,255,8,11,64,3},38), dist))
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
print(string.format(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,41,74,63,72,63,62,250,61,66,63,77,78,250,255,62,251},38), i))
else
warn(string.format(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,64,67,76,63,74,76,73,82,67,71,67,78,83,74,76,73,71,74,78,250,64,59,67,70,63,62,20,250,255,77},38), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,29,66,63,77,78,250,255,62,250,74,76,73,71,74,78,250,72,73,250,70,73,72,65,63,76,250,63,82,67,77,78,77,250,2,71,59,83,250,66,59,80,63,250,62,63,77,74,59,81,72,63,62,3,8},38), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({53,41,74,63,72,29,66,63,77,78,77,55,250,27,70,70,250,61,66,63,77,78,77,250,74,76,73,61,63,77,77,63,62,251},38))
cleanup(_d({59,70,70,250,62,73,72,63},38))
end
end)()