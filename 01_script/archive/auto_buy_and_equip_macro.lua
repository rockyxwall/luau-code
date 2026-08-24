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
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,74,70,72,77,74,73,5,43,78,88,77,82,70,83,5,40,70,91,74,6,5,56,89,84,85,85,78,83,76,5,75,81,78,76,77,89,19},27))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,43,70,78,81,74,73,5,89,84,5,78,83,78,89,78,70,81,78,95,74,5,42,70,88,94,5,57,87,70,91,74,81,19},27))
end
cleanup(_d({38,87,87,78,91,74,73,5,70,89,5,43,78,88,77,82,70,83,5,40,70,91,74},27))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,70,81,87,74,70,73,94,5,74,86,90,78,85,85,74,73,20,84,92,83,74,73,19},27))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({55,78,75,81,74},27))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,74,86,90,78,85,85,74,73,6},27))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,51,84,89,5,74,83,84,90,76,77,5,53,74,81,78,5,89,84,5,71,90,94,5,70,5,55,78,75,81,74,5,13,24,21,21,14,5,70,83,73,5,83,84,89,5,70,89,5,57,84,92,83,5,84,75,5,39,74,76,78,83,83,78,83,76,88,19,5,53,81,74,70,88,74,5,89,87,70,91,74,81,5,89,84,5,57,84,92,83,5,84,75,5,39,74,76,78,83,83,78,83,76,88,5,89,84,5,72,77,74,88,89,5,75,70,87,82,19},27))
cleanup(_d({46,83,91,70,81,78,73,5,81,84,72,70,89,78,84,83,5,75,84,87,5,72,77,74,88,89,5,75,70,87,82,78,83,76},27))
return
end
if not _G.EasyTravel then
importLib(_d({81,78,71,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27), _d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,81,90,70,90,18,72,84,73,74,20,82,70,78,83,20,21,22,68,88,72,87,78,85,89,20,81,78,71,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27))
end
if not _G.ChestFarmer then
importLib(_d({81,78,71,20,72,77,74,88,89,68,75,70,87,82,74,87,19,81,90,70},27), _d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,81,90,70,90,18,72,84,73,74,20,82,70,78,83,20,21,22,68,88,72,87,78,85,89,20,81,78,71,20,72,77,74,88,89,68,75,70,87,82,74,87,19,81,90,70},27))
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
cleanup(_d({40,77,74,88,89,5,75,70,87,82,5,75,70,78,81,74,73,5,84,87,5,88,89,84,85,85,74,73},27))
return
end
else
error(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,5,81,78,71,20,72,77,74,88,89,68,75,70,87,82,74,87,19,81,90,70,6},27))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,51,70,91,78,76,70,89,78,83,76,5,89,84,5,71,90,94,5,55,78,75,81,74,19,19,19},27))
local buyables = Workspace:FindFirstChild(_d({39,90,94,70,71,81,74,46,89,74,82,88},27))
local shopItem = buyables and buyables:FindFirstChild(_d({55,78,75,81,74},27))
local shopPart = shopItem and shopItem:FindFirstChild(_d({56,77,84,85,53,70,87,89},27))
if not shopPart then
error(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,56,77,84,85,53,70,87,89,5,83,84,89,5,75,84,90,83,73,5,90,83,73,74,87,5,39,90,94,70,71,81,74,46,89,74,82,88,6},27))
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
cleanup(_d({43,70,78,81,74,73,5,89,84,5,87,74,70,72,77,5,55,78,75,81,74,5,88,77,84,85},27))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({53,87,84,93,78,82,78,89,94,53,87,84,82,85,89},27), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,53,90,87,72,77,70,88,74,73,5,55,78,75,81,74,5,85,87,84,82,85,89,5,89,87,78,76,76,74,87,74,73,19},27))
else
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,75,78,87,74,85,87,84,93,78,82,78,89,94,85,87,84,82,85,89,5,83,84,89,5,88,90,85,85,84,87,89,74,73,5,71,94,5,74,93,74,72,90,89,84,87,6},27))
end
else
error(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,53,87,84,93,78,82,78,89,94,53,87,84,82,85,89,5,83,84,89,5,75,84,90,83,73,5,84,83,5,55,78,75,81,74,5,88,77,84,85,5,78,89,74,82,6},27))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({42,91,74,83,89,88},27)) and ReplicatedStorage.Events:FindFirstChild(_d({56,77,84,85},27))
if shopEvent and shopEvent:IsA(_d({55,74,82,84,89,74,43,90,83,72,89,78,84,83},27)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({53,81,70,94,74,87,44,90,78},27))
local diag = pgui and pgui:FindFirstChild(_d({41,78,70,81,84,76,90,74},27))
if diag then
local closeBtn = diag:FindFirstChild(_d({40,81,84,88,74},27), true)
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
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,42,86,90,78,85,85,78,83,76,5,55,78,75,81,74,5,75,87,84,82,5,78,83,91,74,83,89,84,87,94,19,19,19},27))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({55,78,75,81,74},27) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,83,84,89,5,78,83,5,77,84,89,71,70,87,19,5,42,86,90,78,85,85,78,83,76,5,91,78,70,5,59,46,50,5,50,70,72,87,84,5,85,81,70,94,71,70,72,80,19,19,19},27))
local vim = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
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
if toolName == _d({55,78,75,81,74},27) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,43,70,78,81,74,73,5,89,84,5,70,88,88,78,76,83,5,55,78,75,81,74,5,89,84,5,70,5,77,84,89,71,70,87,5,88,81,84,89,19},27))
cleanup(_d({55,78,75,81,74,5,74,86,90,78,85,5,74,87,87,84,87},27))
return
end
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,78,88,5,82,70,85,85,74,73,5,89,84,5,77,84,89,71,70,87,5,88,81,84,89,31,5},27) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,53,87,74,88,88,78,83,76,5,77,84,89,71,70,87,5,80,74,94,31,5},27) .. tostring(currentSlot) .. _d({5,89,84,5,85,90,81,81,5,84,90,89,5,55,78,75,81,74,19,19,19},27))
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
local rh = char and char:FindFirstChild(_d({55,78,76,77,89,45,70,83,73},27))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({55,78,75,81,74},27)) then
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
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,73,78,73,5,83,84,89,5,70,85,85,74,70,87,5,78,83,5,55,78,76,77,89,45,70,83,73,5,70,75,89,74,87,5,85,87,74,88,88,78,83,76,5,77,84,89,80,74,94,19},27))
cleanup(_d({55,78,75,81,74,5,74,86,90,78,85,5,89,78,82,74,84,90,89},27))
return
end
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,78,88,5,82,70,85,85,74,73,5,89,84,5,77,84,89,71,70,87,5,88,81,84,89,31,5},27) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
local keyCode = Enum.KeyCode[currentSlot]
end)()