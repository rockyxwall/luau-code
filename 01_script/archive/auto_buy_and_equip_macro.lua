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
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,45,41,43,48,45,44,232,14,49,59,48,53,41,54,232,11,41,62,45,233,232,27,60,55,56,56,49,54,47,232,46,52,49,47,48,60,246},56))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,14,41,49,52,45,44,232,60,55,232,49,54,49,60,49,41,52,49,66,45,232,13,41,59,65,232,28,58,41,62,45,52,246},56))
end
cleanup(_d({9,58,58,49,62,45,44,232,41,60,232,14,49,59,48,53,41,54,232,11,41,62,45},56))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,41,52,58,45,41,44,65,232,45,57,61,49,56,56,45,44,247,55,63,54,45,44,246},56))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,45,57,61,49,56,56,45,44,233},56))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,22,55,60,232,45,54,55,61,47,48,232,24,45,52,49,232,60,55,232,42,61,65,232,41,232,26,49,46,52,45,232,240,251,248,248,241,232,41,54,44,232,54,55,60,232,41,60,232,28,55,63,54,232,55,46,232,10,45,47,49,54,54,49,54,47,59,246,232,24,52,45,41,59,45,232,60,58,41,62,45,52,232,60,55,232,28,55,63,54,232,55,46,232,10,45,47,49,54,54,49,54,47,59,232,60,55,232,43,48,45,59,60,232,46,41,58,53,246},56))
cleanup(_d({17,54,62,41,52,49,44,232,52,55,43,41,60,49,55,54,232,46,55,58,232,43,48,45,59,60,232,46,41,58,53,49,54,47},56))
return
end
if not _G.EasyTravel then
Core.Import(_d({248,249,245,47,56,55,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
end
if not _G.ChestFarmer then
Core.Import(_d({248,249,245,47,56,55,247,52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41},56))
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
cleanup(_d({11,48,45,59,60,232,46,41,58,53,232,46,41,49,52,45,44,232,55,58,232,59,60,55,56,56,45,44},56))
return
end
else
error(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,232,52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41,233},56))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,22,41,62,49,47,41,60,49,54,47,232,60,55,232,42,61,65,232,26,49,46,52,45,246,246,246},56))
local buyables = Workspace:FindFirstChild(_d({10,61,65,41,42,52,45,17,60,45,53,59},56))
local shopItem = buyables and buyables:FindFirstChild(_d({26,49,46,52,45},56))
local shopPart = shopItem and shopItem:FindFirstChild(_d({27,48,55,56,24,41,58,60},56))
if not shopPart then
error(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,27,48,55,56,24,41,58,60,232,54,55,60,232,46,55,61,54,44,232,61,54,44,45,58,232,10,61,65,41,42,52,45,17,60,45,53,59,233},56))
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
cleanup(_d({14,41,49,52,45,44,232,60,55,232,58,45,41,43,48,232,26,49,46,52,45,232,59,48,55,56},56))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({24,58,55,64,49,53,49,60,65,24,58,55,53,56,60},56), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,24,61,58,43,48,41,59,45,44,232,26,49,46,52,45,232,56,58,55,53,56,60,232,60,58,49,47,47,45,58,45,44,246},56))
else
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,46,49,58,45,56,58,55,64,49,53,49,60,65,56,58,55,53,56,60,232,54,55,60,232,59,61,56,56,55,58,60,45,44,232,42,65,232,45,64,45,43,61,60,55,58,233},56))
end
else
error(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,24,58,55,64,49,53,49,60,65,24,58,55,53,56,60,232,54,55,60,232,46,55,61,54,44,232,55,54,232,26,49,46,52,45,232,59,48,55,56,232,49,60,45,53,233},56))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({13,62,45,54,60,59},56)) and ReplicatedStorage.Events:FindFirstChild(_d({27,48,55,56},56))
if shopEvent and shopEvent:IsA(_d({26,45,53,55,60,45,14,61,54,43,60,49,55,54},56)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({24,52,41,65,45,58,15,61,49},56))
local diag = pgui and pgui:FindFirstChild(_d({12,49,41,52,55,47,61,45},56))
if diag then
local closeBtn = diag:FindFirstChild(_d({11,52,55,59,45},56), true)
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
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,13,57,61,49,56,56,49,54,47,232,26,49,46,52,45,246,246,246},56))
local args = {
[1] = _d({45,57,61,49,56},56),
[2] = _d({26,49,46,52,45},56)
}
pcall(function()
game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56)):WaitForChild(_d({13,62,45,54,60,59},56)):WaitForChild(_d({28,55,55,52,59},56)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()