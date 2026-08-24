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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
game:GetService(_d({29,64,46,46,55,28,46,59,63,50,44,46},55))
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
local HttpService = game:GetService(_d({17,61,61,57,28,46,59,63,50,44,46},55))
local RunService = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local Modules = ReplicatedStorage:WaitForChild(_d({22,56,45,62,53,46,60},55))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({29,56,56,53,13,46,60,44},55))
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
local Events = ReplicatedStorage:WaitForChild(_d({14,63,46,55,61,60},55))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({30,18,60},55))
local RarityGradient = require(UIs:WaitForChild(_d({27,42,59,50,61,66,16,59,42,45,50,46,55,61},55)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({25,53,42,66,46,59,16,62,50},55))
local Tools = ReplicatedStorage:WaitForChild(_d({29,56,56,53,60},55))
local Gradients = script:WaitForChild(_d({16,59,42,45,50,46,55,61,60},55))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({30,55,44,56,54,54,56,55},55)),
Rare = Gradients:WaitForChild(_d({27,42,59,46},55)),
Epic = Gradients:WaitForChild(_d({14,57,50,44},55)),
Legendary = Gradients:WaitForChild(_d({21,46,48,46,55,45,42,59,66},55)),
Mythical = Gradients:WaitForChild(_d({22,66,61,49,50,44,42,53},55)),
Collectable = Gradients:WaitForChild(_d({12,56,53,53,46,44,61,42,43,53,46},55)),
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
HP = {Display = _d({14,65,61,59,42,233,17,46,42,53,61,49},55), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({17,46,42,53,61,49,233,27,46,48,46,55},55), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({28,61,42,54,50,55,42,233,27,46,48,46,55},55), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({14,65,61,59,42,233,28,61,42,54,50,55,42},55), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({28,64,56,59,45,233,13,22,16,233,22,62,53,61},55), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({28,29,27,233,13,22,16,233,22,62,53,61},55), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({13,22,16,233,22,62,53,61,50,57,53,50,46,59},55), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({27,46,45,62,44,46,45,233,13,22,16},55), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({27,46,45,62,44,46,45,233,11,62,59,55},55), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({27,46,45,62,44,46,45,233,15,59,46,46,67,46},55), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({16,59,46,63,50,56,62,60,233,32,56,62,55,45,60},55), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({55,62,54,43,46,59},55) then
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
if v:IsA(_d({29,46,65,61,21,42,43,46,53},55)) then
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
ReplicatedStorage:WaitForChild(_d({59,46,60,46,59,63,46,45,12,56,45,46},55))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({28,61,42,61,60},55))
local v6 = StatsFolder:WaitForChild(_d({18,55,63,46,55,61,56,59,66},55))
local Inventory = v6:WaitForChild(_d({18,55,63,46,55,61,56,59,66},55))
local Equiped = v6:WaitForChild(_d({14,58,62,50,57,46,45},55))
local VanitySlots = v6:WaitForChild(_d({31,42,55,50,61,66,28,53,56,61,60},55))
local FightingStyle = v5:WaitForChild(_d({15,50,48,49,61,50,55,48,28,61,66,53,46},55))
local KatanaOrder = v6:WaitForChild(_d({20,42,61,42,55,42,24,59,45,46,59},55))
local EquipedShip = v6:WaitForChild(_d({14,58,62,50,57,46,45,28,49,50,57},55))
local v7 = StatsFolder:WaitForChild(_d({29,50,61,53,46,60},55))
local AllTitles = v7:WaitForChild(_d({10,53,53,29,50,61,53,46,60},55))
local EquipedTitle = v7:WaitForChild(_d({14,58,62,50,57,46,45,29,50,61,53,46},55))
local AutoEquip = StatsFolder:WaitForChild(_d({28,46,61,61,50,55,48,60},55)):WaitForChild(_d({10,62,61,56,14,58,62,50,57},55))
local EquipedGrip = StatsFolder:WaitForChild(_d({16,59,50,57,60},55)):WaitForChild(_d({14,58,62,50,57,46,45,16,59,50,57},55))
local Inventory_2 = PlayerGui:WaitForChild(_d({18,55,63,46,55,61,56,59,66},55), 360)
local Main = Inventory_2:WaitForChild(_d({22,42,50,55},55))
local v8 = Main:WaitForChild(_d({18,55,63,46,55,61,56,59,66},55))
local List = v8:WaitForChild(_d({21,50,60,61},55))
local v9 = Main:WaitForChild(_d({29,56,57,29,42,43,60},55))
local UIGridLayout = List:WaitForChild(_d({30,18,16,59,50,45,21,42,66,56,62,61},55))
local UIPadding = List:WaitForChild(_d({30,18,25,42,45,45,50,55,48},55))
local v10 = v8:WaitForChild(_d({28,46,42,59,44,49},55))
local Input = v10:WaitForChild(_d({18,55,57,62,61},55))
local Clear = v10:WaitForChild(_d({12,53,46,42,59},55))
local ItemMenu = Main:WaitForChild(_d({18,61,46,54,22,46,55,62},55))
local Health = ItemMenu:WaitForChild(_d({17,46,42,53,61,49},55))
local Bar = Health:WaitForChild(_d({11,42,59},55))
local Equip = ItemMenu:WaitForChild(_d({14,58,62,50,57},55))
local Usage = Equip:WaitForChild(_d({30,60,42,48,46},55))
local Drop = ItemMenu:WaitForChild(_d({13,59,56,57},55))
local v11 = ItemMenu:WaitForChild(_d({22,50,60,44,11,62,61,61,56,55,60},55))
local Vanity = v11:WaitForChild(_d({31,42,55,50,61,66},55))
local CustomTailoredToggle = v11:WaitForChild(_d({12,62,60,61,56,54,29,42,50,53,56,59,46,45,29,56,48,48,53,46},55))
local SwordButtons = ItemMenu:WaitForChild(_d({28,64,56,59,45,11,62,61,61,56,55,60},55))
local Stats = ItemMenu:WaitForChild(_d({28,61,42,61,60},55))
local Boosts = Main:WaitForChild(_d({28,61,42,61,62,60,11,56,56,60,61,60},55)):WaitForChild(_d({11,56,56,60,61,60},55))
local v12 = Main:WaitForChild(_d({28,46,53,46,44,61,50,56,55,60},55))
local Frames = v12:WaitForChild(_d({15,59,42,54,46,60},55))
local RarityFilter = Main:WaitForChild(_d({27,42,59,50,61,66,15,50,53,61,46,59},55))
local Grips = Main:WaitForChild(_d({16,59,50,57,60},55))
local List_2 = Grips:WaitForChild(_d({21,50,60,61},55))
local LoadoutFrame = Main:WaitForChild(_d({21,56,42,45,56,62,61,15,59,42,54,46},55))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({14,55,42,43,53,46,45},55))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({31,50,60,50,43,53,46},55), Enabled)
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