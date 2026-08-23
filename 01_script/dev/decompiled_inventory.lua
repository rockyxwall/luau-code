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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
game:GetService(_d({49,84,66,66,75,48,66,79,83,70,64,66},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local HttpService = game:GetService(_d({37,81,81,77,48,66,79,83,70,64,66},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local Modules = ReplicatedStorage:WaitForChild(_d({42,76,65,82,73,66,80},35))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({49,76,76,73,33,66,80,64},35))
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
local Events = ReplicatedStorage:WaitForChild(_d({34,83,66,75,81,80},35))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({50,38,80},35))
local RarityGradient = require(UIs:WaitForChild(_d({47,62,79,70,81,86,36,79,62,65,70,66,75,81},35)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35))
local Tools = ReplicatedStorage:WaitForChild(_d({49,76,76,73,80},35))
local Gradients = script:WaitForChild(_d({36,79,62,65,70,66,75,81,80},35))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({50,75,64,76,74,74,76,75},35)),
Rare = Gradients:WaitForChild(_d({47,62,79,66},35)),
Epic = Gradients:WaitForChild(_d({34,77,70,64},35)),
Legendary = Gradients:WaitForChild(_d({41,66,68,66,75,65,62,79,86},35)),
Mythical = Gradients:WaitForChild(_d({42,86,81,69,70,64,62,73},35)),
Collectable = Gradients:WaitForChild(_d({32,76,73,73,66,64,81,62,63,73,66},35)),
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
HP = {Display = _d({34,85,81,79,62,253,37,66,62,73,81,69},35), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({37,66,62,73,81,69,253,47,66,68,66,75},35), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({48,81,62,74,70,75,62,253,47,66,68,66,75},35), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({34,85,81,79,62,253,48,81,62,74,70,75,62},35), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({48,84,76,79,65,253,33,42,36,253,42,82,73,81},35), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({48,49,47,253,33,42,36,253,42,82,73,81},35), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({33,42,36,253,42,82,73,81,70,77,73,70,66,79},35), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({47,66,65,82,64,66,65,253,33,42,36},35), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({47,66,65,82,64,66,65,253,31,82,79,75},35), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({47,66,65,82,64,66,65,253,35,79,66,66,87,66},35), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({36,79,66,83,70,76,82,80,253,52,76,82,75,65,80},35), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({75,82,74,63,66,79},35) then
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
if v:IsA(_d({49,66,85,81,41,62,63,66,73},35)) then
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
ReplicatedStorage:WaitForChild(_d({79,66,80,66,79,83,66,65,32,76,65,66},35))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({48,81,62,81,80},35))
local v6 = StatsFolder:WaitForChild(_d({38,75,83,66,75,81,76,79,86},35))
local Inventory = v6:WaitForChild(_d({38,75,83,66,75,81,76,79,86},35))
local Equiped = v6:WaitForChild(_d({34,78,82,70,77,66,65},35))
local VanitySlots = v6:WaitForChild(_d({51,62,75,70,81,86,48,73,76,81,80},35))
local FightingStyle = v5:WaitForChild(_d({35,70,68,69,81,70,75,68,48,81,86,73,66},35))
local KatanaOrder = v6:WaitForChild(_d({40,62,81,62,75,62,44,79,65,66,79},35))
local EquipedShip = v6:WaitForChild(_d({34,78,82,70,77,66,65,48,69,70,77},35))
local v7 = StatsFolder:WaitForChild(_d({49,70,81,73,66,80},35))
local AllTitles = v7:WaitForChild(_d({30,73,73,49,70,81,73,66,80},35))
local EquipedTitle = v7:WaitForChild(_d({34,78,82,70,77,66,65,49,70,81,73,66},35))
local AutoEquip = StatsFolder:WaitForChild(_d({48,66,81,81,70,75,68,80},35)):WaitForChild(_d({30,82,81,76,34,78,82,70,77},35))
local EquipedGrip = StatsFolder:WaitForChild(_d({36,79,70,77,80},35)):WaitForChild(_d({34,78,82,70,77,66,65,36,79,70,77},35))
local Inventory_2 = PlayerGui:WaitForChild(_d({38,75,83,66,75,81,76,79,86},35), 360)
local Main = Inventory_2:WaitForChild(_d({42,62,70,75},35))
local v8 = Main:WaitForChild(_d({38,75,83,66,75,81,76,79,86},35))
local List = v8:WaitForChild(_d({41,70,80,81},35))
local v9 = Main:WaitForChild(_d({49,76,77,49,62,63,80},35))
local UIGridLayout = List:WaitForChild(_d({50,38,36,79,70,65,41,62,86,76,82,81},35))
local UIPadding = List:WaitForChild(_d({50,38,45,62,65,65,70,75,68},35))
local v10 = v8:WaitForChild(_d({48,66,62,79,64,69},35))
local Input = v10:WaitForChild(_d({38,75,77,82,81},35))
local Clear = v10:WaitForChild(_d({32,73,66,62,79},35))
local ItemMenu = Main:WaitForChild(_d({38,81,66,74,42,66,75,82},35))
local Health = ItemMenu:WaitForChild(_d({37,66,62,73,81,69},35))
local Bar = Health:WaitForChild(_d({31,62,79},35))
local Equip = ItemMenu:WaitForChild(_d({34,78,82,70,77},35))
local Usage = Equip:WaitForChild(_d({50,80,62,68,66},35))
local Drop = ItemMenu:WaitForChild(_d({33,79,76,77},35))
local v11 = ItemMenu:WaitForChild(_d({42,70,80,64,31,82,81,81,76,75,80},35))
local Vanity = v11:WaitForChild(_d({51,62,75,70,81,86},35))
local CustomTailoredToggle = v11:WaitForChild(_d({32,82,80,81,76,74,49,62,70,73,76,79,66,65,49,76,68,68,73,66},35))
local SwordButtons = ItemMenu:WaitForChild(_d({48,84,76,79,65,31,82,81,81,76,75,80},35))
local Stats = ItemMenu:WaitForChild(_d({48,81,62,81,80},35))
local Boosts = Main:WaitForChild(_d({48,81,62,81,82,80,31,76,76,80,81,80},35)):WaitForChild(_d({31,76,76,80,81,80},35))
local v12 = Main:WaitForChild(_d({48,66,73,66,64,81,70,76,75,80},35))
local Frames = v12:WaitForChild(_d({35,79,62,74,66,80},35))
local RarityFilter = Main:WaitForChild(_d({47,62,79,70,81,86,35,70,73,81,66,79},35))
local Grips = Main:WaitForChild(_d({36,79,70,77,80},35))
local List_2 = Grips:WaitForChild(_d({41,70,80,81},35))
local LoadoutFrame = Main:WaitForChild(_d({41,76,62,65,76,82,81,35,79,62,74,66},35))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({34,75,62,63,73,66,65},35))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({51,70,80,70,63,73,66},35), Enabled)
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