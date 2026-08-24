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
print(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,48,67,63,65,70,67,66,254,36,71,81,70,75,63,76,254,33,63,84,67,255,254,49,82,77,78,78,71,76,69,254,68,74,71,69,70,82,12},34))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,36,63,71,74,67,66,254,82,77,254,71,76,71,82,71,63,74,71,88,67,254,35,63,81,87,254,50,80,63,84,67,74,12},34))
end
cleanup(_d({31,80,80,71,84,67,66,254,63,82,254,36,71,81,70,75,63,76,254,33,63,84,67},34))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,48,71,68,74,67,254,63,74,80,67,63,66,87,254,67,79,83,71,78,78,67,66,13,77,85,76,67,66,12},34))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({48,71,68,74,67},34))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,48,71,68,74,67,254,67,79,83,71,78,78,67,66,255},34))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,44,77,82,254,67,76,77,83,69,70,254,46,67,74,71,254,82,77,254,64,83,87,254,63,254,48,71,68,74,67,254,6,17,14,14,7,254,63,76,66,254,76,77,82,254,63,82,254,50,77,85,76,254,77,68,254,32,67,69,71,76,76,71,76,69,81,12,254,46,74,67,63,81,67,254,82,80,63,84,67,74,254,82,77,254,50,77,85,76,254,77,68,254,32,67,69,71,76,76,71,76,69,81,254,82,77,254,65,70,67,81,82,254,68,63,80,75,12},34))
cleanup(_d({39,76,84,63,74,71,66,254,74,77,65,63,82,71,77,76,254,68,77,80,254,65,70,67,81,82,254,68,63,80,75,71,76,69},34))
return
end
if not _G.EasyTravel then
Core.Import(_d({14,15,11,69,78,77,13,74,71,64,13,67,63,81,87,61,82,80,63,84,67,74,12,74,83,63},34), _d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,80,77,65,73,87,86,85,63,74,74,13,74,83,63,83,11,65,77,66,67,13,75,63,71,76,13,14,15,61,81,65,80,71,78,82,13,74,71,64,13,67,63,81,87,61,82,80,63,84,67,74,12,74,83,63},34))
end
if not _G.ChestFarmer then
Core.Import(_d({14,15,11,69,78,77,13,74,71,64,13,65,70,67,81,82,61,68,63,80,75,67,80,12,74,83,63},34), _d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,80,77,65,73,87,86,85,63,74,74,13,74,83,63,83,11,65,77,66,67,13,75,63,71,76,13,14,15,61,81,65,80,71,78,82,13,74,71,64,13,65,70,67,81,82,61,68,63,80,75,67,80,12,74,83,63},34))
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
cleanup(_d({33,70,67,81,82,254,68,63,80,75,254,68,63,71,74,67,66,254,77,80,254,81,82,77,78,78,67,66},34))
return
end
else
error(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,254,74,71,64,13,65,70,67,81,82,61,68,63,80,75,67,80,12,74,83,63,255},34))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,44,63,84,71,69,63,82,71,76,69,254,82,77,254,64,83,87,254,48,71,68,74,67,12,12,12},34))
local buyables = Workspace:FindFirstChild(_d({32,83,87,63,64,74,67,39,82,67,75,81},34))
local shopItem = buyables and buyables:FindFirstChild(_d({48,71,68,74,67},34))
local shopPart = shopItem and shopItem:FindFirstChild(_d({49,70,77,78,46,63,80,82},34))
if not shopPart then
error(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,48,71,68,74,67,254,49,70,77,78,46,63,80,82,254,76,77,82,254,68,77,83,76,66,254,83,76,66,67,80,254,32,83,87,63,64,74,67,39,82,67,75,81,255},34))
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
cleanup(_d({36,63,71,74,67,66,254,82,77,254,80,67,63,65,70,254,48,71,68,74,67,254,81,70,77,78},34))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({46,80,77,86,71,75,71,82,87,46,80,77,75,78,82},34), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,46,83,80,65,70,63,81,67,66,254,48,71,68,74,67,254,78,80,77,75,78,82,254,82,80,71,69,69,67,80,67,66,12},34))
else
warn(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,68,71,80,67,78,80,77,86,71,75,71,82,87,78,80,77,75,78,82,254,76,77,82,254,81,83,78,78,77,80,82,67,66,254,64,87,254,67,86,67,65,83,82,77,80,255},34))
end
else
error(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,46,80,77,86,71,75,71,82,87,46,80,77,75,78,82,254,76,77,82,254,68,77,83,76,66,254,77,76,254,48,71,68,74,67,254,81,70,77,78,254,71,82,67,75,255},34))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({35,84,67,76,82,81},34)) and ReplicatedStorage.Events:FindFirstChild(_d({49,70,77,78},34))
if shopEvent and shopEvent:IsA(_d({48,67,75,77,82,67,36,83,76,65,82,71,77,76},34)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({46,74,63,87,67,80,37,83,71},34))
local diag = pgui and pgui:FindFirstChild(_d({34,71,63,74,77,69,83,67},34))
if diag then
local closeBtn = diag:FindFirstChild(_d({33,74,77,81,67},34), true)
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
print(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,35,79,83,71,78,78,71,76,69,254,48,71,68,74,67,12,12,12},34))
local args = {
[1] = _d({67,79,83,71,78},34),
[2] = _d({48,71,68,74,67},34)
}
pcall(function()
game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34)):WaitForChild(_d({35,84,67,76,82,81},34)):WaitForChild(_d({50,77,77,74,81},34)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()