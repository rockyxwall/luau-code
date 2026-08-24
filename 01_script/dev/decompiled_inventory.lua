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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
game:GetService(_d({20,55,37,37,46,19,37,50,54,41,35,37},64))
local UserInputService = game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64))
local HttpService = game:GetService(_d({8,52,52,48,19,37,50,54,41,35,37},64))
local RunService = game:GetService(_d({18,53,46,19,37,50,54,41,35,37},64))
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local Modules = ReplicatedStorage:WaitForChild(_d({13,47,36,53,44,37,51},64))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({20,47,47,44,4,37,51,35},64))
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
local Events = ReplicatedStorage:WaitForChild(_d({5,54,37,46,52,51},64))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({21,9,51},64))
local RarityGradient = require(UIs:WaitForChild(_d({18,33,50,41,52,57,7,50,33,36,41,37,46,52},64)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({16,44,33,57,37,50,7,53,41},64))
local Tools = ReplicatedStorage:WaitForChild(_d({20,47,47,44,51},64))
local Gradients = script:WaitForChild(_d({7,50,33,36,41,37,46,52,51},64))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({21,46,35,47,45,45,47,46},64)),
Rare = Gradients:WaitForChild(_d({18,33,50,37},64)),
Epic = Gradients:WaitForChild(_d({5,48,41,35},64)),
Legendary = Gradients:WaitForChild(_d({12,37,39,37,46,36,33,50,57},64)),
Mythical = Gradients:WaitForChild(_d({13,57,52,40,41,35,33,44},64)),
Collectable = Gradients:WaitForChild(_d({3,47,44,44,37,35,52,33,34,44,37},64)),
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
HP = {Display = _d({5,56,52,50,33,224,8,37,33,44,52,40},64), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({8,37,33,44,52,40,224,18,37,39,37,46},64), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({19,52,33,45,41,46,33,224,18,37,39,37,46},64), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({5,56,52,50,33,224,19,52,33,45,41,46,33},64), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({19,55,47,50,36,224,4,13,7,224,13,53,44,52},64), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({19,20,18,224,4,13,7,224,13,53,44,52},64), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({4,13,7,224,13,53,44,52,41,48,44,41,37,50},64), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({18,37,36,53,35,37,36,224,4,13,7},64), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({18,37,36,53,35,37,36,224,2,53,50,46},64), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({18,37,36,53,35,37,36,224,6,50,37,37,58,37},64), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({7,50,37,54,41,47,53,51,224,23,47,53,46,36,51},64), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({46,53,45,34,37,50},64) then
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
if v:IsA(_d({20,37,56,52,12,33,34,37,44},64)) then
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
ReplicatedStorage:WaitForChild(_d({50,37,51,37,50,54,37,36,3,47,36,37},64))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({19,52,33,52,51},64))
local v6 = StatsFolder:WaitForChild(_d({9,46,54,37,46,52,47,50,57},64))
local Inventory = v6:WaitForChild(_d({9,46,54,37,46,52,47,50,57},64))
local Equiped = v6:WaitForChild(_d({5,49,53,41,48,37,36},64))
local VanitySlots = v6:WaitForChild(_d({22,33,46,41,52,57,19,44,47,52,51},64))
local FightingStyle = v5:WaitForChild(_d({6,41,39,40,52,41,46,39,19,52,57,44,37},64))
local KatanaOrder = v6:WaitForChild(_d({11,33,52,33,46,33,15,50,36,37,50},64))
local EquipedShip = v6:WaitForChild(_d({5,49,53,41,48,37,36,19,40,41,48},64))
local v7 = StatsFolder:WaitForChild(_d({20,41,52,44,37,51},64))
local AllTitles = v7:WaitForChild(_d({1,44,44,20,41,52,44,37,51},64))
local EquipedTitle = v7:WaitForChild(_d({5,49,53,41,48,37,36,20,41,52,44,37},64))
local AutoEquip = StatsFolder:WaitForChild(_d({19,37,52,52,41,46,39,51},64)):WaitForChild(_d({1,53,52,47,5,49,53,41,48},64))
local EquipedGrip = StatsFolder:WaitForChild(_d({7,50,41,48,51},64)):WaitForChild(_d({5,49,53,41,48,37,36,7,50,41,48},64))
local Inventory_2 = PlayerGui:WaitForChild(_d({9,46,54,37,46,52,47,50,57},64), 360)
local Main = Inventory_2:WaitForChild(_d({13,33,41,46},64))
local v8 = Main:WaitForChild(_d({9,46,54,37,46,52,47,50,57},64))
local List = v8:WaitForChild(_d({12,41,51,52},64))
local v9 = Main:WaitForChild(_d({20,47,48,20,33,34,51},64))
local UIGridLayout = List:WaitForChild(_d({21,9,7,50,41,36,12,33,57,47,53,52},64))
local UIPadding = List:WaitForChild(_d({21,9,16,33,36,36,41,46,39},64))
local v10 = v8:WaitForChild(_d({19,37,33,50,35,40},64))
local Input = v10:WaitForChild(_d({9,46,48,53,52},64))
local Clear = v10:WaitForChild(_d({3,44,37,33,50},64))
local ItemMenu = Main:WaitForChild(_d({9,52,37,45,13,37,46,53},64))
local Health = ItemMenu:WaitForChild(_d({8,37,33,44,52,40},64))
local Bar = Health:WaitForChild(_d({2,33,50},64))
local Equip = ItemMenu:WaitForChild(_d({5,49,53,41,48},64))
local Usage = Equip:WaitForChild(_d({21,51,33,39,37},64))
local Drop = ItemMenu:WaitForChild(_d({4,50,47,48},64))
local v11 = ItemMenu:WaitForChild(_d({13,41,51,35,2,53,52,52,47,46,51},64))
local Vanity = v11:WaitForChild(_d({22,33,46,41,52,57},64))
local CustomTailoredToggle = v11:WaitForChild(_d({3,53,51,52,47,45,20,33,41,44,47,50,37,36,20,47,39,39,44,37},64))
local SwordButtons = ItemMenu:WaitForChild(_d({19,55,47,50,36,2,53,52,52,47,46,51},64))
local Stats = ItemMenu:WaitForChild(_d({19,52,33,52,51},64))
local Boosts = Main:WaitForChild(_d({19,52,33,52,53,51,2,47,47,51,52,51},64)):WaitForChild(_d({2,47,47,51,52,51},64))
local v12 = Main:WaitForChild(_d({19,37,44,37,35,52,41,47,46,51},64))
local Frames = v12:WaitForChild(_d({6,50,33,45,37,51},64))
local RarityFilter = Main:WaitForChild(_d({18,33,50,41,52,57,6,41,44,52,37,50},64))
local Grips = Main:WaitForChild(_d({7,50,41,48,51},64))
local List_2 = Grips:WaitForChild(_d({12,41,51,52},64))
local LoadoutFrame = Main:WaitForChild(_d({12,47,33,36,47,53,52,6,50,33,45,37},64))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({5,46,33,34,44,37,36},64))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({22,41,51,41,34,44,37},64), Enabled)
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