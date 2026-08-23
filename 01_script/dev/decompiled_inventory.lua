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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
game:GetService(_d({58,93,75,75,84,57,75,88,92,79,73,75},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
local HttpService = game:GetService(_d({46,90,90,86,57,75,88,92,79,73,75},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local Modules = ReplicatedStorage:WaitForChild(_d({51,85,74,91,82,75,89},26))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({58,85,85,82,42,75,89,73},26))
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
local Events = ReplicatedStorage:WaitForChild(_d({43,92,75,84,90,89},26))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({59,47,89},26))
local RarityGradient = require(UIs:WaitForChild(_d({56,71,88,79,90,95,45,88,71,74,79,75,84,90},26)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26))
local Tools = ReplicatedStorage:WaitForChild(_d({58,85,85,82,89},26))
local Gradients = script:WaitForChild(_d({45,88,71,74,79,75,84,90,89},26))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({59,84,73,85,83,83,85,84},26)),
Rare = Gradients:WaitForChild(_d({56,71,88,75},26)),
Epic = Gradients:WaitForChild(_d({43,86,79,73},26)),
Legendary = Gradients:WaitForChild(_d({50,75,77,75,84,74,71,88,95},26)),
Mythical = Gradients:WaitForChild(_d({51,95,90,78,79,73,71,82},26)),
Collectable = Gradients:WaitForChild(_d({41,85,82,82,75,73,90,71,72,82,75},26)),
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
HP = {Display = _d({43,94,90,88,71,6,46,75,71,82,90,78},26), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({46,75,71,82,90,78,6,56,75,77,75,84},26), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({57,90,71,83,79,84,71,6,56,75,77,75,84},26), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({43,94,90,88,71,6,57,90,71,83,79,84,71},26), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({57,93,85,88,74,6,42,51,45,6,51,91,82,90},26), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({57,58,56,6,42,51,45,6,51,91,82,90},26), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({42,51,45,6,51,91,82,90,79,86,82,79,75,88},26), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({56,75,74,91,73,75,74,6,42,51,45},26), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({56,75,74,91,73,75,74,6,40,91,88,84},26), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({56,75,74,91,73,75,74,6,44,88,75,75,96,75},26), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({45,88,75,92,79,85,91,89,6,61,85,91,84,74,89},26), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({84,91,83,72,75,88},26) then
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
if v:IsA(_d({58,75,94,90,50,71,72,75,82},26)) then
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
ReplicatedStorage:WaitForChild(_d({88,75,89,75,88,92,75,74,41,85,74,75},26))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({57,90,71,90,89},26))
local v6 = StatsFolder:WaitForChild(_d({47,84,92,75,84,90,85,88,95},26))
local Inventory = v6:WaitForChild(_d({47,84,92,75,84,90,85,88,95},26))
local Equiped = v6:WaitForChild(_d({43,87,91,79,86,75,74},26))
local VanitySlots = v6:WaitForChild(_d({60,71,84,79,90,95,57,82,85,90,89},26))
local FightingStyle = v5:WaitForChild(_d({44,79,77,78,90,79,84,77,57,90,95,82,75},26))
local KatanaOrder = v6:WaitForChild(_d({49,71,90,71,84,71,53,88,74,75,88},26))
local EquipedShip = v6:WaitForChild(_d({43,87,91,79,86,75,74,57,78,79,86},26))
local v7 = StatsFolder:WaitForChild(_d({58,79,90,82,75,89},26))
local AllTitles = v7:WaitForChild(_d({39,82,82,58,79,90,82,75,89},26))
local EquipedTitle = v7:WaitForChild(_d({43,87,91,79,86,75,74,58,79,90,82,75},26))
local AutoEquip = StatsFolder:WaitForChild(_d({57,75,90,90,79,84,77,89},26)):WaitForChild(_d({39,91,90,85,43,87,91,79,86},26))
local EquipedGrip = StatsFolder:WaitForChild(_d({45,88,79,86,89},26)):WaitForChild(_d({43,87,91,79,86,75,74,45,88,79,86},26))
local Inventory_2 = PlayerGui:WaitForChild(_d({47,84,92,75,84,90,85,88,95},26), 360)
local Main = Inventory_2:WaitForChild(_d({51,71,79,84},26))
local v8 = Main:WaitForChild(_d({47,84,92,75,84,90,85,88,95},26))
local List = v8:WaitForChild(_d({50,79,89,90},26))
local v9 = Main:WaitForChild(_d({58,85,86,58,71,72,89},26))
local UIGridLayout = List:WaitForChild(_d({59,47,45,88,79,74,50,71,95,85,91,90},26))
local UIPadding = List:WaitForChild(_d({59,47,54,71,74,74,79,84,77},26))
local v10 = v8:WaitForChild(_d({57,75,71,88,73,78},26))
local Input = v10:WaitForChild(_d({47,84,86,91,90},26))
local Clear = v10:WaitForChild(_d({41,82,75,71,88},26))
local ItemMenu = Main:WaitForChild(_d({47,90,75,83,51,75,84,91},26))
local Health = ItemMenu:WaitForChild(_d({46,75,71,82,90,78},26))
local Bar = Health:WaitForChild(_d({40,71,88},26))
local Equip = ItemMenu:WaitForChild(_d({43,87,91,79,86},26))
local Usage = Equip:WaitForChild(_d({59,89,71,77,75},26))
local Drop = ItemMenu:WaitForChild(_d({42,88,85,86},26))
local v11 = ItemMenu:WaitForChild(_d({51,79,89,73,40,91,90,90,85,84,89},26))
local Vanity = v11:WaitForChild(_d({60,71,84,79,90,95},26))
local CustomTailoredToggle = v11:WaitForChild(_d({41,91,89,90,85,83,58,71,79,82,85,88,75,74,58,85,77,77,82,75},26))
local SwordButtons = ItemMenu:WaitForChild(_d({57,93,85,88,74,40,91,90,90,85,84,89},26))
local Stats = ItemMenu:WaitForChild(_d({57,90,71,90,89},26))
local Boosts = Main:WaitForChild(_d({57,90,71,90,91,89,40,85,85,89,90,89},26)):WaitForChild(_d({40,85,85,89,90,89},26))
local v12 = Main:WaitForChild(_d({57,75,82,75,73,90,79,85,84,89},26))
local Frames = v12:WaitForChild(_d({44,88,71,83,75,89},26))
local RarityFilter = Main:WaitForChild(_d({56,71,88,79,90,95,44,79,82,90,75,88},26))
local Grips = Main:WaitForChild(_d({45,88,79,86,89},26))
local List_2 = Grips:WaitForChild(_d({50,79,89,90},26))
local LoadoutFrame = Main:WaitForChild(_d({50,85,71,74,85,91,90,44,88,71,83,75},26))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({43,84,71,72,82,75,74},26))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({60,79,89,79,72,82,75},26), Enabled)
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