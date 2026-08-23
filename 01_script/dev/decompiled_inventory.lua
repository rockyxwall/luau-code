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
game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
game:GetService(_d({34,69,51,51,60,33,51,64,68,55,49,51},50))
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
local HttpService = game:GetService(_d({22,66,66,62,33,51,64,68,55,49,51},50))
local RunService = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local Modules = ReplicatedStorage:WaitForChild(_d({27,61,50,67,58,51,65},50))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({34,61,61,58,18,51,65,49},50))
require(Modules.Leveling)
require(Shared.GameUtils)
require(Shared.SoundUtils)
local u56 = require(ToolDesc)
local QueueTask = require(Shared.Queues.QueueTask)
local Module3D = require(Modules.Module3D)
local RichText = require(Modules.RichText)
require(Shared.Maids.Maid)
local Titles = require(Modules.Titles)
local Trove = require(game.ReplicatedStorage.Modules.Trove)
require(ReplicatedStorage.Modules.Shared.TailorCodec)
local TailorPortCodeUI = require(ReplicatedStorage.Modules.Client.UIs.TailorPortCodeUI)
local Events = ReplicatedStorage:WaitForChild(_d({19,68,51,60,66,65},50))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({35,23,65},50))
local RarityGradient = require(UIs:WaitForChild(_d({32,47,64,55,66,71,21,64,47,50,55,51,60,66},50)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({30,58,47,71,51,64,21,67,55},50))
local Tools = ReplicatedStorage:WaitForChild(_d({34,61,61,58,65},50))
local Gradients = script:WaitForChild(_d({21,64,47,50,55,51,60,66,65},50))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({35,60,49,61,59,59,61,60},50)),
Rare = Gradients:WaitForChild(_d({32,47,64,51},50)),
Epic = Gradients:WaitForChild(_d({19,62,55,49},50)),
Legendary = Gradients:WaitForChild(_d({26,51,53,51,60,50,47,64,71},50)),
Mythical = Gradients:WaitForChild(_d({27,71,66,54,55,49,47,58},50)),
Collectable = Gradients:WaitForChild(_d({17,61,58,58,51,49,66,47,48,58,51},50)),
}
local v1 = {
Common = 0,
Uncommon = -200,
Rare = -400,
Epic = -600,
Legendary = -800,
Mythical = -1000,
Collectable = -1200,
}
local u162 = table.freeze(v1)
local v2 = {
Mythical = 0,
Legendary = 1,
Epic = 2,
Rare = 3,
Common = 4,
}
local u165 = table.freeze(v2)
local u166 = {
HP = {Display = _d({19,70,66,64,47,238,22,51,47,58,66,54},50), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({22,51,47,58,66,54,238,32,51,53,51,60},50), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({33,66,47,59,55,60,47,238,32,51,53,51,60},50), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({19,70,66,64,47,238,33,66,47,59,55,60,47},50), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({33,69,61,64,50,238,18,27,21,238,27,67,58,66},50), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({33,34,32,238,18,27,21,238,27,67,58,66},50), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({18,27,21,238,27,67,58,66,55,62,58,55,51,64},50), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({32,51,50,67,49,51,50,238,18,27,21},50), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({32,51,50,67,49,51,50,238,16,67,64,60},50), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({32,51,50,67,49,51,50,238,20,64,51,51,72,51},50), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({21,64,51,68,55,61,67,65,238,37,61,67,60,50,65},50), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({60,67,59,48,51,64},50) then
local v2
p1.Visible = true
if v1.UsePercentValue ~= true then
v2 = math.floor(p3 * 100) / 100
else
v2 = math.floor(p3 * 100 * 100) / 100 .. "%"
if not v2 then
v2 = math.floor(p3 * 100) / 100
end
end
local v3 = math.floor(Color.R * 255)
local v4 = math.floor(Color.G * 255)
local v5 = math.floor(Color.B * 255)
p1.Text = ("%*: <font color=\"rgb(%*, %*, %*)\"><b>%*</b></font>"):format(v1.Display, v3, v4, v5, v2)
return
elseif p3 <= 0 then
p1.Visible = false
return
end
end
local u235 = {
Initialized = false,
DisplayItemStats = function(p1, p2)
local Attributes
local v1 = ToolDesc.ItemStats:FindFirstChild(p2)
if v1 == nil and u56[p2] and u56[p2].BaseItem ~= nil then
v1 = ToolDesc.ItemStats:FindFirstChild(u56[p2].BaseItem)
end
if not v1 then
Attributes = {}
else
Attributes = v1:GetAttributes()
end
for i, v in ipairs(p1:GetChildren()) do
if v:IsA(_d({34,51,70,66,26,47,48,51,58},50)) then
UpdateStatText(v, v.Name, Attributes[v.Name] or 0)
end
end
end,
}
function u235.Initialize(p1)
local ItemRotation, PropertyChangedSignal, TailorableWeapons, Value, v1, v2, v3, v4
if u235.Initialized then
return
end
ReplicatedStorage:WaitForChild(_d({64,51,65,51,64,68,51,50,17,61,50,51},50))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({33,66,47,66,65},50))
local v6 = StatsFolder:WaitForChild(_d({23,60,68,51,60,66,61,64,71},50))
local Inventory = v6:WaitForChild(_d({23,60,68,51,60,66,61,64,71},50))
local Equiped = v6:WaitForChild(_d({19,63,67,55,62,51,50},50))
local VanitySlots = v6:WaitForChild(_d({36,47,60,55,66,71,33,58,61,66,65},50))
local FightingStyle = v5:WaitForChild(_d({20,55,53,54,66,55,60,53,33,66,71,58,51},50))
local KatanaOrder = v6:WaitForChild(_d({25,47,66,47,60,47,29,64,50,51,64},50))
local EquipedShip = v6:WaitForChild(_d({19,63,67,55,62,51,50,33,54,55,62},50))
local v7 = StatsFolder:WaitForChild(_d({34,55,66,58,51,65},50))
local AllTitles = v7:WaitForChild(_d({15,58,58,34,55,66,58,51,65},50))
local EquipedTitle = v7:WaitForChild(_d({19,63,67,55,62,51,50,34,55,66,58,51},50))
local AutoEquip = StatsFolder:WaitForChild(_d({33,51,66,66,55,60,53,65},50)):WaitForChild(_d({15,67,66,61,19,63,67,55,62},50))
local EquipedGrip = StatsFolder:WaitForChild(_d({21,64,55,62,65},50)):WaitForChild(_d({19,63,67,55,62,51,50,21,64,55,62},50))
local Inventory_2 = PlayerGui:WaitForChild(_d({23,60,68,51,60,66,61,64,71},50), 360)
local Main = Inventory_2:WaitForChild(_d({27,47,55,60},50))
local v8 = Main:WaitForChild(_d({23,60,68,51,60,66,61,64,71},50))
local List = v8:WaitForChild(_d({26,55,65,66},50))
local v9 = Main:WaitForChild(_d({34,61,62,34,47,48,65},50))
local UIGridLayout = List:WaitForChild(_d({35,23,21,64,55,50,26,47,71,61,67,66},50))
local UIPadding = List:WaitForChild(_d({35,23,30,47,50,50,55,60,53},50))
local v10 = v8:WaitForChild(_d({33,51,47,64,49,54},50))
local Input = v10:WaitForChild(_d({23,60,62,67,66},50))
local Clear = v10:WaitForChild(_d({17,58,51,47,64},50))
local ItemMenu = Main:WaitForChild(_d({23,66,51,59,27,51,60,67},50))
local Health = ItemMenu:WaitForChild(_d({22,51,47,58,66,54},50))
local Bar = Health:WaitForChild(_d({16,47,64},50))
local Equip = ItemMenu:WaitForChild(_d({19,63,67,55,62},50))
local Usage = Equip:WaitForChild(_d({35,65,47,53,51},50))
local Drop = ItemMenu:WaitForChild(_d({18,64,61,62},50))
local v11 = ItemMenu:WaitForChild(_d({27,55,65,49,16,67,66,66,61,60,65},50))
local Vanity = v11:WaitForChild(_d({36,47,60,55,66,71},50))
local CustomTailoredToggle = v11:WaitForChild(_d({17,67,65,66,61,59,34,47,55,58,61,64,51,50,34,61,53,53,58,51},50))
local SwordButtons = ItemMenu:WaitForChild(_d({33,69,61,64,50,16,67,66,66,61,60,65},50))
local Stats = ItemMenu:WaitForChild(_d({33,66,47,66,65},50))
local Boosts = Main:WaitForChild(_d({33,66,47,66,67,65,16,61,61,65,66,65},50)):WaitForChild(_d({16,61,61,65,66,65},50))
local v12 = Main:WaitForChild(_d({33,51,58,51,49,66,55,61,60,65},50))
local Frames = v12:WaitForChild(_d({20,64,47,59,51,65},50))
local RarityFilter = Main:WaitForChild(_d({32,47,64,55,66,71,20,55,58,66,51,64},50))
local Grips = Main:WaitForChild(_d({21,64,55,62,65},50))
local List_2 = Grips:WaitForChild(_d({26,55,65,66},50))
local LoadoutFrame = Main:WaitForChild(_d({26,61,47,50,61,67,66,20,64,47,59,51},50))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({19,60,47,48,58,51,50},50))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({36,55,65,55,48,58,51},50), Enabled)
RarityGradient.SetRainbowGradientsGui(Inventory_2, Enabled)
end)
local u199 = {}
local u200 = {}
local u201 = {}
local function DestroyItemPreview(p1)
local v1 = u201[p1]
if v1 == nil then
return
end
u201[p1] = nil
v1:Destroy()
end
end)()