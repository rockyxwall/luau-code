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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
game:GetService(_d({57,92,74,74,83,56,74,87,91,78,72,74},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
local HttpService = game:GetService(_d({45,89,89,85,56,74,87,91,78,72,74},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local Modules = ReplicatedStorage:WaitForChild(_d({50,84,73,90,81,74,88},27))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({57,84,84,81,41,74,88,72},27))
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
local Events = ReplicatedStorage:WaitForChild(_d({42,91,74,83,89,88},27))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({58,46,88},27))
local RarityGradient = require(UIs:WaitForChild(_d({55,70,87,78,89,94,44,87,70,73,78,74,83,89},27)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27))
local Tools = ReplicatedStorage:WaitForChild(_d({57,84,84,81,88},27))
local Gradients = script:WaitForChild(_d({44,87,70,73,78,74,83,89,88},27))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({58,83,72,84,82,82,84,83},27)),
Rare = Gradients:WaitForChild(_d({55,70,87,74},27)),
Epic = Gradients:WaitForChild(_d({42,85,78,72},27)),
Legendary = Gradients:WaitForChild(_d({49,74,76,74,83,73,70,87,94},27)),
Mythical = Gradients:WaitForChild(_d({50,94,89,77,78,72,70,81},27)),
Collectable = Gradients:WaitForChild(_d({40,84,81,81,74,72,89,70,71,81,74},27)),
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
HP = {Display = _d({42,93,89,87,70,5,45,74,70,81,89,77},27), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({45,74,70,81,89,77,5,55,74,76,74,83},27), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({56,89,70,82,78,83,70,5,55,74,76,74,83},27), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({42,93,89,87,70,5,56,89,70,82,78,83,70},27), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({56,92,84,87,73,5,41,50,44,5,50,90,81,89},27), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({56,57,55,5,41,50,44,5,50,90,81,89},27), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({41,50,44,5,50,90,81,89,78,85,81,78,74,87},27), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({55,74,73,90,72,74,73,5,41,50,44},27), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({55,74,73,90,72,74,73,5,39,90,87,83},27), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({55,74,73,90,72,74,73,5,43,87,74,74,95,74},27), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({44,87,74,91,78,84,90,88,5,60,84,90,83,73,88},27), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({83,90,82,71,74,87},27) then
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
if v:IsA(_d({57,74,93,89,49,70,71,74,81},27)) then
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
ReplicatedStorage:WaitForChild(_d({87,74,88,74,87,91,74,73,40,84,73,74},27))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({56,89,70,89,88},27))
local v6 = StatsFolder:WaitForChild(_d({46,83,91,74,83,89,84,87,94},27))
local Inventory = v6:WaitForChild(_d({46,83,91,74,83,89,84,87,94},27))
local Equiped = v6:WaitForChild(_d({42,86,90,78,85,74,73},27))
local VanitySlots = v6:WaitForChild(_d({59,70,83,78,89,94,56,81,84,89,88},27))
local FightingStyle = v5:WaitForChild(_d({43,78,76,77,89,78,83,76,56,89,94,81,74},27))
local KatanaOrder = v6:WaitForChild(_d({48,70,89,70,83,70,52,87,73,74,87},27))
local EquipedShip = v6:WaitForChild(_d({42,86,90,78,85,74,73,56,77,78,85},27))
local v7 = StatsFolder:WaitForChild(_d({57,78,89,81,74,88},27))
local AllTitles = v7:WaitForChild(_d({38,81,81,57,78,89,81,74,88},27))
local EquipedTitle = v7:WaitForChild(_d({42,86,90,78,85,74,73,57,78,89,81,74},27))
local AutoEquip = StatsFolder:WaitForChild(_d({56,74,89,89,78,83,76,88},27)):WaitForChild(_d({38,90,89,84,42,86,90,78,85},27))
local EquipedGrip = StatsFolder:WaitForChild(_d({44,87,78,85,88},27)):WaitForChild(_d({42,86,90,78,85,74,73,44,87,78,85},27))
local Inventory_2 = PlayerGui:WaitForChild(_d({46,83,91,74,83,89,84,87,94},27), 360)
local Main = Inventory_2:WaitForChild(_d({50,70,78,83},27))
local v8 = Main:WaitForChild(_d({46,83,91,74,83,89,84,87,94},27))
local List = v8:WaitForChild(_d({49,78,88,89},27))
local v9 = Main:WaitForChild(_d({57,84,85,57,70,71,88},27))
local UIGridLayout = List:WaitForChild(_d({58,46,44,87,78,73,49,70,94,84,90,89},27))
local UIPadding = List:WaitForChild(_d({58,46,53,70,73,73,78,83,76},27))
local v10 = v8:WaitForChild(_d({56,74,70,87,72,77},27))
local Input = v10:WaitForChild(_d({46,83,85,90,89},27))
local Clear = v10:WaitForChild(_d({40,81,74,70,87},27))
local ItemMenu = Main:WaitForChild(_d({46,89,74,82,50,74,83,90},27))
local Health = ItemMenu:WaitForChild(_d({45,74,70,81,89,77},27))
local Bar = Health:WaitForChild(_d({39,70,87},27))
local Equip = ItemMenu:WaitForChild(_d({42,86,90,78,85},27))
local Usage = Equip:WaitForChild(_d({58,88,70,76,74},27))
local Drop = ItemMenu:WaitForChild(_d({41,87,84,85},27))
local v11 = ItemMenu:WaitForChild(_d({50,78,88,72,39,90,89,89,84,83,88},27))
local Vanity = v11:WaitForChild(_d({59,70,83,78,89,94},27))
local CustomTailoredToggle = v11:WaitForChild(_d({40,90,88,89,84,82,57,70,78,81,84,87,74,73,57,84,76,76,81,74},27))
local SwordButtons = ItemMenu:WaitForChild(_d({56,92,84,87,73,39,90,89,89,84,83,88},27))
local Stats = ItemMenu:WaitForChild(_d({56,89,70,89,88},27))
local Boosts = Main:WaitForChild(_d({56,89,70,89,90,88,39,84,84,88,89,88},27)):WaitForChild(_d({39,84,84,88,89,88},27))
local v12 = Main:WaitForChild(_d({56,74,81,74,72,89,78,84,83,88},27))
local Frames = v12:WaitForChild(_d({43,87,70,82,74,88},27))
local RarityFilter = Main:WaitForChild(_d({55,70,87,78,89,94,43,78,81,89,74,87},27))
local Grips = Main:WaitForChild(_d({44,87,78,85,88},27))
local List_2 = Grips:WaitForChild(_d({49,78,88,89},27))
local LoadoutFrame = Main:WaitForChild(_d({49,84,70,73,84,90,89,43,87,70,82,74},27))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({42,83,70,71,81,74,73},27))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({59,78,88,78,71,81,74},27), Enabled)
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