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
print(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,50,69,65,67,72,69,68,0,38,73,83,72,77,65,78,0,35,65,86,69,1,0,51,84,79,80,80,73,78,71,0,70,76,73,71,72,84,14},32))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,38,65,73,76,69,68,0,84,79,0,73,78,73,84,73,65,76,73,90,69,0,37,65,83,89,0,52,82,65,86,69,76,14},32))
end
cleanup(_d({33,82,82,73,86,69,68,0,65,84,0,38,73,83,72,77,65,78,0,35,65,86,69},32))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,50,73,70,76,69,0,65,76,82,69,65,68,89,0,69,81,85,73,80,80,69,68,15,79,87,78,69,68,14},32))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({50,73,70,76,69},32))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,50,73,70,76,69,0,69,81,85,73,80,80,69,68,1},32))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,46,79,84,0,69,78,79,85,71,72,0,48,69,76,73,0,84,79,0,66,85,89,0,65,0,50,73,70,76,69,0,8,19,16,16,9,0,65,78,68,0,78,79,84,0,65,84,0,52,79,87,78,0,79,70,0,34,69,71,73,78,78,73,78,71,83,14,0,48,76,69,65,83,69,0,84,82,65,86,69,76,0,84,79,0,52,79,87,78,0,79,70,0,34,69,71,73,78,78,73,78,71,83,0,84,79,0,67,72,69,83,84,0,70,65,82,77,14},32))
cleanup(_d({41,78,86,65,76,73,68,0,76,79,67,65,84,73,79,78,0,70,79,82,0,67,72,69,83,84,0,70,65,82,77,73,78,71},32))
return
end
if not _G.EasyTravel then
Core.Import(_d({16,17,13,71,80,79,15,76,73,66,15,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65},32), _d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65},32))
end
if not _G.ChestFarmer then
Core.Import(_d({16,17,13,71,80,79,15,76,73,66,15,67,72,69,83,84,63,70,65,82,77,69,82,14,76,85,65},32), _d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,67,72,69,83,84,63,70,65,82,77,69,82,14,76,85,65},32))
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
cleanup(_d({35,72,69,83,84,0,70,65,82,77,0,70,65,73,76,69,68,0,79,82,0,83,84,79,80,80,69,68},32))
return
end
else
error(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,0,76,73,66,15,67,72,69,83,84,63,70,65,82,77,69,82,14,76,85,65,1},32))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,46,65,86,73,71,65,84,73,78,71,0,84,79,0,66,85,89,0,50,73,70,76,69,14,14,14},32))
local buyables = Workspace:FindFirstChild(_d({34,85,89,65,66,76,69,41,84,69,77,83},32))
local shopItem = buyables and buyables:FindFirstChild(_d({50,73,70,76,69},32))
local shopPart = shopItem and shopItem:FindFirstChild(_d({51,72,79,80,48,65,82,84},32))
if not shopPart then
error(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,50,73,70,76,69,0,51,72,79,80,48,65,82,84,0,78,79,84,0,70,79,85,78,68,0,85,78,68,69,82,0,34,85,89,65,66,76,69,41,84,69,77,83,1},32))
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
cleanup(_d({38,65,73,76,69,68,0,84,79,0,82,69,65,67,72,0,50,73,70,76,69,0,83,72,79,80},32))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({48,82,79,88,73,77,73,84,89,48,82,79,77,80,84},32), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,48,85,82,67,72,65,83,69,68,0,50,73,70,76,69,0,80,82,79,77,80,84,0,84,82,73,71,71,69,82,69,68,14},32))
else
warn(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,70,73,82,69,80,82,79,88,73,77,73,84,89,80,82,79,77,80,84,0,78,79,84,0,83,85,80,80,79,82,84,69,68,0,66,89,0,69,88,69,67,85,84,79,82,1},32))
end
else
error(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,48,82,79,88,73,77,73,84,89,48,82,79,77,80,84,0,78,79,84,0,70,79,85,78,68,0,79,78,0,50,73,70,76,69,0,83,72,79,80,0,73,84,69,77,1},32))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({37,86,69,78,84,83},32)) and ReplicatedStorage.Events:FindFirstChild(_d({51,72,79,80},32))
if shopEvent and shopEvent:IsA(_d({50,69,77,79,84,69,38,85,78,67,84,73,79,78},32)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({48,76,65,89,69,82,39,85,73},32))
local diag = pgui and pgui:FindFirstChild(_d({36,73,65,76,79,71,85,69},32))
if diag then
local closeBtn = diag:FindFirstChild(_d({35,76,79,83,69},32), true)
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
print(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,37,81,85,73,80,80,73,78,71,0,50,73,70,76,69,14,14,14},32))
local args = {
[1] = _d({69,81,85,73,80},32),
[2] = _d({50,73,70,76,69},32)
}
pcall(function()
game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32)):WaitForChild(_d({37,86,69,78,84,83},32)):WaitForChild(_d({52,79,79,76,83},32)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()