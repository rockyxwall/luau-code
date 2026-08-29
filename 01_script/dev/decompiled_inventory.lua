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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
game:GetService(_d({56,91,73,73,82,55,73,86,90,77,71,73},28))
local UserInputService = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
local HttpService = game:GetService(_d({44,88,88,84,55,73,86,90,77,71,73},28))
local RunService = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local Modules = ReplicatedStorage:WaitForChild(_d({49,83,72,89,80,73,87},28))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({56,83,83,80,40,73,87,71},28))
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
local Events = ReplicatedStorage:WaitForChild(_d({41,90,73,82,88,87},28))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({57,45,87},28))
local RarityGradient = require(UIs:WaitForChild(_d({54,69,86,77,88,93,43,86,69,72,77,73,82,88},28)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({52,80,69,93,73,86,43,89,77},28))
local Tools = ReplicatedStorage:WaitForChild(_d({56,83,83,80,87},28))
local Gradients = script:WaitForChild(_d({43,86,69,72,77,73,82,88,87},28))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({57,82,71,83,81,81,83,82},28)),
Rare = Gradients:WaitForChild(_d({54,69,86,73},28)),
Epic = Gradients:WaitForChild(_d({41,84,77,71},28)),
Legendary = Gradients:WaitForChild(_d({48,73,75,73,82,72,69,86,93},28)),
Mythical = Gradients:WaitForChild(_d({49,93,88,76,77,71,69,80},28)),
Collectable = Gradients:WaitForChild(_d({39,83,80,80,73,71,88,69,70,80,73},28)),
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
HP = {Display = _d({41,92,88,86,69,4,44,73,69,80,88,76},28), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({44,73,69,80,88,76,4,54,73,75,73,82},28), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({55,88,69,81,77,82,69,4,54,73,75,73,82},28), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({41,92,88,86,69,4,55,88,69,81,77,82,69},28), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({55,91,83,86,72,4,40,49,43,4,49,89,80,88},28), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({55,56,54,4,40,49,43,4,49,89,80,88},28), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({40,49,43,4,49,89,80,88,77,84,80,77,73,86},28), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({54,73,72,89,71,73,72,4,40,49,43},28), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({54,73,72,89,71,73,72,4,38,89,86,82},28), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({54,73,72,89,71,73,72,4,42,86,73,73,94,73},28), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({43,86,73,90,77,83,89,87,4,59,83,89,82,72,87},28), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({82,89,81,70,73,86},28) then
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
if v:IsA(_d({56,73,92,88,48,69,70,73,80},28)) then
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
ReplicatedStorage:WaitForChild(_d({86,73,87,73,86,90,73,72,39,83,72,73},28))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({55,88,69,88,87},28))
local v6 = StatsFolder:WaitForChild(_d({45,82,90,73,82,88,83,86,93},28))
local Inventory = v6:WaitForChild(_d({45,82,90,73,82,88,83,86,93},28))
local Equiped = v6:WaitForChild(_d({41,85,89,77,84,73,72},28))
local VanitySlots = v6:WaitForChild(_d({58,69,82,77,88,93,55,80,83,88,87},28))
local FightingStyle = v5:WaitForChild(_d({42,77,75,76,88,77,82,75,55,88,93,80,73},28))
local KatanaOrder = v6:WaitForChild(_d({47,69,88,69,82,69,51,86,72,73,86},28))
local EquipedShip = v6:WaitForChild(_d({41,85,89,77,84,73,72,55,76,77,84},28))
local v7 = StatsFolder:WaitForChild(_d({56,77,88,80,73,87},28))
local AllTitles = v7:WaitForChild(_d({37,80,80,56,77,88,80,73,87},28))
local EquipedTitle = v7:WaitForChild(_d({41,85,89,77,84,73,72,56,77,88,80,73},28))
local AutoEquip = StatsFolder:WaitForChild(_d({55,73,88,88,77,82,75,87},28)):WaitForChild(_d({37,89,88,83,41,85,89,77,84},28))
local EquipedGrip = StatsFolder:WaitForChild(_d({43,86,77,84,87},28)):WaitForChild(_d({41,85,89,77,84,73,72,43,86,77,84},28))
local Inventory_2 = PlayerGui:WaitForChild(_d({45,82,90,73,82,88,83,86,93},28), 360)
local Main = Inventory_2:WaitForChild(_d({49,69,77,82},28))
local v8 = Main:WaitForChild(_d({45,82,90,73,82,88,83,86,93},28))
local List = v8:WaitForChild(_d({48,77,87,88},28))
local v9 = Main:WaitForChild(_d({56,83,84,56,69,70,87},28))
local UIGridLayout = List:WaitForChild(_d({57,45,43,86,77,72,48,69,93,83,89,88},28))
local UIPadding = List:WaitForChild(_d({57,45,52,69,72,72,77,82,75},28))
local v10 = v8:WaitForChild(_d({55,73,69,86,71,76},28))
local Input = v10:WaitForChild(_d({45,82,84,89,88},28))
local Clear = v10:WaitForChild(_d({39,80,73,69,86},28))
local ItemMenu = Main:WaitForChild(_d({45,88,73,81,49,73,82,89},28))
local Health = ItemMenu:WaitForChild(_d({44,73,69,80,88,76},28))
local Bar = Health:WaitForChild(_d({38,69,86},28))
local Equip = ItemMenu:WaitForChild(_d({41,85,89,77,84},28))
local Usage = Equip:WaitForChild(_d({57,87,69,75,73},28))
local Drop = ItemMenu:WaitForChild(_d({40,86,83,84},28))
local v11 = ItemMenu:WaitForChild(_d({49,77,87,71,38,89,88,88,83,82,87},28))
local Vanity = v11:WaitForChild(_d({58,69,82,77,88,93},28))
local CustomTailoredToggle = v11:WaitForChild(_d({39,89,87,88,83,81,56,69,77,80,83,86,73,72,56,83,75,75,80,73},28))
local SwordButtons = ItemMenu:WaitForChild(_d({55,91,83,86,72,38,89,88,88,83,82,87},28))
local Stats = ItemMenu:WaitForChild(_d({55,88,69,88,87},28))
local Boosts = Main:WaitForChild(_d({55,88,69,88,89,87,38,83,83,87,88,87},28)):WaitForChild(_d({38,83,83,87,88,87},28))
local v12 = Main:WaitForChild(_d({55,73,80,73,71,88,77,83,82,87},28))
local Frames = v12:WaitForChild(_d({42,86,69,81,73,87},28))
local RarityFilter = Main:WaitForChild(_d({54,69,86,77,88,93,42,77,80,88,73,86},28))
local Grips = Main:WaitForChild(_d({43,86,77,84,87},28))
local List_2 = Grips:WaitForChild(_d({48,77,87,88},28))
local LoadoutFrame = Main:WaitForChild(_d({48,83,69,72,83,89,88,42,86,69,81,73},28))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({41,82,69,70,80,73,72},28))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({58,77,87,77,70,80,73},28), Enabled)
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