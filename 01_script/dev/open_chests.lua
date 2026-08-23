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
warn(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,30,73,79,66,62,65,86,253,79,82,75,75,70,75,68,254,253,30,63,76,79,81,70,75,68,253,65,82,77,73,70,64,62,81,66,253,73,62,82,75,64,69,11},35))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({45,73,62,86,66,79,80},35))
local RunService       = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
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
if v:IsA(_d({45,79,76,85,70,74,70,81,86,45,79,76,74,77,81},35)) then
local action = v.ActionText
if action:find(_d({45,66,73,70,253,32,69,66,80,81},35)) then
local part = v.Parent
if part and part:IsA(_d({31,62,80,66,45,62,79,81},35)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({5,2,11,13,67,9,253,2,11,13,67,9,253,2,11,13,67,6},35), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
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
print(string.format(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,35,76,82,75,65,253,2,65,253,45,66,73,70,253,32,69,66,80,81,80,11},35), #chests))
if #chests == 0 then
warn(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,43,76,253,64,69,66,80,81,80,253,67,76,82,75,65,253,191,93,113,253,62,79,66,253,86,76,82,253,70,75,253,81,69,66,253,79,70,68,69,81,253,62,79,66,62,28},35))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,32,76,82,73,65,253,75,76,81,253,67,70,75,65,253,64,69,62,79,62,64,81,66,79,253,79,76,76,81,254,253,30,63,76,79,81,70,75,68,11},35))
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
print(string.format(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,48,72,70,77,77,70,75,68,253,66,73,66,83,62,81,66,65,253,64,69,66,80,81,253,62,81,253,2,80,253,5,54,26,2,11,13,67,253,27,253,73,70,74,70,81,253,2,11,13,67,6},35),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,2,65,253,64,69,66,80,81,80,253,78,82,66,82,66,65,253,5,75,66,62,79,66,80,81,10,67,70,79,80,81,9,253,62,67,81,66,79,253,54,253,67,70,73,81,66,79,6,11},35), #chests))
if #chests == 0 then
warn(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,43,76,253,79,66,62,64,69,62,63,73,66,253,64,69,66,80,81,80,253,62,67,81,66,79,253,67,70,73,81,66,79,70,75,68,11},35))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,253,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62,253,191,93,113,253,64,69,66,64,72,253,84,76,79,72,80,77,62,64,66,253,67,70,73,66,254},35))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,66,62,80,86,60,81,79,62,83,66,73,253,30,45,38,253,75,76,81,253,79,66,81,82,79,75,66,65,253,64,76,79,79,66,64,81,73,86,11},35))
end
task.wait(0.2)
ET.Start()
print(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,34,62,80,86,253,49,79,62,83,66,73,253,80,81,62,79,81,66,65,253,70,75,253,69,66,73,77,66,79,253,74,76,65,66,11},35))
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
print(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,48,81,76,77,77,66,65,23,253},35) .. (reason or _d({65,76,75,66},35)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,45,253,77,79,66,80,80,66,65,253,191,93,113,253,62,63,76,79,81,70,75,68,254},35))
cleanup(_d({45,253,72,66,86,253,62,63,76,79,81},35))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,56,2,65,12,2,65,58,253,49,79,62,83,66,73,73,70,75,68,253,81,76,253,64,69,66,80,81,253,62,81,253,2,80},35), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,41,76,80,81,253,64,69,62,79,62,64,81,66,79,253,191,93,113,253,77,62,82,80,70,75,68,11},35))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,30,79,79,70,83,66,65,254,253,5,65,70,80,81,26,2,11,14,67,6},35), dist))
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
print(string.format(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,44,77,66,75,66,65,253,64,69,66,80,81,253,2,65,254},35), i))
else
warn(string.format(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,67,70,79,66,77,79,76,85,70,74,70,81,86,77,79,76,74,77,81,253,67,62,70,73,66,65,23,253,2,80},35), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,32,69,66,80,81,253,2,65,253,77,79,76,74,77,81,253,75,76,253,73,76,75,68,66,79,253,66,85,70,80,81,80,253,5,74,62,86,253,69,62,83,66,253,65,66,80,77,62,84,75,66,65,6,11},35), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({56,44,77,66,75,32,69,66,80,81,80,58,253,30,73,73,253,64,69,66,80,81,80,253,77,79,76,64,66,80,80,66,65,254},35))
cleanup(_d({62,73,73,253,65,76,75,66},35))
end
end)()