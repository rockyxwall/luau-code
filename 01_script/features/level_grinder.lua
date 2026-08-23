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
warn(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,2,45,51,38,34,37,58,225,51,54,47,47,42,47,40,226,225,2,35,48,51,53,42,47,40,225,37,54,49,45,42,36,34,53,38,225,45,34,54,47,36,41,239},63))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local ReplicatedStorage = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local UserInputService = game:GetService(_d({22,52,38,51,10,47,49,54,53,20,38,51,55,42,36,38},63))
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
return char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
end
local function waitForGameLoad()
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,24,34,42,53,42,47,40,225,39,48,51,225,40,34,46,38,225,53,48,225,45,48,34,37,239,239,239},63))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)) do
task.wait(0.5)
end
local folderName = _d({20,53,34,53,52},63) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,20,53,34,53,52,225,39,48,45,37,38,51,225,47,48,53,225,39,48,54,47,37,225,42,47,225,19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38,226},63))
end
statsFolder:WaitForChild(_d({20,53,34,53,52},63), 10)
statsFolder:WaitForChild(_d({10,47,55,38,47,53,48,51,58},63), 10)
statsFolder:WaitForChild(_d({20,38,53,53,42,47,40,52},63), 10)
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,8,34,46,38,225,39,54,45,45,58,225,45,48,34,37,38,37,226},63))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({20,53,34,53,52},63) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({20,53,34,53,52},63)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({13,38,55,38,45},63)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({17,38,45,42},63)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({19,42,39,45,38},63)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({19,42,39,45,38},63)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({20,53,34,53,52},63) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({10,47,55,38,47,53,48,51,58},63)) and statsFolder.Inventory:FindFirstChild(_d({10,47,55,38,47,53,48,51,58},63))
if invVal then
return invVal.Value:find(_d({227,19,42,39,45,38,227},63)) ~= nil
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
importLib(_d({45,42,35,240,38,34,52,58,32,53,51,34,55,38,45,239,45,54,34},63), _d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,51,48,36,44,58,57,56,34,45,45,240,45,54,34,54,238,36,48,37,38,240,46,34,42,47,240,241,242,32,52,36,51,42,49,53,240,45,42,35,240,38,34,52,58,32,53,51,34,55,38,45,239,45,54,34},63))
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
warn(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,32,8,239,6,34,52,58,21,51,34,55,38,45,225,42,52,225,46,42,52,52,42,47,40,239,225,4,34,47,47,48,53,225,47,34,55,42,40,34,53,38,239},63))
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
local slots = {_d({27,38,51,48},63), _d({16,47,38},63), _d({21,56,48},63), _d({21,41,51,38,38},63), _d({7,48,54,51},63), _d({7,42,55,38},63), _d({20,42,57},63), _d({20,38,55,38,47},63), _d({6,42,40,41,53},63), _d({15,42,47,38},63)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({15,48,47,38},63)
end
local pgui = LocalPlayer:FindFirstChild(_d({17,45,34,58,38,51,8,54,42},63))
local backpackGui = pgui and pgui:FindFirstChild(_d({3,34,36,44,49,34,36,44,8,54,42},63))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({9,48,53,35,34,51},63))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({5,38,52,42,40,47},63) and child.Name ~= _d({15,54,46,35,38,51},63) and child.Name ~= _d({22,10,13,42,52,53,13,34,58,48,54,53},63) and child.Name ~= _d({22,10,17,34,37,37,42,47,40},63) then
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
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({9,48,53,35,34,51},63))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
for _, v in ipairs(getgc(true)) do
if type(v) == _d({53,34,35,45,38},63) then
if rawget(v, _d({16,47,38},63)) ~= nil and rawget(v, _d({21,56,48},63)) ~= nil and rawget(v, _d({21,41,51,38,38},63)) ~= nil then
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
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,20,53,48,49,49,38,37,251,225},63) .. (reason or _d({37,48,47,38},63)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({46,34,47,54,34,45,225,36,45,38,34,47,54,49,225,41,48,48,44},63))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,17,225,49,51,38,52,52,38,37,225,163,65,85,225,34,35,48,51,53,42,47,40,226},63))
cleanup(_d({17,225,44,38,58,225,34,35,48,51,53},63))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,19,42,39,45,38,225,34,45,51,38,34,37,58,225,38,50,54,42,49,49,38,37,240,48,56,47,38,37,239},63))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({19,42,39,45,38},63))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,19,42,39,45,38,225,38,50,54,42,49,49,38,37,226},63))
end
cleanup(_d({19,42,39,45,38,225,34,45,51,38,34,37,58,225,48,56,47,38,37},63))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,15,48,53,225,38,47,48,54,40,41,225,17,38,45,42,225,53,48,225,35,54,58,225,34,225,19,42,39,45,38,225,233,244,241,241,234,225,34,47,37,225,47,48,53,225,34,53,225,21,48,56,47,225,48,39,225,3,38,40,42,47,47,42,47,40,52,239,225,17,45,38,34,52,38,225,53,51,34,55,38,45,225,53,48,225,21,48,56,47,225,48,39,225,3,38,40,42,47,47,42,47,40,52,225,53,48,225,36,41,38,52,53,225,39,34,51,46,239},63))
cleanup(_d({10,47,55,34,45,42,37,225,45,48,36,34,53,42,48,47,225,39,48,51,225,36,41,38,52,53,225,39,34,51,46,42,47,40},63))
return
end
if not _G.ChestFarmer then
importLib(_d({45,42,35,240,36,41,38,52,53,32,39,34,51,46,38,51,239,45,54,34},63), _d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,51,48,36,44,58,57,56,34,45,45,240,45,54,34,54,238,36,48,37,38,240,46,34,42,47,240,241,242,32,52,36,51,42,49,53,240,45,42,35,240,36,41,38,52,53,32,39,34,51,46,38,51,239,45,54,34},63))
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
cleanup(_d({4,41,38,52,53,225,39,34,51,46,225,39,34,42,45,38,37,225,48,51,225,52,53,48,49,49,38,37},63))
return
end
else
error(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,7,34,42,45,38,37,225,53,48,225,45,48,34,37,225,45,42,35,240,36,41,38,52,53,32,39,34,51,46,38,51,239,45,54,34,226},63))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,15,34,55,42,40,34,53,42,47,40,225,53,48,225,35,54,58,225,19,42,39,45,38,239,239,239},63))
local buyables = Workspace:FindFirstChild(_d({3,54,58,34,35,45,38,10,53,38,46,52},63))
local shopItem = buyables and buyables:FindFirstChild(_d({19,42,39,45,38},63))
local shopPart = shopItem and shopItem:FindFirstChild(_d({20,41,48,49,17,34,51,53},63))
if not shopPart then
error(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,19,42,39,45,38,225,20,41,48,49,17,34,51,53,225,47,48,53,225,39,48,54,47,37,225,54,47,37,38,51,225,3,54,58,34,35,45,38,10,53,38,46,52,226},63))
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
cleanup(_d({7,34,42,45,38,37,225,53,48,225,51,38,34,36,41,225,19,42,39,45,38,225,52,41,48,49},63))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({17,51,48,57,42,46,42,53,58,17,51,48,46,49,53},63), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,17,54,51,36,41,34,52,38,37,225,19,42,39,45,38,225,49,51,48,46,49,53,225,53,51,42,40,40,38,51,38,37,239},63))
else
warn(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,39,42,51,38,49,51,48,57,42,46,42,53,58,49,51,48,46,49,53,225,47,48,53,225,52,54,49,49,48,51,53,38,37,225,35,58,225,38,57,38,36,54,53,48,51,226},63))
end
else
error(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,17,51,48,57,42,46,42,53,58,17,51,48,46,49,53,225,47,48,53,225,39,48,54,47,37,225,48,47,225,19,42,39,45,38,225,52,41,48,49,225,42,53,38,46,226},63))
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
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,6,50,54,42,49,49,42,47,40,225,19,42,39,45,38,225,39,51,48,46,225,42,47,55,38,47,53,48,51,58,239,239,239},63))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({19,42,39,45,38},63) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({16,47,38},63), _d({21,56,48},63), _d({21,41,51,38,38},63), _d({7,48,54,51},63), _d({7,42,55,38},63), _d({20,42,57},63), _d({20,38,55,38,47},63), _d({6,42,40,41,53},63), _d({15,42,47,38},63), _d({27,38,51,48},63)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({15,48,47,38},63) then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = _d({15,42,47,38},63)
end
mapping[currentSlot] = _d({19,42,39,45,38},63)
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,3,42,47,37,42,47,40,225,19,42,39,45,38,225,53,48,225,41,48,53,35,34,51,225,52,45,48,53,251,225},63) .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,19,42,39,45,38,225,42,52,225,34,45,51,38,34,37,58,225,46,34,49,49,38,37,225,53,48,225,41,48,53,35,34,51,225,52,45,48,53,251,225},63) .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({19,42,39,45,38},63)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({19,42,39,45,38},63)))
if rifleTool then
break
end
end
if not rifleTool then
warn(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,19,42,39,45,38,225,56,34,52,225,35,48,54,47,37,225,53,48,225,41,48,53,35,34,51,225,35,54,53,225,37,42,37,225,47,48,53,225,34,49,49,38,34,51,225,42,47,225,3,34,36,44,49,34,36,44,240,4,41,34,51,34,36,53,38,51,225,56,42,53,41,42,47,225,242,241,225,52,38,36,48,47,37,52,239},63))
cleanup(_d({19,42,39,45,38,225,51,38,49,45,42,36,34,53,42,48,47,225,53,42,46,38,48,54,53},63))
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({19,42,39,45,38},63))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,19,42,39,45,38,225,52,54,36,36,38,52,52,39,54,45,45,58,225,38,50,54,42,49,49,38,37,226},63))
end
cleanup(_d({19,42,39,45,38,225,49,54,51,36,41,34,52,38,37,237,225,41,48,53,35,34,51,225,35,48,54,47,37,237,225,34,47,37,225,38,50,54,42,49,49,38,37},63))
end)
if not ok then
warn(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,7,34,53,34,45,225,38,51,51,48,51,251,225},63) .. tostring(err))
cleanup(_d({39,34,53,34,45,225,38,51,51,48,51},63))
end
end)
end)()