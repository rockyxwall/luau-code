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
warn(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,47,90,96,83,79,82,103,14,96,99,92,92,87,92,85,15,14,47,80,93,96,98,87,92,85,14,82,99,94,90,87,81,79,98,83,14,90,79,99,92,81,86,28},18))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
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
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
end
local function waitForGameLoad()
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,69,79,87,98,87,92,85,14,84,93,96,14,85,79,91,83,14,98,93,14,90,93,79,82,28,28,28},18))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)) do
task.wait(0.5)
end
local folderName = _d({65,98,79,98,97},18) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,65,98,79,98,97,14,84,93,90,82,83,96,14,92,93,98,14,84,93,99,92,82,14,87,92,14,64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83,15},18))
end
statsFolder:WaitForChild(_d({65,98,79,98,97},18), 10)
statsFolder:WaitForChild(_d({55,92,100,83,92,98,93,96,103},18), 10)
statsFolder:WaitForChild(_d({65,83,98,98,87,92,85,97},18), 10)
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,53,79,91,83,14,84,99,90,90,103,14,90,93,79,82,83,82,15},18))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({65,98,79,98,97},18)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({58,83,100,83,90},18)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({62,83,90,87},18)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({64,87,84,90,83},18)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({64,87,84,90,83},18)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({55,92,100,83,92,98,93,96,103},18)) and statsFolder.Inventory:FindFirstChild(_d({55,92,100,83,92,98,93,96,103},18))
if invVal then
return invVal.Value:find(_d({16,64,87,84,90,83,16},18)) ~= nil
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
importLib(_d({90,87,80,29,83,79,97,103,77,98,96,79,100,83,90,28,90,99,79},18), _d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,96,93,81,89,103,102,101,79,90,90,29,90,99,79,99,27,81,93,82,83,29,91,79,87,92,29,30,31,77,97,81,96,87,94,98,29,90,87,80,29,83,79,97,103,77,98,96,79,100,83,90,28,90,99,79},18))
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
warn(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,77,53,28,51,79,97,103,66,96,79,100,83,90,14,87,97,14,91,87,97,97,87,92,85,28,14,49,79,92,92,93,98,14,92,79,100,87,85,79,98,83,28},18))
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
local slots = {_d({72,83,96,93},18), _d({61,92,83},18), _d({66,101,93},18), _d({66,86,96,83,83},18), _d({52,93,99,96},18), _d({52,87,100,83},18), _d({65,87,102},18), _d({65,83,100,83,92},18), _d({51,87,85,86,98},18), _d({60,87,92,83},18)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({60,93,92,83},18)
end
local pgui = LocalPlayer:FindFirstChild(_d({62,90,79,103,83,96,53,99,87},18))
local backpackGui = pgui and pgui:FindFirstChild(_d({48,79,81,89,94,79,81,89,53,99,87},18))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({54,93,98,80,79,96},18))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({50,83,97,87,85,92},18) and child.Name ~= _d({60,99,91,80,83,96},18) and child.Name ~= _d({67,55,58,87,97,98,58,79,103,93,99,98},18) and child.Name ~= _d({67,55,62,79,82,82,87,92,85},18) then
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
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild(_d({54,93,98,80,79,96},18))
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
local synced = false
if filtergc then
pcall(function()
local cache = filtergc(_d({98,79,80,90,83},18), { Keys = {_d({61,92,83},18), _d({66,101,93},18), _d({66,86,96,83,83},18)} }, true)
if cache and type(cache) == _d({98,79,80,90,83},18) then
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
if type(v) == _d({98,79,80,90,83},18) then
if rawget(v, _d({61,92,83},18)) ~= nil and rawget(v, _d({66,101,93},18)) ~= nil and rawget(v, _d({66,86,96,83,83},18)) ~= nil then
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
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,65,98,93,94,94,83,82,40,14},18) .. (reason or _d({82,93,92,83},18)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({91,79,92,99,79,90,14,81,90,83,79,92,99,94,14,86,93,93,89},18))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,62,14,94,96,83,97,97,83,82,14,208,110,130,14,79,80,93,96,98,87,92,85,15},18))
cleanup(_d({62,14,89,83,103,14,79,80,93,96,98},18))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,64,87,84,90,83,14,79,90,96,83,79,82,103,14,83,95,99,87,94,94,83,82,29,93,101,92,83,82,28},18))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({64,87,84,90,83},18))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,64,87,84,90,83,14,83,95,99,87,94,94,83,82,15},18))
end
cleanup(_d({64,87,84,90,83,14,79,90,96,83,79,82,103,14,93,101,92,83,82},18))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,60,93,98,14,83,92,93,99,85,86,14,62,83,90,87,14,98,93,14,80,99,103,14,79,14,64,87,84,90,83,14,22,33,30,30,23,14,79,92,82,14,92,93,98,14,79,98,14,66,93,101,92,14,93,84,14,48,83,85,87,92,92,87,92,85,97,28,14,62,90,83,79,97,83,14,98,96,79,100,83,90,14,98,93,14,66,93,101,92,14,93,84,14,48,83,85,87,92,92,87,92,85,97,14,98,93,14,81,86,83,97,98,14,84,79,96,91,28},18))
cleanup(_d({55,92,100,79,90,87,82,14,90,93,81,79,98,87,93,92,14,84,93,96,14,81,86,83,97,98,14,84,79,96,91,87,92,85},18))
return
end
if not _G.EasyTravel then
importLib(_d({90,87,80,29,83,79,97,103,77,98,96,79,100,83,90,28,90,99,79},18), _d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,96,93,81,89,103,102,101,79,90,90,29,90,99,79,99,27,81,93,82,83,29,91,79,87,92,29,30,31,77,97,81,96,87,94,98,29,90,87,80,29,83,79,97,103,77,98,96,79,100,83,90,28,90,99,79},18))
end
if not _G.ChestFarmer then
importLib(_d({90,87,80,29,81,86,83,97,98,77,84,79,96,91,83,96,28,90,99,79},18), _d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,96,93,81,89,103,102,101,79,90,90,29,90,99,79,99,27,81,93,82,83,29,91,79,87,92,29,30,31,77,97,81,96,87,94,98,29,90,87,80,29,81,86,83,97,98,77,84,79,96,91,83,96,28,90,99,79},18))
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
cleanup(_d({49,86,83,97,98,14,84,79,96,91,14,84,79,87,90,83,82,14,93,96,14,97,98,93,94,94,83,82},18))
return
end
else
error(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,52,79,87,90,83,82,14,98,93,14,90,93,79,82,14,90,87,80,29,81,86,83,97,98,77,84,79,96,91,83,96,28,90,99,79,15},18))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,60,79,100,87,85,79,98,87,92,85,14,98,93,14,80,99,103,14,64,87,84,90,83,28,28,28},18))
local buyables = Workspace:FindFirstChild(_d({48,99,103,79,80,90,83,55,98,83,91,97},18))
local shopItem = buyables and buyables:FindFirstChild(_d({64,87,84,90,83},18))
local shopPart = shopItem and shopItem:FindFirstChild(_d({65,86,93,94,62,79,96,98},18))
if not shopPart then
error(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,64,87,84,90,83,14,65,86,93,94,62,79,96,98,14,92,93,98,14,84,93,99,92,82,14,99,92,82,83,96,14,48,99,103,79,80,90,83,55,98,83,91,97,15},18))
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
cleanup(_d({52,79,87,90,83,82,14,98,93,14,96,83,79,81,86,14,64,87,84,90,83,14,97,86,93,94},18))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({62,96,93,102,87,91,87,98,103,62,96,93,91,94,98},18), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,62,99,96,81,86,79,97,83,82,14,64,87,84,90,83,14,94,96,93,91,94,98,14,98,96,87,85,85,83,96,83,82,28},18))
else
warn(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,84,87,96,83,94,96,93,102,87,91,87,98,103,94,96,93,91,94,98,14,92,93,98,14,97,99,94,94,93,96,98,83,82,14,80,103,14,83,102,83,81,99,98,93,96,15},18))
end
else
error(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,62,96,93,102,87,91,87,98,103,62,96,93,91,94,98,14,92,93,98,14,84,93,99,92,82,14,93,92,14,64,87,84,90,83,14,97,86,93,94,14,87,98,83,91,15},18))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({51,100,83,92,98,97},18)) and ReplicatedStorage.Events:FindFirstChild(_d({65,86,93,94},18))
if shopEvent and shopEvent:IsA(_d({64,83,91,93,98,83,52,99,92,81,98,87,93,92},18)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({62,90,79,103,83,96,53,99,87},18))
local diag = pgui and pgui:FindFirstChild(_d({50,87,79,90,93,85,99,83},18))
if diag then
local closeBtn = diag:FindFirstChild(_d({49,90,93,97,83},18), true)
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
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,51,95,99,87,94,94,87,92,85,14,64,87,84,90,83,14,84,96,93,91,14,87,92,100,83,92,98,93,96,103,28,28,28},18))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({64,87,84,90,83},18) then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {_d({61,92,83},18), _d({66,101,93},18), _d({66,86,96,83,83},18), _d({52,93,99,96},18), _d({52,87,100,83},18), _d({65,87,102},18), _d({65,83,100,83,92},18), _d({51,87,85,86,98},18), _d({60,87,92,83},18), _d({72,83,96,93},18)}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == _d({60,93,92,83},18) then
currentSlot = slot
break
currentSlot = _d({60,87,92,83},18)
end
mapping[currentSlot] = _d({64,87,84,90,83},18)
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,48,87,92,82,87,92,85,14,64,87,84,90,83,14,98,93,14,86,93,98,80,79,96,14,97,90,93,98,40,14},18) .. tostring(currentSlot))
syncClientHotbar(mapping)
task.wait(1)
local vim = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,62,96,83,97,97,87,92,85,14,86,93,98,80,79,96,14,89,83,103,40,14},18) .. tostring(currentSlot) .. _d({14,98,93,14,94,99,90,90,14,93,99,98,14,64,87,84,90,83,28,28,28},18))
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
local rh = char and char:FindFirstChild(_d({64,87,85,86,98,54,79,92,82},18))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({64,87,84,90,83},18)) then
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
warn(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,64,87,84,90,83,14,82,87,82,14,92,93,98,14,79,94,94,83,79,96,14,87,92,14,64,87,85,86,98,54,79,92,82,14,79,84,98,83,96,14,94,96,83,97,97,87,92,85,14,86,93,98,89,83,103,28},18))
cleanup(_d({64,87,84,90,83,14,83,95,99,87,94,14,98,87,91,83,93,99,98},18))
return
end
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,64,87,84,90,83,14,97,99,81,81,83,97,97,84,99,90,90,103,14,83,95,99,87,94,94,83,82,14,87,92,14,86,79,92,82,97,15},18))
task.wait(1)
cleanup(_d({64,87,84,90,83,14,94,99,96,81,86,79,97,83,82,26,14,86,93,98,80,79,96,14,80,93,99,92,82,26,14,79,92,82,14,83,95,99,87,94,94,83,82},18))
end)
if not ok then
warn(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,52,79,98,79,90,14,83,96,96,93,96,40,14},18) .. tostring(err))
cleanup(_d({84,79,98,79,90,14,83,96,96,93,96},18))
end
end)
end)()