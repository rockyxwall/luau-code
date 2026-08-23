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
warn(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,48,91,97,84,80,83,104,15,97,100,93,93,88,93,86,16,15,48,81,94,97,99,88,93,86,15,83,100,95,91,88,82,80,99,84,15,91,80,100,93,82,87,29},17))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
local ReplicatedStorage = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local UserInputService = game:GetService(_d({68,98,84,97,56,93,95,100,99,66,84,97,101,88,82,84},17))
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
return char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17))
end
local function waitForGameLoad()
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,70,80,88,99,88,93,86,15,85,94,97,15,86,80,92,84,15,99,94,15,91,94,80,83,29,29,29},17))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)) do
task.wait(0.5)
end
local folderName = _d({66,99,80,99,98},17) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,66,99,80,99,98,15,85,94,91,83,84,97,15,93,94,99,15,85,94,100,93,83,15,88,93,15,65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84,16},17))
end
statsFolder:WaitForChild(_d({66,99,80,99,98},17), 10)
statsFolder:WaitForChild(_d({56,93,101,84,93,99,94,97,104},17), 10)
statsFolder:WaitForChild(_d({66,84,99,99,88,93,86,98},17), 10)
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,54,80,92,84,15,85,100,91,91,104,15,91,94,80,83,84,83,16},17))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({66,99,80,99,98},17) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({66,99,80,99,98},17)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({59,84,101,84,91},17)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({63,84,91,88},17)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({65,88,85,91,84},17)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({65,88,85,91,84},17)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({66,99,80,99,98},17) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({56,93,101,84,93,99,94,97,104},17)) and statsFolder.Inventory:FindFirstChild(_d({56,93,101,84,93,99,94,97,104},17))
if invVal then
return invVal.Value:find(_d({17,65,88,85,91,84,17},17)) ~= nil
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
importLib(_d({91,88,81,30,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80},17), _d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80},17))
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
warn(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,78,54,29,52,80,98,104,67,97,80,101,84,91,15,88,98,15,92,88,98,98,88,93,86,29,15,50,80,93,93,94,99,15,93,80,101,88,86,80,99,84,29},17))
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
local slots = {_d({73,84,97,94},17), _d({62,93,84},17), _d({67,102,94},17), _d({67,87,97,84,84},17), _d({53,94,100,97},17), _d({53,88,101,84},17), _d({66,88,103},17), _d({66,84,101,84,93},17), _d({52,88,86,87,99},17), _d({61,88,93,84},17)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({61,94,93,84},17)
end
local pgui = LocalPlayer:FindFirstChild(_d({63,91,80,104,84,97,54,100,88},17))
local backpackGui = pgui and pgui:FindFirstChild(_d({49,80,82,90,95,80,82,90,54,100,88},17))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({55,94,99,81,80,97},17))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({51,84,98,88,86,93},17) and child.Name ~= _d({61,100,92,81,84,97},17) and child.Name ~= _d({68,56,59,88,98,99,59,80,104,94,100,99},17) and child.Name ~= _d({68,56,63,80,83,83,88,93,86},17) then
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
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({55,94,99,81,80,97},17))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
local synced = false
if filtergc then
pcall(function()
local cache = filtergc(_d({99,80,81,91,84},17), { Keys = {_d({62,93,84},17), _d({67,102,94},17), _d({67,87,97,84,84},17)} }, true)
if cache and type(cache) == _d({99,80,81,91,84},17) then
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
if type(v) == _d({99,80,81,91,84},17) then
if rawget(v, _d({62,93,84},17)) ~= nil and rawget(v, _d({67,102,94},17)) ~= nil and rawget(v, _d({67,87,97,84,84},17)) ~= nil then
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
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,66,99,94,95,95,84,83,41,15},17) .. (reason or _d({83,94,93,84},17)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({92,80,93,100,80,91,15,82,91,84,80,93,100,95,15,87,94,94,90},17))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,63,15,95,97,84,98,98,84,83,15,209,111,131,15,80,81,94,97,99,88,93,86,16},17))
cleanup(_d({63,15,90,84,104,15,80,81,94,97,99},17))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,65,88,85,91,84,15,80,91,97,84,80,83,104,15,84,96,100,88,95,95,84,83,30,94,102,93,84,83,29},17))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({65,88,85,91,84},17))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,65,88,85,91,84,15,84,96,100,88,95,95,84,83,16},17))
end
cleanup(_d({65,88,85,91,84,15,80,91,97,84,80,83,104,15,94,102,93,84,83},17))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,61,94,99,15,84,93,94,100,86,87,15,63,84,91,88,15,99,94,15,81,100,104,15,80,15,65,88,85,91,84,15,23,34,31,31,24,15,80,93,83,15,93,94,99,15,80,99,15,67,94,102,93,15,94,85,15,49,84,86,88,93,93,88,93,86,98,29,15,63,91,84,80,98,84,15,99,97,80,101,84,91,15,99,94,15,67,94,102,93,15,94,85,15,49,84,86,88,93,93,88,93,86,98,15,99,94,15,82,87,84,98,99,15,85,80,97,92,29},17))
cleanup(_d({56,93,101,80,91,88,83,15,91,94,82,80,99,88,94,93,15,85,94,97,15,82,87,84,98,99,15,85,80,97,92,88,93,86},17))
return
end
if not _G.EasyTravel then
importLib(_d({91,88,81,30,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80},17), _d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80},17))
end
if not _G.ChestFarmer then
importLib(_d({91,88,81,30,82,87,84,98,99,78,85,80,97,92,84,97,29,91,100,80},17), _d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,82,87,84,98,99,78,85,80,97,92,84,97,29,91,100,80},17))
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
cleanup(_d({50,87,84,98,99,15,85,80,97,92,15,85,80,88,91,84,83,15,94,97,15,98,99,94,95,95,84,83},17))
return
end
else
error(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,53,80,88,91,84,83,15,99,94,15,91,94,80,83,15,91,88,81,30,82,87,84,98,99,78,85,80,97,92,84,97,29,91,100,80,16},17))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,61,80,101,88,86,80,99,88,93,86,15,99,94,15,81,100,104,15,65,88,85,91,84,29,29,29},17))
local buyables = Workspace:FindFirstChild(_d({49,100,104,80,81,91,84,56,99,84,92,98},17))
local shopItem = buyables and buyables:FindFirstChild(_d({65,88,85,91,84},17))
local shopPart = shopItem and shopItem:FindFirstChild(_d({66,87,94,95,63,80,97,99},17))
if not shopPart then
error(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,65,88,85,91,84,15,66,87,94,95,63,80,97,99,15,93,94,99,15,85,94,100,93,83,15,100,93,83,84,97,15,49,100,104,80,81,91,84,56,99,84,92,98,16},17))
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
cleanup(_d({53,80,88,91,84,83,15,99,94,15,97,84,80,82,87,15,65,88,85,91,84,15,98,87,94,95},17))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({63,97,94,103,88,92,88,99,104,63,97,94,92,95,99},17), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,63,100,97,82,87,80,98,84,83,15,65,88,85,91,84,15,95,97,94,92,95,99,15,99,97,88,86,86,84,97,84,83,29},17))
else
warn(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,85,88,97,84,95,97,94,103,88,92,88,99,104,95,97,94,92,95,99,15,93,94,99,15,98,100,95,95,94,97,99,84,83,15,81,104,15,84,103,84,82,100,99,94,97,16},17))
end
else
error(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,63,97,94,103,88,92,88,99,104,63,97,94,92,95,99,15,93,94,99,15,85,94,100,93,83,15,94,93,15,65,88,85,91,84,15,98,87,94,95,15,88,99,84,92,16},17))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({52,101,84,93,99,98},17)) and ReplicatedStorage.Events:FindFirstChild(_d({66,87,94,95},17))
if shopEvent and shopEvent:IsA(_d({65,84,92,94,99,84,53,100,93,82,99,88,94,93},17)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
if hasRifleInInventory() then
break
end
end
end
if not running then return end
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,52,96,100,88,95,95,88,93,86,15,65,88,85,91,84,15,85,97,94,92,15,88,93,101,84,93,99,94,97,104,29,29,29},17))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({65,88,85,91,84},17) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({62,93,84},17), _d({67,102,94},17), _d({67,87,97,84,84},17), _d({53,94,100,97},17), _d({53,88,101,84},17), _d({66,88,103},17), _d({66,84,101,84,93},17), _d({52,88,86,87,99},17), _d({61,88,93,84},17), _d({73,84,97,94},17)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({61,94,93,84},17) then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = _d({61,88,93,84},17)
end
mapping[currentSlot] = _d({65,88,85,91,84},17)
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,49,88,93,83,88,93,86,15,65,88,85,91,84,15,99,94,15,87,94,99,81,80,97,15,98,91,94,99,41,15},17) .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,65,88,85,91,84,15,88,98,15,80,91,97,84,80,83,104,15,92,80,95,95,84,83,15,99,94,15,87,94,99,81,80,97,15,98,91,94,99,41,15},17) .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({65,88,85,91,84},17)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({65,88,85,91,84},17)))
if rifleTool then
break
end
end
if not rifleTool then
warn(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,65,88,85,91,84,15,102,80,98,15,81,94,100,93,83,15,99,94,15,87,94,99,81,80,97,15,81,100,99,15,83,88,83,15,93,94,99,15,80,95,95,84,80,97,15,88,93,15,49,80,82,90,95,80,82,90,30,50,87,80,97,80,82,99,84,97,15,102,88,99,87,88,93,15,32,31,15,98,84,82,94,93,83,98,29},17))
cleanup(_d({65,88,85,91,84,15,97,84,95,91,88,82,80,99,88,94,93,15,99,88,92,84,94,100,99},17))
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({65,88,85,91,84},17))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,65,88,85,91,84,15,98,100,82,82,84,98,98,85,100,91,91,104,15,84,96,100,88,95,95,84,83,16},17))
end
cleanup(_d({65,88,85,91,84,15,95,100,97,82,87,80,98,84,83,27,15,87,94,99,81,80,97,15,81,94,100,93,83,27,15,80,93,83,15,84,96,100,88,95,95,84,83},17))
end)
if not ok then
warn(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,53,80,99,80,91,15,84,97,97,94,97,41,15},17) .. tostring(err))
cleanup(_d({85,80,99,80,91,15,84,97,97,94,97},17))
end
end)
end)()