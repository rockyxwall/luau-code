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
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
game:GetService(_d({62,97,79,79,88,61,79,92,96,83,77,79},22))
local UserInputService = game:GetService(_d({63,93,79,92,51,88,90,95,94,61,79,92,96,83,77,79},22))
local HttpService = game:GetService(_d({50,94,94,90,61,79,92,96,83,77,79},22))
local RunService = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local ReplicatedStorage = game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
local Modules = ReplicatedStorage:WaitForChild(_d({55,89,78,95,86,79,93},22))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({62,89,89,86,46,79,93,77},22))
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
local Events = ReplicatedStorage:WaitForChild(_d({47,96,79,88,94,93},22))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({63,51,93},22))
local RarityGradient = require(UIs:WaitForChild(_d({60,75,92,83,94,99,49,92,75,78,83,79,88,94},22)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({58,86,75,99,79,92,49,95,83},22))
local Tools = ReplicatedStorage:WaitForChild(_d({62,89,89,86,93},22))
local Gradients = script:WaitForChild(_d({49,92,75,78,83,79,88,94,93},22))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({63,88,77,89,87,87,89,88},22)),
Rare = Gradients:WaitForChild(_d({60,75,92,79},22)),
Epic = Gradients:WaitForChild(_d({47,90,83,77},22)),
Legendary = Gradients:WaitForChild(_d({54,79,81,79,88,78,75,92,99},22)),
Mythical = Gradients:WaitForChild(_d({55,99,94,82,83,77,75,86},22)),
Collectable = Gradients:WaitForChild(_d({45,89,86,86,79,77,94,75,76,86,79},22)),
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
HP = {Display = _d({47,98,94,92,75,10,50,79,75,86,94,82},22), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({50,79,75,86,94,82,10,60,79,81,79,88},22), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({61,94,75,87,83,88,75,10,60,79,81,79,88},22), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({47,98,94,92,75,10,61,94,75,87,83,88,75},22), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({61,97,89,92,78,10,46,55,49,10,55,95,86,94},22), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({61,62,60,10,46,55,49,10,55,95,86,94},22), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({46,55,49,10,55,95,86,94,83,90,86,83,79,92},22), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({60,79,78,95,77,79,78,10,46,55,49},22), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({60,79,78,95,77,79,78,10,44,95,92,88},22), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({60,79,78,95,77,79,78,10,48,92,79,79,100,79},22), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({49,92,79,96,83,89,95,93,10,65,89,95,88,78,93},22), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({88,95,87,76,79,92},22) then
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
if v:IsA(_d({62,79,98,94,54,75,76,79,86},22)) then
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
ReplicatedStorage:WaitForChild(_d({92,79,93,79,92,96,79,78,45,89,78,79},22))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({61,94,75,94,93},22))
local v6 = StatsFolder:WaitForChild(_d({51,88,96,79,88,94,89,92,99},22))
local Inventory = v6:WaitForChild(_d({51,88,96,79,88,94,89,92,99},22))
local Equiped = v6:WaitForChild(_d({47,91,95,83,90,79,78},22))
local VanitySlots = v6:WaitForChild(_d({64,75,88,83,94,99,61,86,89,94,93},22))
local FightingStyle = v5:WaitForChild(_d({48,83,81,82,94,83,88,81,61,94,99,86,79},22))
local KatanaOrder = v6:WaitForChild(_d({53,75,94,75,88,75,57,92,78,79,92},22))
local EquipedShip = v6:WaitForChild(_d({47,91,95,83,90,79,78,61,82,83,90},22))
local v7 = StatsFolder:WaitForChild(_d({62,83,94,86,79,93},22))
local AllTitles = v7:WaitForChild(_d({43,86,86,62,83,94,86,79,93},22))
local EquipedTitle = v7:WaitForChild(_d({47,91,95,83,90,79,78,62,83,94,86,79},22))
local AutoEquip = StatsFolder:WaitForChild(_d({61,79,94,94,83,88,81,93},22)):WaitForChild(_d({43,95,94,89,47,91,95,83,90},22))
local EquipedGrip = StatsFolder:WaitForChild(_d({49,92,83,90,93},22)):WaitForChild(_d({47,91,95,83,90,79,78,49,92,83,90},22))
local Inventory_2 = PlayerGui:WaitForChild(_d({51,88,96,79,88,94,89,92,99},22), 360)
local Main = Inventory_2:WaitForChild(_d({55,75,83,88},22))
local v8 = Main:WaitForChild(_d({51,88,96,79,88,94,89,92,99},22))
local List = v8:WaitForChild(_d({54,83,93,94},22))
local v9 = Main:WaitForChild(_d({62,89,90,62,75,76,93},22))
local UIGridLayout = List:WaitForChild(_d({63,51,49,92,83,78,54,75,99,89,95,94},22))
local UIPadding = List:WaitForChild(_d({63,51,58,75,78,78,83,88,81},22))
local v10 = v8:WaitForChild(_d({61,79,75,92,77,82},22))
local Input = v10:WaitForChild(_d({51,88,90,95,94},22))
local Clear = v10:WaitForChild(_d({45,86,79,75,92},22))
local ItemMenu = Main:WaitForChild(_d({51,94,79,87,55,79,88,95},22))
local Health = ItemMenu:WaitForChild(_d({50,79,75,86,94,82},22))
local Bar = Health:WaitForChild(_d({44,75,92},22))
local Equip = ItemMenu:WaitForChild(_d({47,91,95,83,90},22))
local Usage = Equip:WaitForChild(_d({63,93,75,81,79},22))
local Drop = ItemMenu:WaitForChild(_d({46,92,89,90},22))
local v11 = ItemMenu:WaitForChild(_d({55,83,93,77,44,95,94,94,89,88,93},22))
local Vanity = v11:WaitForChild(_d({64,75,88,83,94,99},22))
local CustomTailoredToggle = v11:WaitForChild(_d({45,95,93,94,89,87,62,75,83,86,89,92,79,78,62,89,81,81,86,79},22))
local SwordButtons = ItemMenu:WaitForChild(_d({61,97,89,92,78,44,95,94,94,89,88,93},22))
local Stats = ItemMenu:WaitForChild(_d({61,94,75,94,93},22))
local Boosts = Main:WaitForChild(_d({61,94,75,94,95,93,44,89,89,93,94,93},22)):WaitForChild(_d({44,89,89,93,94,93},22))
local v12 = Main:WaitForChild(_d({61,79,86,79,77,94,83,89,88,93},22))
local Frames = v12:WaitForChild(_d({48,92,75,87,79,93},22))
local RarityFilter = Main:WaitForChild(_d({60,75,92,83,94,99,48,83,86,94,79,92},22))
local Grips = Main:WaitForChild(_d({49,92,83,90,93},22))
local List_2 = Grips:WaitForChild(_d({54,83,93,94},22))
local LoadoutFrame = Main:WaitForChild(_d({54,89,75,78,89,95,94,48,92,75,87,79},22))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({47,88,75,76,86,79,78},22))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({64,83,93,83,76,86,79},22), Enabled)
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