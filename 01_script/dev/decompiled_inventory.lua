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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
game:GetService(_d({54,89,71,71,80,53,71,84,88,75,69,71},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local HttpService = game:GetService(_d({42,86,86,82,53,71,84,88,75,69,71},30))
local RunService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local Modules = ReplicatedStorage:WaitForChild(_d({47,81,70,87,78,71,85},30))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({54,81,81,78,38,71,85,69},30))
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
local Events = ReplicatedStorage:WaitForChild(_d({39,88,71,80,86,85},30))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({55,43,85},30))
local RarityGradient = require(UIs:WaitForChild(_d({52,67,84,75,86,91,41,84,67,70,75,71,80,86},30)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({50,78,67,91,71,84,41,87,75},30))
local Tools = ReplicatedStorage:WaitForChild(_d({54,81,81,78,85},30))
local Gradients = script:WaitForChild(_d({41,84,67,70,75,71,80,86,85},30))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({55,80,69,81,79,79,81,80},30)),
Rare = Gradients:WaitForChild(_d({52,67,84,71},30)),
Epic = Gradients:WaitForChild(_d({39,82,75,69},30)),
Legendary = Gradients:WaitForChild(_d({46,71,73,71,80,70,67,84,91},30)),
Mythical = Gradients:WaitForChild(_d({47,91,86,74,75,69,67,78},30)),
Collectable = Gradients:WaitForChild(_d({37,81,78,78,71,69,86,67,68,78,71},30)),
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
HP = {Display = _d({39,90,86,84,67,2,42,71,67,78,86,74},30), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({42,71,67,78,86,74,2,52,71,73,71,80},30), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({53,86,67,79,75,80,67,2,52,71,73,71,80},30), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({39,90,86,84,67,2,53,86,67,79,75,80,67},30), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({53,89,81,84,70,2,38,47,41,2,47,87,78,86},30), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({53,54,52,2,38,47,41,2,47,87,78,86},30), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({38,47,41,2,47,87,78,86,75,82,78,75,71,84},30), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({52,71,70,87,69,71,70,2,38,47,41},30), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({52,71,70,87,69,71,70,2,36,87,84,80},30), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({52,71,70,87,69,71,70,2,40,84,71,71,92,71},30), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({41,84,71,88,75,81,87,85,2,57,81,87,80,70,85},30), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({80,87,79,68,71,84},30) then
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
if v:IsA(_d({54,71,90,86,46,67,68,71,78},30)) then
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
ReplicatedStorage:WaitForChild(_d({84,71,85,71,84,88,71,70,37,81,70,71},30))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({53,86,67,86,85},30))
local v6 = StatsFolder:WaitForChild(_d({43,80,88,71,80,86,81,84,91},30))
local Inventory = v6:WaitForChild(_d({43,80,88,71,80,86,81,84,91},30))
local Equiped = v6:WaitForChild(_d({39,83,87,75,82,71,70},30))
local VanitySlots = v6:WaitForChild(_d({56,67,80,75,86,91,53,78,81,86,85},30))
local FightingStyle = v5:WaitForChild(_d({40,75,73,74,86,75,80,73,53,86,91,78,71},30))
local KatanaOrder = v6:WaitForChild(_d({45,67,86,67,80,67,49,84,70,71,84},30))
local EquipedShip = v6:WaitForChild(_d({39,83,87,75,82,71,70,53,74,75,82},30))
local v7 = StatsFolder:WaitForChild(_d({54,75,86,78,71,85},30))
local AllTitles = v7:WaitForChild(_d({35,78,78,54,75,86,78,71,85},30))
local EquipedTitle = v7:WaitForChild(_d({39,83,87,75,82,71,70,54,75,86,78,71},30))
local AutoEquip = StatsFolder:WaitForChild(_d({53,71,86,86,75,80,73,85},30)):WaitForChild(_d({35,87,86,81,39,83,87,75,82},30))
local EquipedGrip = StatsFolder:WaitForChild(_d({41,84,75,82,85},30)):WaitForChild(_d({39,83,87,75,82,71,70,41,84,75,82},30))
local Inventory_2 = PlayerGui:WaitForChild(_d({43,80,88,71,80,86,81,84,91},30), 360)
local Main = Inventory_2:WaitForChild(_d({47,67,75,80},30))
local v8 = Main:WaitForChild(_d({43,80,88,71,80,86,81,84,91},30))
local List = v8:WaitForChild(_d({46,75,85,86},30))
local v9 = Main:WaitForChild(_d({54,81,82,54,67,68,85},30))
local UIGridLayout = List:WaitForChild(_d({55,43,41,84,75,70,46,67,91,81,87,86},30))
local UIPadding = List:WaitForChild(_d({55,43,50,67,70,70,75,80,73},30))
local v10 = v8:WaitForChild(_d({53,71,67,84,69,74},30))
local Input = v10:WaitForChild(_d({43,80,82,87,86},30))
local Clear = v10:WaitForChild(_d({37,78,71,67,84},30))
local ItemMenu = Main:WaitForChild(_d({43,86,71,79,47,71,80,87},30))
local Health = ItemMenu:WaitForChild(_d({42,71,67,78,86,74},30))
local Bar = Health:WaitForChild(_d({36,67,84},30))
local Equip = ItemMenu:WaitForChild(_d({39,83,87,75,82},30))
local Usage = Equip:WaitForChild(_d({55,85,67,73,71},30))
local Drop = ItemMenu:WaitForChild(_d({38,84,81,82},30))
local v11 = ItemMenu:WaitForChild(_d({47,75,85,69,36,87,86,86,81,80,85},30))
local Vanity = v11:WaitForChild(_d({56,67,80,75,86,91},30))
local CustomTailoredToggle = v11:WaitForChild(_d({37,87,85,86,81,79,54,67,75,78,81,84,71,70,54,81,73,73,78,71},30))
local SwordButtons = ItemMenu:WaitForChild(_d({53,89,81,84,70,36,87,86,86,81,80,85},30))
local Stats = ItemMenu:WaitForChild(_d({53,86,67,86,85},30))
local Boosts = Main:WaitForChild(_d({53,86,67,86,87,85,36,81,81,85,86,85},30)):WaitForChild(_d({36,81,81,85,86,85},30))
local v12 = Main:WaitForChild(_d({53,71,78,71,69,86,75,81,80,85},30))
local Frames = v12:WaitForChild(_d({40,84,67,79,71,85},30))
local RarityFilter = Main:WaitForChild(_d({52,67,84,75,86,91,40,75,78,86,71,84},30))
local Grips = Main:WaitForChild(_d({41,84,75,82,85},30))
local List_2 = Grips:WaitForChild(_d({46,75,85,86},30))
local LoadoutFrame = Main:WaitForChild(_d({46,81,67,70,81,87,86,40,84,67,79,71},30))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({39,80,67,68,78,71,70},30))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({56,75,85,75,68,78,71},30), Enabled)
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