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
local Players = game:GetService(_d({51,79,68,92,72,85,86},29))
game:GetService(_d({53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72},29))
game:GetService(_d({55,90,72,72,81,54,72,85,89,76,70,72},29))
local UserInputService = game:GetService(_d({56,86,72,85,44,81,83,88,87,54,72,85,89,76,70,72},29))
local HttpService = game:GetService(_d({43,87,87,83,54,72,85,89,76,70,72},29))
local RunService = game:GetService(_d({53,88,81,54,72,85,89,76,70,72},29))
local ReplicatedStorage = game:GetService(_d({53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72},29))
local Modules = ReplicatedStorage:WaitForChild(_d({48,82,71,88,79,72,86},29))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({55,82,82,79,39,72,86,70},29))
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
local Events = ReplicatedStorage:WaitForChild(_d({40,89,72,81,87,86},29))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({56,44,86},29))
local RarityGradient = require(UIs:WaitForChild(_d({53,68,85,76,87,92,42,85,68,71,76,72,81,87},29)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({51,79,68,92,72,85,42,88,76},29))
local Tools = ReplicatedStorage:WaitForChild(_d({55,82,82,79,86},29))
local Gradients = script:WaitForChild(_d({42,85,68,71,76,72,81,87,86},29))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({56,81,70,82,80,80,82,81},29)),
Rare = Gradients:WaitForChild(_d({53,68,85,72},29)),
Epic = Gradients:WaitForChild(_d({40,83,76,70},29)),
Legendary = Gradients:WaitForChild(_d({47,72,74,72,81,71,68,85,92},29)),
Mythical = Gradients:WaitForChild(_d({48,92,87,75,76,70,68,79},29)),
Collectable = Gradients:WaitForChild(_d({38,82,79,79,72,70,87,68,69,79,72},29)),
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
HP = {Display = _d({40,91,87,85,68,3,43,72,68,79,87,75},29), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({43,72,68,79,87,75,3,53,72,74,72,81},29), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({54,87,68,80,76,81,68,3,53,72,74,72,81},29), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({40,91,87,85,68,3,54,87,68,80,76,81,68},29), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({54,90,82,85,71,3,39,48,42,3,48,88,79,87},29), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({54,55,53,3,39,48,42,3,48,88,79,87},29), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({39,48,42,3,48,88,79,87,76,83,79,76,72,85},29), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({53,72,71,88,70,72,71,3,39,48,42},29), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({53,72,71,88,70,72,71,3,37,88,85,81},29), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({53,72,71,88,70,72,71,3,41,85,72,72,93,72},29), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({42,85,72,89,76,82,88,86,3,58,82,88,81,71,86},29), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({81,88,80,69,72,85},29) then
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
if v:IsA(_d({55,72,91,87,47,68,69,72,79},29)) then
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
ReplicatedStorage:WaitForChild(_d({85,72,86,72,85,89,72,71,38,82,71,72},29))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({54,87,68,87,86},29))
local v6 = StatsFolder:WaitForChild(_d({44,81,89,72,81,87,82,85,92},29))
local Inventory = v6:WaitForChild(_d({44,81,89,72,81,87,82,85,92},29))
local Equiped = v6:WaitForChild(_d({40,84,88,76,83,72,71},29))
local VanitySlots = v6:WaitForChild(_d({57,68,81,76,87,92,54,79,82,87,86},29))
local FightingStyle = v5:WaitForChild(_d({41,76,74,75,87,76,81,74,54,87,92,79,72},29))
local KatanaOrder = v6:WaitForChild(_d({46,68,87,68,81,68,50,85,71,72,85},29))
local EquipedShip = v6:WaitForChild(_d({40,84,88,76,83,72,71,54,75,76,83},29))
local v7 = StatsFolder:WaitForChild(_d({55,76,87,79,72,86},29))
local AllTitles = v7:WaitForChild(_d({36,79,79,55,76,87,79,72,86},29))
local EquipedTitle = v7:WaitForChild(_d({40,84,88,76,83,72,71,55,76,87,79,72},29))
local AutoEquip = StatsFolder:WaitForChild(_d({54,72,87,87,76,81,74,86},29)):WaitForChild(_d({36,88,87,82,40,84,88,76,83},29))
local EquipedGrip = StatsFolder:WaitForChild(_d({42,85,76,83,86},29)):WaitForChild(_d({40,84,88,76,83,72,71,42,85,76,83},29))
local Inventory_2 = PlayerGui:WaitForChild(_d({44,81,89,72,81,87,82,85,92},29), 360)
local Main = Inventory_2:WaitForChild(_d({48,68,76,81},29))
local v8 = Main:WaitForChild(_d({44,81,89,72,81,87,82,85,92},29))
local List = v8:WaitForChild(_d({47,76,86,87},29))
local v9 = Main:WaitForChild(_d({55,82,83,55,68,69,86},29))
local UIGridLayout = List:WaitForChild(_d({56,44,42,85,76,71,47,68,92,82,88,87},29))
local UIPadding = List:WaitForChild(_d({56,44,51,68,71,71,76,81,74},29))
local v10 = v8:WaitForChild(_d({54,72,68,85,70,75},29))
local Input = v10:WaitForChild(_d({44,81,83,88,87},29))
local Clear = v10:WaitForChild(_d({38,79,72,68,85},29))
local ItemMenu = Main:WaitForChild(_d({44,87,72,80,48,72,81,88},29))
local Health = ItemMenu:WaitForChild(_d({43,72,68,79,87,75},29))
local Bar = Health:WaitForChild(_d({37,68,85},29))
local Equip = ItemMenu:WaitForChild(_d({40,84,88,76,83},29))
local Usage = Equip:WaitForChild(_d({56,86,68,74,72},29))
local Drop = ItemMenu:WaitForChild(_d({39,85,82,83},29))
local v11 = ItemMenu:WaitForChild(_d({48,76,86,70,37,88,87,87,82,81,86},29))
local Vanity = v11:WaitForChild(_d({57,68,81,76,87,92},29))
local CustomTailoredToggle = v11:WaitForChild(_d({38,88,86,87,82,80,55,68,76,79,82,85,72,71,55,82,74,74,79,72},29))
local SwordButtons = ItemMenu:WaitForChild(_d({54,90,82,85,71,37,88,87,87,82,81,86},29))
local Stats = ItemMenu:WaitForChild(_d({54,87,68,87,86},29))
local Boosts = Main:WaitForChild(_d({54,87,68,87,88,86,37,82,82,86,87,86},29)):WaitForChild(_d({37,82,82,86,87,86},29))
local v12 = Main:WaitForChild(_d({54,72,79,72,70,87,76,82,81,86},29))
local Frames = v12:WaitForChild(_d({41,85,68,80,72,86},29))
local RarityFilter = Main:WaitForChild(_d({53,68,85,76,87,92,41,76,79,87,72,85},29))
local Grips = Main:WaitForChild(_d({42,85,76,83,86},29))
local List_2 = Grips:WaitForChild(_d({47,76,86,87},29))
local LoadoutFrame = Main:WaitForChild(_d({47,82,68,71,82,88,87,41,85,68,80,72},29))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({40,81,68,69,79,72,71},29))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({57,76,86,76,69,79,72},29), Enabled)
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