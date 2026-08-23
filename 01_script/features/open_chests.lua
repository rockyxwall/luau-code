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
warn(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,31,74,80,67,63,66,87,254,80,83,76,76,71,76,69,255,254,31,64,77,80,82,71,76,69,254,66,83,78,74,71,65,63,82,67,254,74,63,83,76,65,70,12},34))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({46,74,63,87,67,80,81},34))
local RunService       = game:GetService(_d({48,83,76,49,67,80,84,71,65,67},34))
local UserInputService = game:GetService(_d({51,81,67,80,39,76,78,83,82,49,67,80,84,71,65,67},34))
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
if v:IsA(_d({46,80,77,86,71,75,71,82,87,46,80,77,75,78,82},34)) then
local action = v.ActionText
if action:find(_d({46,67,74,71,254,33,70,67,81,82},34)) then
local part = v.Parent
if part and part:IsA(_d({32,63,81,67,46,63,80,82},34)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({6,3,12,14,68,10,254,3,12,14,68,10,254,3,12,14,68,7},34), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
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
print(string.format(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,36,77,83,76,66,254,3,66,254,46,67,74,71,254,33,70,67,81,82,81,254,82,77,82,63,74,254,71,76,254,85,77,80,73,81,78,63,65,67,12},34), #allChests))
if #allChests == 0 then
warn(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,44,77,254,65,70,67,81,82,81,254,68,77,83,76,66,254,192,94,114,254,63,80,67,254,87,77,83,254,71,76,254,82,70,67,254,80,71,69,70,82,254,63,80,67,63,29},34))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,33,77,83,74,66,254,76,77,82,254,68,71,76,66,254,65,70,63,80,63,65,82,67,80,254,80,77,77,82,255,254,31,64,77,80,82,71,76,69,12},34))
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
print(string.format(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,49,73,71,78,78,71,76,69,254,77,83,82,11,77,68,11,64,77,83,76,66,81,254,65,70,67,81,82,254,63,82,254,3,81,254,6,77,83,82,81,71,66,67,254,50,77,85,76,254,77,68,254,32,67,69,71,76,76,71,76,69,81,7},34), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,49,73,71,78,78,71,76,69,254,67,74,67,84,63,82,67,66,254,65,70,67,81,82,254,63,82,254,3,81,254,6,55,27,3,12,14,68,254,28,254,74,71,75,71,82,254,3,12,14,68,7},34),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,12,12,12,254,63,76,66,254,3,66,254,75,77,80,67,254,65,70,67,81,82,81,254,81,73,71,78,78,67,66,254,6,77,83,82,81,71,66,67,254,50,77,85,76,254,77,68,254,32,67,69,71,76,76,71,76,69,81,7,12},34), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({57,45,78,67,76,33,70,67,81,82,81,59,254,3,66,254,65,70,67,81,82,81,254,79,83,67,83,67,66,254,6,76,67,63,80,67,81,82,11,68,71,80,81,82,7,254,90,254,3,66,254,77,83,82,81,71,66,67,254,71,81,74,63,76,66,254,90,254,3,66,254,82,77,77,254,70,71,69,70,12},34),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,44,77,254,80,67,63,65,70,63,64,74,67,254,65,70,67,81,82,81,254,63,68,82,67,80,254,68,71,74,82,67,80,71,76,69,12,254,31,80,67,254,87,77,83,254,63,82,254,50,77,85,76,254,77,68,254,32,67,69,71,76,76,71,76,69,81,29},34))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({74,71,64,13,67,63,81,87,61,82,80,63,84,67,74,12,74,83,63},34))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,254,67,63,81,87,61,82,80,63,84,67,74,12,74,83,63,254,192,94,114,254,65,70,67,65,73,254,85,77,80,73,81,78,63,65,67,254,68,71,74,67,255},34))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,67,63,81,87,61,82,80,63,84,67,74,254,31,46,39,254,76,77,82,254,80,67,82,83,80,76,67,66,254,65,77,80,80,67,65,82,74,87,12},34))
end
task.wait(0.2)
ET.Start()
print(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,35,63,81,87,254,50,80,63,84,67,74,254,81,82,63,80,82,67,66,254,71,76,254,70,67,74,78,67,80,254,75,77,66,67,12},34))
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
print(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,49,82,77,78,78,67,66,24,254},34) .. (reason or _d({66,77,76,67},34)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,46,254,78,80,67,81,81,67,66,254,192,94,114,254,63,64,77,80,82,71,76,69,255},34))
cleanup(_d({46,254,73,67,87,254,63,64,77,80,82},34))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,57,3,66,13,3,66,59,254,50,80,63,84,67,74,74,71,76,69,254,82,77,254,65,70,67,81,82,254,63,82,254,3,81},34), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,42,77,81,82,254,65,70,63,80,63,65,82,67,80,254,192,94,114,254,78,63,83,81,71,76,69,12},34))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,31,80,80,71,84,67,66,255,254,6,66,71,81,82,27,3,12,15,68,7},34), dist))
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
print(string.format(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,45,78,67,76,67,66,254,65,70,67,81,82,254,3,66,255},34), i))
else
warn(string.format(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,68,71,80,67,78,80,77,86,71,75,71,82,87,78,80,77,75,78,82,254,68,63,71,74,67,66,24,254,3,81},34), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,33,70,67,81,82,254,3,66,254,78,80,77,75,78,82,254,76,77,254,74,77,76,69,67,80,254,67,86,71,81,82,81,254,6,75,63,87,254,70,63,84,67,254,66,67,81,78,63,85,76,67,66,7,12},34), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({57,45,78,67,76,33,70,67,81,82,81,59,254,31,74,74,254,65,70,67,81,82,81,254,78,80,77,65,67,81,81,67,66,255},34))
cleanup(_d({63,74,74,254,66,77,76,67},34))
end
end)()