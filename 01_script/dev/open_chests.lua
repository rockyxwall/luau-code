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
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,10,53,59,46,42,45,66,233,59,62,55,55,50,55,48,234,233,10,43,56,59,61,50,55,48,233,45,62,57,53,50,44,42,61,46,233,53,42,62,55,44,49,247},55))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({25,53,42,66,46,59,60},55))
local RunService       = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
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
if v:IsA(_d({25,59,56,65,50,54,50,61,66,25,59,56,54,57,61},55)) then
local action = v.ActionText
if action:find(_d({25,46,53,50,233,12,49,46,60,61},55)) then
local part = v.Parent
if part and part:IsA(_d({11,42,60,46,25,42,59,61},55)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({241,238,247,249,47,245,233,238,247,249,47,245,233,238,247,249,47,242},55), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
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
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,15,56,62,55,45,233,238,45,233,25,46,53,50,233,12,49,46,60,61,60,247},55), #chests))
if #chests == 0 then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,23,56,233,44,49,46,60,61,60,233,47,56,62,55,45,233,171,73,93,233,42,59,46,233,66,56,62,233,50,55,233,61,49,46,233,59,50,48,49,61,233,42,59,46,42,8},55))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,12,56,62,53,45,233,55,56,61,233,47,50,55,45,233,44,49,42,59,42,44,61,46,59,233,59,56,56,61,234,233,10,43,56,59,61,50,55,48,247},55))
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
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,28,52,50,57,57,50,55,48,233,46,53,46,63,42,61,46,45,233,44,49,46,60,61,233,42,61,233,238,60,233,241,34,6,238,247,249,47,233,7,233,53,50,54,50,61,233,238,247,249,47,242},55),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,238,45,233,44,49,46,60,61,60,233,58,62,46,62,46,45,233,241,55,46,42,59,46,60,61,246,47,50,59,60,61,245,233,42,47,61,46,59,233,34,233,47,50,53,61,46,59,242,247},55), #chests))
if #chests == 0 then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,23,56,233,59,46,42,44,49,42,43,53,46,233,44,49,46,60,61,60,233,42,47,61,46,59,233,47,50,53,61,46,59,50,55,48,247},55))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({53,50,43,248,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42},55))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,233,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42,233,171,73,93,233,44,49,46,44,52,233,64,56,59,52,60,57,42,44,46,233,47,50,53,46,234},55))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,46,42,60,66,40,61,59,42,63,46,53,233,10,25,18,233,55,56,61,233,59,46,61,62,59,55,46,45,233,44,56,59,59,46,44,61,53,66,247},55))
end
task.wait(0.2)
ET.Start()
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,14,42,60,66,233,29,59,42,63,46,53,233,60,61,42,59,61,46,45,233,50,55,233,49,46,53,57,46,59,233,54,56,45,46,247},55))
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
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,28,61,56,57,57,46,45,3,233},55) .. (reason or _d({45,56,55,46},55)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,25,233,57,59,46,60,60,46,45,233,171,73,93,233,42,43,56,59,61,50,55,48,234},55))
cleanup(_d({25,233,52,46,66,233,42,43,56,59,61},55))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,36,238,45,248,238,45,38,233,29,59,42,63,46,53,53,50,55,48,233,61,56,233,44,49,46,60,61,233,42,61,233,238,60},55), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,21,56,60,61,233,44,49,42,59,42,44,61,46,59,233,171,73,93,233,57,42,62,60,50,55,48,247},55))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,10,59,59,50,63,46,45,234,233,241,45,50,60,61,6,238,247,250,47,242},55), dist))
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
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,24,57,46,55,46,45,233,44,49,46,60,61,233,238,45,234},55), i))
else
warn(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,47,50,59,46,57,59,56,65,50,54,50,61,66,57,59,56,54,57,61,233,47,42,50,53,46,45,3,233,238,60},55), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,12,49,46,60,61,233,238,45,233,57,59,56,54,57,61,233,55,56,233,53,56,55,48,46,59,233,46,65,50,60,61,60,233,241,54,42,66,233,49,42,63,46,233,45,46,60,57,42,64,55,46,45,242,247},55), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,10,53,53,233,44,49,46,60,61,60,233,57,59,56,44,46,60,60,46,45,234},55))
cleanup(_d({42,53,53,233,45,56,55,46},55))
end
end)()