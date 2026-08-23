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
warn(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,4,47,53,40,36,39,60,227,53,56,49,49,44,49,42,228,227,4,37,50,53,55,44,49,42,227,39,56,51,47,44,38,36,55,40,227,47,36,56,49,38,43,241},61))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({19,47,36,60,40,53,54},61))
local RunService       = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
if v:IsA(_d({19,53,50,59,44,48,44,55,60,19,53,50,48,51,55},61)) then
local action = v.ActionText
if action:find(_d({19,40,47,44,227,6,43,40,54,55},61)) then
local part = v.Parent
if part and part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({235,232,241,243,41,239,227,232,241,243,41,239,227,232,241,243,41,236},61), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
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
print(string.format(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,9,50,56,49,39,227,232,39,227,19,40,47,44,227,6,43,40,54,55,54,241},61), #chests))
if #chests == 0 then
warn(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,17,50,227,38,43,40,54,55,54,227,41,50,56,49,39,227,165,67,87,227,36,53,40,227,60,50,56,227,44,49,227,55,43,40,227,53,44,42,43,55,227,36,53,40,36,2},61))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,6,50,56,47,39,227,49,50,55,227,41,44,49,39,227,38,43,36,53,36,38,55,40,53,227,53,50,50,55,228,227,4,37,50,53,55,44,49,42,241},61))
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
print(string.format(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,22,46,44,51,51,44,49,42,227,40,47,40,57,36,55,40,39,227,38,43,40,54,55,227,36,55,227,232,54,227,235,28,0,232,241,243,41,227,1,227,47,44,48,44,55,227,232,241,243,41,236},61),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,232,39,227,38,43,40,54,55,54,227,52,56,40,56,40,39,227,235,49,40,36,53,40,54,55,240,41,44,53,54,55,239,227,36,41,55,40,53,227,28,227,41,44,47,55,40,53,236,241},61), #chests))
if #chests == 0 then
warn(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,17,50,227,53,40,36,38,43,36,37,47,40,227,38,43,40,54,55,54,227,36,41,55,40,53,227,41,44,47,55,40,53,44,49,42,241},61))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({47,44,37,242,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36},61))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,227,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36,227,165,67,87,227,38,43,40,38,46,227,58,50,53,46,54,51,36,38,40,227,41,44,47,40,228},61))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,40,36,54,60,34,55,53,36,57,40,47,227,4,19,12,227,49,50,55,227,53,40,55,56,53,49,40,39,227,38,50,53,53,40,38,55,47,60,241},61))
end
task.wait(0.2)
ET.Start()
print(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,8,36,54,60,227,23,53,36,57,40,47,227,54,55,36,53,55,40,39,227,44,49,227,43,40,47,51,40,53,227,48,50,39,40,241},61))
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
print(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,22,55,50,51,51,40,39,253,227},61) .. (reason or _d({39,50,49,40},61)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,19,227,51,53,40,54,54,40,39,227,165,67,87,227,36,37,50,53,55,44,49,42,228},61))
cleanup(_d({19,227,46,40,60,227,36,37,50,53,55},61))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,30,232,39,242,232,39,32,227,23,53,36,57,40,47,47,44,49,42,227,55,50,227,38,43,40,54,55,227,36,55,227,232,54},61), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,15,50,54,55,227,38,43,36,53,36,38,55,40,53,227,165,67,87,227,51,36,56,54,44,49,42,241},61))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,4,53,53,44,57,40,39,228,227,235,39,44,54,55,0,232,241,244,41,236},61), dist))
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
print(string.format(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,18,51,40,49,40,39,227,38,43,40,54,55,227,232,39,228},61), i))
else
warn(string.format(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,41,44,53,40,51,53,50,59,44,48,44,55,60,51,53,50,48,51,55,227,41,36,44,47,40,39,253,227,232,54},61), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,6,43,40,54,55,227,232,39,227,51,53,50,48,51,55,227,49,50,227,47,50,49,42,40,53,227,40,59,44,54,55,54,227,235,48,36,60,227,43,36,57,40,227,39,40,54,51,36,58,49,40,39,236,241},61), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({30,18,51,40,49,6,43,40,54,55,54,32,227,4,47,47,227,38,43,40,54,55,54,227,51,53,50,38,40,54,54,40,39,228},61))
cleanup(_d({36,47,47,227,39,50,49,40},61))
end
end)()