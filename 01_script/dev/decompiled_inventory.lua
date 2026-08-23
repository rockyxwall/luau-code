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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
game:GetService(_d({47,82,64,64,73,46,64,77,81,68,62,64},37))
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
local HttpService = game:GetService(_d({35,79,79,75,46,64,77,81,68,62,64},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local Modules = ReplicatedStorage:WaitForChild(_d({40,74,63,80,71,64,78},37))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({47,74,74,71,31,64,78,62},37))
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
local Events = ReplicatedStorage:WaitForChild(_d({32,81,64,73,79,78},37))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({48,36,78},37))
local RarityGradient = require(UIs:WaitForChild(_d({45,60,77,68,79,84,34,77,60,63,68,64,73,79},37)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({43,71,60,84,64,77,34,80,68},37))
local Tools = ReplicatedStorage:WaitForChild(_d({47,74,74,71,78},37))
local Gradients = script:WaitForChild(_d({34,77,60,63,68,64,73,79,78},37))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({48,73,62,74,72,72,74,73},37)),
Rare = Gradients:WaitForChild(_d({45,60,77,64},37)),
Epic = Gradients:WaitForChild(_d({32,75,68,62},37)),
Legendary = Gradients:WaitForChild(_d({39,64,66,64,73,63,60,77,84},37)),
Mythical = Gradients:WaitForChild(_d({40,84,79,67,68,62,60,71},37)),
Collectable = Gradients:WaitForChild(_d({30,74,71,71,64,62,79,60,61,71,64},37)),
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
HP = {Display = _d({32,83,79,77,60,251,35,64,60,71,79,67},37), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({35,64,60,71,79,67,251,45,64,66,64,73},37), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({46,79,60,72,68,73,60,251,45,64,66,64,73},37), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({32,83,79,77,60,251,46,79,60,72,68,73,60},37), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({46,82,74,77,63,251,31,40,34,251,40,80,71,79},37), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({46,47,45,251,31,40,34,251,40,80,71,79},37), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({31,40,34,251,40,80,71,79,68,75,71,68,64,77},37), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({45,64,63,80,62,64,63,251,31,40,34},37), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({45,64,63,80,62,64,63,251,29,80,77,73},37), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({45,64,63,80,62,64,63,251,33,77,64,64,85,64},37), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({34,77,64,81,68,74,80,78,251,50,74,80,73,63,78},37), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({73,80,72,61,64,77},37) then
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
if v:IsA(_d({47,64,83,79,39,60,61,64,71},37)) then
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
ReplicatedStorage:WaitForChild(_d({77,64,78,64,77,81,64,63,30,74,63,64},37))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({46,79,60,79,78},37))
local v6 = StatsFolder:WaitForChild(_d({36,73,81,64,73,79,74,77,84},37))
local Inventory = v6:WaitForChild(_d({36,73,81,64,73,79,74,77,84},37))
local Equiped = v6:WaitForChild(_d({32,76,80,68,75,64,63},37))
local VanitySlots = v6:WaitForChild(_d({49,60,73,68,79,84,46,71,74,79,78},37))
local FightingStyle = v5:WaitForChild(_d({33,68,66,67,79,68,73,66,46,79,84,71,64},37))
local KatanaOrder = v6:WaitForChild(_d({38,60,79,60,73,60,42,77,63,64,77},37))
local EquipedShip = v6:WaitForChild(_d({32,76,80,68,75,64,63,46,67,68,75},37))
local v7 = StatsFolder:WaitForChild(_d({47,68,79,71,64,78},37))
local AllTitles = v7:WaitForChild(_d({28,71,71,47,68,79,71,64,78},37))
local EquipedTitle = v7:WaitForChild(_d({32,76,80,68,75,64,63,47,68,79,71,64},37))
local AutoEquip = StatsFolder:WaitForChild(_d({46,64,79,79,68,73,66,78},37)):WaitForChild(_d({28,80,79,74,32,76,80,68,75},37))
local EquipedGrip = StatsFolder:WaitForChild(_d({34,77,68,75,78},37)):WaitForChild(_d({32,76,80,68,75,64,63,34,77,68,75},37))
local Inventory_2 = PlayerGui:WaitForChild(_d({36,73,81,64,73,79,74,77,84},37), 360)
local Main = Inventory_2:WaitForChild(_d({40,60,68,73},37))
local v8 = Main:WaitForChild(_d({36,73,81,64,73,79,74,77,84},37))
local List = v8:WaitForChild(_d({39,68,78,79},37))
local v9 = Main:WaitForChild(_d({47,74,75,47,60,61,78},37))
local UIGridLayout = List:WaitForChild(_d({48,36,34,77,68,63,39,60,84,74,80,79},37))
local UIPadding = List:WaitForChild(_d({48,36,43,60,63,63,68,73,66},37))
local v10 = v8:WaitForChild(_d({46,64,60,77,62,67},37))
local Input = v10:WaitForChild(_d({36,73,75,80,79},37))
local Clear = v10:WaitForChild(_d({30,71,64,60,77},37))
local ItemMenu = Main:WaitForChild(_d({36,79,64,72,40,64,73,80},37))
local Health = ItemMenu:WaitForChild(_d({35,64,60,71,79,67},37))
local Bar = Health:WaitForChild(_d({29,60,77},37))
local Equip = ItemMenu:WaitForChild(_d({32,76,80,68,75},37))
local Usage = Equip:WaitForChild(_d({48,78,60,66,64},37))
local Drop = ItemMenu:WaitForChild(_d({31,77,74,75},37))
local v11 = ItemMenu:WaitForChild(_d({40,68,78,62,29,80,79,79,74,73,78},37))
local Vanity = v11:WaitForChild(_d({49,60,73,68,79,84},37))
local CustomTailoredToggle = v11:WaitForChild(_d({30,80,78,79,74,72,47,60,68,71,74,77,64,63,47,74,66,66,71,64},37))
local SwordButtons = ItemMenu:WaitForChild(_d({46,82,74,77,63,29,80,79,79,74,73,78},37))
local Stats = ItemMenu:WaitForChild(_d({46,79,60,79,78},37))
local Boosts = Main:WaitForChild(_d({46,79,60,79,80,78,29,74,74,78,79,78},37)):WaitForChild(_d({29,74,74,78,79,78},37))
local v12 = Main:WaitForChild(_d({46,64,71,64,62,79,68,74,73,78},37))
local Frames = v12:WaitForChild(_d({33,77,60,72,64,78},37))
local RarityFilter = Main:WaitForChild(_d({45,60,77,68,79,84,33,68,71,79,64,77},37))
local Grips = Main:WaitForChild(_d({34,77,68,75,78},37))
local List_2 = Grips:WaitForChild(_d({39,68,78,79},37))
local LoadoutFrame = Main:WaitForChild(_d({39,74,60,63,74,80,79,33,77,60,72,64},37))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({32,73,60,61,71,64,63},37))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({49,68,78,68,61,71,64},37), Enabled)
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