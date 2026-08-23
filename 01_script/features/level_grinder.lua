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
warn(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,15,58,64,51,47,50,71,238,64,67,60,60,55,60,53,239,238,15,48,61,64,66,55,60,53,238,50,67,62,58,55,49,47,66,51,238,58,47,67,60,49,54,252},50))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
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
return char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
end
local function waitForGameLoad()
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,37,47,55,66,55,60,53,238,52,61,64,238,53,47,59,51,238,66,61,238,58,61,47,50,252,252,252},50))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)) do
task.wait(0.5)
end
local folderName = _d({33,66,47,66,65},50) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,33,66,47,66,65,238,52,61,58,50,51,64,238,60,61,66,238,52,61,67,60,50,238,55,60,238,32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51,239},50))
end
statsFolder:WaitForChild(_d({33,66,47,66,65},50), 10)
statsFolder:WaitForChild(_d({23,60,68,51,60,66,61,64,71},50), 10)
statsFolder:WaitForChild(_d({33,51,66,66,55,60,53,65},50), 10)
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,21,47,59,51,238,52,67,58,58,71,238,58,61,47,50,51,50,239},50))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({33,66,47,66,65},50)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({26,51,68,51,58},50)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({30,51,58,55},50)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({32,55,52,58,51},50)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({32,55,52,58,51},50)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({23,60,68,51,60,66,61,64,71},50)) and statsFolder.Inventory:FindFirstChild(_d({23,60,68,51,60,66,61,64,71},50))
if invVal then
return invVal.Value:find(_d({240,32,55,52,58,51,240},50)) ~= nil
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
importLib(_d({58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50), _d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50))
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
warn(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,45,21,252,19,47,65,71,34,64,47,68,51,58,238,55,65,238,59,55,65,65,55,60,53,252,238,17,47,60,60,61,66,238,60,47,68,55,53,47,66,51,252},50))
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
local slots = {_d({40,51,64,61},50), _d({29,60,51},50), _d({34,69,61},50), _d({34,54,64,51,51},50), _d({20,61,67,64},50), _d({20,55,68,51},50), _d({33,55,70},50), _d({33,51,68,51,60},50), _d({19,55,53,54,66},50), _d({28,55,60,51},50)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({28,61,60,51},50)
end
local pgui = LocalPlayer:FindFirstChild(_d({30,58,47,71,51,64,21,67,55},50))
local backpackGui = pgui and pgui:FindFirstChild(_d({16,47,49,57,62,47,49,57,21,67,55},50))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({22,61,66,48,47,64},50))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({18,51,65,55,53,60},50) and child.Name ~= _d({28,67,59,48,51,64},50) and child.Name ~= _d({35,23,26,55,65,66,26,47,71,61,67,66},50) and child.Name ~= _d({35,23,30,47,50,50,55,60,53},50) then
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
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({22,61,66,48,47,64},50))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
local synced = false
if filtergc then
pcall(function()
local cache = filtergc(_d({66,47,48,58,51},50), function(v)
return rawget(v, _d({29,60,51},50)) ~= nil and rawget(v, _d({34,69,61},50)) ~= nil and rawget(v, _d({34,54,64,51,51},50)) ~= nil
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
if type(v) == _d({66,47,48,58,51},50) then
if rawget(v, _d({29,60,51},50)) ~= nil and rawget(v, _d({34,69,61},50)) ~= nil and rawget(v, _d({34,54,64,51,51},50)) ~= nil then
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
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,33,66,61,62,62,51,50,8,238},50) .. (reason or _d({50,61,60,51},50)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({59,47,60,67,47,58,238,49,58,51,47,60,67,62,238,54,61,61,57},50))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,30,238,62,64,51,65,65,51,50,238,176,78,98,238,47,48,61,64,66,55,60,53,239},50))
cleanup(_d({30,238,57,51,71,238,47,48,61,64,66},50))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,32,55,52,58,51,238,47,58,64,51,47,50,71,238,51,63,67,55,62,62,51,50,253,61,69,60,51,50,252},50))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({32,55,52,58,51},50))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,32,55,52,58,51,238,51,63,67,55,62,62,51,50,239},50))
end
cleanup(_d({32,55,52,58,51,238,47,58,64,51,47,50,71,238,61,69,60,51,50},50))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,28,61,66,238,51,60,61,67,53,54,238,30,51,58,55,238,66,61,238,48,67,71,238,47,238,32,55,52,58,51,238,246,1,254,254,247,238,47,60,50,238,60,61,66,238,47,66,238,34,61,69,60,238,61,52,238,16,51,53,55,60,60,55,60,53,65,252,238,30,58,51,47,65,51,238,66,64,47,68,51,58,238,66,61,238,34,61,69,60,238,61,52,238,16,51,53,55,60,60,55,60,53,65,238,66,61,238,49,54,51,65,66,238,52,47,64,59,252},50))
cleanup(_d({23,60,68,47,58,55,50,238,58,61,49,47,66,55,61,60,238,52,61,64,238,49,54,51,65,66,238,52,47,64,59,55,60,53},50))
return
end
if not _G.EasyTravel then
importLib(_d({58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50), _d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50))
end
if not _G.ChestFarmer then
importLib(_d({58,55,48,253,49,54,51,65,66,45,52,47,64,59,51,64,252,58,67,47},50), _d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,49,54,51,65,66,45,52,47,64,59,51,64,252,58,67,47},50))
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
cleanup(_d({17,54,51,65,66,238,52,47,64,59,238,52,47,55,58,51,50,238,61,64,238,65,66,61,62,62,51,50},50))
return
end
else
error(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,238,58,55,48,253,49,54,51,65,66,45,52,47,64,59,51,64,252,58,67,47,239},50))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,28,47,68,55,53,47,66,55,60,53,238,66,61,238,48,67,71,238,32,55,52,58,51,252,252,252},50))
local buyables = Workspace:FindFirstChild(_d({16,67,71,47,48,58,51,23,66,51,59,65},50))
local shopItem = buyables and buyables:FindFirstChild(_d({32,55,52,58,51},50))
local shopPart = shopItem and shopItem:FindFirstChild(_d({33,54,61,62,30,47,64,66},50))
if not shopPart then
error(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,32,55,52,58,51,238,33,54,61,62,30,47,64,66,238,60,61,66,238,52,61,67,60,50,238,67,60,50,51,64,238,16,67,71,47,48,58,51,23,66,51,59,65,239},50))
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
cleanup(_d({20,47,55,58,51,50,238,66,61,238,64,51,47,49,54,238,32,55,52,58,51,238,65,54,61,62},50))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({30,64,61,70,55,59,55,66,71,30,64,61,59,62,66},50), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,30,67,64,49,54,47,65,51,50,238,32,55,52,58,51,238,62,64,61,59,62,66,238,66,64,55,53,53,51,64,51,50,252},50))
else
warn(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,52,55,64,51,62,64,61,70,55,59,55,66,71,62,64,61,59,62,66,238,60,61,66,238,65,67,62,62,61,64,66,51,50,238,48,71,238,51,70,51,49,67,66,61,64,239},50))
end
else
error(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,30,64,61,70,55,59,55,66,71,30,64,61,59,62,66,238,60,61,66,238,52,61,67,60,50,238,61,60,238,32,55,52,58,51,238,65,54,61,62,238,55,66,51,59,239},50))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local pgui = LocalPlayer:FindFirstChild(_d({30,58,47,71,51,64,21,67,55},50))
local diag = pgui and pgui:FindFirstChild(_d({18,55,47,58,61,53,67,51},50))
if diag then
for _, v in ipairs(diag:GetDescendants()) do
if v:IsA(_d({34,51,70,66,16,67,66,66,61,60},50)) or v:IsA(_d({34,51,70,66,26,47,48,51,58},50)) or v:IsA(_d({23,59,47,53,51,16,67,66,66,61,60},50)) then
local txt = (v.Text or ""):lower()
if txt:find(_d({48,67,71},50)) or txt:find(_d({62,67,64,49,54,47,65,51},50)) or txt:find(_d({71,51,65},50)) or txt:find(_d({49,61,60,52,55,64,59},50)) or txt:find(_d({64,55,52,58,51},50)) then
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
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,19,63,67,55,62,62,55,60,53,238,32,55,52,58,51,238,52,64,61,59,238,55,60,68,51,60,66,61,64,71,252,252,252},50))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({32,55,52,58,51},50) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({29,60,51},50), _d({34,69,61},50), _d({34,54,64,51,51},50), _d({20,61,67,64},50), _d({20,55,68,51},50), _d({33,55,70},50), _d({33,51,68,51,60},50), _d({19,55,53,54,66},50), _d({28,55,60,51},50), _d({40,51,64,61},50)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({28,61,60,51},50) then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = _d({28,55,60,51},50)
end
mapping[currentSlot] = _d({32,55,52,58,51},50)
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,16,55,60,50,55,60,53,238,32,55,52,58,51,238,66,61,238,54,61,66,48,47,64,238,65,58,61,66,8,238},50) .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,32,55,52,58,51,238,55,65,238,47,58,64,51,47,50,71,238,59,47,62,62,51,50,238,66,61,238,54,61,66,48,47,64,238,65,58,61,66,8,238},50) .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({32,55,52,58,51},50)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({32,55,52,58,51},50)))
if rifleTool then
break
end
end
if not rifleTool then
warn(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,32,55,52,58,51,238,69,47,65,238,48,61,67,60,50,238,66,61,238,54,61,66,48,47,64,238,48,67,66,238,50,55,50,238,60,61,66,238,47,62,62,51,47,64,238,55,60,238,16,47,49,57,62,47,49,57,253,17,54,47,64,47,49,66,51,64,238,69,55,66,54,55,60,238,255,254,238,65,51,49,61,60,50,65,252},50))
cleanup(_d({32,55,52,58,51,238,64,51,62,58,55,49,47,66,55,61,60,238,66,55,59,51,61,67,66},50))
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({32,55,52,58,51},50))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,32,55,52,58,51,238,65,67,49,49,51,65,65,52,67,58,58,71,238,51,63,67,55,62,62,51,50,239},50))
end
cleanup(_d({32,55,52,58,51,238,62,67,64,49,54,47,65,51,50,250,238,54,61,66,48,47,64,238,48,61,67,60,50,250,238,47,60,50,238,51,63,67,55,62,62,51,50},50))
end)
if not ok then
warn(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,20,47,66,47,58,238,51,64,64,61,64,8,238},50) .. tostring(err))
cleanup(_d({52,47,66,47,58,238,51,64,64,61,64},50))
end
end)
end)()