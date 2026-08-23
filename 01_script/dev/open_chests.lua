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
warn(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,28,71,77,64,60,63,84,251,77,80,73,73,68,73,66,252,251,28,61,74,77,79,68,73,66,251,63,80,75,71,68,62,60,79,64,251,71,60,80,73,62,67,9},37))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({43,71,60,84,64,77,78},37))
local RunService       = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
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
if v:IsA(_d({43,77,74,83,68,72,68,79,84,43,77,74,72,75,79},37)) then
local action = v.ActionText
if action:find(_d({43,64,71,68,251,30,67,64,78,79},37)) then
local part = v.Parent
if part and part:IsA(_d({29,60,78,64,43,60,77,79},37)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({3,0,9,11,65,7,251,0,9,11,65,7,251,0,9,11,65,4},37), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
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
print(string.format(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,33,74,80,73,63,251,0,63,251,43,64,71,68,251,30,67,64,78,79,78,9},37), #chests))
if #chests == 0 then
warn(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,41,74,251,62,67,64,78,79,78,251,65,74,80,73,63,251,189,91,111,251,60,77,64,251,84,74,80,251,68,73,251,79,67,64,251,77,68,66,67,79,251,60,77,64,60,26},37))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,30,74,80,71,63,251,73,74,79,251,65,68,73,63,251,62,67,60,77,60,62,79,64,77,251,77,74,74,79,252,251,28,61,74,77,79,68,73,66,9},37))
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
print(string.format(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,46,70,68,75,75,68,73,66,251,64,71,64,81,60,79,64,63,251,62,67,64,78,79,251,60,79,251,0,78,251,3,52,24,0,9,11,65,251,25,251,71,68,72,68,79,251,0,9,11,65,4},37),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,0,63,251,62,67,64,78,79,78,251,76,80,64,80,64,63,251,3,73,64,60,77,64,78,79,8,65,68,77,78,79,7,251,60,65,79,64,77,251,52,251,65,68,71,79,64,77,4,9},37), #chests))
if #chests == 0 then
warn(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,41,74,251,77,64,60,62,67,60,61,71,64,251,62,67,64,78,79,78,251,60,65,79,64,77,251,65,68,71,79,64,77,68,73,66,9},37))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60,251,189,91,111,251,62,67,64,62,70,251,82,74,77,70,78,75,60,62,64,251,65,68,71,64,252},37))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,64,60,78,84,58,79,77,60,81,64,71,251,28,43,36,251,73,74,79,251,77,64,79,80,77,73,64,63,251,62,74,77,77,64,62,79,71,84,9},37))
end
task.wait(0.2)
ET.Start()
print(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,32,60,78,84,251,47,77,60,81,64,71,251,78,79,60,77,79,64,63,251,68,73,251,67,64,71,75,64,77,251,72,74,63,64,9},37))
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
print(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,46,79,74,75,75,64,63,21,251},37) .. (reason or _d({63,74,73,64},37)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,43,251,75,77,64,78,78,64,63,251,189,91,111,251,60,61,74,77,79,68,73,66,252},37))
cleanup(_d({43,251,70,64,84,251,60,61,74,77,79},37))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,54,0,63,10,0,63,56,251,47,77,60,81,64,71,71,68,73,66,251,79,74,251,62,67,64,78,79,251,60,79,251,0,78},37), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,39,74,78,79,251,62,67,60,77,60,62,79,64,77,251,189,91,111,251,75,60,80,78,68,73,66,9},37))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,28,77,77,68,81,64,63,252,251,3,63,68,78,79,24,0,9,12,65,4},37), dist))
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
print(string.format(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,42,75,64,73,64,63,251,62,67,64,78,79,251,0,63,252},37), i))
else
warn(string.format(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,65,68,77,64,75,77,74,83,68,72,68,79,84,75,77,74,72,75,79,251,65,60,68,71,64,63,21,251,0,78},37), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,30,67,64,78,79,251,0,63,251,75,77,74,72,75,79,251,73,74,251,71,74,73,66,64,77,251,64,83,68,78,79,78,251,3,72,60,84,251,67,60,81,64,251,63,64,78,75,60,82,73,64,63,4,9},37), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({54,42,75,64,73,30,67,64,78,79,78,56,251,28,71,71,251,62,67,64,78,79,78,251,75,77,74,62,64,78,78,64,63,252},37))
cleanup(_d({60,71,71,251,63,74,73,64},37))
end
end)()