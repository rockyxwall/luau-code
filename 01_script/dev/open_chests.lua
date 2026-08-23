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
warn(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,7,50,56,43,39,42,63,230,56,59,52,52,47,52,45,231,230,7,40,53,56,58,47,52,45,230,42,59,54,50,47,41,39,58,43,230,50,39,59,52,41,46,244},58))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({22,50,39,63,43,56,57},58))
local RunService       = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
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
if v:IsA(_d({22,56,53,62,47,51,47,58,63,22,56,53,51,54,58},58)) then
local action = v.ActionText
if action:find(_d({22,43,50,47,230,9,46,43,57,58},58)) then
local part = v.Parent
if part and part:IsA(_d({8,39,57,43,22,39,56,58},58)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({238,235,244,246,44,242,230,235,244,246,44,242,230,235,244,246,44,239},58), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
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
print(string.format(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,12,53,59,52,42,230,235,42,230,22,43,50,47,230,9,46,43,57,58,57,244},58), #chests))
if #chests == 0 then
warn(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,20,53,230,41,46,43,57,58,57,230,44,53,59,52,42,230,168,70,90,230,39,56,43,230,63,53,59,230,47,52,230,58,46,43,230,56,47,45,46,58,230,39,56,43,39,5},58))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,9,53,59,50,42,230,52,53,58,230,44,47,52,42,230,41,46,39,56,39,41,58,43,56,230,56,53,53,58,231,230,7,40,53,56,58,47,52,45,244},58))
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
print(string.format(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,25,49,47,54,54,47,52,45,230,43,50,43,60,39,58,43,42,230,41,46,43,57,58,230,39,58,230,235,57,230,238,31,3,235,244,246,44,230,4,230,50,47,51,47,58,230,235,244,246,44,239},58),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,235,42,230,41,46,43,57,58,57,230,55,59,43,59,43,42,230,238,52,43,39,56,43,57,58,243,44,47,56,57,58,242,230,39,44,58,43,56,230,31,230,44,47,50,58,43,56,239,244},58), #chests))
if #chests == 0 then
warn(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,20,53,230,56,43,39,41,46,39,40,50,43,230,41,46,43,57,58,57,230,39,44,58,43,56,230,44,47,50,58,43,56,47,52,45,244},58))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({50,47,40,245,43,39,57,63,37,58,56,39,60,43,50,244,50,59,39},58))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,230,43,39,57,63,37,58,56,39,60,43,50,244,50,59,39,230,168,70,90,230,41,46,43,41,49,230,61,53,56,49,57,54,39,41,43,230,44,47,50,43,231},58))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,43,39,57,63,37,58,56,39,60,43,50,230,7,22,15,230,52,53,58,230,56,43,58,59,56,52,43,42,230,41,53,56,56,43,41,58,50,63,244},58))
end
task.wait(0.2)
ET.Start()
print(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,11,39,57,63,230,26,56,39,60,43,50,230,57,58,39,56,58,43,42,230,47,52,230,46,43,50,54,43,56,230,51,53,42,43,244},58))
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
print(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,25,58,53,54,54,43,42,0,230},58) .. (reason or _d({42,53,52,43},58)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,22,230,54,56,43,57,57,43,42,230,168,70,90,230,39,40,53,56,58,47,52,45,231},58))
cleanup(_d({22,230,49,43,63,230,39,40,53,56,58},58))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,33,235,42,245,235,42,35,230,26,56,39,60,43,50,50,47,52,45,230,58,53,230,41,46,43,57,58,230,39,58,230,235,57},58), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,18,53,57,58,230,41,46,39,56,39,41,58,43,56,230,168,70,90,230,54,39,59,57,47,52,45,244},58))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,7,56,56,47,60,43,42,231,230,238,42,47,57,58,3,235,244,247,44,239},58), dist))
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
print(string.format(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,21,54,43,52,43,42,230,41,46,43,57,58,230,235,42,231},58), i))
else
warn(string.format(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,44,47,56,43,54,56,53,62,47,51,47,58,63,54,56,53,51,54,58,230,44,39,47,50,43,42,0,230,235,57},58), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,9,46,43,57,58,230,235,42,230,54,56,53,51,54,58,230,52,53,230,50,53,52,45,43,56,230,43,62,47,57,58,57,230,238,51,39,63,230,46,39,60,43,230,42,43,57,54,39,61,52,43,42,239,244},58), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({33,21,54,43,52,9,46,43,57,58,57,35,230,7,50,50,230,41,46,43,57,58,57,230,54,56,53,41,43,57,57,43,42,231},58))
cleanup(_d({39,50,50,230,42,53,52,43},58))
end
end)()