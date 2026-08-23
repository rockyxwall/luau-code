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
warn(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,36,79,85,72,68,71,92,3,85,88,81,81,76,81,74,4,3,36,69,82,85,87,76,81,74,3,71,88,83,79,76,70,68,87,72,3,79,68,88,81,70,75,17},29))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({51,79,68,92,72,85,86},29))
local RunService       = game:GetService(_d({53,88,81,54,72,85,89,76,70,72},29))
local UserInputService = game:GetService(_d({56,86,72,85,44,81,83,88,87,54,72,85,89,76,70,72},29))
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
if v:IsA(_d({51,85,82,91,76,80,76,87,92,51,85,82,80,83,87},29)) then
local action = v.ActionText
if action:find(_d({51,72,79,76,3,38,75,72,86,87},29)) then
local part = v.Parent
if part and part:IsA(_d({37,68,86,72,51,68,85,87},29)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({11,8,17,19,73,15,3,8,17,19,73,15,3,8,17,19,73,12},29), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
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
print(string.format(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,41,82,88,81,71,3,8,71,3,51,72,79,76,3,38,75,72,86,87,86,17},29), #chests))
if #chests == 0 then
warn(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,49,82,3,70,75,72,86,87,86,3,73,82,88,81,71,3,197,99,119,3,68,85,72,3,92,82,88,3,76,81,3,87,75,72,3,85,76,74,75,87,3,68,85,72,68,34},29))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,38,82,88,79,71,3,81,82,87,3,73,76,81,71,3,70,75,68,85,68,70,87,72,85,3,85,82,82,87,4,3,36,69,82,85,87,76,81,74,17},29))
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
print(string.format(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,54,78,76,83,83,76,81,74,3,72,79,72,89,68,87,72,71,3,70,75,72,86,87,3,68,87,3,8,86,3,11,60,32,8,17,19,73,3,33,3,79,76,80,76,87,3,8,17,19,73,12},29),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,8,71,3,70,75,72,86,87,86,3,84,88,72,88,72,71,3,11,81,72,68,85,72,86,87,16,73,76,85,86,87,15,3,68,73,87,72,85,3,60,3,73,76,79,87,72,85,12,17},29), #chests))
if #chests == 0 then
warn(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,49,82,3,85,72,68,70,75,68,69,79,72,3,70,75,72,86,87,86,3,68,73,87,72,85,3,73,76,79,87,72,85,76,81,74,17},29))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({79,76,69,18,72,68,86,92,66,87,85,68,89,72,79,17,79,88,68},29))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,41,68,76,79,72,71,3,87,82,3,79,82,68,71,3,72,68,86,92,66,87,85,68,89,72,79,17,79,88,68,3,197,99,119,3,70,75,72,70,78,3,90,82,85,78,86,83,68,70,72,3,73,76,79,72,4},29))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,72,68,86,92,66,87,85,68,89,72,79,3,36,51,44,3,81,82,87,3,85,72,87,88,85,81,72,71,3,70,82,85,85,72,70,87,79,92,17},29))
end
task.wait(0.2)
ET.Start()
print(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,40,68,86,92,3,55,85,68,89,72,79,3,86,87,68,85,87,72,71,3,76,81,3,75,72,79,83,72,85,3,80,82,71,72,17},29))
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
print(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,54,87,82,83,83,72,71,29,3},29) .. (reason or _d({71,82,81,72},29)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,51,3,83,85,72,86,86,72,71,3,197,99,119,3,68,69,82,85,87,76,81,74,4},29))
cleanup(_d({51,3,78,72,92,3,68,69,82,85,87},29))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,62,8,71,18,8,71,64,3,55,85,68,89,72,79,79,76,81,74,3,87,82,3,70,75,72,86,87,3,68,87,3,8,86},29), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,47,82,86,87,3,70,75,68,85,68,70,87,72,85,3,197,99,119,3,83,68,88,86,76,81,74,17},29))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,36,85,85,76,89,72,71,4,3,11,71,76,86,87,32,8,17,20,73,12},29), dist))
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
print(string.format(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,50,83,72,81,72,71,3,70,75,72,86,87,3,8,71,4},29), i))
else
warn(string.format(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,73,76,85,72,83,85,82,91,76,80,76,87,92,83,85,82,80,83,87,3,73,68,76,79,72,71,29,3,8,86},29), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,38,75,72,86,87,3,8,71,3,83,85,82,80,83,87,3,81,82,3,79,82,81,74,72,85,3,72,91,76,86,87,86,3,11,80,68,92,3,75,68,89,72,3,71,72,86,83,68,90,81,72,71,12,17},29), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({62,50,83,72,81,38,75,72,86,87,86,64,3,36,79,79,3,70,75,72,86,87,86,3,83,85,82,70,72,86,86,72,71,4},29))
cleanup(_d({68,79,79,3,71,82,81,72},29))
end
end)()