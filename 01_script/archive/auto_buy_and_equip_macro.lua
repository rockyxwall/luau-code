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
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,57,76,72,74,79,76,75,7,45,80,90,79,84,72,85,7,42,72,93,76,8,7,58,91,86,87,87,80,85,78,7,77,83,80,78,79,91,21},25))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,45,72,80,83,76,75,7,91,86,7,80,85,80,91,80,72,83,80,97,76,7,44,72,90,96,7,59,89,72,93,76,83,21},25))
end
cleanup(_d({40,89,89,80,93,76,75,7,72,91,7,45,80,90,79,84,72,85,7,42,72,93,76},25))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,57,80,77,83,76,7,72,83,89,76,72,75,96,7,76,88,92,80,87,87,76,75,22,86,94,85,76,75,21},25))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({57,80,77,83,76},25))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,57,80,77,83,76,7,76,88,92,80,87,87,76,75,8},25))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,53,86,91,7,76,85,86,92,78,79,7,55,76,83,80,7,91,86,7,73,92,96,7,72,7,57,80,77,83,76,7,15,26,23,23,16,7,72,85,75,7,85,86,91,7,72,91,7,59,86,94,85,7,86,77,7,41,76,78,80,85,85,80,85,78,90,21,7,55,83,76,72,90,76,7,91,89,72,93,76,83,7,91,86,7,59,86,94,85,7,86,77,7,41,76,78,80,85,85,80,85,78,90,7,91,86,7,74,79,76,90,91,7,77,72,89,84,21},25))
cleanup(_d({48,85,93,72,83,80,75,7,83,86,74,72,91,80,86,85,7,77,86,89,7,74,79,76,90,91,7,77,72,89,84,80,85,78},25))
return
end
if not _G.EasyTravel then
importLib(_d({83,80,73,22,76,72,90,96,70,91,89,72,93,76,83,21,83,92,72},25), _d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,83,92,72,92,20,74,86,75,76,22,84,72,80,85,22,23,24,70,90,74,89,80,87,91,22,83,80,73,22,76,72,90,96,70,91,89,72,93,76,83,21,83,92,72},25))
end
if not _G.ChestFarmer then
importLib(_d({83,80,73,22,74,79,76,90,91,70,77,72,89,84,76,89,21,83,92,72},25), _d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,83,92,72,92,20,74,86,75,76,22,84,72,80,85,22,23,24,70,90,74,89,80,87,91,22,83,80,73,22,74,79,76,90,91,70,77,72,89,84,76,89,21,83,92,72},25))
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
cleanup(_d({42,79,76,90,91,7,77,72,89,84,7,77,72,80,83,76,75,7,86,89,7,90,91,86,87,87,76,75},25))
return
end
else
error(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,45,72,80,83,76,75,7,91,86,7,83,86,72,75,7,83,80,73,22,74,79,76,90,91,70,77,72,89,84,76,89,21,83,92,72,8},25))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,53,72,93,80,78,72,91,80,85,78,7,91,86,7,73,92,96,7,57,80,77,83,76,21,21,21},25))
local buyables = Workspace:FindFirstChild(_d({41,92,96,72,73,83,76,48,91,76,84,90},25))
local shopItem = buyables and buyables:FindFirstChild(_d({57,80,77,83,76},25))
local shopPart = shopItem and shopItem:FindFirstChild(_d({58,79,86,87,55,72,89,91},25))
if not shopPart then
error(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,57,80,77,83,76,7,58,79,86,87,55,72,89,91,7,85,86,91,7,77,86,92,85,75,7,92,85,75,76,89,7,41,92,96,72,73,83,76,48,91,76,84,90,8},25))
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
cleanup(_d({45,72,80,83,76,75,7,91,86,7,89,76,72,74,79,7,57,80,77,83,76,7,90,79,86,87},25))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({55,89,86,95,80,84,80,91,96,55,89,86,84,87,91},25), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,55,92,89,74,79,72,90,76,75,7,57,80,77,83,76,7,87,89,86,84,87,91,7,91,89,80,78,78,76,89,76,75,21},25))
else
warn(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,77,80,89,76,87,89,86,95,80,84,80,91,96,87,89,86,84,87,91,7,85,86,91,7,90,92,87,87,86,89,91,76,75,7,73,96,7,76,95,76,74,92,91,86,89,8},25))
end
else
error(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,55,89,86,95,80,84,80,91,96,55,89,86,84,87,91,7,85,86,91,7,77,86,92,85,75,7,86,85,7,57,80,77,83,76,7,90,79,86,87,7,80,91,76,84,8},25))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({44,93,76,85,91,90},25)) and ReplicatedStorage.Events:FindFirstChild(_d({58,79,86,87},25))
if shopEvent and shopEvent:IsA(_d({57,76,84,86,91,76,45,92,85,74,91,80,86,85},25)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({55,83,72,96,76,89,46,92,80},25))
local diag = pgui and pgui:FindFirstChild(_d({43,80,72,83,86,78,92,76},25))
if diag then
local closeBtn = diag:FindFirstChild(_d({42,83,86,90,76},25), true)
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
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,44,88,92,80,87,87,80,85,78,7,57,80,77,83,76,7,77,89,86,84,7,80,85,93,76,85,91,86,89,96,21,21,21},25))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({57,80,77,83,76},25) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,57,80,77,83,76,7,85,86,91,7,80,85,7,79,86,91,73,72,89,21,7,44,88,92,80,87,87,80,85,78,7,93,80,72,7,61,48,52,7,52,72,74,89,86,7,87,83,72,96,73,72,74,82,21,21,21},25))
local vim = game:GetService(_d({61,80,89,91,92,72,83,48,85,87,92,91,52,72,85,72,78,76,89},25))
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
if toolName == _d({57,80,77,83,76},25) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,45,72,80,83,76,75,7,91,86,7,72,90,90,80,78,85,7,57,80,77,83,76,7,91,86,7,72,7,79,86,91,73,72,89,7,90,83,86,91,21},25))
cleanup(_d({57,80,77,83,76,7,76,88,92,80,87,7,76,89,89,86,89},25))
return
end
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,57,80,77,83,76,7,80,90,7,84,72,87,87,76,75,7,91,86,7,79,86,91,73,72,89,7,90,83,86,91,33,7},25) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({61,80,89,91,92,72,83,48,85,87,92,91,52,72,85,72,78,76,89},25))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,55,89,76,90,90,80,85,78,7,79,86,91,73,72,89,7,82,76,96,33,7},25) .. tostring(currentSlot) .. _d({7,91,86,7,87,92,83,83,7,86,92,91,7,57,80,77,83,76,21,21,21},25))
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
local rh = char and char:FindFirstChild(_d({57,80,78,79,91,47,72,85,75},25))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({57,80,77,83,76},25)) then
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
warn(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,57,80,77,83,76,7,75,80,75,7,85,86,91,7,72,87,87,76,72,89,7,80,85,7,57,80,78,79,91,47,72,85,75,7,72,77,91,76,89,7,87,89,76,90,90,80,85,78,7,79,86,91,82,76,96,21},25))
cleanup(_d({57,80,77,83,76,7,76,88,92,80,87,7,91,80,84,76,86,92,91},25))
return
end
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,57,80,77,83,76,7,80,90,7,84,72,87,87,76,75,7,91,86,7,79,86,91,73,72,89,7,90,83,86,91,33,7},25) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({61,80,89,91,92,72,83,48,85,87,92,91,52,72,85,72,78,76,89},25))
local keyCode = Enum.KeyCode[currentSlot]
end)()