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
print(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,36,55,51,53,58,55,54,242,24,59,69,58,63,51,64,242,21,51,72,55,243,242,37,70,65,66,66,59,64,57,242,56,62,59,57,58,70,0},46))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,24,51,59,62,55,54,242,70,65,242,59,64,59,70,59,51,62,59,76,55,242,23,51,69,75,242,38,68,51,72,55,62,0},46))
end
cleanup(_d({19,68,68,59,72,55,54,242,51,70,242,24,59,69,58,63,51,64,242,21,51,72,55},46))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,36,59,56,62,55,242,51,62,68,55,51,54,75,242,55,67,71,59,66,66,55,54,1,65,73,64,55,54,0},46))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({36,59,56,62,55},46))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,36,59,56,62,55,242,55,67,71,59,66,66,55,54,243},46))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = Core.GetRoot(LocalPlayer)
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,32,65,70,242,55,64,65,71,57,58,242,34,55,62,59,242,70,65,242,52,71,75,242,51,242,36,59,56,62,55,242,250,5,2,2,251,242,51,64,54,242,64,65,70,242,51,70,242,38,65,73,64,242,65,56,242,20,55,57,59,64,64,59,64,57,69,0,242,34,62,55,51,69,55,242,70,68,51,72,55,62,242,70,65,242,38,65,73,64,242,65,56,242,20,55,57,59,64,64,59,64,57,69,242,70,65,242,53,58,55,69,70,242,56,51,68,63,0},46))
cleanup(_d({27,64,72,51,62,59,54,242,62,65,53,51,70,59,65,64,242,56,65,68,242,53,58,55,69,70,242,56,51,68,63,59,64,57},46))
return
end
if not _G.EasyTravel then
Core.Import(_d({2,3,255,57,66,65,1,62,59,52,1,55,51,69,75,49,70,68,51,72,55,62,0,62,71,51},46), _d({58,70,70,66,69,12,1,1,68,51,73,0,57,59,70,58,71,52,71,69,55,68,53,65,64,70,55,64,70,0,53,65,63,1,68,65,53,61,75,74,73,51,62,62,1,62,71,51,71,255,53,65,54,55,1,63,51,59,64,1,2,3,49,69,53,68,59,66,70,1,62,59,52,1,55,51,69,75,49,70,68,51,72,55,62,0,62,71,51},46))
end
if not _G.ChestFarmer then
Core.Import(_d({2,3,255,57,66,65,1,62,59,52,1,53,58,55,69,70,49,56,51,68,63,55,68,0,62,71,51},46), _d({58,70,70,66,69,12,1,1,68,51,73,0,57,59,70,58,71,52,71,69,55,68,53,65,64,70,55,64,70,0,53,65,63,1,68,65,53,61,75,74,73,51,62,62,1,62,71,51,71,255,53,65,54,55,1,63,51,59,64,1,2,3,49,69,53,68,59,66,70,1,62,59,52,1,53,58,55,69,70,49,56,51,68,63,55,68,0,62,71,51},46))
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
cleanup(_d({21,58,55,69,70,242,56,51,68,63,242,56,51,59,62,55,54,242,65,68,242,69,70,65,66,66,55,54},46))
return
end
else
error(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,24,51,59,62,55,54,242,70,65,242,62,65,51,54,242,62,59,52,1,53,58,55,69,70,49,56,51,68,63,55,68,0,62,71,51,243},46))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,32,51,72,59,57,51,70,59,64,57,242,70,65,242,52,71,75,242,36,59,56,62,55,0,0,0},46))
local buyables = Workspace:FindFirstChild(_d({20,71,75,51,52,62,55,27,70,55,63,69},46))
local shopItem = buyables and buyables:FindFirstChild(_d({36,59,56,62,55},46))
local shopPart = shopItem and shopItem:FindFirstChild(_d({37,58,65,66,34,51,68,70},46))
if not shopPart then
error(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,36,59,56,62,55,242,37,58,65,66,34,51,68,70,242,64,65,70,242,56,65,71,64,54,242,71,64,54,55,68,242,20,71,75,51,52,62,55,27,70,55,63,69,243},46))
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
cleanup(_d({24,51,59,62,55,54,242,70,65,242,68,55,51,53,58,242,36,59,56,62,55,242,69,58,65,66},46))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({34,68,65,74,59,63,59,70,75,34,68,65,63,66,70},46), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,34,71,68,53,58,51,69,55,54,242,36,59,56,62,55,242,66,68,65,63,66,70,242,70,68,59,57,57,55,68,55,54,0},46))
else
warn(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,56,59,68,55,66,68,65,74,59,63,59,70,75,66,68,65,63,66,70,242,64,65,70,242,69,71,66,66,65,68,70,55,54,242,52,75,242,55,74,55,53,71,70,65,68,243},46))
end
else
error(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,34,68,65,74,59,63,59,70,75,34,68,65,63,66,70,242,64,65,70,242,56,65,71,64,54,242,65,64,242,36,59,56,62,55,242,69,58,65,66,242,59,70,55,63,243},46))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({23,72,55,64,70,69},46)) and ReplicatedStorage.Events:FindFirstChild(_d({37,58,65,66},46))
if shopEvent and shopEvent:IsA(_d({36,55,63,65,70,55,24,71,64,53,70,59,65,64},46)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({34,62,51,75,55,68,25,71,59},46))
local diag = pgui and pgui:FindFirstChild(_d({22,59,51,62,65,57,71,55},46))
if diag then
local closeBtn = diag:FindFirstChild(_d({21,62,65,69,55},46), true)
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
print(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,23,67,71,59,66,66,59,64,57,242,36,59,56,62,55,0,0,0},46))
local args = {
[1] = _d({55,67,71,59,66},46),
[2] = _d({36,59,56,62,55},46)
}
pcall(function()
game:GetService(_d({36,55,66,62,59,53,51,70,55,54,37,70,65,68,51,57,55},46)):WaitForChild(_d({23,72,55,64,70,69},46)):WaitForChild(_d({38,65,65,62,69},46)):InvokeServer(unpack(args))
end)
task.wait(1)
end)()