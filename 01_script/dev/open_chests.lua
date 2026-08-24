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
warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,1,44,50,37,33,36,57,224,50,53,46,46,41,46,39,225,224,1,34,47,50,52,41,46,39,224,36,53,48,44,41,35,33,52,37,224,44,33,53,46,35,40,238},64))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({16,44,33,57,37,50,51},64))
local RunService       = game:GetService(_d({18,53,46,19,37,50,54,41,35,37},64))
local UserInputService = game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64))
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
if v:IsA(_d({16,50,47,56,41,45,41,52,57,16,50,47,45,48,52},64)) then
local action = v.ActionText
if action:find(_d({16,37,44,41,224,3,40,37,51,52},64)) then
local part = v.Parent
if part and part:IsA(_d({2,33,51,37,16,33,50,52},64)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({232,229,238,240,38,236,224,229,238,240,38,236,224,229,238,240,38,233},64), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
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
print(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,6,47,53,46,36,224,229,36,224,16,37,44,41,224,3,40,37,51,52,51,238},64), #chests))
if #chests == 0 then
warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,14,47,224,35,40,37,51,52,51,224,38,47,53,46,36,224,162,64,84,224,33,50,37,224,57,47,53,224,41,46,224,52,40,37,224,50,41,39,40,52,224,33,50,37,33,255},64))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,3,47,53,44,36,224,46,47,52,224,38,41,46,36,224,35,40,33,50,33,35,52,37,50,224,50,47,47,52,225,224,1,34,47,50,52,41,46,39,238},64))
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
print(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,19,43,41,48,48,41,46,39,224,37,44,37,54,33,52,37,36,224,35,40,37,51,52,224,33,52,224,229,51,224,232,25,253,229,238,240,38,224,254,224,44,41,45,41,52,224,229,238,240,38,233},64),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,229,36,224,35,40,37,51,52,51,224,49,53,37,53,37,36,224,232,46,37,33,50,37,51,52,237,38,41,50,51,52,236,224,33,38,52,37,50,224,25,224,38,41,44,52,37,50,233,238},64), #chests))
if #chests == 0 then
warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,14,47,224,50,37,33,35,40,33,34,44,37,224,35,40,37,51,52,51,224,33,38,52,37,50,224,38,41,44,52,37,50,41,46,39,238},64))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({44,41,34,239,37,33,51,57,31,52,50,33,54,37,44,238,44,53,33},64))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,224,37,33,51,57,31,52,50,33,54,37,44,238,44,53,33,224,162,64,84,224,35,40,37,35,43,224,55,47,50,43,51,48,33,35,37,224,38,41,44,37,225},64))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,37,33,51,57,31,52,50,33,54,37,44,224,1,16,9,224,46,47,52,224,50,37,52,53,50,46,37,36,224,35,47,50,50,37,35,52,44,57,238},64))
end
task.wait(0.2)
ET.Start()
print(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,5,33,51,57,224,20,50,33,54,37,44,224,51,52,33,50,52,37,36,224,41,46,224,40,37,44,48,37,50,224,45,47,36,37,238},64))
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
print(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,19,52,47,48,48,37,36,250,224},64) .. (reason or _d({36,47,46,37},64)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,16,224,48,50,37,51,51,37,36,224,162,64,84,224,33,34,47,50,52,41,46,39,225},64))
cleanup(_d({16,224,43,37,57,224,33,34,47,50,52},64))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,27,229,36,239,229,36,29,224,20,50,33,54,37,44,44,41,46,39,224,52,47,224,35,40,37,51,52,224,33,52,224,229,51},64), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,12,47,51,52,224,35,40,33,50,33,35,52,37,50,224,162,64,84,224,48,33,53,51,41,46,39,238},64))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,1,50,50,41,54,37,36,225,224,232,36,41,51,52,253,229,238,241,38,233},64), dist))
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
print(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,15,48,37,46,37,36,224,35,40,37,51,52,224,229,36,225},64), i))
else
warn(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,38,41,50,37,48,50,47,56,41,45,41,52,57,48,50,47,45,48,52,224,38,33,41,44,37,36,250,224,229,51},64), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,3,40,37,51,52,224,229,36,224,48,50,47,45,48,52,224,46,47,224,44,47,46,39,37,50,224,37,56,41,51,52,51,224,232,45,33,57,224,40,33,54,37,224,36,37,51,48,33,55,46,37,36,233,238},64), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({27,15,48,37,46,3,40,37,51,52,51,29,224,1,44,44,224,35,40,37,51,52,51,224,48,50,47,35,37,51,51,37,36,225},64))
cleanup(_d({33,44,44,224,36,47,46,37},64))
end
end)()