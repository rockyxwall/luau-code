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
warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,9,52,58,45,41,44,65,232,58,61,54,54,49,54,47,233,232,9,42,55,58,60,49,54,47,232,44,61,56,52,49,43,41,60,45,232,52,41,61,54,43,48,246},56))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({24,52,41,65,45,58,59},56))
local RunService       = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
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
if v:IsA(_d({24,58,55,64,49,53,49,60,65,24,58,55,53,56,60},56)) then
local action = v.ActionText
if action:find(_d({24,45,52,49,232,11,48,45,59,60},56)) then
local part = v.Parent
if part and part:IsA(_d({10,41,59,45,24,41,58,60},56)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({240,237,246,248,46,244,232,237,246,248,46,244,232,237,246,248,46,241},56), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
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
print(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,14,55,61,54,44,232,237,44,232,24,45,52,49,232,11,48,45,59,60,59,246},56), #chests))
if #chests == 0 then
warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,22,55,232,43,48,45,59,60,59,232,46,55,61,54,44,232,170,72,92,232,41,58,45,232,65,55,61,232,49,54,232,60,48,45,232,58,49,47,48,60,232,41,58,45,41,7},56))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,11,55,61,52,44,232,54,55,60,232,46,49,54,44,232,43,48,41,58,41,43,60,45,58,232,58,55,55,60,233,232,9,42,55,58,60,49,54,47,246},56))
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
print(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,27,51,49,56,56,49,54,47,232,45,52,45,62,41,60,45,44,232,43,48,45,59,60,232,41,60,232,237,59,232,240,33,5,237,246,248,46,232,6,232,52,49,53,49,60,232,237,246,248,46,241},56),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,237,44,232,43,48,45,59,60,59,232,57,61,45,61,45,44,232,240,54,45,41,58,45,59,60,245,46,49,58,59,60,244,232,41,46,60,45,58,232,33,232,46,49,52,60,45,58,241,246},56), #chests))
if #chests == 0 then
warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,22,55,232,58,45,41,43,48,41,42,52,45,232,43,48,45,59,60,59,232,41,46,60,45,58,232,46,49,52,60,45,58,49,54,47,246},56))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,232,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41,232,170,72,92,232,43,48,45,43,51,232,63,55,58,51,59,56,41,43,45,232,46,49,52,45,233},56))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,45,41,59,65,39,60,58,41,62,45,52,232,9,24,17,232,54,55,60,232,58,45,60,61,58,54,45,44,232,43,55,58,58,45,43,60,52,65,246},56))
end
task.wait(0.2)
ET.Start()
print(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,13,41,59,65,232,28,58,41,62,45,52,232,59,60,41,58,60,45,44,232,49,54,232,48,45,52,56,45,58,232,53,55,44,45,246},56))
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
print(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,27,60,55,56,56,45,44,2,232},56) .. (reason or _d({44,55,54,45},56)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,24,232,56,58,45,59,59,45,44,232,170,72,92,232,41,42,55,58,60,49,54,47,233},56))
cleanup(_d({24,232,51,45,65,232,41,42,55,58,60},56))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,35,237,44,247,237,44,37,232,28,58,41,62,45,52,52,49,54,47,232,60,55,232,43,48,45,59,60,232,41,60,232,237,59},56), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,20,55,59,60,232,43,48,41,58,41,43,60,45,58,232,170,72,92,232,56,41,61,59,49,54,47,246},56))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,9,58,58,49,62,45,44,233,232,240,44,49,59,60,5,237,246,249,46,241},56), dist))
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
print(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,23,56,45,54,45,44,232,43,48,45,59,60,232,237,44,233},56), i))
else
warn(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,46,49,58,45,56,58,55,64,49,53,49,60,65,56,58,55,53,56,60,232,46,41,49,52,45,44,2,232,237,59},56), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,11,48,45,59,60,232,237,44,232,56,58,55,53,56,60,232,54,55,232,52,55,54,47,45,58,232,45,64,49,59,60,59,232,240,53,41,65,232,48,41,62,45,232,44,45,59,56,41,63,54,45,44,241,246},56), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({35,23,56,45,54,11,48,45,59,60,59,37,232,9,52,52,232,43,48,45,59,60,59,232,56,58,55,43,45,59,59,45,44,233},56))
cleanup(_d({41,52,52,232,44,55,54,45},56))
end
end)()