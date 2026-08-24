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
warn(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,38,81,87,74,70,73,94,5,87,90,83,83,78,83,76,6,5,38,71,84,87,89,78,83,76,5,73,90,85,81,78,72,70,89,74,5,81,70,90,83,72,77,19},27))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({53,81,70,94,74,87,88},27))
local RunService       = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
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
if v:IsA(_d({53,87,84,93,78,82,78,89,94,53,87,84,82,85,89},27)) then
local action = v.ActionText
if action:find(_d({53,74,81,78,5,40,77,74,88,89},27)) then
local part = v.Parent
if part and part:IsA(_d({39,70,88,74,53,70,87,89},27)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({13,10,19,21,75,17,5,10,19,21,75,17,5,10,19,21,75,14},27), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
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
print(string.format(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,43,84,90,83,73,5,10,73,5,53,74,81,78,5,40,77,74,88,89,88,19},27), #chests))
if #chests == 0 then
warn(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,51,84,5,72,77,74,88,89,88,5,75,84,90,83,73,5,199,101,121,5,70,87,74,5,94,84,90,5,78,83,5,89,77,74,5,87,78,76,77,89,5,70,87,74,70,36},27))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,40,84,90,81,73,5,83,84,89,5,75,78,83,73,5,72,77,70,87,70,72,89,74,87,5,87,84,84,89,6,5,38,71,84,87,89,78,83,76,19},27))
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
print(string.format(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,56,80,78,85,85,78,83,76,5,74,81,74,91,70,89,74,73,5,72,77,74,88,89,5,70,89,5,10,88,5,13,62,34,10,19,21,75,5,35,5,81,78,82,78,89,5,10,19,21,75,14},27),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,10,73,5,72,77,74,88,89,88,5,86,90,74,90,74,73,5,13,83,74,70,87,74,88,89,18,75,78,87,88,89,17,5,70,75,89,74,87,5,62,5,75,78,81,89,74,87,14,19},27), #chests))
if #chests == 0 then
warn(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,51,84,5,87,74,70,72,77,70,71,81,74,5,72,77,74,88,89,88,5,70,75,89,74,87,5,75,78,81,89,74,87,78,83,76,19},27))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({81,78,71,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,5,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70,5,199,101,121,5,72,77,74,72,80,5,92,84,87,80,88,85,70,72,74,5,75,78,81,74,6},27))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,74,70,88,94,68,89,87,70,91,74,81,5,38,53,46,5,83,84,89,5,87,74,89,90,87,83,74,73,5,72,84,87,87,74,72,89,81,94,19},27))
end
task.wait(0.2)
ET.Start()
print(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,42,70,88,94,5,57,87,70,91,74,81,5,88,89,70,87,89,74,73,5,78,83,5,77,74,81,85,74,87,5,82,84,73,74,19},27))
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
print(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,56,89,84,85,85,74,73,31,5},27) .. (reason or _d({73,84,83,74},27)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,53,5,85,87,74,88,88,74,73,5,199,101,121,5,70,71,84,87,89,78,83,76,6},27))
cleanup(_d({53,5,80,74,94,5,70,71,84,87,89},27))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,64,10,73,20,10,73,66,5,57,87,70,91,74,81,81,78,83,76,5,89,84,5,72,77,74,88,89,5,70,89,5,10,88},27), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,49,84,88,89,5,72,77,70,87,70,72,89,74,87,5,199,101,121,5,85,70,90,88,78,83,76,19},27))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,38,87,87,78,91,74,73,6,5,13,73,78,88,89,34,10,19,22,75,14},27), dist))
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
print(string.format(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,52,85,74,83,74,73,5,72,77,74,88,89,5,10,73,6},27), i))
else
warn(string.format(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,75,78,87,74,85,87,84,93,78,82,78,89,94,85,87,84,82,85,89,5,75,70,78,81,74,73,31,5,10,88},27), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,40,77,74,88,89,5,10,73,5,85,87,84,82,85,89,5,83,84,5,81,84,83,76,74,87,5,74,93,78,88,89,88,5,13,82,70,94,5,77,70,91,74,5,73,74,88,85,70,92,83,74,73,14,19},27), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({64,52,85,74,83,40,77,74,88,89,88,66,5,38,81,81,5,72,77,74,88,89,88,5,85,87,84,72,74,88,88,74,73,6},27))
cleanup(_d({70,81,81,5,73,84,83,74},27))
end
end)()