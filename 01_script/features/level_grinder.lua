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
warn(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,29,72,78,65,61,64,85,252,78,81,74,74,69,74,67,253,252,29,62,75,78,80,69,74,67,252,64,81,76,72,69,63,61,80,65,252,72,61,81,74,63,68,10},36))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
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
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
end
local function waitForGameLoad()
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,51,61,69,80,69,74,67,252,66,75,78,252,67,61,73,65,252,80,75,252,72,75,61,64,10,10,10},36))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)) do
task.wait(0.5)
end
local folderName = _d({47,80,61,80,79},36) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,47,80,61,80,79,252,66,75,72,64,65,78,252,74,75,80,252,66,75,81,74,64,252,69,74,252,46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65,253},36))
end
statsFolder:WaitForChild(_d({47,80,61,80,79},36), 10)
statsFolder:WaitForChild(_d({37,74,82,65,74,80,75,78,85},36), 10)
statsFolder:WaitForChild(_d({47,65,80,80,69,74,67,79},36), 10)
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,35,61,73,65,252,66,81,72,72,85,252,72,75,61,64,65,64,253},36))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({47,80,61,80,79},36)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({40,65,82,65,72},36)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({44,65,72,69},36)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({46,69,66,72,65},36)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({37,74,82,65,74,80,75,78,85},36)) and statsFolder.Inventory:FindFirstChild(_d({37,74,82,65,74,80,75,78,85},36))
if invVal then
return invVal.Value:find(_d({254,46,69,66,72,65,254},36)) ~= nil
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
importLib(_d({72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36))
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
warn(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,59,35,10,33,61,79,85,48,78,61,82,65,72,252,69,79,252,73,69,79,79,69,74,67,10,252,31,61,74,74,75,80,252,74,61,82,69,67,61,80,65,10},36))
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
local slots = {_d({54,65,78,75},36), _d({43,74,65},36), _d({48,83,75},36), _d({48,68,78,65,65},36), _d({34,75,81,78},36), _d({34,69,82,65},36), _d({47,69,84},36), _d({47,65,82,65,74},36), _d({33,69,67,68,80},36), _d({42,69,74,65},36)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({42,75,74,65},36)
end
local pgui = LocalPlayer:FindFirstChild(_d({44,72,61,85,65,78,35,81,69},36))
local backpackGui = pgui and pgui:FindFirstChild(_d({30,61,63,71,76,61,63,71,35,81,69},36))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({36,75,80,62,61,78},36))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({32,65,79,69,67,74},36) and child.Name ~= _d({42,81,73,62,65,78},36) and child.Name ~= _d({49,37,40,69,79,80,40,61,85,75,81,80},36) and child.Name ~= _d({49,37,44,61,64,64,69,74,67},36) then
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
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({36,75,80,62,61,78},36))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
local synced = false
if filtergc then
pcall(function()
local cache = filtergc(_d({80,61,62,72,65},36), { Keys = {_d({43,74,65},36), _d({48,83,75},36), _d({48,68,78,65,65},36)} }, true)
if cache and type(cache) == _d({80,61,62,72,65},36) then
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
if type(v) == _d({80,61,62,72,65},36) then
if rawget(v, _d({43,74,65},36)) ~= nil and rawget(v, _d({48,83,75},36)) ~= nil and rawget(v, _d({48,68,78,65,65},36)) ~= nil then
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
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,47,80,75,76,76,65,64,22,252},36) .. (reason or _d({64,75,74,65},36)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({73,61,74,81,61,72,252,63,72,65,61,74,81,76,252,68,75,75,71},36))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,44,252,76,78,65,79,79,65,64,252,190,92,112,252,61,62,75,78,80,69,74,67,253},36))
cleanup(_d({44,252,71,65,85,252,61,62,75,78,80},36))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,46,69,66,72,65,252,61,72,78,65,61,64,85,252,65,77,81,69,76,76,65,64,11,75,83,74,65,64,10},36))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,46,69,66,72,65,252,65,77,81,69,76,76,65,64,253},36))
end
cleanup(_d({46,69,66,72,65,252,61,72,78,65,61,64,85,252,75,83,74,65,64},36))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,42,75,80,252,65,74,75,81,67,68,252,44,65,72,69,252,80,75,252,62,81,85,252,61,252,46,69,66,72,65,252,4,15,12,12,5,252,61,74,64,252,74,75,80,252,61,80,252,48,75,83,74,252,75,66,252,30,65,67,69,74,74,69,74,67,79,10,252,44,72,65,61,79,65,252,80,78,61,82,65,72,252,80,75,252,48,75,83,74,252,75,66,252,30,65,67,69,74,74,69,74,67,79,252,80,75,252,63,68,65,79,80,252,66,61,78,73,10},36))
cleanup(_d({37,74,82,61,72,69,64,252,72,75,63,61,80,69,75,74,252,66,75,78,252,63,68,65,79,80,252,66,61,78,73,69,74,67},36))
return
end
if not _G.EasyTravel then
importLib(_d({72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36))
end
if not _G.ChestFarmer then
importLib(_d({72,69,62,11,63,68,65,79,80,59,66,61,78,73,65,78,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,63,68,65,79,80,59,66,61,78,73,65,78,10,72,81,61},36))
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
cleanup(_d({31,68,65,79,80,252,66,61,78,73,252,66,61,69,72,65,64,252,75,78,252,79,80,75,76,76,65,64},36))
return
end
else
error(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,252,72,69,62,11,63,68,65,79,80,59,66,61,78,73,65,78,10,72,81,61,253},36))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,42,61,82,69,67,61,80,69,74,67,252,80,75,252,62,81,85,252,46,69,66,72,65,10,10,10},36))
local buyables = Workspace:FindFirstChild(_d({30,81,85,61,62,72,65,37,80,65,73,79},36))
local shopItem = buyables and buyables:FindFirstChild(_d({46,69,66,72,65},36))
local shopPart = shopItem and shopItem:FindFirstChild(_d({47,68,75,76,44,61,78,80},36))
if not shopPart then
error(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,46,69,66,72,65,252,47,68,75,76,44,61,78,80,252,74,75,80,252,66,75,81,74,64,252,81,74,64,65,78,252,30,81,85,61,62,72,65,37,80,65,73,79,253},36))
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
cleanup(_d({34,61,69,72,65,64,252,80,75,252,78,65,61,63,68,252,46,69,66,72,65,252,79,68,75,76},36))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({44,78,75,84,69,73,69,80,85,44,78,75,73,76,80},36), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,44,81,78,63,68,61,79,65,64,252,46,69,66,72,65,252,76,78,75,73,76,80,252,80,78,69,67,67,65,78,65,64,10},36))
else
warn(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,66,69,78,65,76,78,75,84,69,73,69,80,85,76,78,75,73,76,80,252,74,75,80,252,79,81,76,76,75,78,80,65,64,252,62,85,252,65,84,65,63,81,80,75,78,253},36))
end
else
error(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,44,78,75,84,69,73,69,80,85,44,78,75,73,76,80,252,74,75,80,252,66,75,81,74,64,252,75,74,252,46,69,66,72,65,252,79,68,75,76,252,69,80,65,73,253},36))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local pgui = LocalPlayer:FindFirstChild(_d({44,72,61,85,65,78,35,81,69},36))
local diag = pgui and pgui:FindFirstChild(_d({32,69,61,72,75,67,81,65},36))
if diag then
for _, v in ipairs(diag:GetDescendants()) do
if v:IsA(_d({48,65,84,80,30,81,80,80,75,74},36)) or v:IsA(_d({48,65,84,80,40,61,62,65,72},36)) or v:IsA(_d({37,73,61,67,65,30,81,80,80,75,74},36)) then
local txt = ""
local success, res = pcall(function() return v.Text end)
if success and type(res) == _d({79,80,78,69,74,67},36) then
txt = res:lower()
end
if txt:find(_d({62,81,85},36)) or txt:find(_d({76,81,78,63,68,61,79,65},36)) or txt:find(_d({85,65,79},36)) or txt:find(_d({63,75,74,66,69,78,73},36)) or txt:find(_d({78,69,66,72,65},36)) then
if getconnections then
pcall(function()
for _, conn in ipairs(getconnections(v.Activated)) do
conn:Fire()
end
end)
pcall(function()
for _, conn in ipairs(getconnections(v.MouseButton1Click)) do
conn:Fire()
end
end)
end
end
end
end
end
if hasRifleInInventory() then
break
end
end
end
if not running then return end
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,33,77,81,69,76,76,69,74,67,252,46,69,66,72,65,252,66,78,75,73,252,69,74,82,65,74,80,75,78,85,10,10,10},36))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({46,69,66,72,65},36) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({43,74,65},36), _d({48,83,75},36), _d({48,68,78,65,65},36), _d({34,75,81,78},36), _d({34,69,82,65},36), _d({47,69,84},36), _d({47,65,82,65,74},36), _d({33,69,67,68,80},36), _d({42,69,74,65},36), _d({54,65,78,75},36)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({42,75,74,65},36) then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = _d({42,69,74,65},36)
end
mapping[currentSlot] = _d({46,69,66,72,65},36)
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,30,69,74,64,69,74,67,252,46,69,66,72,65,252,80,75,252,68,75,80,62,61,78,252,79,72,75,80,22,252},36) .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,46,69,66,72,65,252,69,79,252,61,72,78,65,61,64,85,252,73,61,76,76,65,64,252,80,75,252,68,75,80,62,61,78,252,79,72,75,80,22,252},36) .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({46,69,66,72,65},36)))
if rifleTool then
break
end
end
if not rifleTool then
warn(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,46,69,66,72,65,252,83,61,79,252,62,75,81,74,64,252,80,75,252,68,75,80,62,61,78,252,62,81,80,252,64,69,64,252,74,75,80,252,61,76,76,65,61,78,252,69,74,252,30,61,63,71,76,61,63,71,11,31,68,61,78,61,63,80,65,78,252,83,69,80,68,69,74,252,13,12,252,79,65,63,75,74,64,79,10},36))
cleanup(_d({46,69,66,72,65,252,78,65,76,72,69,63,61,80,69,75,74,252,80,69,73,65,75,81,80},36))
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,46,69,66,72,65,252,79,81,63,63,65,79,79,66,81,72,72,85,252,65,77,81,69,76,76,65,64,253},36))
end
cleanup(_d({46,69,66,72,65,252,76,81,78,63,68,61,79,65,64,8,252,68,75,80,62,61,78,252,62,75,81,74,64,8,252,61,74,64,252,65,77,81,69,76,76,65,64},36))
end)
if not ok then
warn(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,34,61,80,61,72,252,65,78,78,75,78,22,252},36) .. tostring(err))
cleanup(_d({66,61,80,61,72,252,65,78,78,75,78},36))
end
end)
end)()