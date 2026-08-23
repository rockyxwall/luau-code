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
warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,5,48,54,41,37,40,61,228,54,57,50,50,45,50,43,229,228,5,38,51,54,56,45,50,43,228,40,57,52,48,45,39,37,56,41,228,48,37,57,50,39,44,242},60))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({20,48,37,61,41,54,55},60))
local RunService       = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
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
if v:IsA(_d({20,54,51,60,45,49,45,56,61,20,54,51,49,52,56},60)) then
local action = v.ActionText
if action:find(_d({20,41,48,45,228,7,44,41,55,56},60)) then
local part = v.Parent
if part and part:IsA(_d({6,37,55,41,20,37,54,56},60)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({236,233,242,244,42,240,228,233,242,244,42,240,228,233,242,244,42,237},60), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
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
print(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,10,51,57,50,40,228,233,40,228,20,41,48,45,228,7,44,41,55,56,55,242},60), #chests))
if #chests == 0 then
warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,18,51,228,39,44,41,55,56,55,228,42,51,57,50,40,228,166,68,88,228,37,54,41,228,61,51,57,228,45,50,228,56,44,41,228,54,45,43,44,56,228,37,54,41,37,3},60))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,7,51,57,48,40,228,50,51,56,228,42,45,50,40,228,39,44,37,54,37,39,56,41,54,228,54,51,51,56,229,228,5,38,51,54,56,45,50,43,242},60))
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
print(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,23,47,45,52,52,45,50,43,228,41,48,41,58,37,56,41,40,228,39,44,41,55,56,228,37,56,228,233,55,228,236,29,1,233,242,244,42,228,2,228,48,45,49,45,56,228,233,242,244,42,237},60),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,233,40,228,39,44,41,55,56,55,228,53,57,41,57,41,40,228,236,50,41,37,54,41,55,56,241,42,45,54,55,56,240,228,37,42,56,41,54,228,29,228,42,45,48,56,41,54,237,242},60), #chests))
if #chests == 0 then
warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,18,51,228,54,41,37,39,44,37,38,48,41,228,39,44,41,55,56,55,228,37,42,56,41,54,228,42,45,48,56,41,54,45,50,43,242},60))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({48,45,38,243,41,37,55,61,35,56,54,37,58,41,48,242,48,57,37},60))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,228,41,37,55,61,35,56,54,37,58,41,48,242,48,57,37,228,166,68,88,228,39,44,41,39,47,228,59,51,54,47,55,52,37,39,41,228,42,45,48,41,229},60))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,41,37,55,61,35,56,54,37,58,41,48,228,5,20,13,228,50,51,56,228,54,41,56,57,54,50,41,40,228,39,51,54,54,41,39,56,48,61,242},60))
end
task.wait(0.2)
ET.Start()
print(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,9,37,55,61,228,24,54,37,58,41,48,228,55,56,37,54,56,41,40,228,45,50,228,44,41,48,52,41,54,228,49,51,40,41,242},60))
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
print(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,23,56,51,52,52,41,40,254,228},60) .. (reason or _d({40,51,50,41},60)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,20,228,52,54,41,55,55,41,40,228,166,68,88,228,37,38,51,54,56,45,50,43,229},60))
cleanup(_d({20,228,47,41,61,228,37,38,51,54,56},60))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,31,233,40,243,233,40,33,228,24,54,37,58,41,48,48,45,50,43,228,56,51,228,39,44,41,55,56,228,37,56,228,233,55},60), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,16,51,55,56,228,39,44,37,54,37,39,56,41,54,228,166,68,88,228,52,37,57,55,45,50,43,242},60))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,5,54,54,45,58,41,40,229,228,236,40,45,55,56,1,233,242,245,42,237},60), dist))
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
print(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,19,52,41,50,41,40,228,39,44,41,55,56,228,233,40,229},60), i))
else
warn(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,42,45,54,41,52,54,51,60,45,49,45,56,61,52,54,51,49,52,56,228,42,37,45,48,41,40,254,228,233,55},60), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,7,44,41,55,56,228,233,40,228,52,54,51,49,52,56,228,50,51,228,48,51,50,43,41,54,228,41,60,45,55,56,55,228,236,49,37,61,228,44,37,58,41,228,40,41,55,52,37,59,50,41,40,237,242},60), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({31,19,52,41,50,7,44,41,55,56,55,33,228,5,48,48,228,39,44,41,55,56,55,228,52,54,51,39,41,55,55,41,40,229},60))
cleanup(_d({37,48,48,228,40,51,50,41},60))
end
end)()