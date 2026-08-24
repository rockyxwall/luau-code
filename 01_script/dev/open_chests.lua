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
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,47,90,96,83,79,82,103,14,96,99,92,92,87,92,85,15,14,47,80,93,96,98,87,92,85,14,82,99,94,90,87,81,79,98,83,14,90,79,99,92,81,86,28},18))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({62,90,79,103,83,96,97},18))
local RunService       = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
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
if v:IsA(_d({62,96,93,102,87,91,87,98,103,62,96,93,91,94,98},18)) then
local action = v.ActionText
if action:find(_d({62,83,90,87,14,49,86,83,97,98},18)) then
local part = v.Parent
if part and part:IsA(_d({48,79,97,83,62,79,96,98},18)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({22,19,28,30,84,26,14,19,28,30,84,26,14,19,28,30,84,23},18), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
local function Core.GetRoot(LocalPlayer)
local char = LocalPlayer.Character
if not char then return nil end
return char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end
local function waitForRoot(timeout)
local t = 0
while t < timeout do
local r = Core.GetRoot(LocalPlayer)
if r then return r end
task.wait(0.1)
t = t + 0.1
end
return nil
end
local chests = collectChests()
print(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,52,93,99,92,82,14,19,82,14,62,83,90,87,14,49,86,83,97,98,97,28},18), #chests))
if #chests == 0 then
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,60,93,14,81,86,83,97,98,97,14,84,93,99,92,82,14,208,110,130,14,79,96,83,14,103,93,99,14,87,92,14,98,86,83,14,96,87,85,86,98,14,79,96,83,79,45},18))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,49,93,99,90,82,14,92,93,98,14,84,87,92,82,14,81,86,79,96,79,81,98,83,96,14,96,93,93,98,15,14,47,80,93,96,98,87,92,85,28},18))
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
print(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,65,89,87,94,94,87,92,85,14,83,90,83,100,79,98,83,82,14,81,86,83,97,98,14,79,98,14,19,97,14,22,71,43,19,28,30,84,14,44,14,90,87,91,87,98,14,19,28,30,84,23},18),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,19,82,14,81,86,83,97,98,97,14,95,99,83,99,83,82,14,22,92,83,79,96,83,97,98,27,84,87,96,97,98,26,14,79,84,98,83,96,14,71,14,84,87,90,98,83,96,23,28},18), #chests))
if #chests == 0 then
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,60,93,14,96,83,79,81,86,79,80,90,83,14,81,86,83,97,98,97,14,79,84,98,83,96,14,84,87,90,98,83,96,87,92,85,28},18))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({90,87,80,29,83,79,97,103,77,98,96,79,100,83,90,28,90,99,79},18))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,52,79,87,90,83,82,14,98,93,14,90,93,79,82,14,83,79,97,103,77,98,96,79,100,83,90,28,90,99,79,14,208,110,130,14,81,86,83,81,89,14,101,93,96,89,97,94,79,81,83,14,84,87,90,83,15},18))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,83,79,97,103,77,98,96,79,100,83,90,14,47,62,55,14,92,93,98,14,96,83,98,99,96,92,83,82,14,81,93,96,96,83,81,98,90,103,28},18))
end
task.wait(0.2)
ET.Start()
print(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,51,79,97,103,14,66,96,79,100,83,90,14,97,98,79,96,98,83,82,14,87,92,14,86,83,90,94,83,96,14,91,93,82,83,28},18))
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
print(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,65,98,93,94,94,83,82,40,14},18) .. (reason or _d({82,93,92,83},18)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,62,14,94,96,83,97,97,83,82,14,208,110,130,14,79,80,93,96,98,87,92,85,15},18))
cleanup(_d({62,14,89,83,103,14,79,80,93,96,98},18))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,73,19,82,29,19,82,75,14,66,96,79,100,83,90,90,87,92,85,14,98,93,14,81,86,83,97,98,14,79,98,14,19,97},18), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,58,93,97,98,14,81,86,79,96,79,81,98,83,96,14,208,110,130,14,94,79,99,97,87,92,85,28},18))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,47,96,96,87,100,83,82,15,14,22,82,87,97,98,43,19,28,31,84,23},18), dist))
break
end
end
if not running then break end
local currentRoot = Core.GetRoot(LocalPlayer)
if currentRoot then
ET.TargetPosition = currentRoot.Position
end
if chest.prompt and chest.prompt.Parent then
local ok, err = pcall(function()
fireproximityprompt(chest.prompt)
end)
if ok then
print(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,61,94,83,92,83,82,14,81,86,83,97,98,14,19,82,15},18), i))
else
warn(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,84,87,96,83,94,96,93,102,87,91,87,98,103,94,96,93,91,94,98,14,84,79,87,90,83,82,40,14,19,97},18), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,49,86,83,97,98,14,19,82,14,94,96,93,91,94,98,14,92,93,14,90,93,92,85,83,96,14,83,102,87,97,98,97,14,22,91,79,103,14,86,79,100,83,14,82,83,97,94,79,101,92,83,82,23,28},18), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,47,90,90,14,81,86,83,97,98,97,14,94,96,93,81,83,97,97,83,82,15},18))
cleanup(_d({79,90,90,14,82,93,92,83},18))
end
end)()