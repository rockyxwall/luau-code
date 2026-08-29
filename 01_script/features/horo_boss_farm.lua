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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local VIM = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({22,65,70,59,236,64,52,49,236,16,53,45,57,59,58,48,46,45,47,55},52),
UseE = true,
UseZ = true,
UseC = true,
UseR = true,
},
}
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
else
peliValueObj = nil
levelValueObj = nil
staminaValueObj = nil
end
return statsFolder
end
function Core.GetPeli()
getStats()
return peliValueObj and peliValueObj.Value or 0
end
function Core.GetLevel()
getStats()
return levelValueObj and levelValueObj.Value or 1
end
function Core.GetStamina()
getStats()
if staminaValueObj then
return staminaValueObj.Value, staminaValueObj.MaxValue
end
return 0, 0
end
function Core.GetHealth()
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
if input.KeyCode == toggleKey then
if checkCallback() then
stopCallback()
else
startCallback()
end
end
end)
if module and module.Connections then
table.insert(module.Connections, connection)
end
if not noAutoStart then
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
end
end
end
end)
return true
end
return false
end
function Safeguard.IsSafe()
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
return Safeguard
end
return Core
end)()
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
local char = LocalPlayer.Character
if not char then
return nil
end
local tool = char:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)) or (bp and bp:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then
return nil
end
local npts = Workspace:FindFirstChild(_d({26,28,15,63},52))
if not npts then
return nil
end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hum = boss:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local function setupHook()
if _G.HoroMouseHooked then
return
end
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then
setreadonly(mt, false)
elseif make_writeable then
make_writeable(mt)
end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and HoroFarm.Running and HoroFarm.Config.SelectedBoss then
local target = getBossPart(HoroFarm.Config.SelectedBoss)
if target then
if key == _d({20,53,64},52) then
return target.CFrame
elseif key == _d({32,45,62,51,49,64},52) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then
setreadonly(mt, true)
elseif make_readonly then
make_readonly(mt)
end
end)
if not successHook then
warn(_d({39,20,59,62,59,18,45,62,57,41,236,25,49,64,45,64,45,46,56,49,236,52,59,59,55,236,50,45,53,56,49,48,6,236},52) .. tostring(err))
end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do
conn:Disconnect()
end
HoroFarm.Connections = {}
print(_d({39,20,59,62,59,18,45,62,57,41,236,31,64,59,60,60,49,48,250},52))
end
function HoroFarm.Start()
if HoroFarm.Running then
warn(_d({39,20,59,62,59,18,45,62,57,41,236,13,56,62,49,45,48,69,236,62,65,58,58,53,58,51,237},52))
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.IsSafe() then
return
end
HoroFarm.Running = true
setupHook()
print(_d({39,20,59,62,59,18,45,62,57,41,236,31,64,45,62,64,49,48,236,64,45,62,51,49,64,53,58,51,6,236},52) .. HoroFarm.Config.SelectedBoss)
task.spawn(function()
while HoroFarm.Running do
local targetRoot = getBossPart(HoroFarm.Config.SelectedBoss)
if not targetRoot then
task.wait(5)
else
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if HoroFarm.Config.UseC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
elseif HoroFarm.Config.UseZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
end
end
if HoroFarm.Config.UseE then
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
end
end
if HoroFarm.Config.UseR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
end
local baseCD = 5
if HoroFarm.Config.UseE then
baseCD = 17
elseif HoroFarm.Config.UseZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
task.wait(finalSleep)
end
end
end)
end
Core.SetupStandalone(HoroFarm, _d({20,59,62,59,18,45,62,57},52), HoroFarm.Start, HoroFarm.Stop, function()
return HoroFarm.Running
end)
return HoroFarm
end)()