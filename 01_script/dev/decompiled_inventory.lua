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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
game:GetService(_d({51,86,68,68,77,50,68,81,85,72,66,68},33))
local UserInputService = game:GetService(_d({52,82,68,81,40,77,79,84,83,50,68,81,85,72,66,68},33))
local HttpService = game:GetService(_d({39,83,83,79,50,68,81,85,72,66,68},33))
local RunService = game:GetService(_d({49,84,77,50,68,81,85,72,66,68},33))
local ReplicatedStorage = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local Modules = ReplicatedStorage:WaitForChild(_d({44,78,67,84,75,68,82},33))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({51,78,78,75,35,68,82,66},33))
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
local Events = ReplicatedStorage:WaitForChild(_d({36,85,68,77,83,82},33))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({52,40,82},33))
local RarityGradient = require(UIs:WaitForChild(_d({49,64,81,72,83,88,38,81,64,67,72,68,77,83},33)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({47,75,64,88,68,81,38,84,72},33))
local Tools = ReplicatedStorage:WaitForChild(_d({51,78,78,75,82},33))
local Gradients = script:WaitForChild(_d({38,81,64,67,72,68,77,83,82},33))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({52,77,66,78,76,76,78,77},33)),
Rare = Gradients:WaitForChild(_d({49,64,81,68},33)),
Epic = Gradients:WaitForChild(_d({36,79,72,66},33)),
Legendary = Gradients:WaitForChild(_d({43,68,70,68,77,67,64,81,88},33)),
Mythical = Gradients:WaitForChild(_d({44,88,83,71,72,66,64,75},33)),
Collectable = Gradients:WaitForChild(_d({34,78,75,75,68,66,83,64,65,75,68},33)),
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
HP = {Display = _d({36,87,83,81,64,255,39,68,64,75,83,71},33), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({39,68,64,75,83,71,255,49,68,70,68,77},33), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({50,83,64,76,72,77,64,255,49,68,70,68,77},33), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({36,87,83,81,64,255,50,83,64,76,72,77,64},33), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({50,86,78,81,67,255,35,44,38,255,44,84,75,83},33), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({50,51,49,255,35,44,38,255,44,84,75,83},33), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({35,44,38,255,44,84,75,83,72,79,75,72,68,81},33), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({49,68,67,84,66,68,67,255,35,44,38},33), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({49,68,67,84,66,68,67,255,33,84,81,77},33), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({49,68,67,84,66,68,67,255,37,81,68,68,89,68},33), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({38,81,68,85,72,78,84,82,255,54,78,84,77,67,82},33), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({77,84,76,65,68,81},33) then
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
if v:IsA(_d({51,68,87,83,43,64,65,68,75},33)) then
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
ReplicatedStorage:WaitForChild(_d({81,68,82,68,81,85,68,67,34,78,67,68},33))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({50,83,64,83,82},33))
local v6 = StatsFolder:WaitForChild(_d({40,77,85,68,77,83,78,81,88},33))
local Inventory = v6:WaitForChild(_d({40,77,85,68,77,83,78,81,88},33))
local Equiped = v6:WaitForChild(_d({36,80,84,72,79,68,67},33))
local VanitySlots = v6:WaitForChild(_d({53,64,77,72,83,88,50,75,78,83,82},33))
local FightingStyle = v5:WaitForChild(_d({37,72,70,71,83,72,77,70,50,83,88,75,68},33))
local KatanaOrder = v6:WaitForChild(_d({42,64,83,64,77,64,46,81,67,68,81},33))
local EquipedShip = v6:WaitForChild(_d({36,80,84,72,79,68,67,50,71,72,79},33))
local v7 = StatsFolder:WaitForChild(_d({51,72,83,75,68,82},33))
local AllTitles = v7:WaitForChild(_d({32,75,75,51,72,83,75,68,82},33))
local EquipedTitle = v7:WaitForChild(_d({36,80,84,72,79,68,67,51,72,83,75,68},33))
local AutoEquip = StatsFolder:WaitForChild(_d({50,68,83,83,72,77,70,82},33)):WaitForChild(_d({32,84,83,78,36,80,84,72,79},33))
local EquipedGrip = StatsFolder:WaitForChild(_d({38,81,72,79,82},33)):WaitForChild(_d({36,80,84,72,79,68,67,38,81,72,79},33))
local Inventory_2 = PlayerGui:WaitForChild(_d({40,77,85,68,77,83,78,81,88},33), 360)
local Main = Inventory_2:WaitForChild(_d({44,64,72,77},33))
local v8 = Main:WaitForChild(_d({40,77,85,68,77,83,78,81,88},33))
local List = v8:WaitForChild(_d({43,72,82,83},33))
local v9 = Main:WaitForChild(_d({51,78,79,51,64,65,82},33))
local UIGridLayout = List:WaitForChild(_d({52,40,38,81,72,67,43,64,88,78,84,83},33))
local UIPadding = List:WaitForChild(_d({52,40,47,64,67,67,72,77,70},33))
local v10 = v8:WaitForChild(_d({50,68,64,81,66,71},33))
local Input = v10:WaitForChild(_d({40,77,79,84,83},33))
local Clear = v10:WaitForChild(_d({34,75,68,64,81},33))
local ItemMenu = Main:WaitForChild(_d({40,83,68,76,44,68,77,84},33))
local Health = ItemMenu:WaitForChild(_d({39,68,64,75,83,71},33))
local Bar = Health:WaitForChild(_d({33,64,81},33))
local Equip = ItemMenu:WaitForChild(_d({36,80,84,72,79},33))
local Usage = Equip:WaitForChild(_d({52,82,64,70,68},33))
local Drop = ItemMenu:WaitForChild(_d({35,81,78,79},33))
local v11 = ItemMenu:WaitForChild(_d({44,72,82,66,33,84,83,83,78,77,82},33))
local Vanity = v11:WaitForChild(_d({53,64,77,72,83,88},33))
local CustomTailoredToggle = v11:WaitForChild(_d({34,84,82,83,78,76,51,64,72,75,78,81,68,67,51,78,70,70,75,68},33))
local SwordButtons = ItemMenu:WaitForChild(_d({50,86,78,81,67,33,84,83,83,78,77,82},33))
local Stats = ItemMenu:WaitForChild(_d({50,83,64,83,82},33))
local Boosts = Main:WaitForChild(_d({50,83,64,83,84,82,33,78,78,82,83,82},33)):WaitForChild(_d({33,78,78,82,83,82},33))
local v12 = Main:WaitForChild(_d({50,68,75,68,66,83,72,78,77,82},33))
local Frames = v12:WaitForChild(_d({37,81,64,76,68,82},33))
local RarityFilter = Main:WaitForChild(_d({49,64,81,72,83,88,37,72,75,83,68,81},33))
local Grips = Main:WaitForChild(_d({38,81,72,79,82},33))
local List_2 = Grips:WaitForChild(_d({43,72,82,83},33))
local LoadoutFrame = Main:WaitForChild(_d({43,78,64,67,78,84,83,37,81,64,76,68},33))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({36,77,64,65,75,68,67},33))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({53,72,82,72,65,75,68},33), Enabled)
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