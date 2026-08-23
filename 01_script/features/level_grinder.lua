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
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,9,52,58,45,41,44,65,232,58,61,54,54,49,54,47,233,232,9,42,55,58,60,49,54,47,232,44,61,56,52,49,43,41,60,45,232,52,41,61,54,43,48,246},56))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
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
return char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
end
local function waitForGameLoad()
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,31,41,49,60,49,54,47,232,46,55,58,232,47,41,53,45,232,60,55,232,52,55,41,44,246,246,246},56))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56)) do
task.wait(0.5)
end
local folderName = _d({27,60,41,60,59},56) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,27,60,41,60,59,232,46,55,52,44,45,58,232,54,55,60,232,46,55,61,54,44,232,49,54,232,26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45,233},56))
end
statsFolder:WaitForChild(_d({27,60,41,60,59},56), 10)
statsFolder:WaitForChild(_d({17,54,62,45,54,60,55,58,65},56), 10)
statsFolder:WaitForChild(_d({27,45,60,60,49,54,47,59},56), 10)
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,15,41,53,45,232,46,61,52,52,65,232,52,55,41,44,45,44,233},56))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({27,60,41,60,59},56) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({27,60,41,60,59},56)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({20,45,62,45,52},56)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({24,45,52,49},56)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({26,49,46,52,45},56)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({27,60,41,60,59},56) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({17,54,62,45,54,60,55,58,65},56)) and statsFolder.Inventory:FindFirstChild(_d({17,54,62,45,54,60,55,58,65},56))
if invVal then
return invVal.Value:find(_d({234,26,49,46,52,45,234},56)) ~= nil
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
importLib(_d({52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
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
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,39,15,246,13,41,59,65,28,58,41,62,45,52,232,49,59,232,53,49,59,59,49,54,47,246,232,11,41,54,54,55,60,232,54,41,62,49,47,41,60,45,246},56))
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
local slots = {_d({34,45,58,55},56), _d({23,54,45},56), _d({28,63,55},56), _d({28,48,58,45,45},56), _d({14,55,61,58},56), _d({14,49,62,45},56), _d({27,49,64},56), _d({27,45,62,45,54},56), _d({13,49,47,48,60},56), _d({22,49,54,45},56)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({22,55,54,45},56)
end
local pgui = LocalPlayer:FindFirstChild(_d({24,52,41,65,45,58,15,61,49},56))
local backpackGui = pgui and pgui:FindFirstChild(_d({10,41,43,51,56,41,43,51,15,61,49},56))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({16,55,60,42,41,58},56))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({12,45,59,49,47,54},56) and child.Name ~= _d({22,61,53,42,45,58},56) and child.Name ~= _d({29,17,20,49,59,60,20,41,65,55,61,60},56) and child.Name ~= _d({29,17,24,41,44,44,49,54,47},56) then
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
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({16,55,60,42,41,58},56))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
local synced = false
if filtergc then
pcall(function()
local cache = filtergc(_d({60,41,42,52,45},56), { Keys = {_d({23,54,45},56), _d({28,63,55},56), _d({28,48,58,45,45},56)} }, true)
if cache and type(cache) == _d({60,41,42,52,45},56) then
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
if type(v) == _d({60,41,42,52,45},56) then
if rawget(v, _d({23,54,45},56)) ~= nil and rawget(v, _d({28,63,55},56)) ~= nil and rawget(v, _d({28,48,58,45,45},56)) ~= nil then
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
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,27,60,55,56,56,45,44,2,232},56) .. (reason or _d({44,55,54,45},56)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({53,41,54,61,41,52,232,43,52,45,41,54,61,56,232,48,55,55,51},56))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,24,232,56,58,45,59,59,45,44,232,170,72,92,232,41,42,55,58,60,49,54,47,233},56))
cleanup(_d({24,232,51,45,65,232,41,42,55,58,60},56))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,41,52,58,45,41,44,65,232,45,57,61,49,56,56,45,44,247,55,63,54,45,44,246},56))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,45,57,61,49,56,56,45,44,233},56))
end
cleanup(_d({26,49,46,52,45,232,41,52,58,45,41,44,65,232,55,63,54,45,44},56))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,22,55,60,232,45,54,55,61,47,48,232,24,45,52,49,232,60,55,232,42,61,65,232,41,232,26,49,46,52,45,232,240,251,248,248,241,232,41,54,44,232,54,55,60,232,41,60,232,28,55,63,54,232,55,46,232,10,45,47,49,54,54,49,54,47,59,246,232,24,52,45,41,59,45,232,60,58,41,62,45,52,232,60,55,232,28,55,63,54,232,55,46,232,10,45,47,49,54,54,49,54,47,59,232,60,55,232,43,48,45,59,60,232,46,41,58,53,246},56))
cleanup(_d({17,54,62,41,52,49,44,232,52,55,43,41,60,49,55,54,232,46,55,58,232,43,48,45,59,60,232,46,41,58,53,49,54,47},56))
return
end
if not _G.EasyTravel then
importLib(_d({52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
end
if not _G.ChestFarmer then
importLib(_d({52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41},56))
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
cleanup(_d({11,48,45,59,60,232,46,41,58,53,232,46,41,49,52,45,44,232,55,58,232,59,60,55,56,56,45,44},56))
return
end
else
error(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,232,52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41,233},56))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,22,41,62,49,47,41,60,49,54,47,232,60,55,232,42,61,65,232,26,49,46,52,45,246,246,246},56))
local buyables = Workspace:FindFirstChild(_d({10,61,65,41,42,52,45,17,60,45,53,59},56))
local shopItem = buyables and buyables:FindFirstChild(_d({26,49,46,52,45},56))
local shopPart = shopItem and shopItem:FindFirstChild(_d({27,48,55,56,24,41,58,60},56))
if not shopPart then
error(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,27,48,55,56,24,41,58,60,232,54,55,60,232,46,55,61,54,44,232,61,54,44,45,58,232,10,61,65,41,42,52,45,17,60,45,53,59,233},56))
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
cleanup(_d({14,41,49,52,45,44,232,60,55,232,58,45,41,43,48,232,26,49,46,52,45,232,59,48,55,56},56))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({24,58,55,64,49,53,49,60,65,24,58,55,53,56,60},56), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,24,61,58,43,48,41,59,45,44,232,26,49,46,52,45,232,56,58,55,53,56,60,232,60,58,49,47,47,45,58,45,44,246},56))
else
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,46,49,58,45,56,58,55,64,49,53,49,60,65,56,58,55,53,56,60,232,54,55,60,232,59,61,56,56,55,58,60,45,44,232,42,65,232,45,64,45,43,61,60,55,58,233},56))
end
else
error(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,24,58,55,64,49,53,49,60,65,24,58,55,53,56,60,232,54,55,60,232,46,55,61,54,44,232,55,54,232,26,49,46,52,45,232,59,48,55,56,232,49,60,45,53,233},56))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local pgui = LocalPlayer:FindFirstChild(_d({24,52,41,65,45,58,15,61,49},56))
local diag = pgui and pgui:FindFirstChild(_d({12,49,41,52,55,47,61,45},56))
if diag then
for _, v in ipairs(diag:GetDescendants()) do
if v:IsA(_d({28,45,64,60,10,61,60,60,55,54},56)) or v:IsA(_d({28,45,64,60,20,41,42,45,52},56)) or v:IsA(_d({17,53,41,47,45,10,61,60,60,55,54},56)) then
local txt = (v.Text or ""):lower()
if txt:find(_d({42,61,65},56)) or txt:find(_d({56,61,58,43,48,41,59,45},56)) or txt:find(_d({65,45,59},56)) or txt:find(_d({43,55,54,46,49,58,53},56)) or txt:find(_d({58,49,46,52,45},56)) then
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
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,13,57,61,49,56,56,49,54,47,232,26,49,46,52,45,232,46,58,55,53,232,49,54,62,45,54,60,55,58,65,246,246,246},56))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({26,49,46,52,45},56) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({23,54,45},56), _d({28,63,55},56), _d({28,48,58,45,45},56), _d({14,55,61,58},56), _d({14,49,62,45},56), _d({27,49,64},56), _d({27,45,62,45,54},56), _d({13,49,47,48,60},56), _d({22,49,54,45},56), _d({34,45,58,55},56)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({22,55,54,45},56) then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = _d({22,49,54,45},56)
end
mapping[currentSlot] = _d({26,49,46,52,45},56)
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,10,49,54,44,49,54,47,232,26,49,46,52,45,232,60,55,232,48,55,60,42,41,58,232,59,52,55,60,2,232},56) .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,49,59,232,41,52,58,45,41,44,65,232,53,41,56,56,45,44,232,60,55,232,48,55,60,42,41,58,232,59,52,55,60,2,232},56) .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({26,49,46,52,45},56)))
if rifleTool then
break
end
end
if not rifleTool then
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,63,41,59,232,42,55,61,54,44,232,60,55,232,48,55,60,42,41,58,232,42,61,60,232,44,49,44,232,54,55,60,232,41,56,56,45,41,58,232,49,54,232,10,41,43,51,56,41,43,51,247,11,48,41,58,41,43,60,45,58,232,63,49,60,48,49,54,232,249,248,232,59,45,43,55,54,44,59,246},56))
cleanup(_d({26,49,46,52,45,232,58,45,56,52,49,43,41,60,49,55,54,232,60,49,53,45,55,61,60},56))
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,59,61,43,43,45,59,59,46,61,52,52,65,232,45,57,61,49,56,56,45,44,233},56))
end
cleanup(_d({26,49,46,52,45,232,56,61,58,43,48,41,59,45,44,244,232,48,55,60,42,41,58,232,42,55,61,54,44,244,232,41,54,44,232,45,57,61,49,56,56,45,44},56))
end)
if not ok then
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,14,41,60,41,52,232,45,58,58,55,58,2,232},56) .. tostring(err))
cleanup(_d({46,41,60,41,52,232,45,58,58,55,58},56))
end
end)
end)()