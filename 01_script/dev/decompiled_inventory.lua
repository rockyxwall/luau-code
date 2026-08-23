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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
game:GetService(_d({64,99,81,81,90,63,81,94,98,85,79,81},20))
local UserInputService = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
local HttpService = game:GetService(_d({52,96,96,92,63,81,94,98,85,79,81},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local Modules = ReplicatedStorage:WaitForChild(_d({57,91,80,97,88,81,95},20))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({64,91,91,88,48,81,95,79},20))
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
local Events = ReplicatedStorage:WaitForChild(_d({49,98,81,90,96,95},20))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({65,53,95},20))
local RarityGradient = require(UIs:WaitForChild(_d({62,77,94,85,96,101,51,94,77,80,85,81,90,96},20)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20))
local Tools = ReplicatedStorage:WaitForChild(_d({64,91,91,88,95},20))
local Gradients = script:WaitForChild(_d({51,94,77,80,85,81,90,96,95},20))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({65,90,79,91,89,89,91,90},20)),
Rare = Gradients:WaitForChild(_d({62,77,94,81},20)),
Epic = Gradients:WaitForChild(_d({49,92,85,79},20)),
Legendary = Gradients:WaitForChild(_d({56,81,83,81,90,80,77,94,101},20)),
Mythical = Gradients:WaitForChild(_d({57,101,96,84,85,79,77,88},20)),
Collectable = Gradients:WaitForChild(_d({47,91,88,88,81,79,96,77,78,88,81},20)),
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
HP = {Display = _d({49,100,96,94,77,12,52,81,77,88,96,84},20), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({52,81,77,88,96,84,12,62,81,83,81,90},20), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({63,96,77,89,85,90,77,12,62,81,83,81,90},20), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({49,100,96,94,77,12,63,96,77,89,85,90,77},20), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({63,99,91,94,80,12,48,57,51,12,57,97,88,96},20), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({63,64,62,12,48,57,51,12,57,97,88,96},20), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({48,57,51,12,57,97,88,96,85,92,88,85,81,94},20), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({62,81,80,97,79,81,80,12,48,57,51},20), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({62,81,80,97,79,81,80,12,46,97,94,90},20), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({62,81,80,97,79,81,80,12,50,94,81,81,102,81},20), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({51,94,81,98,85,91,97,95,12,67,91,97,90,80,95},20), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({90,97,89,78,81,94},20) then
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
if v:IsA(_d({64,81,100,96,56,77,78,81,88},20)) then
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
ReplicatedStorage:WaitForChild(_d({94,81,95,81,94,98,81,80,47,91,80,81},20))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({63,96,77,96,95},20))
local v6 = StatsFolder:WaitForChild(_d({53,90,98,81,90,96,91,94,101},20))
local Inventory = v6:WaitForChild(_d({53,90,98,81,90,96,91,94,101},20))
local Equiped = v6:WaitForChild(_d({49,93,97,85,92,81,80},20))
local VanitySlots = v6:WaitForChild(_d({66,77,90,85,96,101,63,88,91,96,95},20))
local FightingStyle = v5:WaitForChild(_d({50,85,83,84,96,85,90,83,63,96,101,88,81},20))
local KatanaOrder = v6:WaitForChild(_d({55,77,96,77,90,77,59,94,80,81,94},20))
local EquipedShip = v6:WaitForChild(_d({49,93,97,85,92,81,80,63,84,85,92},20))
local v7 = StatsFolder:WaitForChild(_d({64,85,96,88,81,95},20))
local AllTitles = v7:WaitForChild(_d({45,88,88,64,85,96,88,81,95},20))
local EquipedTitle = v7:WaitForChild(_d({49,93,97,85,92,81,80,64,85,96,88,81},20))
local AutoEquip = StatsFolder:WaitForChild(_d({63,81,96,96,85,90,83,95},20)):WaitForChild(_d({45,97,96,91,49,93,97,85,92},20))
local EquipedGrip = StatsFolder:WaitForChild(_d({51,94,85,92,95},20)):WaitForChild(_d({49,93,97,85,92,81,80,51,94,85,92},20))
local Inventory_2 = PlayerGui:WaitForChild(_d({53,90,98,81,90,96,91,94,101},20), 360)
local Main = Inventory_2:WaitForChild(_d({57,77,85,90},20))
local v8 = Main:WaitForChild(_d({53,90,98,81,90,96,91,94,101},20))
local List = v8:WaitForChild(_d({56,85,95,96},20))
local v9 = Main:WaitForChild(_d({64,91,92,64,77,78,95},20))
local UIGridLayout = List:WaitForChild(_d({65,53,51,94,85,80,56,77,101,91,97,96},20))
local UIPadding = List:WaitForChild(_d({65,53,60,77,80,80,85,90,83},20))
local v10 = v8:WaitForChild(_d({63,81,77,94,79,84},20))
local Input = v10:WaitForChild(_d({53,90,92,97,96},20))
local Clear = v10:WaitForChild(_d({47,88,81,77,94},20))
local ItemMenu = Main:WaitForChild(_d({53,96,81,89,57,81,90,97},20))
local Health = ItemMenu:WaitForChild(_d({52,81,77,88,96,84},20))
local Bar = Health:WaitForChild(_d({46,77,94},20))
local Equip = ItemMenu:WaitForChild(_d({49,93,97,85,92},20))
local Usage = Equip:WaitForChild(_d({65,95,77,83,81},20))
local Drop = ItemMenu:WaitForChild(_d({48,94,91,92},20))
local v11 = ItemMenu:WaitForChild(_d({57,85,95,79,46,97,96,96,91,90,95},20))
local Vanity = v11:WaitForChild(_d({66,77,90,85,96,101},20))
local CustomTailoredToggle = v11:WaitForChild(_d({47,97,95,96,91,89,64,77,85,88,91,94,81,80,64,91,83,83,88,81},20))
local SwordButtons = ItemMenu:WaitForChild(_d({63,99,91,94,80,46,97,96,96,91,90,95},20))
local Stats = ItemMenu:WaitForChild(_d({63,96,77,96,95},20))
local Boosts = Main:WaitForChild(_d({63,96,77,96,97,95,46,91,91,95,96,95},20)):WaitForChild(_d({46,91,91,95,96,95},20))
local v12 = Main:WaitForChild(_d({63,81,88,81,79,96,85,91,90,95},20))
local Frames = v12:WaitForChild(_d({50,94,77,89,81,95},20))
local RarityFilter = Main:WaitForChild(_d({62,77,94,85,96,101,50,85,88,96,81,94},20))
local Grips = Main:WaitForChild(_d({51,94,85,92,95},20))
local List_2 = Grips:WaitForChild(_d({56,85,95,96},20))
local LoadoutFrame = Main:WaitForChild(_d({56,91,77,80,91,97,96,50,94,77,89,81},20))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({49,90,77,78,88,81,80},20))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({66,85,95,85,78,88,81},20), Enabled)
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