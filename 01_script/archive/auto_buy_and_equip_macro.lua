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
print(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,33,52,48,50,55,52,51,239,21,56,66,55,60,48,61,239,18,48,69,52,240,239,34,67,62,63,63,56,61,54,239,53,59,56,54,55,67,253},49))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,21,48,56,59,52,51,239,67,62,239,56,61,56,67,56,48,59,56,73,52,239,20,48,66,72,239,35,65,48,69,52,59,253},49))
end
cleanup(_d({16,65,65,56,69,52,51,239,48,67,239,21,56,66,55,60,48,61,239,18,48,69,52},49))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,33,56,53,59,52,239,48,59,65,52,48,51,72,239,52,64,68,56,63,63,52,51,254,62,70,61,52,51,253},49))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({33,56,53,59,52},49))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,33,56,53,59,52,239,52,64,68,56,63,63,52,51,240},49))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,29,62,67,239,52,61,62,68,54,55,239,31,52,59,56,239,67,62,239,49,68,72,239,48,239,33,56,53,59,52,239,247,2,255,255,248,239,48,61,51,239,61,62,67,239,48,67,239,35,62,70,61,239,62,53,239,17,52,54,56,61,61,56,61,54,66,253,239,31,59,52,48,66,52,239,67,65,48,69,52,59,239,67,62,239,35,62,70,61,239,62,53,239,17,52,54,56,61,61,56,61,54,66,239,67,62,239,50,55,52,66,67,239,53,48,65,60,253},49))
cleanup(_d({24,61,69,48,59,56,51,239,59,62,50,48,67,56,62,61,239,53,62,65,239,50,55,52,66,67,239,53,48,65,60,56,61,54},49))
return
end
if not _G.EasyTravel then
Core.Import(_d({255,0,252,54,63,62,254,59,56,49,254,52,48,66,72,46,67,65,48,69,52,59,253,59,68,48},49), _d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,65,62,50,58,72,71,70,48,59,59,254,59,68,48,68,252,50,62,51,52,254,60,48,56,61,254,255,0,46,66,50,65,56,63,67,254,59,56,49,254,52,48,66,72,46,67,65,48,69,52,59,253,59,68,48},49))
end
if not _G.ChestFarmer then
Core.Import(_d({255,0,252,54,63,62,254,59,56,49,254,50,55,52,66,67,46,53,48,65,60,52,65,253,59,68,48},49), _d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,65,62,50,58,72,71,70,48,59,59,254,59,68,48,68,252,50,62,51,52,254,60,48,56,61,254,255,0,46,66,50,65,56,63,67,254,59,56,49,254,50,55,52,66,67,46,53,48,65,60,52,65,253,59,68,48},49))
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
cleanup(_d({18,55,52,66,67,239,53,48,65,60,239,53,48,56,59,52,51,239,62,65,239,66,67,62,63,63,52,51},49))
return
end
else
error(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,21,48,56,59,52,51,239,67,62,239,59,62,48,51,239,59,56,49,254,50,55,52,66,67,46,53,48,65,60,52,65,253,59,68,48,240},49))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,29,48,69,56,54,48,67,56,61,54,239,67,62,239,49,68,72,239,33,56,53,59,52,253,253,253},49))
local buyables = Workspace:FindFirstChild(_d({17,68,72,48,49,59,52,24,67,52,60,66},49))
local shopItem = buyables and buyables:FindFirstChild(_d({33,56,53,59,52},49))
local shopPart = shopItem and shopItem:FindFirstChild(_d({34,55,62,63,31,48,65,67},49))
if not shopPart then
error(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,33,56,53,59,52,239,34,55,62,63,31,48,65,67,239,61,62,67,239,53,62,68,61,51,239,68,61,51,52,65,239,17,68,72,48,49,59,52,24,67,52,60,66,240},49))
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
cleanup(_d({21,48,56,59,52,51,239,67,62,239,65,52,48,50,55,239,33,56,53,59,52,239,66,55,62,63},49))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({31,65,62,71,56,60,56,67,72,31,65,62,60,63,67},49), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,31,68,65,50,55,48,66,52,51,239,33,56,53,59,52,239,63,65,62,60,63,67,239,67,65,56,54,54,52,65,52,51,253},49))
else
warn(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,53,56,65,52,63,65,62,71,56,60,56,67,72,63,65,62,60,63,67,239,61,62,67,239,66,68,63,63,62,65,67,52,51,239,49,72,239,52,71,52,50,68,67,62,65,240},49))
end
else
error(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,31,65,62,71,56,60,56,67,72,31,65,62,60,63,67,239,61,62,67,239,53,62,68,61,51,239,62,61,239,33,56,53,59,52,239,66,55,62,63,239,56,67,52,60,240},49))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({20,69,52,61,67,66},49)) and ReplicatedStorage.Events:FindFirstChild(_d({34,55,62,63},49))
if shopEvent and shopEvent:IsA(_d({33,52,60,62,67,52,21,68,61,50,67,56,62,61},49)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({31,59,48,72,52,65,22,68,56},49))
local diag = pgui and pgui:FindFirstChild(_d({19,56,48,59,62,54,68,52},49))
if diag then
local closeBtn = diag:FindFirstChild(_d({18,59,62,66,52},49), true)
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
print(_d({42,22,52,63,62,239,22,65,56,61,51,52,65,44,239,20,64,68,56,63,63,56,61,54,239,33,56,53,59,52,253,253,253},49))
local args = {
[1] = _d({52,64,68,56,63},49),
[2] = _d({33,56,53,59,52},49)
}
pcall(function()
game:GetService(_d({33,52,63,59,56,50,48,67,52,51,34,67,62,65,48,54,52},49)):WaitForChild(_d({20,69,52,61,67,66},49)):WaitForChild(_d({35,62,62,59,66},49)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()