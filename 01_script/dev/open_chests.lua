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
warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,44,87,93,80,76,79,100,11,93,96,89,89,84,89,82,12,11,44,77,90,93,95,84,89,82,11,79,96,91,87,84,78,76,95,80,11,87,76,96,89,78,83,25},21))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({59,87,76,100,80,93,94},21))
local RunService       = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
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
if v:IsA(_d({59,93,90,99,84,88,84,95,100,59,93,90,88,91,95},21)) then
local action = v.ActionText
if action:find(_d({59,80,87,84,11,46,83,80,94,95},21)) then
local part = v.Parent
if part and part:IsA(_d({45,76,94,80,59,76,93,95},21)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({19,16,25,27,81,23,11,16,25,27,81,23,11,16,25,27,81,20},21), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
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
print(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,49,90,96,89,79,11,16,79,11,59,80,87,84,11,46,83,80,94,95,94,25},21), #chests))
if #chests == 0 then
warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,57,90,11,78,83,80,94,95,94,11,81,90,96,89,79,11,205,107,127,11,76,93,80,11,100,90,96,11,84,89,11,95,83,80,11,93,84,82,83,95,11,76,93,80,76,42},21))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,46,90,96,87,79,11,89,90,95,11,81,84,89,79,11,78,83,76,93,76,78,95,80,93,11,93,90,90,95,12,11,44,77,90,93,95,84,89,82,25},21))
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
print(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,62,86,84,91,91,84,89,82,11,80,87,80,97,76,95,80,79,11,78,83,80,94,95,11,76,95,11,16,94,11,19,68,40,16,25,27,81,11,41,11,87,84,88,84,95,11,16,25,27,81,20},21),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,16,79,11,78,83,80,94,95,94,11,92,96,80,96,80,79,11,19,89,80,76,93,80,94,95,24,81,84,93,94,95,23,11,76,81,95,80,93,11,68,11,81,84,87,95,80,93,20,25},21), #chests))
if #chests == 0 then
warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,57,90,11,93,80,76,78,83,76,77,87,80,11,78,83,80,94,95,94,11,76,81,95,80,93,11,81,84,87,95,80,93,84,89,82,25},21))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({87,84,77,26,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,11,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76,11,205,107,127,11,78,83,80,78,86,11,98,90,93,86,94,91,76,78,80,11,81,84,87,80,12},21))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,80,76,94,100,74,95,93,76,97,80,87,11,44,59,52,11,89,90,95,11,93,80,95,96,93,89,80,79,11,78,90,93,93,80,78,95,87,100,25},21))
end
task.wait(0.2)
ET.Start()
print(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,48,76,94,100,11,63,93,76,97,80,87,11,94,95,76,93,95,80,79,11,84,89,11,83,80,87,91,80,93,11,88,90,79,80,25},21))
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
print(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,62,95,90,91,91,80,79,37,11},21) .. (reason or _d({79,90,89,80},21)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,59,11,91,93,80,94,94,80,79,11,205,107,127,11,76,77,90,93,95,84,89,82,12},21))
cleanup(_d({59,11,86,80,100,11,76,77,90,93,95},21))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,70,16,79,26,16,79,72,11,63,93,76,97,80,87,87,84,89,82,11,95,90,11,78,83,80,94,95,11,76,95,11,16,94},21), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,55,90,94,95,11,78,83,76,93,76,78,95,80,93,11,205,107,127,11,91,76,96,94,84,89,82,25},21))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,44,93,93,84,97,80,79,12,11,19,79,84,94,95,40,16,25,28,81,20},21), dist))
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
print(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,58,91,80,89,80,79,11,78,83,80,94,95,11,16,79,12},21), i))
else
warn(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,81,84,93,80,91,93,90,99,84,88,84,95,100,91,93,90,88,91,95,11,81,76,84,87,80,79,37,11,16,94},21), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,46,83,80,94,95,11,16,79,11,91,93,90,88,91,95,11,89,90,11,87,90,89,82,80,93,11,80,99,84,94,95,94,11,19,88,76,100,11,83,76,97,80,11,79,80,94,91,76,98,89,80,79,20,25},21), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({70,58,91,80,89,46,83,80,94,95,94,72,11,44,87,87,11,78,83,80,94,95,94,11,91,93,90,78,80,94,94,80,79,12},21))
cleanup(_d({76,87,87,11,79,90,89,80},21))
end
end)()