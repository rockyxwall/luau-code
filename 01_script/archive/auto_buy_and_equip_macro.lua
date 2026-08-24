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
print(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,61,80,76,78,83,80,79,11,49,84,94,83,88,76,89,11,46,76,97,80,12,11,62,95,90,91,91,84,89,82,11,81,87,84,82,83,95,25},21))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,49,76,84,87,80,79,11,95,90,11,84,89,84,95,84,76,87,84,101,80,11,48,76,94,100,11,63,93,76,97,80,87,25},21))
end
cleanup(_d({44,93,93,84,97,80,79,11,76,95,11,49,84,94,83,88,76,89,11,46,76,97,80},21))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,61,84,81,87,80,11,76,87,93,80,76,79,100,11,80,92,96,84,91,91,80,79,26,90,98,89,80,79,25},21))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({61,84,81,87,80},21))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,61,84,81,87,80,11,80,92,96,84,91,91,80,79,12},21))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,57,90,95,11,80,89,90,96,82,83,11,59,80,87,84,11,95,90,11,77,96,100,11,76,11,61,84,81,87,80,11,19,30,27,27,20,11,76,89,79,11,89,90,95,11,76,95,11,63,90,98,89,11,90,81,11,45,80,82,84,89,89,84,89,82,94,25,11,59,87,80,76,94,80,11,95,93,76,97,80,87,11,95,90,11,63,90,98,89,11,90,81,11,45,80,82,84,89,89,84,89,82,94,11,95,90,11,78,83,80,94,95,11,81,76,93,88,25},21))
cleanup(_d({52,89,97,76,87,84,79,11,87,90,78,76,95,84,90,89,11,81,90,93,11,78,83,80,94,95,11,81,76,93,88,84,89,82},21))
return
end
if not _G.EasyTravel then
Core.Import(_d({27,28,24,82,91,90,26,87,84,77,26,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21), _d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,87,96,76,96,24,78,90,79,80,26,88,76,84,89,26,27,28,74,94,78,93,84,91,95,26,87,84,77,26,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21))
end
if not _G.ChestFarmer then
Core.Import(_d({27,28,24,82,91,90,26,87,84,77,26,78,83,80,94,95,74,81,76,93,88,80,93,25,87,96,76},21), _d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,87,96,76,96,24,78,90,79,80,26,88,76,84,89,26,27,28,74,94,78,93,84,91,95,26,87,84,77,26,78,83,80,94,95,74,81,76,93,88,80,93,25,87,96,76},21))
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
cleanup(_d({46,83,80,94,95,11,81,76,93,88,11,81,76,84,87,80,79,11,90,93,11,94,95,90,91,91,80,79},21))
return
end
else
error(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,11,87,84,77,26,78,83,80,94,95,74,81,76,93,88,80,93,25,87,96,76,12},21))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,57,76,97,84,82,76,95,84,89,82,11,95,90,11,77,96,100,11,61,84,81,87,80,25,25,25},21))
local buyables = Workspace:FindFirstChild(_d({45,96,100,76,77,87,80,52,95,80,88,94},21))
local shopItem = buyables and buyables:FindFirstChild(_d({61,84,81,87,80},21))
local shopPart = shopItem and shopItem:FindFirstChild(_d({62,83,90,91,59,76,93,95},21))
if not shopPart then
error(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,61,84,81,87,80,11,62,83,90,91,59,76,93,95,11,89,90,95,11,81,90,96,89,79,11,96,89,79,80,93,11,45,96,100,76,77,87,80,52,95,80,88,94,12},21))
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
cleanup(_d({49,76,84,87,80,79,11,95,90,11,93,80,76,78,83,11,61,84,81,87,80,11,94,83,90,91},21))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({59,93,90,99,84,88,84,95,100,59,93,90,88,91,95},21), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,59,96,93,78,83,76,94,80,79,11,61,84,81,87,80,11,91,93,90,88,91,95,11,95,93,84,82,82,80,93,80,79,25},21))
else
warn(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,81,84,93,80,91,93,90,99,84,88,84,95,100,91,93,90,88,91,95,11,89,90,95,11,94,96,91,91,90,93,95,80,79,11,77,100,11,80,99,80,78,96,95,90,93,12},21))
end
else
error(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,59,93,90,99,84,88,84,95,100,59,93,90,88,91,95,11,89,90,95,11,81,90,96,89,79,11,90,89,11,61,84,81,87,80,11,94,83,90,91,11,84,95,80,88,12},21))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({48,97,80,89,95,94},21)) and ReplicatedStorage.Events:FindFirstChild(_d({62,83,90,91},21))
if shopEvent and shopEvent:IsA(_d({61,80,88,90,95,80,49,96,89,78,95,84,90,89},21)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({59,87,76,100,80,93,50,96,84},21))
local diag = pgui and pgui:FindFirstChild(_d({47,84,76,87,90,82,96,80},21))
if diag then
local closeBtn = diag:FindFirstChild(_d({46,87,90,94,80},21), true)
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
print(_d({70,50,80,91,90,11,50,93,84,89,79,80,93,72,11,48,92,96,84,91,91,84,89,82,11,61,84,81,87,80,25,25,25},21))
local args = {
[1] = _d({80,92,96,84,91},21),
[2] = _d({61,84,81,87,80},21)
}
pcall(function()
game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21)):WaitForChild(_d({48,97,80,89,95,94},21)):WaitForChild(_d({63,90,90,87,94},21)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()