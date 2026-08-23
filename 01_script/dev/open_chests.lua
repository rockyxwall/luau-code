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
warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,41,84,90,77,73,76,97,8,90,93,86,86,81,86,79,9,8,41,74,87,90,92,81,86,79,8,76,93,88,84,81,75,73,92,77,8,84,73,93,86,75,80,22},24))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({56,84,73,97,77,90,91},24))
local RunService       = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
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
if v:IsA(_d({56,90,87,96,81,85,81,92,97,56,90,87,85,88,92},24)) then
local action = v.ActionText
if action:find(_d({56,77,84,81,8,43,80,77,91,92},24)) then
local part = v.Parent
if part and part:IsA(_d({42,73,91,77,56,73,90,92},24)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({16,13,22,24,78,20,8,13,22,24,78,20,8,13,22,24,78,17},24), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
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
print(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,46,87,93,86,76,8,13,76,8,56,77,84,81,8,43,80,77,91,92,91,22},24), #chests))
if #chests == 0 then
warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,54,87,8,75,80,77,91,92,91,8,78,87,93,86,76,8,202,104,124,8,73,90,77,8,97,87,93,8,81,86,8,92,80,77,8,90,81,79,80,92,8,73,90,77,73,39},24))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,43,87,93,84,76,8,86,87,92,8,78,81,86,76,8,75,80,73,90,73,75,92,77,90,8,90,87,87,92,9,8,41,74,87,90,92,81,86,79,22},24))
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
print(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,59,83,81,88,88,81,86,79,8,77,84,77,94,73,92,77,76,8,75,80,77,91,92,8,73,92,8,13,91,8,16,65,37,13,22,24,78,8,38,8,84,81,85,81,92,8,13,22,24,78,17},24),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,13,76,8,75,80,77,91,92,91,8,89,93,77,93,77,76,8,16,86,77,73,90,77,91,92,21,78,81,90,91,92,20,8,73,78,92,77,90,8,65,8,78,81,84,92,77,90,17,22},24), #chests))
if #chests == 0 then
warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,54,87,8,90,77,73,75,80,73,74,84,77,8,75,80,77,91,92,91,8,73,78,92,77,90,8,78,81,84,92,77,90,81,86,79,22},24))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73,8,202,104,124,8,75,80,77,75,83,8,95,87,90,83,91,88,73,75,77,8,78,81,84,77,9},24))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,77,73,91,97,71,92,90,73,94,77,84,8,41,56,49,8,86,87,92,8,90,77,92,93,90,86,77,76,8,75,87,90,90,77,75,92,84,97,22},24))
end
task.wait(0.2)
ET.Start()
print(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,45,73,91,97,8,60,90,73,94,77,84,8,91,92,73,90,92,77,76,8,81,86,8,80,77,84,88,77,90,8,85,87,76,77,22},24))
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
print(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,59,92,87,88,88,77,76,34,8},24) .. (reason or _d({76,87,86,77},24)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,56,8,88,90,77,91,91,77,76,8,202,104,124,8,73,74,87,90,92,81,86,79,9},24))
cleanup(_d({56,8,83,77,97,8,73,74,87,90,92},24))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,67,13,76,23,13,76,69,8,60,90,73,94,77,84,84,81,86,79,8,92,87,8,75,80,77,91,92,8,73,92,8,13,91},24), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,52,87,91,92,8,75,80,73,90,73,75,92,77,90,8,202,104,124,8,88,73,93,91,81,86,79,22},24))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,41,90,90,81,94,77,76,9,8,16,76,81,91,92,37,13,22,25,78,17},24), dist))
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
print(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,55,88,77,86,77,76,8,75,80,77,91,92,8,13,76,9},24), i))
else
warn(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,78,81,90,77,88,90,87,96,81,85,81,92,97,88,90,87,85,88,92,8,78,73,81,84,77,76,34,8,13,91},24), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,43,80,77,91,92,8,13,76,8,88,90,87,85,88,92,8,86,87,8,84,87,86,79,77,90,8,77,96,81,91,92,91,8,16,85,73,97,8,80,73,94,77,8,76,77,91,88,73,95,86,77,76,17,22},24), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({67,55,88,77,86,43,80,77,91,92,91,69,8,41,84,84,8,75,80,77,91,92,91,8,88,90,87,75,77,91,91,77,76,9},24))
cleanup(_d({73,84,84,8,76,87,86,77},24))
end
end)()