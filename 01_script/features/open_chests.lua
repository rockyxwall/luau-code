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
warn(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,46,89,95,82,78,81,102,13,95,98,91,91,86,91,84,14,13,46,79,92,95,97,86,91,84,13,81,98,93,89,86,80,78,97,82,13,89,78,98,91,80,85,27},19))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({61,89,78,102,82,95,96},19))
local RunService       = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
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
if v:IsA(_d({61,95,92,101,86,90,86,97,102,61,95,92,90,93,97},19)) then
local action = v.ActionText
if action:find(_d({61,82,89,86,13,48,85,82,96,97},19)) then
local part = v.Parent
if part and part:IsA(_d({47,78,96,82,61,78,95,97},19)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({21,18,27,29,83,25,13,18,27,29,83,25,13,18,27,29,83,22},19), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
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
print(string.format(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,51,92,98,91,81,13,18,81,13,61,82,89,86,13,48,85,82,96,97,96,13,97,92,97,78,89,13,86,91,13,100,92,95,88,96,93,78,80,82,27},19), #allChests))
if #allChests == 0 then
warn(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,59,92,13,80,85,82,96,97,96,13,83,92,98,91,81,13,207,109,129,13,78,95,82,13,102,92,98,13,86,91,13,97,85,82,13,95,86,84,85,97,13,78,95,82,78,44},19))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,48,92,98,89,81,13,91,92,97,13,83,86,91,81,13,80,85,78,95,78,80,97,82,95,13,95,92,92,97,14,13,46,79,92,95,97,86,91,84,27},19))
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
print(string.format(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,64,88,86,93,93,86,91,84,13,92,98,97,26,92,83,26,79,92,98,91,81,96,13,80,85,82,96,97,13,78,97,13,18,96,13,21,92,98,97,96,86,81,82,13,65,92,100,91,13,92,83,13,47,82,84,86,91,91,86,91,84,96,22},19), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,64,88,86,93,93,86,91,84,13,82,89,82,99,78,97,82,81,13,80,85,82,96,97,13,78,97,13,18,96,13,21,70,42,18,27,29,83,13,43,13,89,86,90,86,97,13,18,27,29,83,22},19),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,27,27,27,13,78,91,81,13,18,81,13,90,92,95,82,13,80,85,82,96,97,96,13,96,88,86,93,93,82,81,13,21,92,98,97,96,86,81,82,13,65,92,100,91,13,92,83,13,47,82,84,86,91,91,86,91,84,96,22,27},19), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({72,60,93,82,91,48,85,82,96,97,96,74,13,18,81,13,80,85,82,96,97,96,13,94,98,82,98,82,81,13,21,91,82,78,95,82,96,97,26,83,86,95,96,97,22,13,105,13,18,81,13,92,98,97,96,86,81,82,13,86,96,89,78,91,81,13,105,13,18,81,13,97,92,92,13,85,86,84,85,27},19),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,59,92,13,95,82,78,80,85,78,79,89,82,13,80,85,82,96,97,96,13,78,83,97,82,95,13,83,86,89,97,82,95,86,91,84,27,13,46,95,82,13,102,92,98,13,78,97,13,65,92,100,91,13,92,83,13,47,82,84,86,91,91,86,91,84,96,44},19))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({89,86,79,28,82,78,96,102,76,97,95,78,99,82,89,27,89,98,78},19))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,13,82,78,96,102,76,97,95,78,99,82,89,27,89,98,78,13,207,109,129,13,80,85,82,80,88,13,100,92,95,88,96,93,78,80,82,13,83,86,89,82,14},19))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,82,78,96,102,76,97,95,78,99,82,89,13,46,61,54,13,91,92,97,13,95,82,97,98,95,91,82,81,13,80,92,95,95,82,80,97,89,102,27},19))
end
task.wait(0.2)
ET.Start()
print(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,50,78,96,102,13,65,95,78,99,82,89,13,96,97,78,95,97,82,81,13,86,91,13,85,82,89,93,82,95,13,90,92,81,82,27},19))
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
print(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,64,97,92,93,93,82,81,39,13},19) .. (reason or _d({81,92,91,82},19)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,61,13,93,95,82,96,96,82,81,13,207,109,129,13,78,79,92,95,97,86,91,84,14},19))
cleanup(_d({61,13,88,82,102,13,78,79,92,95,97},19))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,72,18,81,28,18,81,74,13,65,95,78,99,82,89,89,86,91,84,13,97,92,13,80,85,82,96,97,13,78,97,13,18,96},19), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,57,92,96,97,13,80,85,78,95,78,80,97,82,95,13,207,109,129,13,93,78,98,96,86,91,84,27},19))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,46,95,95,86,99,82,81,14,13,21,81,86,96,97,42,18,27,30,83,22},19), dist))
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
print(string.format(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,60,93,82,91,82,81,13,80,85,82,96,97,13,18,81,14},19), i))
else
warn(string.format(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,83,86,95,82,93,95,92,101,86,90,86,97,102,93,95,92,90,93,97,13,83,78,86,89,82,81,39,13,18,96},19), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,48,85,82,96,97,13,18,81,13,93,95,92,90,93,97,13,91,92,13,89,92,91,84,82,95,13,82,101,86,96,97,96,13,21,90,78,102,13,85,78,99,82,13,81,82,96,93,78,100,91,82,81,22,27},19), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({72,60,93,82,91,48,85,82,96,97,96,74,13,46,89,89,13,80,85,82,96,97,96,13,93,95,92,80,82,96,96,82,81,14},19))
cleanup(_d({78,89,89,13,81,92,91,82},19))
end
end)()