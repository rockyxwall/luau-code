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
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,18,37,33,35,40,37,36,224,6,41,51,40,45,33,46,224,3,33,54,37,225,224,19,52,47,48,48,41,46,39,224,38,44,41,39,40,52,238},64))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,6,33,41,44,37,36,224,52,47,224,41,46,41,52,41,33,44,41,58,37,224,5,33,51,57,224,20,50,33,54,37,44,238},64))
end
cleanup(_d({1,50,50,41,54,37,36,224,33,52,224,6,41,51,40,45,33,46,224,3,33,54,37},64))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,18,41,38,44,37,224,33,44,50,37,33,36,57,224,37,49,53,41,48,48,37,36,239,47,55,46,37,36,238},64))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({18,41,38,44,37},64))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,18,41,38,44,37,224,37,49,53,41,48,48,37,36,225},64))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,14,47,52,224,37,46,47,53,39,40,224,16,37,44,41,224,52,47,224,34,53,57,224,33,224,18,41,38,44,37,224,232,243,240,240,233,224,33,46,36,224,46,47,52,224,33,52,224,20,47,55,46,224,47,38,224,2,37,39,41,46,46,41,46,39,51,238,224,16,44,37,33,51,37,224,52,50,33,54,37,44,224,52,47,224,20,47,55,46,224,47,38,224,2,37,39,41,46,46,41,46,39,51,224,52,47,224,35,40,37,51,52,224,38,33,50,45,238},64))
cleanup(_d({9,46,54,33,44,41,36,224,44,47,35,33,52,41,47,46,224,38,47,50,224,35,40,37,51,52,224,38,33,50,45,41,46,39},64))
return
end
if not _G.EasyTravel then
importLib(_d({44,41,34,239,37,33,51,57,31,52,50,33,54,37,44,238,44,53,33},64), _d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,50,47,35,43,57,56,55,33,44,44,239,44,53,33,53,237,35,47,36,37,239,45,33,41,46,239,240,241,31,51,35,50,41,48,52,239,44,41,34,239,37,33,51,57,31,52,50,33,54,37,44,238,44,53,33},64))
end
if not _G.ChestFarmer then
importLib(_d({44,41,34,239,35,40,37,51,52,31,38,33,50,45,37,50,238,44,53,33},64), _d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,50,47,35,43,57,56,55,33,44,44,239,44,53,33,53,237,35,47,36,37,239,45,33,41,46,239,240,241,31,51,35,50,41,48,52,239,44,41,34,239,35,40,37,51,52,31,38,33,50,45,37,50,238,44,53,33},64))
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
cleanup(_d({3,40,37,51,52,224,38,33,50,45,224,38,33,41,44,37,36,224,47,50,224,51,52,47,48,48,37,36},64))
return
end
else
error(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,224,44,41,34,239,35,40,37,51,52,31,38,33,50,45,37,50,238,44,53,33,225},64))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,14,33,54,41,39,33,52,41,46,39,224,52,47,224,34,53,57,224,18,41,38,44,37,238,238,238},64))
local buyables = Workspace:FindFirstChild(_d({2,53,57,33,34,44,37,9,52,37,45,51},64))
local shopItem = buyables and buyables:FindFirstChild(_d({18,41,38,44,37},64))
local shopPart = shopItem and shopItem:FindFirstChild(_d({19,40,47,48,16,33,50,52},64))
if not shopPart then
error(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,18,41,38,44,37,224,19,40,47,48,16,33,50,52,224,46,47,52,224,38,47,53,46,36,224,53,46,36,37,50,224,2,53,57,33,34,44,37,9,52,37,45,51,225},64))
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
cleanup(_d({6,33,41,44,37,36,224,52,47,224,50,37,33,35,40,224,18,41,38,44,37,224,51,40,47,48},64))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({16,50,47,56,41,45,41,52,57,16,50,47,45,48,52},64), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,16,53,50,35,40,33,51,37,36,224,18,41,38,44,37,224,48,50,47,45,48,52,224,52,50,41,39,39,37,50,37,36,238},64))
else
warn(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,38,41,50,37,48,50,47,56,41,45,41,52,57,48,50,47,45,48,52,224,46,47,52,224,51,53,48,48,47,50,52,37,36,224,34,57,224,37,56,37,35,53,52,47,50,225},64))
end
else
error(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,16,50,47,56,41,45,41,52,57,16,50,47,45,48,52,224,46,47,52,224,38,47,53,46,36,224,47,46,224,18,41,38,44,37,224,51,40,47,48,224,41,52,37,45,225},64))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({5,54,37,46,52,51},64)) and ReplicatedStorage.Events:FindFirstChild(_d({19,40,47,48},64))
if shopEvent and shopEvent:IsA(_d({18,37,45,47,52,37,6,53,46,35,52,41,47,46},64)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({16,44,33,57,37,50,7,53,41},64))
local diag = pgui and pgui:FindFirstChild(_d({4,41,33,44,47,39,53,37},64))
if diag then
local closeBtn = diag:FindFirstChild(_d({3,44,47,51,37},64), true)
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
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,5,49,53,41,48,48,41,46,39,224,18,41,38,44,37,224,38,50,47,45,224,41,46,54,37,46,52,47,50,57,238,238,238},64))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({18,41,38,44,37},64) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,18,41,38,44,37,224,46,47,52,224,41,46,224,40,47,52,34,33,50,238,224,5,49,53,41,48,48,41,46,39,224,54,41,33,224,22,9,13,224,13,33,35,50,47,224,48,44,33,57,34,33,35,43,238,238,238},64))
local vim = game:GetService(_d({22,41,50,52,53,33,44,9,46,48,53,52,13,33,46,33,39,37,50},64))
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
if toolName == _d({18,41,38,44,37},64) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,6,33,41,44,37,36,224,52,47,224,33,51,51,41,39,46,224,18,41,38,44,37,224,52,47,224,33,224,40,47,52,34,33,50,224,51,44,47,52,238},64))
cleanup(_d({18,41,38,44,37,224,37,49,53,41,48,224,37,50,50,47,50},64))
return
end
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,18,41,38,44,37,224,41,51,224,45,33,48,48,37,36,224,52,47,224,40,47,52,34,33,50,224,51,44,47,52,250,224},64) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({22,41,50,52,53,33,44,9,46,48,53,52,13,33,46,33,39,37,50},64))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,16,50,37,51,51,41,46,39,224,40,47,52,34,33,50,224,43,37,57,250,224},64) .. tostring(currentSlot) .. _d({224,52,47,224,48,53,44,44,224,47,53,52,224,18,41,38,44,37,238,238,238},64))
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
local rh = char and char:FindFirstChild(_d({18,41,39,40,52,8,33,46,36},64))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({18,41,38,44,37},64)) then
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
warn(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,18,41,38,44,37,224,36,41,36,224,46,47,52,224,33,48,48,37,33,50,224,41,46,224,18,41,39,40,52,8,33,46,36,224,33,38,52,37,50,224,48,50,37,51,51,41,46,39,224,40,47,52,43,37,57,238},64))
cleanup(_d({18,41,38,44,37,224,37,49,53,41,48,224,52,41,45,37,47,53,52},64))
return
end
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,18,41,38,44,37,224,41,51,224,45,33,48,48,37,36,224,52,47,224,40,47,52,34,33,50,224,51,44,47,52,250,224},64) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({22,41,50,52,53,33,44,9,46,48,53,52,13,33,46,33,39,37,50},64))
local keyCode = Enum.KeyCode[currentSlot]
end)()