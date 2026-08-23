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
warn(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,45,88,94,81,77,80,101,12,94,97,90,90,85,90,83,13,12,45,78,91,94,96,85,90,83,12,80,97,92,88,85,79,77,96,81,12,88,77,97,90,79,84,26},20))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({60,88,77,101,81,94,95},20))
local RunService       = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local UserInputService = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
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
if v:IsA(_d({60,94,91,100,85,89,85,96,101,60,94,91,89,92,96},20)) then
local action = v.ActionText
if action:find(_d({60,81,88,85,12,47,84,81,95,96},20)) then
local part = v.Parent
if part and part:IsA(_d({46,77,95,81,60,77,94,96},20)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({20,17,26,28,82,24,12,17,26,28,82,24,12,17,26,28,82,21},20), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
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
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,50,91,97,90,80,12,17,80,12,60,81,88,85,12,47,84,81,95,96,95,12,96,91,96,77,88,12,85,90,12,99,91,94,87,95,92,77,79,81,26},20), #allChests))
if #allChests == 0 then
warn(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,58,91,12,79,84,81,95,96,95,12,82,91,97,90,80,12,206,108,128,12,77,94,81,12,101,91,97,12,85,90,12,96,84,81,12,94,85,83,84,96,12,77,94,81,77,43},20))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,47,91,97,88,80,12,90,91,96,12,82,85,90,80,12,79,84,77,94,77,79,96,81,94,12,94,91,91,96,13,12,45,78,91,94,96,85,90,83,26},20))
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
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,63,87,85,92,92,85,90,83,12,91,97,96,25,91,82,25,78,91,97,90,80,95,12,79,84,81,95,96,12,77,96,12,17,95,12,20,91,97,96,95,85,80,81,12,64,91,99,90,12,91,82,12,46,81,83,85,90,90,85,90,83,95,21},20), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,63,87,85,92,92,85,90,83,12,81,88,81,98,77,96,81,80,12,79,84,81,95,96,12,77,96,12,17,95,12,20,69,41,17,26,28,82,12,42,12,88,85,89,85,96,12,17,26,28,82,21},20),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,26,26,26,12,77,90,80,12,17,80,12,89,91,94,81,12,79,84,81,95,96,95,12,95,87,85,92,92,81,80,12,20,91,97,96,95,85,80,81,12,64,91,99,90,12,91,82,12,46,81,83,85,90,90,85,90,83,95,21,26},20), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({71,59,92,81,90,47,84,81,95,96,95,73,12,17,80,12,79,84,81,95,96,95,12,93,97,81,97,81,80,12,20,90,81,77,94,81,95,96,25,82,85,94,95,96,21,12,104,12,17,80,12,91,97,96,95,85,80,81,12,85,95,88,77,90,80,12,104,12,17,80,12,96,91,91,12,84,85,83,84,26},20),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,58,91,12,94,81,77,79,84,77,78,88,81,12,79,84,81,95,96,95,12,77,82,96,81,94,12,82,85,88,96,81,94,85,90,83,26,12,45,94,81,12,101,91,97,12,77,96,12,64,91,99,90,12,91,82,12,46,81,83,85,90,90,85,90,83,95,43},20))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({88,85,78,27,81,77,95,101,75,96,94,77,98,81,88,26,88,97,77},20))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,50,77,85,88,81,80,12,96,91,12,88,91,77,80,12,81,77,95,101,75,96,94,77,98,81,88,26,88,97,77,12,206,108,128,12,79,84,81,79,87,12,99,91,94,87,95,92,77,79,81,12,82,85,88,81,13},20))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,81,77,95,101,75,96,94,77,98,81,88,12,45,60,53,12,90,91,96,12,94,81,96,97,94,90,81,80,12,79,91,94,94,81,79,96,88,101,26},20))
end
task.wait(0.2)
ET.Start()
print(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,49,77,95,101,12,64,94,77,98,81,88,12,95,96,77,94,96,81,80,12,85,90,12,84,81,88,92,81,94,12,89,91,80,81,26},20))
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
print(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,63,96,91,92,92,81,80,38,12},20) .. (reason or _d({80,91,90,81},20)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,60,12,92,94,81,95,95,81,80,12,206,108,128,12,77,78,91,94,96,85,90,83,13},20))
cleanup(_d({60,12,87,81,101,12,77,78,91,94,96},20))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,71,17,80,27,17,80,73,12,64,94,77,98,81,88,88,85,90,83,12,96,91,12,79,84,81,95,96,12,77,96,12,17,95},20), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
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
if dist <= ARRIVE_DIST then
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,45,94,94,85,98,81,80,13,12,20,80,85,95,96,41,17,26,29,82,21},20), dist))
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
print(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,59,92,81,90,81,80,12,79,84,81,95,96,12,17,80,13},20), i))
else
warn(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,82,85,94,81,92,94,91,100,85,89,85,96,101,92,94,91,89,92,96,12,82,77,85,88,81,80,38,12,17,95},20), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,47,84,81,95,96,12,17,80,12,92,94,91,89,92,96,12,90,91,12,88,91,90,83,81,94,12,81,100,85,95,96,95,12,20,89,77,101,12,84,77,98,81,12,80,81,95,92,77,99,90,81,80,21,26},20), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({71,59,92,81,90,47,84,81,95,96,95,73,12,45,88,88,12,79,84,81,95,96,95,12,92,94,91,79,81,95,95,81,80,13},20))
cleanup(_d({77,88,88,12,80,91,90,81},20))
end
end)()