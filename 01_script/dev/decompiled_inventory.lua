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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
game:GetService(_d({48,83,65,65,74,47,65,78,82,69,63,65},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local HttpService = game:GetService(_d({36,80,80,76,47,65,78,82,69,63,65},36))
local RunService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local Modules = ReplicatedStorage:WaitForChild(_d({41,75,64,81,72,65,79},36))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({48,75,75,72,32,65,79,63},36))
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
local Events = ReplicatedStorage:WaitForChild(_d({33,82,65,74,80,79},36))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({49,37,79},36))
local RarityGradient = require(UIs:WaitForChild(_d({46,61,78,69,80,85,35,78,61,64,69,65,74,80},36)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36))
local Tools = ReplicatedStorage:WaitForChild(_d({48,75,75,72,79},36))
local Gradients = script:WaitForChild(_d({35,78,61,64,69,65,74,80,79},36))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({49,74,63,75,73,73,75,74},36)),
Rare = Gradients:WaitForChild(_d({46,61,78,65},36)),
Epic = Gradients:WaitForChild(_d({33,76,69,63},36)),
Legendary = Gradients:WaitForChild(_d({40,65,67,65,74,64,61,78,85},36)),
Mythical = Gradients:WaitForChild(_d({41,85,80,68,69,63,61,72},36)),
Collectable = Gradients:WaitForChild(_d({31,75,72,72,65,63,80,61,62,72,65},36)),
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
HP = {Display = _d({33,84,80,78,61,252,36,65,61,72,80,68},36), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({36,65,61,72,80,68,252,46,65,67,65,74},36), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({47,80,61,73,69,74,61,252,46,65,67,65,74},36), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({33,84,80,78,61,252,47,80,61,73,69,74,61},36), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({47,83,75,78,64,252,32,41,35,252,41,81,72,80},36), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({47,48,46,252,32,41,35,252,41,81,72,80},36), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({32,41,35,252,41,81,72,80,69,76,72,69,65,78},36), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({46,65,64,81,63,65,64,252,32,41,35},36), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({46,65,64,81,63,65,64,252,30,81,78,74},36), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({46,65,64,81,63,65,64,252,34,78,65,65,86,65},36), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({35,78,65,82,69,75,81,79,252,51,75,81,74,64,79},36), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({74,81,73,62,65,78},36) then
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
if v:IsA(_d({48,65,84,80,40,61,62,65,72},36)) then
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
ReplicatedStorage:WaitForChild(_d({78,65,79,65,78,82,65,64,31,75,64,65},36))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({47,80,61,80,79},36))
local v6 = StatsFolder:WaitForChild(_d({37,74,82,65,74,80,75,78,85},36))
local Inventory = v6:WaitForChild(_d({37,74,82,65,74,80,75,78,85},36))
local Equiped = v6:WaitForChild(_d({33,77,81,69,76,65,64},36))
local VanitySlots = v6:WaitForChild(_d({50,61,74,69,80,85,47,72,75,80,79},36))
local FightingStyle = v5:WaitForChild(_d({34,69,67,68,80,69,74,67,47,80,85,72,65},36))
local KatanaOrder = v6:WaitForChild(_d({39,61,80,61,74,61,43,78,64,65,78},36))
local EquipedShip = v6:WaitForChild(_d({33,77,81,69,76,65,64,47,68,69,76},36))
local v7 = StatsFolder:WaitForChild(_d({48,69,80,72,65,79},36))
local AllTitles = v7:WaitForChild(_d({29,72,72,48,69,80,72,65,79},36))
local EquipedTitle = v7:WaitForChild(_d({33,77,81,69,76,65,64,48,69,80,72,65},36))
local AutoEquip = StatsFolder:WaitForChild(_d({47,65,80,80,69,74,67,79},36)):WaitForChild(_d({29,81,80,75,33,77,81,69,76},36))
local EquipedGrip = StatsFolder:WaitForChild(_d({35,78,69,76,79},36)):WaitForChild(_d({33,77,81,69,76,65,64,35,78,69,76},36))
local Inventory_2 = PlayerGui:WaitForChild(_d({37,74,82,65,74,80,75,78,85},36), 360)
local Main = Inventory_2:WaitForChild(_d({41,61,69,74},36))
local v8 = Main:WaitForChild(_d({37,74,82,65,74,80,75,78,85},36))
local List = v8:WaitForChild(_d({40,69,79,80},36))
local v9 = Main:WaitForChild(_d({48,75,76,48,61,62,79},36))
local UIGridLayout = List:WaitForChild(_d({49,37,35,78,69,64,40,61,85,75,81,80},36))
local UIPadding = List:WaitForChild(_d({49,37,44,61,64,64,69,74,67},36))
local v10 = v8:WaitForChild(_d({47,65,61,78,63,68},36))
local Input = v10:WaitForChild(_d({37,74,76,81,80},36))
local Clear = v10:WaitForChild(_d({31,72,65,61,78},36))
local ItemMenu = Main:WaitForChild(_d({37,80,65,73,41,65,74,81},36))
local Health = ItemMenu:WaitForChild(_d({36,65,61,72,80,68},36))
local Bar = Health:WaitForChild(_d({30,61,78},36))
local Equip = ItemMenu:WaitForChild(_d({33,77,81,69,76},36))
local Usage = Equip:WaitForChild(_d({49,79,61,67,65},36))
local Drop = ItemMenu:WaitForChild(_d({32,78,75,76},36))
local v11 = ItemMenu:WaitForChild(_d({41,69,79,63,30,81,80,80,75,74,79},36))
local Vanity = v11:WaitForChild(_d({50,61,74,69,80,85},36))
local CustomTailoredToggle = v11:WaitForChild(_d({31,81,79,80,75,73,48,61,69,72,75,78,65,64,48,75,67,67,72,65},36))
local SwordButtons = ItemMenu:WaitForChild(_d({47,83,75,78,64,30,81,80,80,75,74,79},36))
local Stats = ItemMenu:WaitForChild(_d({47,80,61,80,79},36))
local Boosts = Main:WaitForChild(_d({47,80,61,80,81,79,30,75,75,79,80,79},36)):WaitForChild(_d({30,75,75,79,80,79},36))
local v12 = Main:WaitForChild(_d({47,65,72,65,63,80,69,75,74,79},36))
local Frames = v12:WaitForChild(_d({34,78,61,73,65,79},36))
local RarityFilter = Main:WaitForChild(_d({46,61,78,69,80,85,34,69,72,80,65,78},36))
local Grips = Main:WaitForChild(_d({35,78,69,76,79},36))
local List_2 = Grips:WaitForChild(_d({40,69,79,80},36))
local LoadoutFrame = Main:WaitForChild(_d({40,75,61,64,75,81,80,34,78,61,73,65},36))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({33,74,61,62,72,65,64},36))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({50,69,79,69,62,72,65},36), Enabled)
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