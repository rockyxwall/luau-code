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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
game:GetService(_d({52,87,69,69,78,51,69,82,86,73,67,69},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local HttpService = game:GetService(_d({40,84,84,80,51,69,82,86,73,67,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local Modules = ReplicatedStorage:WaitForChild(_d({45,79,68,85,76,69,83},32))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({52,79,79,76,36,69,83,67},32))
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
local Events = ReplicatedStorage:WaitForChild(_d({37,86,69,78,84,83},32))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({53,41,83},32))
local RarityGradient = require(UIs:WaitForChild(_d({50,65,82,73,84,89,39,82,65,68,73,69,78,84},32)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32))
local Tools = ReplicatedStorage:WaitForChild(_d({52,79,79,76,83},32))
local Gradients = script:WaitForChild(_d({39,82,65,68,73,69,78,84,83},32))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({53,78,67,79,77,77,79,78},32)),
Rare = Gradients:WaitForChild(_d({50,65,82,69},32)),
Epic = Gradients:WaitForChild(_d({37,80,73,67},32)),
Legendary = Gradients:WaitForChild(_d({44,69,71,69,78,68,65,82,89},32)),
Mythical = Gradients:WaitForChild(_d({45,89,84,72,73,67,65,76},32)),
Collectable = Gradients:WaitForChild(_d({35,79,76,76,69,67,84,65,66,76,69},32)),
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
HP = {Display = _d({37,88,84,82,65,0,40,69,65,76,84,72},32), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({40,69,65,76,84,72,0,50,69,71,69,78},32), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({51,84,65,77,73,78,65,0,50,69,71,69,78},32), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({37,88,84,82,65,0,51,84,65,77,73,78,65},32), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({51,87,79,82,68,0,36,45,39,0,45,85,76,84},32), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({51,52,50,0,36,45,39,0,45,85,76,84},32), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({36,45,39,0,45,85,76,84,73,80,76,73,69,82},32), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({50,69,68,85,67,69,68,0,36,45,39},32), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({50,69,68,85,67,69,68,0,34,85,82,78},32), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({50,69,68,85,67,69,68,0,38,82,69,69,90,69},32), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({39,82,69,86,73,79,85,83,0,55,79,85,78,68,83},32), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({78,85,77,66,69,82},32) then
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
if v:IsA(_d({52,69,88,84,44,65,66,69,76},32)) then
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
ReplicatedStorage:WaitForChild(_d({82,69,83,69,82,86,69,68,35,79,68,69},32))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({51,84,65,84,83},32))
local v6 = StatsFolder:WaitForChild(_d({41,78,86,69,78,84,79,82,89},32))
local Inventory = v6:WaitForChild(_d({41,78,86,69,78,84,79,82,89},32))
local Equiped = v6:WaitForChild(_d({37,81,85,73,80,69,68},32))
local VanitySlots = v6:WaitForChild(_d({54,65,78,73,84,89,51,76,79,84,83},32))
local FightingStyle = v5:WaitForChild(_d({38,73,71,72,84,73,78,71,51,84,89,76,69},32))
local KatanaOrder = v6:WaitForChild(_d({43,65,84,65,78,65,47,82,68,69,82},32))
local EquipedShip = v6:WaitForChild(_d({37,81,85,73,80,69,68,51,72,73,80},32))
local v7 = StatsFolder:WaitForChild(_d({52,73,84,76,69,83},32))
local AllTitles = v7:WaitForChild(_d({33,76,76,52,73,84,76,69,83},32))
local EquipedTitle = v7:WaitForChild(_d({37,81,85,73,80,69,68,52,73,84,76,69},32))
local AutoEquip = StatsFolder:WaitForChild(_d({51,69,84,84,73,78,71,83},32)):WaitForChild(_d({33,85,84,79,37,81,85,73,80},32))
local EquipedGrip = StatsFolder:WaitForChild(_d({39,82,73,80,83},32)):WaitForChild(_d({37,81,85,73,80,69,68,39,82,73,80},32))
local Inventory_2 = PlayerGui:WaitForChild(_d({41,78,86,69,78,84,79,82,89},32), 360)
local Main = Inventory_2:WaitForChild(_d({45,65,73,78},32))
local v8 = Main:WaitForChild(_d({41,78,86,69,78,84,79,82,89},32))
local List = v8:WaitForChild(_d({44,73,83,84},32))
local v9 = Main:WaitForChild(_d({52,79,80,52,65,66,83},32))
local UIGridLayout = List:WaitForChild(_d({53,41,39,82,73,68,44,65,89,79,85,84},32))
local UIPadding = List:WaitForChild(_d({53,41,48,65,68,68,73,78,71},32))
local v10 = v8:WaitForChild(_d({51,69,65,82,67,72},32))
local Input = v10:WaitForChild(_d({41,78,80,85,84},32))
local Clear = v10:WaitForChild(_d({35,76,69,65,82},32))
local ItemMenu = Main:WaitForChild(_d({41,84,69,77,45,69,78,85},32))
local Health = ItemMenu:WaitForChild(_d({40,69,65,76,84,72},32))
local Bar = Health:WaitForChild(_d({34,65,82},32))
local Equip = ItemMenu:WaitForChild(_d({37,81,85,73,80},32))
local Usage = Equip:WaitForChild(_d({53,83,65,71,69},32))
local Drop = ItemMenu:WaitForChild(_d({36,82,79,80},32))
local v11 = ItemMenu:WaitForChild(_d({45,73,83,67,34,85,84,84,79,78,83},32))
local Vanity = v11:WaitForChild(_d({54,65,78,73,84,89},32))
local CustomTailoredToggle = v11:WaitForChild(_d({35,85,83,84,79,77,52,65,73,76,79,82,69,68,52,79,71,71,76,69},32))
local SwordButtons = ItemMenu:WaitForChild(_d({51,87,79,82,68,34,85,84,84,79,78,83},32))
local Stats = ItemMenu:WaitForChild(_d({51,84,65,84,83},32))
local Boosts = Main:WaitForChild(_d({51,84,65,84,85,83,34,79,79,83,84,83},32)):WaitForChild(_d({34,79,79,83,84,83},32))
local v12 = Main:WaitForChild(_d({51,69,76,69,67,84,73,79,78,83},32))
local Frames = v12:WaitForChild(_d({38,82,65,77,69,83},32))
local RarityFilter = Main:WaitForChild(_d({50,65,82,73,84,89,38,73,76,84,69,82},32))
local Grips = Main:WaitForChild(_d({39,82,73,80,83},32))
local List_2 = Grips:WaitForChild(_d({44,73,83,84},32))
local LoadoutFrame = Main:WaitForChild(_d({44,79,65,68,79,85,84,38,82,65,77,69},32))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({37,78,65,66,76,69,68},32))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({54,73,83,73,66,76,69},32), Enabled)
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