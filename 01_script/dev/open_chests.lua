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
warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,3,46,52,39,35,38,59,226,52,55,48,48,43,48,41,227,226,3,36,49,52,54,43,48,41,226,38,55,50,46,43,37,35,54,39,226,46,35,55,48,37,42,240},62))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({18,46,35,59,39,52,53},62))
local RunService       = game:GetService(_d({20,55,48,21,39,52,56,43,37,39},62))
local UserInputService = game:GetService(_d({23,53,39,52,11,48,50,55,54,21,39,52,56,43,37,39},62))
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
if v:IsA(_d({18,52,49,58,43,47,43,54,59,18,52,49,47,50,54},62)) then
local action = v.ActionText
if action:find(_d({18,39,46,43,226,5,42,39,53,54},62)) then
local part = v.Parent
if part and part:IsA(_d({4,35,53,39,18,35,52,54},62)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({234,231,240,242,40,238,226,231,240,242,40,238,226,231,240,242,40,235},62), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
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
print(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,8,49,55,48,38,226,231,38,226,18,39,46,43,226,5,42,39,53,54,53,240},62), #chests))
if #chests == 0 then
warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,16,49,226,37,42,39,53,54,53,226,40,49,55,48,38,226,164,66,86,226,35,52,39,226,59,49,55,226,43,48,226,54,42,39,226,52,43,41,42,54,226,35,52,39,35,1},62))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,5,49,55,46,38,226,48,49,54,226,40,43,48,38,226,37,42,35,52,35,37,54,39,52,226,52,49,49,54,227,226,3,36,49,52,54,43,48,41,240},62))
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
print(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,21,45,43,50,50,43,48,41,226,39,46,39,56,35,54,39,38,226,37,42,39,53,54,226,35,54,226,231,53,226,234,27,255,231,240,242,40,226,0,226,46,43,47,43,54,226,231,240,242,40,235},62),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,231,38,226,37,42,39,53,54,53,226,51,55,39,55,39,38,226,234,48,39,35,52,39,53,54,239,40,43,52,53,54,238,226,35,40,54,39,52,226,27,226,40,43,46,54,39,52,235,240},62), #chests))
if #chests == 0 then
warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,16,49,226,52,39,35,37,42,35,36,46,39,226,37,42,39,53,54,53,226,35,40,54,39,52,226,40,43,46,54,39,52,43,48,41,240},62))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,226,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35,226,164,66,86,226,37,42,39,37,45,226,57,49,52,45,53,50,35,37,39,226,40,43,46,39,227},62))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,39,35,53,59,33,54,52,35,56,39,46,226,3,18,11,226,48,49,54,226,52,39,54,55,52,48,39,38,226,37,49,52,52,39,37,54,46,59,240},62))
end
task.wait(0.2)
ET.Start()
print(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,7,35,53,59,226,22,52,35,56,39,46,226,53,54,35,52,54,39,38,226,43,48,226,42,39,46,50,39,52,226,47,49,38,39,240},62))
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
print(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,21,54,49,50,50,39,38,252,226},62) .. (reason or _d({38,49,48,39},62)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,18,226,50,52,39,53,53,39,38,226,164,66,86,226,35,36,49,52,54,43,48,41,227},62))
cleanup(_d({18,226,45,39,59,226,35,36,49,52,54},62))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,29,231,38,241,231,38,31,226,22,52,35,56,39,46,46,43,48,41,226,54,49,226,37,42,39,53,54,226,35,54,226,231,53},62), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,14,49,53,54,226,37,42,35,52,35,37,54,39,52,226,164,66,86,226,50,35,55,53,43,48,41,240},62))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,3,52,52,43,56,39,38,227,226,234,38,43,53,54,255,231,240,243,40,235},62), dist))
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
print(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,17,50,39,48,39,38,226,37,42,39,53,54,226,231,38,227},62), i))
else
warn(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,40,43,52,39,50,52,49,58,43,47,43,54,59,50,52,49,47,50,54,226,40,35,43,46,39,38,252,226,231,53},62), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,5,42,39,53,54,226,231,38,226,50,52,49,47,50,54,226,48,49,226,46,49,48,41,39,52,226,39,58,43,53,54,53,226,234,47,35,59,226,42,35,56,39,226,38,39,53,50,35,57,48,39,38,235,240},62), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({29,17,50,39,48,5,42,39,53,54,53,31,226,3,46,46,226,37,42,39,53,54,53,226,50,52,49,37,39,53,53,39,38,227},62))
cleanup(_d({35,46,46,226,38,49,48,39},62))
end
end)()