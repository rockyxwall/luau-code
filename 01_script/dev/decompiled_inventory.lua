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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
game:GetService(_d({36,71,53,53,62,35,53,66,70,57,51,53},48))
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local HttpService = game:GetService(_d({24,68,68,64,35,53,66,70,57,51,53},48))
local RunService = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local Modules = ReplicatedStorage:WaitForChild(_d({29,63,52,69,60,53,67},48))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({36,63,63,60,20,53,67,51},48))
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
local Events = ReplicatedStorage:WaitForChild(_d({21,70,53,62,68,67},48))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({37,25,67},48))
local RarityGradient = require(UIs:WaitForChild(_d({34,49,66,57,68,73,23,66,49,52,57,53,62,68},48)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({32,60,49,73,53,66,23,69,57},48))
local Tools = ReplicatedStorage:WaitForChild(_d({36,63,63,60,67},48))
local Gradients = script:WaitForChild(_d({23,66,49,52,57,53,62,68,67},48))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({37,62,51,63,61,61,63,62},48)),
Rare = Gradients:WaitForChild(_d({34,49,66,53},48)),
Epic = Gradients:WaitForChild(_d({21,64,57,51},48)),
Legendary = Gradients:WaitForChild(_d({28,53,55,53,62,52,49,66,73},48)),
Mythical = Gradients:WaitForChild(_d({29,73,68,56,57,51,49,60},48)),
Collectable = Gradients:WaitForChild(_d({19,63,60,60,53,51,68,49,50,60,53},48)),
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
HP = {Display = _d({21,72,68,66,49,240,24,53,49,60,68,56},48), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({24,53,49,60,68,56,240,34,53,55,53,62},48), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({35,68,49,61,57,62,49,240,34,53,55,53,62},48), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({21,72,68,66,49,240,35,68,49,61,57,62,49},48), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({35,71,63,66,52,240,20,29,23,240,29,69,60,68},48), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({35,36,34,240,20,29,23,240,29,69,60,68},48), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({20,29,23,240,29,69,60,68,57,64,60,57,53,66},48), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({34,53,52,69,51,53,52,240,20,29,23},48), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({34,53,52,69,51,53,52,240,18,69,66,62},48), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({34,53,52,69,51,53,52,240,22,66,53,53,74,53},48), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({23,66,53,70,57,63,69,67,240,39,63,69,62,52,67},48), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({62,69,61,50,53,66},48) then
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
if v:IsA(_d({36,53,72,68,28,49,50,53,60},48)) then
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
ReplicatedStorage:WaitForChild(_d({66,53,67,53,66,70,53,52,19,63,52,53},48))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({35,68,49,68,67},48))
local v6 = StatsFolder:WaitForChild(_d({25,62,70,53,62,68,63,66,73},48))
local Inventory = v6:WaitForChild(_d({25,62,70,53,62,68,63,66,73},48))
local Equiped = v6:WaitForChild(_d({21,65,69,57,64,53,52},48))
local VanitySlots = v6:WaitForChild(_d({38,49,62,57,68,73,35,60,63,68,67},48))
local FightingStyle = v5:WaitForChild(_d({22,57,55,56,68,57,62,55,35,68,73,60,53},48))
local KatanaOrder = v6:WaitForChild(_d({27,49,68,49,62,49,31,66,52,53,66},48))
local EquipedShip = v6:WaitForChild(_d({21,65,69,57,64,53,52,35,56,57,64},48))
local v7 = StatsFolder:WaitForChild(_d({36,57,68,60,53,67},48))
local AllTitles = v7:WaitForChild(_d({17,60,60,36,57,68,60,53,67},48))
local EquipedTitle = v7:WaitForChild(_d({21,65,69,57,64,53,52,36,57,68,60,53},48))
local AutoEquip = StatsFolder:WaitForChild(_d({35,53,68,68,57,62,55,67},48)):WaitForChild(_d({17,69,68,63,21,65,69,57,64},48))
local EquipedGrip = StatsFolder:WaitForChild(_d({23,66,57,64,67},48)):WaitForChild(_d({21,65,69,57,64,53,52,23,66,57,64},48))
local Inventory_2 = PlayerGui:WaitForChild(_d({25,62,70,53,62,68,63,66,73},48), 360)
local Main = Inventory_2:WaitForChild(_d({29,49,57,62},48))
local v8 = Main:WaitForChild(_d({25,62,70,53,62,68,63,66,73},48))
local List = v8:WaitForChild(_d({28,57,67,68},48))
local v9 = Main:WaitForChild(_d({36,63,64,36,49,50,67},48))
local UIGridLayout = List:WaitForChild(_d({37,25,23,66,57,52,28,49,73,63,69,68},48))
local UIPadding = List:WaitForChild(_d({37,25,32,49,52,52,57,62,55},48))
local v10 = v8:WaitForChild(_d({35,53,49,66,51,56},48))
local Input = v10:WaitForChild(_d({25,62,64,69,68},48))
local Clear = v10:WaitForChild(_d({19,60,53,49,66},48))
local ItemMenu = Main:WaitForChild(_d({25,68,53,61,29,53,62,69},48))
local Health = ItemMenu:WaitForChild(_d({24,53,49,60,68,56},48))
local Bar = Health:WaitForChild(_d({18,49,66},48))
local Equip = ItemMenu:WaitForChild(_d({21,65,69,57,64},48))
local Usage = Equip:WaitForChild(_d({37,67,49,55,53},48))
local Drop = ItemMenu:WaitForChild(_d({20,66,63,64},48))
local v11 = ItemMenu:WaitForChild(_d({29,57,67,51,18,69,68,68,63,62,67},48))
local Vanity = v11:WaitForChild(_d({38,49,62,57,68,73},48))
local CustomTailoredToggle = v11:WaitForChild(_d({19,69,67,68,63,61,36,49,57,60,63,66,53,52,36,63,55,55,60,53},48))
local SwordButtons = ItemMenu:WaitForChild(_d({35,71,63,66,52,18,69,68,68,63,62,67},48))
local Stats = ItemMenu:WaitForChild(_d({35,68,49,68,67},48))
local Boosts = Main:WaitForChild(_d({35,68,49,68,69,67,18,63,63,67,68,67},48)):WaitForChild(_d({18,63,63,67,68,67},48))
local v12 = Main:WaitForChild(_d({35,53,60,53,51,68,57,63,62,67},48))
local Frames = v12:WaitForChild(_d({22,66,49,61,53,67},48))
local RarityFilter = Main:WaitForChild(_d({34,49,66,57,68,73,22,57,60,68,53,66},48))
local Grips = Main:WaitForChild(_d({23,66,57,64,67},48))
local List_2 = Grips:WaitForChild(_d({28,57,67,68},48))
local LoadoutFrame = Main:WaitForChild(_d({28,63,49,52,63,69,68,22,66,49,61,53},48))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({21,62,49,50,60,53,52},48))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({38,57,67,57,50,60,53},48), Enabled)
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