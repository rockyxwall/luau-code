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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
game:GetService(_d({50,85,67,67,76,49,67,80,84,71,65,67},34))
local UserInputService = game:GetService(_d({51,81,67,80,39,76,78,83,82,49,67,80,84,71,65,67},34))
local HttpService = game:GetService(_d({38,82,82,78,49,67,80,84,71,65,67},34))
local RunService = game:GetService(_d({48,83,76,49,67,80,84,71,65,67},34))
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local Modules = ReplicatedStorage:WaitForChild(_d({43,77,66,83,74,67,81},34))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({50,77,77,74,34,67,81,65},34))
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
local Events = ReplicatedStorage:WaitForChild(_d({35,84,67,76,82,81},34))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({51,39,81},34))
local RarityGradient = require(UIs:WaitForChild(_d({48,63,80,71,82,87,37,80,63,66,71,67,76,82},34)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({46,74,63,87,67,80,37,83,71},34))
local Tools = ReplicatedStorage:WaitForChild(_d({50,77,77,74,81},34))
local Gradients = script:WaitForChild(_d({37,80,63,66,71,67,76,82,81},34))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({51,76,65,77,75,75,77,76},34)),
Rare = Gradients:WaitForChild(_d({48,63,80,67},34)),
Epic = Gradients:WaitForChild(_d({35,78,71,65},34)),
Legendary = Gradients:WaitForChild(_d({42,67,69,67,76,66,63,80,87},34)),
Mythical = Gradients:WaitForChild(_d({43,87,82,70,71,65,63,74},34)),
Collectable = Gradients:WaitForChild(_d({33,77,74,74,67,65,82,63,64,74,67},34)),
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
HP = {Display = _d({35,86,82,80,63,254,38,67,63,74,82,70},34), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({38,67,63,74,82,70,254,48,67,69,67,76},34), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({49,82,63,75,71,76,63,254,48,67,69,67,76},34), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({35,86,82,80,63,254,49,82,63,75,71,76,63},34), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({49,85,77,80,66,254,34,43,37,254,43,83,74,82},34), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({49,50,48,254,34,43,37,254,43,83,74,82},34), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({34,43,37,254,43,83,74,82,71,78,74,71,67,80},34), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({48,67,66,83,65,67,66,254,34,43,37},34), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({48,67,66,83,65,67,66,254,32,83,80,76},34), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({48,67,66,83,65,67,66,254,36,80,67,67,88,67},34), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({37,80,67,84,71,77,83,81,254,53,77,83,76,66,81},34), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({76,83,75,64,67,80},34) then
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
if v:IsA(_d({50,67,86,82,42,63,64,67,74},34)) then
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
ReplicatedStorage:WaitForChild(_d({80,67,81,67,80,84,67,66,33,77,66,67},34))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({49,82,63,82,81},34))
local v6 = StatsFolder:WaitForChild(_d({39,76,84,67,76,82,77,80,87},34))
local Inventory = v6:WaitForChild(_d({39,76,84,67,76,82,77,80,87},34))
local Equiped = v6:WaitForChild(_d({35,79,83,71,78,67,66},34))
local VanitySlots = v6:WaitForChild(_d({52,63,76,71,82,87,49,74,77,82,81},34))
local FightingStyle = v5:WaitForChild(_d({36,71,69,70,82,71,76,69,49,82,87,74,67},34))
local KatanaOrder = v6:WaitForChild(_d({41,63,82,63,76,63,45,80,66,67,80},34))
local EquipedShip = v6:WaitForChild(_d({35,79,83,71,78,67,66,49,70,71,78},34))
local v7 = StatsFolder:WaitForChild(_d({50,71,82,74,67,81},34))
local AllTitles = v7:WaitForChild(_d({31,74,74,50,71,82,74,67,81},34))
local EquipedTitle = v7:WaitForChild(_d({35,79,83,71,78,67,66,50,71,82,74,67},34))
local AutoEquip = StatsFolder:WaitForChild(_d({49,67,82,82,71,76,69,81},34)):WaitForChild(_d({31,83,82,77,35,79,83,71,78},34))
local EquipedGrip = StatsFolder:WaitForChild(_d({37,80,71,78,81},34)):WaitForChild(_d({35,79,83,71,78,67,66,37,80,71,78},34))
local Inventory_2 = PlayerGui:WaitForChild(_d({39,76,84,67,76,82,77,80,87},34), 360)
local Main = Inventory_2:WaitForChild(_d({43,63,71,76},34))
local v8 = Main:WaitForChild(_d({39,76,84,67,76,82,77,80,87},34))
local List = v8:WaitForChild(_d({42,71,81,82},34))
local v9 = Main:WaitForChild(_d({50,77,78,50,63,64,81},34))
local UIGridLayout = List:WaitForChild(_d({51,39,37,80,71,66,42,63,87,77,83,82},34))
local UIPadding = List:WaitForChild(_d({51,39,46,63,66,66,71,76,69},34))
local v10 = v8:WaitForChild(_d({49,67,63,80,65,70},34))
local Input = v10:WaitForChild(_d({39,76,78,83,82},34))
local Clear = v10:WaitForChild(_d({33,74,67,63,80},34))
local ItemMenu = Main:WaitForChild(_d({39,82,67,75,43,67,76,83},34))
local Health = ItemMenu:WaitForChild(_d({38,67,63,74,82,70},34))
local Bar = Health:WaitForChild(_d({32,63,80},34))
local Equip = ItemMenu:WaitForChild(_d({35,79,83,71,78},34))
local Usage = Equip:WaitForChild(_d({51,81,63,69,67},34))
local Drop = ItemMenu:WaitForChild(_d({34,80,77,78},34))
local v11 = ItemMenu:WaitForChild(_d({43,71,81,65,32,83,82,82,77,76,81},34))
local Vanity = v11:WaitForChild(_d({52,63,76,71,82,87},34))
local CustomTailoredToggle = v11:WaitForChild(_d({33,83,81,82,77,75,50,63,71,74,77,80,67,66,50,77,69,69,74,67},34))
local SwordButtons = ItemMenu:WaitForChild(_d({49,85,77,80,66,32,83,82,82,77,76,81},34))
local Stats = ItemMenu:WaitForChild(_d({49,82,63,82,81},34))
local Boosts = Main:WaitForChild(_d({49,82,63,82,83,81,32,77,77,81,82,81},34)):WaitForChild(_d({32,77,77,81,82,81},34))
local v12 = Main:WaitForChild(_d({49,67,74,67,65,82,71,77,76,81},34))
local Frames = v12:WaitForChild(_d({36,80,63,75,67,81},34))
local RarityFilter = Main:WaitForChild(_d({48,63,80,71,82,87,36,71,74,82,67,80},34))
local Grips = Main:WaitForChild(_d({37,80,71,78,81},34))
local List_2 = Grips:WaitForChild(_d({42,71,81,82},34))
local LoadoutFrame = Main:WaitForChild(_d({42,77,63,66,77,83,82,36,80,63,75,67},34))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({35,76,63,64,74,67,66},34))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({52,71,81,71,64,74,67},34), Enabled)
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