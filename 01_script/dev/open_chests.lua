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
warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,29,72,78,65,61,64,85,252,78,81,74,74,69,74,67,253,252,29,62,75,78,80,69,74,67,252,64,81,76,72,69,63,61,80,65,252,72,61,81,74,63,68,10},36))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({44,72,61,85,65,78,79},36))
local RunService       = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
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
if v:IsA(_d({44,78,75,84,69,73,69,80,85,44,78,75,73,76,80},36)) then
local action = v.ActionText
if action:find(_d({44,65,72,69,252,31,68,65,79,80},36)) then
local part = v.Parent
if part and part:IsA(_d({30,61,79,65,44,61,78,80},36)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({4,1,10,12,66,8,252,1,10,12,66,8,252,1,10,12,66,5},36), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
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
print(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,34,75,81,74,64,252,1,64,252,44,65,72,69,252,31,68,65,79,80,79,10},36), #chests))
if #chests == 0 then
warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,42,75,252,63,68,65,79,80,79,252,66,75,81,74,64,252,190,92,112,252,61,78,65,252,85,75,81,252,69,74,252,80,68,65,252,78,69,67,68,80,252,61,78,65,61,27},36))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,63,68,61,78,61,63,80,65,78,252,78,75,75,80,253,252,29,62,75,78,80,69,74,67,10},36))
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
print(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,47,71,69,76,76,69,74,67,252,65,72,65,82,61,80,65,64,252,63,68,65,79,80,252,61,80,252,1,79,252,4,53,25,1,10,12,66,252,26,252,72,69,73,69,80,252,1,10,12,66,5},36),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,1,64,252,63,68,65,79,80,79,252,77,81,65,81,65,64,252,4,74,65,61,78,65,79,80,9,66,69,78,79,80,8,252,61,66,80,65,78,252,53,252,66,69,72,80,65,78,5,10},36), #chests))
if #chests == 0 then
warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,42,75,252,78,65,61,63,68,61,62,72,65,252,63,68,65,79,80,79,252,61,66,80,65,78,252,66,69,72,80,65,78,69,74,67,10},36))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,252,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61,252,190,92,112,252,63,68,65,63,71,252,83,75,78,71,79,76,61,63,65,252,66,69,72,65,253},36))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,65,61,79,85,59,80,78,61,82,65,72,252,29,44,37,252,74,75,80,252,78,65,80,81,78,74,65,64,252,63,75,78,78,65,63,80,72,85,10},36))
end
task.wait(0.2)
ET.Start()
print(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,33,61,79,85,252,48,78,61,82,65,72,252,79,80,61,78,80,65,64,252,69,74,252,68,65,72,76,65,78,252,73,75,64,65,10},36))
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
print(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,47,80,75,76,76,65,64,22,252},36) .. (reason or _d({64,75,74,65},36)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,44,252,76,78,65,79,79,65,64,252,190,92,112,252,61,62,75,78,80,69,74,67,253},36))
cleanup(_d({44,252,71,65,85,252,61,62,75,78,80},36))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,55,1,64,11,1,64,57,252,48,78,61,82,65,72,72,69,74,67,252,80,75,252,63,68,65,79,80,252,61,80,252,1,79},36), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,40,75,79,80,252,63,68,61,78,61,63,80,65,78,252,190,92,112,252,76,61,81,79,69,74,67,10},36))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,29,78,78,69,82,65,64,253,252,4,64,69,79,80,25,1,10,13,66,5},36), dist))
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
print(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,43,76,65,74,65,64,252,63,68,65,79,80,252,1,64,253},36), i))
else
warn(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,66,69,78,65,76,78,75,84,69,73,69,80,85,76,78,75,73,76,80,252,66,61,69,72,65,64,22,252,1,79},36), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,31,68,65,79,80,252,1,64,252,76,78,75,73,76,80,252,74,75,252,72,75,74,67,65,78,252,65,84,69,79,80,79,252,4,73,61,85,252,68,61,82,65,252,64,65,79,76,61,83,74,65,64,5,10},36), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,29,72,72,252,63,68,65,79,80,79,252,76,78,75,63,65,79,79,65,64,253},36))
cleanup(_d({61,72,72,252,64,75,74,65},36))
end
end)()