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
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,3,46,52,39,35,38,59,226,52,55,48,48,43,48,41,227,226,3,36,49,52,54,43,48,41,226,38,55,50,46,43,37,35,54,39,226,46,35,55,48,37,42,240},62))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local ReplicatedStorage = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local UserInputService = game:GetService(_d({23,53,39,52,11,48,50,55,54,21,39,52,56,43,37,39},62))
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
return char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
end
local function waitForGameLoad()
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,25,35,43,54,43,48,41,226,40,49,52,226,41,35,47,39,226,54,49,226,46,49,35,38,240,240,240},62))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)) do
task.wait(0.5)
end
local folderName = _d({21,54,35,54,53},62) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,21,54,35,54,53,226,40,49,46,38,39,52,226,48,49,54,226,40,49,55,48,38,226,43,48,226,20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39,227},62))
end
statsFolder:WaitForChild(_d({21,54,35,54,53},62), 10)
statsFolder:WaitForChild(_d({11,48,56,39,48,54,49,52,59},62), 10)
statsFolder:WaitForChild(_d({21,39,54,54,43,48,41,53},62), 10)
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,9,35,47,39,226,40,55,46,46,59,226,46,49,35,38,39,38,227},62))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({21,54,35,54,53},62) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({21,54,35,54,53},62)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({14,39,56,39,46},62)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({18,39,46,43},62)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({20,43,40,46,39},62)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({20,43,40,46,39},62)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({21,54,35,54,53},62) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({11,48,56,39,48,54,49,52,59},62)) and statsFolder.Inventory:FindFirstChild(_d({11,48,56,39,48,54,49,52,59},62))
if invVal then
return invVal.Value:find(_d({228,20,43,40,46,39,228},62)) ~= nil
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
importLib(_d({46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62), _d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,46,55,35,55,239,37,49,38,39,241,47,35,43,48,241,242,243,33,53,37,52,43,50,54,241,46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62))
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
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,33,9,240,7,35,53,59,22,52,35,56,39,46,226,43,53,226,47,43,53,53,43,48,41,240,226,5,35,48,48,49,54,226,48,35,56,43,41,35,54,39,240},62))
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
local slots = {_d({28,39,52,49},62), _d({17,48,39},62), _d({22,57,49},62), _d({22,42,52,39,39},62), _d({8,49,55,52},62), _d({8,43,56,39},62), _d({21,43,58},62), _d({21,39,56,39,48},62), _d({7,43,41,42,54},62), _d({16,43,48,39},62)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({16,49,48,39},62)
end
local pgui = LocalPlayer:FindFirstChild(_d({18,46,35,59,39,52,9,55,43},62))
local backpackGui = pgui and pgui:FindFirstChild(_d({4,35,37,45,50,35,37,45,9,55,43},62))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({10,49,54,36,35,52},62))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({6,39,53,43,41,48},62) and child.Name ~= _d({16,55,47,36,39,52},62) and child.Name ~= _d({23,11,14,43,53,54,14,35,59,49,55,54},62) and child.Name ~= _d({23,11,18,35,38,38,43,48,41},62) then
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
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({10,49,54,36,35,52},62))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
local synced = false
if filtergc then
pcall(function()
local cache = filtergc(_d({54,35,36,46,39},62), { Keys = {_d({17,48,39},62), _d({22,57,49},62), _d({22,42,52,39,39},62)} }, true)
if cache and type(cache) == _d({54,35,36,46,39},62) then
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
if type(v) == _d({54,35,36,46,39},62) then
if rawget(v, _d({17,48,39},62)) ~= nil and rawget(v, _d({22,57,49},62)) ~= nil and rawget(v, _d({22,42,52,39,39},62)) ~= nil then
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
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,21,54,49,50,50,39,38,252,226},62) .. (reason or _d({38,49,48,39},62)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({47,35,48,55,35,46,226,37,46,39,35,48,55,50,226,42,49,49,45},62))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,18,226,50,52,39,53,53,39,38,226,164,66,86,226,35,36,49,52,54,43,48,41,227},62))
cleanup(_d({18,226,45,39,59,226,35,36,49,52,54},62))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,20,43,40,46,39,226,35,46,52,39,35,38,59,226,39,51,55,43,50,50,39,38,241,49,57,48,39,38,240},62))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({20,43,40,46,39},62))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,20,43,40,46,39,226,39,51,55,43,50,50,39,38,227},62))
end
cleanup(_d({20,43,40,46,39,226,35,46,52,39,35,38,59,226,49,57,48,39,38},62))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,16,49,54,226,39,48,49,55,41,42,226,18,39,46,43,226,54,49,226,36,55,59,226,35,226,20,43,40,46,39,226,234,245,242,242,235,226,35,48,38,226,48,49,54,226,35,54,226,22,49,57,48,226,49,40,226,4,39,41,43,48,48,43,48,41,53,240,226,18,46,39,35,53,39,226,54,52,35,56,39,46,226,54,49,226,22,49,57,48,226,49,40,226,4,39,41,43,48,48,43,48,41,53,226,54,49,226,37,42,39,53,54,226,40,35,52,47,240},62))
cleanup(_d({11,48,56,35,46,43,38,226,46,49,37,35,54,43,49,48,226,40,49,52,226,37,42,39,53,54,226,40,35,52,47,43,48,41},62))
return
end
if not _G.EasyTravel then
importLib(_d({46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62), _d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,46,55,35,55,239,37,49,38,39,241,47,35,43,48,241,242,243,33,53,37,52,43,50,54,241,46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62))
end
if not _G.ChestFarmer then
importLib(_d({46,43,36,241,37,42,39,53,54,33,40,35,52,47,39,52,240,46,55,35},62), _d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,46,55,35,55,239,37,49,38,39,241,47,35,43,48,241,242,243,33,53,37,52,43,50,54,241,46,43,36,241,37,42,39,53,54,33,40,35,52,47,39,52,240,46,55,35},62))
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
cleanup(_d({5,42,39,53,54,226,40,35,52,47,226,40,35,43,46,39,38,226,49,52,226,53,54,49,50,50,39,38},62))
return
end
else
error(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,226,46,43,36,241,37,42,39,53,54,33,40,35,52,47,39,52,240,46,55,35,227},62))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,16,35,56,43,41,35,54,43,48,41,226,54,49,226,36,55,59,226,20,43,40,46,39,240,240,240},62))
local buyables = Workspace:FindFirstChild(_d({4,55,59,35,36,46,39,11,54,39,47,53},62))
local shopItem = buyables and buyables:FindFirstChild(_d({20,43,40,46,39},62))
local shopPart = shopItem and shopItem:FindFirstChild(_d({21,42,49,50,18,35,52,54},62))
if not shopPart then
error(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,20,43,40,46,39,226,21,42,49,50,18,35,52,54,226,48,49,54,226,40,49,55,48,38,226,55,48,38,39,52,226,4,55,59,35,36,46,39,11,54,39,47,53,227},62))
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
cleanup(_d({8,35,43,46,39,38,226,54,49,226,52,39,35,37,42,226,20,43,40,46,39,226,53,42,49,50},62))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({18,52,49,58,43,47,43,54,59,18,52,49,47,50,54},62), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,18,55,52,37,42,35,53,39,38,226,20,43,40,46,39,226,50,52,49,47,50,54,226,54,52,43,41,41,39,52,39,38,240},62))
else
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,40,43,52,39,50,52,49,58,43,47,43,54,59,50,52,49,47,50,54,226,48,49,54,226,53,55,50,50,49,52,54,39,38,226,36,59,226,39,58,39,37,55,54,49,52,227},62))
end
else
error(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,18,52,49,58,43,47,43,54,59,18,52,49,47,50,54,226,48,49,54,226,40,49,55,48,38,226,49,48,226,20,43,40,46,39,226,53,42,49,50,226,43,54,39,47,227},62))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({7,56,39,48,54,53},62)) and ReplicatedStorage.Events:FindFirstChild(_d({21,42,49,50},62))
if shopEvent and shopEvent:IsA(_d({20,39,47,49,54,39,8,55,48,37,54,43,49,48},62)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({18,46,35,59,39,52,9,55,43},62))
local diag = pgui and pgui:FindFirstChild(_d({6,43,35,46,49,41,55,39},62))
if diag then
local closeBtn = diag:FindFirstChild(_d({5,46,49,53,39},62), true)
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
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,7,51,55,43,50,50,43,48,41,226,20,43,40,46,39,226,40,52,49,47,226,43,48,56,39,48,54,49,52,59,240,240,240},62))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({20,43,40,46,39},62) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({17,48,39},62), _d({22,57,49},62), _d({22,42,52,39,39},62), _d({8,49,55,52},62), _d({8,43,56,39},62), _d({21,43,58},62), _d({21,39,56,39,48},62), _d({7,43,41,42,54},62), _d({16,43,48,39},62), _d({28,39,52,49},62)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({16,49,48,39},62) then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = _d({16,43,48,39},62)
end
mapping[currentSlot] = _d({20,43,40,46,39},62)
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,4,43,48,38,43,48,41,226,20,43,40,46,39,226,54,49,226,42,49,54,36,35,52,226,53,46,49,54,252,226},62) .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,20,43,40,46,39,226,43,53,226,35,46,52,39,35,38,59,226,47,35,50,50,39,38,226,54,49,226,42,49,54,36,35,52,226,53,46,49,54,252,226},62) .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 3 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({20,43,40,46,39},62)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({20,43,40,46,39},62)))
if rifleTool then
break
end
end
if not rifleTool then
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,20,43,40,46,39,226,42,35,53,48,233,54,226,52,39,50,46,43,37,35,54,39,38,226,59,39,54,240,226,20,39,53,39,54,54,43,48,41,226,37,42,35,52,35,37,54,39,52,226,54,49,226,40,49,52,37,39,226,43,48,56,39,48,54,49,52,59,226,53,59,48,37,240,240,240},62))
local hum = getHumanoid()
if hum then
hum.Health = 0
end
task.wait(6)
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({20,43,40,46,39},62)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({20,43,40,46,39},62)))
if not rifleTool then
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,20,43,40,46,39,226,57,35,53,226,36,49,55,48,38,226,54,49,226,42,49,54,36,35,52,226,36,55,54,226,38,43,38,226,48,49,54,226,35,50,50,39,35,52,226,43,48,226,4,35,37,45,50,35,37,45,241,5,42,35,52,35,37,54,39,52,226,39,56,39,48,226,35,40,54,39,52,226,52,39,53,39,54,240},62))
cleanup(_d({20,43,40,46,39,226,52,39,50,46,43,37,35,54,43,49,48,226,54,43,47,39,49,55,54},62))
return
end
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({20,43,40,46,39},62))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,20,43,40,46,39,226,53,55,37,37,39,53,53,40,55,46,46,59,226,39,51,55,43,50,50,39,38,227},62))
end
cleanup(_d({20,43,40,46,39,226,50,55,52,37,42,35,53,39,38,238,226,42,49,54,36,35,52,226,36,49,55,48,38,238,226,35,48,38,226,39,51,55,43,50,50,39,38},62))
end)
if not ok then
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,8,35,54,35,46,226,39,52,52,49,52,252,226},62) .. tostring(err))
cleanup(_d({40,35,54,35,46,226,39,52,52,49,52},62))
end
end)
end)()