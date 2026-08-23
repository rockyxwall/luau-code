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
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,30,49,45,47,52,49,48,236,18,53,63,52,57,45,58,236,15,45,66,49,237,236,31,64,59,60,60,53,58,51,236,50,56,53,51,52,64,250},52))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,18,45,53,56,49,48,236,64,59,236,53,58,53,64,53,45,56,53,70,49,236,17,45,63,69,236,32,62,45,66,49,56,250},52))
end
cleanup(_d({13,62,62,53,66,49,48,236,45,64,236,18,53,63,52,57,45,58,236,15,45,66,49},52))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,30,53,50,56,49,236,45,56,62,49,45,48,69,236,49,61,65,53,60,60,49,48,251,59,67,58,49,48,250},52))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({30,53,50,56,49},52))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,30,53,50,56,49,236,49,61,65,53,60,60,49,48,237},52))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,26,59,64,236,49,58,59,65,51,52,236,28,49,56,53,236,64,59,236,46,65,69,236,45,236,30,53,50,56,49,236,244,255,252,252,245,236,45,58,48,236,58,59,64,236,45,64,236,32,59,67,58,236,59,50,236,14,49,51,53,58,58,53,58,51,63,250,236,28,56,49,45,63,49,236,64,62,45,66,49,56,236,64,59,236,32,59,67,58,236,59,50,236,14,49,51,53,58,58,53,58,51,63,236,64,59,236,47,52,49,63,64,236,50,45,62,57,250},52))
cleanup(_d({21,58,66,45,56,53,48,236,56,59,47,45,64,53,59,58,236,50,59,62,236,47,52,49,63,64,236,50,45,62,57,53,58,51},52))
return
end
if not _G.EasyTravel then
importLib(_d({56,53,46,251,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45},52), _d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45},52))
end
if not _G.ChestFarmer then
importLib(_d({56,53,46,251,47,52,49,63,64,43,50,45,62,57,49,62,250,56,65,45},52), _d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,47,52,49,63,64,43,50,45,62,57,49,62,250,56,65,45},52))
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
cleanup(_d({15,52,49,63,64,236,50,45,62,57,236,50,45,53,56,49,48,236,59,62,236,63,64,59,60,60,49,48},52))
return
end
else
error(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,236,56,53,46,251,47,52,49,63,64,43,50,45,62,57,49,62,250,56,65,45,237},52))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,26,45,66,53,51,45,64,53,58,51,236,64,59,236,46,65,69,236,30,53,50,56,49,250,250,250},52))
local buyables = Workspace:FindFirstChild(_d({14,65,69,45,46,56,49,21,64,49,57,63},52))
local shopItem = buyables and buyables:FindFirstChild(_d({30,53,50,56,49},52))
local shopPart = shopItem and shopItem:FindFirstChild(_d({31,52,59,60,28,45,62,64},52))
if not shopPart then
error(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,30,53,50,56,49,236,31,52,59,60,28,45,62,64,236,58,59,64,236,50,59,65,58,48,236,65,58,48,49,62,236,14,65,69,45,46,56,49,21,64,49,57,63,237},52))
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
cleanup(_d({18,45,53,56,49,48,236,64,59,236,62,49,45,47,52,236,30,53,50,56,49,236,63,52,59,60},52))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({28,62,59,68,53,57,53,64,69,28,62,59,57,60,64},52), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,28,65,62,47,52,45,63,49,48,236,30,53,50,56,49,236,60,62,59,57,60,64,236,64,62,53,51,51,49,62,49,48,250},52))
else
warn(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,50,53,62,49,60,62,59,68,53,57,53,64,69,60,62,59,57,60,64,236,58,59,64,236,63,65,60,60,59,62,64,49,48,236,46,69,236,49,68,49,47,65,64,59,62,237},52))
end
else
error(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,28,62,59,68,53,57,53,64,69,28,62,59,57,60,64,236,58,59,64,236,50,59,65,58,48,236,59,58,236,30,53,50,56,49,236,63,52,59,60,236,53,64,49,57,237},52))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({17,66,49,58,64,63},52)) and ReplicatedStorage.Events:FindFirstChild(_d({31,52,59,60},52))
if shopEvent and shopEvent:IsA(_d({30,49,57,59,64,49,18,65,58,47,64,53,59,58},52)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({28,56,45,69,49,62,19,65,53},52))
local diag = pgui and pgui:FindFirstChild(_d({16,53,45,56,59,51,65,49},52))
if diag then
local closeBtn = diag:FindFirstChild(_d({15,56,59,63,49},52), true)
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
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,17,61,65,53,60,60,53,58,51,236,30,53,50,56,49,236,50,62,59,57,236,53,58,66,49,58,64,59,62,69,250,250,250},52))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({30,53,50,56,49},52) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,30,53,50,56,49,236,58,59,64,236,53,58,236,52,59,64,46,45,62,250,236,17,61,65,53,60,60,53,58,51,236,66,53,45,236,34,21,25,236,25,45,47,62,59,236,60,56,45,69,46,45,47,55,250,250,250},52))
local vim = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local vs = workspace.CurrentCamera.ViewportSize
local function clickRelative(pctX, pctY)
local cx = vs.X * pctX
local cy = vs.Y * pctY
pcall(function()
vim:SendMouseButtonEvent(cx, cy, 0, true, game, 0)
task.wait(0.05)
vim:SendMouseButtonEvent(cx, cy, 0, false, game, 0)
end)
end
clickRelative(0.025, 0.975)
task.wait(0.8)
clickRelative(0.494, 0.377)
task.wait(0.5)
clickRelative(0.518, 0.443)
task.wait(0.5)
clickRelative(0.770, 0.655)
task.wait(0.5)
clickRelative(0.038, 0.981)
task.wait(1)
mapping = getHotbarMapping()
for slot, toolName in pairs(mapping) do
if toolName == _d({30,53,50,56,49},52) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,18,45,53,56,49,48,236,64,59,236,45,63,63,53,51,58,236,30,53,50,56,49,236,64,59,236,45,236,52,59,64,46,45,62,236,63,56,59,64,250},52))
cleanup(_d({30,53,50,56,49,236,49,61,65,53,60,236,49,62,62,59,62},52))
return
end
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,30,53,50,56,49,236,53,63,236,57,45,60,60,49,48,236,64,59,236,52,59,64,46,45,62,236,63,56,59,64,6,236},52) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,28,62,49,63,63,53,58,51,236,52,59,64,46,45,62,236,55,49,69,6,236},52) .. tostring(currentSlot) .. _d({236,64,59,236,60,65,56,56,236,59,65,64,236,30,53,50,56,49,250,250,250},52))
vim:SendKeyEvent(true, keyCode, false, game)
task.wait(0.1)
vim:SendKeyEvent(false, keyCode, false, game)
end
local replicaElapsed = 0
local rifleEquipped = false
while running and replicaElapsed < 5 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
local char = LocalPlayer.Character
local rh = char and char:FindFirstChild(_d({30,53,51,52,64,20,45,58,48},52))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({30,53,50,56,49},52)) then
rifleEquipped = true
break
end
end
end
if rifleEquipped then
break
end
end
if not rifleEquipped then
warn(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,30,53,50,56,49,236,48,53,48,236,58,59,64,236,45,60,60,49,45,62,236,53,58,236,30,53,51,52,64,20,45,58,48,236,45,50,64,49,62,236,60,62,49,63,63,53,58,51,236,52,59,64,55,49,69,250},52))
cleanup(_d({30,53,50,56,49,236,49,61,65,53,60,236,64,53,57,49,59,65,64},52))
return
end
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,30,53,50,56,49,236,53,63,236,57,45,60,60,49,48,236,64,59,236,52,59,64,46,45,62,236,63,56,59,64,6,236},52) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local keyCode = Enum.KeyCode[currentSlot]
end)()