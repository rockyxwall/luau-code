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
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,41,60,56,58,63,60,59,247,29,64,74,63,68,56,69,247,26,56,77,60,248,247,42,75,70,71,71,64,69,62,247,61,67,64,62,63,75,5},41))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,29,56,64,67,60,59,247,75,70,247,64,69,64,75,64,56,67,64,81,60,247,28,56,74,80,247,43,73,56,77,60,67,5},41))
end
cleanup(_d({24,73,73,64,77,60,59,247,56,75,247,29,64,74,63,68,56,69,247,26,56,77,60},41))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,41,64,61,67,60,247,56,67,73,60,56,59,80,247,60,72,76,64,71,71,60,59,6,70,78,69,60,59,5},41))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({41,64,61,67,60},41))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,41,64,61,67,60,247,60,72,76,64,71,71,60,59,248},41))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,37,70,75,247,60,69,70,76,62,63,247,39,60,67,64,247,75,70,247,57,76,80,247,56,247,41,64,61,67,60,247,255,10,7,7,0,247,56,69,59,247,69,70,75,247,56,75,247,43,70,78,69,247,70,61,247,25,60,62,64,69,69,64,69,62,74,5,247,39,67,60,56,74,60,247,75,73,56,77,60,67,247,75,70,247,43,70,78,69,247,70,61,247,25,60,62,64,69,69,64,69,62,74,247,75,70,247,58,63,60,74,75,247,61,56,73,68,5},41))
cleanup(_d({32,69,77,56,67,64,59,247,67,70,58,56,75,64,70,69,247,61,70,73,247,58,63,60,74,75,247,61,56,73,68,64,69,62},41))
return
end
if not _G.EasyTravel then
Core.Import(_d({7,8,4,62,71,70,6,67,64,57,6,60,56,74,80,54,75,73,56,77,60,67,5,67,76,56},41), _d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,67,76,56,76,4,58,70,59,60,6,68,56,64,69,6,7,8,54,74,58,73,64,71,75,6,67,64,57,6,60,56,74,80,54,75,73,56,77,60,67,5,67,76,56},41))
end
if not _G.ChestFarmer then
Core.Import(_d({7,8,4,62,71,70,6,67,64,57,6,58,63,60,74,75,54,61,56,73,68,60,73,5,67,76,56},41), _d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,67,76,56,76,4,58,70,59,60,6,68,56,64,69,6,7,8,54,74,58,73,64,71,75,6,67,64,57,6,58,63,60,74,75,54,61,56,73,68,60,73,5,67,76,56},41))
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
cleanup(_d({26,63,60,74,75,247,61,56,73,68,247,61,56,64,67,60,59,247,70,73,247,74,75,70,71,71,60,59},41))
return
end
else
error(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,247,67,64,57,6,58,63,60,74,75,54,61,56,73,68,60,73,5,67,76,56,248},41))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,37,56,77,64,62,56,75,64,69,62,247,75,70,247,57,76,80,247,41,64,61,67,60,5,5,5},41))
local buyables = Workspace:FindFirstChild(_d({25,76,80,56,57,67,60,32,75,60,68,74},41))
local shopItem = buyables and buyables:FindFirstChild(_d({41,64,61,67,60},41))
local shopPart = shopItem and shopItem:FindFirstChild(_d({42,63,70,71,39,56,73,75},41))
if not shopPart then
error(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,41,64,61,67,60,247,42,63,70,71,39,56,73,75,247,69,70,75,247,61,70,76,69,59,247,76,69,59,60,73,247,25,76,80,56,57,67,60,32,75,60,68,74,248},41))
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
cleanup(_d({29,56,64,67,60,59,247,75,70,247,73,60,56,58,63,247,41,64,61,67,60,247,74,63,70,71},41))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({39,73,70,79,64,68,64,75,80,39,73,70,68,71,75},41), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,39,76,73,58,63,56,74,60,59,247,41,64,61,67,60,247,71,73,70,68,71,75,247,75,73,64,62,62,60,73,60,59,5},41))
else
warn(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,61,64,73,60,71,73,70,79,64,68,64,75,80,71,73,70,68,71,75,247,69,70,75,247,74,76,71,71,70,73,75,60,59,247,57,80,247,60,79,60,58,76,75,70,73,248},41))
end
else
error(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,39,73,70,79,64,68,64,75,80,39,73,70,68,71,75,247,69,70,75,247,61,70,76,69,59,247,70,69,247,41,64,61,67,60,247,74,63,70,71,247,64,75,60,68,248},41))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({28,77,60,69,75,74},41)) and ReplicatedStorage.Events:FindFirstChild(_d({42,63,70,71},41))
if shopEvent and shopEvent:IsA(_d({41,60,68,70,75,60,29,76,69,58,75,64,70,69},41)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({39,67,56,80,60,73,30,76,64},41))
local diag = pgui and pgui:FindFirstChild(_d({27,64,56,67,70,62,76,60},41))
if diag then
local closeBtn = diag:FindFirstChild(_d({26,67,70,74,60},41), true)
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
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,28,72,76,64,71,71,64,69,62,247,41,64,61,67,60,5,5,5},41))
local args = {
[1] = _d({60,72,76,64,71},41),
[2] = _d({41,64,61,67,60},41)
}
pcall(function()
game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41)):WaitForChild(_d({28,77,60,69,75,74},41)):WaitForChild(_d({43,70,70,67,74},41)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()