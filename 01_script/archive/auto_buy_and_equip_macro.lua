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
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,44,63,59,61,66,63,62,250,32,67,77,66,71,59,72,250,29,59,80,63,251,250,45,78,73,74,74,67,72,65,250,64,70,67,65,66,78,8},38))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,32,59,67,70,63,62,250,78,73,250,67,72,67,78,67,59,70,67,84,63,250,31,59,77,83,250,46,76,59,80,63,70,8},38))
end
cleanup(_d({27,76,76,67,80,63,62,250,59,78,250,32,67,77,66,71,59,72,250,29,59,80,63},38))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,44,67,64,70,63,250,59,70,76,63,59,62,83,250,63,75,79,67,74,74,63,62,9,73,81,72,63,62,8},38))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({44,67,64,70,63},38))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,44,67,64,70,63,250,63,75,79,67,74,74,63,62,251},38))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,40,73,78,250,63,72,73,79,65,66,250,42,63,70,67,250,78,73,250,60,79,83,250,59,250,44,67,64,70,63,250,2,13,10,10,3,250,59,72,62,250,72,73,78,250,59,78,250,46,73,81,72,250,73,64,250,28,63,65,67,72,72,67,72,65,77,8,250,42,70,63,59,77,63,250,78,76,59,80,63,70,250,78,73,250,46,73,81,72,250,73,64,250,28,63,65,67,72,72,67,72,65,77,250,78,73,250,61,66,63,77,78,250,64,59,76,71,8},38))
cleanup(_d({35,72,80,59,70,67,62,250,70,73,61,59,78,67,73,72,250,64,73,76,250,61,66,63,77,78,250,64,59,76,71,67,72,65},38))
return
end
if not _G.EasyTravel then
Core.Import(_d({10,11,7,65,74,73,9,70,67,60,9,63,59,77,83,57,78,76,59,80,63,70,8,70,79,59},38), _d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,76,73,61,69,83,82,81,59,70,70,9,70,79,59,79,7,61,73,62,63,9,71,59,67,72,9,10,11,57,77,61,76,67,74,78,9,70,67,60,9,63,59,77,83,57,78,76,59,80,63,70,8,70,79,59},38))
end
if not _G.ChestFarmer then
Core.Import(_d({10,11,7,65,74,73,9,70,67,60,9,61,66,63,77,78,57,64,59,76,71,63,76,8,70,79,59},38), _d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,76,73,61,69,83,82,81,59,70,70,9,70,79,59,79,7,61,73,62,63,9,71,59,67,72,9,10,11,57,77,61,76,67,74,78,9,70,67,60,9,61,66,63,77,78,57,64,59,76,71,63,76,8,70,79,59},38))
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
cleanup(_d({29,66,63,77,78,250,64,59,76,71,250,64,59,67,70,63,62,250,73,76,250,77,78,73,74,74,63,62},38))
return
end
else
error(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,32,59,67,70,63,62,250,78,73,250,70,73,59,62,250,70,67,60,9,61,66,63,77,78,57,64,59,76,71,63,76,8,70,79,59,251},38))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,40,59,80,67,65,59,78,67,72,65,250,78,73,250,60,79,83,250,44,67,64,70,63,8,8,8},38))
local buyables = Workspace:FindFirstChild(_d({28,79,83,59,60,70,63,35,78,63,71,77},38))
local shopItem = buyables and buyables:FindFirstChild(_d({44,67,64,70,63},38))
local shopPart = shopItem and shopItem:FindFirstChild(_d({45,66,73,74,42,59,76,78},38))
if not shopPart then
error(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,44,67,64,70,63,250,45,66,73,74,42,59,76,78,250,72,73,78,250,64,73,79,72,62,250,79,72,62,63,76,250,28,79,83,59,60,70,63,35,78,63,71,77,251},38))
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
cleanup(_d({32,59,67,70,63,62,250,78,73,250,76,63,59,61,66,250,44,67,64,70,63,250,77,66,73,74},38))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({42,76,73,82,67,71,67,78,83,42,76,73,71,74,78},38), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,42,79,76,61,66,59,77,63,62,250,44,67,64,70,63,250,74,76,73,71,74,78,250,78,76,67,65,65,63,76,63,62,8},38))
else
warn(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,64,67,76,63,74,76,73,82,67,71,67,78,83,74,76,73,71,74,78,250,72,73,78,250,77,79,74,74,73,76,78,63,62,250,60,83,250,63,82,63,61,79,78,73,76,251},38))
end
else
error(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,42,76,73,82,67,71,67,78,83,42,76,73,71,74,78,250,72,73,78,250,64,73,79,72,62,250,73,72,250,44,67,64,70,63,250,77,66,73,74,250,67,78,63,71,251},38))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({31,80,63,72,78,77},38)) and ReplicatedStorage.Events:FindFirstChild(_d({45,66,73,74},38))
if shopEvent and shopEvent:IsA(_d({44,63,71,73,78,63,32,79,72,61,78,67,73,72},38)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({42,70,59,83,63,76,33,79,67},38))
local diag = pgui and pgui:FindFirstChild(_d({30,67,59,70,73,65,79,63},38))
if diag then
local closeBtn = diag:FindFirstChild(_d({29,70,73,77,63},38), true)
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
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,31,75,79,67,74,74,67,72,65,250,44,67,64,70,63,8,8,8},38))
local args = {
[1] = _d({63,75,79,67,74},38),
[2] = _d({44,67,64,70,63},38)
}
pcall(function()
game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38)):WaitForChild(_d({31,80,63,72,78,77},38)):WaitForChild(_d({46,73,73,70,77},38)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()