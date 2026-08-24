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
warn(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,16,59,65,52,48,51,72,239,65,68,61,61,56,61,54,240,239,16,49,62,65,67,56,61,54,239,51,68,63,59,56,50,48,67,52,239,59,48,68,61,50,55,253},49))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({31,59,48,72,52,65,66},49))
local RunService       = game:GetService(_d({33,68,61,34,52,65,69,56,50,52},49))
local UserInputService = game:GetService(_d({36,66,52,65,24,61,63,68,67,34,52,65,69,56,50,52},49))
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
if v:IsA(_d({31,65,62,71,56,60,56,67,72,31,65,62,60,63,67},49)) then
local action = v.ActionText
if action:find(_d({31,52,59,56,239,18,55,52,66,67},49)) then
local part = v.Parent
if part and part:IsA(_d({17,48,66,52,31,48,65,67},49)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({247,244,253,255,53,251,239,244,253,255,53,251,239,244,253,255,53,248},49), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
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
print(string.format(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,21,62,68,61,51,239,244,51,239,31,52,59,56,239,18,55,52,66,67,66,253},49), #chests))
if #chests == 0 then
warn(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,29,62,239,50,55,52,66,67,66,239,53,62,68,61,51,239,177,79,99,239,48,65,52,239,72,62,68,239,56,61,239,67,55,52,239,65,56,54,55,67,239,48,65,52,48,14},49))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,18,62,68,59,51,239,61,62,67,239,53,56,61,51,239,50,55,48,65,48,50,67,52,65,239,65,62,62,67,240,239,16,49,62,65,67,56,61,54,253},49))
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
print(string.format(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,34,58,56,63,63,56,61,54,239,52,59,52,69,48,67,52,51,239,50,55,52,66,67,239,48,67,239,244,66,239,247,40,12,244,253,255,53,239,13,239,59,56,60,56,67,239,244,253,255,53,248},49),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,244,51,239,50,55,52,66,67,66,239,64,68,52,68,52,51,239,247,61,52,48,65,52,66,67,252,53,56,65,66,67,251,239,48,53,67,52,65,239,40,239,53,56,59,67,52,65,248,253},49), #chests))
if #chests == 0 then
warn(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,29,62,239,65,52,48,50,55,48,49,59,52,239,50,55,52,66,67,66,239,48,53,67,52,65,239,53,56,59,67,52,65,56,61,54,253},49))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({59,56,49,254,52,48,66,72,46,67,65,48,69,52,59,253,59,68,48},49))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,21,48,56,59,52,51,239,67,62,239,59,62,48,51,239,52,48,66,72,46,67,65,48,69,52,59,253,59,68,48,239,177,79,99,239,50,55,52,50,58,239,70,62,65,58,66,63,48,50,52,239,53,56,59,52,240},49))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,52,48,66,72,46,67,65,48,69,52,59,239,16,31,24,239,61,62,67,239,65,52,67,68,65,61,52,51,239,50,62,65,65,52,50,67,59,72,253},49))
end
task.wait(0.2)
ET.Start()
print(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,20,48,66,72,239,35,65,48,69,52,59,239,66,67,48,65,67,52,51,239,56,61,239,55,52,59,63,52,65,239,60,62,51,52,253},49))
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
print(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,34,67,62,63,63,52,51,9,239},49) .. (reason or _d({51,62,61,52},49)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,31,239,63,65,52,66,66,52,51,239,177,79,99,239,48,49,62,65,67,56,61,54,240},49))
cleanup(_d({31,239,58,52,72,239,48,49,62,65,67},49))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,42,244,51,254,244,51,44,239,35,65,48,69,52,59,59,56,61,54,239,67,62,239,50,55,52,66,67,239,48,67,239,244,66},49), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,27,62,66,67,239,50,55,48,65,48,50,67,52,65,239,177,79,99,239,63,48,68,66,56,61,54,253},49))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,16,65,65,56,69,52,51,240,239,247,51,56,66,67,12,244,253,0,53,248},49), dist))
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
print(string.format(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,30,63,52,61,52,51,239,50,55,52,66,67,239,244,51,240},49), i))
else
warn(string.format(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,53,56,65,52,63,65,62,71,56,60,56,67,72,63,65,62,60,63,67,239,53,48,56,59,52,51,9,239,244,66},49), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,18,55,52,66,67,239,244,51,239,63,65,62,60,63,67,239,61,62,239,59,62,61,54,52,65,239,52,71,56,66,67,66,239,247,60,48,72,239,55,48,69,52,239,51,52,66,63,48,70,61,52,51,248,253},49), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({42,30,63,52,61,18,55,52,66,67,66,44,239,16,59,59,239,50,55,52,66,67,66,239,63,65,62,50,52,66,66,52,51,240},49))
cleanup(_d({48,59,59,239,51,62,61,52},49))
end
end)()