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
warn(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,19,62,68,55,51,54,75,242,68,71,64,64,59,64,57,243,242,19,52,65,68,70,59,64,57,242,54,71,66,62,59,53,51,70,55,242,62,51,71,64,53,58,0},46))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({34,62,51,75,55,68,69},46))
local RunService       = game:GetService(_d({36,71,64,37,55,68,72,59,53,55},46))
local UserInputService = game:GetService(_d({39,69,55,68,27,64,66,71,70,37,55,68,72,59,53,55},46))
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
if v:IsA(_d({34,68,65,74,59,63,59,70,75,34,68,65,63,66,70},46)) then
local action = v.ActionText
if action:find(_d({34,55,62,59,242,21,58,55,69,70},46)) then
local part = v.Parent
if part and part:IsA(_d({20,51,69,55,34,51,68,70},46)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({250,247,0,2,56,254,242,247,0,2,56,254,242,247,0,2,56,251},46), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
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
print(string.format(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,24,65,71,64,54,242,247,54,242,34,55,62,59,242,21,58,55,69,70,69,0},46), #chests))
if #chests == 0 then
warn(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,32,65,242,53,58,55,69,70,69,242,56,65,71,64,54,242,180,82,102,242,51,68,55,242,75,65,71,242,59,64,242,70,58,55,242,68,59,57,58,70,242,51,68,55,51,17},46))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,21,65,71,62,54,242,64,65,70,242,56,59,64,54,242,53,58,51,68,51,53,70,55,68,242,68,65,65,70,243,242,19,52,65,68,70,59,64,57,0},46))
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
print(string.format(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,37,61,59,66,66,59,64,57,242,55,62,55,72,51,70,55,54,242,53,58,55,69,70,242,51,70,242,247,69,242,250,43,15,247,0,2,56,242,16,242,62,59,63,59,70,242,247,0,2,56,251},46),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,247,54,242,53,58,55,69,70,69,242,67,71,55,71,55,54,242,250,64,55,51,68,55,69,70,255,56,59,68,69,70,254,242,51,56,70,55,68,242,43,242,56,59,62,70,55,68,251,0},46), #chests))
if #chests == 0 then
warn(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,32,65,242,68,55,51,53,58,51,52,62,55,242,53,58,55,69,70,69,242,51,56,70,55,68,242,56,59,62,70,55,68,59,64,57,0},46))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({62,59,52,1,55,51,69,75,49,70,68,51,72,55,62,0,62,71,51},46))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,24,51,59,62,55,54,242,70,65,242,62,65,51,54,242,55,51,69,75,49,70,68,51,72,55,62,0,62,71,51,242,180,82,102,242,53,58,55,53,61,242,73,65,68,61,69,66,51,53,55,242,56,59,62,55,243},46))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,55,51,69,75,49,70,68,51,72,55,62,242,19,34,27,242,64,65,70,242,68,55,70,71,68,64,55,54,242,53,65,68,68,55,53,70,62,75,0},46))
end
task.wait(0.2)
ET.Start()
print(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,23,51,69,75,242,38,68,51,72,55,62,242,69,70,51,68,70,55,54,242,59,64,242,58,55,62,66,55,68,242,63,65,54,55,0},46))
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
print(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,37,70,65,66,66,55,54,12,242},46) .. (reason or _d({54,65,64,55},46)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,34,242,66,68,55,69,69,55,54,242,180,82,102,242,51,52,65,68,70,59,64,57,243},46))
cleanup(_d({34,242,61,55,75,242,51,52,65,68,70},46))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,45,247,54,1,247,54,47,242,38,68,51,72,55,62,62,59,64,57,242,70,65,242,53,58,55,69,70,242,51,70,242,247,69},46), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,30,65,69,70,242,53,58,51,68,51,53,70,55,68,242,180,82,102,242,66,51,71,69,59,64,57,0},46))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,19,68,68,59,72,55,54,243,242,250,54,59,69,70,15,247,0,3,56,251},46), dist))
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
print(string.format(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,33,66,55,64,55,54,242,53,58,55,69,70,242,247,54,243},46), i))
else
warn(string.format(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,56,59,68,55,66,68,65,74,59,63,59,70,75,66,68,65,63,66,70,242,56,51,59,62,55,54,12,242,247,69},46), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,21,58,55,69,70,242,247,54,242,66,68,65,63,66,70,242,64,65,242,62,65,64,57,55,68,242,55,74,59,69,70,69,242,250,63,51,75,242,58,51,72,55,242,54,55,69,66,51,73,64,55,54,251,0},46), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({45,33,66,55,64,21,58,55,69,70,69,47,242,19,62,62,242,53,58,55,69,70,69,242,66,68,65,53,55,69,69,55,54,243},46))
cleanup(_d({51,62,62,242,54,65,64,55},46))
end
end)()