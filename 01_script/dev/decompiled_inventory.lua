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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
game:GetService(_d({23,58,40,40,49,22,40,53,57,44,38,40},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local HttpService = game:GetService(_d({11,55,55,51,22,40,53,57,44,38,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local Modules = ReplicatedStorage:WaitForChild(_d({16,50,39,56,47,40,54},61))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({23,50,50,47,7,40,54,38},61))
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
local Events = ReplicatedStorage:WaitForChild(_d({8,57,40,49,55,54},61))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({24,12,54},61))
local RarityGradient = require(UIs:WaitForChild(_d({21,36,53,44,55,60,10,53,36,39,44,40,49,55},61)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({19,47,36,60,40,53,10,56,44},61))
local Tools = ReplicatedStorage:WaitForChild(_d({23,50,50,47,54},61))
local Gradients = script:WaitForChild(_d({10,53,36,39,44,40,49,55,54},61))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({24,49,38,50,48,48,50,49},61)),
Rare = Gradients:WaitForChild(_d({21,36,53,40},61)),
Epic = Gradients:WaitForChild(_d({8,51,44,38},61)),
Legendary = Gradients:WaitForChild(_d({15,40,42,40,49,39,36,53,60},61)),
Mythical = Gradients:WaitForChild(_d({16,60,55,43,44,38,36,47},61)),
Collectable = Gradients:WaitForChild(_d({6,50,47,47,40,38,55,36,37,47,40},61)),
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
HP = {Display = _d({8,59,55,53,36,227,11,40,36,47,55,43},61), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({11,40,36,47,55,43,227,21,40,42,40,49},61), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({22,55,36,48,44,49,36,227,21,40,42,40,49},61), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({8,59,55,53,36,227,22,55,36,48,44,49,36},61), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({22,58,50,53,39,227,7,16,10,227,16,56,47,55},61), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({22,23,21,227,7,16,10,227,16,56,47,55},61), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({7,16,10,227,16,56,47,55,44,51,47,44,40,53},61), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({21,40,39,56,38,40,39,227,7,16,10},61), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({21,40,39,56,38,40,39,227,5,56,53,49},61), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({21,40,39,56,38,40,39,227,9,53,40,40,61,40},61), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({10,53,40,57,44,50,56,54,227,26,50,56,49,39,54},61), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({49,56,48,37,40,53},61) then
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
if v:IsA(_d({23,40,59,55,15,36,37,40,47},61)) then
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
ReplicatedStorage:WaitForChild(_d({53,40,54,40,53,57,40,39,6,50,39,40},61))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({22,55,36,55,54},61))
local v6 = StatsFolder:WaitForChild(_d({12,49,57,40,49,55,50,53,60},61))
local Inventory = v6:WaitForChild(_d({12,49,57,40,49,55,50,53,60},61))
local Equiped = v6:WaitForChild(_d({8,52,56,44,51,40,39},61))
local VanitySlots = v6:WaitForChild(_d({25,36,49,44,55,60,22,47,50,55,54},61))
local FightingStyle = v5:WaitForChild(_d({9,44,42,43,55,44,49,42,22,55,60,47,40},61))
local KatanaOrder = v6:WaitForChild(_d({14,36,55,36,49,36,18,53,39,40,53},61))
local EquipedShip = v6:WaitForChild(_d({8,52,56,44,51,40,39,22,43,44,51},61))
local v7 = StatsFolder:WaitForChild(_d({23,44,55,47,40,54},61))
local AllTitles = v7:WaitForChild(_d({4,47,47,23,44,55,47,40,54},61))
local EquipedTitle = v7:WaitForChild(_d({8,52,56,44,51,40,39,23,44,55,47,40},61))
local AutoEquip = StatsFolder:WaitForChild(_d({22,40,55,55,44,49,42,54},61)):WaitForChild(_d({4,56,55,50,8,52,56,44,51},61))
local EquipedGrip = StatsFolder:WaitForChild(_d({10,53,44,51,54},61)):WaitForChild(_d({8,52,56,44,51,40,39,10,53,44,51},61))
local Inventory_2 = PlayerGui:WaitForChild(_d({12,49,57,40,49,55,50,53,60},61), 360)
local Main = Inventory_2:WaitForChild(_d({16,36,44,49},61))
local v8 = Main:WaitForChild(_d({12,49,57,40,49,55,50,53,60},61))
local List = v8:WaitForChild(_d({15,44,54,55},61))
local v9 = Main:WaitForChild(_d({23,50,51,23,36,37,54},61))
local UIGridLayout = List:WaitForChild(_d({24,12,10,53,44,39,15,36,60,50,56,55},61))
local UIPadding = List:WaitForChild(_d({24,12,19,36,39,39,44,49,42},61))
local v10 = v8:WaitForChild(_d({22,40,36,53,38,43},61))
local Input = v10:WaitForChild(_d({12,49,51,56,55},61))
local Clear = v10:WaitForChild(_d({6,47,40,36,53},61))
local ItemMenu = Main:WaitForChild(_d({12,55,40,48,16,40,49,56},61))
local Health = ItemMenu:WaitForChild(_d({11,40,36,47,55,43},61))
local Bar = Health:WaitForChild(_d({5,36,53},61))
local Equip = ItemMenu:WaitForChild(_d({8,52,56,44,51},61))
local Usage = Equip:WaitForChild(_d({24,54,36,42,40},61))
local Drop = ItemMenu:WaitForChild(_d({7,53,50,51},61))
local v11 = ItemMenu:WaitForChild(_d({16,44,54,38,5,56,55,55,50,49,54},61))
local Vanity = v11:WaitForChild(_d({25,36,49,44,55,60},61))
local CustomTailoredToggle = v11:WaitForChild(_d({6,56,54,55,50,48,23,36,44,47,50,53,40,39,23,50,42,42,47,40},61))
local SwordButtons = ItemMenu:WaitForChild(_d({22,58,50,53,39,5,56,55,55,50,49,54},61))
local Stats = ItemMenu:WaitForChild(_d({22,55,36,55,54},61))
local Boosts = Main:WaitForChild(_d({22,55,36,55,56,54,5,50,50,54,55,54},61)):WaitForChild(_d({5,50,50,54,55,54},61))
local v12 = Main:WaitForChild(_d({22,40,47,40,38,55,44,50,49,54},61))
local Frames = v12:WaitForChild(_d({9,53,36,48,40,54},61))
local RarityFilter = Main:WaitForChild(_d({21,36,53,44,55,60,9,44,47,55,40,53},61))
local Grips = Main:WaitForChild(_d({10,53,44,51,54},61))
local List_2 = Grips:WaitForChild(_d({15,44,54,55},61))
local LoadoutFrame = Main:WaitForChild(_d({15,50,36,39,50,56,55,9,53,36,48,40},61))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({8,49,36,37,47,40,39},61))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({25,44,54,44,37,47,40},61), Enabled)
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