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
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,49,68,64,66,71,68,67,255,37,72,82,71,76,64,77,255,34,64,85,68,0,255,50,83,78,79,79,72,77,70,255,69,75,72,70,71,83,13},33))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,37,64,72,75,68,67,255,83,78,255,72,77,72,83,72,64,75,72,89,68,255,36,64,82,88,255,51,81,64,85,68,75,13},33))
end
cleanup(_d({32,81,81,72,85,68,67,255,64,83,255,37,72,82,71,76,64,77,255,34,64,85,68},33))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,49,72,69,75,68,255,64,75,81,68,64,67,88,255,68,80,84,72,79,79,68,67,14,78,86,77,68,67,13},33))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({49,72,69,75,68},33))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,49,72,69,75,68,255,68,80,84,72,79,79,68,67,0},33))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,45,78,83,255,68,77,78,84,70,71,255,47,68,75,72,255,83,78,255,65,84,88,255,64,255,49,72,69,75,68,255,7,18,15,15,8,255,64,77,67,255,77,78,83,255,64,83,255,51,78,86,77,255,78,69,255,33,68,70,72,77,77,72,77,70,82,13,255,47,75,68,64,82,68,255,83,81,64,85,68,75,255,83,78,255,51,78,86,77,255,78,69,255,33,68,70,72,77,77,72,77,70,82,255,83,78,255,66,71,68,82,83,255,69,64,81,76,13},33))
cleanup(_d({40,77,85,64,75,72,67,255,75,78,66,64,83,72,78,77,255,69,78,81,255,66,71,68,82,83,255,69,64,81,76,72,77,70},33))
return
end
if not _G.EasyTravel then
Core.Import(_d({15,16,12,70,79,78,14,75,72,65,14,68,64,82,88,62,83,81,64,85,68,75,13,75,84,64},33), _d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,75,84,64,84,12,66,78,67,68,14,76,64,72,77,14,15,16,62,82,66,81,72,79,83,14,75,72,65,14,68,64,82,88,62,83,81,64,85,68,75,13,75,84,64},33))
end
if not _G.ChestFarmer then
Core.Import(_d({15,16,12,70,79,78,14,75,72,65,14,66,71,68,82,83,62,69,64,81,76,68,81,13,75,84,64},33), _d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,75,84,64,84,12,66,78,67,68,14,76,64,72,77,14,15,16,62,82,66,81,72,79,83,14,75,72,65,14,66,71,68,82,83,62,69,64,81,76,68,81,13,75,84,64},33))
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
cleanup(_d({34,71,68,82,83,255,69,64,81,76,255,69,64,72,75,68,67,255,78,81,255,82,83,78,79,79,68,67},33))
return
end
else
error(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,255,75,72,65,14,66,71,68,82,83,62,69,64,81,76,68,81,13,75,84,64,0},33))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,45,64,85,72,70,64,83,72,77,70,255,83,78,255,65,84,88,255,49,72,69,75,68,13,13,13},33))
local buyables = Workspace:FindFirstChild(_d({33,84,88,64,65,75,68,40,83,68,76,82},33))
local shopItem = buyables and buyables:FindFirstChild(_d({49,72,69,75,68},33))
local shopPart = shopItem and shopItem:FindFirstChild(_d({50,71,78,79,47,64,81,83},33))
if not shopPart then
error(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,49,72,69,75,68,255,50,71,78,79,47,64,81,83,255,77,78,83,255,69,78,84,77,67,255,84,77,67,68,81,255,33,84,88,64,65,75,68,40,83,68,76,82,0},33))
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
cleanup(_d({37,64,72,75,68,67,255,83,78,255,81,68,64,66,71,255,49,72,69,75,68,255,82,71,78,79},33))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({47,81,78,87,72,76,72,83,88,47,81,78,76,79,83},33), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,47,84,81,66,71,64,82,68,67,255,49,72,69,75,68,255,79,81,78,76,79,83,255,83,81,72,70,70,68,81,68,67,13},33))
else
warn(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,69,72,81,68,79,81,78,87,72,76,72,83,88,79,81,78,76,79,83,255,77,78,83,255,82,84,79,79,78,81,83,68,67,255,65,88,255,68,87,68,66,84,83,78,81,0},33))
end
else
error(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,47,81,78,87,72,76,72,83,88,47,81,78,76,79,83,255,77,78,83,255,69,78,84,77,67,255,78,77,255,49,72,69,75,68,255,82,71,78,79,255,72,83,68,76,0},33))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({36,85,68,77,83,82},33)) and ReplicatedStorage.Events:FindFirstChild(_d({50,71,78,79},33))
if shopEvent and shopEvent:IsA(_d({49,68,76,78,83,68,37,84,77,66,83,72,78,77},33)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({47,75,64,88,68,81,38,84,72},33))
local diag = pgui and pgui:FindFirstChild(_d({35,72,64,75,78,70,84,68},33))
if diag then
local closeBtn = diag:FindFirstChild(_d({34,75,78,82,68},33), true)
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
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,36,80,84,72,79,79,72,77,70,255,49,72,69,75,68,13,13,13},33))
local args = {
[1] = _d({68,80,84,72,79},33),
[2] = _d({49,72,69,75,68},33)
}
pcall(function()
game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33)):WaitForChild(_d({36,85,68,77,83,82},33)):WaitForChild(_d({51,78,78,75,82},33)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()