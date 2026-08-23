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
warn(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,12,55,61,48,44,47,68,235,61,64,57,57,52,57,50,236,235,12,45,58,61,63,52,57,50,235,47,64,59,55,52,46,44,63,48,235,55,44,64,57,46,51,249},53))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({27,55,44,68,48,61,62},53))
local RunService       = game:GetService(_d({29,64,57,30,48,61,65,52,46,48},53))
local UserInputService = game:GetService(_d({32,62,48,61,20,57,59,64,63,30,48,61,65,52,46,48},53))
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
if v:IsA(_d({27,61,58,67,52,56,52,63,68,27,61,58,56,59,63},53)) then
local action = v.ActionText
if action:find(_d({27,48,55,52,235,14,51,48,62,63},53)) then
local part = v.Parent
if part and part:IsA(_d({13,44,62,48,27,44,61,63},53)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({243,240,249,251,49,247,235,240,249,251,49,247,235,240,249,251,49,244},53), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
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
print(string.format(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,17,58,64,57,47,235,240,47,235,27,48,55,52,235,14,51,48,62,63,62,235,63,58,63,44,55,235,52,57,235,66,58,61,54,62,59,44,46,48,249},53), #allChests))
if #allChests == 0 then
warn(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,25,58,235,46,51,48,62,63,62,235,49,58,64,57,47,235,173,75,95,235,44,61,48,235,68,58,64,235,52,57,235,63,51,48,235,61,52,50,51,63,235,44,61,48,44,10},53))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,14,58,64,55,47,235,57,58,63,235,49,52,57,47,235,46,51,44,61,44,46,63,48,61,235,61,58,58,63,236,235,12,45,58,61,63,52,57,50,249},53))
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
print(string.format(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,30,54,52,59,59,52,57,50,235,58,64,63,248,58,49,248,45,58,64,57,47,62,235,46,51,48,62,63,235,44,63,235,240,62,235,243,58,64,63,62,52,47,48,235,31,58,66,57,235,58,49,235,13,48,50,52,57,57,52,57,50,62,244},53), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,30,54,52,59,59,52,57,50,235,48,55,48,65,44,63,48,47,235,46,51,48,62,63,235,44,63,235,240,62,235,243,36,8,240,249,251,49,235,9,235,55,52,56,52,63,235,240,249,251,49,244},53),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,249,249,249,235,44,57,47,235,240,47,235,56,58,61,48,235,46,51,48,62,63,62,235,62,54,52,59,59,48,47,235,243,58,64,63,62,52,47,48,235,31,58,66,57,235,58,49,235,13,48,50,52,57,57,52,57,50,62,244,249},53), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({38,26,59,48,57,14,51,48,62,63,62,40,235,240,47,235,46,51,48,62,63,62,235,60,64,48,64,48,47,235,243,57,48,44,61,48,62,63,248,49,52,61,62,63,244,235,71,235,240,47,235,58,64,63,62,52,47,48,235,52,62,55,44,57,47,235,71,235,240,47,235,63,58,58,235,51,52,50,51,249},53),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,25,58,235,61,48,44,46,51,44,45,55,48,235,46,51,48,62,63,62,235,44,49,63,48,61,235,49,52,55,63,48,61,52,57,50,249,235,12,61,48,235,68,58,64,235,44,63,235,31,58,66,57,235,58,49,235,13,48,50,52,57,57,52,57,50,62,10},53))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({55,52,45,250,48,44,62,68,42,63,61,44,65,48,55,249,55,64,44},53))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,17,44,52,55,48,47,235,63,58,235,55,58,44,47,235,48,44,62,68,42,63,61,44,65,48,55,249,55,64,44,235,173,75,95,235,46,51,48,46,54,235,66,58,61,54,62,59,44,46,48,235,49,52,55,48,236},53))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,48,44,62,68,42,63,61,44,65,48,55,235,12,27,20,235,57,58,63,235,61,48,63,64,61,57,48,47,235,46,58,61,61,48,46,63,55,68,249},53))
end
task.wait(0.2)
ET.Start()
print(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,16,44,62,68,235,31,61,44,65,48,55,235,62,63,44,61,63,48,47,235,52,57,235,51,48,55,59,48,61,235,56,58,47,48,249},53))
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
print(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,30,63,58,59,59,48,47,5,235},53) .. (reason or _d({47,58,57,48},53)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,27,235,59,61,48,62,62,48,47,235,173,75,95,235,44,45,58,61,63,52,57,50,236},53))
cleanup(_d({27,235,54,48,68,235,44,45,58,61,63},53))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,38,240,47,250,240,47,40,235,31,61,44,65,48,55,55,52,57,50,235,63,58,235,46,51,48,62,63,235,44,63,235,240,62},53), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,23,58,62,63,235,46,51,44,61,44,46,63,48,61,235,173,75,95,235,59,44,64,62,52,57,50,249},53))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,12,61,61,52,65,48,47,236,235,243,47,52,62,63,8,240,249,252,49,244},53), dist))
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
print(string.format(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,26,59,48,57,48,47,235,46,51,48,62,63,235,240,47,236},53), i))
else
warn(string.format(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,49,52,61,48,59,61,58,67,52,56,52,63,68,59,61,58,56,59,63,235,49,44,52,55,48,47,5,235,240,62},53), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,14,51,48,62,63,235,240,47,235,59,61,58,56,59,63,235,57,58,235,55,58,57,50,48,61,235,48,67,52,62,63,62,235,243,56,44,68,235,51,44,65,48,235,47,48,62,59,44,66,57,48,47,244,249},53), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({38,26,59,48,57,14,51,48,62,63,62,40,235,12,55,55,235,46,51,48,62,63,62,235,59,61,58,46,48,62,62,48,47,236},53))
cleanup(_d({44,55,55,235,47,58,57,48},53))
end
end)()