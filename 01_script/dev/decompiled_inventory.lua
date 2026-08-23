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
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
game:GetService(_d({28,63,45,45,54,27,45,58,62,49,43,45},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
local HttpService = game:GetService(_d({16,60,60,56,27,45,58,62,49,43,45},56))
local RunService = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local Modules = ReplicatedStorage:WaitForChild(_d({21,55,44,61,52,45,59},56))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({28,55,55,52,12,45,59,43},56))
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
local Events = ReplicatedStorage:WaitForChild(_d({13,62,45,54,60,59},56))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({29,17,59},56))
local RarityGradient = require(UIs:WaitForChild(_d({26,41,58,49,60,65,15,58,41,44,49,45,54,60},56)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({24,52,41,65,45,58,15,61,49},56))
local Tools = ReplicatedStorage:WaitForChild(_d({28,55,55,52,59},56))
local Gradients = script:WaitForChild(_d({15,58,41,44,49,45,54,60,59},56))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({29,54,43,55,53,53,55,54},56)),
Rare = Gradients:WaitForChild(_d({26,41,58,45},56)),
Epic = Gradients:WaitForChild(_d({13,56,49,43},56)),
Legendary = Gradients:WaitForChild(_d({20,45,47,45,54,44,41,58,65},56)),
Mythical = Gradients:WaitForChild(_d({21,65,60,48,49,43,41,52},56)),
Collectable = Gradients:WaitForChild(_d({11,55,52,52,45,43,60,41,42,52,45},56)),
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
HP = {Display = _d({13,64,60,58,41,232,16,45,41,52,60,48},56), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({16,45,41,52,60,48,232,26,45,47,45,54},56), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({27,60,41,53,49,54,41,232,26,45,47,45,54},56), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({13,64,60,58,41,232,27,60,41,53,49,54,41},56), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({27,63,55,58,44,232,12,21,15,232,21,61,52,60},56), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({27,28,26,232,12,21,15,232,21,61,52,60},56), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({12,21,15,232,21,61,52,60,49,56,52,49,45,58},56), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({26,45,44,61,43,45,44,232,12,21,15},56), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({26,45,44,61,43,45,44,232,10,61,58,54},56), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({26,45,44,61,43,45,44,232,14,58,45,45,66,45},56), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({15,58,45,62,49,55,61,59,232,31,55,61,54,44,59},56), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({54,61,53,42,45,58},56) then
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
if v:IsA(_d({28,45,64,60,20,41,42,45,52},56)) then
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
ReplicatedStorage:WaitForChild(_d({58,45,59,45,58,62,45,44,11,55,44,45},56))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({27,60,41,60,59},56))
local v6 = StatsFolder:WaitForChild(_d({17,54,62,45,54,60,55,58,65},56))
local Inventory = v6:WaitForChild(_d({17,54,62,45,54,60,55,58,65},56))
local Equiped = v6:WaitForChild(_d({13,57,61,49,56,45,44},56))
local VanitySlots = v6:WaitForChild(_d({30,41,54,49,60,65,27,52,55,60,59},56))
local FightingStyle = v5:WaitForChild(_d({14,49,47,48,60,49,54,47,27,60,65,52,45},56))
local KatanaOrder = v6:WaitForChild(_d({19,41,60,41,54,41,23,58,44,45,58},56))
local EquipedShip = v6:WaitForChild(_d({13,57,61,49,56,45,44,27,48,49,56},56))
local v7 = StatsFolder:WaitForChild(_d({28,49,60,52,45,59},56))
local AllTitles = v7:WaitForChild(_d({9,52,52,28,49,60,52,45,59},56))
local EquipedTitle = v7:WaitForChild(_d({13,57,61,49,56,45,44,28,49,60,52,45},56))
local AutoEquip = StatsFolder:WaitForChild(_d({27,45,60,60,49,54,47,59},56)):WaitForChild(_d({9,61,60,55,13,57,61,49,56},56))
local EquipedGrip = StatsFolder:WaitForChild(_d({15,58,49,56,59},56)):WaitForChild(_d({13,57,61,49,56,45,44,15,58,49,56},56))
local Inventory_2 = PlayerGui:WaitForChild(_d({17,54,62,45,54,60,55,58,65},56), 360)
local Main = Inventory_2:WaitForChild(_d({21,41,49,54},56))
local v8 = Main:WaitForChild(_d({17,54,62,45,54,60,55,58,65},56))
local List = v8:WaitForChild(_d({20,49,59,60},56))
local v9 = Main:WaitForChild(_d({28,55,56,28,41,42,59},56))
local UIGridLayout = List:WaitForChild(_d({29,17,15,58,49,44,20,41,65,55,61,60},56))
local UIPadding = List:WaitForChild(_d({29,17,24,41,44,44,49,54,47},56))
local v10 = v8:WaitForChild(_d({27,45,41,58,43,48},56))
local Input = v10:WaitForChild(_d({17,54,56,61,60},56))
local Clear = v10:WaitForChild(_d({11,52,45,41,58},56))
local ItemMenu = Main:WaitForChild(_d({17,60,45,53,21,45,54,61},56))
local Health = ItemMenu:WaitForChild(_d({16,45,41,52,60,48},56))
local Bar = Health:WaitForChild(_d({10,41,58},56))
local Equip = ItemMenu:WaitForChild(_d({13,57,61,49,56},56))
local Usage = Equip:WaitForChild(_d({29,59,41,47,45},56))
local Drop = ItemMenu:WaitForChild(_d({12,58,55,56},56))
local v11 = ItemMenu:WaitForChild(_d({21,49,59,43,10,61,60,60,55,54,59},56))
local Vanity = v11:WaitForChild(_d({30,41,54,49,60,65},56))
local CustomTailoredToggle = v11:WaitForChild(_d({11,61,59,60,55,53,28,41,49,52,55,58,45,44,28,55,47,47,52,45},56))
local SwordButtons = ItemMenu:WaitForChild(_d({27,63,55,58,44,10,61,60,60,55,54,59},56))
local Stats = ItemMenu:WaitForChild(_d({27,60,41,60,59},56))
local Boosts = Main:WaitForChild(_d({27,60,41,60,61,59,10,55,55,59,60,59},56)):WaitForChild(_d({10,55,55,59,60,59},56))
local v12 = Main:WaitForChild(_d({27,45,52,45,43,60,49,55,54,59},56))
local Frames = v12:WaitForChild(_d({14,58,41,53,45,59},56))
local RarityFilter = Main:WaitForChild(_d({26,41,58,49,60,65,14,49,52,60,45,58},56))
local Grips = Main:WaitForChild(_d({15,58,49,56,59},56))
local List_2 = Grips:WaitForChild(_d({20,49,59,60},56))
local LoadoutFrame = Main:WaitForChild(_d({20,55,41,44,55,61,60,14,58,41,53,45},56))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({13,54,41,42,52,45,44},56))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({30,49,59,49,42,52,45},56), Enabled)
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