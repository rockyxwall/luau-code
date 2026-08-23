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
warn(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,13,56,62,49,45,48,69,236,62,65,58,58,53,58,51,237,236,13,46,59,62,64,53,58,51,236,48,65,60,56,53,47,45,64,49,236,56,45,65,58,47,52,250},52))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({28,56,45,69,49,62,63},52))
local RunService       = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local LocalPlayer      = Players.LocalPlayer
local running = true
local ARRIVE_DIST      = 6
local TIMEOUT_PER_CHEST = 20
local OPEN_WAIT        = 2.5
local TRAVEL_HEIGHT    = 4
local CHECK_HZ         = 0.1
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(position)
return position.X >= ISLAND_MIN_X and position.X <= ISLAND_MAX_X
and position.Z >= ISLAND_MIN_Z and position.Z <= ISLAND_MAX_Z
end
local function collectChests()
local chests = {}
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA(_d({28,62,59,68,53,57,53,64,69,28,62,59,57,60,64},52)) then
local action = v.ActionText
if action:find(_d({28,49,56,53,236,15,52,49,63,64},52)) then
local part = v.Parent
if part and part:IsA(_d({14,45,63,49,28,45,62,64},52)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({244,241,250,252,50,248,236,241,250,252,50,248,236,241,250,252,50,245},52), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
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
local allChests = collectChests()
print(string.format(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,18,59,65,58,48,236,241,48,236,28,49,56,53,236,15,52,49,63,64,63,236,64,59,64,45,56,236,53,58,236,67,59,62,55,63,60,45,47,49,250},52), #allChests))
if #allChests == 0 then
warn(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,26,59,236,47,52,49,63,64,63,236,50,59,65,58,48,236,174,76,96,236,45,62,49,236,69,59,65,236,53,58,236,64,52,49,236,62,53,51,52,64,236,45,62,49,45,11},52))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,47,52,45,62,45,47,64,49,62,236,62,59,59,64,237,236,13,46,59,62,64,53,58,51,250},52))
_G.OpenChestsRunning = false
return
end
local playerStartPos = startRoot.Position
local playerStartY   = playerStartPos.Y
local filtered = {}
local skippedIsland = 0
local skippedY      = 0
for _, c in ipairs(allChests) do
if not isInsideTownOfBeginnings(c.position) then
skippedIsland = skippedIsland + 1
if skippedIsland <= 5 then
print(string.format(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,31,55,53,60,60,53,58,51,236,59,65,64,249,59,50,249,46,59,65,58,48,63,236,47,52,49,63,64,236,45,64,236,241,63,236,244,59,65,64,63,53,48,49,236,32,59,67,58,236,59,50,236,14,49,51,53,58,58,53,58,51,63,245},52), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,31,55,53,60,60,53,58,51,236,49,56,49,66,45,64,49,48,236,47,52,49,63,64,236,45,64,236,241,63,236,244,37,9,241,250,252,50,236,10,236,56,53,57,53,64,236,241,250,252,50,245},52),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,250,250,250,236,45,58,48,236,241,48,236,57,59,62,49,236,47,52,49,63,64,63,236,63,55,53,60,60,49,48,236,244,59,65,64,63,53,48,49,236,32,59,67,58,236,59,50,236,14,49,51,53,58,58,53,58,51,63,245,250},52), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({39,27,60,49,58,15,52,49,63,64,63,41,236,241,48,236,47,52,49,63,64,63,236,61,65,49,65,49,48,236,244,58,49,45,62,49,63,64,249,50,53,62,63,64,245,236,72,236,241,48,236,59,65,64,63,53,48,49,236,53,63,56,45,58,48,236,72,236,241,48,236,64,59,59,236,52,53,51,52,250},52),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,26,59,236,62,49,45,47,52,45,46,56,49,236,47,52,49,63,64,63,236,45,50,64,49,62,236,50,53,56,64,49,62,53,58,51,250,236,13,62,49,236,69,59,65,236,45,64,236,32,59,67,58,236,59,50,236,14,49,51,53,58,58,53,58,51,63,11},52))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({56,53,46,251,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45},52))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,236,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45,236,174,76,96,236,47,52,49,47,55,236,67,59,62,55,63,60,45,47,49,236,50,53,56,49,237},52))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,49,45,63,69,43,64,62,45,66,49,56,236,13,28,21,236,58,59,64,236,62,49,64,65,62,58,49,48,236,47,59,62,62,49,47,64,56,69,250},52))
end
task.wait(0.2)
ET.Start()
print(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,17,45,63,69,236,32,62,45,66,49,56,236,63,64,45,62,64,49,48,236,53,58,236,52,49,56,60,49,62,236,57,59,48,49,250},52))
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
print(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,31,64,59,60,60,49,48,6,236},52) .. (reason or _d({48,59,58,49},52)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,28,236,60,62,49,63,63,49,48,236,174,76,96,236,45,46,59,62,64,53,58,51,237},52))
cleanup(_d({28,236,55,49,69,236,45,46,59,62,64},52))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,39,241,48,251,241,48,41,236,32,62,45,66,49,56,56,53,58,51,236,64,59,236,47,52,49,63,64,236,45,64,236,241,63},52), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,24,59,63,64,236,47,52,45,62,45,47,64,49,62,236,174,76,96,236,60,45,65,63,53,58,51,250},52))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,13,62,62,53,66,49,48,237,236,244,48,53,63,64,9,241,250,253,50,245},52), dist))
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
print(string.format(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,27,60,49,58,49,48,236,47,52,49,63,64,236,241,48,237},52), i))
else
warn(string.format(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,50,53,62,49,60,62,59,68,53,57,53,64,69,60,62,59,57,60,64,236,50,45,53,56,49,48,6,236,241,63},52), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,15,52,49,63,64,236,241,48,236,60,62,59,57,60,64,236,58,59,236,56,59,58,51,49,62,236,49,68,53,63,64,63,236,244,57,45,69,236,52,45,66,49,236,48,49,63,60,45,67,58,49,48,245,250},52), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({39,27,60,49,58,15,52,49,63,64,63,41,236,13,56,56,236,47,52,49,63,64,63,236,60,62,59,47,49,63,63,49,48,237},52))
cleanup(_d({45,56,56,236,48,59,58,49},52))
end
end)()