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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local VIM = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({37,80,85,74,251,79,67,64,251,31,68,60,72,74,73,63,61,60,62,70},37),
UseE = true,
UseZ = true,
UseC = true,
UseR = true,
},
}
local Core = (function()
local Core = {}
function Core.Import(localPath, publicUrl)
local loaded = false
local result = nil
local oldState = _G.DisableStandalone
_G.DisableStandalone = true
if isfile and readfile then
pcall(function()
local content = readfile(localPath)
if content and content ~= "" then
result = loadstring(content)()
loaded = true
end
end)
end
if not loaded then
pcall(function()
result = loadstring(game:HttpGet(publicUrl))()
end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({43,64,71,68},37))
if not (peliValueObj and peliValueObj:IsA(_d({49,60,71,80,64,29,60,78,64},37))) then
local nested = statsFolder:FindFirstChild(_d({46,79,60,79,78},37))
peliValueObj = nested and nested:FindFirstChild(_d({43,64,71,68},37))
end
levelValueObj = statsFolder:FindFirstChild(_d({39,64,81,64,71},37))
if not (levelValueObj and levelValueObj:IsA(_d({49,60,71,80,64,29,60,78,64},37))) then
local nested = statsFolder:FindFirstChild(_d({46,79,60,79,78},37))
levelValueObj = nested and nested:FindFirstChild(_d({39,64,81,64,71},37))
end
staminaValueObj = statsFolder:FindFirstChild(_d({46,79,60,72,68,73,60},37))
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
local hum = char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63},37))
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
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
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
print("[" .. tostring(name) .. _d({56,251,46,79,60,73,63,60,71,74,73,64,251,40,74,63,64,21,251,43,77,64,78,78,251,2},37) .. toggleKey.Name .. _d({2,251,79,74,251,79,74,66,66,71,64,9},37))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({37,70,13,37,38,47,28,38,30,65},37),
TeleportLocation = _d({12,78,79,46,64,60},37),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({33,68,77,78,79,251,46,64,60,251,35,74,72,64,78,62,77,64,64,73,251,10,251,40,60,68,73,251,40,64,73,80},37),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({78,79,77,68,73,66},37) and code ~= "" then
print(string.format(_d({54,46,60,65,64,66,80,60,77,63,56,251,37,74,68,73,68,73,66,251,43,77,68,81,60,79,64,251,46,64,77,81,64,77,251,2,0,78,2,9,9,9},37), code))
task.spawn(function()
local rs = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local reservedRemote = rs:WaitForChild(_d({32,81,64,73,79,78},37)):WaitForChild(_d({77,64,78,64,77,81,64,63},37))
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
v:IsA(_d({45,64,72,74,79,64,32,81,64,73,79},37)) and (v.Name == _d({45,64,72,74,79,64,32,81,64,73,79},37) or v.Name == _d({79,64,71,64},37) or v.Name == _d({47,64,71,64,75,74,77,79},37))
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
print(_d({54,46,60,65,64,66,80,60,77,63,56,251,33,68,77,68,73,66,251,79,64,71,64,75,74,77,79,251,77,64,72,74,79,64,21,251},37) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,30,74,80,71,63,251,73,74,79,251,65,68,73,63,251,45,64,72,74,79,64,32,81,64,73,79,251,68,73,251,73,68,71,9,251,43,77,68,73,79,68,73,66,251,60,71,71,251,45,64,72,74,79,64,32,81,64,73,79,78,251,68,73,251,73,68,71,21},37))
for _, v in next, getnilinstances() do
if v:IsA(_d({45,64,72,74,79,64,32,81,64,73,79},37)) then
print(_d({251,8,251,41,60,72,64,21},37), v.Name)
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
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,50,77,74,73,66,251,66,60,72,64,251,80,73,68,81,64,77,78,64,252,251,46,62,77,68,75,79,251,68,78,251,74,73,71,84,251,65,74,77,251,34,43,42,9},37))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,46,62,77,68,75,79,251,64,83,64,62,80,79,68,74,73,251,61,71,74,62,70,64,63,251,74,73,21,251},37) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({54,46,60,65,64,66,80,60,77,63,56,251,47,64,71,64,75,74,77,79,68,73,66,251,79,74,251,43,77,68,81,60,79,64,251,46,64,77,81,64,77,9,9,9,251,43,71,64,60,78,64,251,82,60,68,79,9},37))
else
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,43,77,68,81,60,79,64,46,64,77,81,64,77,30,74,63,64,251,68,78,251,73,74,79,251,78,64,79,9,251,30,60,73,73,74,79,251,60,80,79,74,8,69,74,68,73,9},37))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,50,77,74,73,66,251,66,60,72,64,251,80,73,68,81,64,77,78,64,252,251,46,62,77,68,75,79,251,68,78,251,74,73,71,84,251,65,74,77,251,34,43,42,9},37))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({54,46,60,65,64,66,80,60,77,63,56,251,52,74,80,251,60,77,64,251,74,73,251,79,67,64,251,35,74,72,64,78,62,77,64,64,73,9,251,46,62,77,68,75,79,251,77,64,76,80,68,77,64,78,251,0,78,9},37), name or _d({60,251,78,75,64,62,68,65,68,62,251,75,71,60,62,64},37)))
if Safeguard.JoinPrivateServer() then
print(_d({54,46,60,65,64,66,80,60,77,63,56,251,47,64,71,64,75,74,77,79,68,73,66,251,79,74,251,43,77,68,81,60,79,64,251,46,64,77,81,64,77,9,9,9,251,43,71,64,60,78,64,251,82,60,68,79,9},37))
else
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,43,77,68,81,60,79,64,46,64,77,81,64,77,30,74,63,64,251,68,78,251,73,74,79,251,78,64,79,9,251,30,60,73,73,74,79,251,60,80,79,74,8,69,74,68,73,9},37))
end
return false
end
warn(
string.format(
_d({54,46,60,65,64,66,80,60,77,63,56,251,50,77,74,73,66,251,75,71,60,62,64,252,251,45,64,76,80,68,77,64,63,21,251,0,78,251,3,0,63,4,7,251,30,80,77,77,64,73,79,21,251,0,63},37),
name or _d({48,73,70,73,74,82,73},37),
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
local bp = LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
local char = LocalPlayer.Character
if not char then
return nil
end
local tool = char:FindFirstChild(_d({35,74,77,74,8,35,74,77,74},37)) or (bp and bp:FindFirstChild(_d({35,74,77,74,8,35,74,77,74},37)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
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
local npts = Workspace:FindFirstChild(_d({41,43,30,78},37))
if not npts then
return nil
end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local hum = boss:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
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
if key == _d({35,68,79},37) then
return target.CFrame
elseif key == _d({47,60,77,66,64,79},37) then
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
warn(_d({54,35,74,77,74,33,60,77,72,56,251,40,64,79,60,79,60,61,71,64,251,67,74,74,70,251,65,60,68,71,64,63,21,251},37) .. tostring(err))
end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do
conn:Disconnect()
end
HoroFarm.Connections = {}
print(_d({54,35,74,77,74,33,60,77,72,56,251,46,79,74,75,75,64,63,9},37))
end
function HoroFarm.Start()
if HoroFarm.Running then
warn(_d({54,35,74,77,74,33,60,77,72,56,251,28,71,77,64,60,63,84,251,77,80,73,73,68,73,66,252},37))
return
end
if not Safeguard then
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,252},37))
return
end
if not Safeguard.IsSafe() then
return
end
HoroFarm.Running = true
setupHook()
print(_d({54,35,74,77,74,33,60,77,72,56,251,46,79,60,77,79,64,63,251,79,60,77,66,64,79,68,73,66,21,251},37) .. HoroFarm.Config.SelectedBoss)
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
Core.SetupStandalone(HoroFarm, _d({35,74,77,74,33,60,77,72},37), HoroFarm.Start, HoroFarm.Stop, function()
return HoroFarm.Running
end)
return HoroFarm
end)()