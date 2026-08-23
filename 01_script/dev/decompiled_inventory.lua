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
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
game:GetService(_d({33,68,50,50,59,32,50,63,67,54,48,50},51))
local UserInputService = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
local HttpService = game:GetService(_d({21,65,65,61,32,50,63,67,54,48,50},51))
local RunService = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local Modules = ReplicatedStorage:WaitForChild(_d({26,60,49,66,57,50,64},51))
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild(_d({33,60,60,57,17,50,64,48},51))
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
local Events = ReplicatedStorage:WaitForChild(_d({18,67,50,59,65,64},51))
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild(_d({34,22,64},51))
local RarityGradient = require(UIs:WaitForChild(_d({31,46,63,54,65,70,20,63,46,49,54,50,59,65},51)))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({29,57,46,70,50,63,20,66,54},51))
local Tools = ReplicatedStorage:WaitForChild(_d({33,60,60,57,64},51))
local Gradients = script:WaitForChild(_d({20,63,46,49,54,50,59,65,64},51))
local u128 = {
Uncommon = Gradients:WaitForChild(_d({34,59,48,60,58,58,60,59},51)),
Rare = Gradients:WaitForChild(_d({31,46,63,50},51)),
Epic = Gradients:WaitForChild(_d({18,61,54,48},51)),
Legendary = Gradients:WaitForChild(_d({25,50,52,50,59,49,46,63,70},51)),
Mythical = Gradients:WaitForChild(_d({26,70,65,53,54,48,46,57},51)),
Collectable = Gradients:WaitForChild(_d({16,60,57,57,50,48,65,46,47,57,50},51)),
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
HP = {Display = _d({18,69,65,63,46,237,21,50,46,57,65,53},51), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
Regen = {Display = _d({21,50,46,57,65,53,237,31,50,52,50,59},51), UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
Stam = {Display = _d({32,65,46,58,54,59,46,237,31,50,52,50,59},51), UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
MaxStam = {Display = _d({18,69,65,63,46,237,32,65,46,58,54,59,46},51), UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
swordMultiplier = {Display = _d({32,68,60,63,49,237,17,26,20,237,26,66,57,65},51), UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
strengthMultiplier = {Display = _d({32,33,31,237,17,26,20,237,26,66,57,65},51), UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
damageMultiplier = {Display = _d({17,26,20,237,26,66,57,65,54,61,57,54,50,63},51), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
ReducedDMG = {Display = _d({31,50,49,66,48,50,49,237,17,26,20},51), UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
BurnResistance = {Display = _d({31,50,49,66,48,50,49,237,15,66,63,59},51), UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
FreezeResistance = {Display = _d({31,50,49,66,48,50,49,237,19,63,50,50,71,50},51), UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
AntiHeal = {Display = _d({20,63,50,67,54,60,66,64,237,36,60,66,59,49,64},51), UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2)
local v1 = math.floor(p1 * 10 ^ p2)
return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3)
local v1 = u166[p2]
local Color = v1.Color
if typeof(p3) ~= _d({59,66,58,47,50,63},51) then
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
if v:IsA(_d({33,50,69,65,25,46,47,50,57},51)) then
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
ReplicatedStorage:WaitForChild(_d({63,50,64,50,63,67,50,49,16,60,49,50},51))
local StatsFolder = p1:GetStatsFolder()
local v5 = StatsFolder:WaitForChild(_d({32,65,46,65,64},51))
local v6 = StatsFolder:WaitForChild(_d({22,59,67,50,59,65,60,63,70},51))
local Inventory = v6:WaitForChild(_d({22,59,67,50,59,65,60,63,70},51))
local Equiped = v6:WaitForChild(_d({18,62,66,54,61,50,49},51))
local VanitySlots = v6:WaitForChild(_d({35,46,59,54,65,70,32,57,60,65,64},51))
local FightingStyle = v5:WaitForChild(_d({19,54,52,53,65,54,59,52,32,65,70,57,50},51))
local KatanaOrder = v6:WaitForChild(_d({24,46,65,46,59,46,28,63,49,50,63},51))
local EquipedShip = v6:WaitForChild(_d({18,62,66,54,61,50,49,32,53,54,61},51))
local v7 = StatsFolder:WaitForChild(_d({33,54,65,57,50,64},51))
local AllTitles = v7:WaitForChild(_d({14,57,57,33,54,65,57,50,64},51))
local EquipedTitle = v7:WaitForChild(_d({18,62,66,54,61,50,49,33,54,65,57,50},51))
local AutoEquip = StatsFolder:WaitForChild(_d({32,50,65,65,54,59,52,64},51)):WaitForChild(_d({14,66,65,60,18,62,66,54,61},51))
local EquipedGrip = StatsFolder:WaitForChild(_d({20,63,54,61,64},51)):WaitForChild(_d({18,62,66,54,61,50,49,20,63,54,61},51))
local Inventory_2 = PlayerGui:WaitForChild(_d({22,59,67,50,59,65,60,63,70},51), 360)
local Main = Inventory_2:WaitForChild(_d({26,46,54,59},51))
local v8 = Main:WaitForChild(_d({22,59,67,50,59,65,60,63,70},51))
local List = v8:WaitForChild(_d({25,54,64,65},51))
local v9 = Main:WaitForChild(_d({33,60,61,33,46,47,64},51))
local UIGridLayout = List:WaitForChild(_d({34,22,20,63,54,49,25,46,70,60,66,65},51))
local UIPadding = List:WaitForChild(_d({34,22,29,46,49,49,54,59,52},51))
local v10 = v8:WaitForChild(_d({32,50,46,63,48,53},51))
local Input = v10:WaitForChild(_d({22,59,61,66,65},51))
local Clear = v10:WaitForChild(_d({16,57,50,46,63},51))
local ItemMenu = Main:WaitForChild(_d({22,65,50,58,26,50,59,66},51))
local Health = ItemMenu:WaitForChild(_d({21,50,46,57,65,53},51))
local Bar = Health:WaitForChild(_d({15,46,63},51))
local Equip = ItemMenu:WaitForChild(_d({18,62,66,54,61},51))
local Usage = Equip:WaitForChild(_d({34,64,46,52,50},51))
local Drop = ItemMenu:WaitForChild(_d({17,63,60,61},51))
local v11 = ItemMenu:WaitForChild(_d({26,54,64,48,15,66,65,65,60,59,64},51))
local Vanity = v11:WaitForChild(_d({35,46,59,54,65,70},51))
local CustomTailoredToggle = v11:WaitForChild(_d({16,66,64,65,60,58,33,46,54,57,60,63,50,49,33,60,52,52,57,50},51))
local SwordButtons = ItemMenu:WaitForChild(_d({32,68,60,63,49,15,66,65,65,60,59,64},51))
local Stats = ItemMenu:WaitForChild(_d({32,65,46,65,64},51))
local Boosts = Main:WaitForChild(_d({32,65,46,65,66,64,15,60,60,64,65,64},51)):WaitForChild(_d({15,60,60,64,65,64},51))
local v12 = Main:WaitForChild(_d({32,50,57,50,48,65,54,60,59,64},51))
local Frames = v12:WaitForChild(_d({19,63,46,58,50,64},51))
local RarityFilter = Main:WaitForChild(_d({31,46,63,54,65,70,19,54,57,65,50,63},51))
local Grips = Main:WaitForChild(_d({20,63,54,61,64},51))
local List_2 = Grips:WaitForChild(_d({25,54,64,65},51))
local LoadoutFrame = Main:WaitForChild(_d({25,60,46,49,60,66,65,19,63,46,58,50},51))
local FavButton = ItemMenu.FavButton
Main.Visible = false
local v13 = Inventory_2:GetPropertyChangedSignal(_d({18,59,46,47,57,50,49},51))
v13:Connect(function()
local Enabled = Inventory_2.Enabled
print(_d({35,54,64,54,47,57,50},51), Enabled)
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