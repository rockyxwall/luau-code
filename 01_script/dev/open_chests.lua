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
warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,35,78,84,71,67,70,91,2,84,87,80,80,75,80,73,3,2,35,68,81,84,86,75,80,73,2,70,87,82,78,75,69,67,86,71,2,78,67,87,80,69,74,16},30))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({50,78,67,91,71,84,85},30))
local RunService       = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
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
if v:IsA(_d({50,84,81,90,75,79,75,86,91,50,84,81,79,82,86},30)) then
local action = v.ActionText
if action:find(_d({50,71,78,75,2,37,74,71,85,86},30)) then
local part = v.Parent
if part and part:IsA(_d({36,67,85,71,50,67,84,86},30)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({10,7,16,18,72,14,2,7,16,18,72,14,2,7,16,18,72,11},30), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
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
print(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,40,81,87,80,70,2,7,70,2,50,71,78,75,2,37,74,71,85,86,85,16},30), #chests))
if #chests == 0 then
warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,48,81,2,69,74,71,85,86,85,2,72,81,87,80,70,2,196,98,118,2,67,84,71,2,91,81,87,2,75,80,2,86,74,71,2,84,75,73,74,86,2,67,84,71,67,33},30))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,37,81,87,78,70,2,80,81,86,2,72,75,80,70,2,69,74,67,84,67,69,86,71,84,2,84,81,81,86,3,2,35,68,81,84,86,75,80,73,16},30))
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
print(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,53,77,75,82,82,75,80,73,2,71,78,71,88,67,86,71,70,2,69,74,71,85,86,2,67,86,2,7,85,2,10,59,31,7,16,18,72,2,32,2,78,75,79,75,86,2,7,16,18,72,11},30),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,7,70,2,69,74,71,85,86,85,2,83,87,71,87,71,70,2,10,80,71,67,84,71,85,86,15,72,75,84,85,86,14,2,67,72,86,71,84,2,59,2,72,75,78,86,71,84,11,16},30), #chests))
if #chests == 0 then
warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,48,81,2,84,71,67,69,74,67,68,78,71,2,69,74,71,85,86,85,2,67,72,86,71,84,2,72,75,78,86,71,84,75,80,73,16},30))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({78,75,68,17,71,67,85,91,65,86,84,67,88,71,78,16,78,87,67},30))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,2,71,67,85,91,65,86,84,67,88,71,78,16,78,87,67,2,196,98,118,2,69,74,71,69,77,2,89,81,84,77,85,82,67,69,71,2,72,75,78,71,3},30))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,71,67,85,91,65,86,84,67,88,71,78,2,35,50,43,2,80,81,86,2,84,71,86,87,84,80,71,70,2,69,81,84,84,71,69,86,78,91,16},30))
end
task.wait(0.2)
ET.Start()
print(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,39,67,85,91,2,54,84,67,88,71,78,2,85,86,67,84,86,71,70,2,75,80,2,74,71,78,82,71,84,2,79,81,70,71,16},30))
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
print(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,53,86,81,82,82,71,70,28,2},30) .. (reason or _d({70,81,80,71},30)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,50,2,82,84,71,85,85,71,70,2,196,98,118,2,67,68,81,84,86,75,80,73,3},30))
cleanup(_d({50,2,77,71,91,2,67,68,81,84,86},30))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,61,7,70,17,7,70,63,2,54,84,67,88,71,78,78,75,80,73,2,86,81,2,69,74,71,85,86,2,67,86,2,7,85},30), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,46,81,85,86,2,69,74,67,84,67,69,86,71,84,2,196,98,118,2,82,67,87,85,75,80,73,16},30))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,35,84,84,75,88,71,70,3,2,10,70,75,85,86,31,7,16,19,72,11},30), dist))
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
print(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,49,82,71,80,71,70,2,69,74,71,85,86,2,7,70,3},30), i))
else
warn(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,72,75,84,71,82,84,81,90,75,79,75,86,91,82,84,81,79,82,86,2,72,67,75,78,71,70,28,2,7,85},30), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,37,74,71,85,86,2,7,70,2,82,84,81,79,82,86,2,80,81,2,78,81,80,73,71,84,2,71,90,75,85,86,85,2,10,79,67,91,2,74,67,88,71,2,70,71,85,82,67,89,80,71,70,11,16},30), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,35,78,78,2,69,74,71,85,86,85,2,82,84,81,69,71,85,85,71,70,3},30))
cleanup(_d({67,78,78,2,70,81,80,71},30))
end
end)()