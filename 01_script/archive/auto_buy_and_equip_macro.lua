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
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,45,64,60,62,67,64,63,251,33,68,78,67,72,60,73,251,30,60,81,64,252,251,46,79,74,75,75,68,73,66,251,65,71,68,66,67,79,9},37))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,33,60,68,71,64,63,251,79,74,251,68,73,68,79,68,60,71,68,85,64,251,32,60,78,84,251,47,77,60,81,64,71,9},37))
end
cleanup(_d({28,77,77,68,81,64,63,251,60,79,251,33,68,78,67,72,60,73,251,30,60,81,64},37))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,45,68,65,71,64,251,60,71,77,64,60,63,84,251,64,76,80,68,75,75,64,63,10,74,82,73,64,63,9},37))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({45,68,65,71,64},37))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,45,68,65,71,64,251,64,76,80,68,75,75,64,63,252},37))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,41,74,79,251,64,73,74,80,66,67,251,43,64,71,68,251,79,74,251,61,80,84,251,60,251,45,68,65,71,64,251,3,14,11,11,4,251,60,73,63,251,73,74,79,251,60,79,251,47,74,82,73,251,74,65,251,29,64,66,68,73,73,68,73,66,78,9,251,43,71,64,60,78,64,251,79,77,60,81,64,71,251,79,74,251,47,74,82,73,251,74,65,251,29,64,66,68,73,73,68,73,66,78,251,79,74,251,62,67,64,78,79,251,65,60,77,72,9},37))
cleanup(_d({36,73,81,60,71,68,63,251,71,74,62,60,79,68,74,73,251,65,74,77,251,62,67,64,78,79,251,65,60,77,72,68,73,66},37))
return
end
if not _G.EasyTravel then
Core.Import(_d({11,12,8,66,75,74,10,71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37))
end
if not _G.ChestFarmer then
Core.Import(_d({11,12,8,66,75,74,10,71,68,61,10,62,67,64,78,79,58,65,60,77,72,64,77,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,62,67,64,78,79,58,65,60,77,72,64,77,9,71,80,60},37))
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
cleanup(_d({30,67,64,78,79,251,65,60,77,72,251,65,60,68,71,64,63,251,74,77,251,78,79,74,75,75,64,63},37))
return
end
else
error(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,71,68,61,10,62,67,64,78,79,58,65,60,77,72,64,77,9,71,80,60,252},37))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,41,60,81,68,66,60,79,68,73,66,251,79,74,251,61,80,84,251,45,68,65,71,64,9,9,9},37))
local buyables = Workspace:FindFirstChild(_d({29,80,84,60,61,71,64,36,79,64,72,78},37))
local shopItem = buyables and buyables:FindFirstChild(_d({45,68,65,71,64},37))
local shopPart = shopItem and shopItem:FindFirstChild(_d({46,67,74,75,43,60,77,79},37))
if not shopPart then
error(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,45,68,65,71,64,251,46,67,74,75,43,60,77,79,251,73,74,79,251,65,74,80,73,63,251,80,73,63,64,77,251,29,80,84,60,61,71,64,36,79,64,72,78,252},37))
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
cleanup(_d({33,60,68,71,64,63,251,79,74,251,77,64,60,62,67,251,45,68,65,71,64,251,78,67,74,75},37))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({43,77,74,83,68,72,68,79,84,43,77,74,72,75,79},37), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,43,80,77,62,67,60,78,64,63,251,45,68,65,71,64,251,75,77,74,72,75,79,251,79,77,68,66,66,64,77,64,63,9},37))
else
warn(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,65,68,77,64,75,77,74,83,68,72,68,79,84,75,77,74,72,75,79,251,73,74,79,251,78,80,75,75,74,77,79,64,63,251,61,84,251,64,83,64,62,80,79,74,77,252},37))
end
else
error(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,43,77,74,83,68,72,68,79,84,43,77,74,72,75,79,251,73,74,79,251,65,74,80,73,63,251,74,73,251,45,68,65,71,64,251,78,67,74,75,251,68,79,64,72,252},37))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({32,81,64,73,79,78},37)) and ReplicatedStorage.Events:FindFirstChild(_d({46,67,74,75},37))
if shopEvent and shopEvent:IsA(_d({45,64,72,74,79,64,33,80,73,62,79,68,74,73},37)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({43,71,60,84,64,77,34,80,68},37))
local diag = pgui and pgui:FindFirstChild(_d({31,68,60,71,74,66,80,64},37))
if diag then
local closeBtn = diag:FindFirstChild(_d({30,71,74,78,64},37), true)
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
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,32,76,80,68,75,75,68,73,66,251,45,68,65,71,64,9,9,9},37))
local args = {
[1] = _d({64,76,80,68,75},37),
[2] = _d({45,68,65,71,64},37)
}
pcall(function()
game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37)):WaitForChild(_d({32,81,64,73,79,78},37)):WaitForChild(_d({47,74,74,71,78},37)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()