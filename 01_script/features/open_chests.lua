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
warn(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,8,51,57,44,40,43,64,231,57,60,53,53,48,53,46,232,231,8,41,54,57,59,48,53,46,231,43,60,55,51,48,42,40,59,44,231,51,40,60,53,42,47,245},57))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({23,51,40,64,44,57,58},57))
local RunService       = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
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
if v:IsA(_d({23,57,54,63,48,52,48,59,64,23,57,54,52,55,59},57)) then
local action = v.ActionText
if action:find(_d({23,44,51,48,231,10,47,44,58,59},57)) then
local part = v.Parent
if part and part:IsA(_d({9,40,58,44,23,40,57,59},57)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({239,236,245,247,45,243,231,236,245,247,45,243,231,236,245,247,45,240},57), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
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
print(string.format(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,13,54,60,53,43,231,236,43,231,23,44,51,48,231,10,47,44,58,59,58,231,59,54,59,40,51,231,48,53,231,62,54,57,50,58,55,40,42,44,245},57), #allChests))
if #allChests == 0 then
warn(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,21,54,231,42,47,44,58,59,58,231,45,54,60,53,43,231,169,71,91,231,40,57,44,231,64,54,60,231,48,53,231,59,47,44,231,57,48,46,47,59,231,40,57,44,40,6},57))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,10,54,60,51,43,231,53,54,59,231,45,48,53,43,231,42,47,40,57,40,42,59,44,57,231,57,54,54,59,232,231,8,41,54,57,59,48,53,46,245},57))
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
print(string.format(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,26,50,48,55,55,48,53,46,231,54,60,59,244,54,45,244,41,54,60,53,43,58,231,42,47,44,58,59,231,40,59,231,236,58,231,239,54,60,59,58,48,43,44,231,27,54,62,53,231,54,45,231,9,44,46,48,53,53,48,53,46,58,240},57), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,26,50,48,55,55,48,53,46,231,44,51,44,61,40,59,44,43,231,42,47,44,58,59,231,40,59,231,236,58,231,239,32,4,236,245,247,45,231,5,231,51,48,52,48,59,231,236,245,247,45,240},57),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,245,245,245,231,40,53,43,231,236,43,231,52,54,57,44,231,42,47,44,58,59,58,231,58,50,48,55,55,44,43,231,239,54,60,59,58,48,43,44,231,27,54,62,53,231,54,45,231,9,44,46,48,53,53,48,53,46,58,240,245},57), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({34,22,55,44,53,10,47,44,58,59,58,36,231,236,43,231,42,47,44,58,59,58,231,56,60,44,60,44,43,231,239,53,44,40,57,44,58,59,244,45,48,57,58,59,240,231,67,231,236,43,231,54,60,59,58,48,43,44,231,48,58,51,40,53,43,231,67,231,236,43,231,59,54,54,231,47,48,46,47,245},57),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,21,54,231,57,44,40,42,47,40,41,51,44,231,42,47,44,58,59,58,231,40,45,59,44,57,231,45,48,51,59,44,57,48,53,46,245,231,8,57,44,231,64,54,60,231,40,59,231,27,54,62,53,231,54,45,231,9,44,46,48,53,53,48,53,46,58,6},57))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({51,48,41,246,44,40,58,64,38,59,57,40,61,44,51,245,51,60,40},57))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,13,40,48,51,44,43,231,59,54,231,51,54,40,43,231,44,40,58,64,38,59,57,40,61,44,51,245,51,60,40,231,169,71,91,231,42,47,44,42,50,231,62,54,57,50,58,55,40,42,44,231,45,48,51,44,232},57))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,44,40,58,64,38,59,57,40,61,44,51,231,8,23,16,231,53,54,59,231,57,44,59,60,57,53,44,43,231,42,54,57,57,44,42,59,51,64,245},57))
end
task.wait(0.2)
ET.Start()
print(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,12,40,58,64,231,27,57,40,61,44,51,231,58,59,40,57,59,44,43,231,48,53,231,47,44,51,55,44,57,231,52,54,43,44,245},57))
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
print(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,26,59,54,55,55,44,43,1,231},57) .. (reason or _d({43,54,53,44},57)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,23,231,55,57,44,58,58,44,43,231,169,71,91,231,40,41,54,57,59,48,53,46,232},57))
cleanup(_d({23,231,50,44,64,231,40,41,54,57,59},57))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,34,236,43,246,236,43,36,231,27,57,40,61,44,51,51,48,53,46,231,59,54,231,42,47,44,58,59,231,40,59,231,236,58},57), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,19,54,58,59,231,42,47,40,57,40,42,59,44,57,231,169,71,91,231,55,40,60,58,48,53,46,245},57))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,8,57,57,48,61,44,43,232,231,239,43,48,58,59,4,236,245,248,45,240},57), dist))
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
print(string.format(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,22,55,44,53,44,43,231,42,47,44,58,59,231,236,43,232},57), i))
else
warn(string.format(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,45,48,57,44,55,57,54,63,48,52,48,59,64,55,57,54,52,55,59,231,45,40,48,51,44,43,1,231,236,58},57), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,10,47,44,58,59,231,236,43,231,55,57,54,52,55,59,231,53,54,231,51,54,53,46,44,57,231,44,63,48,58,59,58,231,239,52,40,64,231,47,40,61,44,231,43,44,58,55,40,62,53,44,43,240,245},57), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({34,22,55,44,53,10,47,44,58,59,58,36,231,8,51,51,231,42,47,44,58,59,58,231,55,57,54,42,44,58,58,44,43,232},57))
cleanup(_d({40,51,51,231,43,54,53,44},57))
end
end)()