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
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,29,48,44,46,51,48,47,235,17,52,62,51,56,44,57,235,14,44,65,48,236,235,30,63,58,59,59,52,57,50,235,49,55,52,50,51,63,249},53))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,17,44,52,55,48,47,235,63,58,235,52,57,52,63,52,44,55,52,69,48,235,16,44,62,68,235,31,61,44,65,48,55,249},53))
end
cleanup(_d({12,61,61,52,65,48,47,235,44,63,235,17,52,62,51,56,44,57,235,14,44,65,48},53))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,29,52,49,55,48,235,44,55,61,48,44,47,68,235,48,60,64,52,59,59,48,47,250,58,66,57,48,47,249},53))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({29,52,49,55,48},53))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,29,52,49,55,48,235,48,60,64,52,59,59,48,47,236},53))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,25,58,63,235,48,57,58,64,50,51,235,27,48,55,52,235,63,58,235,45,64,68,235,44,235,29,52,49,55,48,235,243,254,251,251,244,235,44,57,47,235,57,58,63,235,44,63,235,31,58,66,57,235,58,49,235,13,48,50,52,57,57,52,57,50,62,249,235,27,55,48,44,62,48,235,63,61,44,65,48,55,235,63,58,235,31,58,66,57,235,58,49,235,13,48,50,52,57,57,52,57,50,62,235,63,58,235,46,51,48,62,63,235,49,44,61,56,249},53))
cleanup(_d({20,57,65,44,55,52,47,235,55,58,46,44,63,52,58,57,235,49,58,61,235,46,51,48,62,63,235,49,44,61,56,52,57,50},53))
return
end
if not _G.EasyTravel then
Core.Import(_d({251,252,248,50,59,58,250,55,52,45,250,48,44,62,68,42,63,61,44,65,48,55,249,55,64,44},53), _d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,61,58,46,54,68,67,66,44,55,55,250,55,64,44,64,248,46,58,47,48,250,56,44,52,57,250,251,252,42,62,46,61,52,59,63,250,55,52,45,250,48,44,62,68,42,63,61,44,65,48,55,249,55,64,44},53))
end
if not _G.ChestFarmer then
Core.Import(_d({251,252,248,50,59,58,250,55,52,45,250,46,51,48,62,63,42,49,44,61,56,48,61,249,55,64,44},53), _d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,61,58,46,54,68,67,66,44,55,55,250,55,64,44,64,248,46,58,47,48,250,56,44,52,57,250,251,252,42,62,46,61,52,59,63,250,55,52,45,250,46,51,48,62,63,42,49,44,61,56,48,61,249,55,64,44},53))
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
cleanup(_d({14,51,48,62,63,235,49,44,61,56,235,49,44,52,55,48,47,235,58,61,235,62,63,58,59,59,48,47},53))
return
end
else
error(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,17,44,52,55,48,47,235,63,58,235,55,58,44,47,235,55,52,45,250,46,51,48,62,63,42,49,44,61,56,48,61,249,55,64,44,236},53))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,25,44,65,52,50,44,63,52,57,50,235,63,58,235,45,64,68,235,29,52,49,55,48,249,249,249},53))
local buyables = Workspace:FindFirstChild(_d({13,64,68,44,45,55,48,20,63,48,56,62},53))
local shopItem = buyables and buyables:FindFirstChild(_d({29,52,49,55,48},53))
local shopPart = shopItem and shopItem:FindFirstChild(_d({30,51,58,59,27,44,61,63},53))
if not shopPart then
error(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,29,52,49,55,48,235,30,51,58,59,27,44,61,63,235,57,58,63,235,49,58,64,57,47,235,64,57,47,48,61,235,13,64,68,44,45,55,48,20,63,48,56,62,236},53))
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
cleanup(_d({17,44,52,55,48,47,235,63,58,235,61,48,44,46,51,235,29,52,49,55,48,235,62,51,58,59},53))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({27,61,58,67,52,56,52,63,68,27,61,58,56,59,63},53), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,27,64,61,46,51,44,62,48,47,235,29,52,49,55,48,235,59,61,58,56,59,63,235,63,61,52,50,50,48,61,48,47,249},53))
else
warn(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,49,52,61,48,59,61,58,67,52,56,52,63,68,59,61,58,56,59,63,235,57,58,63,235,62,64,59,59,58,61,63,48,47,235,45,68,235,48,67,48,46,64,63,58,61,236},53))
end
else
error(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,27,61,58,67,52,56,52,63,68,27,61,58,56,59,63,235,57,58,63,235,49,58,64,57,47,235,58,57,235,29,52,49,55,48,235,62,51,58,59,235,52,63,48,56,236},53))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({16,65,48,57,63,62},53)) and ReplicatedStorage.Events:FindFirstChild(_d({30,51,58,59},53))
if shopEvent and shopEvent:IsA(_d({29,48,56,58,63,48,17,64,57,46,63,52,58,57},53)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({27,55,44,68,48,61,18,64,52},53))
local diag = pgui and pgui:FindFirstChild(_d({15,52,44,55,58,50,64,48},53))
if diag then
local closeBtn = diag:FindFirstChild(_d({14,55,58,62,48},53), true)
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
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,16,60,64,52,59,59,52,57,50,235,29,52,49,55,48,249,249,249},53))
local args = {
[1] = _d({48,60,64,52,59},53),
[2] = _d({29,52,49,55,48},53)
}
pcall(function()
game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53)):WaitForChild(_d({16,65,48,57,63,62},53)):WaitForChild(_d({31,58,58,55,62},53)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()