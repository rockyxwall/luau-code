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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
game:GetService(_d({30,65,47,47,56,29,47,60,64,51,45,47},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
local HttpService = game:GetService(_d({18,62,62,58,29,47,60,64,51,45,47},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local Modules = ReplicatedStorage:WaitForChild(_d({23,57,46,63,54,47,61},54))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({30,57,57,54,14,47,61,45},54))
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
local Events = ReplicatedStorage:WaitForChild(_d({15,64,47,56,62,61},54))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({31,19,61},54))
local RarityGradient = require(UIs:WaitForChild(_d({28,43,60,51,62,67,17,60,43,46,51,47,56,62},54)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54))
local Tools = ReplicatedStorage:WaitForChild(_d({30,57,57,54,61},54))
local Gradients = script:WaitForChild(_d({17,60,43,46,51,47,56,62,61},54))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({31,56,45,57,55,55,57,56},54)),
Rare = Gradients:WaitForChild(_d({28,43,60,47},54)),
Epic = Gradients:WaitForChild(_d({15,58,51,45},54)),
Legendary = Gradients:WaitForChild(_d({22,47,49,47,56,46,43,60,67},54)),
Mythical = Gradients:WaitForChild(_d({23,67,62,50,51,45,43,54},54)),
Collectable = Gradients:WaitForChild(_d({13,57,54,54,47,45,62,43,44,54,47},54)),
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
HP = {Display = _d({15,66,62,60,43,234,18,47,43,54,62,50},54), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({18,47,43,54,62,50,234,28,47,49,47,56},54), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({29,62,43,55,51,56,43,234,28,47,49,47,56},54), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({15,66,62,60,43,234,29,62,43,55,51,56,43},54), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({29,65,57,60,46,234,14,23,17,234,23,63,54,62},54), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({29,30,28,234,14,23,17,234,23,63,54,62},54), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({14,23,17,234,23,63,54,62,51,58,54,51,47,60},54), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({28,47,46,63,45,47,46,234,14,23,17},54), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({28,47,46,63,45,47,46,234,12,63,60,56},54), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({28,47,46,63,45,47,46,234,16,60,47,47,68,47},54), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({17,60,47,64,51,57,63,61,234,33,57,63,56,46,61},54), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({56,63,55,44,47,60},54) then
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
if v:IsA(_d({30,47,66,62,22,43,44,47,54},54)) then
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
ReplicatedStorage:WaitForChild(_d({60,47,61,47,60,64,47,46,13,57,46,47},54))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({29,62,43,62,61},54))
local v6 = StatsFolder:WaitForChild(_d({19,56,64,47,56,62,57,60,67},54))
local Inventory = v6:WaitForChild(_d({19,56,64,47,56,62,57,60,67},54))
local Equiped = v6:WaitForChild(_d({15,59,63,51,58,47,46},54))
local VanitySlots = v6:WaitForChild(_d({32,43,56,51,62,67,29,54,57,62,61},54))
local FightingStyle = v5:WaitForChild(_d({16,51,49,50,62,51,56,49,29,62,67,54,47},54))
local KatanaOrder = v6:WaitForChild(_d({21,43,62,43,56,43,25,60,46,47,60},54))
local EquipedShip = v6:WaitForChild(_d({15,59,63,51,58,47,46,29,50,51,58},54))
local v7 = StatsFolder:WaitForChild(_d({30,51,62,54,47,61},54))
local AllTitles = v7:WaitForChild(_d({11,54,54,30,51,62,54,47,61},54))
local EquipedTitle = v7:WaitForChild(_d({15,59,63,51,58,47,46,30,51,62,54,47},54))
local AutoEquip = StatsFolder:WaitForChild(_d({29,47,62,62,51,56,49,61},54)):WaitForChild(_d({11,63,62,57,15,59,63,51,58},54))
local EquipedGrip = StatsFolder:WaitForChild(_d({17,60,51,58,61},54)):WaitForChild(_d({15,59,63,51,58,47,46,17,60,51,58},54))
local Inventory_2 = PlayerGui:WaitForChild(_d({19,56,64,47,56,62,57,60,67},54), 360)
local Main = Inventory_2:WaitForChild(_d({23,43,51,56},54))
local v8 = Main:WaitForChild(_d({19,56,64,47,56,62,57,60,67},54))
local List = v8:WaitForChild(_d({22,51,61,62},54))
local v9 = Main:WaitForChild(_d({30,57,58,30,43,44,61},54))
local UIGridLayout = List:WaitForChild(_d({31,19,17,60,51,46,22,43,67,57,63,62},54))
local UIPadding = List:WaitForChild(_d({31,19,26,43,46,46,51,56,49},54))
local v10 = v8:WaitForChild(_d({29,47,43,60,45,50},54))
local Input = v10:WaitForChild(_d({19,56,58,63,62},54))
local Clear = v10:WaitForChild(_d({13,54,47,43,60},54))
local ItemMenu = Main:WaitForChild(_d({19,62,47,55,23,47,56,63},54))
local Health = ItemMenu:WaitForChild(_d({18,47,43,54,62,50},54))
local Bar = Health:WaitForChild(_d({12,43,60},54))
local Equip = ItemMenu:WaitForChild(_d({15,59,63,51,58},54))
local Usage = Equip:WaitForChild(_d({31,61,43,49,47},54))
local Drop = ItemMenu:WaitForChild(_d({14,60,57,58},54))
local v11 = ItemMenu:WaitForChild(_d({23,51,61,45,12,63,62,62,57,56,61},54))
local Vanity = v11:WaitForChild(_d({32,43,56,51,62,67},54))
local CustomTailoredToggle = v11:WaitForChild(_d({13,63,61,62,57,55,30,43,51,54,57,60,47,46,30,57,49,49,54,47},54))
local SwordButtons = ItemMenu:WaitForChild(_d({29,65,57,60,46,12,63,62,62,57,56,61},54))
local Stats = ItemMenu:WaitForChild(_d({29,62,43,62,61},54))
local Boosts = Main:WaitForChild(_d({29,62,43,62,63,61,12,57,57,61,62,61},54)):WaitForChild(_d({12,57,57,61,62,61},54))
local v12 = Main:WaitForChild(_d({29,47,54,47,45,62,51,57,56,61},54))
local Frames = v12:WaitForChild(_d({16,60,43,55,47,61},54))
local RarityFilter = Main:WaitForChild(_d({28,43,60,51,62,67,16,51,54,62,47,60},54))
local Grips = Main:WaitForChild(_d({17,60,51,58,61},54))
local List_2 = Grips:WaitForChild(_d({22,51,61,62},54))
local LoadoutFrame = Main:WaitForChild(_d({22,57,43,46,57,63,62,16,60,43,55,47},54))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({15,56,43,44,54,47,46},54))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({32,51,61,51,44,54,47},54), Enabled)
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