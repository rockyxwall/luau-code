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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local VIM = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({16,59,64,53,230,58,46,43,230,10,47,39,51,53,52,42,40,39,41,49},58),
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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({25,58,39,58,57},58) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({22,43,50,47},58))
if not (peliValueObj and peliValueObj:IsA(_d({28,39,50,59,43,8,39,57,43},58))) then
local nested = statsFolder:FindFirstChild(_d({25,58,39,58,57},58))
peliValueObj = nested and nested:FindFirstChild(_d({22,43,50,47},58))
end
levelValueObj = statsFolder:FindFirstChild(_d({18,43,60,43,50},58))
if not (levelValueObj and levelValueObj:IsA(_d({28,39,50,59,43,8,39,57,43},58))) then
local nested = statsFolder:FindFirstChild(_d({25,58,39,58,57},58))
levelValueObj = nested and nested:FindFirstChild(_d({18,43,60,43,50},58))
end
staminaValueObj = statsFolder:FindFirstChild(_d({25,58,39,51,47,52,39},58))
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
local hum = char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42},58))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
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
print("[" .. tostring(name) .. _d({35,230,25,58,39,52,42,39,50,53,52,43,230,19,53,42,43,0,230,22,56,43,57,57,230,237},58) .. toggleKey.Name .. _d({237,230,58,53,230,58,53,45,45,50,43,244},58))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({16,49,248,16,17,26,7,17,9,44},58),
TeleportLocation = _d({247,57,58,25,43,39},58)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({12,47,56,57,58,230,25,43,39,230,14,53,51,43,57,41,56,43,43,52,230,245,230,19,39,47,52,230,19,43,52,59},58),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({57,58,56,47,52,45},58) and code ~= "" then
print(string.format(_d({33,25,39,44,43,45,59,39,56,42,35,230,16,53,47,52,47,52,45,230,22,56,47,60,39,58,43,230,25,43,56,60,43,56,230,237,235,57,237,244,244,244},58), code))
task.spawn(function()
local rs = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local reservedRemote = rs:WaitForChild(_d({11,60,43,52,58,57},58)):WaitForChild(_d({56,43,57,43,56,60,43,42},58))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({24,43,51,53,58,43,11,60,43,52,58},58)) and (v.Name == _d({24,43,51,53,58,43,11,60,43,52,58},58) or v.Name == _d({58,43,50,43},58) or v.Name == _d({26,43,50,43,54,53,56,58},58)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({33,25,39,44,43,45,59,39,56,42,35,230,12,47,56,47,52,45,230,58,43,50,43,54,53,56,58,230,56,43,51,53,58,43,0,230},58) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,9,53,59,50,42,230,52,53,58,230,44,47,52,42,230,24,43,51,53,58,43,11,60,43,52,58,230,47,52,230,52,47,50,244,230,22,56,47,52,58,47,52,45,230,39,50,50,230,24,43,51,53,58,43,11,60,43,52,58,57,230,47,52,230,52,47,50,0},58))
for _,v in next, getnilinstances() do
if v:IsA(_d({24,43,51,53,58,43,11,60,43,52,58},58)) then
print(_d({230,243,230,20,39,51,43,0},58), v.Name)
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
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,29,56,53,52,45,230,45,39,51,43,230,59,52,47,60,43,56,57,43,231,230,25,41,56,47,54,58,230,47,57,230,53,52,50,63,230,44,53,56,230,13,22,21,244},58))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,25,41,56,47,54,58,230,43,62,43,41,59,58,47,53,52,230,40,50,53,41,49,43,42,230,53,52,0,230},58) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({33,25,39,44,43,45,59,39,56,42,35,230,26,43,50,43,54,53,56,58,47,52,45,230,58,53,230,22,56,47,60,39,58,43,230,25,43,56,60,43,56,244,244,244,230,22,50,43,39,57,43,230,61,39,47,58,244},58))
else
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,22,56,47,60,39,58,43,25,43,56,60,43,56,9,53,42,43,230,47,57,230,52,53,58,230,57,43,58,244,230,9,39,52,52,53,58,230,39,59,58,53,243,48,53,47,52,244},58))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,29,56,53,52,45,230,45,39,51,43,230,59,52,47,60,43,56,57,43,231,230,25,41,56,47,54,58,230,47,57,230,53,52,50,63,230,44,53,56,230,13,22,21,244},58))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({33,25,39,44,43,45,59,39,56,42,35,230,31,53,59,230,39,56,43,230,53,52,230,58,46,43,230,14,53,51,43,57,41,56,43,43,52,244,230,25,41,56,47,54,58,230,56,43,55,59,47,56,43,57,230,235,57,244},58), name or _d({39,230,57,54,43,41,47,44,47,41,230,54,50,39,41,43},58)))
if Safeguard.JoinPrivateServer() then
print(_d({33,25,39,44,43,45,59,39,56,42,35,230,26,43,50,43,54,53,56,58,47,52,45,230,58,53,230,22,56,47,60,39,58,43,230,25,43,56,60,43,56,244,244,244,230,22,50,43,39,57,43,230,61,39,47,58,244},58))
else
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,22,56,47,60,39,58,43,25,43,56,60,43,56,9,53,42,43,230,47,57,230,52,53,58,230,57,43,58,244,230,9,39,52,52,53,58,230,39,59,58,53,243,48,53,47,52,244},58))
end
return false
end
warn(string.format(_d({33,25,39,44,43,45,59,39,56,42,35,230,29,56,53,52,45,230,54,50,39,41,43,231,230,24,43,55,59,47,56,43,42,0,230,235,57,230,238,235,42,239,242,230,9,59,56,56,43,52,58,0,230,235,42},58), name or _d({27,52,49,52,53,61,52},58), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
if Safeguard then return Safeguard end
return Core.Import(_d({246,247,243,45,54,53,245,50,47,40,245,57,39,44,43,45,59,39,56,42,244,50,59,39},58), _d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,57,39,44,43,45,59,39,56,42,244,50,59,39},58))
end
return Core
end)()
if not Core then
pcall(function()
Core = loadstring(game:HttpGet(_d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,41,53,56,43,244,50,59,39},58)))()
end)
end
if not Core then warn(_d({33,9,53,56,43,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,231},58)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({8,39,41,49,54,39,41,49},58))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({14,53,56,53,243,14,53,56,53},58)) or (bp and bp:FindFirstChild(_d({14,53,56,53,243,14,53,56,53},58)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({20,22,9,57},58))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local hum = boss:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
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
if key == _d({14,47,58},58) then return target.CFrame
elseif key == _d({26,39,56,45,43,58},58) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({33,14,53,56,53,12,39,56,51,35,230,19,43,58,39,58,39,40,50,43,230,46,53,53,49,230,44,39,47,50,43,42,0,230},58) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({33,14,53,56,53,12,39,56,51,35,230,25,58,53,54,54,43,42,244},58))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({33,14,53,56,53,12,39,56,51,35,230,7,50,56,43,39,42,63,230,56,59,52,52,47,52,45,231},58)); return end
if not Safeguard then warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,231},58)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({33,14,53,56,53,12,39,56,51,35,230,25,58,39,56,58,43,42,230,58,39,56,45,43,58,47,52,45,0,230},58) .. HoroFarm.Config.SelectedBoss)
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
_d({14,53,56,53,12,39,56,51},58),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)()