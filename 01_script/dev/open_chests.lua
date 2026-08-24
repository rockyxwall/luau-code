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
warn(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,20,63,69,56,52,55,76,243,69,72,65,65,60,65,58,244,243,20,53,66,69,71,60,65,58,243,55,72,67,63,60,54,52,71,56,243,63,52,72,65,54,59,1},45))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({35,63,52,76,56,69,70},45))
local RunService       = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
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
if v:IsA(_d({35,69,66,75,60,64,60,71,76,35,69,66,64,67,71},45)) then
local action = v.ActionText
if action:find(_d({35,56,63,60,243,22,59,56,70,71},45)) then
local part = v.Parent
if part and part:IsA(_d({21,52,70,56,35,52,69,71},45)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({251,248,1,3,57,255,243,248,1,3,57,255,243,248,1,3,57,252},45), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
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
print(string.format(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,25,66,72,65,55,243,248,55,243,35,56,63,60,243,22,59,56,70,71,70,1},45), #chests))
if #chests == 0 then
warn(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,33,66,243,54,59,56,70,71,70,243,57,66,72,65,55,243,181,83,103,243,52,69,56,243,76,66,72,243,60,65,243,71,59,56,243,69,60,58,59,71,243,52,69,56,52,18},45))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,22,66,72,63,55,243,65,66,71,243,57,60,65,55,243,54,59,52,69,52,54,71,56,69,243,69,66,66,71,244,243,20,53,66,69,71,60,65,58,1},45))
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
print(string.format(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,38,62,60,67,67,60,65,58,243,56,63,56,73,52,71,56,55,243,54,59,56,70,71,243,52,71,243,248,70,243,251,44,16,248,1,3,57,243,17,243,63,60,64,60,71,243,248,1,3,57,252},45),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,248,55,243,54,59,56,70,71,70,243,68,72,56,72,56,55,243,251,65,56,52,69,56,70,71,0,57,60,69,70,71,255,243,52,57,71,56,69,243,44,243,57,60,63,71,56,69,252,1},45), #chests))
if #chests == 0 then
warn(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,33,66,243,69,56,52,54,59,52,53,63,56,243,54,59,56,70,71,70,243,52,57,71,56,69,243,57,60,63,71,56,69,60,65,58,1},45))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,243,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52,243,181,83,103,243,54,59,56,54,62,243,74,66,69,62,70,67,52,54,56,243,57,60,63,56,244},45))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,56,52,70,76,50,71,69,52,73,56,63,243,20,35,28,243,65,66,71,243,69,56,71,72,69,65,56,55,243,54,66,69,69,56,54,71,63,76,1},45))
end
task.wait(0.2)
ET.Start()
print(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,24,52,70,76,243,39,69,52,73,56,63,243,70,71,52,69,71,56,55,243,60,65,243,59,56,63,67,56,69,243,64,66,55,56,1},45))
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
print(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,38,71,66,67,67,56,55,13,243},45) .. (reason or _d({55,66,65,56},45)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,35,243,67,69,56,70,70,56,55,243,181,83,103,243,52,53,66,69,71,60,65,58,244},45))
cleanup(_d({35,243,62,56,76,243,52,53,66,69,71},45))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,46,248,55,2,248,55,48,243,39,69,52,73,56,63,63,60,65,58,243,71,66,243,54,59,56,70,71,243,52,71,243,248,70},45), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,31,66,70,71,243,54,59,52,69,52,54,71,56,69,243,181,83,103,243,67,52,72,70,60,65,58,1},45))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,20,69,69,60,73,56,55,244,243,251,55,60,70,71,16,248,1,4,57,252},45), dist))
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
print(string.format(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,34,67,56,65,56,55,243,54,59,56,70,71,243,248,55,244},45), i))
else
warn(string.format(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,57,60,69,56,67,69,66,75,60,64,60,71,76,67,69,66,64,67,71,243,57,52,60,63,56,55,13,243,248,70},45), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,22,59,56,70,71,243,248,55,243,67,69,66,64,67,71,243,65,66,243,63,66,65,58,56,69,243,56,75,60,70,71,70,243,251,64,52,76,243,59,52,73,56,243,55,56,70,67,52,74,65,56,55,252,1},45), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({46,34,67,56,65,22,59,56,70,71,70,48,243,20,63,63,243,54,59,56,70,71,70,243,67,69,66,54,56,70,70,56,55,244},45))
cleanup(_d({52,63,63,243,55,66,65,56},45))
end
end)()