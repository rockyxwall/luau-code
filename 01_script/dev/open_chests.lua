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
warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,34,77,83,70,66,69,90,1,83,86,79,79,74,79,72,2,1,34,67,80,83,85,74,79,72,1,69,86,81,77,74,68,66,85,70,1,77,66,86,79,68,73,15},31))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({49,77,66,90,70,83,84},31))
local RunService       = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local UserInputService = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
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
if v:IsA(_d({49,83,80,89,74,78,74,85,90,49,83,80,78,81,85},31)) then
local action = v.ActionText
if action:find(_d({49,70,77,74,1,36,73,70,84,85},31)) then
local part = v.Parent
if part and part:IsA(_d({35,66,84,70,49,66,83,85},31)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({9,6,15,17,71,13,1,6,15,17,71,13,1,6,15,17,71,10},31), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
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
print(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,39,80,86,79,69,1,6,69,1,49,70,77,74,1,36,73,70,84,85,84,15},31), #chests))
if #chests == 0 then
warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,47,80,1,68,73,70,84,85,84,1,71,80,86,79,69,1,195,97,117,1,66,83,70,1,90,80,86,1,74,79,1,85,73,70,1,83,74,72,73,85,1,66,83,70,66,32},31))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,36,80,86,77,69,1,79,80,85,1,71,74,79,69,1,68,73,66,83,66,68,85,70,83,1,83,80,80,85,2,1,34,67,80,83,85,74,79,72,15},31))
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
print(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,52,76,74,81,81,74,79,72,1,70,77,70,87,66,85,70,69,1,68,73,70,84,85,1,66,85,1,6,84,1,9,58,30,6,15,17,71,1,31,1,77,74,78,74,85,1,6,15,17,71,10},31),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,6,69,1,68,73,70,84,85,84,1,82,86,70,86,70,69,1,9,79,70,66,83,70,84,85,14,71,74,83,84,85,13,1,66,71,85,70,83,1,58,1,71,74,77,85,70,83,10,15},31), #chests))
if #chests == 0 then
warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,47,80,1,83,70,66,68,73,66,67,77,70,1,68,73,70,84,85,84,1,66,71,85,70,83,1,71,74,77,85,70,83,74,79,72,15},31))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({77,74,67,16,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,1,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66,1,195,97,117,1,68,73,70,68,76,1,88,80,83,76,84,81,66,68,70,1,71,74,77,70,2},31))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,70,66,84,90,64,85,83,66,87,70,77,1,34,49,42,1,79,80,85,1,83,70,85,86,83,79,70,69,1,68,80,83,83,70,68,85,77,90,15},31))
end
task.wait(0.2)
ET.Start()
print(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,38,66,84,90,1,53,83,66,87,70,77,1,84,85,66,83,85,70,69,1,74,79,1,73,70,77,81,70,83,1,78,80,69,70,15},31))
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
print(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,52,85,80,81,81,70,69,27,1},31) .. (reason or _d({69,80,79,70},31)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,49,1,81,83,70,84,84,70,69,1,195,97,117,1,66,67,80,83,85,74,79,72,2},31))
cleanup(_d({49,1,76,70,90,1,66,67,80,83,85},31))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,60,6,69,16,6,69,62,1,53,83,66,87,70,77,77,74,79,72,1,85,80,1,68,73,70,84,85,1,66,85,1,6,84},31), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,45,80,84,85,1,68,73,66,83,66,68,85,70,83,1,195,97,117,1,81,66,86,84,74,79,72,15},31))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,34,83,83,74,87,70,69,2,1,9,69,74,84,85,30,6,15,18,71,10},31), dist))
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
print(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,48,81,70,79,70,69,1,68,73,70,84,85,1,6,69,2},31), i))
else
warn(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,71,74,83,70,81,83,80,89,74,78,74,85,90,81,83,80,78,81,85,1,71,66,74,77,70,69,27,1,6,84},31), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,36,73,70,84,85,1,6,69,1,81,83,80,78,81,85,1,79,80,1,77,80,79,72,70,83,1,70,89,74,84,85,84,1,9,78,66,90,1,73,66,87,70,1,69,70,84,81,66,88,79,70,69,10,15},31), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({60,48,81,70,79,36,73,70,84,85,84,62,1,34,77,77,1,68,73,70,84,85,84,1,81,83,80,68,70,84,84,70,69,2},31))
cleanup(_d({66,77,77,1,69,80,79,70},31))
end
end)()