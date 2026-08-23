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
warn(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,8,51,57,44,40,43,64,231,57,60,53,53,48,53,46,232,231,8,41,54,57,59,48,53,46,231,43,60,55,51,48,42,40,59,44,231,51,40,60,53,42,47,245},57))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
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
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
end
local function waitForGameLoad()
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,30,40,48,59,48,53,46,231,45,54,57,231,46,40,52,44,231,59,54,231,51,54,40,43,245,245,245},57))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57)) do
task.wait(0.5)
end
local folderName = _d({26,59,40,59,58},57) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,26,59,40,59,58,231,45,54,51,43,44,57,231,53,54,59,231,45,54,60,53,43,231,48,53,231,25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44,232},57))
end
statsFolder:WaitForChild(_d({26,59,40,59,58},57), 10)
statsFolder:WaitForChild(_d({16,53,61,44,53,59,54,57,64},57), 10)
statsFolder:WaitForChild(_d({26,44,59,59,48,53,46,58},57), 10)
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,14,40,52,44,231,45,60,51,51,64,231,51,54,40,43,44,43,232},57))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({26,59,40,59,58},57)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({19,44,61,44,51},57)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({23,44,51,48},57)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({25,48,45,51,44},57)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({25,48,45,51,44},57)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({16,53,61,44,53,59,54,57,64},57)) and statsFolder.Inventory:FindFirstChild(_d({16,53,61,44,53,59,54,57,64},57))
if invVal then
return invVal.Value:find(_d({233,25,48,45,51,44,233},57)) ~= nil
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
importLib(_d({51,48,41,246,44,40,58,64,38,59,57,40,61,44,51,245,51,60,40},57), _d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,57,54,42,50,64,63,62,40,51,51,246,51,60,40,60,244,42,54,43,44,246,52,40,48,53,246,247,248,38,58,42,57,48,55,59,246,51,48,41,246,44,40,58,64,38,59,57,40,61,44,51,245,51,60,40},57))
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
warn(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,38,14,245,12,40,58,64,27,57,40,61,44,51,231,48,58,231,52,48,58,58,48,53,46,245,231,10,40,53,53,54,59,231,53,40,61,48,46,40,59,44,245},57))
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
local slots = {_d({33,44,57,54},57), _d({22,53,44},57), _d({27,62,54},57), _d({27,47,57,44,44},57), _d({13,54,60,57},57), _d({13,48,61,44},57), _d({26,48,63},57), _d({26,44,61,44,53},57), _d({12,48,46,47,59},57), _d({21,48,53,44},57)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({21,54,53,44},57)
end
local pgui = LocalPlayer:FindFirstChild(_d({23,51,40,64,44,57,14,60,48},57))
local backpackGui = pgui and pgui:FindFirstChild(_d({9,40,42,50,55,40,42,50,14,60,48},57))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({15,54,59,41,40,57},57))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({11,44,58,48,46,53},57) and child.Name ~= _d({21,60,52,41,44,57},57) and child.Name ~= _d({28,16,19,48,58,59,19,40,64,54,60,59},57) and child.Name ~= _d({28,16,23,40,43,43,48,53,46},57) then
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
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,26,59,54,55,55,44,43,1,231},57) .. (reason or _d({43,54,53,44},57)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({52,40,53,60,40,51,231,42,51,44,40,53,60,55,231,47,54,54,50},57))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,23,231,55,57,44,58,58,44,43,231,169,71,91,231,40,41,54,57,59,48,53,46,232},57))
cleanup(_d({23,231,50,44,64,231,40,41,54,57,59},57))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,25,48,45,51,44,231,40,51,57,44,40,43,64,231,44,56,60,48,55,55,44,43,246,54,62,53,44,43,245},57))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({25,48,45,51,44},57))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,25,48,45,51,44,231,44,56,60,48,55,55,44,43,232},57))
end
cleanup(_d({25,48,45,51,44,231,40,51,57,44,40,43,64,231,54,62,53,44,43},57))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,21,54,59,231,44,53,54,60,46,47,231,23,44,51,48,231,59,54,231,41,60,64,231,40,231,25,48,45,51,44,231,239,250,247,247,240,231,40,53,43,231,53,54,59,231,40,59,231,27,54,62,53,231,54,45,231,9,44,46,48,53,53,48,53,46,58,245,231,23,51,44,40,58,44,231,59,57,40,61,44,51,231,59,54,231,27,54,62,53,231,54,45,231,9,44,46,48,53,53,48,53,46,58,231,59,54,231,42,47,44,58,59,231,45,40,57,52,245},57))
cleanup(_d({16,53,61,40,51,48,43,231,51,54,42,40,59,48,54,53,231,45,54,57,231,42,47,44,58,59,231,45,40,57,52,48,53,46},57))
return
end
if not _G.EasyTravel then
importLib(_d({51,48,41,246,44,40,58,64,38,59,57,40,61,44,51,245,51,60,40},57), _d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,57,54,42,50,64,63,62,40,51,51,246,51,60,40,60,244,42,54,43,44,246,52,40,48,53,246,247,248,38,58,42,57,48,55,59,246,51,48,41,246,44,40,58,64,38,59,57,40,61,44,51,245,51,60,40},57))
end
if not _G.ChestFarmer then
importLib(_d({51,48,41,246,42,47,44,58,59,38,45,40,57,52,44,57,245,51,60,40},57), _d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,57,54,42,50,64,63,62,40,51,51,246,51,60,40,60,244,42,54,43,44,246,52,40,48,53,246,247,248,38,58,42,57,48,55,59,246,51,48,41,246,42,47,44,58,59,38,45,40,57,52,44,57,245,51,60,40},57))
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
cleanup(_d({10,47,44,58,59,231,45,40,57,52,231,45,40,48,51,44,43,231,54,57,231,58,59,54,55,55,44,43},57))
return
end
else
error(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,13,40,48,51,44,43,231,59,54,231,51,54,40,43,231,51,48,41,246,42,47,44,58,59,38,45,40,57,52,44,57,245,51,60,40,232},57))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,21,40,61,48,46,40,59,48,53,46,231,59,54,231,41,60,64,231,25,48,45,51,44,245,245,245},57))
local buyables = Workspace:FindFirstChild(_d({9,60,64,40,41,51,44,16,59,44,52,58},57))
local shopItem = buyables and buyables:FindFirstChild(_d({25,48,45,51,44},57))
local shopPart = shopItem and shopItem:FindFirstChild(_d({26,47,54,55,23,40,57,59},57))
if not shopPart then
error(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,25,48,45,51,44,231,26,47,54,55,23,40,57,59,231,53,54,59,231,45,54,60,53,43,231,60,53,43,44,57,231,9,60,64,40,41,51,44,16,59,44,52,58,232},57))
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
cleanup(_d({13,40,48,51,44,43,231,59,54,231,57,44,40,42,47,231,25,48,45,51,44,231,58,47,54,55},57))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({23,57,54,63,48,52,48,59,64,23,57,54,52,55,59},57), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,23,60,57,42,47,40,58,44,43,231,25,48,45,51,44,231,55,57,54,52,55,59,231,59,57,48,46,46,44,57,44,43,245},57))
else
warn(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,45,48,57,44,55,57,54,63,48,52,48,59,64,55,57,54,52,55,59,231,53,54,59,231,58,60,55,55,54,57,59,44,43,231,41,64,231,44,63,44,42,60,59,54,57,232},57))
end
else
error(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,23,57,54,63,48,52,48,59,64,23,57,54,52,55,59,231,53,54,59,231,45,54,60,53,43,231,54,53,231,25,48,45,51,44,231,58,47,54,55,231,48,59,44,52,232},57))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({12,61,44,53,59,58},57)) and ReplicatedStorage.Events:FindFirstChild(_d({26,47,54,55},57))
if shopEvent and shopEvent:IsA(_d({25,44,52,54,59,44,13,60,53,42,59,48,54,53},57)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({23,51,40,64,44,57,14,60,48},57))
local diag = pgui and pgui:FindFirstChild(_d({11,48,40,51,54,46,60,44},57))
if diag then
local closeBtn = diag:FindFirstChild(_d({10,51,54,58,44},57), true)
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
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,12,56,60,48,55,55,48,53,46,231,25,48,45,51,44,231,45,57,54,52,231,48,53,61,44,53,59,54,57,64,245,245,245},57))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({25,48,45,51,44},57) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,25,48,45,51,44,231,53,54,59,231,48,53,231,47,54,59,41,40,57,245,231,12,56,60,48,55,55,48,53,46,231,61,48,40,231,57,44,52,54,59,44,231,44,61,44,53,59,245,245,245},57))
local newMapping = {
Zero = _d({21,54,53,44},57), Four = _d({21,54,53,44},57), Seven = _d({21,54,53,44},57), Eight = _d({21,54,53,44},57),
Nine = _d({21,54,53,44},57), Six = _d({21,54,53,44},57), Two = _d({25,48,45,51,44},57), One = _d({20,44,51,44,44},57),
Five = _d({21,54,53,44},57), Three = _d({21,54,53,44},57)
}
local hotbarRemote = ReplicatedStorage:FindFirstChild(_d({12,61,44,53,59,58},57)) and ReplicatedStorage.Events:FindFirstChild(_d({15,54,59,41,40,57},57))
if hotbarRemote then
pcall(function()
hotbarRemote:FireServer(newMapping)
end)
else
warn(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,10,54,60,51,43,231,53,54,59,231,45,48,53,43,231,15,54,59,41,40,57,231,57,44,52,54,59,44,231,44,61,44,53,59,245},57))
end
task.wait(1)
currentSlot = _d({27,62,54},57)
end
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,25,48,45,51,44,231,48,58,231,52,40,55,55,44,43,231,59,54,231,47,54,59,41,40,57,231,58,51,54,59,1,231},57) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,23,57,44,58,58,48,53,46,231,47,54,59,41,40,57,231,50,44,64,1,231},57) .. tostring(currentSlot) .. _d({231,59,54,231,55,60,51,51,231,54,60,59,231,25,48,45,51,44,245,245,245},57))
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
local rh = char and char:FindFirstChild(_d({25,48,46,47,59,15,40,53,43},57))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({25,48,45,51,44},57)) then
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
warn(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,25,48,45,51,44,231,43,48,43,231,53,54,59,231,40,55,55,44,40,57,231,48,53,231,25,48,46,47,59,15,40,53,43,231,40,45,59,44,57,231,55,57,44,58,58,48,53,46,231,47,54,59,50,44,64,245},57))
cleanup(_d({25,48,45,51,44,231,44,56,60,48,55,231,59,48,52,44,54,60,59},57))
return
end
print(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,25,48,45,51,44,231,58,60,42,42,44,58,58,45,60,51,51,64,231,44,56,60,48,55,55,44,43,231,48,53,231,47,40,53,43,58,232},57))
task.wait(1)
cleanup(_d({25,48,45,51,44,231,55,60,57,42,47,40,58,44,43,243,231,47,54,59,41,40,57,231,41,54,60,53,43,243,231,40,53,43,231,44,56,60,48,55,55,44,43},57))
end)
if not ok then
warn(_d({34,14,44,55,54,231,14,57,48,53,43,44,57,36,231,13,40,59,40,51,231,44,57,57,54,57,1,231},57) .. tostring(err))
cleanup(_d({45,40,59,40,51,231,44,57,57,54,57},57))
end
end)
end)()