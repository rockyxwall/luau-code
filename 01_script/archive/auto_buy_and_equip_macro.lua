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
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,77,73,75,80,77,76,8,46,81,91,80,85,73,86,8,43,73,94,77,9,8,59,92,87,88,88,81,86,79,8,78,84,81,79,80,92,22},24))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,46,73,81,84,77,76,8,92,87,8,81,86,81,92,81,73,84,81,98,77,8,45,73,91,97,8,60,90,73,94,77,84,22},24))
end
cleanup(_d({41,90,90,81,94,77,76,8,73,92,8,46,81,91,80,85,73,86,8,43,73,94,77},24))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,73,84,90,77,73,76,97,8,77,89,93,81,88,88,77,76,23,87,95,86,77,76,22},24))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({58,81,78,84,77},24))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,77,89,93,81,88,88,77,76,9},24))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,54,87,92,8,77,86,87,93,79,80,8,56,77,84,81,8,92,87,8,74,93,97,8,73,8,58,81,78,84,77,8,16,27,24,24,17,8,73,86,76,8,86,87,92,8,73,92,8,60,87,95,86,8,87,78,8,42,77,79,81,86,86,81,86,79,91,22,8,56,84,77,73,91,77,8,92,90,73,94,77,84,8,92,87,8,60,87,95,86,8,87,78,8,42,77,79,81,86,86,81,86,79,91,8,92,87,8,75,80,77,91,92,8,78,73,90,85,22},24))
cleanup(_d({49,86,94,73,84,81,76,8,84,87,75,73,92,81,87,86,8,78,87,90,8,75,80,77,91,92,8,78,73,90,85,81,86,79},24))
return
end
if not _G.EasyTravel then
importLib(_d({84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24))
end
if not _G.ChestFarmer then
importLib(_d({84,81,74,23,75,80,77,91,92,71,78,73,90,85,77,90,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,75,80,77,91,92,71,78,73,90,85,77,90,22,84,93,73},24))
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
cleanup(_d({43,80,77,91,92,8,78,73,90,85,8,78,73,81,84,77,76,8,87,90,8,91,92,87,88,88,77,76},24))
return
end
else
error(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,84,81,74,23,75,80,77,91,92,71,78,73,90,85,77,90,22,84,93,73,9},24))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,54,73,94,81,79,73,92,81,86,79,8,92,87,8,74,93,97,8,58,81,78,84,77,22,22,22},24))
local buyables = Workspace:FindFirstChild(_d({42,93,97,73,74,84,77,49,92,77,85,91},24))
local shopItem = buyables and buyables:FindFirstChild(_d({58,81,78,84,77},24))
local shopPart = shopItem and shopItem:FindFirstChild(_d({59,80,87,88,56,73,90,92},24))
if not shopPart then
error(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,59,80,87,88,56,73,90,92,8,86,87,92,8,78,87,93,86,76,8,93,86,76,77,90,8,42,93,97,73,74,84,77,49,92,77,85,91,9},24))
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
cleanup(_d({46,73,81,84,77,76,8,92,87,8,90,77,73,75,80,8,58,81,78,84,77,8,91,80,87,88},24))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({56,90,87,96,81,85,81,92,97,56,90,87,85,88,92},24), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,56,93,90,75,80,73,91,77,76,8,58,81,78,84,77,8,88,90,87,85,88,92,8,92,90,81,79,79,77,90,77,76,22},24))
else
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,78,81,90,77,88,90,87,96,81,85,81,92,97,88,90,87,85,88,92,8,86,87,92,8,91,93,88,88,87,90,92,77,76,8,74,97,8,77,96,77,75,93,92,87,90,9},24))
end
else
error(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,56,90,87,96,81,85,81,92,97,56,90,87,85,88,92,8,86,87,92,8,78,87,93,86,76,8,87,86,8,58,81,78,84,77,8,91,80,87,88,8,81,92,77,85,9},24))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({45,94,77,86,92,91},24)) and ReplicatedStorage.Events:FindFirstChild(_d({59,80,87,88},24))
if shopEvent and shopEvent:IsA(_d({58,77,85,87,92,77,46,93,86,75,92,81,87,86},24)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({56,84,73,97,77,90,47,93,81},24))
local diag = pgui and pgui:FindFirstChild(_d({44,81,73,84,87,79,93,77},24))
if diag then
local closeBtn = diag:FindFirstChild(_d({43,84,87,91,77},24), true)
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
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,45,89,93,81,88,88,81,86,79,8,58,81,78,84,77,8,78,90,87,85,8,81,86,94,77,86,92,87,90,97,22,22,22},24))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({58,81,78,84,77},24) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,86,87,92,8,81,86,8,80,87,92,74,73,90,22,8,45,89,93,81,88,88,81,86,79,8,94,81,73,8,62,49,53,8,53,73,75,90,87,8,88,84,73,97,74,73,75,83,22,22,22},24))
local vim = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
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
if toolName == _d({58,81,78,84,77},24) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,46,73,81,84,77,76,8,92,87,8,73,91,91,81,79,86,8,58,81,78,84,77,8,92,87,8,73,8,80,87,92,74,73,90,8,91,84,87,92,22},24))
cleanup(_d({58,81,78,84,77,8,77,89,93,81,88,8,77,90,90,87,90},24))
return
end
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,81,91,8,85,73,88,88,77,76,8,92,87,8,80,87,92,74,73,90,8,91,84,87,92,34,8},24) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,56,90,77,91,91,81,86,79,8,80,87,92,74,73,90,8,83,77,97,34,8},24) .. tostring(currentSlot) .. _d({8,92,87,8,88,93,84,84,8,87,93,92,8,58,81,78,84,77,22,22,22},24))
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
local rh = char and char:FindFirstChild(_d({58,81,79,80,92,48,73,86,76},24))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({58,81,78,84,77},24)) then
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
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,76,81,76,8,86,87,92,8,73,88,88,77,73,90,8,81,86,8,58,81,79,80,92,48,73,86,76,8,73,78,92,77,90,8,88,90,77,91,91,81,86,79,8,80,87,92,83,77,97,22},24))
cleanup(_d({58,81,78,84,77,8,77,89,93,81,88,8,92,81,85,77,87,93,92},24))
return
end
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,81,91,8,85,73,88,88,77,76,8,92,87,8,80,87,92,74,73,90,8,91,84,87,92,34,8},24) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
local keyCode = Enum.KeyCode[currentSlot]
end)()