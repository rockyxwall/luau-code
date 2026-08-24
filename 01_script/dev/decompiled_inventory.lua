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
local Players = game:GetService(_d({36,64,53,77,57,70,71},44))
game:GetService(_d({38,57,68,64,61,55,53,72,57,56,39,72,67,70,53,59,57},44))
game:GetService(_d({40,75,57,57,66,39,57,70,74,61,55,57},44))
local UserInputService = game:GetService(_d({41,71,57,70,29,66,68,73,72,39,57,70,74,61,55,57},44))
local HttpService = game:GetService(_d({28,72,72,68,39,57,70,74,61,55,57},44))
local RunService = game:GetService(_d({38,73,66,39,57,70,74,61,55,57},44))
local ReplicatedStorage = game:GetService(_d({38,57,68,64,61,55,53,72,57,56,39,72,67,70,53,59,57},44))
local Modules = ReplicatedStorage:WaitForChild(_d({33,67,56,73,64,57,71},44))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({40,67,67,64,24,57,71,55},44))
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
local Events = ReplicatedStorage:WaitForChild(_d({25,74,57,66,72,71},44))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({41,29,71},44))
local RarityGradient = require(UIs:WaitForChild(_d({38,53,70,61,72,77,27,70,53,56,61,57,66,72},44)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({36,64,53,77,57,70,27,73,61},44))
local Tools = ReplicatedStorage:WaitForChild(_d({40,67,67,64,71},44))
local Gradients = script:WaitForChild(_d({27,70,53,56,61,57,66,72,71},44))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({41,66,55,67,65,65,67,66},44)),
Rare = Gradients:WaitForChild(_d({38,53,70,57},44)),
Epic = Gradients:WaitForChild(_d({25,68,61,55},44)),
Legendary = Gradients:WaitForChild(_d({32,57,59,57,66,56,53,70,77},44)),
Mythical = Gradients:WaitForChild(_d({33,77,72,60,61,55,53,64},44)),
Collectable = Gradients:WaitForChild(_d({23,67,64,64,57,55,72,53,54,64,57},44)),
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
HP = {Display = _d({25,76,72,70,53,244,28,57,53,64,72,60},44), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({28,57,53,64,72,60,244,38,57,59,57,66},44), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({39,72,53,65,61,66,53,244,38,57,59,57,66},44), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({25,76,72,70,53,244,39,72,53,65,61,66,53},44), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({39,75,67,70,56,244,24,33,27,244,33,73,64,72},44), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({39,40,38,244,24,33,27,244,33,73,64,72},44), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({24,33,27,244,33,73,64,72,61,68,64,61,57,70},44), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({38,57,56,73,55,57,56,244,24,33,27},44), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({38,57,56,73,55,57,56,244,22,73,70,66},44), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({38,57,56,73,55,57,56,244,26,70,57,57,78,57},44), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({27,70,57,74,61,67,73,71,244,43,67,73,66,56,71},44), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({66,73,65,54,57,70},44) then
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
if v:IsA(_d({40,57,76,72,32,53,54,57,64},44)) then
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
ReplicatedStorage:WaitForChild(_d({70,57,71,57,70,74,57,56,23,67,56,57},44))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({39,72,53,72,71},44))
local v6 = StatsFolder:WaitForChild(_d({29,66,74,57,66,72,67,70,77},44))
local Inventory = v6:WaitForChild(_d({29,66,74,57,66,72,67,70,77},44))
local Equiped = v6:WaitForChild(_d({25,69,73,61,68,57,56},44))
local VanitySlots = v6:WaitForChild(_d({42,53,66,61,72,77,39,64,67,72,71},44))
local FightingStyle = v5:WaitForChild(_d({26,61,59,60,72,61,66,59,39,72,77,64,57},44))
local KatanaOrder = v6:WaitForChild(_d({31,53,72,53,66,53,35,70,56,57,70},44))
local EquipedShip = v6:WaitForChild(_d({25,69,73,61,68,57,56,39,60,61,68},44))
local v7 = StatsFolder:WaitForChild(_d({40,61,72,64,57,71},44))
local AllTitles = v7:WaitForChild(_d({21,64,64,40,61,72,64,57,71},44))
local EquipedTitle = v7:WaitForChild(_d({25,69,73,61,68,57,56,40,61,72,64,57},44))
local AutoEquip = StatsFolder:WaitForChild(_d({39,57,72,72,61,66,59,71},44)):WaitForChild(_d({21,73,72,67,25,69,73,61,68},44))
local EquipedGrip = StatsFolder:WaitForChild(_d({27,70,61,68,71},44)):WaitForChild(_d({25,69,73,61,68,57,56,27,70,61,68},44))
local Inventory_2 = PlayerGui:WaitForChild(_d({29,66,74,57,66,72,67,70,77},44), 360)
local Main = Inventory_2:WaitForChild(_d({33,53,61,66},44))
local v8 = Main:WaitForChild(_d({29,66,74,57,66,72,67,70,77},44))
local List = v8:WaitForChild(_d({32,61,71,72},44))
local v9 = Main:WaitForChild(_d({40,67,68,40,53,54,71},44))
local UIGridLayout = List:WaitForChild(_d({41,29,27,70,61,56,32,53,77,67,73,72},44))
local UIPadding = List:WaitForChild(_d({41,29,36,53,56,56,61,66,59},44))
local v10 = v8:WaitForChild(_d({39,57,53,70,55,60},44))
local Input = v10:WaitForChild(_d({29,66,68,73,72},44))
local Clear = v10:WaitForChild(_d({23,64,57,53,70},44))
local ItemMenu = Main:WaitForChild(_d({29,72,57,65,33,57,66,73},44))
local Health = ItemMenu:WaitForChild(_d({28,57,53,64,72,60},44))
local Bar = Health:WaitForChild(_d({22,53,70},44))
local Equip = ItemMenu:WaitForChild(_d({25,69,73,61,68},44))
local Usage = Equip:WaitForChild(_d({41,71,53,59,57},44))
local Drop = ItemMenu:WaitForChild(_d({24,70,67,68},44))
local v11 = ItemMenu:WaitForChild(_d({33,61,71,55,22,73,72,72,67,66,71},44))
local Vanity = v11:WaitForChild(_d({42,53,66,61,72,77},44))
local CustomTailoredToggle = v11:WaitForChild(_d({23,73,71,72,67,65,40,53,61,64,67,70,57,56,40,67,59,59,64,57},44))
local SwordButtons = ItemMenu:WaitForChild(_d({39,75,67,70,56,22,73,72,72,67,66,71},44))
local Stats = ItemMenu:WaitForChild(_d({39,72,53,72,71},44))
local Boosts = Main:WaitForChild(_d({39,72,53,72,73,71,22,67,67,71,72,71},44)):WaitForChild(_d({22,67,67,71,72,71},44))
local v12 = Main:WaitForChild(_d({39,57,64,57,55,72,61,67,66,71},44))
local Frames = v12:WaitForChild(_d({26,70,53,65,57,71},44))
local RarityFilter = Main:WaitForChild(_d({38,53,70,61,72,77,26,61,64,72,57,70},44))
local Grips = Main:WaitForChild(_d({27,70,61,68,71},44))
local List_2 = Grips:WaitForChild(_d({32,61,71,72},44))
local LoadoutFrame = Main:WaitForChild(_d({32,67,53,56,67,73,72,26,70,53,65,57},44))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({25,66,53,54,64,57,56},44))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({42,61,71,61,54,64,57},44), Enabled)
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