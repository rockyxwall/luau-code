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
warn(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,48,91,97,84,80,83,104,15,97,100,93,93,88,93,86,16,15,48,81,94,97,99,88,93,86,15,83,100,95,91,88,82,80,99,84,15,91,80,100,93,82,87,29},17))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({63,91,80,104,84,97,98},17))
local RunService       = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17))
local UserInputService = game:GetService(_d({68,98,84,97,56,93,95,100,99,66,84,97,101,88,82,84},17))
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
if v:IsA(_d({63,97,94,103,88,92,88,99,104,63,97,94,92,95,99},17)) then
local action = v.ActionText
if action:find(_d({63,84,91,88,15,50,87,84,98,99},17)) then
local part = v.Parent
if part and part:IsA(_d({49,80,98,84,63,80,97,99},17)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({23,20,29,31,85,27,15,20,29,31,85,27,15,20,29,31,85,24},17), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
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
print(string.format(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,53,94,100,93,83,15,20,83,15,63,84,91,88,15,50,87,84,98,99,98,29},17), #chests))
if #chests == 0 then
warn(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,61,94,15,82,87,84,98,99,98,15,85,94,100,93,83,15,209,111,131,15,80,97,84,15,104,94,100,15,88,93,15,99,87,84,15,97,88,86,87,99,15,80,97,84,80,46},17))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,50,94,100,91,83,15,93,94,99,15,85,88,93,83,15,82,87,80,97,80,82,99,84,97,15,97,94,94,99,16,15,48,81,94,97,99,88,93,86,29},17))
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
print(string.format(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,66,90,88,95,95,88,93,86,15,84,91,84,101,80,99,84,83,15,82,87,84,98,99,15,80,99,15,20,98,15,23,72,44,20,29,31,85,15,45,15,91,88,92,88,99,15,20,29,31,85,24},17),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,20,83,15,82,87,84,98,99,98,15,96,100,84,100,84,83,15,23,93,84,80,97,84,98,99,28,85,88,97,98,99,27,15,80,85,99,84,97,15,72,15,85,88,91,99,84,97,24,29},17), #chests))
if #chests == 0 then
warn(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,61,94,15,97,84,80,82,87,80,81,91,84,15,82,87,84,98,99,98,15,80,85,99,84,97,15,85,88,91,99,84,97,88,93,86,29},17))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({91,88,81,30,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80},17))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,53,80,88,91,84,83,15,99,94,15,91,94,80,83,15,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80,15,209,111,131,15,82,87,84,82,90,15,102,94,97,90,98,95,80,82,84,15,85,88,91,84,16},17))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,84,80,98,104,78,99,97,80,101,84,91,15,48,63,56,15,93,94,99,15,97,84,99,100,97,93,84,83,15,82,94,97,97,84,82,99,91,104,29},17))
end
task.wait(0.2)
ET.Start()
print(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,52,80,98,104,15,67,97,80,101,84,91,15,98,99,80,97,99,84,83,15,88,93,15,87,84,91,95,84,97,15,92,94,83,84,29},17))
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
print(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,66,99,94,95,95,84,83,41,15},17) .. (reason or _d({83,94,93,84},17)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,63,15,95,97,84,98,98,84,83,15,209,111,131,15,80,81,94,97,99,88,93,86,16},17))
cleanup(_d({63,15,90,84,104,15,80,81,94,97,99},17))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,74,20,83,30,20,83,76,15,67,97,80,101,84,91,91,88,93,86,15,99,94,15,82,87,84,98,99,15,80,99,15,20,98},17), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,59,94,98,99,15,82,87,80,97,80,82,99,84,97,15,209,111,131,15,95,80,100,98,88,93,86,29},17))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,48,97,97,88,101,84,83,16,15,23,83,88,98,99,44,20,29,32,85,24},17), dist))
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
print(string.format(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,62,95,84,93,84,83,15,82,87,84,98,99,15,20,83,16},17), i))
else
warn(string.format(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,85,88,97,84,95,97,94,103,88,92,88,99,104,95,97,94,92,95,99,15,85,80,88,91,84,83,41,15,20,98},17), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,50,87,84,98,99,15,20,83,15,95,97,94,92,95,99,15,93,94,15,91,94,93,86,84,97,15,84,103,88,98,99,98,15,23,92,80,104,15,87,80,101,84,15,83,84,98,95,80,102,93,84,83,24,29},17), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({74,62,95,84,93,50,87,84,98,99,98,76,15,48,91,91,15,82,87,84,98,99,98,15,95,97,94,82,84,98,98,84,83,16},17))
cleanup(_d({80,91,91,15,83,94,93,84},17))
end
end)()