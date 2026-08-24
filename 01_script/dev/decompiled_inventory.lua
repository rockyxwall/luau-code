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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
game:GetService(_d({27,62,44,44,53,26,44,57,61,48,42,44},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
local HttpService = game:GetService(_d({15,59,59,55,26,44,57,61,48,42,44},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local Modules = ReplicatedStorage:WaitForChild(_d({20,54,43,60,51,44,58},57))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({27,54,54,51,11,44,58,42},57))
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
local Events = ReplicatedStorage:WaitForChild(_d({12,61,44,53,59,58},57))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({28,16,58},57))
local RarityGradient = require(UIs:WaitForChild(_d({25,40,57,48,59,64,14,57,40,43,48,44,53,59},57)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57))
local Tools = ReplicatedStorage:WaitForChild(_d({27,54,54,51,58},57))
local Gradients = script:WaitForChild(_d({14,57,40,43,48,44,53,59,58},57))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({28,53,42,54,52,52,54,53},57)),
Rare = Gradients:WaitForChild(_d({25,40,57,44},57)),
Epic = Gradients:WaitForChild(_d({12,55,48,42},57)),
Legendary = Gradients:WaitForChild(_d({19,44,46,44,53,43,40,57,64},57)),
Mythical = Gradients:WaitForChild(_d({20,64,59,47,48,42,40,51},57)),
Collectable = Gradients:WaitForChild(_d({10,54,51,51,44,42,59,40,41,51,44},57)),
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
HP = {Display = _d({12,63,59,57,40,231,15,44,40,51,59,47},57), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({15,44,40,51,59,47,231,25,44,46,44,53},57), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({26,59,40,52,48,53,40,231,25,44,46,44,53},57), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({12,63,59,57,40,231,26,59,40,52,48,53,40},57), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({26,62,54,57,43,231,11,20,14,231,20,60,51,59},57), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({26,27,25,231,11,20,14,231,20,60,51,59},57), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({11,20,14,231,20,60,51,59,48,55,51,48,44,57},57), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({25,44,43,60,42,44,43,231,11,20,14},57), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({25,44,43,60,42,44,43,231,9,60,57,53},57), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({25,44,43,60,42,44,43,231,13,57,44,44,65,44},57), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({14,57,44,61,48,54,60,58,231,30,54,60,53,43,58},57), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({53,60,52,41,44,57},57) then
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
if v:IsA(_d({27,44,63,59,19,40,41,44,51},57)) then
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
ReplicatedStorage:WaitForChild(_d({57,44,58,44,57,61,44,43,10,54,43,44},57))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({26,59,40,59,58},57))
local v6 = StatsFolder:WaitForChild(_d({16,53,61,44,53,59,54,57,64},57))
local Inventory = v6:WaitForChild(_d({16,53,61,44,53,59,54,57,64},57))
local Equiped = v6:WaitForChild(_d({12,56,60,48,55,44,43},57))
local VanitySlots = v6:WaitForChild(_d({29,40,53,48,59,64,26,51,54,59,58},57))
local FightingStyle = v5:WaitForChild(_d({13,48,46,47,59,48,53,46,26,59,64,51,44},57))
local KatanaOrder = v6:WaitForChild(_d({18,40,59,40,53,40,22,57,43,44,57},57))
local EquipedShip = v6:WaitForChild(_d({12,56,60,48,55,44,43,26,47,48,55},57))
local v7 = StatsFolder:WaitForChild(_d({27,48,59,51,44,58},57))
local AllTitles = v7:WaitForChild(_d({8,51,51,27,48,59,51,44,58},57))
local EquipedTitle = v7:WaitForChild(_d({12,56,60,48,55,44,43,27,48,59,51,44},57))
local AutoEquip = StatsFolder:WaitForChild(_d({26,44,59,59,48,53,46,58},57)):WaitForChild(_d({8,60,59,54,12,56,60,48,55},57))
local EquipedGrip = StatsFolder:WaitForChild(_d({14,57,48,55,58},57)):WaitForChild(_d({12,56,60,48,55,44,43,14,57,48,55},57))
local Inventory_2 = PlayerGui:WaitForChild(_d({16,53,61,44,53,59,54,57,64},57), 360)
local Main = Inventory_2:WaitForChild(_d({20,40,48,53},57))
local v8 = Main:WaitForChild(_d({16,53,61,44,53,59,54,57,64},57))
local List = v8:WaitForChild(_d({19,48,58,59},57))
local v9 = Main:WaitForChild(_d({27,54,55,27,40,41,58},57))
local UIGridLayout = List:WaitForChild(_d({28,16,14,57,48,43,19,40,64,54,60,59},57))
local UIPadding = List:WaitForChild(_d({28,16,23,40,43,43,48,53,46},57))
local v10 = v8:WaitForChild(_d({26,44,40,57,42,47},57))
local Input = v10:WaitForChild(_d({16,53,55,60,59},57))
local Clear = v10:WaitForChild(_d({10,51,44,40,57},57))
local ItemMenu = Main:WaitForChild(_d({16,59,44,52,20,44,53,60},57))
local Health = ItemMenu:WaitForChild(_d({15,44,40,51,59,47},57))
local Bar = Health:WaitForChild(_d({9,40,57},57))
local Equip = ItemMenu:WaitForChild(_d({12,56,60,48,55},57))
local Usage = Equip:WaitForChild(_d({28,58,40,46,44},57))
local Drop = ItemMenu:WaitForChild(_d({11,57,54,55},57))
local v11 = ItemMenu:WaitForChild(_d({20,48,58,42,9,60,59,59,54,53,58},57))
local Vanity = v11:WaitForChild(_d({29,40,53,48,59,64},57))
local CustomTailoredToggle = v11:WaitForChild(_d({10,60,58,59,54,52,27,40,48,51,54,57,44,43,27,54,46,46,51,44},57))
local SwordButtons = ItemMenu:WaitForChild(_d({26,62,54,57,43,9,60,59,59,54,53,58},57))
local Stats = ItemMenu:WaitForChild(_d({26,59,40,59,58},57))
local Boosts = Main:WaitForChild(_d({26,59,40,59,60,58,9,54,54,58,59,58},57)):WaitForChild(_d({9,54,54,58,59,58},57))
local v12 = Main:WaitForChild(_d({26,44,51,44,42,59,48,54,53,58},57))
local Frames = v12:WaitForChild(_d({13,57,40,52,44,58},57))
local RarityFilter = Main:WaitForChild(_d({25,40,57,48,59,64,13,48,51,59,44,57},57))
local Grips = Main:WaitForChild(_d({14,57,48,55,58},57))
local List_2 = Grips:WaitForChild(_d({19,48,58,59},57))
local LoadoutFrame = Main:WaitForChild(_d({19,54,40,43,54,60,59,13,57,40,52,44},57))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({12,53,40,41,51,44,43},57))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({29,48,58,48,41,51,44},57), Enabled)
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