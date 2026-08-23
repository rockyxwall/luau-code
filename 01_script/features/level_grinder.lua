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
warn(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,17,60,66,53,49,52,73,240,66,69,62,62,57,62,55,241,240,17,50,63,66,68,57,62,55,240,52,69,64,60,57,51,49,68,53,240,60,49,69,62,51,56,254},48))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
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
return char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
end
local function waitForGameLoad()
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,39,49,57,68,57,62,55,240,54,63,66,240,55,49,61,53,240,68,63,240,60,63,49,52,254,254,254},48))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48)) do
task.wait(0.5)
end
local folderName = _d({35,68,49,68,67},48) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,35,68,49,68,67,240,54,63,60,52,53,66,240,62,63,68,240,54,63,69,62,52,240,57,62,240,34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53,241},48))
end
statsFolder:WaitForChild(_d({35,68,49,68,67},48), 10)
statsFolder:WaitForChild(_d({25,62,70,53,62,68,63,66,73},48), 10)
statsFolder:WaitForChild(_d({35,53,68,68,57,62,55,67},48), 10)
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,23,49,61,53,240,54,69,60,60,73,240,60,63,49,52,53,52,241},48))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({35,68,49,68,67},48) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({35,68,49,68,67},48)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({28,53,70,53,60},48)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({32,53,60,57},48)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({34,57,54,60,53},48)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({35,68,49,68,67},48) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({25,62,70,53,62,68,63,66,73},48)) and statsFolder.Inventory:FindFirstChild(_d({25,62,70,53,62,68,63,66,73},48))
if invVal then
return invVal.Value:find(_d({242,34,57,54,60,53,242},48)) ~= nil
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
importLib(_d({60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48))
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
warn(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,47,23,254,21,49,67,73,36,66,49,70,53,60,240,57,67,240,61,57,67,67,57,62,55,254,240,19,49,62,62,63,68,240,62,49,70,57,55,49,68,53,254},48))
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
local slots = {_d({42,53,66,63},48), _d({31,62,53},48), _d({36,71,63},48), _d({36,56,66,53,53},48), _d({22,63,69,66},48), _d({22,57,70,53},48), _d({35,57,72},48), _d({35,53,70,53,62},48), _d({21,57,55,56,68},48), _d({30,57,62,53},48)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({30,63,62,53},48)
end
local pgui = LocalPlayer:FindFirstChild(_d({32,60,49,73,53,66,23,69,57},48))
local backpackGui = pgui and pgui:FindFirstChild(_d({18,49,51,59,64,49,51,59,23,69,57},48))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({24,63,68,50,49,66},48))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({20,53,67,57,55,62},48) and child.Name ~= _d({30,69,61,50,53,66},48) and child.Name ~= _d({37,25,28,57,67,68,28,49,73,63,69,68},48) and child.Name ~= _d({37,25,32,49,52,52,57,62,55},48) then
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
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({24,63,68,50,49,66},48))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
for _, v in ipairs(getgc(true)) do
if type(v) == _d({68,49,50,60,53},48) then
if rawget(v, _d({31,62,53},48)) ~= nil and rawget(v, _d({36,71,63},48)) ~= nil and rawget(v, _d({36,56,66,53,53},48)) ~= nil then
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
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,35,68,63,64,64,53,52,10,240},48) .. (reason or _d({52,63,62,53},48)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({61,49,62,69,49,60,240,51,60,53,49,62,69,64,240,56,63,63,59},48))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,32,240,64,66,53,67,67,53,52,240,178,80,100,240,49,50,63,66,68,57,62,55,241},48))
cleanup(_d({32,240,59,53,73,240,49,50,63,66,68},48))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,57,54,60,53,240,49,60,66,53,49,52,73,240,53,65,69,57,64,64,53,52,255,63,71,62,53,52,254},48))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,57,54,60,53,240,53,65,69,57,64,64,53,52,241},48))
end
cleanup(_d({34,57,54,60,53,240,49,60,66,53,49,52,73,240,63,71,62,53,52},48))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,30,63,68,240,53,62,63,69,55,56,240,32,53,60,57,240,68,63,240,50,69,73,240,49,240,34,57,54,60,53,240,248,3,0,0,249,240,49,62,52,240,62,63,68,240,49,68,240,36,63,71,62,240,63,54,240,18,53,55,57,62,62,57,62,55,67,254,240,32,60,53,49,67,53,240,68,66,49,70,53,60,240,68,63,240,36,63,71,62,240,63,54,240,18,53,55,57,62,62,57,62,55,67,240,68,63,240,51,56,53,67,68,240,54,49,66,61,254},48))
cleanup(_d({25,62,70,49,60,57,52,240,60,63,51,49,68,57,63,62,240,54,63,66,240,51,56,53,67,68,240,54,49,66,61,57,62,55},48))
return
end
if not _G.EasyTravel then
importLib(_d({60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48))
end
if not _G.ChestFarmer then
importLib(_d({60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49},48))
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
cleanup(_d({19,56,53,67,68,240,54,49,66,61,240,54,49,57,60,53,52,240,63,66,240,67,68,63,64,64,53,52},48))
return
end
else
error(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,240,60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49,241},48))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,30,49,70,57,55,49,68,57,62,55,240,68,63,240,50,69,73,240,34,57,54,60,53,254,254,254},48))
local buyables = Workspace:FindFirstChild(_d({18,69,73,49,50,60,53,25,68,53,61,67},48))
local shopItem = buyables and buyables:FindFirstChild(_d({34,57,54,60,53},48))
local shopPart = shopItem and shopItem:FindFirstChild(_d({35,56,63,64,32,49,66,68},48))
if not shopPart then
error(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,57,54,60,53,240,35,56,63,64,32,49,66,68,240,62,63,68,240,54,63,69,62,52,240,69,62,52,53,66,240,18,69,73,49,50,60,53,25,68,53,61,67,241},48))
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
cleanup(_d({22,49,57,60,53,52,240,68,63,240,66,53,49,51,56,240,34,57,54,60,53,240,67,56,63,64},48))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({32,66,63,72,57,61,57,68,73,32,66,63,61,64,68},48), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,32,69,66,51,56,49,67,53,52,240,34,57,54,60,53,240,64,66,63,61,64,68,240,68,66,57,55,55,53,66,53,52,254},48))
else
warn(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,54,57,66,53,64,66,63,72,57,61,57,68,73,64,66,63,61,64,68,240,62,63,68,240,67,69,64,64,63,66,68,53,52,240,50,73,240,53,72,53,51,69,68,63,66,241},48))
end
else
error(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,32,66,63,72,57,61,57,68,73,32,66,63,61,64,68,240,62,63,68,240,54,63,69,62,52,240,63,62,240,34,57,54,60,53,240,67,56,63,64,240,57,68,53,61,241},48))
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
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,21,65,69,57,64,64,57,62,55,240,34,57,54,60,53,240,54,66,63,61,240,57,62,70,53,62,68,63,66,73,254,254,254},48))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({34,57,54,60,53},48) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({31,62,53},48), _d({36,71,63},48), _d({36,56,66,53,53},48), _d({22,63,69,66},48), _d({22,57,70,53},48), _d({35,57,72},48), _d({35,53,70,53,62},48), _d({21,57,55,56,68},48), _d({30,57,62,53},48), _d({42,53,66,63},48)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({30,63,62,53},48) then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = _d({30,57,62,53},48)
end
mapping[currentSlot] = _d({34,57,54,60,53},48)
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,18,57,62,52,57,62,55,240,34,57,54,60,53,240,68,63,240,56,63,68,50,49,66,240,67,60,63,68,10,240},48) .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,57,54,60,53,240,57,67,240,49,60,66,53,49,52,73,240,61,49,64,64,53,52,240,68,63,240,56,63,68,50,49,66,240,67,60,63,68,10,240},48) .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({34,57,54,60,53},48)))
if rifleTool then
break
end
end
if not rifleTool then
warn(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,57,54,60,53,240,71,49,67,240,50,63,69,62,52,240,68,63,240,56,63,68,50,49,66,240,50,69,68,240,52,57,52,240,62,63,68,240,49,64,64,53,49,66,240,57,62,240,18,49,51,59,64,49,51,59,255,19,56,49,66,49,51,68,53,66,240,71,57,68,56,57,62,240,1,0,240,67,53,51,63,62,52,67,254},48))
cleanup(_d({34,57,54,60,53,240,66,53,64,60,57,51,49,68,57,63,62,240,68,57,61,53,63,69,68},48))
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,57,54,60,53,240,67,69,51,51,53,67,67,54,69,60,60,73,240,53,65,69,57,64,64,53,52,241},48))
end
cleanup(_d({34,57,54,60,53,240,64,69,66,51,56,49,67,53,52,252,240,56,63,68,50,49,66,240,50,63,69,62,52,252,240,49,62,52,240,53,65,69,57,64,64,53,52},48))
end)
if not ok then
warn(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,22,49,68,49,60,240,53,66,66,63,66,10,240},48) .. tostring(err))
cleanup(_d({54,49,68,49,60,240,53,66,66,63,66},48))
end
end)
end)()