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
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,38,81,87,74,70,73,94,5,87,90,83,83,78,83,76,6,5,38,71,84,87,89,78,83,76,5,73,90,85,81,78,72,70,89,74,5,81,70,90,83,72,77,19},27))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
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
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
end
local function waitForGameLoad()
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,60,70,78,89,78,83,76,5,75,84,87,5,76,70,82,74,5,89,84,5,81,84,70,73,19,19,19},27))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)) do
task.wait(0.5)
end
local folderName = _d({56,89,70,89,88},27) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,56,89,70,89,88,5,75,84,81,73,74,87,5,83,84,89,5,75,84,90,83,73,5,78,83,5,55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74,6},27))
end
statsFolder:WaitForChild(_d({56,89,70,89,88},27), 10)
statsFolder:WaitForChild(_d({46,83,91,74,83,89,84,87,94},27), 10)
statsFolder:WaitForChild(_d({56,74,89,89,78,83,76,88},27), 10)
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,44,70,82,74,5,75,90,81,81,94,5,81,84,70,73,74,73,6},27))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({56,89,70,89,88},27) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({56,89,70,89,88},27)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({49,74,91,74,81},27)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({53,74,81,78},27)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({55,78,75,81,74},27)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({55,78,75,81,74},27)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({56,89,70,89,88},27) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({46,83,91,74,83,89,84,87,94},27)) and statsFolder.Inventory:FindFirstChild(_d({46,83,91,74,83,89,84,87,94},27))
if invVal then
return invVal.Value:find(_d({7,55,78,75,81,74,7},27)) ~= nil
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
importLib(_d({81,78,71,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27), _d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,81,90,70,90,18,72,84,73,74,20,82,70,78,83,20,21,22,68,88,72,87,78,85,89,20,81,78,71,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27))
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
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,68,44,19,42,70,88,94,57,87,70,91,74,81,5,78,88,5,82,78,88,88,78,83,76,19,5,40,70,83,83,84,89,5,83,70,91,78,76,70,89,74,19},27))
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
local slots = {_d({63,74,87,84},27), _d({52,83,74},27), _d({57,92,84},27), _d({57,77,87,74,74},27), _d({43,84,90,87},27), _d({43,78,91,74},27), _d({56,78,93},27), _d({56,74,91,74,83},27), _d({42,78,76,77,89},27), _d({51,78,83,74},27)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({51,84,83,74},27)
end
local pgui = LocalPlayer:FindFirstChild(_d({53,81,70,94,74,87,44,90,78},27))
local backpackGui = pgui and pgui:FindFirstChild(_d({39,70,72,80,85,70,72,80,44,90,78},27))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({45,84,89,71,70,87},27))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({41,74,88,78,76,83},27) and child.Name ~= _d({51,90,82,71,74,87},27) and child.Name ~= _d({58,46,49,78,88,89,49,70,94,84,90,89},27) and child.Name ~= _d({58,46,53,70,73,73,78,83,76},27) then
mapping[slot] = child.Name
break
end
end
end
end
end
return mapping
end
local function syncClientHotbar(mapping)
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({45,84,89,71,70,87},27))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
for _, v in ipairs(getgc(true)) do
if type(v) == _d({89,70,71,81,74},27) then
if rawget(v, _d({52,83,74},27)) ~= nil and rawget(v, _d({57,92,84},27)) ~= nil and rawget(v, _d({57,77,87,74,74},27)) ~= nil then
for slot, toolName in pairs(mapping) do
rawset(v, slot, toolName)
end
end
end
end
end
local function cleanup(reason)
running = false
stopNavigation()
_G.EasyTravelHelperMode = nil
_G.GepoGrinderRunning = false
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,56,89,84,85,85,74,73,31,5},27) .. (reason or _d({73,84,83,74},27)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({82,70,83,90,70,81,5,72,81,74,70,83,90,85,5,77,84,84,80},27))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,53,5,85,87,74,88,88,74,73,5,199,101,121,5,70,71,84,87,89,78,83,76,6},27))
cleanup(_d({53,5,80,74,94,5,70,71,84,87,89},27))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,70,81,87,74,70,73,94,5,74,86,90,78,85,85,74,73,20,84,92,83,74,73,19},27))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({55,78,75,81,74},27))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,74,86,90,78,85,85,74,73,6},27))
end
cleanup(_d({55,78,75,81,74,5,70,81,87,74,70,73,94,5,84,92,83,74,73},27))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,51,84,89,5,74,83,84,90,76,77,5,53,74,81,78,5,89,84,5,71,90,94,5,70,5,55,78,75,81,74,5,13,24,21,21,14,5,70,83,73,5,83,84,89,5,70,89,5,57,84,92,83,5,84,75,5,39,74,76,78,83,83,78,83,76,88,19,5,53,81,74,70,88,74,5,89,87,70,91,74,81,5,89,84,5,57,84,92,83,5,84,75,5,39,74,76,78,83,83,78,83,76,88,5,89,84,5,72,77,74,88,89,5,75,70,87,82,19},27))
cleanup(_d({46,83,91,70,81,78,73,5,81,84,72,70,89,78,84,83,5,75,84,87,5,72,77,74,88,89,5,75,70,87,82,78,83,76},27))
return
end
if not _G.ChestFarmer then
importLib(_d({81,78,71,20,72,77,74,88,89,68,75,70,87,82,74,87,19,81,90,70},27), _d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,81,90,70,90,18,72,84,73,74,20,82,70,78,83,20,21,22,68,88,72,87,78,85,89,20,81,78,71,20,72,77,74,88,89,68,75,70,87,82,74,87,19,81,90,70},27))
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
cleanup(_d({40,77,74,88,89,5,75,70,87,82,5,75,70,78,81,74,73,5,84,87,5,88,89,84,85,85,74,73},27))
return
end
else
error(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,5,81,78,71,20,72,77,74,88,89,68,75,70,87,82,74,87,19,81,90,70,6},27))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,51,70,91,78,76,70,89,78,83,76,5,89,84,5,71,90,94,5,55,78,75,81,74,19,19,19},27))
local buyables = Workspace:FindFirstChild(_d({39,90,94,70,71,81,74,46,89,74,82,88},27))
local shopItem = buyables and buyables:FindFirstChild(_d({55,78,75,81,74},27))
local shopPart = shopItem and shopItem:FindFirstChild(_d({56,77,84,85,53,70,87,89},27))
if not shopPart then
error(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,56,77,84,85,53,70,87,89,5,83,84,89,5,75,84,90,83,73,5,90,83,73,74,87,5,39,90,94,70,71,81,74,46,89,74,82,88,6},27))
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
cleanup(_d({43,70,78,81,74,73,5,89,84,5,87,74,70,72,77,5,55,78,75,81,74,5,88,77,84,85},27))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({53,87,84,93,78,82,78,89,94,53,87,84,82,85,89},27), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,53,90,87,72,77,70,88,74,73,5,55,78,75,81,74,5,85,87,84,82,85,89,5,89,87,78,76,76,74,87,74,73,19},27))
else
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,75,78,87,74,85,87,84,93,78,82,78,89,94,85,87,84,82,85,89,5,83,84,89,5,88,90,85,85,84,87,89,74,73,5,71,94,5,74,93,74,72,90,89,84,87,6},27))
end
else
error(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,53,87,84,93,78,82,78,89,94,53,87,84,82,85,89,5,83,84,89,5,75,84,90,83,73,5,84,83,5,55,78,75,81,74,5,88,77,84,85,5,78,89,74,82,6},27))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
if hasRifleInInventory() then
break
end
end
end
if not running then return end
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,42,86,90,78,85,85,78,83,76,5,55,78,75,81,74,5,75,87,84,82,5,78,83,91,74,83,89,84,87,94,19,19,19},27))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({55,78,75,81,74},27) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({52,83,74},27), _d({57,92,84},27), _d({57,77,87,74,74},27), _d({43,84,90,87},27), _d({43,78,91,74},27), _d({56,78,93},27), _d({56,74,91,74,83},27), _d({42,78,76,77,89},27), _d({51,78,83,74},27), _d({63,74,87,84},27)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({51,84,83,74},27) then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = _d({51,78,83,74},27)
end
mapping[currentSlot] = _d({55,78,75,81,74},27)
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,39,78,83,73,78,83,76,5,55,78,75,81,74,5,89,84,5,77,84,89,71,70,87,5,88,81,84,89,31,5},27) .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,78,88,5,70,81,87,74,70,73,94,5,82,70,85,85,74,73,5,89,84,5,77,84,89,71,70,87,5,88,81,84,89,31,5},27) .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({55,78,75,81,74},27)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({55,78,75,81,74},27)))
if rifleTool then
break
end
end
if not rifleTool then
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,92,70,88,5,71,84,90,83,73,5,89,84,5,77,84,89,71,70,87,5,71,90,89,5,73,78,73,5,83,84,89,5,70,85,85,74,70,87,5,78,83,5,39,70,72,80,85,70,72,80,20,40,77,70,87,70,72,89,74,87,5,92,78,89,77,78,83,5,22,21,5,88,74,72,84,83,73,88,19},27))
cleanup(_d({55,78,75,81,74,5,87,74,85,81,78,72,70,89,78,84,83,5,89,78,82,74,84,90,89},27))
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({55,78,75,81,74},27))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,88,90,72,72,74,88,88,75,90,81,81,94,5,74,86,90,78,85,85,74,73,6},27))
end
cleanup(_d({55,78,75,81,74,5,85,90,87,72,77,70,88,74,73,17,5,77,84,89,71,70,87,5,71,84,90,83,73,17,5,70,83,73,5,74,86,90,78,85,85,74,73},27))
end)
if not ok then
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,43,70,89,70,81,5,74,87,87,84,87,31,5},27) .. tostring(err))
cleanup(_d({75,70,89,70,81,5,74,87,87,84,87},27))
end
end)
end)()