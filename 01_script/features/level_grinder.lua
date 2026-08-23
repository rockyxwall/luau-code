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
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,42,85,91,78,74,77,98,9,91,94,87,87,82,87,80,10,9,42,75,88,91,93,82,87,80,9,77,94,89,85,82,76,74,93,78,9,85,74,94,87,76,81,23},23))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local UserInputService = game:GetService(_d({62,92,78,91,50,87,89,94,93,60,78,91,95,82,76,78},23))
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
return char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
end
local function waitForGameLoad()
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,64,74,82,93,82,87,80,9,79,88,91,9,80,74,86,78,9,93,88,9,85,88,74,77,23,23,23},23))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) do
task.wait(0.5)
end
local folderName = _d({60,93,74,93,92},23) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,60,93,74,93,92,9,79,88,85,77,78,91,9,87,88,93,9,79,88,94,87,77,9,82,87,9,59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78,10},23))
end
statsFolder:WaitForChild(_d({60,93,74,93,92},23), 10)
statsFolder:WaitForChild(_d({50,87,95,78,87,93,88,91,98},23), 10)
statsFolder:WaitForChild(_d({60,78,93,93,82,87,80,92},23), 10)
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,48,74,86,78,9,79,94,85,85,98,9,85,88,74,77,78,77,10},23))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({60,93,74,93,92},23) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({60,93,74,93,92},23)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({53,78,95,78,85},23)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({57,78,85,82},23)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifle()
return LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({59,82,79,85,78},23)))
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
importLib(_d({85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23))
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
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,72,48,23,46,74,92,98,61,91,74,95,78,85,9,82,92,9,86,82,92,92,82,87,80,23,9,44,74,87,87,88,93,9,87,74,95,82,80,74,93,78,23},23))
end
return false
end
local function stopNavigation()
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
end
local function cleanup(reason)
running = false
stopNavigation()
_G.EasyTravelHelperMode = nil
_G.GepoGrinderRunning = false
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,60,93,88,89,89,78,77,35,9},23) .. (reason or _d({77,88,87,78},23)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({86,74,87,94,74,85,9,76,85,78,74,87,94,89,9,81,88,88,84},23))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,57,9,89,91,78,92,92,78,77,9,203,105,125,9,74,75,88,91,93,82,87,80,10},23))
cleanup(_d({57,9,84,78,98,9,74,75,88,91,93},23))
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifle() then
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,82,79,85,78,9,74,85,91,78,74,77,98,9,88,96,87,78,77,23},23))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,82,79,85,78,9,78,90,94,82,89,89,78,77,10},23))
end
cleanup(_d({59,82,79,85,78,9,74,85,91,78,74,77,98,9,88,96,87,78,77},23))
return
end
local _, peli = getStats()
if peli < 300 then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,55,88,93,9,78,87,88,94,80,81,9,57,78,85,82,9,93,88,9,75,94,98,9,74,9,59,82,79,85,78,9,17,28,25,25,18,9,74,87,77,9,87,88,93,9,74,93,9,61,88,96,87,9,88,79,9,43,78,80,82,87,87,82,87,80,92,23,9,57,85,78,74,92,78,9,93,91,74,95,78,85,9,93,88,9,61,88,96,87,9,88,79,9,43,78,80,82,87,87,82,87,80,92,9,93,88,9,76,81,78,92,93,9,79,74,91,86,23},23))
cleanup(_d({50,87,95,74,85,82,77,9,85,88,76,74,93,82,88,87,9,79,88,91,9,76,81,78,92,93,9,79,74,91,86,82,87,80},23))
return
end
if not _G.ChestFarmer then
importLib(_d({85,82,75,24,76,81,78,92,93,72,79,74,91,86,78,91,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,76,81,78,92,93,72,79,74,91,86,78,91,23,85,94,74},23))
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
cleanup(_d({44,81,78,92,93,9,79,74,91,86,9,79,74,82,85,78,77,9,88,91,9,92,93,88,89,89,78,77},23))
return
end
else
error(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,9,85,82,75,24,76,81,78,92,93,72,79,74,91,86,78,91,23,85,94,74,10},23))
end
end
if not running then return end
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,55,74,95,82,80,74,93,82,87,80,9,93,88,9,75,94,98,9,59,82,79,85,78,23,23,23},23))
local buyables = Workspace:FindFirstChild(_d({43,94,98,74,75,85,78,50,93,78,86,92},23))
local shopItem = buyables and buyables:FindFirstChild(_d({59,82,79,85,78},23))
local shopPart = shopItem and shopItem:FindFirstChild(_d({60,81,88,89,57,74,91,93},23))
if not shopPart then
error(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,82,79,85,78,9,60,81,88,89,57,74,91,93,9,87,88,93,9,79,88,94,87,77,9,94,87,77,78,91,9,43,94,98,74,75,85,78,50,93,78,86,92,10},23))
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
cleanup(_d({47,74,82,85,78,77,9,93,88,9,91,78,74,76,81,9,59,82,79,85,78,9,92,81,88,89},23))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({57,91,88,97,82,86,82,93,98,57,91,88,86,89,93},23), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,57,94,91,76,81,74,92,78,77,9,59,82,79,85,78,9,89,91,88,86,89,93,9,93,91,82,80,80,78,91,78,77,23},23))
else
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,79,82,91,78,89,91,88,97,82,86,82,93,98,89,91,88,86,89,93,9,87,88,93,9,92,94,89,89,88,91,93,78,77,9,75,98,9,78,97,78,76,94,93,88,91,10},23))
end
else
error(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,57,91,88,97,82,86,82,93,98,57,91,88,86,89,93,9,87,88,93,9,79,88,94,87,77,9,88,87,9,59,82,79,85,78,9,92,81,88,89,9,82,93,78,86,10},23))
end
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,64,74,82,93,82,87,80,9,79,88,91,9,59,82,79,85,78,9,93,88,9,91,78,89,85,82,76,74,93,78,9,93,88,9,43,74,76,84,89,74,76,84,23,23,23},23))
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({59,82,79,85,78},23)))
if rifleTool then
break
end
end
if not rifleTool then
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,82,79,85,78,9,96,74,92,9,89,94,91,76,81,74,92,78,77,9,75,94,93,9,77,82,77,9,87,88,93,9,74,89,89,78,74,91,9,82,87,9,43,74,76,84,89,74,76,84,24,44,81,74,91,74,76,93,78,91,9,96,82,93,81,82,87,9,26,25,9,92,78,76,88,87,77,92,23},23))
cleanup(_d({59,82,79,85,78,9,91,78,89,85,82,76,74,93,82,88,87,9,93,82,86,78,88,94,93},23))
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23))
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,82,79,85,78,9,92,94,76,76,78,92,92,79,94,85,85,98,9,78,90,94,82,89,89,78,77,10},23))
end
cleanup(_d({59,82,79,85,78,9,89,94,91,76,81,74,92,78,77,9,74,87,77,9,78,90,94,82,89,89,78,77},23))
end)
if not ok then
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,47,74,93,74,85,9,78,91,91,88,91,35,9},23) .. tostring(err))
cleanup(_d({79,74,93,74,85,9,78,91,91,88,91},23))
end
end)
end)()