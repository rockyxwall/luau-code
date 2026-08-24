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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
game:GetService(_d({24,59,41,41,50,23,41,54,58,45,39,41},60))
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
local HttpService = game:GetService(_d({12,56,56,52,23,41,54,58,45,39,41},60))
local RunService = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local Modules = ReplicatedStorage:WaitForChild(_d({17,51,40,57,48,41,55},60))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({24,51,51,48,8,41,55,39},60))
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
local Events = ReplicatedStorage:WaitForChild(_d({9,58,41,50,56,55},60))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({25,13,55},60))
local RarityGradient = require(UIs:WaitForChild(_d({22,37,54,45,56,61,11,54,37,40,45,41,50,56},60)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({20,48,37,61,41,54,11,57,45},60))
local Tools = ReplicatedStorage:WaitForChild(_d({24,51,51,48,55},60))
local Gradients = script:WaitForChild(_d({11,54,37,40,45,41,50,56,55},60))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({25,50,39,51,49,49,51,50},60)),
Rare = Gradients:WaitForChild(_d({22,37,54,41},60)),
Epic = Gradients:WaitForChild(_d({9,52,45,39},60)),
Legendary = Gradients:WaitForChild(_d({16,41,43,41,50,40,37,54,61},60)),
Mythical = Gradients:WaitForChild(_d({17,61,56,44,45,39,37,48},60)),
Collectable = Gradients:WaitForChild(_d({7,51,48,48,41,39,56,37,38,48,41},60)),
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
HP = {Display = _d({9,60,56,54,37,228,12,41,37,48,56,44},60), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({12,41,37,48,56,44,228,22,41,43,41,50},60), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({23,56,37,49,45,50,37,228,22,41,43,41,50},60), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({9,60,56,54,37,228,23,56,37,49,45,50,37},60), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({23,59,51,54,40,228,8,17,11,228,17,57,48,56},60), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({23,24,22,228,8,17,11,228,17,57,48,56},60), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({8,17,11,228,17,57,48,56,45,52,48,45,41,54},60), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({22,41,40,57,39,41,40,228,8,17,11},60), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({22,41,40,57,39,41,40,228,6,57,54,50},60), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({22,41,40,57,39,41,40,228,10,54,41,41,62,41},60), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({11,54,41,58,45,51,57,55,228,27,51,57,50,40,55},60), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({50,57,49,38,41,54},60) then
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
if v:IsA(_d({24,41,60,56,16,37,38,41,48},60)) then
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
ReplicatedStorage:WaitForChild(_d({54,41,55,41,54,58,41,40,7,51,40,41},60))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({23,56,37,56,55},60))
local v6 = StatsFolder:WaitForChild(_d({13,50,58,41,50,56,51,54,61},60))
local Inventory = v6:WaitForChild(_d({13,50,58,41,50,56,51,54,61},60))
local Equiped = v6:WaitForChild(_d({9,53,57,45,52,41,40},60))
local VanitySlots = v6:WaitForChild(_d({26,37,50,45,56,61,23,48,51,56,55},60))
local FightingStyle = v5:WaitForChild(_d({10,45,43,44,56,45,50,43,23,56,61,48,41},60))
local KatanaOrder = v6:WaitForChild(_d({15,37,56,37,50,37,19,54,40,41,54},60))
local EquipedShip = v6:WaitForChild(_d({9,53,57,45,52,41,40,23,44,45,52},60))
local v7 = StatsFolder:WaitForChild(_d({24,45,56,48,41,55},60))
local AllTitles = v7:WaitForChild(_d({5,48,48,24,45,56,48,41,55},60))
local EquipedTitle = v7:WaitForChild(_d({9,53,57,45,52,41,40,24,45,56,48,41},60))
local AutoEquip = StatsFolder:WaitForChild(_d({23,41,56,56,45,50,43,55},60)):WaitForChild(_d({5,57,56,51,9,53,57,45,52},60))
local EquipedGrip = StatsFolder:WaitForChild(_d({11,54,45,52,55},60)):WaitForChild(_d({9,53,57,45,52,41,40,11,54,45,52},60))
local Inventory_2 = PlayerGui:WaitForChild(_d({13,50,58,41,50,56,51,54,61},60), 360)
local Main = Inventory_2:WaitForChild(_d({17,37,45,50},60))
local v8 = Main:WaitForChild(_d({13,50,58,41,50,56,51,54,61},60))
local List = v8:WaitForChild(_d({16,45,55,56},60))
local v9 = Main:WaitForChild(_d({24,51,52,24,37,38,55},60))
local UIGridLayout = List:WaitForChild(_d({25,13,11,54,45,40,16,37,61,51,57,56},60))
local UIPadding = List:WaitForChild(_d({25,13,20,37,40,40,45,50,43},60))
local v10 = v8:WaitForChild(_d({23,41,37,54,39,44},60))
local Input = v10:WaitForChild(_d({13,50,52,57,56},60))
local Clear = v10:WaitForChild(_d({7,48,41,37,54},60))
local ItemMenu = Main:WaitForChild(_d({13,56,41,49,17,41,50,57},60))
local Health = ItemMenu:WaitForChild(_d({12,41,37,48,56,44},60))
local Bar = Health:WaitForChild(_d({6,37,54},60))
local Equip = ItemMenu:WaitForChild(_d({9,53,57,45,52},60))
local Usage = Equip:WaitForChild(_d({25,55,37,43,41},60))
local Drop = ItemMenu:WaitForChild(_d({8,54,51,52},60))
local v11 = ItemMenu:WaitForChild(_d({17,45,55,39,6,57,56,56,51,50,55},60))
local Vanity = v11:WaitForChild(_d({26,37,50,45,56,61},60))
local CustomTailoredToggle = v11:WaitForChild(_d({7,57,55,56,51,49,24,37,45,48,51,54,41,40,24,51,43,43,48,41},60))
local SwordButtons = ItemMenu:WaitForChild(_d({23,59,51,54,40,6,57,56,56,51,50,55},60))
local Stats = ItemMenu:WaitForChild(_d({23,56,37,56,55},60))
local Boosts = Main:WaitForChild(_d({23,56,37,56,57,55,6,51,51,55,56,55},60)):WaitForChild(_d({6,51,51,55,56,55},60))
local v12 = Main:WaitForChild(_d({23,41,48,41,39,56,45,51,50,55},60))
local Frames = v12:WaitForChild(_d({10,54,37,49,41,55},60))
local RarityFilter = Main:WaitForChild(_d({22,37,54,45,56,61,10,45,48,56,41,54},60))
local Grips = Main:WaitForChild(_d({11,54,45,52,55},60))
local List_2 = Grips:WaitForChild(_d({16,45,55,56},60))
local LoadoutFrame = Main:WaitForChild(_d({16,51,37,40,51,57,56,10,54,37,49,41},60))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({9,50,37,38,48,41,40},60))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({26,45,55,45,38,48,41},60), Enabled)
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