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
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,20,63,69,56,52,55,76,243,69,72,65,65,60,65,58,244,243,20,53,66,69,71,60,65,58,243,55,72,67,63,60,54,52,71,56,243,63,52,72,65,54,59,1},45))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
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
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
end
local function waitForGameLoad()
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,42,52,60,71,60,65,58,243,57,66,69,243,58,52,64,56,243,71,66,243,63,66,52,55,1,1,1},45))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)) do
task.wait(0.5)
end
local folderName = _d({38,71,52,71,70},45) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,38,71,52,71,70,243,57,66,63,55,56,69,243,65,66,71,243,57,66,72,65,55,243,60,65,243,37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56,244},45))
end
statsFolder:WaitForChild(_d({38,71,52,71,70},45), 10)
statsFolder:WaitForChild(_d({28,65,73,56,65,71,66,69,76},45), 10)
statsFolder:WaitForChild(_d({38,56,71,71,60,65,58,70},45), 10)
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,26,52,64,56,243,57,72,63,63,76,243,63,66,52,55,56,55,244},45))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({38,71,52,71,70},45)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({31,56,73,56,63},45)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({35,56,63,60},45)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({37,60,57,63,56},45)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({37,60,57,63,56},45)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({28,65,73,56,65,71,66,69,76},45)) and statsFolder.Inventory:FindFirstChild(_d({28,65,73,56,65,71,66,69,76},45))
if invVal then
return invVal.Value:find(_d({245,37,60,57,63,56,245},45)) ~= nil
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
importLib(_d({63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45))
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
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,50,26,1,24,52,70,76,39,69,52,73,56,63,243,60,70,243,64,60,70,70,60,65,58,1,243,22,52,65,65,66,71,243,65,52,73,60,58,52,71,56,1},45))
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
local slots = {_d({45,56,69,66},45), _d({34,65,56},45), _d({39,74,66},45), _d({39,59,69,56,56},45), _d({25,66,72,69},45), _d({25,60,73,56},45), _d({38,60,75},45), _d({38,56,73,56,65},45), _d({24,60,58,59,71},45), _d({33,60,65,56},45)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({33,66,65,56},45)
end
local pgui = LocalPlayer:FindFirstChild(_d({35,63,52,76,56,69,26,72,60},45))
local backpackGui = pgui and pgui:FindFirstChild(_d({21,52,54,62,67,52,54,62,26,72,60},45))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({27,66,71,53,52,69},45))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({23,56,70,60,58,65},45) and child.Name ~= _d({33,72,64,53,56,69},45) and child.Name ~= _d({40,28,31,60,70,71,31,52,76,66,72,71},45) and child.Name ~= _d({40,28,35,52,55,55,60,65,58},45) then
mapping[slot] = child.Name
break
end
end
end
end
end
return mapping
end
local function cleanup(reason)
running = false
stopNavigation()
_G.EasyTravelHelperMode = nil
_G.GepoGrinderRunning = false
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,38,71,66,67,67,56,55,13,243},45) .. (reason or _d({55,66,65,56},45)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({64,52,65,72,52,63,243,54,63,56,52,65,72,67,243,59,66,66,62},45))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,35,243,67,69,56,70,70,56,55,243,181,83,103,243,52,53,66,69,71,60,65,58,244},45))
cleanup(_d({35,243,62,56,76,243,52,53,66,69,71},45))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,37,60,57,63,56,243,52,63,69,56,52,55,76,243,56,68,72,60,67,67,56,55,2,66,74,65,56,55,1},45))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({37,60,57,63,56},45))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,37,60,57,63,56,243,56,68,72,60,67,67,56,55,244},45))
end
cleanup(_d({37,60,57,63,56,243,52,63,69,56,52,55,76,243,66,74,65,56,55},45))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,33,66,71,243,56,65,66,72,58,59,243,35,56,63,60,243,71,66,243,53,72,76,243,52,243,37,60,57,63,56,243,251,6,3,3,252,243,52,65,55,243,65,66,71,243,52,71,243,39,66,74,65,243,66,57,243,21,56,58,60,65,65,60,65,58,70,1,243,35,63,56,52,70,56,243,71,69,52,73,56,63,243,71,66,243,39,66,74,65,243,66,57,243,21,56,58,60,65,65,60,65,58,70,243,71,66,243,54,59,56,70,71,243,57,52,69,64,1},45))
cleanup(_d({28,65,73,52,63,60,55,243,63,66,54,52,71,60,66,65,243,57,66,69,243,54,59,56,70,71,243,57,52,69,64,60,65,58},45))
return
end
if not _G.EasyTravel then
importLib(_d({63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45))
end
if not _G.ChestFarmer then
importLib(_d({63,60,53,2,54,59,56,70,71,50,57,52,69,64,56,69,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,54,59,56,70,71,50,57,52,69,64,56,69,1,63,72,52},45))
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
cleanup(_d({22,59,56,70,71,243,57,52,69,64,243,57,52,60,63,56,55,243,66,69,243,70,71,66,67,67,56,55},45))
return
end
else
error(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,243,63,60,53,2,54,59,56,70,71,50,57,52,69,64,56,69,1,63,72,52,244},45))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,33,52,73,60,58,52,71,60,65,58,243,71,66,243,53,72,76,243,37,60,57,63,56,1,1,1},45))
local buyables = Workspace:FindFirstChild(_d({21,72,76,52,53,63,56,28,71,56,64,70},45))
local shopItem = buyables and buyables:FindFirstChild(_d({37,60,57,63,56},45))
local shopPart = shopItem and shopItem:FindFirstChild(_d({38,59,66,67,35,52,69,71},45))
if not shopPart then
error(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,37,60,57,63,56,243,38,59,66,67,35,52,69,71,243,65,66,71,243,57,66,72,65,55,243,72,65,55,56,69,243,21,72,76,52,53,63,56,28,71,56,64,70,244},45))
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
cleanup(_d({25,52,60,63,56,55,243,71,66,243,69,56,52,54,59,243,37,60,57,63,56,243,70,59,66,67},45))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({35,69,66,75,60,64,60,71,76,35,69,66,64,67,71},45), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,35,72,69,54,59,52,70,56,55,243,37,60,57,63,56,243,67,69,66,64,67,71,243,71,69,60,58,58,56,69,56,55,1},45))
else
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,57,60,69,56,67,69,66,75,60,64,60,71,76,67,69,66,64,67,71,243,65,66,71,243,70,72,67,67,66,69,71,56,55,243,53,76,243,56,75,56,54,72,71,66,69,244},45))
end
else
error(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,35,69,66,75,60,64,60,71,76,35,69,66,64,67,71,243,65,66,71,243,57,66,72,65,55,243,66,65,243,37,60,57,63,56,243,70,59,66,67,243,60,71,56,64,244},45))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({24,73,56,65,71,70},45)) and ReplicatedStorage.Events:FindFirstChild(_d({38,59,66,67},45))
if shopEvent and shopEvent:IsA(_d({37,56,64,66,71,56,25,72,65,54,71,60,66,65},45)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({35,63,52,76,56,69,26,72,60},45))
local diag = pgui and pgui:FindFirstChild(_d({23,60,52,63,66,58,72,56},45))
if diag then
local closeBtn = diag:FindFirstChild(_d({22,63,66,70,56},45), true)
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
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,24,68,72,60,67,67,60,65,58,243,37,60,57,63,56,243,57,69,66,64,243,60,65,73,56,65,71,66,69,76,1,1,1},45))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({37,60,57,63,56},45) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,37,60,57,63,56,243,65,66,71,243,60,65,243,59,66,71,53,52,69,1,243,24,68,72,60,67,67,60,65,58,243,73,60,52,243,60,65,73,56,65,71,66,69,76,243,40,28,1,1,1},45))
local pgui = LocalPlayer:FindFirstChild(_d({35,63,52,76,56,69,26,72,60},45))
if pgui then
local inv = pgui:FindFirstChild(_d({28,65,73,56,65,71,66,69,76},45))
local list = inv and inv:FindFirstChild(_d({32,52,60,65},45)) and inv.Main:FindFirstChild(_d({28,65,73,56,65,71,66,69,76},45)) and inv.Main.Inventory:FindFirstChild(_d({31,60,70,71},45))
local rifleBtn = list and list:FindFirstChild(_d({37,60,57,63,56},45)) and list.Rifle:FindFirstChild(_d({21,72,71,71,66,65},45))
local equipBtn = inv and inv.Main:FindFirstChild(_d({28,71,56,64,32,56,65,72},45)) and inv.Main.ItemMenu:FindFirstChild(_d({24,68,72,60,67},45))
if rifleBtn and equipBtn and getconnections then
pcall(function()
for _, c in ipairs(getconnections(rifleBtn.Activated)) do
c.Function()
end
end)
task.wait(0.2)
pcall(function()
for _, c in ipairs(getconnections(equipBtn.Activated)) do
c.Function()
end
end)
task.wait(1)
else
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,22,66,72,63,55,243,65,66,71,243,57,60,65,55,243,37,60,57,63,56,2,24,68,72,60,67,243,53,72,71,71,66,65,70,243,60,65,243,28,65,73,56,65,71,66,69,76,243,40,28,1},45))
end
end
mapping = getHotbarMapping()
for slot, toolName in pairs(mapping) do
if toolName == _d({37,60,57,63,56},45) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,25,52,60,63,56,55,243,71,66,243,52,70,70,60,58,65,243,37,60,57,63,56,243,71,66,243,52,243,59,66,71,53,52,69,243,70,63,66,71,1},45))
cleanup(_d({37,60,57,63,56,243,56,68,72,60,67,243,56,69,69,66,69},45))
return
end
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,37,60,57,63,56,243,60,70,243,64,52,67,67,56,55,243,71,66,243,59,66,71,53,52,69,243,70,63,66,71,13,243},45) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({41,60,69,71,72,52,63,28,65,67,72,71,32,52,65,52,58,56,69},45))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,35,69,56,70,70,60,65,58,243,59,66,71,53,52,69,243,62,56,76,13,243},45) .. tostring(currentSlot) .. _d({243,71,66,243,67,72,63,63,243,66,72,71,243,37,60,57,63,56,1,1,1},45))
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
local rh = char and char:FindFirstChild(_d({37,60,58,59,71,27,52,65,55},45))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({37,60,57,63,56},45)) then
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
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,37,60,57,63,56,243,55,60,55,243,65,66,71,243,52,67,67,56,52,69,243,60,65,243,37,60,58,59,71,27,52,65,55,243,52,57,71,56,69,243,67,69,56,70,70,60,65,58,243,59,66,71,62,56,76,1},45))
cleanup(_d({37,60,57,63,56,243,56,68,72,60,67,243,71,60,64,56,66,72,71},45))
return
end
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,37,60,57,63,56,243,70,72,54,54,56,70,70,57,72,63,63,76,243,56,68,72,60,67,67,56,55,243,60,65,243,59,52,65,55,70,244},45))
task.wait(1)
cleanup(_d({37,60,57,63,56,243,67,72,69,54,59,52,70,56,55,255,243,59,66,71,53,52,69,243,53,66,72,65,55,255,243,52,65,55,243,56,68,72,60,67,67,56,55},45))
end)
if not ok then
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,25,52,71,52,63,243,56,69,69,66,69,13,243},45) .. tostring(err))
cleanup(_d({57,52,71,52,63,243,56,69,69,66,69},45))
end
end)
end)()