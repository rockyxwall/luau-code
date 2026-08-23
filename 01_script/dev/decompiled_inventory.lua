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
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
game:GetService(_d({61,96,78,78,87,60,78,91,95,82,76,78},23))
local UserInputService = game:GetService(_d({62,92,78,91,50,87,89,94,93,60,78,91,95,82,76,78},23))
local HttpService = game:GetService(_d({49,93,93,89,60,78,91,95,82,76,78},23))
local RunService = game:GetService(_d({59,94,87,60,78,91,95,82,76,78},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local Modules = ReplicatedStorage:WaitForChild(_d({54,88,77,94,85,78,92},23))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({61,88,88,85,45,78,92,76},23))
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
local Events = ReplicatedStorage:WaitForChild(_d({46,95,78,87,93,92},23))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({62,50,92},23))
local RarityGradient = require(UIs:WaitForChild(_d({59,74,91,82,93,98,48,91,74,77,82,78,87,93},23)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({57,85,74,98,78,91,48,94,82},23))
local Tools = ReplicatedStorage:WaitForChild(_d({61,88,88,85,92},23))
local Gradients = script:WaitForChild(_d({48,91,74,77,82,78,87,93,92},23))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({62,87,76,88,86,86,88,87},23)),
Rare = Gradients:WaitForChild(_d({59,74,91,78},23)),
Epic = Gradients:WaitForChild(_d({46,89,82,76},23)),
Legendary = Gradients:WaitForChild(_d({53,78,80,78,87,77,74,91,98},23)),
Mythical = Gradients:WaitForChild(_d({54,98,93,81,82,76,74,85},23)),
Collectable = Gradients:WaitForChild(_d({44,88,85,85,78,76,93,74,75,85,78},23)),
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
HP = {Display = _d({46,97,93,91,74,9,49,78,74,85,93,81},23), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({49,78,74,85,93,81,9,59,78,80,78,87},23), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({60,93,74,86,82,87,74,9,59,78,80,78,87},23), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({46,97,93,91,74,9,60,93,74,86,82,87,74},23), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({60,96,88,91,77,9,45,54,48,9,54,94,85,93},23), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({60,61,59,9,45,54,48,9,54,94,85,93},23), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({45,54,48,9,54,94,85,93,82,89,85,82,78,91},23), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({59,78,77,94,76,78,77,9,45,54,48},23), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({59,78,77,94,76,78,77,9,43,94,91,87},23), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({59,78,77,94,76,78,77,9,47,91,78,78,99,78},23), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({48,91,78,95,82,88,94,92,9,64,88,94,87,77,92},23), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({87,94,86,75,78,91},23) then
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
if v:IsA(_d({61,78,97,93,53,74,75,78,85},23)) then
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
ReplicatedStorage:WaitForChild(_d({91,78,92,78,91,95,78,77,44,88,77,78},23))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({60,93,74,93,92},23))
local v6 = StatsFolder:WaitForChild(_d({50,87,95,78,87,93,88,91,98},23))
local Inventory = v6:WaitForChild(_d({50,87,95,78,87,93,88,91,98},23))
local Equiped = v6:WaitForChild(_d({46,90,94,82,89,78,77},23))
local VanitySlots = v6:WaitForChild(_d({63,74,87,82,93,98,60,85,88,93,92},23))
local FightingStyle = v5:WaitForChild(_d({47,82,80,81,93,82,87,80,60,93,98,85,78},23))
local KatanaOrder = v6:WaitForChild(_d({52,74,93,74,87,74,56,91,77,78,91},23))
local EquipedShip = v6:WaitForChild(_d({46,90,94,82,89,78,77,60,81,82,89},23))
local v7 = StatsFolder:WaitForChild(_d({61,82,93,85,78,92},23))
local AllTitles = v7:WaitForChild(_d({42,85,85,61,82,93,85,78,92},23))
local EquipedTitle = v7:WaitForChild(_d({46,90,94,82,89,78,77,61,82,93,85,78},23))
local AutoEquip = StatsFolder:WaitForChild(_d({60,78,93,93,82,87,80,92},23)):WaitForChild(_d({42,94,93,88,46,90,94,82,89},23))
local EquipedGrip = StatsFolder:WaitForChild(_d({48,91,82,89,92},23)):WaitForChild(_d({46,90,94,82,89,78,77,48,91,82,89},23))
local Inventory_2 = PlayerGui:WaitForChild(_d({50,87,95,78,87,93,88,91,98},23), 360)
local Main = Inventory_2:WaitForChild(_d({54,74,82,87},23))
local v8 = Main:WaitForChild(_d({50,87,95,78,87,93,88,91,98},23))
local List = v8:WaitForChild(_d({53,82,92,93},23))
local v9 = Main:WaitForChild(_d({61,88,89,61,74,75,92},23))
local UIGridLayout = List:WaitForChild(_d({62,50,48,91,82,77,53,74,98,88,94,93},23))
local UIPadding = List:WaitForChild(_d({62,50,57,74,77,77,82,87,80},23))
local v10 = v8:WaitForChild(_d({60,78,74,91,76,81},23))
local Input = v10:WaitForChild(_d({50,87,89,94,93},23))
local Clear = v10:WaitForChild(_d({44,85,78,74,91},23))
local ItemMenu = Main:WaitForChild(_d({50,93,78,86,54,78,87,94},23))
local Health = ItemMenu:WaitForChild(_d({49,78,74,85,93,81},23))
local Bar = Health:WaitForChild(_d({43,74,91},23))
local Equip = ItemMenu:WaitForChild(_d({46,90,94,82,89},23))
local Usage = Equip:WaitForChild(_d({62,92,74,80,78},23))
local Drop = ItemMenu:WaitForChild(_d({45,91,88,89},23))
local v11 = ItemMenu:WaitForChild(_d({54,82,92,76,43,94,93,93,88,87,92},23))
local Vanity = v11:WaitForChild(_d({63,74,87,82,93,98},23))
local CustomTailoredToggle = v11:WaitForChild(_d({44,94,92,93,88,86,61,74,82,85,88,91,78,77,61,88,80,80,85,78},23))
local SwordButtons = ItemMenu:WaitForChild(_d({60,96,88,91,77,43,94,93,93,88,87,92},23))
local Stats = ItemMenu:WaitForChild(_d({60,93,74,93,92},23))
local Boosts = Main:WaitForChild(_d({60,93,74,93,94,92,43,88,88,92,93,92},23)):WaitForChild(_d({43,88,88,92,93,92},23))
local v12 = Main:WaitForChild(_d({60,78,85,78,76,93,82,88,87,92},23))
local Frames = v12:WaitForChild(_d({47,91,74,86,78,92},23))
local RarityFilter = Main:WaitForChild(_d({59,74,91,82,93,98,47,82,85,93,78,91},23))
local Grips = Main:WaitForChild(_d({48,91,82,89,92},23))
local List_2 = Grips:WaitForChild(_d({53,82,92,93},23))
local LoadoutFrame = Main:WaitForChild(_d({53,88,74,77,88,94,93,47,91,74,86,78},23))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({46,87,74,75,85,78,77},23))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({63,82,92,82,75,85,78},23), Enabled)
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