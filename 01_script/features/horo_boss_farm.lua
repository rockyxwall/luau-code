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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local RunService = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50))
local VIM = game:GetService(_d({36,55,64,66,67,47,58,23,60,62,67,66,27,47,60,47,53,51,64},50))
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({24,67,72,61,238,66,54,51,238,18,55,47,59,61,60,50,48,47,49,57},50),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
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
pcall(function() result = loadstring(game:HttpGet(publicUrl))() end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({30,51,58,55},50))
if not (peliValueObj and peliValueObj:IsA(_d({36,47,58,67,51,16,47,65,51},50))) then
local nested = statsFolder:FindFirstChild(_d({33,66,47,66,65},50))
peliValueObj = nested and nested:FindFirstChild(_d({30,51,58,55},50))
end
levelValueObj = statsFolder:FindFirstChild(_d({26,51,68,51,58},50))
if not (levelValueObj and levelValueObj:IsA(_d({36,47,58,67,51,16,47,65,51},50))) then
local nested = statsFolder:FindFirstChild(_d({33,66,47,66,65},50))
levelValueObj = nested and nested:FindFirstChild(_d({26,51,68,51,58},50))
end
staminaValueObj = statsFolder:FindFirstChild(_d({33,66,47,59,55,60,47},50))
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
local hum = char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50},50))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
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
if not game:IsLoaded() then game.Loaded:Wait() end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({43,238,33,66,47,60,50,47,58,61,60,51,238,27,61,50,51,8,238,30,64,51,65,65,238,245},50) .. toggleKey.Name .. _d({245,238,66,61,238,66,61,53,53,58,51,252},50))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({24,57,0,24,25,34,15,25,17,52},50),
TeleportLocation = _d({255,65,66,33,51,47},50)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({20,55,64,65,66,238,33,51,47,238,22,61,59,51,65,49,64,51,51,60,238,253,238,27,47,55,60,238,27,51,60,67},50),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({65,66,64,55,60,53},50) and code ~= "" then
print(string.format(_d({41,33,47,52,51,53,67,47,64,50,43,238,24,61,55,60,55,60,53,238,30,64,55,68,47,66,51,238,33,51,64,68,51,64,238,245,243,65,245,252,252,252},50), code))
task.spawn(function()
local rs = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local reservedRemote = rs:WaitForChild(_d({19,68,51,60,66,65},50)):WaitForChild(_d({64,51,65,51,64,68,51,50},50))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({32,51,59,61,66,51,19,68,51,60,66},50)) and (v.Name == _d({32,51,59,61,66,51,19,68,51,60,66},50) or v.Name == _d({66,51,58,51},50) or v.Name == _d({34,51,58,51,62,61,64,66},50)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({41,33,47,52,51,53,67,47,64,50,43,238,20,55,64,55,60,53,238,66,51,58,51,62,61,64,66,238,64,51,59,61,66,51,8,238},50) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,17,61,67,58,50,238,60,61,66,238,52,55,60,50,238,32,51,59,61,66,51,19,68,51,60,66,238,55,60,238,60,55,58,252,238,30,64,55,60,66,55,60,53,238,47,58,58,238,32,51,59,61,66,51,19,68,51,60,66,65,238,55,60,238,60,55,58,8},50))
for _,v in next, getnilinstances() do
if v:IsA(_d({32,51,59,61,66,51,19,68,51,60,66},50)) then
print(_d({238,251,238,28,47,59,51,8},50), v.Name)
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
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,37,64,61,60,53,238,53,47,59,51,238,67,60,55,68,51,64,65,51,239,238,33,49,64,55,62,66,238,55,65,238,61,60,58,71,238,52,61,64,238,21,30,29,252},50))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,33,49,64,55,62,66,238,51,70,51,49,67,66,55,61,60,238,48,58,61,49,57,51,50,238,61,60,8,238},50) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({41,33,47,52,51,53,67,47,64,50,43,238,34,51,58,51,62,61,64,66,55,60,53,238,66,61,238,30,64,55,68,47,66,51,238,33,51,64,68,51,64,252,252,252,238,30,58,51,47,65,51,238,69,47,55,66,252},50))
else
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,30,64,55,68,47,66,51,33,51,64,68,51,64,17,61,50,51,238,55,65,238,60,61,66,238,65,51,66,252,238,17,47,60,60,61,66,238,47,67,66,61,251,56,61,55,60,252},50))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,37,64,61,60,53,238,53,47,59,51,238,67,60,55,68,51,64,65,51,239,238,33,49,64,55,62,66,238,55,65,238,61,60,58,71,238,52,61,64,238,21,30,29,252},50))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({41,33,47,52,51,53,67,47,64,50,43,238,39,61,67,238,47,64,51,238,61,60,238,66,54,51,238,22,61,59,51,65,49,64,51,51,60,252,238,33,49,64,55,62,66,238,64,51,63,67,55,64,51,65,238,243,65,252},50), name or _d({47,238,65,62,51,49,55,52,55,49,238,62,58,47,49,51},50)))
if Safeguard.JoinPrivateServer() then
print(_d({41,33,47,52,51,53,67,47,64,50,43,238,34,51,58,51,62,61,64,66,55,60,53,238,66,61,238,30,64,55,68,47,66,51,238,33,51,64,68,51,64,252,252,252,238,30,58,51,47,65,51,238,69,47,55,66,252},50))
else
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,30,64,55,68,47,66,51,33,51,64,68,51,64,17,61,50,51,238,55,65,238,60,61,66,238,65,51,66,252,238,17,47,60,60,61,66,238,47,67,66,61,251,56,61,55,60,252},50))
end
return false
end
warn(string.format(_d({41,33,47,52,51,53,67,47,64,50,43,238,37,64,61,60,53,238,62,58,47,49,51,239,238,32,51,63,67,55,64,51,50,8,238,243,65,238,246,243,50,247,250,238,17,67,64,64,51,60,66,8,238,243,50},50), name or _d({35,60,57,60,61,69,60},50), placeId, game.PlaceId))
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
local bp = LocalPlayer:FindFirstChild(_d({16,47,49,57,62,47,49,57},50))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({22,61,64,61,251,22,61,64,61},50)) or (bp and bp:FindFirstChild(_d({22,61,64,61,251,22,61,64,61},50)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({28,30,17,65},50))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
local hum = boss:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local function setupHook()
if _G.HoroMouseHooked then return end
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and HoroFarm.Running and HoroFarm.Config.SelectedBoss then
local target = getBossPart(HoroFarm.Config.SelectedBoss)
if target then
if key == _d({22,55,66},50) then return target.CFrame
elseif key == _d({34,47,64,53,51,66},50) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({41,22,61,64,61,20,47,64,59,43,238,27,51,66,47,66,47,48,58,51,238,54,61,61,57,238,52,47,55,58,51,50,8,238},50) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({41,22,61,64,61,20,47,64,59,43,238,33,66,61,62,62,51,50,252},50))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({41,22,61,64,61,20,47,64,59,43,238,15,58,64,51,47,50,71,238,64,67,60,60,55,60,53,239},50)); return end
if not Safeguard then warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,239},50)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({41,22,61,64,61,20,47,64,59,43,238,33,66,47,64,66,51,50,238,66,47,64,53,51,66,55,60,53,8,238},50) .. HoroFarm.Config.SelectedBoss)
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
if HoroFarm.Config.UseE then baseCD = 17
elseif HoroFarm.Config.UseZ then baseCD = 10 end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
task.wait(finalSleep)
end
end
end)
end
Core.SetupStandalone(
HoroFarm,
_d({22,61,64,61,20,47,64,59},50),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)()