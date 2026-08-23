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
warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,39,82,88,75,71,74,95,6,88,91,84,84,79,84,77,7,6,39,72,85,88,90,79,84,77,6,74,91,86,82,79,73,71,90,75,6,82,71,91,84,73,78,20},26))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({54,82,71,95,75,88,89},26))
local RunService       = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
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
if v:IsA(_d({54,88,85,94,79,83,79,90,95,54,88,85,83,86,90},26)) then
local action = v.ActionText
if action:find(_d({54,75,82,79,6,41,78,75,89,90},26)) then
local part = v.Parent
if part and part:IsA(_d({40,71,89,75,54,71,88,90},26)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({14,11,20,22,76,18,6,11,20,22,76,18,6,11,20,22,76,15},26), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
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
print(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,44,85,91,84,74,6,11,74,6,54,75,82,79,6,41,78,75,89,90,89,20},26), #chests))
if #chests == 0 then
warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,52,85,6,73,78,75,89,90,89,6,76,85,91,84,74,6,200,102,122,6,71,88,75,6,95,85,91,6,79,84,6,90,78,75,6,88,79,77,78,90,6,71,88,75,71,37},26))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,41,85,91,82,74,6,84,85,90,6,76,79,84,74,6,73,78,71,88,71,73,90,75,88,6,88,85,85,90,7,6,39,72,85,88,90,79,84,77,20},26))
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
print(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,57,81,79,86,86,79,84,77,6,75,82,75,92,71,90,75,74,6,73,78,75,89,90,6,71,90,6,11,89,6,14,63,35,11,20,22,76,6,36,6,82,79,83,79,90,6,11,20,22,76,15},26),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,11,74,6,73,78,75,89,90,89,6,87,91,75,91,75,74,6,14,84,75,71,88,75,89,90,19,76,79,88,89,90,18,6,71,76,90,75,88,6,63,6,76,79,82,90,75,88,15,20},26), #chests))
if #chests == 0 then
warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,52,85,6,88,75,71,73,78,71,72,82,75,6,73,78,75,89,90,89,6,71,76,90,75,88,6,76,79,82,90,75,88,79,84,77,20},26))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({82,79,72,21,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71},26))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,6,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71,6,200,102,122,6,73,78,75,73,81,6,93,85,88,81,89,86,71,73,75,6,76,79,82,75,7},26))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,75,71,89,95,69,90,88,71,92,75,82,6,39,54,47,6,84,85,90,6,88,75,90,91,88,84,75,74,6,73,85,88,88,75,73,90,82,95,20},26))
end
task.wait(0.2)
ET.Start()
print(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,43,71,89,95,6,58,88,71,92,75,82,6,89,90,71,88,90,75,74,6,79,84,6,78,75,82,86,75,88,6,83,85,74,75,20},26))
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
print(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,57,90,85,86,86,75,74,32,6},26) .. (reason or _d({74,85,84,75},26)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,54,6,86,88,75,89,89,75,74,6,200,102,122,6,71,72,85,88,90,79,84,77,7},26))
cleanup(_d({54,6,81,75,95,6,71,72,85,88,90},26))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,65,11,74,21,11,74,67,6,58,88,71,92,75,82,82,79,84,77,6,90,85,6,73,78,75,89,90,6,71,90,6,11,89},26), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,50,85,89,90,6,73,78,71,88,71,73,90,75,88,6,200,102,122,6,86,71,91,89,79,84,77,20},26))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,39,88,88,79,92,75,74,7,6,14,74,79,89,90,35,11,20,23,76,15},26), dist))
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
print(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,53,86,75,84,75,74,6,73,78,75,89,90,6,11,74,7},26), i))
else
warn(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,76,79,88,75,86,88,85,94,79,83,79,90,95,86,88,85,83,86,90,6,76,71,79,82,75,74,32,6,11,89},26), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,41,78,75,89,90,6,11,74,6,86,88,85,83,86,90,6,84,85,6,82,85,84,77,75,88,6,75,94,79,89,90,89,6,14,83,71,95,6,78,71,92,75,6,74,75,89,86,71,93,84,75,74,15,20},26), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({65,53,86,75,84,41,78,75,89,90,89,67,6,39,82,82,6,73,78,75,89,90,89,6,86,88,85,73,75,89,89,75,74,7},26))
cleanup(_d({71,82,82,6,74,85,84,75},26))
end
end)()