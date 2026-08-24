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
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,51,70,66,68,73,70,69,1,39,74,84,73,78,66,79,1,36,66,87,70,2,1,52,85,80,81,81,74,79,72,1,71,77,74,72,73,85,15},31))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,39,66,74,77,70,69,1,85,80,1,74,79,74,85,74,66,77,74,91,70,1,38,66,84,90,1,53,83,66,87,70,77,15},31))
end
cleanup(_d({34,83,83,74,87,70,69,1,66,85,1,39,74,84,73,78,66,79,1,36,66,87,70},31))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,51,74,71,77,70,1,66,77,83,70,66,69,90,1,70,82,86,74,81,81,70,69,16,80,88,79,70,69,15},31))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({51,74,71,77,70},31))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,51,74,71,77,70,1,70,82,86,74,81,81,70,69,2},31))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,47,80,85,1,70,79,80,86,72,73,1,49,70,77,74,1,85,80,1,67,86,90,1,66,1,51,74,71,77,70,1,9,20,17,17,10,1,66,79,69,1,79,80,85,1,66,85,1,53,80,88,79,1,80,71,1,35,70,72,74,79,79,74,79,72,84,15,1,49,77,70,66,84,70,1,85,83,66,87,70,77,1,85,80,1,53,80,88,79,1,80,71,1,35,70,72,74,79,79,74,79,72,84,1,85,80,1,68,73,70,84,85,1,71,66,83,78,15},31))
cleanup(_d({42,79,87,66,77,74,69,1,77,80,68,66,85,74,80,79,1,71,80,83,1,68,73,70,84,85,1,71,66,83,78,74,79,72},31))
return
end
if not _G.EasyTravel then
Core.Import(_d({17,18,14,72,81,80,16,77,74,67,16,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31), _d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,77,86,66,86,14,68,80,69,70,16,78,66,74,79,16,17,18,64,84,68,83,74,81,85,16,77,74,67,16,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31))
end
if not _G.ChestFarmer then
Core.Import(_d({17,18,14,72,81,80,16,77,74,67,16,68,73,70,84,85,64,71,66,83,78,70,83,15,77,86,66},31), _d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,77,86,66,86,14,68,80,69,70,16,78,66,74,79,16,17,18,64,84,68,83,74,81,85,16,77,74,67,16,68,73,70,84,85,64,71,66,83,78,70,83,15,77,86,66},31))
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
cleanup(_d({36,73,70,84,85,1,71,66,83,78,1,71,66,74,77,70,69,1,80,83,1,84,85,80,81,81,70,69},31))
return
end
else
error(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,1,77,74,67,16,68,73,70,84,85,64,71,66,83,78,70,83,15,77,86,66,2},31))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,47,66,87,74,72,66,85,74,79,72,1,85,80,1,67,86,90,1,51,74,71,77,70,15,15,15},31))
local buyables = Workspace:FindFirstChild(_d({35,86,90,66,67,77,70,42,85,70,78,84},31))
local shopItem = buyables and buyables:FindFirstChild(_d({51,74,71,77,70},31))
local shopPart = shopItem and shopItem:FindFirstChild(_d({52,73,80,81,49,66,83,85},31))
if not shopPart then
error(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,51,74,71,77,70,1,52,73,80,81,49,66,83,85,1,79,80,85,1,71,80,86,79,69,1,86,79,69,70,83,1,35,86,90,66,67,77,70,42,85,70,78,84,2},31))
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
cleanup(_d({39,66,74,77,70,69,1,85,80,1,83,70,66,68,73,1,51,74,71,77,70,1,84,73,80,81},31))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({49,83,80,89,74,78,74,85,90,49,83,80,78,81,85},31), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,49,86,83,68,73,66,84,70,69,1,51,74,71,77,70,1,81,83,80,78,81,85,1,85,83,74,72,72,70,83,70,69,15},31))
else
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,71,74,83,70,81,83,80,89,74,78,74,85,90,81,83,80,78,81,85,1,79,80,85,1,84,86,81,81,80,83,85,70,69,1,67,90,1,70,89,70,68,86,85,80,83,2},31))
end
else
error(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,49,83,80,89,74,78,74,85,90,49,83,80,78,81,85,1,79,80,85,1,71,80,86,79,69,1,80,79,1,51,74,71,77,70,1,84,73,80,81,1,74,85,70,78,2},31))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({38,87,70,79,85,84},31)) and ReplicatedStorage.Events:FindFirstChild(_d({52,73,80,81},31))
if shopEvent and shopEvent:IsA(_d({51,70,78,80,85,70,39,86,79,68,85,74,80,79},31)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({49,77,66,90,70,83,40,86,74},31))
local diag = pgui and pgui:FindFirstChild(_d({37,74,66,77,80,72,86,70},31))
if diag then
local closeBtn = diag:FindFirstChild(_d({36,77,80,84,70},31), true)
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
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,38,82,86,74,81,81,74,79,72,1,51,74,71,77,70,15,15,15},31))
local args = {
[1] = _d({70,82,86,74,81},31),
[2] = _d({51,74,71,77,70},31)
}
pcall(function()
game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31)):WaitForChild(_d({38,87,70,79,85,84},31)):WaitForChild(_d({53,80,80,77,84},31)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()