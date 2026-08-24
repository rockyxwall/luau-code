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
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
game:GetService(_d({67,102,84,84,93,66,84,97,101,88,82,84},17))
local UserInputService = game:GetService(_d({68,98,84,97,56,93,95,100,99,66,84,97,101,88,82,84},17))
local HttpService = game:GetService(_d({55,99,99,95,66,84,97,101,88,82,84},17))
local RunService = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17))
local ReplicatedStorage = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local Modules = ReplicatedStorage:WaitForChild(_d({60,94,83,100,91,84,98},17))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({67,94,94,91,51,84,98,82},17))
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
local Events = ReplicatedStorage:WaitForChild(_d({52,101,84,93,99,98},17))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({68,56,98},17))
local RarityGradient = require(UIs:WaitForChild(_d({65,80,97,88,99,104,54,97,80,83,88,84,93,99},17)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({63,91,80,104,84,97,54,100,88},17))
local Tools = ReplicatedStorage:WaitForChild(_d({67,94,94,91,98},17))
local Gradients = script:WaitForChild(_d({54,97,80,83,88,84,93,99,98},17))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({68,93,82,94,92,92,94,93},17)),
Rare = Gradients:WaitForChild(_d({65,80,97,84},17)),
Epic = Gradients:WaitForChild(_d({52,95,88,82},17)),
Legendary = Gradients:WaitForChild(_d({59,84,86,84,93,83,80,97,104},17)),
Mythical = Gradients:WaitForChild(_d({60,104,99,87,88,82,80,91},17)),
Collectable = Gradients:WaitForChild(_d({50,94,91,91,84,82,99,80,81,91,84},17)),
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
HP = {Display = _d({52,103,99,97,80,15,55,84,80,91,99,87},17), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({55,84,80,91,99,87,15,65,84,86,84,93},17), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({66,99,80,92,88,93,80,15,65,84,86,84,93},17), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({52,103,99,97,80,15,66,99,80,92,88,93,80},17), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({66,102,94,97,83,15,51,60,54,15,60,100,91,99},17), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({66,67,65,15,51,60,54,15,60,100,91,99},17), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({51,60,54,15,60,100,91,99,88,95,91,88,84,97},17), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({65,84,83,100,82,84,83,15,51,60,54},17), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({65,84,83,100,82,84,83,15,49,100,97,93},17), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({65,84,83,100,82,84,83,15,53,97,84,84,105,84},17), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({54,97,84,101,88,94,100,98,15,70,94,100,93,83,98},17), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({93,100,92,81,84,97},17) then
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
if v:IsA(_d({67,84,103,99,59,80,81,84,91},17)) then
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
ReplicatedStorage:WaitForChild(_d({97,84,98,84,97,101,84,83,50,94,83,84},17))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({66,99,80,99,98},17))
local v6 = StatsFolder:WaitForChild(_d({56,93,101,84,93,99,94,97,104},17))
local Inventory = v6:WaitForChild(_d({56,93,101,84,93,99,94,97,104},17))
local Equiped = v6:WaitForChild(_d({52,96,100,88,95,84,83},17))
local VanitySlots = v6:WaitForChild(_d({69,80,93,88,99,104,66,91,94,99,98},17))
local FightingStyle = v5:WaitForChild(_d({53,88,86,87,99,88,93,86,66,99,104,91,84},17))
local KatanaOrder = v6:WaitForChild(_d({58,80,99,80,93,80,62,97,83,84,97},17))
local EquipedShip = v6:WaitForChild(_d({52,96,100,88,95,84,83,66,87,88,95},17))
local v7 = StatsFolder:WaitForChild(_d({67,88,99,91,84,98},17))
local AllTitles = v7:WaitForChild(_d({48,91,91,67,88,99,91,84,98},17))
local EquipedTitle = v7:WaitForChild(_d({52,96,100,88,95,84,83,67,88,99,91,84},17))
local AutoEquip = StatsFolder:WaitForChild(_d({66,84,99,99,88,93,86,98},17)):WaitForChild(_d({48,100,99,94,52,96,100,88,95},17))
local EquipedGrip = StatsFolder:WaitForChild(_d({54,97,88,95,98},17)):WaitForChild(_d({52,96,100,88,95,84,83,54,97,88,95},17))
local Inventory_2 = PlayerGui:WaitForChild(_d({56,93,101,84,93,99,94,97,104},17), 360)
local Main = Inventory_2:WaitForChild(_d({60,80,88,93},17))
local v8 = Main:WaitForChild(_d({56,93,101,84,93,99,94,97,104},17))
local List = v8:WaitForChild(_d({59,88,98,99},17))
local v9 = Main:WaitForChild(_d({67,94,95,67,80,81,98},17))
local UIGridLayout = List:WaitForChild(_d({68,56,54,97,88,83,59,80,104,94,100,99},17))
local UIPadding = List:WaitForChild(_d({68,56,63,80,83,83,88,93,86},17))
local v10 = v8:WaitForChild(_d({66,84,80,97,82,87},17))
local Input = v10:WaitForChild(_d({56,93,95,100,99},17))
local Clear = v10:WaitForChild(_d({50,91,84,80,97},17))
local ItemMenu = Main:WaitForChild(_d({56,99,84,92,60,84,93,100},17))
local Health = ItemMenu:WaitForChild(_d({55,84,80,91,99,87},17))
local Bar = Health:WaitForChild(_d({49,80,97},17))
local Equip = ItemMenu:WaitForChild(_d({52,96,100,88,95},17))
local Usage = Equip:WaitForChild(_d({68,98,80,86,84},17))
local Drop = ItemMenu:WaitForChild(_d({51,97,94,95},17))
local v11 = ItemMenu:WaitForChild(_d({60,88,98,82,49,100,99,99,94,93,98},17))
local Vanity = v11:WaitForChild(_d({69,80,93,88,99,104},17))
local CustomTailoredToggle = v11:WaitForChild(_d({50,100,98,99,94,92,67,80,88,91,94,97,84,83,67,94,86,86,91,84},17))
local SwordButtons = ItemMenu:WaitForChild(_d({66,102,94,97,83,49,100,99,99,94,93,98},17))
local Stats = ItemMenu:WaitForChild(_d({66,99,80,99,98},17))
local Boosts = Main:WaitForChild(_d({66,99,80,99,100,98,49,94,94,98,99,98},17)):WaitForChild(_d({49,94,94,98,99,98},17))
local v12 = Main:WaitForChild(_d({66,84,91,84,82,99,88,94,93,98},17))
local Frames = v12:WaitForChild(_d({53,97,80,92,84,98},17))
local RarityFilter = Main:WaitForChild(_d({65,80,97,88,99,104,53,88,91,99,84,97},17))
local Grips = Main:WaitForChild(_d({54,97,88,95,98},17))
local List_2 = Grips:WaitForChild(_d({59,88,98,99},17))
local LoadoutFrame = Main:WaitForChild(_d({59,94,80,83,94,100,99,53,97,80,92,84},17))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({52,93,80,81,91,84,83},17))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({69,88,98,88,81,91,84},17), Enabled)
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