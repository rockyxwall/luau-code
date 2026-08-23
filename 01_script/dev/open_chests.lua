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
warn(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,32,75,81,68,64,67,88,255,81,84,77,77,72,77,70,0,255,32,65,78,81,83,72,77,70,255,67,84,79,75,72,66,64,83,68,255,75,64,84,77,66,71,13},33))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({47,75,64,88,68,81,82},33))
local RunService       = game:GetService(_d({49,84,77,50,68,81,85,72,66,68},33))
local UserInputService = game:GetService(_d({52,82,68,81,40,77,79,84,83,50,68,81,85,72,66,68},33))
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
if v:IsA(_d({47,81,78,87,72,76,72,83,88,47,81,78,76,79,83},33)) then
local action = v.ActionText
if action:find(_d({47,68,75,72,255,34,71,68,82,83},33)) then
local part = v.Parent
if part and part:IsA(_d({33,64,82,68,47,64,81,83},33)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({7,4,13,15,69,11,255,4,13,15,69,11,255,4,13,15,69,8},33), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
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
print(string.format(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,37,78,84,77,67,255,4,67,255,47,68,75,72,255,34,71,68,82,83,82,13},33), #chests))
if #chests == 0 then
warn(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,45,78,255,66,71,68,82,83,82,255,69,78,84,77,67,255,193,95,115,255,64,81,68,255,88,78,84,255,72,77,255,83,71,68,255,81,72,70,71,83,255,64,81,68,64,30},33))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,34,78,84,75,67,255,77,78,83,255,69,72,77,67,255,66,71,64,81,64,66,83,68,81,255,81,78,78,83,0,255,32,65,78,81,83,72,77,70,13},33))
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
print(string.format(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,50,74,72,79,79,72,77,70,255,68,75,68,85,64,83,68,67,255,66,71,68,82,83,255,64,83,255,4,82,255,7,56,28,4,13,15,69,255,29,255,75,72,76,72,83,255,4,13,15,69,8},33),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,4,67,255,66,71,68,82,83,82,255,80,84,68,84,68,67,255,7,77,68,64,81,68,82,83,12,69,72,81,82,83,11,255,64,69,83,68,81,255,56,255,69,72,75,83,68,81,8,13},33), #chests))
if #chests == 0 then
warn(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,45,78,255,81,68,64,66,71,64,65,75,68,255,66,71,68,82,83,82,255,64,69,83,68,81,255,69,72,75,83,68,81,72,77,70,13},33))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({75,72,65,14,68,64,82,88,62,83,81,64,85,68,75,13,75,84,64},33))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,255,68,64,82,88,62,83,81,64,85,68,75,13,75,84,64,255,193,95,115,255,66,71,68,66,74,255,86,78,81,74,82,79,64,66,68,255,69,72,75,68,0},33))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,68,64,82,88,62,83,81,64,85,68,75,255,32,47,40,255,77,78,83,255,81,68,83,84,81,77,68,67,255,66,78,81,81,68,66,83,75,88,13},33))
end
task.wait(0.2)
ET.Start()
print(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,36,64,82,88,255,51,81,64,85,68,75,255,82,83,64,81,83,68,67,255,72,77,255,71,68,75,79,68,81,255,76,78,67,68,13},33))
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
print(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,50,83,78,79,79,68,67,25,255},33) .. (reason or _d({67,78,77,68},33)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,47,255,79,81,68,82,82,68,67,255,193,95,115,255,64,65,78,81,83,72,77,70,0},33))
cleanup(_d({47,255,74,68,88,255,64,65,78,81,83},33))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,58,4,67,14,4,67,60,255,51,81,64,85,68,75,75,72,77,70,255,83,78,255,66,71,68,82,83,255,64,83,255,4,82},33), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,43,78,82,83,255,66,71,64,81,64,66,83,68,81,255,193,95,115,255,79,64,84,82,72,77,70,13},33))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,32,81,81,72,85,68,67,0,255,7,67,72,82,83,28,4,13,16,69,8},33), dist))
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
print(string.format(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,46,79,68,77,68,67,255,66,71,68,82,83,255,4,67,0},33), i))
else
warn(string.format(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,69,72,81,68,79,81,78,87,72,76,72,83,88,79,81,78,76,79,83,255,69,64,72,75,68,67,25,255,4,82},33), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,34,71,68,82,83,255,4,67,255,79,81,78,76,79,83,255,77,78,255,75,78,77,70,68,81,255,68,87,72,82,83,82,255,7,76,64,88,255,71,64,85,68,255,67,68,82,79,64,86,77,68,67,8,13},33), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({58,46,79,68,77,34,71,68,82,83,82,60,255,32,75,75,255,66,71,68,82,83,82,255,79,81,78,66,68,82,82,68,67,0},33))
cleanup(_d({64,75,75,255,67,78,77,68},33))
end
end)()