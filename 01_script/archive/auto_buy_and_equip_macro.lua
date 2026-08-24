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
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,37,56,52,54,59,56,55,243,25,60,70,59,64,52,65,243,22,52,73,56,244,243,38,71,66,67,67,60,65,58,243,57,63,60,58,59,71,1},45))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,25,52,60,63,56,55,243,71,66,243,60,65,60,71,60,52,63,60,77,56,243,24,52,70,76,243,39,69,52,73,56,63,1},45))
end
cleanup(_d({20,69,69,60,73,56,55,243,52,71,243,25,60,70,59,64,52,65,243,22,52,73,56},45))
end
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
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,33,66,71,243,56,65,66,72,58,59,243,35,56,63,60,243,71,66,243,53,72,76,243,52,243,37,60,57,63,56,243,251,6,3,3,252,243,52,65,55,243,65,66,71,243,52,71,243,39,66,74,65,243,66,57,243,21,56,58,60,65,65,60,65,58,70,1,243,35,63,56,52,70,56,243,71,69,52,73,56,63,243,71,66,243,39,66,74,65,243,66,57,243,21,56,58,60,65,65,60,65,58,70,243,71,66,243,54,59,56,70,71,243,57,52,69,64,1},45))
cleanup(_d({28,65,73,52,63,60,55,243,63,66,54,52,71,60,66,65,243,57,66,69,243,54,59,56,70,71,243,57,52,69,64,60,65,58},45))
return
end
if not _G.EasyTravel then
Core.Import(_d({3,4,0,58,67,66,2,63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45))
end
if not _G.ChestFarmer then
Core.Import(_d({3,4,0,58,67,66,2,63,60,53,2,54,59,56,70,71,50,57,52,69,64,56,69,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,54,59,56,70,71,50,57,52,69,64,56,69,1,63,72,52},45))
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
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,24,68,72,60,67,67,60,65,58,243,37,60,57,63,56,1,1,1},45))
local args = {
[1] = _d({56,68,72,60,67},45),
[2] = _d({37,60,57,63,56},45)
}
pcall(function()
game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45)):WaitForChild(_d({24,73,56,65,71,70},45)):WaitForChild(_d({39,66,66,63,70},45)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()