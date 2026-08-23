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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
game:GetService(_d({60,95,77,77,86,59,77,90,94,81,75,77},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
local HttpService = game:GetService(_d({48,92,92,88,59,77,90,94,81,75,77},24))
local RunService = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local Modules = ReplicatedStorage:WaitForChild(_d({53,87,76,93,84,77,91},24))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({60,87,87,84,44,77,91,75},24))
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
local Events = ReplicatedStorage:WaitForChild(_d({45,94,77,86,92,91},24))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({61,49,91},24))
local RarityGradient = require(UIs:WaitForChild(_d({58,73,90,81,92,97,47,90,73,76,81,77,86,92},24)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({56,84,73,97,77,90,47,93,81},24))
local Tools = ReplicatedStorage:WaitForChild(_d({60,87,87,84,91},24))
local Gradients = script:WaitForChild(_d({47,90,73,76,81,77,86,92,91},24))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({61,86,75,87,85,85,87,86},24)),
Rare = Gradients:WaitForChild(_d({58,73,90,77},24)),
Epic = Gradients:WaitForChild(_d({45,88,81,75},24)),
Legendary = Gradients:WaitForChild(_d({52,77,79,77,86,76,73,90,97},24)),
Mythical = Gradients:WaitForChild(_d({53,97,92,80,81,75,73,84},24)),
Collectable = Gradients:WaitForChild(_d({43,87,84,84,77,75,92,73,74,84,77},24)),
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
HP = {Display = _d({45,96,92,90,73,8,48,77,73,84,92,80},24), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({48,77,73,84,92,80,8,58,77,79,77,86},24), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({59,92,73,85,81,86,73,8,58,77,79,77,86},24), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({45,96,92,90,73,8,59,92,73,85,81,86,73},24), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({59,95,87,90,76,8,44,53,47,8,53,93,84,92},24), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({59,60,58,8,44,53,47,8,53,93,84,92},24), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({44,53,47,8,53,93,84,92,81,88,84,81,77,90},24), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({58,77,76,93,75,77,76,8,44,53,47},24), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({58,77,76,93,75,77,76,8,42,93,90,86},24), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({58,77,76,93,75,77,76,8,46,90,77,77,98,77},24), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({47,90,77,94,81,87,93,91,8,63,87,93,86,76,91},24), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({86,93,85,74,77,90},24) then
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
if v:IsA(_d({60,77,96,92,52,73,74,77,84},24)) then
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
ReplicatedStorage:WaitForChild(_d({90,77,91,77,90,94,77,76,43,87,76,77},24))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({59,92,73,92,91},24))
local v6 = StatsFolder:WaitForChild(_d({49,86,94,77,86,92,87,90,97},24))
local Inventory = v6:WaitForChild(_d({49,86,94,77,86,92,87,90,97},24))
local Equiped = v6:WaitForChild(_d({45,89,93,81,88,77,76},24))
local VanitySlots = v6:WaitForChild(_d({62,73,86,81,92,97,59,84,87,92,91},24))
local FightingStyle = v5:WaitForChild(_d({46,81,79,80,92,81,86,79,59,92,97,84,77},24))
local KatanaOrder = v6:WaitForChild(_d({51,73,92,73,86,73,55,90,76,77,90},24))
local EquipedShip = v6:WaitForChild(_d({45,89,93,81,88,77,76,59,80,81,88},24))
local v7 = StatsFolder:WaitForChild(_d({60,81,92,84,77,91},24))
local AllTitles = v7:WaitForChild(_d({41,84,84,60,81,92,84,77,91},24))
local EquipedTitle = v7:WaitForChild(_d({45,89,93,81,88,77,76,60,81,92,84,77},24))
local AutoEquip = StatsFolder:WaitForChild(_d({59,77,92,92,81,86,79,91},24)):WaitForChild(_d({41,93,92,87,45,89,93,81,88},24))
local EquipedGrip = StatsFolder:WaitForChild(_d({47,90,81,88,91},24)):WaitForChild(_d({45,89,93,81,88,77,76,47,90,81,88},24))
local Inventory_2 = PlayerGui:WaitForChild(_d({49,86,94,77,86,92,87,90,97},24), 360)
local Main = Inventory_2:WaitForChild(_d({53,73,81,86},24))
local v8 = Main:WaitForChild(_d({49,86,94,77,86,92,87,90,97},24))
local List = v8:WaitForChild(_d({52,81,91,92},24))
local v9 = Main:WaitForChild(_d({60,87,88,60,73,74,91},24))
local UIGridLayout = List:WaitForChild(_d({61,49,47,90,81,76,52,73,97,87,93,92},24))
local UIPadding = List:WaitForChild(_d({61,49,56,73,76,76,81,86,79},24))
local v10 = v8:WaitForChild(_d({59,77,73,90,75,80},24))
local Input = v10:WaitForChild(_d({49,86,88,93,92},24))
local Clear = v10:WaitForChild(_d({43,84,77,73,90},24))
local ItemMenu = Main:WaitForChild(_d({49,92,77,85,53,77,86,93},24))
local Health = ItemMenu:WaitForChild(_d({48,77,73,84,92,80},24))
local Bar = Health:WaitForChild(_d({42,73,90},24))
local Equip = ItemMenu:WaitForChild(_d({45,89,93,81,88},24))
local Usage = Equip:WaitForChild(_d({61,91,73,79,77},24))
local Drop = ItemMenu:WaitForChild(_d({44,90,87,88},24))
local v11 = ItemMenu:WaitForChild(_d({53,81,91,75,42,93,92,92,87,86,91},24))
local Vanity = v11:WaitForChild(_d({62,73,86,81,92,97},24))
local CustomTailoredToggle = v11:WaitForChild(_d({43,93,91,92,87,85,60,73,81,84,87,90,77,76,60,87,79,79,84,77},24))
local SwordButtons = ItemMenu:WaitForChild(_d({59,95,87,90,76,42,93,92,92,87,86,91},24))
local Stats = ItemMenu:WaitForChild(_d({59,92,73,92,91},24))
local Boosts = Main:WaitForChild(_d({59,92,73,92,93,91,42,87,87,91,92,91},24)):WaitForChild(_d({42,87,87,91,92,91},24))
local v12 = Main:WaitForChild(_d({59,77,84,77,75,92,81,87,86,91},24))
local Frames = v12:WaitForChild(_d({46,90,73,85,77,91},24))
local RarityFilter = Main:WaitForChild(_d({58,73,90,81,92,97,46,81,84,92,77,90},24))
local Grips = Main:WaitForChild(_d({47,90,81,88,91},24))
local List_2 = Grips:WaitForChild(_d({52,81,91,92},24))
local LoadoutFrame = Main:WaitForChild(_d({52,87,73,76,87,93,92,46,90,73,85,77},24))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({45,86,73,74,84,77,76},24))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({62,81,91,81,74,84,77},24), Enabled)
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