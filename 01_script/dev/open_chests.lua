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
warn(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,26,69,75,62,58,61,82,249,75,78,71,71,66,71,64,250,249,26,59,72,75,77,66,71,64,249,61,78,73,69,66,60,58,77,62,249,69,58,78,71,60,65,7},39))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({41,69,58,82,62,75,76},39))
local RunService       = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local UserInputService = game:GetService(_d({46,76,62,75,34,71,73,78,77,44,62,75,79,66,60,62},39))
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
if v:IsA(_d({41,75,72,81,66,70,66,77,82,41,75,72,70,73,77},39)) then
local action = v.ActionText
if action:find(_d({41,62,69,66,249,28,65,62,76,77},39)) then
local part = v.Parent
if part and part:IsA(_d({27,58,76,62,41,58,75,77},39)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({1,254,7,9,63,5,249,254,7,9,63,5,249,254,7,9,63,2},39), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
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
print(string.format(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,31,72,78,71,61,249,254,61,249,41,62,69,66,249,28,65,62,76,77,76,7},39), #chests))
if #chests == 0 then
warn(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,39,72,249,60,65,62,76,77,76,249,63,72,78,71,61,249,187,89,109,249,58,75,62,249,82,72,78,249,66,71,249,77,65,62,249,75,66,64,65,77,249,58,75,62,58,24},39))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,28,72,78,69,61,249,71,72,77,249,63,66,71,61,249,60,65,58,75,58,60,77,62,75,249,75,72,72,77,250,249,26,59,72,75,77,66,71,64,7},39))
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
print(string.format(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,44,68,66,73,73,66,71,64,249,62,69,62,79,58,77,62,61,249,60,65,62,76,77,249,58,77,249,254,76,249,1,50,22,254,7,9,63,249,23,249,69,66,70,66,77,249,254,7,9,63,2},39),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,254,61,249,60,65,62,76,77,76,249,74,78,62,78,62,61,249,1,71,62,58,75,62,76,77,6,63,66,75,76,77,5,249,58,63,77,62,75,249,50,249,63,66,69,77,62,75,2,7},39), #chests))
if #chests == 0 then
warn(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,39,72,249,75,62,58,60,65,58,59,69,62,249,60,65,62,76,77,76,249,58,63,77,62,75,249,63,66,69,77,62,75,66,71,64,7},39))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({69,66,59,8,62,58,76,82,56,77,75,58,79,62,69,7,69,78,58},39))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,31,58,66,69,62,61,249,77,72,249,69,72,58,61,249,62,58,76,82,56,77,75,58,79,62,69,7,69,78,58,249,187,89,109,249,60,65,62,60,68,249,80,72,75,68,76,73,58,60,62,249,63,66,69,62,250},39))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,62,58,76,82,56,77,75,58,79,62,69,249,26,41,34,249,71,72,77,249,75,62,77,78,75,71,62,61,249,60,72,75,75,62,60,77,69,82,7},39))
end
task.wait(0.2)
ET.Start()
print(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,30,58,76,82,249,45,75,58,79,62,69,249,76,77,58,75,77,62,61,249,66,71,249,65,62,69,73,62,75,249,70,72,61,62,7},39))
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
print(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,44,77,72,73,73,62,61,19,249},39) .. (reason or _d({61,72,71,62},39)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,41,249,73,75,62,76,76,62,61,249,187,89,109,249,58,59,72,75,77,66,71,64,250},39))
cleanup(_d({41,249,68,62,82,249,58,59,72,75,77},39))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,52,254,61,8,254,61,54,249,45,75,58,79,62,69,69,66,71,64,249,77,72,249,60,65,62,76,77,249,58,77,249,254,76},39), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,37,72,76,77,249,60,65,58,75,58,60,77,62,75,249,187,89,109,249,73,58,78,76,66,71,64,7},39))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,26,75,75,66,79,62,61,250,249,1,61,66,76,77,22,254,7,10,63,2},39), dist))
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
print(string.format(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,40,73,62,71,62,61,249,60,65,62,76,77,249,254,61,250},39), i))
else
warn(string.format(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,63,66,75,62,73,75,72,81,66,70,66,77,82,73,75,72,70,73,77,249,63,58,66,69,62,61,19,249,254,76},39), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,28,65,62,76,77,249,254,61,249,73,75,72,70,73,77,249,71,72,249,69,72,71,64,62,75,249,62,81,66,76,77,76,249,1,70,58,82,249,65,58,79,62,249,61,62,76,73,58,80,71,62,61,2,7},39), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({52,40,73,62,71,28,65,62,76,77,76,54,249,26,69,69,249,60,65,62,76,77,76,249,73,75,72,60,62,76,76,62,61,250},39))
cleanup(_d({58,69,69,249,61,72,71,62},39))
end
end)()