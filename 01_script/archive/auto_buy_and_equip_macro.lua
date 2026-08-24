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
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,53,49,51,56,53,52,240,22,57,67,56,61,49,62,240,19,49,70,53,241,240,35,68,63,64,64,57,62,55,240,54,60,57,55,56,68,254},48))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,22,49,57,60,53,52,240,68,63,240,57,62,57,68,57,49,60,57,74,53,240,21,49,67,73,240,36,66,49,70,53,60,254},48))
end
cleanup(_d({17,66,66,57,70,53,52,240,49,68,240,22,57,67,56,61,49,62,240,19,49,70,53},48))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,57,54,60,53,240,49,60,66,53,49,52,73,240,53,65,69,57,64,64,53,52,255,63,71,62,53,52,254},48))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,57,54,60,53,240,53,65,69,57,64,64,53,52,241},48))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,30,63,68,240,53,62,63,69,55,56,240,32,53,60,57,240,68,63,240,50,69,73,240,49,240,34,57,54,60,53,240,248,3,0,0,249,240,49,62,52,240,62,63,68,240,49,68,240,36,63,71,62,240,63,54,240,18,53,55,57,62,62,57,62,55,67,254,240,32,60,53,49,67,53,240,68,66,49,70,53,60,240,68,63,240,36,63,71,62,240,63,54,240,18,53,55,57,62,62,57,62,55,67,240,68,63,240,51,56,53,67,68,240,54,49,66,61,254},48))
cleanup(_d({25,62,70,49,60,57,52,240,60,63,51,49,68,57,63,62,240,54,63,66,240,51,56,53,67,68,240,54,49,66,61,57,62,55},48))
return
end
if not _G.EasyTravel then
Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48))
end
if not _G.ChestFarmer then
Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49},48))
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
cleanup(_d({19,56,53,67,68,240,54,49,66,61,240,54,49,57,60,53,52,240,63,66,240,67,68,63,64,64,53,52},48))
return
end
else
error(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,240,60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49,241},48))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,30,49,70,57,55,49,68,57,62,55,240,68,63,240,50,69,73,240,34,57,54,60,53,254,254,254},48))
local buyables = Workspace:FindFirstChild(_d({18,69,73,49,50,60,53,25,68,53,61,67},48))
local shopItem = buyables and buyables:FindFirstChild(_d({34,57,54,60,53},48))
local shopPart = shopItem and shopItem:FindFirstChild(_d({35,56,63,64,32,49,66,68},48))
if not shopPart then
error(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,34,57,54,60,53,240,35,56,63,64,32,49,66,68,240,62,63,68,240,54,63,69,62,52,240,69,62,52,53,66,240,18,69,73,49,50,60,53,25,68,53,61,67,241},48))
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
cleanup(_d({22,49,57,60,53,52,240,68,63,240,66,53,49,51,56,240,34,57,54,60,53,240,67,56,63,64},48))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({32,66,63,72,57,61,57,68,73,32,66,63,61,64,68},48), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,32,69,66,51,56,49,67,53,52,240,34,57,54,60,53,240,64,66,63,61,64,68,240,68,66,57,55,55,53,66,53,52,254},48))
else
warn(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,54,57,66,53,64,66,63,72,57,61,57,68,73,64,66,63,61,64,68,240,62,63,68,240,67,69,64,64,63,66,68,53,52,240,50,73,240,53,72,53,51,69,68,63,66,241},48))
end
else
error(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,32,66,63,72,57,61,57,68,73,32,66,63,61,64,68,240,62,63,68,240,54,63,69,62,52,240,63,62,240,34,57,54,60,53,240,67,56,63,64,240,57,68,53,61,241},48))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({21,70,53,62,68,67},48)) and ReplicatedStorage.Events:FindFirstChild(_d({35,56,63,64},48))
if shopEvent and shopEvent:IsA(_d({34,53,61,63,68,53,22,69,62,51,68,57,63,62},48)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({32,60,49,73,53,66,23,69,57},48))
local diag = pgui and pgui:FindFirstChild(_d({20,57,49,60,63,55,69,53},48))
if diag then
local closeBtn = diag:FindFirstChild(_d({19,60,63,67,53},48), true)
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
print(_d({43,23,53,64,63,240,23,66,57,62,52,53,66,45,240,21,65,69,57,64,64,57,62,55,240,34,57,54,60,53,254,254,254},48))
local args = {
[1] = _d({53,65,69,57,64},48),
[2] = _d({34,57,54,60,53},48)
}
pcall(function()
game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48)):WaitForChild(_d({21,70,53,62,68,67},48)):WaitForChild(_d({36,63,63,60,67},48)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()