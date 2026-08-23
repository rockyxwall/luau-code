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
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,49,92,98,85,81,84,105,16,98,101,94,94,89,94,87,17,16,49,82,95,98,100,89,94,87,16,84,101,96,92,89,83,81,100,85,16,92,81,101,94,83,88,30},16))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local UserInputService = game:GetService(_d({69,99,85,98,57,94,96,101,100,67,85,98,102,89,83,85},16))
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
return char and char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
end
local function waitForGameLoad()
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,71,81,89,100,89,94,87,16,86,95,98,16,87,81,93,85,16,100,95,16,92,95,81,84,30,30,30},16))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)) do
task.wait(0.5)
end
local folderName = _d({67,100,81,100,99},16) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,67,100,81,100,99,16,86,95,92,84,85,98,16,94,95,100,16,86,95,101,94,84,16,89,94,16,66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85,17},16))
end
statsFolder:WaitForChild(_d({67,100,81,100,99},16), 10)
statsFolder:WaitForChild(_d({57,94,102,85,94,100,95,98,105},16), 10)
statsFolder:WaitForChild(_d({67,85,100,100,89,94,87,99},16), 10)
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,55,81,93,85,16,86,101,92,92,105,16,92,95,81,84,85,84,17},16))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({67,100,81,100,99},16) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({67,100,81,100,99},16)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({60,85,102,85,92},16)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({64,85,92,89},16)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({66,89,86,92,85},16)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({66,89,86,92,85},16)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({67,100,81,100,99},16) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({57,94,102,85,94,100,95,98,105},16)) and statsFolder.Inventory:FindFirstChild(_d({57,94,102,85,94,100,95,98,105},16))
if invVal then
return invVal.Value:find(_d({18,66,89,86,92,85,18},16)) ~= nil
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
importLib(_d({92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16), _d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16))
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
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,79,55,30,53,81,99,105,68,98,81,102,85,92,16,89,99,16,93,89,99,99,89,94,87,30,16,51,81,94,94,95,100,16,94,81,102,89,87,81,100,85,30},16))
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
local slots = {_d({74,85,98,95},16), _d({63,94,85},16), _d({68,103,95},16), _d({68,88,98,85,85},16), _d({54,95,101,98},16), _d({54,89,102,85},16), _d({67,89,104},16), _d({67,85,102,85,94},16), _d({53,89,87,88,100},16), _d({62,89,94,85},16)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({62,95,94,85},16)
end
local pgui = LocalPlayer:FindFirstChild(_d({64,92,81,105,85,98,55,101,89},16))
local backpackGui = pgui and pgui:FindFirstChild(_d({50,81,83,91,96,81,83,91,55,101,89},16))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({56,95,100,82,81,98},16))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({52,85,99,89,87,94},16) and child.Name ~= _d({62,101,93,82,85,98},16) and child.Name ~= _d({69,57,60,89,99,100,60,81,105,95,101,100},16) and child.Name ~= _d({69,57,64,81,84,84,89,94,87},16) then
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
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({56,95,100,82,81,98},16))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
local synced = false
if filtergc then
pcall(function()
local cache = filtergc(_d({100,81,82,92,85},16), function(v)
return rawget(v, _d({63,94,85},16)) ~= nil and rawget(v, _d({68,103,95},16)) ~= nil and rawget(v, _d({68,88,98,85,85},16)) ~= nil
end, true)
if cache then
for slot, toolName in pairs(mapping) do
rawset(cache, slot, toolName)
end
synced = true
end
end)
end
if not synced and getgc then
pcall(function()
for _, v in ipairs(getgc(true)) do
if type(v) == _d({100,81,82,92,85},16) then
if rawget(v, _d({63,94,85},16)) ~= nil and rawget(v, _d({68,103,95},16)) ~= nil and rawget(v, _d({68,88,98,85,85},16)) ~= nil then
for slot, toolName in pairs(mapping) do
rawset(v, slot, toolName)
end
end
end
end
end)
end
end
local function cleanup(reason)
running = false
stopNavigation()
_G.EasyTravelHelperMode = nil
_G.GepoGrinderRunning = false
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,67,100,95,96,96,85,84,42,16},16) .. (reason or _d({84,95,94,85},16)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({93,81,94,101,81,92,16,83,92,85,81,94,101,96,16,88,95,95,91},16))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,64,16,96,98,85,99,99,85,84,16,210,112,132,16,81,82,95,98,100,89,94,87,17},16))
cleanup(_d({64,16,91,85,105,16,81,82,95,98,100},16))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,81,92,98,85,81,84,105,16,85,97,101,89,96,96,85,84,31,95,103,94,85,84,30},16))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({66,89,86,92,85},16))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,85,97,101,89,96,96,85,84,17},16))
end
cleanup(_d({66,89,86,92,85,16,81,92,98,85,81,84,105,16,95,103,94,85,84},16))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,62,95,100,16,85,94,95,101,87,88,16,64,85,92,89,16,100,95,16,82,101,105,16,81,16,66,89,86,92,85,16,24,35,32,32,25,16,81,94,84,16,94,95,100,16,81,100,16,68,95,103,94,16,95,86,16,50,85,87,89,94,94,89,94,87,99,30,16,64,92,85,81,99,85,16,100,98,81,102,85,92,16,100,95,16,68,95,103,94,16,95,86,16,50,85,87,89,94,94,89,94,87,99,16,100,95,16,83,88,85,99,100,16,86,81,98,93,30},16))
cleanup(_d({57,94,102,81,92,89,84,16,92,95,83,81,100,89,95,94,16,86,95,98,16,83,88,85,99,100,16,86,81,98,93,89,94,87},16))
return
end
if not _G.EasyTravel then
importLib(_d({92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16), _d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16))
end
if not _G.ChestFarmer then
importLib(_d({92,89,82,31,83,88,85,99,100,79,86,81,98,93,85,98,30,92,101,81},16), _d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,83,88,85,99,100,79,86,81,98,93,85,98,30,92,101,81},16))
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
cleanup(_d({51,88,85,99,100,16,86,81,98,93,16,86,81,89,92,85,84,16,95,98,16,99,100,95,96,96,85,84},16))
return
end
else
error(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,54,81,89,92,85,84,16,100,95,16,92,95,81,84,16,92,89,82,31,83,88,85,99,100,79,86,81,98,93,85,98,30,92,101,81,17},16))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,62,81,102,89,87,81,100,89,94,87,16,100,95,16,82,101,105,16,66,89,86,92,85,30,30,30},16))
local buyables = Workspace:FindFirstChild(_d({50,101,105,81,82,92,85,57,100,85,93,99},16))
local shopItem = buyables and buyables:FindFirstChild(_d({66,89,86,92,85},16))
local shopPart = shopItem and shopItem:FindFirstChild(_d({67,88,95,96,64,81,98,100},16))
if not shopPart then
error(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,67,88,95,96,64,81,98,100,16,94,95,100,16,86,95,101,94,84,16,101,94,84,85,98,16,50,101,105,81,82,92,85,57,100,85,93,99,17},16))
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
cleanup(_d({54,81,89,92,85,84,16,100,95,16,98,85,81,83,88,16,66,89,86,92,85,16,99,88,95,96},16))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({64,98,95,104,89,93,89,100,105,64,98,95,93,96,100},16), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,64,101,98,83,88,81,99,85,84,16,66,89,86,92,85,16,96,98,95,93,96,100,16,100,98,89,87,87,85,98,85,84,30},16))
else
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,86,89,98,85,96,98,95,104,89,93,89,100,105,96,98,95,93,96,100,16,94,95,100,16,99,101,96,96,95,98,100,85,84,16,82,105,16,85,104,85,83,101,100,95,98,17},16))
end
else
error(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,64,98,95,104,89,93,89,100,105,64,98,95,93,96,100,16,94,95,100,16,86,95,101,94,84,16,95,94,16,66,89,86,92,85,16,99,88,95,96,16,89,100,85,93,17},16))
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
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,53,97,101,89,96,96,89,94,87,16,66,89,86,92,85,16,86,98,95,93,16,89,94,102,85,94,100,95,98,105,30,30,30},16))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({66,89,86,92,85},16) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({63,94,85},16), _d({68,103,95},16), _d({68,88,98,85,85},16), _d({54,95,101,98},16), _d({54,89,102,85},16), _d({67,89,104},16), _d({67,85,102,85,94},16), _d({53,89,87,88,100},16), _d({62,89,94,85},16), _d({74,85,98,95},16)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({62,95,94,85},16) then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = _d({62,89,94,85},16)
end
mapping[currentSlot] = _d({66,89,86,92,85},16)
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,50,89,94,84,89,94,87,16,66,89,86,92,85,16,100,95,16,88,95,100,82,81,98,16,99,92,95,100,42,16},16) .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,89,99,16,81,92,98,85,81,84,105,16,93,81,96,96,85,84,16,100,95,16,88,95,100,82,81,98,16,99,92,95,100,42,16},16) .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({66,89,86,92,85},16)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({66,89,86,92,85},16)))
if rifleTool then
break
end
end
if not rifleTool then
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,103,81,99,16,82,95,101,94,84,16,100,95,16,88,95,100,82,81,98,16,82,101,100,16,84,89,84,16,94,95,100,16,81,96,96,85,81,98,16,89,94,16,50,81,83,91,96,81,83,91,31,51,88,81,98,81,83,100,85,98,16,103,89,100,88,89,94,16,33,32,16,99,85,83,95,94,84,99,30},16))
cleanup(_d({66,89,86,92,85,16,98,85,96,92,89,83,81,100,89,95,94,16,100,89,93,85,95,101,100},16))
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({66,89,86,92,85},16))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,99,101,83,83,85,99,99,86,101,92,92,105,16,85,97,101,89,96,96,85,84,17},16))
end
cleanup(_d({66,89,86,92,85,16,96,101,98,83,88,81,99,85,84,28,16,88,95,100,82,81,98,16,82,95,101,94,84,28,16,81,94,84,16,85,97,101,89,96,96,85,84},16))
end)
if not ok then
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,54,81,100,81,92,16,85,98,98,95,98,42,16},16) .. tostring(err))
cleanup(_d({86,81,100,81,92,16,85,98,98,95,98},16))
end
end)
end)()