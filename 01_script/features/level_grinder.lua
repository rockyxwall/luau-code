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
_G.EasyTravelHelperMode = true
if _G.GepoGrinderRunning then
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,30,73,79,66,62,65,86,253,79,82,75,75,70,75,68,254,253,30,63,76,79,81,70,75,68,253,65,82,77,73,70,64,62,81,66,253,73,62,82,75,64,69,11},35))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local running = true
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(pos)
return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X
and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
end
local function waitForGameLoad()
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,52,62,70,81,70,75,68,253,67,76,79,253,68,62,74,66,253,81,76,253,73,76,62,65,11,11,11},35))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)) do
task.wait(0.5)
end
local folderName = _d({48,81,62,81,80},35) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,48,81,62,81,80,253,67,76,73,65,66,79,253,75,76,81,253,67,76,82,75,65,253,70,75,253,47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66,254},35))
end
statsFolder:WaitForChild(_d({48,81,62,81,80},35), 10)
statsFolder:WaitForChild(_d({38,75,83,66,75,81,76,79,86},35), 10)
statsFolder:WaitForChild(_d({48,66,81,81,70,75,68,80},35), 10)
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,36,62,74,66,253,67,82,73,73,86,253,73,76,62,65,66,65,254},35))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({48,81,62,81,80},35) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({48,81,62,81,80},35)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({41,66,83,66,73},35)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({45,66,73,70},35)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({47,70,67,73,66},35)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({47,70,67,73,66},35)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({48,81,62,81,80},35) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({38,75,83,66,75,81,76,79,86},35)) and statsFolder.Inventory:FindFirstChild(_d({38,75,83,66,75,81,76,79,86},35))
if invVal then
return invVal.Value:find(_d({255,47,70,67,73,66,255},35)) ~= nil
end
return false
end
local function importLib(localPath, rawUrl)
local loaded = false
if isfile and readfile then
pcall(function()
if isfile(localPath) then
local content = readfile(localPath)
if content and content ~= "" then
loadstring(content)()
loaded = true
end
end
end)
end
if not loaded then
pcall(function()
loadstring(game:HttpGet(rawUrl))()
end)
end
end
local function navigateTo(targetPos)
if not _G.EasyTravel then
importLib(_d({73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35))
end
if _G.EasyTravel then
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
_G.EasyTravel.TargetPosition = targetPos
local myRoot = getRoot()
if myRoot and (targetPos - myRoot.Position).Magnitude <= 4.0 then
_G.EasyTravel.TargetPosition = nil
return true
end
else
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,60,36,11,34,62,80,86,49,79,62,83,66,73,253,70,80,253,74,70,80,80,70,75,68,11,253,32,62,75,75,76,81,253,75,62,83,70,68,62,81,66,11},35))
end
return false
end
local function stopNavigation()
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
end
local function getHotbarMapping()
local slots = {_d({55,66,79,76},35), _d({44,75,66},35), _d({49,84,76},35), _d({49,69,79,66,66},35), _d({35,76,82,79},35), _d({35,70,83,66},35), _d({48,70,85},35), _d({48,66,83,66,75},35), _d({34,70,68,69,81},35), _d({43,70,75,66},35)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({43,76,75,66},35)
end
local pgui = LocalPlayer:FindFirstChild(_d({45,73,62,86,66,79,36,82,70},35))
local backpackGui = pgui and pgui:FindFirstChild(_d({31,62,64,72,77,62,64,72,36,82,70},35))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({37,76,81,63,62,79},35))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({33,66,80,70,68,75},35) and child.Name ~= _d({43,82,74,63,66,79},35) and child.Name ~= _d({50,38,41,70,80,81,41,62,86,76,82,81},35) and child.Name ~= _d({50,38,45,62,65,65,70,75,68},35) then
mapping[slot] = child.Name
break
end
end
end
end
end
return mapping
end
local function cleanup(reason)
running = false
stopNavigation()
_G.EasyTravelHelperMode = nil
_G.GepoGrinderRunning = false
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,48,81,76,77,77,66,65,23,253},35) .. (reason or _d({65,76,75,66},35)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({74,62,75,82,62,73,253,64,73,66,62,75,82,77,253,69,76,76,72},35))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,45,253,77,79,66,80,80,66,65,253,191,93,113,253,62,63,76,79,81,70,75,68,254},35))
cleanup(_d({45,253,72,66,86,253,62,63,76,79,81},35))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,70,67,73,66,253,62,73,79,66,62,65,86,253,66,78,82,70,77,77,66,65,12,76,84,75,66,65,11},35))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({47,70,67,73,66},35))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,70,67,73,66,253,66,78,82,70,77,77,66,65,254},35))
end
cleanup(_d({47,70,67,73,66,253,62,73,79,66,62,65,86,253,76,84,75,66,65},35))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,43,76,81,253,66,75,76,82,68,69,253,45,66,73,70,253,81,76,253,63,82,86,253,62,253,47,70,67,73,66,253,5,16,13,13,6,253,62,75,65,253,75,76,81,253,62,81,253,49,76,84,75,253,76,67,253,31,66,68,70,75,75,70,75,68,80,11,253,45,73,66,62,80,66,253,81,79,62,83,66,73,253,81,76,253,49,76,84,75,253,76,67,253,31,66,68,70,75,75,70,75,68,80,253,81,76,253,64,69,66,80,81,253,67,62,79,74,11},35))
cleanup(_d({38,75,83,62,73,70,65,253,73,76,64,62,81,70,76,75,253,67,76,79,253,64,69,66,80,81,253,67,62,79,74,70,75,68},35))
return
end
if not _G.EasyTravel then
importLib(_d({73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35))
end
if not _G.ChestFarmer then
importLib(_d({73,70,63,12,64,69,66,80,81,60,67,62,79,74,66,79,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,64,69,66,80,81,60,67,62,79,74,66,79,11,73,82,62},35))
end
if _G.ChestFarmer then
local getPeli = function()
local _, p = getStats()
return p
end
local isRunning = function()
return running
end
local farmSuccess = _G.ChestFarmer.FarmUntilPeli(300, getPeli, isRunning)
if not farmSuccess or not running then
cleanup(_d({32,69,66,80,81,253,67,62,79,74,253,67,62,70,73,66,65,253,76,79,253,80,81,76,77,77,66,65},35))
return
end
else
error(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,253,73,70,63,12,64,69,66,80,81,60,67,62,79,74,66,79,11,73,82,62,254},35))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,43,62,83,70,68,62,81,70,75,68,253,81,76,253,63,82,86,253,47,70,67,73,66,11,11,11},35))
local buyables = Workspace:FindFirstChild(_d({31,82,86,62,63,73,66,38,81,66,74,80},35))
local shopItem = buyables and buyables:FindFirstChild(_d({47,70,67,73,66},35))
local shopPart = shopItem and shopItem:FindFirstChild(_d({48,69,76,77,45,62,79,81},35))
if not shopPart then
error(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,70,67,73,66,253,48,69,76,77,45,62,79,81,253,75,76,81,253,67,76,82,75,65,253,82,75,65,66,79,253,31,82,86,62,63,73,66,38,81,66,74,80,254},35))
end
local shopTarget = shopPart.Position - Vector3.new(0, 3.0, 0)
local elapsed = 0
local reached = false
while running and elapsed < 30 do
task.wait(0.1)
elapsed = elapsed + 0.1
if navigateTo(shopTarget) then
reached = true
break
end
end
if not reached or not running then
cleanup(_d({35,62,70,73,66,65,253,81,76,253,79,66,62,64,69,253,47,70,67,73,66,253,80,69,76,77},35))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({45,79,76,85,70,74,70,81,86,45,79,76,74,77,81},35), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,45,82,79,64,69,62,80,66,65,253,47,70,67,73,66,253,77,79,76,74,77,81,253,81,79,70,68,68,66,79,66,65,11},35))
else
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,67,70,79,66,77,79,76,85,70,74,70,81,86,77,79,76,74,77,81,253,75,76,81,253,80,82,77,77,76,79,81,66,65,253,63,86,253,66,85,66,64,82,81,76,79,254},35))
end
else
error(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,45,79,76,85,70,74,70,81,86,45,79,76,74,77,81,253,75,76,81,253,67,76,82,75,65,253,76,75,253,47,70,67,73,66,253,80,69,76,77,253,70,81,66,74,254},35))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({34,83,66,75,81,80},35)) and ReplicatedStorage.Events:FindFirstChild(_d({48,69,76,77},35))
if shopEvent and shopEvent:IsA(_d({47,66,74,76,81,66,35,82,75,64,81,70,76,75},35)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({45,73,62,86,66,79,36,82,70},35))
local diag = pgui and pgui:FindFirstChild(_d({33,70,62,73,76,68,82,66},35))
if diag then
local closeBtn = diag:FindFirstChild(_d({32,73,76,80,66},35), true)
if closeBtn and getconnections then
pcall(function()
for _, conn in ipairs(getconnections(closeBtn.MouseButton1Click)) do
conn:Fire()
end
for _, conn in ipairs(getconnections(closeBtn.Activated)) do
conn:Fire()
end
end)
end
end
if hasRifleInInventory() then
break
end
end
end
if not running then return end
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,34,78,82,70,77,77,70,75,68,253,47,70,67,73,66,253,67,79,76,74,253,70,75,83,66,75,81,76,79,86,11,11,11},35))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({47,70,67,73,66},35) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,70,67,73,66,253,75,76,81,253,70,75,253,69,76,81,63,62,79,11,253,34,78,82,70,77,77,70,75,68,253,83,70,62,253,51,38,42,253,42,62,64,79,76,253,77,73,62,86,63,62,64,72,11,11,11},35))
local vim = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local vs = workspace.CurrentCamera.ViewportSize
local function clickRelative(pctX, pctY)
local cx = vs.X * pctX
local cy = vs.Y * pctY
pcall(function()
vim:SendMouseButtonEvent(cx, cy, 0, true, game, 0)
task.wait(0.05)
vim:SendMouseButtonEvent(cx, cy, 0, false, game, 0)
end)
end
clickRelative(0.025, 0.975)
task.wait(0.8)
clickRelative(0.494, 0.377)
task.wait(0.5)
clickRelative(0.518, 0.443)
task.wait(0.5)
clickRelative(0.770, 0.655)
task.wait(0.5)
clickRelative(0.038, 0.981)
task.wait(1)
mapping = getHotbarMapping()
for slot, toolName in pairs(mapping) do
if toolName == _d({47,70,67,73,66},35) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,35,62,70,73,66,65,253,81,76,253,62,80,80,70,68,75,253,47,70,67,73,66,253,81,76,253,62,253,69,76,81,63,62,79,253,80,73,76,81,11},35))
cleanup(_d({47,70,67,73,66,253,66,78,82,70,77,253,66,79,79,76,79},35))
return
end
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,70,67,73,66,253,70,80,253,74,62,77,77,66,65,253,81,76,253,69,76,81,63,62,79,253,80,73,76,81,23,253},35) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,45,79,66,80,80,70,75,68,253,69,76,81,63,62,79,253,72,66,86,23,253},35) .. tostring(currentSlot) .. _d({253,81,76,253,77,82,73,73,253,76,82,81,253,47,70,67,73,66,11,11,11},35))
vim:SendKeyEvent(true, keyCode, false, game)
task.wait(0.1)
vim:SendKeyEvent(false, keyCode, false, game)
end
local replicaElapsed = 0
local rifleEquipped = false
while running and replicaElapsed < 5 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
local char = LocalPlayer.Character
local rh = char and char:FindFirstChild(_d({47,70,68,69,81,37,62,75,65},35))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({47,70,67,73,66},35)) then
rifleEquipped = true
break
end
end
end
if rifleEquipped then
break
end
end
if not rifleEquipped then
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,70,67,73,66,253,65,70,65,253,75,76,81,253,62,77,77,66,62,79,253,70,75,253,47,70,68,69,81,37,62,75,65,253,62,67,81,66,79,253,77,79,66,80,80,70,75,68,253,69,76,81,72,66,86,11},35))
cleanup(_d({47,70,67,73,66,253,66,78,82,70,77,253,81,70,74,66,76,82,81},35))
return
end
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,70,67,73,66,253,70,80,253,74,62,77,77,66,65,253,81,76,253,69,76,81,63,62,79,253,80,73,76,81,23,253},35) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,45,79,66,80,80,70,75,68,253,69,76,81,63,62,79,253,72,66,86,23,253},35) .. tostring(currentSlot) .. _d({253,81,76,253,77,82,73,73,253,76,82,81,253,47,70,67,73,66,11,11,11},35))
vim:SendKeyEvent(true, keyCode, false, game)
task.wait(0.1)
vim:SendKeyEvent(false, keyCode, false, game)
end
local replicaElapsed = 0
local rifleEquipped = false
while running and replicaElapsed < 5 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
local char = LocalPlayer.Character
local rh = char and char:FindFirstChild(_d({47,70,68,69,81,37,62,75,65},35))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({47,70,67,73,66},35)) then
rifleEquipped = true
break
end
end
end
if rifleEquipped then
break
end
end
if not rifleEquipped then
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,70,67,73,66,253,65,70,65,253,75,76,81,253,62,77,77,66,62,79,253,70,75,253,47,70,68,69,81,37,62,75,65,253,62,67,81,66,79,253,77,79,66,80,80,70,75,68,253,69,76,81,72,66,86,11},35))
cleanup(_d({47,70,67,73,66,253,66,78,82,70,77,253,81,70,74,66,76,82,81},35))
return
end
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,70,67,73,66,253,80,82,64,64,66,80,80,67,82,73,73,86,253,66,78,82,70,77,77,66,65,253,70,75,253,69,62,75,65,80,254},35))
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,34,75,62,63,73,70,75,68,253,34,62,80,86,253,49,79,62,83,66,73,253,62,75,65,253,67,73,86,70,75,68,253,81,76,253,35,70,80,69,74,62,75,253,32,62,83,66,11,11,11},35))
_G.EasyTravelHelperMode = true(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local flightEnabled = false
local currentTargetY = 0
local loopConnection = nil
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local inputConnection = nil
_G.EasyTravel = {
TargetPosition = nil,
DisableKeyboard = (_G.EasyTravelHelperMode == true),
Speed = FLIGHT_SPEED,
Enabled = false
}
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local hum = char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({60,60,34,62,80,86,49,79,62,83,66,73,30,81,81},35)) or Instance.new(_d({30,81,81,62,64,69,74,66,75,81},35))
att.Name = _d({60,60,34,62,80,86,49,79,62,83,66,73,30,81,81},35)
att.Parent = root
local force = root:FindFirstChild(_d({60,60,34,62,80,86,49,79,62,83,66,73,35,76,79,64,66},35))
if not force then
force = Instance.new(_d({41,70,75,66,62,79,51,66,73,76,64,70,81,86},35))
force.Name = _d({60,60,34,62,80,86,49,79,62,83,66,73,35,76,79,64,66},35)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 10000000
force.VectorVelocity = Vector3.zero
force.Parent = root
end
return force
end
local function cleanupForce()
local _, _, root = getCharacterComponents()
if root then
local force = root:FindFirstChild(_d({60,60,34,62,80,86,49,79,62,83,66,73,35,76,79,64,66},35))
local att = root:FindFirstChild(_d({60,60,34,62,80,86,49,79,62,83,66,73,30,81,81},35))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function getSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {character}
raycastParams.IgnoreWater = true
local startPos = Vector3.new(position.X, position.Y + 2, position.Z)
local checkDepth = math.max((position.Y + 2) - SEA_LEVEL_Y, 30)
local direction = Vector3.new(0, -checkDepth, 0)
local result = Workspace:Raycast(startPos, direction, raycastParams)
local groundY = result and result.Position.Y or -100
return math.max(groundY, SEA_LEVEL_Y)
end
local function runRaycastLoop()
while flightEnabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local moveDir = Vector3.zero
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = _G.EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local currentPos = root.Position
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {char}
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit = Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit = Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if forwardHit then
distanceToWall = forwardHit.Distance
local clearanceY = nil
local currentScanDist = FORWARD_SCAN_DISTANCE
local heightOffset = 4
while heightOffset <= 100 do
local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, raycastParams)
if not scanHit then
clearanceY = scanOrigin.Y
local secondaryOrigin = scanOrigin + moveUnit * 10
local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, raycastParams)
if secondaryHit then
currentScanDist = currentScanDist + 15
else
break
end
end
heightOffset = heightOffset + 4
end
if clearanceY then
isClimbing = true
climbTargetY = clearanceY + HEIGHT_OFFSET
else
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = getSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = getSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
local function startFlight()
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
flightEnabled = true
_G.EasyTravel.Enabled = true
currentTargetY = getSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, currentHum, currentRoot = getCharacterComponents()
if not currentRoot or not flightEnabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil; end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = currentTargetY
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
else
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
local currentSpeed = _G.EasyTravel.Speed or FLIGHT_SPEED
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 3 then
if distanceToWall < 6 then
speedMultiplier = 0
else
speedMultiplier = 1
end
end
targetVelocity = moveDir.Unit * (currentSpeed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({56,34,62,80,86,253,49,79,62,83,66,73,58,253,35,73,70,68,69,81,253,66,75,62,63,73,66,65,11},35))
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print(_d({56,34,62,80,86,253,49,79,62,83,66,73,58,253,35,73,70,68,69,81,253,65,70,80,62,63,73,66,65,11},35))
end
_G.EasyTravel.Start = startFlight
_G.EasyTravel.Stop = stopFlight
_G.EasyTravel.GetSurfaceY = getSurfaceY
if not _G.EasyTravelHelperMode then
inputConnection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if flightEnabled then
stopFlight()
else
startFlight()
end
elseif input.KeyCode == Enum.KeyCode.End then
if _G.EasyTravelCleanup then
_G.EasyTravelCleanup()
end
end
end)
end
_G.EasyTravelCleanup = function()
stopFlight()
if inputConnection then
inputConnection:Disconnect()
inputConnection = nil
end
_G.EasyTravel = nil
_G.EasyTravelCleanup = nil
print(_d({56,34,62,80,86,253,49,79,62,83,66,73,58,253,32,76,74,77,73,66,81,66,73,86,253,82,75,73,76,62,65,66,65,253,62,75,65,253,64,73,66,62,75,66,65,253,82,77,253,80,64,79,70,77,81,253,80,81,62,81,66,11},35))
end
if _G.EasyTravelHelperMode then
print(_d({56,34,62,80,86,253,49,79,62,83,66,73,58,253,41,76,62,65,66,65,253,70,75,253,69,66,73,77,66,79,253,74,76,65,66,11,253,40,66,86,63,76,62,79,65,253,70,75,77,82,81,80,253,65,70,80,62,63,73,66,65,11},35))
else
print(_d({56,34,62,80,86,253,49,79,62,83,66,73,58,253,41,76,62,65,66,65,11,253,45,79,66,80,80,253,4,45,4,253,81,76,253,81,76,68,68,73,66,253,67,73,70,68,69,81,11,253,60,36,11,34,62,80,86,49,79,62,83,66,73,253,30,45,38,253,79,66,68,70,80,81,66,79,66,65,11},35))
end
return _G.EasyTravel
})();
if _G.EasyTravel and _G.EasyTravel.Start then
_G.EasyTravel.TargetPosition = Vector3.new(1837, -15, -12258)
_G.EasyTravel.Start()
local replicaElapsed = 0
while running do
task.wait(1)
replicaElapsed = replicaElapsed + 1
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if hrp then
local dist = (hrp.Position - _G.EasyTravel.TargetPosition).Magnitude
if dist < 50 then
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,47,66,62,64,69,66,65,253,35,70,80,69,74,62,75,253,32,62,83,66,254,253,48,81,76,77,77,70,75,68,253,67,73,70,68,69,81,11},35))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,35,62,70,73,66,65,253,81,76,253,70,75,70,81,70,62,73,70,87,66,253,34,62,80,86,253,49,79,62,83,66,73,11},35))
end
cleanup(_d({47,70,67,73,66,253,77,82,79,64,69,62,80,66,65,9,253,66,78,82,70,77,77,66,65,9,253,62,75,65,253,62,79,79,70,83,66,65,253,62,81,253,35,70,80,69,74,62,75,253,32,62,83,66},35))
end)
if not ok then
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,35,62,81,62,73,253,66,79,79,76,79,23,253},35) .. tostring(err))
cleanup(_d({67,62,81,62,73,253,66,79,79,76,79},35))
end
end)
end)()