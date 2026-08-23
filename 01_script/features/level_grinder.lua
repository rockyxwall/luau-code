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
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,14,57,63,50,46,49,70,237,63,66,59,59,54,59,52,238,237,14,47,60,63,65,54,59,52,237,49,66,61,57,54,48,46,65,50,237,57,46,66,59,48,53,251},51))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local UserInputService = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
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
return char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
end
local function waitForGameLoad()
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,36,46,54,65,54,59,52,237,51,60,63,237,52,46,58,50,237,65,60,237,57,60,46,49,251,251,251},51))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)) do
task.wait(0.5)
end
local folderName = _d({32,65,46,65,64},51) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,32,65,46,65,64,237,51,60,57,49,50,63,237,59,60,65,237,51,60,66,59,49,237,54,59,237,31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50,238},51))
end
statsFolder:WaitForChild(_d({32,65,46,65,64},51), 10)
statsFolder:WaitForChild(_d({22,59,67,50,59,65,60,63,70},51), 10)
statsFolder:WaitForChild(_d({32,50,65,65,54,59,52,64},51), 10)
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,20,46,58,50,237,51,66,57,57,70,237,57,60,46,49,50,49,238},51))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({32,65,46,65,64},51) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({32,65,46,65,64},51)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({25,50,67,50,57},51)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({29,50,57,54},51)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({31,54,51,57,50},51)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({31,54,51,57,50},51)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({32,65,46,65,64},51) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({22,59,67,50,59,65,60,63,70},51)) and statsFolder.Inventory:FindFirstChild(_d({22,59,67,50,59,65,60,63,70},51))
if invVal then
return invVal.Value:find(_d({239,31,54,51,57,50,239},51)) ~= nil
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
importLib(_d({57,54,47,252,50,46,64,70,44,65,63,46,67,50,57,251,57,66,46},51), _d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,63,60,48,56,70,69,68,46,57,57,252,57,66,46,66,250,48,60,49,50,252,58,46,54,59,252,253,254,44,64,48,63,54,61,65,252,57,54,47,252,50,46,64,70,44,65,63,46,67,50,57,251,57,66,46},51))
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
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,44,20,251,18,46,64,70,33,63,46,67,50,57,237,54,64,237,58,54,64,64,54,59,52,251,237,16,46,59,59,60,65,237,59,46,67,54,52,46,65,50,251},51))
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
local slots = {_d({39,50,63,60},51), _d({28,59,50},51), _d({33,68,60},51), _d({33,53,63,50,50},51), _d({19,60,66,63},51), _d({19,54,67,50},51), _d({32,54,69},51), _d({32,50,67,50,59},51), _d({18,54,52,53,65},51), _d({27,54,59,50},51)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({27,60,59,50},51)
end
local pgui = LocalPlayer:FindFirstChild(_d({29,57,46,70,50,63,20,66,54},51))
local backpackGui = pgui and pgui:FindFirstChild(_d({15,46,48,56,61,46,48,56,20,66,54},51))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({21,60,65,47,46,63},51))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({17,50,64,54,52,59},51) and child.Name ~= _d({27,66,58,47,50,63},51) and child.Name ~= _d({34,22,25,54,64,65,25,46,70,60,66,65},51) and child.Name ~= _d({34,22,29,46,49,49,54,59,52},51) then
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
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,32,65,60,61,61,50,49,7,237},51) .. (reason or _d({49,60,59,50},51)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({58,46,59,66,46,57,237,48,57,50,46,59,66,61,237,53,60,60,56},51))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,29,237,61,63,50,64,64,50,49,237,175,77,97,237,46,47,60,63,65,54,59,52,238},51))
cleanup(_d({29,237,56,50,70,237,46,47,60,63,65},51))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,31,54,51,57,50,237,46,57,63,50,46,49,70,237,50,62,66,54,61,61,50,49,252,60,68,59,50,49,251},51))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({31,54,51,57,50},51))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,31,54,51,57,50,237,50,62,66,54,61,61,50,49,238},51))
end
cleanup(_d({31,54,51,57,50,237,46,57,63,50,46,49,70,237,60,68,59,50,49},51))
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,27,60,65,237,50,59,60,66,52,53,237,29,50,57,54,237,65,60,237,47,66,70,237,46,237,31,54,51,57,50,237,245,0,253,253,246,237,46,59,49,237,59,60,65,237,46,65,237,33,60,68,59,237,60,51,237,15,50,52,54,59,59,54,59,52,64,251,237,29,57,50,46,64,50,237,65,63,46,67,50,57,237,65,60,237,33,60,68,59,237,60,51,237,15,50,52,54,59,59,54,59,52,64,237,65,60,237,48,53,50,64,65,237,51,46,63,58,251},51))
cleanup(_d({22,59,67,46,57,54,49,237,57,60,48,46,65,54,60,59,237,51,60,63,237,48,53,50,64,65,237,51,46,63,58,54,59,52},51))
return
end
if not _G.EasyTravel then
importLib(_d({57,54,47,252,50,46,64,70,44,65,63,46,67,50,57,251,57,66,46},51), _d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,63,60,48,56,70,69,68,46,57,57,252,57,66,46,66,250,48,60,49,50,252,58,46,54,59,252,253,254,44,64,48,63,54,61,65,252,57,54,47,252,50,46,64,70,44,65,63,46,67,50,57,251,57,66,46},51))
end
if not _G.ChestFarmer then
importLib(_d({57,54,47,252,48,53,50,64,65,44,51,46,63,58,50,63,251,57,66,46},51), _d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,63,60,48,56,70,69,68,46,57,57,252,57,66,46,66,250,48,60,49,50,252,58,46,54,59,252,253,254,44,64,48,63,54,61,65,252,57,54,47,252,48,53,50,64,65,44,51,46,63,58,50,63,251,57,66,46},51))
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
cleanup(_d({16,53,50,64,65,237,51,46,63,58,237,51,46,54,57,50,49,237,60,63,237,64,65,60,61,61,50,49},51))
return
end
else
error(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,19,46,54,57,50,49,237,65,60,237,57,60,46,49,237,57,54,47,252,48,53,50,64,65,44,51,46,63,58,50,63,251,57,66,46,238},51))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,27,46,67,54,52,46,65,54,59,52,237,65,60,237,47,66,70,237,31,54,51,57,50,251,251,251},51))
local buyables = Workspace:FindFirstChild(_d({15,66,70,46,47,57,50,22,65,50,58,64},51))
local shopItem = buyables and buyables:FindFirstChild(_d({31,54,51,57,50},51))
local shopPart = shopItem and shopItem:FindFirstChild(_d({32,53,60,61,29,46,63,65},51))
if not shopPart then
error(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,31,54,51,57,50,237,32,53,60,61,29,46,63,65,237,59,60,65,237,51,60,66,59,49,237,66,59,49,50,63,237,15,66,70,46,47,57,50,22,65,50,58,64,238},51))
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
cleanup(_d({19,46,54,57,50,49,237,65,60,237,63,50,46,48,53,237,31,54,51,57,50,237,64,53,60,61},51))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({29,63,60,69,54,58,54,65,70,29,63,60,58,61,65},51), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,29,66,63,48,53,46,64,50,49,237,31,54,51,57,50,237,61,63,60,58,61,65,237,65,63,54,52,52,50,63,50,49,251},51))
else
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,51,54,63,50,61,63,60,69,54,58,54,65,70,61,63,60,58,61,65,237,59,60,65,237,64,66,61,61,60,63,65,50,49,237,47,70,237,50,69,50,48,66,65,60,63,238},51))
end
else
error(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,29,63,60,69,54,58,54,65,70,29,63,60,58,61,65,237,59,60,65,237,51,60,66,59,49,237,60,59,237,31,54,51,57,50,237,64,53,60,61,237,54,65,50,58,238},51))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({18,67,50,59,65,64},51)) and ReplicatedStorage.Events:FindFirstChild(_d({32,53,60,61},51))
if shopEvent and shopEvent:IsA(_d({31,50,58,60,65,50,19,66,59,48,65,54,60,59},51)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({29,57,46,70,50,63,20,66,54},51))
local diag = pgui and pgui:FindFirstChild(_d({17,54,46,57,60,52,66,50},51))
if diag then
local closeBtn = diag:FindFirstChild(_d({16,57,60,64,50},51), true)
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
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,18,62,66,54,61,61,54,59,52,237,31,54,51,57,50,237,51,63,60,58,237,54,59,67,50,59,65,60,63,70,251,251,251},51))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({31,54,51,57,50},51) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,31,54,51,57,50,237,59,60,65,237,54,59,237,53,60,65,47,46,63,251,237,18,62,66,54,61,61,54,59,52,237,67,54,46,237,35,22,26,237,26,46,48,63,60,237,61,57,46,70,47,46,48,56,251,251,251},51))
local vim = game:GetService(_d({35,54,63,65,66,46,57,22,59,61,66,65,26,46,59,46,52,50,63},51))
local vs = workspace.CurrentCamera.ViewportSize
local function clickRelative(pctX, pctY)
local cx = vs.X * pctX
local cy = vs.Y * pctY
pcall(function()
vim:SendMouseButtonEvent(cx, cy, 0, true, game, 0)
task.wait(0.05)
vim:SendMouseButtonEvent(cx, cy, 0, false, game, 0)
end)
end
clickRelative(0.025, 0.975)
task.wait(0.8)
clickRelative(0.494, 0.377)
task.wait(0.5)
clickRelative(0.518, 0.443)
task.wait(0.5)
clickRelative(0.770, 0.655)
task.wait(0.5)
clickRelative(0.038, 0.981)
task.wait(1)
mapping = getHotbarMapping()
for slot, toolName in pairs(mapping) do
if toolName == _d({31,54,51,57,50},51) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,19,46,54,57,50,49,237,65,60,237,46,64,64,54,52,59,237,31,54,51,57,50,237,65,60,237,46,237,53,60,65,47,46,63,237,64,57,60,65,251},51))
cleanup(_d({31,54,51,57,50,237,50,62,66,54,61,237,50,63,63,60,63},51))
return
end
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,31,54,51,57,50,237,54,64,237,58,46,61,61,50,49,237,65,60,237,53,60,65,47,46,63,237,64,57,60,65,7,237},51) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({35,54,63,65,66,46,57,22,59,61,66,65,26,46,59,46,52,50,63},51))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,29,63,50,64,64,54,59,52,237,53,60,65,47,46,63,237,56,50,70,7,237},51) .. tostring(currentSlot) .. _d({237,65,60,237,61,66,57,57,237,60,66,65,237,31,54,51,57,50,251,251,251},51))
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
local rh = char and char:FindFirstChild(_d({31,54,52,53,65,21,46,59,49},51))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({31,54,51,57,50},51)) then
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
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,31,54,51,57,50,237,49,54,49,237,59,60,65,237,46,61,61,50,46,63,237,54,59,237,31,54,52,53,65,21,46,59,49,237,46,51,65,50,63,237,61,63,50,64,64,54,59,52,237,53,60,65,56,50,70,251},51))
cleanup(_d({31,54,51,57,50,237,50,62,66,54,61,237,65,54,58,50,60,66,65},51))
return
end
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,31,54,51,57,50,237,54,64,237,58,46,61,61,50,49,237,65,60,237,53,60,65,47,46,63,237,64,57,60,65,7,237},51) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({35,54,63,65,66,46,57,22,59,61,66,65,26,46,59,46,52,50,63},51))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,29,63,50,64,64,54,59,52,237,53,60,65,47,46,63,237,56,50,70,7,237},51) .. tostring(currentSlot) .. _d({237,65,60,237,61,66,57,57,237,60,66,65,237,31,54,51,57,50,251,251,251},51))
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
local rh = char and char:FindFirstChild(_d({31,54,52,53,65,21,46,59,49},51))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({31,54,51,57,50},51)) then
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
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,31,54,51,57,50,237,49,54,49,237,59,60,65,237,46,61,61,50,46,63,237,54,59,237,31,54,52,53,65,21,46,59,49,237,46,51,65,50,63,237,61,63,50,64,64,54,59,52,237,53,60,65,56,50,70,251},51))
cleanup(_d({31,54,51,57,50,237,50,62,66,54,61,237,65,54,58,50,60,66,65},51))
return
end
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,31,54,51,57,50,237,64,66,48,48,50,64,64,51,66,57,57,70,237,50,62,66,54,61,61,50,49,237,54,59,237,53,46,59,49,64,238},51))
task.wait(1)
cleanup(_d({31,54,51,57,50,237,61,66,63,48,53,46,64,50,49,249,237,53,60,65,47,46,63,237,47,60,66,59,49,249,237,46,59,49,237,50,62,66,54,61,61,50,49},51))
end)
if not ok then
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,19,46,65,46,57,237,50,63,63,60,63,7,237},51) .. tostring(err))
cleanup(_d({51,46,65,46,57,237,50,63,63,60,63},51))
end
end)
end)()