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
warn(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,33,76,82,69,65,68,89,0,82,85,78,78,73,78,71,1,0,33,66,79,82,84,73,78,71,0,68,85,80,76,73,67,65,84,69,0,76,65,85,78,67,72,14},32))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({48,76,65,89,69,82,83},32))
local RunService       = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local LocalPlayer      = Players.LocalPlayer
local running = true
local ARRIVE_DIST     = 6
local TIMEOUT_PER_CHEST = 20
local OPEN_WAIT       = 2.5
local TRAVEL_HEIGHT   = 4
local CHECK_HZ        = 0.1
local function collectChests()
local chests = {}
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA(_d({48,82,79,88,73,77,73,84,89,48,82,79,77,80,84},32)) then
local action = v.ActionText
if action:find(_d({48,69,76,73,0,35,72,69,83,84},32)) then
local part = v.Parent
if part and part:IsA(_d({34,65,83,69,48,65,82,84},32)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({8,5,14,16,70,12,0,5,14,16,70,12,0,5,14,16,70,9},32), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
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
local chests = collectChests()
print(string.format(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,38,79,85,78,68,0,5,68,0,48,69,76,73,0,35,72,69,83,84,83,14},32), #chests))
if #chests == 0 then
warn(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,46,79,0,67,72,69,83,84,83,0,70,79,85,78,68,0,194,96,116,0,65,82,69,0,89,79,85,0,73,78,0,84,72,69,0,82,73,71,72,84,0,65,82,69,65,31},32))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,35,79,85,76,68,0,78,79,84,0,70,73,78,68,0,67,72,65,82,65,67,84,69,82,0,82,79,79,84,1,0,33,66,79,82,84,73,78,71,14},32))
_G.OpenChestsRunning = false
return
end
local playerStartPos = startRoot.Position
local playerStartY   = playerStartPos.Y
local filtered = {}
for _, c in ipairs(chests) do
if c.position.Y <= playerStartY + 20 then
table.insert(filtered, c)
else
print(string.format(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,51,75,73,80,80,73,78,71,0,69,76,69,86,65,84,69,68,0,67,72,69,83,84,0,65,84,0,5,83,0,8,57,29,5,14,16,70,0,30,0,76,73,77,73,84,0,5,14,16,70,9},32),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,5,68,0,67,72,69,83,84,83,0,81,85,69,85,69,68,0,8,78,69,65,82,69,83,84,13,70,73,82,83,84,12,0,65,70,84,69,82,0,57,0,70,73,76,84,69,82,9,14},32), #chests))
if #chests == 0 then
warn(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,46,79,0,82,69,65,67,72,65,66,76,69,0,67,72,69,83,84,83,0,65,70,84,69,82,0,70,73,76,84,69,82,73,78,71,14},32))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({76,73,66,15,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65},32))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,0,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65,0,194,96,116,0,67,72,69,67,75,0,87,79,82,75,83,80,65,67,69,0,70,73,76,69,1},32))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,69,65,83,89,63,84,82,65,86,69,76,0,33,48,41,0,78,79,84,0,82,69,84,85,82,78,69,68,0,67,79,82,82,69,67,84,76,89,14},32))
end
task.wait(0.2)
ET.Start()
print(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,37,65,83,89,0,52,82,65,86,69,76,0,83,84,65,82,84,69,68,0,73,78,0,72,69,76,80,69,82,0,77,79,68,69,14},32))
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
print(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,51,84,79,80,80,69,68,26,0},32) .. (reason or _d({68,79,78,69},32)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,48,0,80,82,69,83,83,69,68,0,194,96,116,0,65,66,79,82,84,73,78,71,1},32))
cleanup(_d({48,0,75,69,89,0,65,66,79,82,84},32))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,59,5,68,15,5,68,61,0,52,82,65,86,69,76,76,73,78,71,0,84,79,0,67,72,69,83,84,0,65,84,0,5,83},32), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,44,79,83,84,0,67,72,65,82,65,67,84,69,82,0,194,96,116,0,80,65,85,83,73,78,71,14},32))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,33,82,82,73,86,69,68,1,0,8,68,73,83,84,29,5,14,17,70,9},32), dist))
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
print(string.format(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,47,80,69,78,69,68,0,67,72,69,83,84,0,5,68,1},32), i))
else
warn(string.format(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,70,73,82,69,80,82,79,88,73,77,73,84,89,80,82,79,77,80,84,0,70,65,73,76,69,68,26,0,5,83},32), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,35,72,69,83,84,0,5,68,0,80,82,79,77,80,84,0,78,79,0,76,79,78,71,69,82,0,69,88,73,83,84,83,0,8,77,65,89,0,72,65,86,69,0,68,69,83,80,65,87,78,69,68,9,14},32), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({59,47,80,69,78,35,72,69,83,84,83,61,0,33,76,76,0,67,72,69,83,84,83,0,80,82,79,67,69,83,83,69,68,1},32))
cleanup(_d({65,76,76,0,68,79,78,69},32))
end
end)()