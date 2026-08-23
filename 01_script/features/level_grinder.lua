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
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,36,79,85,72,68,71,92,3,85,88,81,81,76,81,74,4,3,36,69,82,85,87,76,81,74,3,71,88,83,79,76,70,68,87,72,3,79,68,88,81,70,75,17},29))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({51,79,68,92,72,85,86},29))
local ReplicatedStorage = game:GetService(_d({53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72},29))
local UserInputService = game:GetService(_d({56,86,72,85,44,81,83,88,87,54,72,85,89,76,70,72},29))
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
return char and char:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
end
local function waitForGameLoad()
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,58,68,76,87,76,81,74,3,73,82,85,3,74,68,80,72,3,87,82,3,79,82,68,71,17,17,17},29))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)) do
task.wait(0.5)
end
local folderName = _d({54,87,68,87,86},29) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,54,87,68,87,86,3,73,82,79,71,72,85,3,81,82,87,3,73,82,88,81,71,3,76,81,3,53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72,4},29))
end
statsFolder:WaitForChild(_d({54,87,68,87,86},29), 10)
statsFolder:WaitForChild(_d({44,81,89,72,81,87,82,85,92},29), 10)
statsFolder:WaitForChild(_d({54,72,87,87,76,81,74,86},29), 10)
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,42,68,80,72,3,73,88,79,79,92,3,79,82,68,71,72,71,4},29))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({54,87,68,87,86},29) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({54,87,68,87,86},29)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({47,72,89,72,79},29)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({51,72,79,76},29)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({53,76,73,79,72},29)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({53,76,73,79,72},29)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({54,87,68,87,86},29) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({44,81,89,72,81,87,82,85,92},29)) and statsFolder.Inventory:FindFirstChild(_d({44,81,89,72,81,87,82,85,92},29))
if invVal then
return invVal.Value:find(_d({5,53,76,73,79,72,5},29)) ~= nil
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
importLib(_d({79,76,69,18,72,68,86,92,66,87,85,68,89,72,79,17,79,88,68},29), _d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,85,82,70,78,92,91,90,68,79,79,18,79,88,68,88,16,70,82,71,72,18,80,68,76,81,18,19,20,66,86,70,85,76,83,87,18,79,76,69,18,72,68,86,92,66,87,85,68,89,72,79,17,79,88,68},29))
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
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,66,42,17,40,68,86,92,55,85,68,89,72,79,3,76,86,3,80,76,86,86,76,81,74,17,3,38,68,81,81,82,87,3,81,68,89,76,74,68,87,72,17},29))
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
local slots = {_d({61,72,85,82},29), _d({50,81,72},29), _d({55,90,82},29), _d({55,75,85,72,72},29), _d({41,82,88,85},29), _d({41,76,89,72},29), _d({54,76,91},29), _d({54,72,89,72,81},29), _d({40,76,74,75,87},29), _d({49,76,81,72},29)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({49,82,81,72},29)
end
local pgui = LocalPlayer:FindFirstChild(_d({51,79,68,92,72,85,42,88,76},29))
local backpackGui = pgui and pgui:FindFirstChild(_d({37,68,70,78,83,68,70,78,42,88,76},29))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({43,82,87,69,68,85},29))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({39,72,86,76,74,81},29) and child.Name ~= _d({49,88,80,69,72,85},29) and child.Name ~= _d({56,44,47,76,86,87,47,68,92,82,88,87},29) and child.Name ~= _d({56,44,51,68,71,71,76,81,74},29) then
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
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,54,87,82,83,83,72,71,29,3},29) .. (reason or _d({71,82,81,72},29)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({80,68,81,88,68,79,3,70,79,72,68,81,88,83,3,75,82,82,78},29))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,51,3,83,85,72,86,86,72,71,3,197,99,119,3,68,69,82,85,87,76,81,74,4},29))
cleanup(_d({51,3,78,72,92,3,68,69,82,85,87},29))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,68,79,85,72,68,71,92,3,72,84,88,76,83,83,72,71,18,82,90,81,72,71,17},29))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({53,76,73,79,72},29))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,72,84,88,76,83,83,72,71,4},29))
end
cleanup(_d({53,76,73,79,72,3,68,79,85,72,68,71,92,3,82,90,81,72,71},29))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,49,82,87,3,72,81,82,88,74,75,3,51,72,79,76,3,87,82,3,69,88,92,3,68,3,53,76,73,79,72,3,11,22,19,19,12,3,68,81,71,3,81,82,87,3,68,87,3,55,82,90,81,3,82,73,3,37,72,74,76,81,81,76,81,74,86,17,3,51,79,72,68,86,72,3,87,85,68,89,72,79,3,87,82,3,55,82,90,81,3,82,73,3,37,72,74,76,81,81,76,81,74,86,3,87,82,3,70,75,72,86,87,3,73,68,85,80,17},29))
cleanup(_d({44,81,89,68,79,76,71,3,79,82,70,68,87,76,82,81,3,73,82,85,3,70,75,72,86,87,3,73,68,85,80,76,81,74},29))
return
end
if not _G.EasyTravel then
importLib(_d({79,76,69,18,72,68,86,92,66,87,85,68,89,72,79,17,79,88,68},29), _d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,85,82,70,78,92,91,90,68,79,79,18,79,88,68,88,16,70,82,71,72,18,80,68,76,81,18,19,20,66,86,70,85,76,83,87,18,79,76,69,18,72,68,86,92,66,87,85,68,89,72,79,17,79,88,68},29))
end
if not _G.ChestFarmer then
importLib(_d({79,76,69,18,70,75,72,86,87,66,73,68,85,80,72,85,17,79,88,68},29), _d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,85,82,70,78,92,91,90,68,79,79,18,79,88,68,88,16,70,82,71,72,18,80,68,76,81,18,19,20,66,86,70,85,76,83,87,18,79,76,69,18,70,75,72,86,87,66,73,68,85,80,72,85,17,79,88,68},29))
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
cleanup(_d({38,75,72,86,87,3,73,68,85,80,3,73,68,76,79,72,71,3,82,85,3,86,87,82,83,83,72,71},29))
return
end
else
error(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,41,68,76,79,72,71,3,87,82,3,79,82,68,71,3,79,76,69,18,70,75,72,86,87,66,73,68,85,80,72,85,17,79,88,68,4},29))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,49,68,89,76,74,68,87,76,81,74,3,87,82,3,69,88,92,3,53,76,73,79,72,17,17,17},29))
local buyables = Workspace:FindFirstChild(_d({37,88,92,68,69,79,72,44,87,72,80,86},29))
local shopItem = buyables and buyables:FindFirstChild(_d({53,76,73,79,72},29))
local shopPart = shopItem and shopItem:FindFirstChild(_d({54,75,82,83,51,68,85,87},29))
if not shopPart then
error(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,54,75,82,83,51,68,85,87,3,81,82,87,3,73,82,88,81,71,3,88,81,71,72,85,3,37,88,92,68,69,79,72,44,87,72,80,86,4},29))
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
cleanup(_d({41,68,76,79,72,71,3,87,82,3,85,72,68,70,75,3,53,76,73,79,72,3,86,75,82,83},29))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({51,85,82,91,76,80,76,87,92,51,85,82,80,83,87},29), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,51,88,85,70,75,68,86,72,71,3,53,76,73,79,72,3,83,85,82,80,83,87,3,87,85,76,74,74,72,85,72,71,17},29))
else
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,73,76,85,72,83,85,82,91,76,80,76,87,92,83,85,82,80,83,87,3,81,82,87,3,86,88,83,83,82,85,87,72,71,3,69,92,3,72,91,72,70,88,87,82,85,4},29))
end
else
error(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,51,85,82,91,76,80,76,87,92,51,85,82,80,83,87,3,81,82,87,3,73,82,88,81,71,3,82,81,3,53,76,73,79,72,3,86,75,82,83,3,76,87,72,80,4},29))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({40,89,72,81,87,86},29)) and ReplicatedStorage.Events:FindFirstChild(_d({54,75,82,83},29))
if shopEvent and shopEvent:IsA(_d({53,72,80,82,87,72,41,88,81,70,87,76,82,81},29)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({51,79,68,92,72,85,42,88,76},29))
local diag = pgui and pgui:FindFirstChild(_d({39,76,68,79,82,74,88,72},29))
if diag then
local closeBtn = diag:FindFirstChild(_d({38,79,82,86,72},29), true)
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
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,40,84,88,76,83,83,76,81,74,3,53,76,73,79,72,3,73,85,82,80,3,76,81,89,72,81,87,82,85,92,17,17,17},29))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({53,76,73,79,72},29) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,81,82,87,3,76,81,3,75,82,87,69,68,85,17,3,40,84,88,76,83,83,76,81,74,3,89,76,68,3,76,81,89,72,81,87,82,85,92,3,56,44,17,17,17},29))
local pgui = LocalPlayer:FindFirstChild(_d({51,79,68,92,72,85,42,88,76},29))
if pgui then
local inv = pgui:FindFirstChild(_d({44,81,89,72,81,87,82,85,92},29))
local list = inv and inv:FindFirstChild(_d({48,68,76,81},29)) and inv.Main:FindFirstChild(_d({44,81,89,72,81,87,82,85,92},29)) and inv.Main.Inventory:FindFirstChild(_d({47,76,86,87},29))
local rifleBtn = list and list:FindFirstChild(_d({53,76,73,79,72},29)) and list.Rifle:FindFirstChild(_d({37,88,87,87,82,81},29))
local equipBtn = inv and inv.Main:FindFirstChild(_d({44,87,72,80,48,72,81,88},29)) and inv.Main.ItemMenu:FindFirstChild(_d({40,84,88,76,83},29))
if rifleBtn and equipBtn and getconnections then
pcall(function()
inv.Main.Visible = true
end)
task.wait(0.5)
pcall(function()
for _, c in ipairs(getconnections(rifleBtn.Activated)) do
c.Function()
end
end)
task.wait(0.5)
pcall(function()
for _, c in ipairs(getconnections(equipBtn.Activated)) do
c.Function()
end
end)
task.wait(1)
pcall(function()
inv.Main.Visible = false
end)
else
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,38,82,88,79,71,3,81,82,87,3,73,76,81,71,3,53,76,73,79,72,18,40,84,88,76,83,3,69,88,87,87,82,81,86,3,76,81,3,44,81,89,72,81,87,82,85,92,3,56,44,17},29))
end
end
mapping = getHotbarMapping()
for slot, toolName in pairs(mapping) do
if toolName == _d({53,76,73,79,72},29) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,41,68,76,79,72,71,3,87,82,3,68,86,86,76,74,81,3,53,76,73,79,72,3,87,82,3,68,3,75,82,87,69,68,85,3,86,79,82,87,17},29))
cleanup(_d({53,76,73,79,72,3,72,84,88,76,83,3,72,85,85,82,85},29))
return
end
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,76,86,3,80,68,83,83,72,71,3,87,82,3,75,82,87,69,68,85,3,86,79,82,87,29,3},29) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({57,76,85,87,88,68,79,44,81,83,88,87,48,68,81,68,74,72,85},29))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,51,85,72,86,86,76,81,74,3,75,82,87,69,68,85,3,78,72,92,29,3},29) .. tostring(currentSlot) .. _d({3,87,82,3,83,88,79,79,3,82,88,87,3,53,76,73,79,72,17,17,17},29))
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
local rh = char and char:FindFirstChild(_d({53,76,74,75,87,43,68,81,71},29))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({53,76,73,79,72},29)) then
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
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,71,76,71,3,81,82,87,3,68,83,83,72,68,85,3,76,81,3,53,76,74,75,87,43,68,81,71,3,68,73,87,72,85,3,83,85,72,86,86,76,81,74,3,75,82,87,78,72,92,17},29))
cleanup(_d({53,76,73,79,72,3,72,84,88,76,83,3,87,76,80,72,82,88,87},29))
return
end
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,76,86,3,80,68,83,83,72,71,3,87,82,3,75,82,87,69,68,85,3,86,79,82,87,29,3},29) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({57,76,85,87,88,68,79,44,81,83,88,87,48,68,81,68,74,72,85},29))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,51,85,72,86,86,76,81,74,3,75,82,87,69,68,85,3,78,72,92,29,3},29) .. tostring(currentSlot) .. _d({3,87,82,3,83,88,79,79,3,82,88,87,3,53,76,73,79,72,17,17,17},29))
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
local rh = char and char:FindFirstChild(_d({53,76,74,75,87,43,68,81,71},29))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({53,76,73,79,72},29)) then
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
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,71,76,71,3,81,82,87,3,68,83,83,72,68,85,3,76,81,3,53,76,74,75,87,43,68,81,71,3,68,73,87,72,85,3,83,85,72,86,86,76,81,74,3,75,82,87,78,72,92,17},29))
cleanup(_d({53,76,73,79,72,3,72,84,88,76,83,3,87,76,80,72,82,88,87},29))
return
end
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,86,88,70,70,72,86,86,73,88,79,79,92,3,72,84,88,76,83,83,72,71,3,76,81,3,75,68,81,71,86,4},29))
task.wait(1)
cleanup(_d({53,76,73,79,72,3,83,88,85,70,75,68,86,72,71,15,3,75,82,87,69,68,85,3,69,82,88,81,71,15,3,68,81,71,3,72,84,88,76,83,83,72,71},29))
end)
if not ok then
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,41,68,87,68,79,3,72,85,85,82,85,29,3},29) .. tostring(err))
cleanup(_d({73,68,87,68,79,3,72,85,85,82,85},29))
end
end)
end)()