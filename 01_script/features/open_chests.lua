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
warn(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,11,54,60,47,43,46,67,234,60,63,56,56,51,56,49,235,234,11,44,57,60,62,51,56,49,234,46,63,58,54,51,45,43,62,47,234,54,43,63,56,45,50,248},54))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({26,54,43,67,47,60,61},54))
local RunService       = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
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
if v:IsA(_d({26,60,57,66,51,55,51,62,67,26,60,57,55,58,62},54)) then
local action = v.ActionText
if action:find(_d({26,47,54,51,234,13,50,47,61,62},54)) then
local part = v.Parent
if part and part:IsA(_d({12,43,61,47,26,43,60,62},54)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({242,239,248,250,48,246,234,239,248,250,48,246,234,239,248,250,48,243},54), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
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
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,16,57,63,56,46,234,239,46,234,26,47,54,51,234,13,50,47,61,62,61,234,62,57,62,43,54,234,51,56,234,65,57,60,53,61,58,43,45,47,248},54), #allChests))
if #allChests == 0 then
warn(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,24,57,234,45,50,47,61,62,61,234,48,57,63,56,46,234,172,74,94,234,43,60,47,234,67,57,63,234,51,56,234,62,50,47,234,60,51,49,50,62,234,43,60,47,43,9},54))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,13,57,63,54,46,234,56,57,62,234,48,51,56,46,234,45,50,43,60,43,45,62,47,60,234,60,57,57,62,235,234,11,44,57,60,62,51,56,49,248},54))
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
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,29,53,51,58,58,51,56,49,234,57,63,62,247,57,48,247,44,57,63,56,46,61,234,45,50,47,61,62,234,43,62,234,239,61,234,242,57,63,62,61,51,46,47,234,30,57,65,56,234,57,48,234,12,47,49,51,56,56,51,56,49,61,243},54), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,29,53,51,58,58,51,56,49,234,47,54,47,64,43,62,47,46,234,45,50,47,61,62,234,43,62,234,239,61,234,242,35,7,239,248,250,48,234,8,234,54,51,55,51,62,234,239,248,250,48,243},54),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,248,248,248,234,43,56,46,234,239,46,234,55,57,60,47,234,45,50,47,61,62,61,234,61,53,51,58,58,47,46,234,242,57,63,62,61,51,46,47,234,30,57,65,56,234,57,48,234,12,47,49,51,56,56,51,56,49,61,243,248},54), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({37,25,58,47,56,13,50,47,61,62,61,39,234,239,46,234,45,50,47,61,62,61,234,59,63,47,63,47,46,234,242,56,47,43,60,47,61,62,247,48,51,60,61,62,243,234,70,234,239,46,234,57,63,62,61,51,46,47,234,51,61,54,43,56,46,234,70,234,239,46,234,62,57,57,234,50,51,49,50,248},54),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,24,57,234,60,47,43,45,50,43,44,54,47,234,45,50,47,61,62,61,234,43,48,62,47,60,234,48,51,54,62,47,60,51,56,49,248,234,11,60,47,234,67,57,63,234,43,62,234,30,57,65,56,234,57,48,234,12,47,49,51,56,56,51,56,49,61,9},54))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({54,51,44,249,47,43,61,67,41,62,60,43,64,47,54,248,54,63,43},54))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,234,47,43,61,67,41,62,60,43,64,47,54,248,54,63,43,234,172,74,94,234,45,50,47,45,53,234,65,57,60,53,61,58,43,45,47,234,48,51,54,47,235},54))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,47,43,61,67,41,62,60,43,64,47,54,234,11,26,19,234,56,57,62,234,60,47,62,63,60,56,47,46,234,45,57,60,60,47,45,62,54,67,248},54))
end
task.wait(0.2)
ET.Start()
print(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,15,43,61,67,234,30,60,43,64,47,54,234,61,62,43,60,62,47,46,234,51,56,234,50,47,54,58,47,60,234,55,57,46,47,248},54))
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
print(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,29,62,57,58,58,47,46,4,234},54) .. (reason or _d({46,57,56,47},54)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,26,234,58,60,47,61,61,47,46,234,172,74,94,234,43,44,57,60,62,51,56,49,235},54))
cleanup(_d({26,234,53,47,67,234,43,44,57,60,62},54))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,37,239,46,249,239,46,39,234,30,60,43,64,47,54,54,51,56,49,234,62,57,234,45,50,47,61,62,234,43,62,234,239,61},54), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
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
if dist <= ARRIVE_DIST then
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,11,60,60,51,64,47,46,235,234,242,46,51,61,62,7,239,248,251,48,243},54), dist))
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
print(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,25,58,47,56,47,46,234,45,50,47,61,62,234,239,46,235},54), i))
else
warn(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,48,51,60,47,58,60,57,66,51,55,51,62,67,58,60,57,55,58,62,234,48,43,51,54,47,46,4,234,239,61},54), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,13,50,47,61,62,234,239,46,234,58,60,57,55,58,62,234,56,57,234,54,57,56,49,47,60,234,47,66,51,61,62,61,234,242,55,43,67,234,50,43,64,47,234,46,47,61,58,43,65,56,47,46,243,248},54), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({37,25,58,47,56,13,50,47,61,62,61,39,234,11,54,54,234,45,50,47,61,62,61,234,58,60,57,45,47,61,61,47,46,235},54))
cleanup(_d({43,54,54,234,46,57,56,47},54))
end
end)()