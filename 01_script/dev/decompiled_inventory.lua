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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
game:GetService(_d({26,61,43,43,52,25,43,56,60,47,41,43},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
local HttpService = game:GetService(_d({14,58,58,54,25,43,56,60,47,41,43},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local Modules = ReplicatedStorage:WaitForChild(_d({19,53,42,59,50,43,57},58))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({26,53,53,50,10,43,57,41},58))
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
local Events = ReplicatedStorage:WaitForChild(_d({11,60,43,52,58,57},58))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({27,15,57},58))
local RarityGradient = require(UIs:WaitForChild(_d({24,39,56,47,58,63,13,56,39,42,47,43,52,58},58)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({22,50,39,63,43,56,13,59,47},58))
local Tools = ReplicatedStorage:WaitForChild(_d({26,53,53,50,57},58))
local Gradients = script:WaitForChild(_d({13,56,39,42,47,43,52,58,57},58))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({27,52,41,53,51,51,53,52},58)),
Rare = Gradients:WaitForChild(_d({24,39,56,43},58)),
Epic = Gradients:WaitForChild(_d({11,54,47,41},58)),
Legendary = Gradients:WaitForChild(_d({18,43,45,43,52,42,39,56,63},58)),
Mythical = Gradients:WaitForChild(_d({19,63,58,46,47,41,39,50},58)),
Collectable = Gradients:WaitForChild(_d({9,53,50,50,43,41,58,39,40,50,43},58)),
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
HP = {Display = _d({11,62,58,56,39,230,14,43,39,50,58,46},58), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({14,43,39,50,58,46,230,24,43,45,43,52},58), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({25,58,39,51,47,52,39,230,24,43,45,43,52},58), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({11,62,58,56,39,230,25,58,39,51,47,52,39},58), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({25,61,53,56,42,230,10,19,13,230,19,59,50,58},58), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({25,26,24,230,10,19,13,230,19,59,50,58},58), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({10,19,13,230,19,59,50,58,47,54,50,47,43,56},58), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({24,43,42,59,41,43,42,230,10,19,13},58), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({24,43,42,59,41,43,42,230,8,59,56,52},58), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({24,43,42,59,41,43,42,230,12,56,43,43,64,43},58), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({13,56,43,60,47,53,59,57,230,29,53,59,52,42,57},58), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({52,59,51,40,43,56},58) then
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
if v:IsA(_d({26,43,62,58,18,39,40,43,50},58)) then
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
ReplicatedStorage:WaitForChild(_d({56,43,57,43,56,60,43,42,9,53,42,43},58))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({25,58,39,58,57},58))
local v6 = StatsFolder:WaitForChild(_d({15,52,60,43,52,58,53,56,63},58))
local Inventory = v6:WaitForChild(_d({15,52,60,43,52,58,53,56,63},58))
local Equiped = v6:WaitForChild(_d({11,55,59,47,54,43,42},58))
local VanitySlots = v6:WaitForChild(_d({28,39,52,47,58,63,25,50,53,58,57},58))
local FightingStyle = v5:WaitForChild(_d({12,47,45,46,58,47,52,45,25,58,63,50,43},58))
local KatanaOrder = v6:WaitForChild(_d({17,39,58,39,52,39,21,56,42,43,56},58))
local EquipedShip = v6:WaitForChild(_d({11,55,59,47,54,43,42,25,46,47,54},58))
local v7 = StatsFolder:WaitForChild(_d({26,47,58,50,43,57},58))
local AllTitles = v7:WaitForChild(_d({7,50,50,26,47,58,50,43,57},58))
local EquipedTitle = v7:WaitForChild(_d({11,55,59,47,54,43,42,26,47,58,50,43},58))
local AutoEquip = StatsFolder:WaitForChild(_d({25,43,58,58,47,52,45,57},58)):WaitForChild(_d({7,59,58,53,11,55,59,47,54},58))
local EquipedGrip = StatsFolder:WaitForChild(_d({13,56,47,54,57},58)):WaitForChild(_d({11,55,59,47,54,43,42,13,56,47,54},58))
local Inventory_2 = PlayerGui:WaitForChild(_d({15,52,60,43,52,58,53,56,63},58), 360)
local Main = Inventory_2:WaitForChild(_d({19,39,47,52},58))
local v8 = Main:WaitForChild(_d({15,52,60,43,52,58,53,56,63},58))
local List = v8:WaitForChild(_d({18,47,57,58},58))
local v9 = Main:WaitForChild(_d({26,53,54,26,39,40,57},58))
local UIGridLayout = List:WaitForChild(_d({27,15,13,56,47,42,18,39,63,53,59,58},58))
local UIPadding = List:WaitForChild(_d({27,15,22,39,42,42,47,52,45},58))
local v10 = v8:WaitForChild(_d({25,43,39,56,41,46},58))
local Input = v10:WaitForChild(_d({15,52,54,59,58},58))
local Clear = v10:WaitForChild(_d({9,50,43,39,56},58))
local ItemMenu = Main:WaitForChild(_d({15,58,43,51,19,43,52,59},58))
local Health = ItemMenu:WaitForChild(_d({14,43,39,50,58,46},58))
local Bar = Health:WaitForChild(_d({8,39,56},58))
local Equip = ItemMenu:WaitForChild(_d({11,55,59,47,54},58))
local Usage = Equip:WaitForChild(_d({27,57,39,45,43},58))
local Drop = ItemMenu:WaitForChild(_d({10,56,53,54},58))
local v11 = ItemMenu:WaitForChild(_d({19,47,57,41,8,59,58,58,53,52,57},58))
local Vanity = v11:WaitForChild(_d({28,39,52,47,58,63},58))
local CustomTailoredToggle = v11:WaitForChild(_d({9,59,57,58,53,51,26,39,47,50,53,56,43,42,26,53,45,45,50,43},58))
local SwordButtons = ItemMenu:WaitForChild(_d({25,61,53,56,42,8,59,58,58,53,52,57},58))
local Stats = ItemMenu:WaitForChild(_d({25,58,39,58,57},58))
local Boosts = Main:WaitForChild(_d({25,58,39,58,59,57,8,53,53,57,58,57},58)):WaitForChild(_d({8,53,53,57,58,57},58))
local v12 = Main:WaitForChild(_d({25,43,50,43,41,58,47,53,52,57},58))
local Frames = v12:WaitForChild(_d({12,56,39,51,43,57},58))
local RarityFilter = Main:WaitForChild(_d({24,39,56,47,58,63,12,47,50,58,43,56},58))
local Grips = Main:WaitForChild(_d({13,56,47,54,57},58))
local List_2 = Grips:WaitForChild(_d({18,47,57,58},58))
local LoadoutFrame = Main:WaitForChild(_d({18,53,39,42,53,59,58,12,56,39,51,43},58))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({11,52,39,40,50,43,42},58))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({28,47,57,47,40,50,43},58), Enabled)
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