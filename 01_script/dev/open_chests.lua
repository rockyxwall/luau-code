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
warn(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,18,61,67,54,50,53,74,241,67,70,63,63,58,63,56,242,241,18,51,64,67,69,58,63,56,241,53,70,65,61,58,52,50,69,54,241,61,50,70,63,52,57,255},47))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({33,61,50,74,54,67,68},47))
local RunService       = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
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
if v:IsA(_d({33,67,64,73,58,62,58,69,74,33,67,64,62,65,69},47)) then
local action = v.ActionText
if action:find(_d({33,54,61,58,241,20,57,54,68,69},47)) then
local part = v.Parent
if part and part:IsA(_d({19,50,68,54,33,50,67,69},47)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({249,246,255,1,55,253,241,246,255,1,55,253,241,246,255,1,55,250},47), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
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
print(string.format(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,23,64,70,63,53,241,246,53,241,33,54,61,58,241,20,57,54,68,69,68,255},47), #chests))
if #chests == 0 then
warn(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,31,64,241,52,57,54,68,69,68,241,55,64,70,63,53,241,179,81,101,241,50,67,54,241,74,64,70,241,58,63,241,69,57,54,241,67,58,56,57,69,241,50,67,54,50,16},47))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,20,64,70,61,53,241,63,64,69,241,55,58,63,53,241,52,57,50,67,50,52,69,54,67,241,67,64,64,69,242,241,18,51,64,67,69,58,63,56,255},47))
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
print(string.format(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,36,60,58,65,65,58,63,56,241,54,61,54,71,50,69,54,53,241,52,57,54,68,69,241,50,69,241,246,68,241,249,42,14,246,255,1,55,241,15,241,61,58,62,58,69,241,246,255,1,55,250},47),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,246,53,241,52,57,54,68,69,68,241,66,70,54,70,54,53,241,249,63,54,50,67,54,68,69,254,55,58,67,68,69,253,241,50,55,69,54,67,241,42,241,55,58,61,69,54,67,250,255},47), #chests))
if #chests == 0 then
warn(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,31,64,241,67,54,50,52,57,50,51,61,54,241,52,57,54,68,69,68,241,50,55,69,54,67,241,55,58,61,69,54,67,58,63,56,255},47))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({61,58,51,0,54,50,68,74,48,69,67,50,71,54,61,255,61,70,50},47))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,23,50,58,61,54,53,241,69,64,241,61,64,50,53,241,54,50,68,74,48,69,67,50,71,54,61,255,61,70,50,241,179,81,101,241,52,57,54,52,60,241,72,64,67,60,68,65,50,52,54,241,55,58,61,54,242},47))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,54,50,68,74,48,69,67,50,71,54,61,241,18,33,26,241,63,64,69,241,67,54,69,70,67,63,54,53,241,52,64,67,67,54,52,69,61,74,255},47))
end
task.wait(0.2)
ET.Start()
print(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,22,50,68,74,241,37,67,50,71,54,61,241,68,69,50,67,69,54,53,241,58,63,241,57,54,61,65,54,67,241,62,64,53,54,255},47))
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
print(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,36,69,64,65,65,54,53,11,241},47) .. (reason or _d({53,64,63,54},47)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,33,241,65,67,54,68,68,54,53,241,179,81,101,241,50,51,64,67,69,58,63,56,242},47))
cleanup(_d({33,241,60,54,74,241,50,51,64,67,69},47))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,44,246,53,0,246,53,46,241,37,67,50,71,54,61,61,58,63,56,241,69,64,241,52,57,54,68,69,241,50,69,241,246,68},47), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,29,64,68,69,241,52,57,50,67,50,52,69,54,67,241,179,81,101,241,65,50,70,68,58,63,56,255},47))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,18,67,67,58,71,54,53,242,241,249,53,58,68,69,14,246,255,2,55,250},47), dist))
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
print(string.format(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,32,65,54,63,54,53,241,52,57,54,68,69,241,246,53,242},47), i))
else
warn(string.format(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,55,58,67,54,65,67,64,73,58,62,58,69,74,65,67,64,62,65,69,241,55,50,58,61,54,53,11,241,246,68},47), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,20,57,54,68,69,241,246,53,241,65,67,64,62,65,69,241,63,64,241,61,64,63,56,54,67,241,54,73,58,68,69,68,241,249,62,50,74,241,57,50,71,54,241,53,54,68,65,50,72,63,54,53,250,255},47), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({44,32,65,54,63,20,57,54,68,69,68,46,241,18,61,61,241,52,57,54,68,69,68,241,65,67,64,52,54,68,68,54,53,242},47))
cleanup(_d({50,61,61,241,53,64,63,54},47))
end
end)()