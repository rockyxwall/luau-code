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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
game:GetService(_d({25,60,42,42,51,24,42,55,59,46,40,42},59))
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local HttpService = game:GetService(_d({13,57,57,53,24,42,55,59,46,40,42},59))
local RunService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local Modules = ReplicatedStorage:WaitForChild(_d({18,52,41,58,49,42,56},59))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({25,52,52,49,9,42,56,40},59))
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
local Events = ReplicatedStorage:WaitForChild(_d({10,59,42,51,57,56},59))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({26,14,56},59))
local RarityGradient = require(UIs:WaitForChild(_d({23,38,55,46,57,62,12,55,38,41,46,42,51,57},59)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59))
local Tools = ReplicatedStorage:WaitForChild(_d({25,52,52,49,56},59))
local Gradients = script:WaitForChild(_d({12,55,38,41,46,42,51,57,56},59))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({26,51,40,52,50,50,52,51},59)),
Rare = Gradients:WaitForChild(_d({23,38,55,42},59)),
Epic = Gradients:WaitForChild(_d({10,53,46,40},59)),
Legendary = Gradients:WaitForChild(_d({17,42,44,42,51,41,38,55,62},59)),
Mythical = Gradients:WaitForChild(_d({18,62,57,45,46,40,38,49},59)),
Collectable = Gradients:WaitForChild(_d({8,52,49,49,42,40,57,38,39,49,42},59)),
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
HP = {Display = _d({10,61,57,55,38,229,13,42,38,49,57,45},59), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({13,42,38,49,57,45,229,23,42,44,42,51},59), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({24,57,38,50,46,51,38,229,23,42,44,42,51},59), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({10,61,57,55,38,229,24,57,38,50,46,51,38},59), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({24,60,52,55,41,229,9,18,12,229,18,58,49,57},59), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({24,25,23,229,9,18,12,229,18,58,49,57},59), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({9,18,12,229,18,58,49,57,46,53,49,46,42,55},59), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({23,42,41,58,40,42,41,229,9,18,12},59), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({23,42,41,58,40,42,41,229,7,58,55,51},59), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({23,42,41,58,40,42,41,229,11,55,42,42,63,42},59), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({12,55,42,59,46,52,58,56,229,28,52,58,51,41,56},59), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({51,58,50,39,42,55},59) then
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
if v:IsA(_d({25,42,61,57,17,38,39,42,49},59)) then
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
ReplicatedStorage:WaitForChild(_d({55,42,56,42,55,59,42,41,8,52,41,42},59))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({24,57,38,57,56},59))
local v6 = StatsFolder:WaitForChild(_d({14,51,59,42,51,57,52,55,62},59))
local Inventory = v6:WaitForChild(_d({14,51,59,42,51,57,52,55,62},59))
local Equiped = v6:WaitForChild(_d({10,54,58,46,53,42,41},59))
local VanitySlots = v6:WaitForChild(_d({27,38,51,46,57,62,24,49,52,57,56},59))
local FightingStyle = v5:WaitForChild(_d({11,46,44,45,57,46,51,44,24,57,62,49,42},59))
local KatanaOrder = v6:WaitForChild(_d({16,38,57,38,51,38,20,55,41,42,55},59))
local EquipedShip = v6:WaitForChild(_d({10,54,58,46,53,42,41,24,45,46,53},59))
local v7 = StatsFolder:WaitForChild(_d({25,46,57,49,42,56},59))
local AllTitles = v7:WaitForChild(_d({6,49,49,25,46,57,49,42,56},59))
local EquipedTitle = v7:WaitForChild(_d({10,54,58,46,53,42,41,25,46,57,49,42},59))
local AutoEquip = StatsFolder:WaitForChild(_d({24,42,57,57,46,51,44,56},59)):WaitForChild(_d({6,58,57,52,10,54,58,46,53},59))
local EquipedGrip = StatsFolder:WaitForChild(_d({12,55,46,53,56},59)):WaitForChild(_d({10,54,58,46,53,42,41,12,55,46,53},59))
local Inventory_2 = PlayerGui:WaitForChild(_d({14,51,59,42,51,57,52,55,62},59), 360)
local Main = Inventory_2:WaitForChild(_d({18,38,46,51},59))
local v8 = Main:WaitForChild(_d({14,51,59,42,51,57,52,55,62},59))
local List = v8:WaitForChild(_d({17,46,56,57},59))
local v9 = Main:WaitForChild(_d({25,52,53,25,38,39,56},59))
local UIGridLayout = List:WaitForChild(_d({26,14,12,55,46,41,17,38,62,52,58,57},59))
local UIPadding = List:WaitForChild(_d({26,14,21,38,41,41,46,51,44},59))
local v10 = v8:WaitForChild(_d({24,42,38,55,40,45},59))
local Input = v10:WaitForChild(_d({14,51,53,58,57},59))
local Clear = v10:WaitForChild(_d({8,49,42,38,55},59))
local ItemMenu = Main:WaitForChild(_d({14,57,42,50,18,42,51,58},59))
local Health = ItemMenu:WaitForChild(_d({13,42,38,49,57,45},59))
local Bar = Health:WaitForChild(_d({7,38,55},59))
local Equip = ItemMenu:WaitForChild(_d({10,54,58,46,53},59))
local Usage = Equip:WaitForChild(_d({26,56,38,44,42},59))
local Drop = ItemMenu:WaitForChild(_d({9,55,52,53},59))
local v11 = ItemMenu:WaitForChild(_d({18,46,56,40,7,58,57,57,52,51,56},59))
local Vanity = v11:WaitForChild(_d({27,38,51,46,57,62},59))
local CustomTailoredToggle = v11:WaitForChild(_d({8,58,56,57,52,50,25,38,46,49,52,55,42,41,25,52,44,44,49,42},59))
local SwordButtons = ItemMenu:WaitForChild(_d({24,60,52,55,41,7,58,57,57,52,51,56},59))
local Stats = ItemMenu:WaitForChild(_d({24,57,38,57,56},59))
local Boosts = Main:WaitForChild(_d({24,57,38,57,58,56,7,52,52,56,57,56},59)):WaitForChild(_d({7,52,52,56,57,56},59))
local v12 = Main:WaitForChild(_d({24,42,49,42,40,57,46,52,51,56},59))
local Frames = v12:WaitForChild(_d({11,55,38,50,42,56},59))
local RarityFilter = Main:WaitForChild(_d({23,38,55,46,57,62,11,46,49,57,42,55},59))
local Grips = Main:WaitForChild(_d({12,55,46,53,56},59))
local List_2 = Grips:WaitForChild(_d({17,46,56,57},59))
local LoadoutFrame = Main:WaitForChild(_d({17,52,38,41,52,58,57,11,55,38,50,42},59))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({10,51,38,39,49,42,41},59))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({27,46,56,46,39,49,42},59), Enabled)
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