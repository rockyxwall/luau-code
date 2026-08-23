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
warn(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,23,66,72,59,55,58,79,246,72,75,68,68,63,68,61,247,246,23,56,69,72,74,63,68,61,246,58,75,70,66,63,57,55,74,59,246,66,55,75,68,57,62,4},42))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({38,66,55,79,59,72,73},42))
local RunService       = game:GetService(_d({40,75,68,41,59,72,76,63,57,59},42))
local UserInputService = game:GetService(_d({43,73,59,72,31,68,70,75,74,41,59,72,76,63,57,59},42))
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
if v:IsA(_d({38,72,69,78,63,67,63,74,79,38,72,69,67,70,74},42)) then
local action = v.ActionText
if action:find(_d({38,59,66,63,246,25,62,59,73,74},42)) then
local part = v.Parent
if part and part:IsA(_d({24,55,73,59,38,55,72,74},42)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({254,251,4,6,60,2,246,251,4,6,60,2,246,251,4,6,60,255},42), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
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
print(string.format(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,28,69,75,68,58,246,251,58,246,38,59,66,63,246,25,62,59,73,74,73,4},42), #chests))
if #chests == 0 then
warn(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,36,69,246,57,62,59,73,74,73,246,60,69,75,68,58,246,184,86,106,246,55,72,59,246,79,69,75,246,63,68,246,74,62,59,246,72,63,61,62,74,246,55,72,59,55,21},42))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,25,69,75,66,58,246,68,69,74,246,60,63,68,58,246,57,62,55,72,55,57,74,59,72,246,72,69,69,74,247,246,23,56,69,72,74,63,68,61,4},42))
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
print(string.format(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,41,65,63,70,70,63,68,61,246,59,66,59,76,55,74,59,58,246,57,62,59,73,74,246,55,74,246,251,73,246,254,47,19,251,4,6,60,246,20,246,66,63,67,63,74,246,251,4,6,60,255},42),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,251,58,246,57,62,59,73,74,73,246,71,75,59,75,59,58,246,254,68,59,55,72,59,73,74,3,60,63,72,73,74,2,246,55,60,74,59,72,246,47,246,60,63,66,74,59,72,255,4},42), #chests))
if #chests == 0 then
warn(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,36,69,246,72,59,55,57,62,55,56,66,59,246,57,62,59,73,74,73,246,55,60,74,59,72,246,60,63,66,74,59,72,63,68,61,4},42))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({66,63,56,5,59,55,73,79,53,74,72,55,76,59,66,4,66,75,55},42))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,246,59,55,73,79,53,74,72,55,76,59,66,4,66,75,55,246,184,86,106,246,57,62,59,57,65,246,77,69,72,65,73,70,55,57,59,246,60,63,66,59,247},42))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,59,55,73,79,53,74,72,55,76,59,66,246,23,38,31,246,68,69,74,246,72,59,74,75,72,68,59,58,246,57,69,72,72,59,57,74,66,79,4},42))
end
task.wait(0.2)
ET.Start()
print(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,27,55,73,79,246,42,72,55,76,59,66,246,73,74,55,72,74,59,58,246,63,68,246,62,59,66,70,59,72,246,67,69,58,59,4},42))
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
print(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,41,74,69,70,70,59,58,16,246},42) .. (reason or _d({58,69,68,59},42)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,38,246,70,72,59,73,73,59,58,246,184,86,106,246,55,56,69,72,74,63,68,61,247},42))
cleanup(_d({38,246,65,59,79,246,55,56,69,72,74},42))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,49,251,58,5,251,58,51,246,42,72,55,76,59,66,66,63,68,61,246,74,69,246,57,62,59,73,74,246,55,74,246,251,73},42), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,34,69,73,74,246,57,62,55,72,55,57,74,59,72,246,184,86,106,246,70,55,75,73,63,68,61,4},42))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,23,72,72,63,76,59,58,247,246,254,58,63,73,74,19,251,4,7,60,255},42), dist))
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
print(string.format(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,37,70,59,68,59,58,246,57,62,59,73,74,246,251,58,247},42), i))
else
warn(string.format(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,60,63,72,59,70,72,69,78,63,67,63,74,79,70,72,69,67,70,74,246,60,55,63,66,59,58,16,246,251,73},42), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,25,62,59,73,74,246,251,58,246,70,72,69,67,70,74,246,68,69,246,66,69,68,61,59,72,246,59,78,63,73,74,73,246,254,67,55,79,246,62,55,76,59,246,58,59,73,70,55,77,68,59,58,255,4},42), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({49,37,70,59,68,25,62,59,73,74,73,51,246,23,66,66,246,57,62,59,73,74,73,246,70,72,69,57,59,73,73,59,58,247},42))
cleanup(_d({55,66,66,246,58,69,68,59},42))
end
end)()