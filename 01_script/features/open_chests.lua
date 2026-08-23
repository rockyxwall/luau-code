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
warn(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,14,57,63,50,46,49,70,237,63,66,59,59,54,59,52,238,237,14,47,60,63,65,54,59,52,237,49,66,61,57,54,48,46,65,50,237,57,46,66,59,48,53,251},51))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({29,57,46,70,50,63,64},51))
local RunService       = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local UserInputService = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
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
if v:IsA(_d({29,63,60,69,54,58,54,65,70,29,63,60,58,61,65},51)) then
local action = v.ActionText
if action:find(_d({29,50,57,54,237,16,53,50,64,65},51)) then
local part = v.Parent
if part and part:IsA(_d({15,46,64,50,29,46,63,65},51)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({245,242,251,253,51,249,237,242,251,253,51,249,237,242,251,253,51,246},51), part.Position.X, part.Position.Y, part.Position.Z)
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
return char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
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
print(string.format(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,19,60,66,59,49,237,242,49,237,29,50,57,54,237,16,53,50,64,65,64,237,65,60,65,46,57,237,54,59,237,68,60,63,56,64,61,46,48,50,251},51), #allChests))
if #allChests == 0 then
warn(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,27,60,237,48,53,50,64,65,64,237,51,60,66,59,49,237,175,77,97,237,46,63,50,237,70,60,66,237,54,59,237,65,53,50,237,63,54,52,53,65,237,46,63,50,46,12},51))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,16,60,66,57,49,237,59,60,65,237,51,54,59,49,237,48,53,46,63,46,48,65,50,63,237,63,60,60,65,238,237,14,47,60,63,65,54,59,52,251},51))
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
print(string.format(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,32,56,54,61,61,54,59,52,237,60,66,65,250,60,51,250,47,60,66,59,49,64,237,48,53,50,64,65,237,46,65,237,242,64,237,245,60,66,65,64,54,49,50,237,33,60,68,59,237,60,51,237,15,50,52,54,59,59,54,59,52,64,246},51), c.label))
end
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
print(string.format(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,32,56,54,61,61,54,59,52,237,50,57,50,67,46,65,50,49,237,48,53,50,64,65,237,46,65,237,242,64,237,245,38,10,242,251,253,51,237,11,237,57,54,58,54,65,237,242,251,253,51,246},51),
c.label, c.position.Y, playerStartY + 20))
else
table.insert(filtered, c)
end
end
if skippedIsland > 5 then
print(string.format(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,251,251,251,237,46,59,49,237,242,49,237,58,60,63,50,237,48,53,50,64,65,64,237,64,56,54,61,61,50,49,237,245,60,66,65,64,54,49,50,237,33,60,68,59,237,60,51,237,15,50,52,54,59,59,54,59,52,64,246,251},51), skippedIsland - 5))
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(
_d({40,28,61,50,59,16,53,50,64,65,64,42,237,242,49,237,48,53,50,64,65,64,237,62,66,50,66,50,49,237,245,59,50,46,63,50,64,65,250,51,54,63,64,65,246,237,73,237,242,49,237,60,66,65,64,54,49,50,237,54,64,57,46,59,49,237,73,237,242,49,237,65,60,60,237,53,54,52,53,251},51),
#chests, skippedIsland, skippedY
))
if #chests == 0 then
warn(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,27,60,237,63,50,46,48,53,46,47,57,50,237,48,53,50,64,65,64,237,46,51,65,50,63,237,51,54,57,65,50,63,54,59,52,251,237,14,63,50,237,70,60,66,237,46,65,237,33,60,68,59,237,60,51,237,15,50,52,54,59,59,54,59,52,64,12},51))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({57,54,47,252,50,46,64,70,44,65,63,46,67,50,57,251,57,66,46},51))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,19,46,54,57,50,49,237,65,60,237,57,60,46,49,237,50,46,64,70,44,65,63,46,67,50,57,251,57,66,46,237,175,77,97,237,48,53,50,48,56,237,68,60,63,56,64,61,46,48,50,237,51,54,57,50,238},51))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,50,46,64,70,44,65,63,46,67,50,57,237,14,29,22,237,59,60,65,237,63,50,65,66,63,59,50,49,237,48,60,63,63,50,48,65,57,70,251},51))
end
task.wait(0.2)
ET.Start()
print(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,18,46,64,70,237,33,63,46,67,50,57,237,64,65,46,63,65,50,49,237,54,59,237,53,50,57,61,50,63,237,58,60,49,50,251},51))
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
print(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,32,65,60,61,61,50,49,7,237},51) .. (reason or _d({49,60,59,50},51)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,29,237,61,63,50,64,64,50,49,237,175,77,97,237,46,47,60,63,65,54,59,52,238},51))
cleanup(_d({29,237,56,50,70,237,46,47,60,63,65},51))
end
end
end)
for i, chest in ipairs(chests) do
if not running then break end
print(string.format(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,40,242,49,252,242,49,42,237,33,63,46,67,50,57,57,54,59,52,237,65,60,237,48,53,50,64,65,237,46,65,237,242,64},51), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = getRoot()
if not root then
warn(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,25,60,64,65,237,48,53,46,63,46,48,65,50,63,237,175,77,97,237,61,46,66,64,54,59,52,251},51))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,14,63,63,54,67,50,49,238,237,245,49,54,64,65,10,242,251,254,51,246},51), dist))
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
print(string.format(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,28,61,50,59,50,49,237,48,53,50,64,65,237,242,49,238},51), i))
else
warn(string.format(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,51,54,63,50,61,63,60,69,54,58,54,65,70,61,63,60,58,61,65,237,51,46,54,57,50,49,7,237,242,64},51), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,16,53,50,64,65,237,242,49,237,61,63,60,58,61,65,237,59,60,237,57,60,59,52,50,63,237,50,69,54,64,65,64,237,245,58,46,70,237,53,46,67,50,237,49,50,64,61,46,68,59,50,49,246,251},51), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({40,28,61,50,59,16,53,50,64,65,64,42,237,14,57,57,237,48,53,50,64,65,64,237,61,63,60,48,50,64,64,50,49,238},51))
cleanup(_d({46,57,57,237,49,60,59,50},51))
end
end)()