--[[
__________                   __               __    __________              .__
\______   \_______  ____    |__| ____   _____/  |_  \______   \ ____ _____  |  |
 |     ___/\_  __ \/  _ \   |  |/ __ \_/ ___\   __\  |       _// __ \\__  \ |  |
 |    |     |  | \(  <_> )  |  \  ___/\  \___|  |    |    |   \  ___/ / __ \|  |__
 |____|     |__|   \____/\__|  |\___  >\___  >__|    |____|_  /\___  >____  /____/
                        \______|    \/     \/               \/     \/     \/
]]
--                           Project Real  |  Luau Decompiler
--                                   Made by @zinvera
--        File: ReplicatedStorage.Modules.Client.UIController.Guis.Core.Inventory
--                               Dumped in 0.0179 seconds
--                         Bytecode version 9  |  103 functions

local Players = game:GetService("Players")
game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Shared = Modules.Shared
local Client = Modules.Client
local ToolDesc = Modules:WaitForChild("ToolDesc")
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
local Events = ReplicatedStorage:WaitForChild("Events")
local GoodSignal = require(ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local UIUtils = require(Client.UIUtils)
local UIs = Client:WaitForChild("UIs")
local RarityGradient = require(UIs:WaitForChild("RarityGradient"))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Tools = ReplicatedStorage:WaitForChild("Tools")
local Gradients = script:WaitForChild("Gradients")
local u128 = {
    Uncommon = Gradients:WaitForChild("Uncommon"),
    Rare = Gradients:WaitForChild("Rare"),
    Epic = Gradients:WaitForChild("Epic"),
    Legendary = Gradients:WaitForChild("Legendary"),
    Mythical = Gradients:WaitForChild("Mythical"),
    Collectable = Gradients:WaitForChild("Collectable"),
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
    HP = {Display = "Extra Health", UsePercentValue = false, Color = Color3.fromRGB(170, 255, 0)},
    Regen = {Display = "Health Regen", UsePercentValue = false, Color = Color3.fromRGB(170, 255, 127)},
    Stam = {Display = "Stamina Regen", UsePercentValue = false, Color = Color3.fromRGB(85, 255, 255)},
    MaxStam = {Display = "Extra Stamina", UsePercentValue = false, Color = Color3.fromRGB(0, 255, 255)},
    swordMultiplier = {Display = "Sword DMG Mult", UsePercentValue = true, Color = Color3.fromRGB(85, 85, 255)},
    strengthMultiplier = {Display = "STR DMG Mult", UsePercentValue = true, Color = Color3.fromRGB(255, 170, 127)},
    damageMultiplier = {Display = "DMG Multiplier", UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
    ReducedDMG = {Display = "Reduced DMG", UsePercentValue = true, Color = Color3.fromRGB(170, 170, 255)},
    BurnResistance = {Display = "Reduced Burn", UsePercentValue = true, Color = Color3.fromRGB(255, 85, 0)},
    FreezeResistance = {Display = "Reduced Freeze", UsePercentValue = true, Color = Color3.fromRGB(170, 255, 255)},
    AntiHeal = {Display = "Grevious Wounds", UsePercentValue = true, Color = Color3.fromRGB(57, 113, 0)},
}
local function roundNumber(p1, p2) -- Line: 88
    local v1 = math.floor(p1 * 10 ^ p2)
    return v1 / 10 ^ p2
end
local function UpdateStatText(p1, p2, p3) -- Line: 92 -- upvalues: u166 (val)
    local v1 = u166[p2]
    local Color = v1.Color
    if typeof(p3) ~= "number" then
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
    DisplayItemStats = function(p1, p2) -- Line: 116 -- upvalues: ToolDesc (val), u56 (val), UpdateStatText (val)
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
            if v:IsA("TextLabel") then
                UpdateStatText(v, v.Name, Attributes[v.Name] or 0)
            end
        end
    end,
}
function u235.Initialize(p1) -- Line: 133 -- upvalues: u235 (val), ReplicatedStorage (val), PlayerGui (val), RarityGradient (val), Tools (val), Module3D (val), UIUtils (val), u56 (val), HttpService (val), Events (val), RichText (val), LocalPlayer (val), u128 (val), u165 (val), QueueTask (val), u162 (val), UserInputService (val), RunService (val), Titles (val), ToolDesc (val), UpdateStatText (val), TailorPortCodeUI (val), GoodSignal (val), Trove (val)
    local ItemRotation, PropertyChangedSignal, TailorableWeapons, Value, v1, v2, v3, v4
    if u235.Initialized then
        return
    end
    ReplicatedStorage:WaitForChild("reservedCode")
    local StatsFolder = p1:GetStatsFolder()
    local v5 = StatsFolder:WaitForChild("Stats")
    local v6 = StatsFolder:WaitForChild("Inventory")
    local Inventory = v6:WaitForChild("Inventory")
    local Equiped = v6:WaitForChild("Equiped")
    local VanitySlots = v6:WaitForChild("VanitySlots")
    local FightingStyle = v5:WaitForChild("FightingStyle")
    local KatanaOrder = v6:WaitForChild("KatanaOrder")
    local EquipedShip = v6:WaitForChild("EquipedShip")
    local v7 = StatsFolder:WaitForChild("Titles")
    local AllTitles = v7:WaitForChild("AllTitles")
    local EquipedTitle = v7:WaitForChild("EquipedTitle")
    local AutoEquip = StatsFolder:WaitForChild("Settings"):WaitForChild("AutoEquip")
    local EquipedGrip = StatsFolder:WaitForChild("Grips"):WaitForChild("EquipedGrip")
    local Inventory_2 = PlayerGui:WaitForChild("Inventory", 360)
    local Main = Inventory_2:WaitForChild("Main")
    local v8 = Main:WaitForChild("Inventory")
    local List = v8:WaitForChild("List")
    local v9 = Main:WaitForChild("TopTabs")
    local UIGridLayout = List:WaitForChild("UIGridLayout")
    local UIPadding = List:WaitForChild("UIPadding")
    local v10 = v8:WaitForChild("Search")
    local Input = v10:WaitForChild("Input")
    local Clear = v10:WaitForChild("Clear")
    local ItemMenu = Main:WaitForChild("ItemMenu")
    local Health = ItemMenu:WaitForChild("Health")
    local Bar = Health:WaitForChild("Bar")
    local Equip = ItemMenu:WaitForChild("Equip")
    local Usage = Equip:WaitForChild("Usage")
    local Drop = ItemMenu:WaitForChild("Drop")
    local v11 = ItemMenu:WaitForChild("MiscButtons")
    local Vanity = v11:WaitForChild("Vanity")
    local CustomTailoredToggle = v11:WaitForChild("CustomTailoredToggle")
    local SwordButtons = ItemMenu:WaitForChild("SwordButtons")
    local Stats = ItemMenu:WaitForChild("Stats")
    local Boosts = Main:WaitForChild("StatusBoosts"):WaitForChild("Boosts")
    local v12 = Main:WaitForChild("Selections")
    local Frames = v12:WaitForChild("Frames")
    local RarityFilter = Main:WaitForChild("RarityFilter")
    local Grips = Main:WaitForChild("Grips")
    local List_2 = Grips:WaitForChild("List")
    local LoadoutFrame = Main:WaitForChild("LoadoutFrame")
    local FavButton = ItemMenu.FavButton
    Main.Visible = false
    local v13 = Inventory_2:GetPropertyChangedSignal("Enabled")
    v13:Connect(function() -- Line: 206 -- upvalues: Inventory_2 (val), RarityGradient (upval)
        local Enabled = Inventory_2.Enabled
        print("Visible", Enabled)
        RarityGradient.SetRainbowGradientsGui(Inventory_2, Enabled)
    end)
    local u199 = {}
    local u200 = {}
    local u201 = {}
    local function DestroyItemPreview(p1) -- Line: 219 -- upvalues: u201 (val)
        local v1 = u201[p1]
        if v1 == nil then
            return
        end
        u201[p1] = nil
        v1:Destroy()
    end