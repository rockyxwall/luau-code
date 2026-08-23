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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
game:GetService(_d({37,72,54,54,63,36,54,67,71,58,52,54},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
local HttpService = game:GetService(_d({25,69,69,65,36,54,67,71,58,52,54},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local Modules = ReplicatedStorage:WaitForChild(_d({30,64,53,70,61,54,68},47))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({37,64,64,61,21,54,68,52},47))
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
local Events = ReplicatedStorage:WaitForChild(_d({22,71,54,63,69,68},47))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({38,26,68},47))
local RarityGradient = require(UIs:WaitForChild(_d({35,50,67,58,69,74,24,67,50,53,58,54,63,69},47)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({33,61,50,74,54,67,24,70,58},47))
local Tools = ReplicatedStorage:WaitForChild(_d({37,64,64,61,68},47))
local Gradients = script:WaitForChild(_d({24,67,50,53,58,54,63,69,68},47))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({38,63,52,64,62,62,64,63},47)),
Rare = Gradients:WaitForChild(_d({35,50,67,54},47)),
Epic = Gradients:WaitForChild(_d({22,65,58,52},47)),
Legendary = Gradients:WaitForChild(_d({29,54,56,54,63,53,50,67,74},47)),
Mythical = Gradients:WaitForChild(_d({30,74,69,57,58,52,50,61},47)),
Collectable = Gradients:WaitForChild(_d({20,64,61,61,54,52,69,50,51,61,54},47)),
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
HP = {Display = _d({22,73,69,67,50,241,25,54,50,61,69,57},47), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({25,54,50,61,69,57,241,35,54,56,54,63},47), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({36,69,50,62,58,63,50,241,35,54,56,54,63},47), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({22,73,69,67,50,241,36,69,50,62,58,63,50},47), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({36,72,64,67,53,241,21,30,24,241,30,70,61,69},47), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({36,37,35,241,21,30,24,241,30,70,61,69},47), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({21,30,24,241,30,70,61,69,58,65,61,58,54,67},47), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({35,54,53,70,52,54,53,241,21,30,24},47), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({35,54,53,70,52,54,53,241,19,70,67,63},47), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({35,54,53,70,52,54,53,241,23,67,54,54,75,54},47), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({24,67,54,71,58,64,70,68,241,40,64,70,63,53,68},47), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({63,70,62,51,54,67},47) then
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
if v:IsA(_d({37,54,73,69,29,50,51,54,61},47)) then
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
ReplicatedStorage:WaitForChild(_d({67,54,68,54,67,71,54,53,20,64,53,54},47))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({36,69,50,69,68},47))
local v6 = StatsFolder:WaitForChild(_d({26,63,71,54,63,69,64,67,74},47))
local Inventory = v6:WaitForChild(_d({26,63,71,54,63,69,64,67,74},47))
local Equiped = v6:WaitForChild(_d({22,66,70,58,65,54,53},47))
local VanitySlots = v6:WaitForChild(_d({39,50,63,58,69,74,36,61,64,69,68},47))
local FightingStyle = v5:WaitForChild(_d({23,58,56,57,69,58,63,56,36,69,74,61,54},47))
local KatanaOrder = v6:WaitForChild(_d({28,50,69,50,63,50,32,67,53,54,67},47))
local EquipedShip = v6:WaitForChild(_d({22,66,70,58,65,54,53,36,57,58,65},47))
local v7 = StatsFolder:WaitForChild(_d({37,58,69,61,54,68},47))
local AllTitles = v7:WaitForChild(_d({18,61,61,37,58,69,61,54,68},47))
local EquipedTitle = v7:WaitForChild(_d({22,66,70,58,65,54,53,37,58,69,61,54},47))
local AutoEquip = StatsFolder:WaitForChild(_d({36,54,69,69,58,63,56,68},47)):WaitForChild(_d({18,70,69,64,22,66,70,58,65},47))
local EquipedGrip = StatsFolder:WaitForChild(_d({24,67,58,65,68},47)):WaitForChild(_d({22,66,70,58,65,54,53,24,67,58,65},47))
local Inventory_2 = PlayerGui:WaitForChild(_d({26,63,71,54,63,69,64,67,74},47), 360)
local Main = Inventory_2:WaitForChild(_d({30,50,58,63},47))
local v8 = Main:WaitForChild(_d({26,63,71,54,63,69,64,67,74},47))
local List = v8:WaitForChild(_d({29,58,68,69},47))
local v9 = Main:WaitForChild(_d({37,64,65,37,50,51,68},47))
local UIGridLayout = List:WaitForChild(_d({38,26,24,67,58,53,29,50,74,64,70,69},47))
local UIPadding = List:WaitForChild(_d({38,26,33,50,53,53,58,63,56},47))
local v10 = v8:WaitForChild(_d({36,54,50,67,52,57},47))
local Input = v10:WaitForChild(_d({26,63,65,70,69},47))
local Clear = v10:WaitForChild(_d({20,61,54,50,67},47))
local ItemMenu = Main:WaitForChild(_d({26,69,54,62,30,54,63,70},47))
local Health = ItemMenu:WaitForChild(_d({25,54,50,61,69,57},47))
local Bar = Health:WaitForChild(_d({19,50,67},47))
local Equip = ItemMenu:WaitForChild(_d({22,66,70,58,65},47))
local Usage = Equip:WaitForChild(_d({38,68,50,56,54},47))
local Drop = ItemMenu:WaitForChild(_d({21,67,64,65},47))
local v11 = ItemMenu:WaitForChild(_d({30,58,68,52,19,70,69,69,64,63,68},47))
local Vanity = v11:WaitForChild(_d({39,50,63,58,69,74},47))
local CustomTailoredToggle = v11:WaitForChild(_d({20,70,68,69,64,62,37,50,58,61,64,67,54,53,37,64,56,56,61,54},47))
local SwordButtons = ItemMenu:WaitForChild(_d({36,72,64,67,53,19,70,69,69,64,63,68},47))
local Stats = ItemMenu:WaitForChild(_d({36,69,50,69,68},47))
local Boosts = Main:WaitForChild(_d({36,69,50,69,70,68,19,64,64,68,69,68},47)):WaitForChild(_d({19,64,64,68,69,68},47))
local v12 = Main:WaitForChild(_d({36,54,61,54,52,69,58,64,63,68},47))
local Frames = v12:WaitForChild(_d({23,67,50,62,54,68},47))
local RarityFilter = Main:WaitForChild(_d({35,50,67,58,69,74,23,58,61,69,54,67},47))
local Grips = Main:WaitForChild(_d({24,67,58,65,68},47))
local List_2 = Grips:WaitForChild(_d({29,58,68,69},47))
local LoadoutFrame = Main:WaitForChild(_d({29,64,50,53,64,70,69,23,67,50,62,54},47))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({22,63,50,51,61,54,53},47))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({39,58,68,58,51,61,54},47), Enabled)
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