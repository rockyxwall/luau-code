--[[
    ================================================================================
    GPO UNIFIED LOADER / LAUNCHER UI
    ================================================================================
    Allows selection and execution of specific bots and tools in the GPO suite.
    ================================================================================
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Wrap script bundles in functions so they only execute when selected
local function loadCupidDungeon()
    
--[[
    CupidTrial.lua
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = workspace

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()
local Safeguard = Core.GetSafeguard()

-- ========================= CONFIG =========================

local HOVER_OFFSET = 10.3 -- studs above an NPC target while fighting it
local HOVER_YVEL = 120
local XZ_SPEED = 5
local XZ_THRESHOLD = 3
local Y_THRESHOLD = 1.5
local TOGGLE_KEY = Enum.KeyCode.P

local MELEE_CLICK_INTERVAL = 0.2
local ARROW_HOVER_OFFSET = 10 -- "hover 10 studs on the sky"
local ARROW_HOVER_WAIT = 30
local ARROW_DODGE_DISTANCE = 40 -- studs ahead/behind while dodging
local ARROW_DODGE_INTERVAL = 0.5 -- seconds per side before switching
local LEO_PILLAR_ANIM_ID = "rbxassetid://5244141327"
local LEO_ENTEI_ANIM_ID = "rbxassetid://5244138278"
local LEO_HIKEN_ANIM_ID = "rbxassetid://5220917407"
local LEO_FIREFLY_ANIM_ID = "rbxassetid://5220236154"
local LEO_DODGE_ANIMS = { LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID }
local LEO_DODGE_DISTANCE = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY = 4 -- seconds after leaving for Leo before we start holding Block, instead of blocking immediately on departure
local BLOCK_KEY = Enum.KeyCode.F
local LOAD_WAIT = 15
local OBJECTIVES_GUI_NAME = "Objectives" -- PlayerGui child that exists once the match/stage has actually loaded
local OBJECTIVES_WAIT_MAX = 60 -- seconds to wait for it to appear before giving up and proceeding anyway
local BUSO_CHECK_INTERVAL = 1 -- seconds between Buso Haki activity checks
local KEN_CHECK_INTERVAL = 1 -- seconds between Ken Haki activity checks (once it starts, after Queen phase 2)
local GEPPO_CLIMB_THRESHOLD = 10 -- studs — only invoke Geppo if the climb is at least this much
local GEPPO_HOLD_INTERVAL = 2 -- seconds between repeated Geppo presses while holding position in the air during a dodge
local COMBAT_LOCK_MAX_SNAP = 10 -- studs — safety cap for the combat CFrame lock. If the NPC target is
-- farther than this when we'd otherwise hard-snap (e.g. it dashed, or a
-- stage/NPC swap happened), skip the snap and fall back to the normal
-- velocity-based move so we glide back in instead of teleporting.
local UNSTUCK_CHECK_INTERVAL = 1 -- seconds between stuck-detection position samples
local UNSTUCK_MOVE_THRESHOLD = 5 -- studs — moving less than this between samples counts as "no progress"
local UNSTUCK_STUCK_TICKS = 10 -- consecutive no-progress samples (~5s at the interval above) before
-- we send /unstuck
local UNSTUCK_COOLDOWN = 8 -- seconds to wait after sending /unstuck before we'll send it again,
-- so the command has time to actually take effect

local COORDS = {
    Stage1 = Vector3.new(557.1764526367188, 310.18902587890625, -2282.130126953125),
    Stage2 = Vector3.new(514.002197265625, 320.0939025878906, -2755.223876953125),
    Stage3 = Vector3.new(-213.13096618652344, 376.07440185546875, -2699.046142578125),
    Stage3B = Vector3.new(-915.4906616210938, 435.0939636230469, -2743.846923828125),
    ArrowFlyDown = Vector3.new(-1071.06884765625, 444.2209167480469, -3205.72412109375),
    Stage4 = Vector3.new(-1089.56494140625, 452.1291198730469, -3590.454833984375),
    Leo = Vector3.new(-1092.56298828125, 506.0744462890625, -4248.216796875),
    Queen = Vector3.new(-1098.1424560546875, 666.206787109375, -5066.43603515625),
    Statue1 = Vector3.new(-902.9956665039062, 670.851867675757812, -5307.0703125),
    Statue2 = Vector3.new(-1089.46533203125, 671.2554931640625, -5410.2470703125),
    Statue3 = Vector3.new(-1304.9073486328125, 666.7710571289062, -5306.22705078125),
    PostQueen = Vector3.new(-1096.88134765625, 672.9217529296875, -5380.06396484375),
}

-- Replay prompt (appears after Queen is defeated, once at PostQueen)
local REPLAY_BUTTON_VALUE = "Replay" -- matches the ImageButton's buttonValue attribute
local REPLAY_PROMPT_TIMEOUT = 15 -- seconds to wait for the prompt to appear before giving up
local REPLAY_CLICK_SETTLE = 1 -- brief pause after the prompt appears before clicking, since it tweens in

-- ========================= STATE =========================

local enabled = false
local navConn = nil
local phase = "move"
local NavState = { mode = "idle" } -- mode: "idle" | "point" | "npc" | "named"
local lastAim = nil
local lastFace = nil

local function debug(...)
    print("[BossBot]", ...)
end

-- ========================= BASIC GETTERS =========================

local function getRoot()
    local ok, root = pcall(function()
        local char = Players.LocalPlayer.Character
        return char and char:FindFirstChild("HumanoidRootPart")
    end)
    if ok then
        return root
    end
    debug("getRoot error:", root)
    return nil
end

local function getHumanoid()
    local ok, hum = pcall(function()
        local char = Players.LocalPlayer.Character
        return char and char:FindFirstChildWhichIsA("Humanoid")
    end)
    if ok then
        return hum
    end
    debug("getHumanoid error:", hum)
    return nil
end

-- ========================= FORCE (hover) =========================

local function getOrCreateForce(root)
    local ok, result = pcall(function()
        local att = root:FindFirstChild("__HoverAtt") or Instance.new("Attachment")
        att.Name = "__HoverAtt"
        att.Parent = root
        local force = root:FindFirstChild("__HoverForce")
        if not force then
            force = Instance.new("LinearVelocity")
            force.Name = "__HoverForce"
            force.Attachment0 = att
            force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            force.RelativeTo = Enum.ActuatorRelativeTo.World
            force.MaxForce = 1000000
            force.VectorVelocity = Vector3.new(0, 0, 0)
            force.Parent = root
        end
        return force
    end)
    if ok then
        return result
    end
    debug("getOrCreateForce error:", result)
    return nil
end

local function cleanupForce()
    local ok, err = pcall(function()
        local char = Players.LocalPlayer.Character
        if not char then
            return
        end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then
            return
        end
        local force = root:FindFirstChild("__HoverForce")
        local att = root:FindFirstChild("__HoverAtt")
        if force then
            force:Destroy()
        end
        if att then
            att:Destroy()
        end
    end)
    if not ok then
        debug("cleanupForce error:", err)
    end
end

local function isBusoActive()
    local ok, result = pcall(function()
        local char = Players.LocalPlayer.Character
        return char ~= nil and char:FindFirstChild("BusoMelee") ~= nil
    end)
    if ok then
        return result
    end
    debug("isBusoActive error:", result)
    return false
end

local function activateBuso()
    local ok, err = pcall(function()
        ReplicatedStorage.Events.Haki:FireServer("Buso")
    end)
    if not ok then
        debug("activateBuso error:", err)
    end
end

local function startBusoKeeper()
    task.spawn(function()
        while enabled do
            local ok, err = pcall(function()
                if not isBusoActive() then
                    debug("Buso not active, activating")
                    activateBuso()
                end
            end)
            if not ok then
                debug("BusoKeeper error:", err)
            end
            task.wait(BUSO_CHECK_INTERVAL)
        end
        debug("Buso keeper stopped")
    end)
end

local function isKenActive()
    local ok, result = pcall(function()
        local char = Players.LocalPlayer.Character
        return char ~= nil and char:FindFirstChild("KenHaki") ~= nil
    end)
    if ok then
        return result
    end
    debug("isKenActive error:", result)
    return false
end

local function activateKen()
    local ok, err = pcall(function()
        ReplicatedStorage.Events.Haki:FireServer("Ken", true)
    end)
    if not ok then
        debug("activateKen error:", err)
    end
end

local kenKeeperStarted = false
local function startKenKeeper()
    -- Started once Queen reaches phase 2 (see runPlan) and left running for
    -- the rest of the fight. Same pattern as startBusoKeeper: poll, and if
    -- the KenHaki marker is missing (it got disabled — ran out of dodges,
    -- got interrupted, whatever) fire the same remote the real Ken module
    -- uses to turn it back on.
    if kenKeeperStarted then
        return
    end
    kenKeeperStarted = true
    task.spawn(function()
        while enabled do
            local ok, err = pcall(function()
                if not isKenActive() then
                    debug("Ken not active, activating")
                    activateKen()
                end
            end)
            if not ok then
                debug("KenKeeper error:", err)
            end
            task.wait(KEN_CHECK_INTERVAL)
        end
        debug("Ken keeper stopped")
        kenKeeperStarted = false
    end)
end

-- ========================= NPC HELPERS =========================

local function getNPCsFolder()
    local ok, folder = pcall(function()
        return Workspace:FindFirstChild("NPCs")
    end)
    if ok then
        return folder
    end
    debug("getNPCsFolder error:", folder)
    return nil
end

local function getNearestNPC(exclude)
    local ok, result = pcall(function()
        local root = Core.GetRoot(LocalPlayer)
        local folder = getNPCsFolder()
        if not root or not folder then
            return nil
        end
        local nearest, nearestDist = nil, math.huge
        local fallbackNearest, fallbackDist = nil, math.huge -- true nearest regardless of exclude, used if every candidate is excluded so we never stall with nothing to target
        for _, model in ipairs(folder:GetChildren()) do
            local okp, info = pcall(function()
                local r = model:FindFirstChild("HumanoidRootPart")
                local h = model:FindFirstChildWhichIsA("Humanoid")
                if r and h and h.Health > 0 then
                    return { root = r, humanoid = h, model = model }
                end
                return nil
            end)
            if okp and info then
                local dist = (info.root.Position - root.Position).Magnitude
                if dist < fallbackDist then
                    fallbackDist, fallbackNearest = dist, info
                end
                if dist < nearestDist and not (exclude and exclude[model]) then
                    nearestDist, nearest = dist, info
                end
            end
        end
        return nearest or fallbackNearest
    end)
    if ok then
        return result
    end
    debug("getNearestNPC error:", result)
    return nil
end

local function getNPCByName(name)
    local ok, result = pcall(function()
        local folder = getNPCsFolder()
        if not folder then
            return nil
        end
        local model = folder:FindFirstChild(name)
        if not model then
            return nil
        end
        local root = model:FindFirstChild("HumanoidRootPart")
        local hum = model:FindFirstChildWhichIsA("Humanoid")
        if root and hum and hum.Health > 0 then
            return { root = root, humanoid = hum, model = model }
        end
        return nil
    end)
    if ok then
        return result
    end
    debug("getNPCByName error:", result)
    return nil
end

local function npcsRemaining()
    local ok, count = pcall(function()
        local folder = getNPCsFolder()
        if not folder then
            return 0
        end
        local n = 0
        for _, m in ipairs(folder:GetChildren()) do
            local hum = m:FindFirstChildWhichIsA("Humanoid")
            if hum and hum.Health > 0 then
                n += 1
            end
        end
        return n
    end)
    if ok then
        return count
    end
    debug("npcsRemaining error:", count)
    return 0
end

local function isQueenPhase2()
    local ok, result = pcall(function()
        local folder = getNPCsFolder()
        local queen = folder and folder:FindFirstChild("Cupid Queen")
        return queen ~= nil and queen:FindFirstChild("motionLess") ~= nil
    end)
    if ok then
        return result
    end
    debug("isQueenPhase2 error:", result)
    return false
end

local QUEEN_EMBRACE_ANIM_ID = "rbxassetid://121297942292769"
local QUEEN_GRASP_ANIM_ID = "rbxassetid://129800061001734"
local QUEEN_BLOCK_ANIMS = { QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID }
local QUEEN_BLOCK_TIMEOUT = 3 -- safety cap in case the animation never stops being reported
local QUEEN_DODGE_DISTANCE = 70
local QUEEN_DODGE_DURATION = 3

local function isPlayingAnimFromList(npcModel, animList)
    local ok, result, which = pcall(function()
        if not npcModel then
            return false
        end
        local hum = npcModel:FindFirstChildWhichIsA("Humanoid")
        if not hum then
            return false
        end
        for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
            local animId = track.Animation and track.Animation.AnimationId
            for _, id in ipairs(animList) do
                if animId == id then
                    return true, id
                end
            end
        end
        return false
    end)
    if ok then
        return result, which
    end
    debug("isPlayingAnimFromList error:", result)
    return false
end

local function isCastingDodgeSkill(npcModel)
    return isPlayingAnimFromList(npcModel, LEO_DODGE_ANIMS)
end

local function isQueenCastingBlockableSkill(npcModel)
    return isPlayingAnimFromList(npcModel, QUEEN_BLOCK_ANIMS)
end

local function isNPCBlocking(npcModel)
    local ok, result = pcall(function()
        return npcModel ~= nil and npcModel:FindFirstChild("Blocking") ~= nil
    end)
    if ok then
        return result
    end
    debug("isNPCBlocking error:", result)
    return false
end

local NPC_PREDICT_LOOKAHEAD = 0.15 -- seconds — lead the NPC's position by this much based on its current
-- velocity, so the hover controller is closing toward where it will be
-- instead of always chasing where it was a frame ago (that lag is why
-- it never caught up to a moving NPC).
local NPC_PREDICT_MAX_LEAD = 12 -- studs — cap on how far ahead we'll lead, so a knockback/velocity
-- spike on the NPC can't fling the aim point wildly off target.

local function predictNPCPosition(info)
    local ok, result = pcall(function()
        local vel = info.root.AssemblyLinearVelocity
        -- Ignore vertical velocity entirely — falling/knockback/hitstun can
        -- put a large Y component on this vector, and leading on that drags
        -- the aim point well below (or above) where the NPC actually is
        -- right now. Only horizontal motion should be predicted; height is
        -- always taken from the NPC's real current position.
        local flatVel = Vector3.new(vel.X, 0, vel.Z)
        local lead = flatVel * NPC_PREDICT_LOOKAHEAD
        if lead.Magnitude > NPC_PREDICT_MAX_LEAD then
            lead = lead.Unit * NPC_PREDICT_MAX_LEAD
        end
        return info.root.Position + lead
    end)
    if ok then
        return result
    end
    debug("predictNPCPosition error:", result)
    return info.root.Position
end

-- ========================= STUCK-TARGET TRACKING (Stage1-Stage4) =========================
-- Used only by the "npc" nav mode (nearest-NPC targeting during clearStage,
-- i.e. Stage1-Stage4). If the currently-targeted NPC's health hasn't moved
-- for NPC_STUCK_TIMEOUT seconds despite us attacking it, it's likely
-- unreachable (stuck on geometry, out of melee range, etc.) - mark it stuck
-- so getNearestNPC picks a different target instead of camping it forever.

local NPC_STUCK_TIMEOUT = 10 -- seconds without a health change before we give up on the current target
local npcDamageTracker = setmetatable({}, { __mode = "k" }) -- model -> {lastHP, since}; weak-keyed so dead/despawned NPCs don't leak
local stuckNPCs = setmetatable({}, { __mode = "k" }) -- model -> true, while considered unreachable

local function trackNPCDamage(info)
    local ok, err = pcall(function()
        local model = info.model
        local hp = info.humanoid.Health
        local tracked = npcDamageTracker[model]
        if not tracked or tracked.lastHP ~= hp then
            -- Either the first time we've seen this NPC, or it just took
            -- damage - reset the clock and clear any stuck flag.
            npcDamageTracker[model] = { lastHP = hp, since = tick() }
            stuckNPCs[model] = nil
            return
        end
        if not stuckNPCs[model] and tick() - tracked.since > NPC_STUCK_TIMEOUT then
            debug("No damage on", model.Name, "for", NPC_STUCK_TIMEOUT, "s - switching target")
            stuckNPCs[model] = true
        end
    end)
    if not ok then
        debug("trackNPCDamage error:", err)
    end
end

-- ========================= STATUE HELPERS =========================

local function getModelFacePos(model)
    local ok, pos = pcall(function()
        if model:IsA("Model") then
            if model.PrimaryPart then
                return model.PrimaryPart.Position
            end
            return model:GetPivot().Position
        elseif model:IsA("BasePart") then
            return model.Position
        end
        return nil
    end)
    if ok then
        return pos
    end
    debug("getModelFacePos error:", pos)
    return nil
end

local function getStatueModelNear(coordPos)
    local ok, result = pcall(function()
        local env = Workspace:FindFirstChild("Env")
        local folder = env and env:FindFirstChild("Statues")
        if not folder then
            return nil
        end
        local nearest, nearestDist = nil, math.huge
        for _, m in ipairs(folder:GetChildren()) do
            local okp, mpos = pcall(getModelFacePos, m)
            if okp and mpos then
                local dist = (mpos - coordPos).Magnitude
                if dist < nearestDist then
                    nearestDist, nearest = dist, m
                end
            end
        end
        return nearest
    end)
    if ok then
        return result
    end
    debug("getStatueModelNear error:", result)
    return nil
end

local function getStatueHP(statueModel)
    local ok, hp = pcall(function()
        local v = statueModel:FindFirstChild("barrelHP")
        return v and v.Value or 0
    end)
    if ok then
        return hp
    end
    debug("getStatueHP error:", hp)
    return 0
end

-- ========================= TOOL / EQUIP HELPERS =========================

local function findToolByAttribute(attrName)
    local ok, tool = pcall(function()
        local char = Players.LocalPlayer.Character
        local bp = Players.LocalPlayer:FindFirstChild("Backpack")
        for _, pool in ipairs({ char, bp }) do
            if pool then
                for _, item in ipairs(pool:GetChildren()) do
                    if item:IsA("Tool") then
                        local ok2, val = pcall(function()
                            return item:GetAttribute(attrName)
                        end)
                        if ok2 and val == true then
                            return item
                        end
                    end
                end
            end
        end
        return nil
    end)
    if ok then
        return tool
    end
    debug("findToolByAttribute error:", tool)
    return nil
end

local function findToolByName(toolName)
    local ok, tool = pcall(function()
        local char = Players.LocalPlayer.Character
        local bp = Players.LocalPlayer:FindFirstChild("Backpack")
        for _, pool in ipairs({ char, bp }) do
            if pool then
                local t = pool:FindFirstChild(toolName)
                if t and t:IsA("Tool") then
                    return t
                end
            end
        end
        return nil
    end)
    if ok then
        return tool
    end
    debug("findToolByName error:", tool)
    return nil
end

local function equipTool(tool)
    if not tool then
        return false
    end
    local ok, err = pcall(function()
        local char = Players.LocalPlayer.Character
        if tool.Parent == char then
            return
        end -- already equipped
        local hum = getHumanoid()
        if not hum then
            return
        end
        hum:EquipTool(tool)
    end)
    if not ok then
        debug("equipTool error:", err)
    end
    return ok
end

local function findToolByChildName(childName)
    local ok, tool = pcall(function()
        local char = Players.LocalPlayer.Character
        local bp = Players.LocalPlayer:FindFirstChild("Backpack")
        for _, pool in ipairs({ char, bp }) do
            if pool then
                for _, item in ipairs(pool:GetChildren()) do
                    if item:IsA("Tool") and item:FindFirstChild(childName) then
                        return item
                    end
                end
            end
        end
        return nil
    end)
    if ok then
        return tool
    end
    debug("findToolByChildName error:", tool)
    return nil
end

local function equipSwordOrMelee()
    local sword = findToolByChildName("SwordEquip")
    if sword then
        equipTool(sword)
        return "sword"
    end
    local melee = findToolByAttribute("MeleeTool")
    if melee then
        equipTool(melee)
        return "melee"
    end
    debug("No sword or melee tool found")
    return nil
end

-- ========================= INPUT SIMULATION =========================

local function clickM1(holdTime)
    local ok, err = pcall(function()
        local cam = Workspace.CurrentCamera
        local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
        local x, y = math.floor(vp.X / 2), math.floor(vp.Y / 2)
        VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
        task.wait(holdTime or 0.05)
        VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
    end)
    if not ok then
        debug("clickM1 error:", err)
    end
end

local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2 -- Safe, slow rate-limiting to avoid remote spam bans

local function invokeGeppo()
    local now = tick()
    if now - lastGeppoTime < GEPPO_COOLDOWN then
        return
    end
    lastGeppoTime = now

    local ok, err = pcall(function()
        local char = Players.LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then
            return
        end
        local statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. Players.LocalPlayer.Name)
        if not statsFolder then
            return
        end
        local style = statsFolder.Stats.FightingStyle.Value
        local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
        local args = { char = char, cf = cf }
        if style == "Rokushiki" then
            ReplicatedStorage.Events.Skill:InvokeServer("Geppo", args)
        elseif style == "BlackLeg" then
            ReplicatedStorage.Events.Skill:InvokeServer("Sky Walk", args)
        elseif style == "Kamishiki" then
            ReplicatedStorage.Events.Skill:InvokeServer("KamishikiGeppo", args)
        else
            ReplicatedStorage.Events.Skill:InvokeServer("Sky Walk2", args)
        end
    end)
    if not ok then
        debug("invokeGeppo error:", err)
    end
end

local function pressSkillR()
    local ok, err = pcall(function()
        VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
        task.wait(0.05)
        VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
    end)
    if not ok then
        debug("pressSkillR error:", err)
    end
end

local function holdBlock(duration)
    local ok, err = pcall(function()
        VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
        task.wait(duration)
        VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
    end)
    if not ok then
        debug("holdBlock error:", err)
    end
end

local function holdBlockWhile(conditionFn, timeout)
    local ok, err = pcall(function()
        VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
        local t = 0
        while enabled and conditionFn() and t < (timeout or 5) do
            task.wait(0.1)
            t += 0.1
        end
        VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
    end)
    if not ok then
        debug("holdBlockWhile error:", err)
    end
end

local function getGameG()
    local ok, result = pcall(function()
        if getrenv then
            local renv = getrenv()
            return renv and renv._G
        end
        return nil
    end)
    if ok then
        return result
    end
    debug("getGameG error:", result)
    return nil
end

local function isRealM1Busy()
    local ok, result = pcall(function()
        local g = getGameG()
        return g ~= nil and g.midM1 == true
    end)
    if ok then
        return result
    end
    debug("isRealM1Busy error:", result)
    return false
end

local prevM1Busy = false
local function pollM1Completed()
    -- Returns true exactly once, the tick a real M1 swing transitions from
    -- busy back to not-busy (covers both a landed hit and a missed/cancelled
    -- swing, since the game sets midM1 = false in both cases).
    local busy = isRealM1Busy()
    local completed = prevM1Busy and not busy
    prevM1Busy = busy
    return completed
end

local function waitOrReact(duration, checkFn)
    -- Polls checkFn every ~0.03s instead of a single blocking wait, so a
    -- dodge/block trigger is caught almost immediately instead of only at
    -- the next full attack-cycle tick.
    local t = 0
    local step = 0.03
    while enabled and t < duration do
        if checkFn() then
            return true
        end
        task.wait(step)
        t += step
    end
    return checkFn()
end

local function isStunned()
    local ok, result = pcall(function()
        local char = Players.LocalPlayer.Character
        return char ~= nil and char:FindFirstChild("stun") ~= nil
    end)
    if ok then
        return result
    end
    debug("isStunned error:", result)
    return false
end

local function pressStunBreak()
    local ok, err = pcall(function()
        VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
        task.wait(0.05)
        VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
    end)
    if not ok then
        debug("pressStunBreak error:", err)
    end
end

local function dodgeHold(duration)
    -- Same idea as waitOrReact: poll every ~0.1s instead of one blocking
    -- wait, so a "stun" tag appearing mid-dodge gets caught and answered
    -- with Left Ctrl instead of being missed for the whole hold duration.
    local t = 0
    local step = 0.1
    while enabled and t < duration do
        if isStunned() then
            pressStunBreak()
        end
        task.wait(step)
        t += step
    end
end

-- Forward declarations: queenDodgeUntilSafe/startQueenDodgeWatcher below call
-- into the nav helpers that are only defined later, in the NAV section. Without
-- this, those calls resolve to nil globals instead of the real local functions
-- and error with "attempt to call a nil value" the first time Queen dodges.
local navToPoint, setNavNamed, disableBot

local function queenDodgeUntilSafe(getInfoFn)
    -- Continuously watches casting status (and stun) the whole time we're
    -- airborne, instead of a fixed-duration hold that goes blind to a
    -- renewed/extended cast (e.g. her jumping in to re-cast while we dodge).
    local info = getInfoFn()
    if not info then
        return
    end
    local root = Core.GetRoot(LocalPlayer)
    local myPos = root and root.Position or info.root.Position
    local bossPos = info.root.Position

    -- Dodge horizontally away from the boss to avoid flight anti-cheat
    local flatDir = Vector3.new(myPos.X - bossPos.X, 0, myPos.Z - bossPos.Z)
    if flatDir.Magnitude < 1 then
        flatDir = Vector3.new(1, 0, 0)
    end
    local awayPoint = myPos + (flatDir.Unit * QUEEN_DODGE_DISTANCE)
    awayPoint = Vector3.new(awayPoint.X, bossPos.Y + HOVER_OFFSET, awayPoint.Z)

    navToPoint(awayPoint, true)

    local t = 0
    while enabled do
        if isStunned() then
            pressStunBreak()
        end

        info = getInfoFn()
        if not info then
            debug("queenDodgeUntilSafe: Queen gone - ending dodge early")
            break
        end
        local stillCasting = isQueenCastingBlockableSkill(info.model)
        if not stillCasting and t >= QUEEN_DODGE_DURATION then
            break
        end
        task.wait(0.1)
        t += 0.1
        if t > 15 then
            debug("queenDodgeUntilSafe safety timeout")
            break
        end
    end
end

local queenDodging = false
local queenWatcherStarted = false
local function startQueenDodgeWatcher()
    if queenWatcherStarted then
        return
    end
    queenWatcherStarted = true
    task.spawn(function()
        while enabled do
            local ok, err = pcall(function()
                local info = getNPCByName("Cupid Queen")
                if not info then
                    return
                end
                if not queenDodging and isQueenCastingBlockableSkill(info.model) then
                    queenDodging = true
                    debug("Queen casting detected - dodging (watcher)")
                    queenDodgeUntilSafe(function()
                        return getNPCByName("Cupid Queen")
                    end)
                    if enabled and getNPCByName("Cupid Queen") then
                        setNavNamed("Cupid Queen")
                    end
                    queenDodging = false
                end
            end)
            if not ok then
                debug("queenDodgeWatcher error:", err)
            end
            task.wait(0.03)
        end
        queenWatcherStarted = false
    end)
end

-- ========================= NAV (hover/fall anti-AFK loop) =========================

local function getNavTargets()
    -- Returns aimPos (where to hover, may include a height offset), facePos
    -- (the real thing to look at, e.g. the NPC itself, not the point above it)
    local ok, aimR, faceR = pcall(function()
        if NavState.mode == "point" and NavState.point then
            return NavState.point, NavState.point
        elseif NavState.mode == "npc" then
            local info = getNearestNPC(stuckNPCs)
            if info then
                trackNPCDamage(info)
                local predicted = predictNPCPosition(info)
                return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
            end
        elseif NavState.mode == "named" and NavState.name then
            local info = getNPCByName(NavState.name)
            if info then
                local predicted = predictNPCPosition(info)
                return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
            end
        end
        return nil, nil
    end)
    if ok then
        return aimR, faceR
    end
    debug("getNavTargets error:", aimR)
    return nil, nil
end

local function computeLookDownCFrame(root, targetPos)
    -- Always look at targetPos (including its real height, so this tilts
    -- down at NPCs below you), but never feeds CFrame.lookAt a degenerate
    -- (near-zero or near-vertical) direction, which produces a NaN CFrame
    -- that Roblox sanitizes by voiding the character.
    local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
    if horiz.Magnitude < 0.5 then
        -- Synthesize a small horizontal offset from current facing so the
        -- look direction stays valid even when hovering directly above/below.
        local fwd = root.CFrame.LookVector
        local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
        if fwdFlat.Magnitude < 0.01 then
            fwdFlat = Vector3.new(0, 0, 1)
        end
        horiz = fwdFlat.Unit * 5
    end
    local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
    return CFrame.lookAt(root.Position, lookPoint)
end

-- Combat position lock: the weapon's own lunge/push force on M1 swings
-- stacks with __HoverForce (a separate BodyMover/velocity write on top of
-- ours), which is what drags us off a moving NPC. A LinearVelocity target
-- only gets re-asserted once per Heartbeat, so a mid-frame push is briefly
-- visible before we correct it — and if the NPC moved during that window
-- too, we drift. A direct CFrame write has no such window: it always wins
-- over any force/velocity mover for that physics step, since it overwrites
-- the *result*, not another input into the solver. So instead of only
-- correcting orientation during "hover", we correct position too, but only
-- in npc/named (combat) modes — "point" mode keeps the smooth velocity
-- hover so stage-to-stage travel doesn't look like teleporting.
local COMBAT_LOCK_MODES = { npc = true, named = true }

local function computeLockedCFrame(root, aimPos, facePos)
    local ok, result = pcall(function()
        return computeLookDownCFrame(root, facePos) + (aimPos - root.Position)
    end)
    if ok then
        return result
    end
    debug("computeLockedCFrame error:", result)
    return nil
end

local function setNavPoint(pos)
    NavState = { mode = "point", point = pos }
    phase = "move"
end

function navToPoint(pos, skipExtraGeppo)
    -- Invoke Geppo before any move that increases height, since the game's
    -- own Geppo module (double-jump/sky-walk) expects that to justify climbing.
    -- Stage-to-stage flights (Stage1 -> ... -> Leo -> Cupid Queen, the arrow
    -- fly-down area, etc.) can easily outlast a single jump's hang time, so
    -- follow the initial press with 2 more, 2s apart, in the background.
    -- skipExtraGeppo lets in-combat dodge callers (Leo/Queen dodges) opt out
    -- since those already run their own tailored repeat loop on top of this.
    local ok, err = pcall(function()
        local root = Core.GetRoot(LocalPlayer)
        if root and pos.Y - root.Position.Y > GEPPO_CLIMB_THRESHOLD then
            invokeGeppo()
            if not skipExtraGeppo then
                task.spawn(function()
                    for _ = 1, 2 do
                        task.wait(GEPPO_HOLD_INTERVAL)
                        invokeGeppo()
                    end
                end)
            end
        end
    end)
    if not ok then
        debug("navToPoint geppo check error:", err)
    end
    setNavPoint(pos)
end

local function setNavNPCNearest()
    NavState = { mode = "npc" }
    phase = "move"
end
function setNavNamed(name)
    NavState = { mode = "named", name = name }
    phase = "move"
end
local function setNavIdle()
    NavState = { mode = "idle" }
    phase = "move"
end

local function hasArrived()
    return phase == "hover"
end

local function startNav()
    phase = "move"
    debug("Nav loop ON")
    navConn = RunService.Heartbeat:Connect(function(dt)
        local ok, err = pcall(function()
            local root = Core.GetRoot(LocalPlayer)
            if not root then
                return
            end

            local hum = getHumanoid()
            if hum and hum.Health <= 0 then
                debug("Player died! Stopping bot.")
                disableBot()
                return
            end

            local aim, face = getNavTargets()
            if aim then
                lastAim = aim
                lastFace = face
            else
                aim = lastAim or root.Position
                face = lastFace or aim
            end

            local pos = root.Position
            local yErr = aim.Y - pos.Y
            local xzDist = Vector3.new(pos.X - aim.X, 0, pos.Z - aim.Z).Magnitude

            -- If player is too far from aim point (> 2000 studs), they likely died and respawned at lobby
            if (pos - aim).Magnitude > 2000 then
                debug("Player is too far from target (>2000 studs). Likely respawned at lobby. Stopping bot.")
                disableBot()
                return
            end

            local xzDir = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
            local xzVel = xzDir.Magnitude > 0 and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
                or Vector3.zero

            local force = getOrCreateForce(root)
            if not force then
                return
            end

            -- DIAGNOSTIC: catch a runaway/unexpected teleport the instant it happens
            local prevPos = force:GetAttribute("__prevPos")
            if prevPos then
                local delta = (pos - prevPos).Magnitude
                if delta > 100 then
                    debug("Large position jump detected:", delta, "studs. prevPos=", prevPos, "newPos=", pos)
                end
            end
            force:SetAttribute("__prevPos", pos)

            local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
            if phase == "move" and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
                phase = "hover"
                debug("Phase: hover")
            end

            local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
            if finalVel.Magnitude > 200 then
                debug("!!! REFUSING TO APPLY ABNORMAL VELOCITY:", finalVel, "aim=", aim, "pos=", pos)
                finalVel = Vector3.zero
            end
            force.VectorVelocity = finalVel

            if phase == "hover" then
                pcall(function()
                    if COMBAT_LOCK_MODES[NavState.mode] then
                        local snapDist = (aim - root.Position).Magnitude
                        if snapDist <= COMBAT_LOCK_MAX_SNAP then
                            local locked = computeLockedCFrame(root, aim, face)
                            if locked then
                                root.CFrame = locked
                            else
                                root.CFrame = computeLookDownCFrame(root, face)
                            end
                        else
                            -- Target is farther than a normal weapon-push
                            -- displacement should ever cause — don't teleport
                            -- to catch up. Drop back to "move" so the
                            -- velocity-based hover closes the gap smoothly;
                            -- only correct orientation this frame.
                            debug("Combat lock skipped,", snapDist, "studs from target — falling back to move")
                            phase = "move"
                            root.CFrame = computeLookDownCFrame(root, face)
                        end
                    else
                        root.CFrame = computeLookDownCFrame(root, face)
                    end
                end)
            end
        end)
        if not ok then
            debug("Heartbeat error:", err)
        end
    end)
end

local function stopNav()
    debug("Nav loop OFF")
    if navConn then
        navConn:Disconnect()
        navConn = nil
    end
    cleanupForce()
    phase = "move"
end

local function sendChatMessage(message)
    -- Tries the modern chat (TextChatService) first, falls back to the
    -- legacy chat remote for games still on the old chat system.
    local ok, err = pcall(function()
        local TextChatService = game:GetService("TextChatService")
        local channels = TextChatService:FindFirstChild("TextChannels")
        local channel = channels and channels:FindFirstChild("RBXGeneral")
        if channel then
            channel:SendAsync(message)
            return
        end

        local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        local sayEvent = chatEvents and chatEvents:FindFirstChild("SayMessageRequest")
        if sayEvent then
            sayEvent:FireServer(message, "All")
            return
        end

        debug("sendChatMessage: no TextChatService.RBXGeneral or legacy SayMessageRequest found for", message)
    end)
    if not ok then
        debug("sendChatMessage error:", err)
    end
end

local function waitUntilArrived(timeout)
    -- Stuck detection lives HERE rather than as a standalone background
    -- watcher, so it only ever runs while we're actually flying to a stage
    -- or back to a stage position (every waitUntilArrived call site is one
    -- of those) - never during combat (npc/named nav never calls this) or
    -- while intentionally holding position (dodges, statues - phase is
    -- already "hover"/idle there, so this loop wouldn't even be running).
    local t = 0
    local lastPos = nil
    local stuckTicks = 0
    local sinceStuckCheck = 0
    local lastUnstuckSent = -math.huge
    while enabled and not hasArrived() do
        task.wait(0.2)
        t += 0.2
        sinceStuckCheck += 0.2

        if sinceStuckCheck >= UNSTUCK_CHECK_INTERVAL then
            sinceStuckCheck = 0
            local root = Core.GetRoot(LocalPlayer)
            if root then
                local pos = root.Position
                if lastPos then
                    local moved = (pos - lastPos).Magnitude
                    if moved < UNSTUCK_MOVE_THRESHOLD then
                        stuckTicks += 1
                    else
                        stuckTicks = 0
                    end
                end
                lastPos = pos

                if stuckTicks >= UNSTUCK_STUCK_TICKS and (tick() - lastUnstuckSent) > UNSTUCK_COOLDOWN then
                    debug(
                        "Not making progress toward nav target for",
                        stuckTicks * UNSTUCK_CHECK_INTERVAL,
                        "s - sending /unstuck"
                    )
                    sendChatMessage("/unstuck")
                    lastUnstuckSent = tick()
                    stuckTicks = 0
                end
            end
        end

        if timeout and t > timeout then
            debug("waitUntilArrived timeout")
            break
        end
    end
end

local function navToPointConfirmed(pos, timeout, label)
    -- Same as navToPoint + waitUntilArrived, but waitUntilArrived returns
    -- the same way whether we actually arrived or just gave up on the
    -- timeout - which lets the plan silently move on to the NEXT step from
    -- wherever we really are (e.g. still fighting to descend out of a
    -- dodge) instead of from the intended stage position. This checks
    -- hasArrived() after the wait and, if we didn't really make it, logs
    -- it clearly and retries once before giving up for good.
    navToPoint(pos)
    waitUntilArrived(timeout)
    if not hasArrived() then
        debug("navToPointConfirmed:", label or "target", "- did not arrive within", timeout, "s, retrying once")
        navToPoint(pos)
        waitUntilArrived(timeout)
        if not hasArrived() then
            debug("navToPointConfirmed:", label or "target", "- still not arrived after retry, proceeding anyway")
        end
    end
end

local function navToPointHoldingBlock(pos, timeout, blockDelay)
    -- Starts the flight to `pos`, waits `blockDelay` seconds (if given)
    -- before engaging Block, then holds it for the rest of the flight,
    -- releasing it the instant we arrive (or the nav times out) — used for
    -- the Stage4 -> Leo flight so nothing tags us for free while cruising,
    -- without blocking the instant we leave Stage4.
    navToPoint(pos)

    if blockDelay and blockDelay > 0 then
        task.wait(blockDelay)
    end

    local ok, err = pcall(function()
        VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
    end)
    if not ok then
        debug("navToPointHoldingBlock key-down error:", err)
    end

    waitUntilArrived(timeout)

    local ok2, err2 = pcall(function()
        VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
    end)
    if not ok2 then
        debug("navToPointHoldingBlock key-up error:", err2)
    end
end

local function walkToPoint(pos, timeout, useJumpUnstuck)
    timeout = timeout or 30
    local root = Core.GetRoot(LocalPlayer)
    if not root then
        return
    end

    debug("Walking to:", pos)

    local wasNavActive = (navConn ~= nil)
    if wasNavActive then
        stopNav()
    end

    cleanupForce()

    -- Press W
    local ok, err = pcall(function()
        VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
    end)
    if not ok then
        debug("walkToPoint W down error:", err)
    end

    local startT = tick()
    local lastDash = 0
    local dashCooldown = 3

    local hum = getHumanoid()
    local startHP = hum and hum.Health or math.huge

    local lastUnstuckCheck = tick()
    local lastPos = nil
    local stuckTicks = 0

    while enabled and (tick() - startT < timeout) do
        local currentRoot = Core.GetRoot(LocalPlayer)
        if not currentRoot then
            break
        end

        local currentHum = getHumanoid()
        if currentHum and currentHum.Health < startHP then
            debug("Took damage while walking to point! Stopping walk to engage.")
            break
        end
        if currentHum then
            startHP = currentHum.Health
        end -- Update startHP in case they heal

        local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
        if dist < 5 then
            debug("Arrived at:", pos)
            break
        end

        if useJumpUnstuck then
            if tick() - lastUnstuckCheck > 0.5 then
                if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
                    debug("Stuck during walk, jumping!")
                    stuckTicks += 1

                    VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    task.wait(0.05)
                    VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)

                    if stuckTicks > 1 then
                        debug("Still stuck, triggering Geppo!")
                        task.wait(0.05)
                        VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                        task.wait(0.05)
                        VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                        task.wait(0.05)
                        VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                        task.wait(0.05)
                        VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                        stuckTicks = 0
                    end
                else
                    stuckTicks = 0
                end
                lastPos = currentRoot.Position
                lastUnstuckCheck = tick()
            end
        end

        -- Aim camera and body
        pcall(function()
            local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
            currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
            Workspace.CurrentCamera.CFrame = CFrame.lookAt(
                Workspace.CurrentCamera.CFrame.Position,
                currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10
            )
        end)

        -- Dash
        if tick() - lastDash >= dashCooldown then
            pcall(function()
                VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                task.wait(0.05)
                VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
            end)
            lastDash = tick()
        end

        task.wait()
    end

    -- Release W
    pcall(function()
        VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
    end)

    if wasNavActive and enabled then
        startNav()
    end
end

-- ========================= PLAN STEPS =========================

local function clearStage(stageName, targetHP)
    targetHP = targetHP or 0.95
    debug("Moving to", stageName)
    walkToPoint(COORDS[stageName], 30)

    -- Wait for NPCs to actually spawn instead of guessing a fixed delay
    debug("Waiting for NPCs to spawn at", stageName)
    local waited = 0
    while enabled and npcsRemaining() == 0 do
        local folder = getNPCsFolder()
        debug(
            "  spawn check: folder exists =",
            folder ~= nil,
            ", children =",
            folder and #folder:GetChildren() or 0,
            ", alive =",
            npcsRemaining()
        )
        task.wait(1)
        waited += 1
        if waited > 15 then
            debug("No NPCs appeared at", stageName, "after 15s, moving on anyway")
            break
        end
    end

    debug("Killing NPCs at", stageName)
    equipSwordOrMelee()
    setNavNPCNearest()
    local m1Combo = 0
    local m1Target = math.random(4, 5)
    while enabled and npcsRemaining() > 0 do
        equipSwordOrMelee()
        clickM1(0.05)
        m1Combo += 1
        if m1Combo >= m1Target then
            m1Combo = 0
            m1Target = math.random(4, 5)
            task.wait(0.2)
        end
        task.wait(MELEE_CLICK_INTERVAL)
    end

    debug("Returning to", stageName, "position before moving on")
    navToPoint(COORDS[stageName])
    waitUntilArrived(30)

    debug("Waiting 5s at", stageName, "position")
    task.wait(5)

    debug("Waiting for", targetHP * 100, "% HP before moving to next stage")
    local hum = getHumanoid()
    if hum then
        while enabled and hum.Health < hum.MaxHealth * targetHP do
            task.wait(1)
        end
    end

    debug(stageName, "cleared")
end

local function killNamedNPC(name, targetPos)
    debug("Moving to", name)
    navToPoint(targetPos)
    waitUntilArrived(30)

    equipSwordOrMelee()
    setNavNamed(name)
    local m1Combo = 0
    local m1Target = math.random(4, 5)
    while enabled and getNPCByName(name) do
        equipSwordOrMelee()
        clickM1(0.05)
        m1Combo += 1
        if m1Combo >= m1Target then
            m1Combo = 0
            m1Target = math.random(4, 5)
            task.wait(0.2)
        end
        task.wait(MELEE_CLICK_INTERVAL)
    end
    debug(name, "defeated")
end

local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
    local ok, err = pcall(function()
        local hum = model:FindFirstChildWhichIsA("Humanoid")
        if not hum then
            return
        end
        if leoAnimLoggerConn then
            leoAnimLoggerConn:Disconnect()
        end
        leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
            local ok2, err2 = pcall(function()
                debug(
                    "Leo played animation:",
                    track.Animation and track.Animation.Name,
                    "-",
                    track.Animation and track.Animation.AnimationId
                )
            end)
            if not ok2 then
                debug("leoAnimLogger print error:", err2)
            end
        end)
    end)
    if not ok then
        debug("startLeoAnimLogger error:", err)
    end
end

local function stopLeoAnimLogger()
    if leoAnimLoggerConn then
        leoAnimLoggerConn:Disconnect()
        leoAnimLoggerConn = nil
    end
end

local function fightLeo()
    debug("Moving to Leo")
    equipSwordOrMelee()
    walkToPoint(COORDS.Leo, 30)

    local leoModel = getNPCByName("Leo")
    if leoModel then
        startLeoAnimLogger(leoModel.model)
    end

    equipSwordOrMelee()
    setNavNamed("Leo")
    local m1Combo = 0
    local m1Target = math.random(4, 5)
    while enabled do
        local info = getNPCByName("Leo")
        if not info then
            break
        end

        local casting, which = isCastingDodgeSkill(info.model)
        if casting then
            debug("Leo casting", which, "- dodging")
            if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
                -- Hold block to tank Firefly + Hiken combo (projectiles take time to travel)
                -- Continuously check for block-breakers (Entei/Pillar) to evade immediately
                VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
                local holdTime = 0
                while enabled and holdTime < 3.5 do
                    local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
                    if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
                        debug("Leo started block-breaker mid-block! Evading...")
                        break
                    end
                    task.wait(0.1)
                    holdTime += 0.1
                end
                VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
            else
                local root = Core.GetRoot(LocalPlayer)
                local myPos = root and root.Position or info.root.Position
                local bossPos = info.root.Position

                -- Dodge horizontally to avoid flight anti-cheat
                local flatDir = Vector3.new(myPos.X - bossPos.X, 0, myPos.Z - bossPos.Z)
                if flatDir.Magnitude < 1 then
                    flatDir = Vector3.new(1, 0, 0)
                end
                local awayPoint = myPos + (flatDir.Unit * LEO_DODGE_DISTANCE)
                awayPoint = Vector3.new(awayPoint.X, bossPos.Y + HOVER_OFFSET, awayPoint.Z)

                navToPoint(awayPoint, true)

                if which == LEO_ENTEI_ANIM_ID then
                    local held = 0
                    while enabled and held < 6 do
                        task.wait(1)
                        held += 1
                        if not getNPCByName("Leo") then
                            debug("Leo gone mid-dodge - ending Entei hold early")
                            break
                        end
                    end
                else -- Flame Pillar
                    task.wait(4)
                end
            end

            if enabled and getNPCByName("Leo") then
                setNavNamed("Leo")
            end
        else
            -- Only ever reached when NOT dodging (casting == false), so
            -- blocking here structurally never overlaps with a dodge.
            equipSwordOrMelee()
            if isNPCBlocking(info.model) then
                pressSkillR()
                m1Combo = 0
            elseif not isRealM1Busy() then
                clickM1(0.05)
                m1Combo += 1
                if m1Combo >= m1Target then
                    m1Combo = 0
                    m1Target = math.random(4, 5)
                    task.wait(0.2)
                end
            end
            waitOrReact(MELEE_CLICK_INTERVAL, function()
                return isCastingDodgeSkill(info.model) or isNPCBlocking(info.model)
            end)
        end
    end
    debug("Leo defeated")
    stopLeoAnimLogger()

    debug("Returning to Leo position before moving on")
    navToPointConfirmed(COORDS.Leo, 30, "Leo position")

    debug("Waiting 5s at Leo position")
    task.wait(5)
end

local function destroyStatue(coordKey)
    local coordPos = COORDS[coordKey]
    debug("Moving to", coordKey)
    navToPoint(coordPos)
    waitUntilArrived(30)

    local statueModel = getStatueModelNear(coordPos)
    if not statueModel then
        debug("Could not find statue model near", coordKey)
        return
    end

    local weapon = equipSwordOrMelee()
    debug("Attacking", coordKey, "with", weapon or "nothing found")
    setNavIdle() -- freeze here; hover/fall anti-AFK cycle keeps running in place

    while enabled and getStatueHP(statueModel) > 0 do
        local root = Core.GetRoot(LocalPlayer)
        local facePos = getModelFacePos(statueModel)
        if root and facePos then
            pcall(function()
                root.CFrame = computeLookDownCFrame(root, facePos)
            end)
        end
        clickM1(0.05)
        task.wait(MELEE_CLICK_INTERVAL)
    end
    debug(coordKey, "barrel destroyed")
end

local function recheckStatue(coordKey)
    -- Re-verifies a statue we already destroyed is still at 0 HP before
    -- moving on. If it somehow isn't (respawn/resync/whatever), re-run the
    -- full destroyStatue flow on it instead of just flagging it.
    local ok, err = pcall(function()
        local coordPos = COORDS[coordKey]
        local statueModel = getStatueModelNear(coordPos)
        if not statueModel then
            debug("recheckStatue:", coordKey, "- could not find statue model, skipping")
            return
        end
        local hp = getStatueHP(statueModel)
        if hp > 0 then
            debug("recheckStatue:", coordKey, "still alive (HP", hp, ") - re-destroying")
            destroyStatue(coordKey)
        else
            debug("recheckStatue:", coordKey, "confirmed destroyed")
        end
    end)
    if not ok then
        debug("recheckStatue error:", coordKey, err)
    end
end

local function fightQueenUntilPhase2()
    debug("Moving to Queen")
    walkToPoint(COORDS.Queen, 30)

    equipSwordOrMelee()
    setNavNamed("Cupid Queen")
    startQueenDodgeWatcher()
    local m1Combo = 0
    local m1Target = math.random(4, 5)
    while enabled and not isQueenPhase2() do
        if queenDodging then
            task.wait(0.05)
        else
            local info = getNPCByName("Cupid Queen")
            equipSwordOrMelee()
            if info and isNPCBlocking(info.model) then
                pressSkillR()
                m1Combo = 0
            else
                clickM1(0.05)
                m1Combo += 1
                if m1Combo >= m1Target then
                    m1Combo = 0
                    m1Target = math.random(4, 5)
                    task.wait(0.2)
                end
            end
            task.wait(MELEE_CLICK_INTERVAL)
        end
    end
    debug("Queen entered phase 2")
end

local function finishQueen()
    debug("Finishing Queen")
    equipSwordOrMelee()
    setNavNamed("Cupid Queen")
    startQueenDodgeWatcher()
    local m1Combo = 0
    local m1Target = math.random(4, 5)
    while enabled and getNPCByName("Cupid Queen") do
        if queenDodging then
            task.wait(0.05)
        else
            local info = getNPCByName("Cupid Queen")
            equipSwordOrMelee()
            if info and isNPCBlocking(info.model) then
                pressSkillR()
                m1Combo = 0
            else
                clickM1(0.05)
                m1Combo += 1
                if m1Combo >= m1Target then
                    m1Combo = 0
                    m1Target = math.random(4, 5)
                    task.wait(0.2)
                end
            end
            task.wait(MELEE_CLICK_INTERVAL)
        end
    end
    debug("Queen defeated. Plan complete.")
end

-- ========================= REPLAY PROMPT =========================
-- Confirmed path: PlayerGui.ConfirmationPrompt.RemoteEvent. The instance
-- gets Destroy()'d once answered (see fireValue in the decompiled script),
-- but it's recreated under the same name each time the prompt reappears, so
-- WaitForChild on that fixed name/path is reliable — no need to scan for it.
-- The buttonValue == "Replay" search + ancestor walk-up is kept only as a
-- fallback in case that name or path ever changes.

local CONFIRMATION_PROMPT_NAME = "ConfirmationPrompt"

local function getReplayRemote()
    local ok, result = pcall(function()
        local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
        local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
        if not prompt then
            return nil
        end
        return prompt:WaitForChild("RemoteEvent", 5)
    end)
    if ok then
        return result
    end
    debug("getReplayRemote error:", result)
    return nil
end

local function findButtonByValue(value)
    local ok, result = pcall(function()
        local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then
            return nil
        end
        for _, obj in ipairs(playerGui:GetDescendants()) do
            if obj:IsA("ImageButton") then
                local ok2, val = pcall(function()
                    return obj:GetAttribute("buttonValue")
                end)
                if ok2 and val == value then
                    return obj
                end
            end
        end
        return nil
    end)
    if ok then
        return result
    end
    debug("findButtonByValue error:", result)
    return nil
end

local function clickGuiButton(button)
    local ok, err = pcall(function()
        local pos, size = button.AbsolutePosition, button.AbsoluteSize
        local x = math.floor(pos.X + size.X / 2)
        local y = math.floor(pos.Y + size.Y / 2)
        VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
    end)
    if not ok then
        debug("clickGuiButton error:", err)
    end
end

local function findAnswerConnector(button)
    -- Walks up from the button until it finds the instance with the
    -- "isServer" attribute set (that's "Parent" in the decompiled script),
    -- then returns whichever sibling event it actually answers through.
    local ok, connector, isServer = pcall(function()
        local inst = button
        for _ = 1, 8 do
            inst = inst.Parent
            if not inst then
                return nil, nil
            end
            local isServerAttr = inst:GetAttribute("isServer")
            if isServerAttr ~= nil then
                local child = isServerAttr and inst:FindFirstChild("RemoteEvent") or inst:FindFirstChild("clientEvent")
                if child then
                    return child, isServerAttr
                end
            end
        end
        return nil, nil
    end)
    if ok then
        return connector, isServer
    end
    debug("findAnswerConnector error:", connector)
    return nil, nil
end

local function fireReplayValue(button)
    local connector, isServer = findAnswerConnector(button)
    if not connector then
        debug("Could not locate RemoteEvent/clientEvent near Replay button, falling back to click")
        clickGuiButton(button)
        return
    end
    local ok, err = pcall(function()
        if isServer then
            connector:FireServer(REPLAY_BUTTON_VALUE)
        else
            connector:Fire(REPLAY_BUTTON_VALUE)
        end
    end)
    if not ok then
        debug("fireReplayValue error:", err, "- falling back to click")
        clickGuiButton(button)
    end
end

local function fallbackButtonSearch()
    debug("Falling back to buttonValue search for Replay")
    local waited = 0
    local button = nil
    while enabled and waited < REPLAY_PROMPT_TIMEOUT do
        button = findButtonByValue(REPLAY_BUTTON_VALUE)
        if button then
            break
        end
        task.wait(0.5)
        waited += 0.5
    end
    if not button then
        debug("Replay button not found either, giving up")
        return
    end
    task.wait(REPLAY_CLICK_SETTLE)
    fireReplayValue(button)
end

local function handleReplayPrompt()
    debug("Waiting for ConfirmationPrompt.RemoteEvent")
    local remote = getReplayRemote()
    if not remote then
        debug("ConfirmationPrompt/RemoteEvent not found within timeout")
        fallbackButtonSearch()
        return
    end
    task.wait(REPLAY_CLICK_SETTLE) -- let the entrance tween finish before answering
    debug("Firing Replay via ConfirmationPrompt.RemoteEvent")
    local ok, err = pcall(function()
        remote:FireServer(REPLAY_BUTTON_VALUE)
    end)
    if not ok then
        debug("FireServer error:", err)
        fallbackButtonSearch()
    end
end

local function waitForObjectivesGui()
    -- PlayerGui.Objectives existing is a direct signal the match/stage has
    -- actually loaded, unlike inferring it from a >100 stud position jump
    -- (which can false-negative if the teleport lands close to the old
    -- position, or false-positive off knockback/dodge movement). Nav/hover
    -- is intentionally NOT started until this resolves, so the hover force
    -- can't engage before (or fight) the actual load-in.
    local ok, err = pcall(function()
        local player = Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui", 10)
        if not playerGui then
            debug("waitForObjectivesGui: no PlayerGui within timeout, proceeding anyway")
            return
        end
        local waited = 0
        while enabled do
            if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
                debug("Objectives GUI found - stage loaded")
                return
            end
            task.wait(0.2)
            waited += 0.2
            if waited > OBJECTIVES_WAIT_MAX then
                debug("Objectives GUI not found within timeout, proceeding anyway")
                return
            end
        end
    end)
    if not ok then
        debug("waitForObjectivesGui error:", err)
    end
end

local function runPlan()
    debug("Plan started")

    -- Step 1: loading + stage-ready wait. Nav/hover is intentionally NOT
    -- started until this resolves, so the hover force can't engage before
    -- (or fight) the actual load-in.
    task.wait(LOAD_WAIT)
    waitForObjectivesGui()

    debug("Starting nav loop")
    startNav()
    task.spawn(function()
        task.wait(0.2)
        local rootAfter = Core.GetRoot(LocalPlayer)
        debug("pos 0.2s AFTER startNav:", rootAfter and rootAfter.Position)
    end)

    debug("Waiting 5s before moving to Stage1")
    task.wait(5)

    -- Steps 2-3: Stage1 -> Stage2 -> Stage3 -> Stage3B
    for _, stage in ipairs({ "Stage1", "Stage2", "Stage3", "Stage3B" }) do
        if not enabled then
            return
        end
        local hpTarget = (stage == "Stage3B") and 0.40 or 0.95
        clearStage(stage, hpTarget)
    end

    -- Step 4: dodge arrow rain at the arrow area in a square on the ground
    if not enabled then
        return
    end
    debug("Moving to arrow fly-down area (Cupid Rain)")
    walkToPoint(COORDS.ArrowFlyDown, 30, true) -- true enables Jump/Geppo unstuck

    debug("Dodging arrow rain in a square")
    local elapsed = 0
    local d = ARROW_DODGE_DISTANCE
    local corners = {
        COORDS.ArrowFlyDown + Vector3.new(d, 0, d),
        COORDS.ArrowFlyDown + Vector3.new(-d, 0, d),
        COORDS.ArrowFlyDown + Vector3.new(-d, 0, -d),
        COORDS.ArrowFlyDown + Vector3.new(d, 0, -d),
    }

    local startT = tick()
    local cornerIdx = 1
    while enabled and (tick() - startT) < ARROW_HOVER_WAIT do
        walkToPoint(corners[cornerIdx], 5)
        cornerIdx = (cornerIdx % 4) + 1
    end

    -- Step 5: Stage4
    if not enabled then
        return
    end
    clearStage("Stage4")

    -- Step 6: Leo (dodges Flame Pillar / Entei by AnimationId)
    if not enabled then
        return
    end
    fightLeo()

    -- Step 7: Queen phase 1
    if not enabled then
        return
    end
    fightQueenUntilPhase2()

    debug("Queen in phase 2 - keeping Ken Haki active from here on")
    startKenKeeper()

    -- Step 8: statues, rechecking every previously-destroyed statue before
    -- moving on to the next one
    if not enabled then
        return
    end
    destroyStatue("Statue1")

    if not enabled then
        return
    end
    recheckStatue("Statue1")
    destroyStatue("Statue2")

    if not enabled then
        return
    end
    recheckStatue("Statue1")
    recheckStatue("Statue2")
    destroyStatue("Statue3")

    -- Step 9: recheck all three statues, wait for phase 2 to end, finish Queen
    if not enabled then
        return
    end
    recheckStatue("Statue3")
    recheckStatue("Statue2")
    recheckStatue("Statue1")

    if not enabled then
        return
    end
    debug("Waiting for phase 2 to end")
    local t2 = 0
    while enabled and isQueenPhase2() do
        task.wait(0.3)
        t2 += 0.3
        if t2 > 120 then
            debug("Phase 2 end wait timeout, proceeding anyway")
            break
        end
    end
    if not enabled then
        return
    end
    finishQueen()

    -- Step 10: back to Queen stage position, then to the spot where the
    -- replay prompt appears
    if not enabled then
        return
    end
    debug("Moving back to Queen stage position")
    navToPointConfirmed(COORDS.Queen, 30, "Queen stage position")

    debug("Waiting 5s at Queen stage position")
    task.wait(5)

    if not enabled then
        return
    end
    debug("Moving to post-Queen position")
    navToPointConfirmed(COORDS.PostQueen, 30, "post-Queen position")

    -- Step 11: click Replay
    if not enabled then
        return
    end
    handleReplayPrompt()

    enabled = false
    stopNav()
end

-- ========================= TOGGLE / AUTOSTART =========================

local CupidDungeon = {
    Connections = {},
}

local function enableBot()
    if enabled then
        return
    end
    enabled = true
    local rootBefore = Core.GetRoot(LocalPlayer)
    debug("Enabling, pos BEFORE plan:", rootBefore and rootBefore.Position)
    startBusoKeeper()
    task.spawn(function()
        local ok2, err2 = pcall(runPlan)
        if not ok2 then
            debug("Plan error:", err2)
        end
    end)
    debug("Enabled:", enabled)
end

local function disableBot()
    if not enabled then
        return
    end
    enabled = false
    stopNav()
    debug("Enabled:", enabled)
end

function CupidDungeon.Start()
    if enabled then
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.RequirePlace(11424731604, "Cupid Dungeon") then
        return
    end
    enableBot()
end

function CupidDungeon.Stop()
    if not enabled then
        return
    end
    disableBot()
end

Core.SetupStandalone(CupidDungeon, "Cupid Dungeon", CupidDungeon.Start, CupidDungeon.Stop, function()
    return enabled
end)

return CupidDungeon


end

local function loadHoroBossFarm()
    
--[[
    Horo Horo Z-Skill Loop Farm - v0.0.3
    Automates skills on a selected boss using reliable camera alignment and viewport targeting.
    Headless module compatible with hub or standalone execution.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local HoroFarm = {
    Running = false,
    Connections = {},
    Config = {
        SelectedBoss = "Juzo the Diamondback", -- Default boss
        UseE = true,
        UseZ = true,
        UseC = true,
        UseR = true,
        CameraHeight = 30.0,
        LoopDelay = 10.5,
        CameraLock = true, -- true = visual bird's eye view; false = pure virtual in-memory camera (free player camera)
    },
}

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()
local Safeguard = Core.GetSafeguard()

local lastC = 0
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = "HoroCameraLock"

-- In-memory virtual camera for when CameraLock = false
local VirtualCamera = Instance.new("Camera")
VirtualCamera.FieldOfView = Camera.FieldOfView

local function equipHoroTool()
    local bp = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    if not char then
        return nil
    end

    local tool = char:FindFirstChild("Horo-Horo") or (bp and bp:FindFirstChild("Horo-Horo"))
    if tool and tool.Parent ~= char then
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum:EquipTool(tool)
        end
    end
    return tool
end

local function getBossPart(name)
    local npts = Workspace:FindFirstChild("NPCs")
    if not npts then
        return nil
    end

    if name and name ~= "" then
        local boss = npts:FindFirstChild(name)
        if boss then
            local root = boss:FindFirstChild("HumanoidRootPart")
            local hum = boss:FindFirstChildWhichIsA("Humanoid")
            if root and hum and hum.Health > 0 then
                return root
            end
        end
    end

    -- Auto-fallback to any alive boss in NPCs if selectedBoss not found
    for _, npc in ipairs(npts:GetChildren()) do
        local root = npc:FindFirstChild("HumanoidRootPart")
        local hum = npc:FindFirstChildWhichIsA("Humanoid")
        if root and hum and hum.Health > 0 and hum.MaxHealth > 1000 then
            return root
        end
    end

    return nil
end

local smoothedFloorY = nil
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude

local function calculateSafeCameraCFrame(targetRoot)
    local bossPos = targetRoot.Position

    if not smoothedFloorY then
        smoothedFloorY = bossPos.Y
    end

    if math.abs(bossPos.Y - smoothedFloorY) > 25 then
        smoothedFloorY = bossPos.Y
    else
        smoothedFloorY = smoothedFloorY + (bossPos.Y - smoothedFloorY) * 0.05
    end

    local filterList = {}
    if LocalPlayer.Character then
        table.insert(filterList, LocalPlayer.Character)
    end
    if targetRoot.Parent then
        table.insert(filterList, targetRoot.Parent)
    end
    rayParams.FilterDescendantsInstances = filterList

    local idealCamPos = Vector3.new(bossPos.X, smoothedFloorY + HoroFarm.Config.CameraHeight, bossPos.Z)
    local losRay = Workspace:Raycast(bossPos, idealCamPos - bossPos, rayParams)
    local safeCamPos = idealCamPos

    if losRay then
        local hitDist = (losRay.Position - bossPos).Magnitude
        if hitDist > 3 then
            safeCamPos = bossPos + (idealCamPos - bossPos).Unit * (hitDist - 1.5)
        else
            safeCamPos = losRay.Position + (bossPos - losRay.Position).Unit * 1.5
        end
    end

    return CFrame.lookAt(safeCamPos, bossPos)
end

local function lockCameraToBoss(targetRoot)
    if not savedCameraCF and HoroFarm.Config.CameraLock then
        savedCameraCF = Camera.CFrame
        savedCameraType = Camera.CameraType
    end

    if not cameraBound then
        cameraBound = true
        smoothedFloorY = targetRoot.Position.Y

        RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
            if
                targetRoot
                and targetRoot.Parent
                and targetRoot.Parent:FindFirstChildWhichIsA("Humanoid")
                and targetRoot.Parent:FindFirstChildWhichIsA("Humanoid").Health > 0
            then
                local bossPos = targetRoot.Position
                local targetCF = calculateSafeCameraCFrame(targetRoot)

                local activeCam = Camera
                if HoroFarm.Config.CameraLock then
                    Camera.CameraType = Enum.CameraType.Scriptable
                    Camera.CFrame = targetCF
                    activeCam = Camera
                else
                    VirtualCamera.ViewportSize = Camera.ViewportSize
                    VirtualCamera.FieldOfView = Camera.FieldOfView
                    VirtualCamera.CFrame = targetCF
                    activeCam = VirtualCamera
                end

                -- Continuous live mouse lock on boss screen coordinates
                local screenPos, onScreen = activeCam:WorldToViewportPoint(bossPos)
                if onScreen then
                    VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
                end
            else
                pcall(function()
                    RunService:UnbindFromRenderStep(BIND_NAME)
                end)
                cameraBound = false
                if savedCameraType and savedCameraCF then
                    Camera.CameraType = savedCameraType
                    Camera.CFrame = savedCameraCF
                    savedCameraType = nil
                    savedCameraCF = nil
                else
                    Camera.CameraType = Enum.CameraType.Custom
                end
            end
        end)
    end
end

local function unlockCamera()
    if cameraBound then
        pcall(function()
            RunService:UnbindFromRenderStep(BIND_NAME)
        end)
        cameraBound = false
    end
    if savedCameraType and savedCameraCF then
        Camera.CameraType = savedCameraType
        Camera.CFrame = savedCameraCF
        savedCameraType = nil
        savedCameraCF = nil
    else
        Camera.CameraType = Enum.CameraType.Custom
    end
end

function HoroFarm.Stop()
    HoroFarm.Running = false
    unlockCamera()
    print("[HoroFarm] Stopped.")
end

function HoroFarm.Start()
    if HoroFarm.Running then
        return
    end

    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end

    HoroFarm.Running = true
    print("[HoroFarm] Started targeting: " .. tostring(HoroFarm.Config.SelectedBoss))

    task.spawn(function()
        while HoroFarm.Running do
            local targetRoot = getBossPart(HoroFarm.Config.SelectedBoss)
            if not targetRoot then
                unlockCamera()
                task.wait(5)
            else
                lockCameraToBoss(targetRoot)
                local tool = equipHoroTool()

                if tool and getBossPart(HoroFarm.Config.SelectedBoss) then
                    local comboStart = tick()
                    local hollowsAttached = false

                    -- Step 1: Attach Hollows (C or Z)
                    if HoroFarm.Config.UseC and (tick() - lastC >= 60) then
                        VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
                        task.wait(0.05)
                        VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
                        lastC = tick()
                        hollowsAttached = true
                    elseif HoroFarm.Config.UseZ then
                        -- Summon hollows
                        VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                        task.wait(0.05)
                        VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
                        task.wait(0.3)

                        -- Aim cursor at boss via viewport projection
                        local currentTarget = getBossPart(HoroFarm.Config.SelectedBoss)
                        if currentTarget then
                            local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
                            if onScreen then
                                VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
                                task.wait(0.1)

                                -- Launch hollows
                                VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                                task.wait(0.05)
                                VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
                                hollowsAttached = true
                            end
                        end
                    end

                    -- Step 2: Stun (E)
                    if HoroFarm.Config.UseE and getBossPart(HoroFarm.Config.SelectedBoss) then
                        task.wait(0.2)
                        VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        task.wait(0.05)
                        VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                    end

                    -- Step 3: Detonation (R)
                    if HoroFarm.Config.UseR and hollowsAttached then
                        task.wait(2.0)
                        VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
                        task.wait(0.05)
                        VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
                    end

                    local baseCD = HoroFarm.Config.LoopDelay
                    if HoroFarm.Config.UseE then
                        baseCD = 17
                    end

                    local elapsed = tick() - comboStart
                    local finalSleep = math.max(baseCD - elapsed, 1)
                    task.wait(finalSleep)
                else
                    task.wait(1)
                end
            end
        end
        unlockCamera()
    end)
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(HoroFarm, "HoroFarm", HoroFarm.Start, HoroFarm.Stop, function()
    return HoroFarm.Running
end)

return HoroFarm


end

local function loadLevelGrinder()
    
--[[
    ================================================================================
    Level Grinder - Step-by-Step Level Grinder (Rifle Startup Refactor)
    ================================================================================
    Optimized auto-grinder.
    ================================================================================
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local LevelGrinder = {
    Running = false,
    Connections = {},
}

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()
local Safeguard = Core.GetSafeguard()

local oldStandalone = _G.DisableStandalone
_G.DisableStandalone = true

local ChestFarmer = (function()
    
--[[
    ============================================================
    LIBRARY: Peli Chest Farmer — Town of Beginnings
    ============================================================
    Provides reusable functions to farm chests within the XZ
    bounds of Town of Beginnings.
    If run standalone, farms chests indefinitely.
    ============================================================
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ChestFarmer = {
    Running = false,
    Connections = {},
}

local ARRIVE_DIST = 6
local TRAVEL_HEIGHT = 4

local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087

local function isInsideTownOfBeginnings(pos)
    return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()
local Safeguard = Core.GetSafeguard()

-- Import helper to avoid globals

function ChestFarmer.CollectChests()
    local chests = {}
    local env = workspace:FindFirstChild("Env") or workspace
    for _, v in ipairs(env:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local action = v.ActionText or ""
            if action:find("Peli Chest") then
                local part = v.Parent
                if part and part:IsA("BasePart") and isInsideTownOfBeginnings(part.Position) then
                    table.insert(chests, {
                        prompt = v,
                        position = part.Position,
                        label = string.format("(%.0f, %.0f, %.0f)", part.Position.X, part.Position.Y, part.Position.Z),
                    })
                end
            end
        end
    end
    return chests
end

function ChestFarmer.Stop()
    ChestFarmer.Running = false
    for _, conn in ipairs(ChestFarmer.Connections) do
        conn:Disconnect()
    end
    ChestFarmer.Connections = {}
    print("[ChestFarmer] Stopped.")
end

function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
    print("[ChestFarmer] Started chest farm. Target Peli: " .. tostring(targetPeli))

    local EasyTravel = (function()
        
--[[
    ================================================================================
    EASY TRAVEL SUITE - WASD GROUND-FOLLOWING & HYPOTENUSE WALL-CLIMBING FLIGHT
    ================================================================================
    Provides coordinate-based flight (Start/Stop).
    If run standalone (not loaded via hub or importLib), binds ']' to toggle flight.
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()
local Safeguard = Core.GetSafeguard()

local UserInputService = game:GetService("UserInputService")
local Workspace = workspace

local LocalPlayer = Players.LocalPlayer

local EasyTravel = {
    TargetPosition = nil,
    DisableKeyboard = false,
    Speed = 70.0,
    Enabled = false,
    DisableRaycasting = false,
    DisableWallTouch = false,
    Connections = {},
}

-- Configurations
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0

-- Internal State
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil

local function getCharacterComponents()
    local char = LocalPlayer.Character
    if not char then
        return nil, nil, nil
    end
    return char, char:FindFirstChildWhichIsA("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

local function getOrCreateForce(root)
    local att = root:FindFirstChild("__EasyTravelAtt") or Instance.new("Attachment")
    att.Name = "__EasyTravelAtt"
    att.Parent = root

    local force = root:FindFirstChild("__EasyTravelForce")
    if not force then
        force = Instance.new("LinearVelocity")
        force.Name = "__EasyTravelForce"
        force.Attachment0 = att
        force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        force.RelativeTo = Enum.ActuatorRelativeTo.World
        force.MaxForce = 10000000
        force.VectorVelocity = Vector3.zero
        force.Parent = root
    end
    return force
end

local function cleanupForce()
    local _, _, root = getCharacterComponents()
    if root then
        local force = root:FindFirstChild("__EasyTravelForce")
        local att = root:FindFirstChild("__EasyTravelAtt")
        if force then
            force:Destroy()
        end
        if att then
            att:Destroy()
        end
    end
end

function EasyTravel.GetSurfaceY(position, character)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = { character }
    raycastParams.IgnoreWater = true

    local startPos = Vector3.new(position.X, position.Y + 2, position.Z)
    local checkDepth = math.max((position.Y + 2) - SEA_LEVEL_Y, 30)
    local direction = Vector3.new(0, -checkDepth, 0)

    local result = Workspace:Raycast(startPos, direction, raycastParams)
    local groundY = result and result.Position.Y or -100

    return math.max(groundY, SEA_LEVEL_Y)
end

local function runRaycastLoop()
    while EasyTravel.Enabled do
        task.wait(RAYCAST_COOLDOWN)
        local char, _, root = getCharacterComponents()
        if not char or not root then
            continue
        end

        local currentPos = root.Position
        local inRoughWaters = currentPos.X >= 1002.01
            and currentPos.X <= 3049.91
            and currentPos.Z >= -11748.53
            and currentPos.Z <= -9700.63

        local moveDir = Vector3.zero
        if EasyTravel.DisableRaycasting then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            task.wait(RAYCAST_COOLDOWN)
            continue
        end

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - root.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            else
                isClimbing = false
                currentTargetY = EasyTravel.TargetPosition.Y
                continue
            end
        else
            local camera = Workspace.CurrentCamera
            local look = camera.CFrame.LookVector
            local right = camera.CFrame.RightVector
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

        local hitCave = false
        local cave = Workspace.Islands:FindFirstChild("Fishman Cave")
        if cave and moveDir and moveDir.Magnitude > 0 then
            local caveRayParams = RaycastParams.new()
            caveRayParams.FilterType = Enum.RaycastFilterType.Include
            caveRayParams.FilterDescendantsInstances = { cave }
            local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
            if hit then
                hitCave = true
            end
        end
        EasyTravel.HitCave = hitCave

        if hitCave or inRoughWaters then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            continue
        end
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = { char }
        raycastParams.IgnoreWater = true

        if moveDir.Magnitude > 0 then
            local moveUnit = moveDir.Unit
            local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit

            local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end

            if forwardHit then
                distanceToWall = forwardHit.Distance
                local clearanceY = nil
                local currentScanDist = FORWARD_SCAN_DISTANCE
                local heightOffset = 4

                while heightOffset <= 100 do
                    local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
                    local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, raycastParams)

                    if not scanHit then
                        clearanceY = scanOrigin.Y
                        local secondaryOrigin = scanOrigin + moveUnit * 10
                        local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, raycastParams)
                        if secondaryHit then
                            currentScanDist = currentScanDist + 15
                        else
                            break
                        end
                    end
                    heightOffset = heightOffset + 4
                end

                if clearanceY then
                    isClimbing = true
                    climbTargetY = clearanceY + HEIGHT_OFFSET
                else
                    isClimbing = false
                    currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
                end
            else
                distanceToWall = 999
                isClimbing = false
                local groundY = EasyTravel.GetSurfaceY(currentPos, char)
                local aheadPos = currentPos + moveUnit * 4
                local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
                currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
            end
        else
            distanceToWall = 999
            isClimbing = false
            currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
        end
    end
end

function EasyTravel.Start()
    if EasyTravel.Enabled then
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end
    EasyTravel.Enabled = true
    cleanupForce()
    local char, hum, root = getCharacterComponents()
    if not root or not hum then
        return
    end

    EasyTravel.Enabled = true
    currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
    isClimbing = false

    task.spawn(runRaycastLoop)

    loopConnection = RunService.Heartbeat:Connect(function(dt)
        local _, _, currentRoot = getCharacterComponents()
        if not currentRoot or not EasyTravel.Enabled then
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            cleanupForce()
            return
        end

        local force = getOrCreateForce(currentRoot)
        local camera = Workspace.CurrentCamera
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local moveDir = Vector3.zero
        local finalTargetY = isClimbing and climbTargetY or currentTargetY

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - currentRoot.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            end
        else
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

        local yError = finalTargetY - currentRoot.Position.Y
        local targetVelocity = Vector3.zero
        if moveDir.Magnitude > 0 then
            local speedMultiplier = 1
            if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
                speedMultiplier = 0
            end
            targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
        end

        local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
        force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)

        if moveDir.Magnitude > 0 then
            currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
        end
    end)
    print("[Easy Travel] Flight enabled.")
end

function EasyTravel.Stop()
    EasyTravel.Enabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    cleanupForce()
    print("[Easy Travel] Flight disabled.")
end

-- Completely shutdown everything
function EasyTravel.Cleanup()
    EasyTravel.Stop()
    for _, conn in ipairs(EasyTravel.Connections) do
        conn:Disconnect()
    end
    EasyTravel.Connections = {}
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(EasyTravel, "Easy Travel", EasyTravel.Start, EasyTravel.Stop, function()
    return EasyTravel.Enabled
end, Enum.KeyCode.P, true)

return EasyTravel


    end)()

    while isRunningCallback() and getPeliCallback() < targetPeli do
        local chests = ChestFarmer.CollectChests()

        if #chests == 0 then
            print("[ChestFarmer] No chests found. Waiting 20 seconds for spawn...")
            local waited = 0
            while isRunningCallback() and waited < 20 do
                task.wait(1)
                waited = waited + 1
                if getPeliCallback() >= targetPeli then
                    return true
                end
            end
        else
            local root = Core.GetRoot(LocalPlayer)
            if root then
                local startPos = root.Position
                table.sort(chests, function(a, b)
                    return (a.position - startPos).Magnitude < (b.position - startPos).Magnitude
                end)
            end

            for _, chest in ipairs(chests) do
                if not isRunningCallback() or getPeliCallback() >= targetPeli then
                    break
                end

                if EasyTravel then
                    EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
                    if not EasyTravel.Enabled then
                        pcall(EasyTravel.Start)
                    end
                end

                local elapsed = 0
                local reached = false
                while isRunningCallback() and elapsed < 20 do
                    task.wait(0.1)
                    elapsed = elapsed + 0.1

                    local myRoot = Core.GetRoot(LocalPlayer)
                    if myRoot then
                        local dist = (myRoot.Position - chest.position).Magnitude
                        if dist <= ARRIVE_DIST then
                            reached = true
                            break
                        end
                    else
                        task.wait(1)
                    end
                end

                if reached and isRunningCallback() then
                    if EasyTravel then
                        local myRoot = Core.GetRoot(LocalPlayer)
                        if myRoot then
                            EasyTravel.TargetPosition = myRoot.Position
                        end
                    end

                    if chest.prompt and chest.prompt.Parent then
                        local holdTime = chest.prompt.HoldDuration or 0
                        if holdTime > 0 then
                            task.wait(holdTime + 0.1)
                        end
                        if fireproximityprompt then
                            pcall(fireproximityprompt, chest.prompt)
                        else
                            pcall(function()
                                chest.prompt.Triggered:Fire(LocalPlayer)
                            end)
                        end
                        task.wait(2.5)
                    end
                end
            end
        end
        task.wait(0.2)
    end

    if EasyTravel then
        EasyTravel.TargetPosition = nil
        pcall(EasyTravel.Stop)
    end

    return getPeliCallback() >= targetPeli
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
function ChestFarmer.Start()
    if ChestFarmer.Running then
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end
    ChestFarmer.Running = true
    task.spawn(function()
        ChestFarmer.FarmUntilPeli(9999999, function()
            return 0
        end, function()
            return ChestFarmer.Running
        end)
    end)
end

Core.SetupStandalone(ChestFarmer, "ChestFarmer", ChestFarmer.Start, ChestFarmer.Stop, function()
    return ChestFarmer.Running
end)

return ChestFarmer


end)()

local EasyTravel = (function()
    
--[[
    ================================================================================
    EASY TRAVEL SUITE - WASD GROUND-FOLLOWING & HYPOTENUSE WALL-CLIMBING FLIGHT
    ================================================================================
    Provides coordinate-based flight (Start/Stop).
    If run standalone (not loaded via hub or importLib), binds ']' to toggle flight.
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()
local Safeguard = Core.GetSafeguard()

local UserInputService = game:GetService("UserInputService")
local Workspace = workspace

local LocalPlayer = Players.LocalPlayer

local EasyTravel = {
    TargetPosition = nil,
    DisableKeyboard = false,
    Speed = 70.0,
    Enabled = false,
    DisableRaycasting = false,
    DisableWallTouch = false,
    Connections = {},
}

-- Configurations
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0

-- Internal State
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil

local function getCharacterComponents()
    local char = LocalPlayer.Character
    if not char then
        return nil, nil, nil
    end
    return char, char:FindFirstChildWhichIsA("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

local function getOrCreateForce(root)
    local att = root:FindFirstChild("__EasyTravelAtt") or Instance.new("Attachment")
    att.Name = "__EasyTravelAtt"
    att.Parent = root

    local force = root:FindFirstChild("__EasyTravelForce")
    if not force then
        force = Instance.new("LinearVelocity")
        force.Name = "__EasyTravelForce"
        force.Attachment0 = att
        force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        force.RelativeTo = Enum.ActuatorRelativeTo.World
        force.MaxForce = 10000000
        force.VectorVelocity = Vector3.zero
        force.Parent = root
    end
    return force
end

local function cleanupForce()
    local _, _, root = getCharacterComponents()
    if root then
        local force = root:FindFirstChild("__EasyTravelForce")
        local att = root:FindFirstChild("__EasyTravelAtt")
        if force then
            force:Destroy()
        end
        if att then
            att:Destroy()
        end
    end
end

function EasyTravel.GetSurfaceY(position, character)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = { character }
    raycastParams.IgnoreWater = true

    local startPos = Vector3.new(position.X, position.Y + 2, position.Z)
    local checkDepth = math.max((position.Y + 2) - SEA_LEVEL_Y, 30)
    local direction = Vector3.new(0, -checkDepth, 0)

    local result = Workspace:Raycast(startPos, direction, raycastParams)
    local groundY = result and result.Position.Y or -100

    return math.max(groundY, SEA_LEVEL_Y)
end

local function runRaycastLoop()
    while EasyTravel.Enabled do
        task.wait(RAYCAST_COOLDOWN)
        local char, _, root = getCharacterComponents()
        if not char or not root then
            continue
        end

        local currentPos = root.Position
        local inRoughWaters = currentPos.X >= 1002.01
            and currentPos.X <= 3049.91
            and currentPos.Z >= -11748.53
            and currentPos.Z <= -9700.63

        local moveDir = Vector3.zero
        if EasyTravel.DisableRaycasting then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            task.wait(RAYCAST_COOLDOWN)
            continue
        end

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - root.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            else
                isClimbing = false
                currentTargetY = EasyTravel.TargetPosition.Y
                continue
            end
        else
            local camera = Workspace.CurrentCamera
            local look = camera.CFrame.LookVector
            local right = camera.CFrame.RightVector
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

        local hitCave = false
        local cave = Workspace.Islands:FindFirstChild("Fishman Cave")
        if cave and moveDir and moveDir.Magnitude > 0 then
            local caveRayParams = RaycastParams.new()
            caveRayParams.FilterType = Enum.RaycastFilterType.Include
            caveRayParams.FilterDescendantsInstances = { cave }
            local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
            if hit then
                hitCave = true
            end
        end
        EasyTravel.HitCave = hitCave

        if hitCave or inRoughWaters then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            continue
        end
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = { char }
        raycastParams.IgnoreWater = true

        if moveDir.Magnitude > 0 then
            local moveUnit = moveDir.Unit
            local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit

            local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end

            if forwardHit then
                distanceToWall = forwardHit.Distance
                local clearanceY = nil
                local currentScanDist = FORWARD_SCAN_DISTANCE
                local heightOffset = 4

                while heightOffset <= 100 do
                    local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
                    local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, raycastParams)

                    if not scanHit then
                        clearanceY = scanOrigin.Y
                        local secondaryOrigin = scanOrigin + moveUnit * 10
                        local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, raycastParams)
                        if secondaryHit then
                            currentScanDist = currentScanDist + 15
                        else
                            break
                        end
                    end
                    heightOffset = heightOffset + 4
                end

                if clearanceY then
                    isClimbing = true
                    climbTargetY = clearanceY + HEIGHT_OFFSET
                else
                    isClimbing = false
                    currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
                end
            else
                distanceToWall = 999
                isClimbing = false
                local groundY = EasyTravel.GetSurfaceY(currentPos, char)
                local aheadPos = currentPos + moveUnit * 4
                local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
                currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
            end
        else
            distanceToWall = 999
            isClimbing = false
            currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
        end
    end
end

function EasyTravel.Start()
    if EasyTravel.Enabled then
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end
    EasyTravel.Enabled = true
    cleanupForce()
    local char, hum, root = getCharacterComponents()
    if not root or not hum then
        return
    end

    EasyTravel.Enabled = true
    currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
    isClimbing = false

    task.spawn(runRaycastLoop)

    loopConnection = RunService.Heartbeat:Connect(function(dt)
        local _, _, currentRoot = getCharacterComponents()
        if not currentRoot or not EasyTravel.Enabled then
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            cleanupForce()
            return
        end

        local force = getOrCreateForce(currentRoot)
        local camera = Workspace.CurrentCamera
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local moveDir = Vector3.zero
        local finalTargetY = isClimbing and climbTargetY or currentTargetY

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - currentRoot.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            end
        else
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

        local yError = finalTargetY - currentRoot.Position.Y
        local targetVelocity = Vector3.zero
        if moveDir.Magnitude > 0 then
            local speedMultiplier = 1
            if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
                speedMultiplier = 0
            end
            targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
        end

        local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
        force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)

        if moveDir.Magnitude > 0 then
            currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
        end
    end)
    print("[Easy Travel] Flight enabled.")
end

function EasyTravel.Stop()
    EasyTravel.Enabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    cleanupForce()
    print("[Easy Travel] Flight disabled.")
end

-- Completely shutdown everything
function EasyTravel.Cleanup()
    EasyTravel.Stop()
    for _, conn in ipairs(EasyTravel.Connections) do
        conn:Disconnect()
    end
    EasyTravel.Connections = {}
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(EasyTravel, "Easy Travel", EasyTravel.Start, EasyTravel.Stop, function()
    return EasyTravel.Enabled
end, Enum.KeyCode.P, true)

return EasyTravel


end)()

local FishmanMaze = (function()
    
--[[
    ================================================================================
    Fishman Maze Suite - EasyTravel-Powered Point-to-Point Traversal
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()

local FishmanMaze = {}

-- Fishman Cave mazePath — corrected for player hitbox (agent radius = 2 studs, Roblox default)
-- Original scan treated the player as a single point/ray, so several waypoints sat AT or PAST
-- a wall (0 or negative clearance). Fixed points use true corridor-center math instead.
-- ⚠ = pinch point with ≤1 stud clearance per side even after centering — move slow/exact there.
local mazePath = {
    Vector3.new(1837.32, 4.27, -12170.40),
    Vector3.new(1837.77, 4.14, -12172.13),
    Vector3.new(1837.32, 4.25, -12178.01),
    Vector3.new(1836.65, 4.40, -12186.67),
    Vector3.new(1836.38, 4.46, -12190.21),
    Vector3.new(1836.27, 1.73, -12191.54),
    Vector3.new(1836.26, -9.27, -12191.68),
    Vector3.new(1836.25, -23.02, -12191.86),
    Vector3.new(1836.23, -36.77, -12192.03),
    Vector3.new(1836.22, -50.52, -12192.18),
    Vector3.new(1836.21, -64.27, -12192.31),
    Vector3.new(1836.21, -75.42, -12192.42),
    Vector3.new(1836.20, -79.67, -12192.46),
    Vector3.new(1836.20, -82.19, -12192.49),
    Vector3.new(1836.20, -83.00, -12200.39),
    Vector3.new(1836.20, -83.30, -12207.03),
    Vector3.new(1836.20, -83.42, -12209.81),
    Vector3.new(1830.20, -83.47, -12210.82),
    Vector3.new(1815.20, -83.48, -12211.12),
    Vector3.new(1805.88, -83.49, -12211.31),
    Vector3.new(1800.69, -83.50, -12211.42),
    Vector3.new(1798.27, -83.50, -12211.48),
    Vector3.new(1797.56, -83.50, -12215.29),
    Vector3.new(1797.37, -83.50, -12217.99),
    Vector3.new(1797.25, -83.50, -12219.77),
    Vector3.new(1782.33, -82.01, -12220.12),
    Vector3.new(1773.28, -81.11, -12220.35),
    Vector3.new(1769.64, -80.74, -12220.44),
    Vector3.new(1767.85, -80.57, -12220.48),
    Vector3.new(1767.47, -80.53, -12225.82),
    Vector3.new(1767.29, -80.51, -12228.27),
    Vector3.new(1775.67, -83.67, -12229.00),
    Vector3.new(1784.96, -87.16, -12229.29),
    Vector3.new(1788.69, -88.56, -12229.41),
    Vector3.new(1790.37, -89.19, -12229.47),
    Vector3.new(1790.80, -89.35, -12235.70),
    Vector3.new(1791.04, -89.44, -12239.17),
    Vector3.new(1789.23, -89.48, -12240.67),
    Vector3.new(1784.29, -89.49, -12241.10),
    Vector3.new(1781.46, -89.50, -12241.35),
    Vector3.new(1780.42, -89.50, -12247.42),
    Vector3.new(1780.12, -89.50, -12259.42),
    Vector3.new(1779.87, -89.50, -12269.64),
    Vector3.new(1779.77, -89.50, -12273.74),
    Vector3.new(1779.72, -89.50, -12275.53),
    Vector3.new(1791.72, -89.50, -12275.91),
    Vector3.new(1801.45, -89.50, -12276.21),
    Vector3.new(1806.98, -89.50, -12276.38),
    Vector3.new(1809.47, -89.50, -12276.45),
    Vector3.new(1810.80, -89.50, -12285.20),
    Vector3.new(1811.64, -89.50, -12293.46),
    Vector3.new(1811.97, -89.50, -12296.78),
    Vector3.new(1815.11, -89.50, -12298.22),
    Vector3.new(1830.10, -89.50, -12298.58),
    Vector3.new(1840.33, -89.50, -12298.83),
    Vector3.new(1843.89, -89.50, -12298.92),
    Vector3.new(1846.25, -89.50, -12298.97),
    Vector3.new(1846.74, -89.50, -12302.87),
    Vector3.new(1847.05, -89.50, -12305.32),
    Vector3.new(1838.11, -89.50, -12306.01),
    Vector3.new(1828.00, -89.50, -12306.31),
    Vector3.new(1823.93, -89.50, -12306.42),
    Vector3.new(1822.13, -89.50, -12306.47),
    Vector3.new(1821.57, -83.52, -12313.97),
    Vector3.new(1821.38, -81.44, -12316.58),
    Vector3.new(1821.27, -80.27, -12318.04),
    Vector3.new(1821.23, -79.81, -12323.39),
    Vector3.new(1821.21, -79.60, -12325.83),
    Vector3.new(1813.09, -83.45, -12326.49),
    Vector3.new(1803.26, -88.17, -12326.73),
    Vector3.new(1797.24, -91.06, -12326.90),
    Vector3.new(1794.73, -92.27, -12326.95),
    Vector3.new(1791.73, -90.76, -12327.45),
}

function FishmanMaze.Travel(hrp, isRunning)
    if not hrp or not Core then
        return
    end

    local EasyTravel = (function()
        
--[[
    ================================================================================
    EASY TRAVEL SUITE - WASD GROUND-FOLLOWING & HYPOTENUSE WALL-CLIMBING FLIGHT
    ================================================================================
    Provides coordinate-based flight (Start/Stop).
    If run standalone (not loaded via hub or importLib), binds ']' to toggle flight.
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()
local Safeguard = Core.GetSafeguard()

local UserInputService = game:GetService("UserInputService")
local Workspace = workspace

local LocalPlayer = Players.LocalPlayer

local EasyTravel = {
    TargetPosition = nil,
    DisableKeyboard = false,
    Speed = 70.0,
    Enabled = false,
    DisableRaycasting = false,
    DisableWallTouch = false,
    Connections = {},
}

-- Configurations
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0

-- Internal State
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil

local function getCharacterComponents()
    local char = LocalPlayer.Character
    if not char then
        return nil, nil, nil
    end
    return char, char:FindFirstChildWhichIsA("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

local function getOrCreateForce(root)
    local att = root:FindFirstChild("__EasyTravelAtt") or Instance.new("Attachment")
    att.Name = "__EasyTravelAtt"
    att.Parent = root

    local force = root:FindFirstChild("__EasyTravelForce")
    if not force then
        force = Instance.new("LinearVelocity")
        force.Name = "__EasyTravelForce"
        force.Attachment0 = att
        force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        force.RelativeTo = Enum.ActuatorRelativeTo.World
        force.MaxForce = 10000000
        force.VectorVelocity = Vector3.zero
        force.Parent = root
    end
    return force
end

local function cleanupForce()
    local _, _, root = getCharacterComponents()
    if root then
        local force = root:FindFirstChild("__EasyTravelForce")
        local att = root:FindFirstChild("__EasyTravelAtt")
        if force then
            force:Destroy()
        end
        if att then
            att:Destroy()
        end
    end
end

function EasyTravel.GetSurfaceY(position, character)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = { character }
    raycastParams.IgnoreWater = true

    local startPos = Vector3.new(position.X, position.Y + 2, position.Z)
    local checkDepth = math.max((position.Y + 2) - SEA_LEVEL_Y, 30)
    local direction = Vector3.new(0, -checkDepth, 0)

    local result = Workspace:Raycast(startPos, direction, raycastParams)
    local groundY = result and result.Position.Y or -100

    return math.max(groundY, SEA_LEVEL_Y)
end

local function runRaycastLoop()
    while EasyTravel.Enabled do
        task.wait(RAYCAST_COOLDOWN)
        local char, _, root = getCharacterComponents()
        if not char or not root then
            continue
        end

        local currentPos = root.Position
        local inRoughWaters = currentPos.X >= 1002.01
            and currentPos.X <= 3049.91
            and currentPos.Z >= -11748.53
            and currentPos.Z <= -9700.63

        local moveDir = Vector3.zero
        if EasyTravel.DisableRaycasting then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            task.wait(RAYCAST_COOLDOWN)
            continue
        end

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - root.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            else
                isClimbing = false
                currentTargetY = EasyTravel.TargetPosition.Y
                continue
            end
        else
            local camera = Workspace.CurrentCamera
            local look = camera.CFrame.LookVector
            local right = camera.CFrame.RightVector
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

        local hitCave = false
        local cave = Workspace.Islands:FindFirstChild("Fishman Cave")
        if cave and moveDir and moveDir.Magnitude > 0 then
            local caveRayParams = RaycastParams.new()
            caveRayParams.FilterType = Enum.RaycastFilterType.Include
            caveRayParams.FilterDescendantsInstances = { cave }
            local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
            if hit then
                hitCave = true
            end
        end
        EasyTravel.HitCave = hitCave

        if hitCave or inRoughWaters then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            continue
        end
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = { char }
        raycastParams.IgnoreWater = true

        if moveDir.Magnitude > 0 then
            local moveUnit = moveDir.Unit
            local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit

            local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end

            if forwardHit then
                distanceToWall = forwardHit.Distance
                local clearanceY = nil
                local currentScanDist = FORWARD_SCAN_DISTANCE
                local heightOffset = 4

                while heightOffset <= 100 do
                    local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
                    local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, raycastParams)

                    if not scanHit then
                        clearanceY = scanOrigin.Y
                        local secondaryOrigin = scanOrigin + moveUnit * 10
                        local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, raycastParams)
                        if secondaryHit then
                            currentScanDist = currentScanDist + 15
                        else
                            break
                        end
                    end
                    heightOffset = heightOffset + 4
                end

                if clearanceY then
                    isClimbing = true
                    climbTargetY = clearanceY + HEIGHT_OFFSET
                else
                    isClimbing = false
                    currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
                end
            else
                distanceToWall = 999
                isClimbing = false
                local groundY = EasyTravel.GetSurfaceY(currentPos, char)
                local aheadPos = currentPos + moveUnit * 4
                local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
                currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
            end
        else
            distanceToWall = 999
            isClimbing = false
            currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
        end
    end
end

function EasyTravel.Start()
    if EasyTravel.Enabled then
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end
    EasyTravel.Enabled = true
    cleanupForce()
    local char, hum, root = getCharacterComponents()
    if not root or not hum then
        return
    end

    EasyTravel.Enabled = true
    currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
    isClimbing = false

    task.spawn(runRaycastLoop)

    loopConnection = RunService.Heartbeat:Connect(function(dt)
        local _, _, currentRoot = getCharacterComponents()
        if not currentRoot or not EasyTravel.Enabled then
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            cleanupForce()
            return
        end

        local force = getOrCreateForce(currentRoot)
        local camera = Workspace.CurrentCamera
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local moveDir = Vector3.zero
        local finalTargetY = isClimbing and climbTargetY or currentTargetY

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - currentRoot.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            end
        else
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

        local yError = finalTargetY - currentRoot.Position.Y
        local targetVelocity = Vector3.zero
        if moveDir.Magnitude > 0 then
            local speedMultiplier = 1
            if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
                speedMultiplier = 0
            end
            targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
        end

        local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
        force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)

        if moveDir.Magnitude > 0 then
            currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
        end
    end)
    print("[Easy Travel] Flight enabled.")
end

function EasyTravel.Stop()
    EasyTravel.Enabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    cleanupForce()
    print("[Easy Travel] Flight disabled.")
end

-- Completely shutdown everything
function EasyTravel.Cleanup()
    EasyTravel.Stop()
    for _, conn in ipairs(EasyTravel.Connections) do
        conn:Disconnect()
    end
    EasyTravel.Connections = {}
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(EasyTravel, "Easy Travel", EasyTravel.Start, EasyTravel.Stop, function()
    return EasyTravel.Enabled
end, Enum.KeyCode.P, true)

return EasyTravel


    end)()
    if not EasyTravel then
        warn("[Fishman Maze] Failed to load EasyTravel!")
        return
    end
    if EasyTravel.Cleanup then
        pcall(EasyTravel.Cleanup)
    end

    print("[Fishman Maze] Starting collision-aware maze traversal (NoClip OFF)...")

    EasyTravel.DisableRaycasting = true
    EasyTravel.DisableWallTouch = true
    EasyTravel.Speed = 25

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.IgnoreWater = true

    local function getAvoidanceVector(origin, forwardUnit, char)
        raycastParams.FilterDescendantsInstances = { char }
        -- Check direct forward
        local hit = workspace:Raycast(origin, forwardUnit * 3.5, raycastParams)
        if not hit then
            return forwardUnit
        end

        -- Collision detected: heavy raycast sweep to find open corridor heading
        local angles = { 30, -30, 45, -45, 60, -60, 90, -90 }
        local bestDir = nil
        local maxClearDist = 0

        for _, deg in ipairs(angles) do
            local rad = math.rad(deg)
            local cosA = math.cos(rad)
            local sinA = math.sin(rad)
            local probeDir = Vector3.new(
                forwardUnit.X * cosA - forwardUnit.Z * sinA,
                forwardUnit.Y,
                forwardUnit.X * sinA + forwardUnit.Z * cosA
            ).Unit

            local probeHit = workspace:Raycast(origin, probeDir * 8, raycastParams)
            local clearDist = probeHit and probeHit.Distance or 8
            if clearDist > maxClearDist then
                maxClearDist = clearDist
                bestDir = probeDir
            end
        end

        return bestDir or forwardUnit
    end

    for _, target in ipairs(mazePath) do
        local lastPos = hrp.Position
        local stuckFrames = 0

        while (hrp.Position - target).Magnitude > 4 do
            if isRunning and not isRunning() then
                break
            end

            local char = LocalPlayer.Character
            if not char then
                break
            end

            local curPos = hrp.Position
            local delta = (curPos - lastPos).Magnitude
            if delta < 0.15 then
                stuckFrames = stuckFrames + 1
            else
                stuckFrames = 0
            end
            lastPos = curPos

            local toTarget = target - curPos
            local dist = toTarget.Magnitude
            if dist > 0.01 then
                local dir = toTarget.Unit
                -- If stuck against a wall or approaching obstacle, steer with raycast avoidance
                if stuckFrames > 3 then
                    local steerDir = getAvoidanceVector(curPos, dir, char)
                    EasyTravel.TargetPosition = curPos + (steerDir * math.min(dist, 6))
                else
                    EasyTravel.TargetPosition = target
                end
            end

            pcall(EasyTravel.Start)
            RunService.Heartbeat:Wait()
        end

        if isRunning and not isRunning() then
            break
        end
    end

    pcall(EasyTravel.Stop)
    EasyTravel.DisableRaycasting = false
    EasyTravel.DisableWallTouch = false
    print("[Fishman Maze] Complete.")
end

return FishmanMaze


end)()

_G.DisableStandalone = oldStandalone

if EasyTravel and EasyTravel.Cleanup then
    pcall(EasyTravel.Cleanup)
end

local function getCharRoot()
    local c = LocalPlayer.Character
    return c, c and c:FindFirstChild("HumanoidRootPart")
end

local function hasRifle()
    local c = LocalPlayer.Character
    return LocalPlayer.Backpack:FindFirstChild("Rifle") ~= nil or (c and c:FindFirstChild("Rifle") ~= nil)
end

local function travelTo(targetPos, reachDist, noCollide, disableRaycast)
    if not EasyTravel then
        return false
    end
    reachDist = reachDist or 8
    local conn = nil
    if noCollide then
        conn = RunService.Stepped:Connect(function()
            local c = LocalPlayer.Character
            if c then
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end

    if disableRaycast then
        EasyTravel.DisableRaycasting = true
        EasyTravel.DisableWallTouch = true
    end

    EasyTravel.TargetPosition = targetPos
    pcall(EasyTravel.Start)

    while LevelGrinder.Running do
        local _, hrp = getCharRoot()
        if hrp and (hrp.Position - targetPos).Magnitude <= reachDist then
            break
        end
        task.wait(0.3)
    end

    pcall(EasyTravel.Stop)
    if conn then
        conn:Disconnect()
    end
    if disableRaycast then
        EasyTravel.DisableRaycasting = false
        EasyTravel.DisableWallTouch = false
    end
    return LevelGrinder.Running
end

function LevelGrinder.Stop()
    LevelGrinder.Running = false
    for _, conn in ipairs(LevelGrinder.Connections) do
        conn:Disconnect()
    end
    LevelGrinder.Connections = {}
    if EasyTravel then
        pcall(EasyTravel.Stop)
    end
    print("[Level Grinder] Stopped.")
end

function LevelGrinder.Start()
    if LevelGrinder.Running then
        warn("[Level Grinder] Already running!")
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.RequirePlace(3978370137, "First Sea") then
        return
    end
    LevelGrinder.Running = true

    task.spawn(function()
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end

        local events = ReplicatedStorage:WaitForChild("Events", 10)
        local shopEvent = events and events:FindFirstChild("Shop")
        local toolsEvent = events and events:FindFirstChild("Tools")

        -- Phase 1: Obtain Rifle
        while LevelGrinder.Running and not hasRifle() do
            local _, hrp = getCharRoot()
            local inTown = hrp
                and hrp.Position.X >= -889
                and hrp.Position.X <= -156
                and hrp.Position.Z >= -3706
                and hrp.Position.Z <= -3087

            if not inTown then
                warn("[Level Grinder] Not at Town of Beginnings. Please travel there to farm chests for Rifle.")
                task.wait(2)
                continue
            end

            local peli = Core.GetPeli()
            if peli < 300 and ChestFarmer then
                print("[Level Grinder] Farming chests until 300 Peli... (Current: " .. tostring(peli) .. ")")
                ChestFarmer.FarmUntilPeli(300, Core.GetPeli, function()
                    return LevelGrinder.Running and not hasRifle()
                end)
            else
                local buyables = workspace:FindFirstChild("BuyableItems")
                local shopItem = buyables and buyables:FindFirstChild("Rifle")
                local shopPart = shopItem and shopItem:FindFirstChild("ShopPart")

                if shopPart and travelTo(shopPart.Position, 8, true) then
                    task.wait(0.5)
                    if shopEvent and shopEvent:IsA("RemoteFunction") then
                        pcall(function()
                            shopEvent:InvokeServer(shopItem, 1)
                        end)
                    end
                    task.wait(1)

                    if toolsEvent and toolsEvent:IsA("RemoteFunction") then
                        pcall(function()
                            toolsEvent:InvokeServer("equip", "Rifle")
                        end)
                    end
                    task.wait(1)
                end
            end
            task.wait(1)
        end

        if not LevelGrinder.Running then
            return
        end

        -- Equip tool if in backpack
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local rifle = LocalPlayer.Backpack:FindFirstChild("Rifle")
        if rifle and hum then
            hum:EquipTool(rifle)
        end

        -- Phase 2: Escape shop interior if in town
        local _, hrp = getCharRoot()
        if hrp then
            local wasAtShop = hrp.Position.X >= -889
                and hrp.Position.X <= -156
                and hrp.Position.Z >= -3706
                and hrp.Position.Z <= -3087
            if wasAtShop then
                print("[Level Grinder] Escaping shop interior...")
                travelTo(Vector3.new(hrp.Position.X, hrp.Position.Y + 15, hrp.Position.Z), 2, true)
            end
        end

        -- Phase 3: Fly to Fishman Cave
        print("[Level Grinder] Flying to Fishman Cave...")
        travelTo(Vector3.new(1837.4, 4.1, -12181.6), 8, false, true)

        -- Phase 4: Traverse Fishman Maze
        local _, finalHrp = getCharRoot()
        if finalHrp and FishmanMaze then
            local pos = finalHrp.Position
            local inCave = pos.X >= 1750 and pos.X <= 1923 and pos.Z >= -12353 and pos.Z <= -12164
            if inCave then
                pcall(function()
                    FishmanMaze.Travel(finalHrp, function()
                        return LevelGrinder.Running
                    end)
                end)
            else
                warn("[Level Grinder] Outside Fishman Cave bounds, skipping maze.")
            end
        end

        LevelGrinder.Stop()
    end)
end

Core.SetupStandalone(LevelGrinder, "Level Grinder", LevelGrinder.Start, LevelGrinder.Stop, function()
    return LevelGrinder.Running
end)

return LevelGrinder


end

local function loadNavigationLab()
    
--[[
    ================================================================================
    EASY TRAVEL SUITE - WASD GROUND-FOLLOWING & HYPOTENUSE WALL-CLIMBING FLIGHT
    ================================================================================
    Provides coordinate-based flight (Start/Stop).
    If run standalone (not loaded via hub or importLib), binds ']' to toggle flight.
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()
local Safeguard = Core.GetSafeguard()

local UserInputService = game:GetService("UserInputService")
local Workspace = workspace

local LocalPlayer = Players.LocalPlayer

local EasyTravel = {
    TargetPosition = nil,
    DisableKeyboard = false,
    Speed = 70.0,
    Enabled = false,
    DisableRaycasting = false,
    DisableWallTouch = false,
    Connections = {},
}

-- Configurations
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0

-- Internal State
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil

local function getCharacterComponents()
    local char = LocalPlayer.Character
    if not char then
        return nil, nil, nil
    end
    return char, char:FindFirstChildWhichIsA("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

local function getOrCreateForce(root)
    local att = root:FindFirstChild("__EasyTravelAtt") or Instance.new("Attachment")
    att.Name = "__EasyTravelAtt"
    att.Parent = root

    local force = root:FindFirstChild("__EasyTravelForce")
    if not force then
        force = Instance.new("LinearVelocity")
        force.Name = "__EasyTravelForce"
        force.Attachment0 = att
        force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        force.RelativeTo = Enum.ActuatorRelativeTo.World
        force.MaxForce = 10000000
        force.VectorVelocity = Vector3.zero
        force.Parent = root
    end
    return force
end

local function cleanupForce()
    local _, _, root = getCharacterComponents()
    if root then
        local force = root:FindFirstChild("__EasyTravelForce")
        local att = root:FindFirstChild("__EasyTravelAtt")
        if force then
            force:Destroy()
        end
        if att then
            att:Destroy()
        end
    end
end

function EasyTravel.GetSurfaceY(position, character)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = { character }
    raycastParams.IgnoreWater = true

    local startPos = Vector3.new(position.X, position.Y + 2, position.Z)
    local checkDepth = math.max((position.Y + 2) - SEA_LEVEL_Y, 30)
    local direction = Vector3.new(0, -checkDepth, 0)

    local result = Workspace:Raycast(startPos, direction, raycastParams)
    local groundY = result and result.Position.Y or -100

    return math.max(groundY, SEA_LEVEL_Y)
end

local function runRaycastLoop()
    while EasyTravel.Enabled do
        task.wait(RAYCAST_COOLDOWN)
        local char, _, root = getCharacterComponents()
        if not char or not root then
            continue
        end

        local currentPos = root.Position
        local inRoughWaters = currentPos.X >= 1002.01
            and currentPos.X <= 3049.91
            and currentPos.Z >= -11748.53
            and currentPos.Z <= -9700.63

        local moveDir = Vector3.zero
        if EasyTravel.DisableRaycasting then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            task.wait(RAYCAST_COOLDOWN)
            continue
        end

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - root.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            else
                isClimbing = false
                currentTargetY = EasyTravel.TargetPosition.Y
                continue
            end
        else
            local camera = Workspace.CurrentCamera
            local look = camera.CFrame.LookVector
            local right = camera.CFrame.RightVector
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

        local hitCave = false
        local cave = Workspace.Islands:FindFirstChild("Fishman Cave")
        if cave and moveDir and moveDir.Magnitude > 0 then
            local caveRayParams = RaycastParams.new()
            caveRayParams.FilterType = Enum.RaycastFilterType.Include
            caveRayParams.FilterDescendantsInstances = { cave }
            local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
            if hit then
                hitCave = true
            end
        end
        EasyTravel.HitCave = hitCave

        if hitCave or inRoughWaters then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            continue
        end
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = { char }
        raycastParams.IgnoreWater = true

        if moveDir.Magnitude > 0 then
            local moveUnit = moveDir.Unit
            local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit

            local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end

            if forwardHit then
                distanceToWall = forwardHit.Distance
                local clearanceY = nil
                local currentScanDist = FORWARD_SCAN_DISTANCE
                local heightOffset = 4

                while heightOffset <= 100 do
                    local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
                    local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, raycastParams)

                    if not scanHit then
                        clearanceY = scanOrigin.Y
                        local secondaryOrigin = scanOrigin + moveUnit * 10
                        local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, raycastParams)
                        if secondaryHit then
                            currentScanDist = currentScanDist + 15
                        else
                            break
                        end
                    end
                    heightOffset = heightOffset + 4
                end

                if clearanceY then
                    isClimbing = true
                    climbTargetY = clearanceY + HEIGHT_OFFSET
                else
                    isClimbing = false
                    currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
                end
            else
                distanceToWall = 999
                isClimbing = false
                local groundY = EasyTravel.GetSurfaceY(currentPos, char)
                local aheadPos = currentPos + moveUnit * 4
                local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
                currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
            end
        else
            distanceToWall = 999
            isClimbing = false
            currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
        end
    end
end

function EasyTravel.Start()
    if EasyTravel.Enabled then
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end
    EasyTravel.Enabled = true
    cleanupForce()
    local char, hum, root = getCharacterComponents()
    if not root or not hum then
        return
    end

    EasyTravel.Enabled = true
    currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
    isClimbing = false

    task.spawn(runRaycastLoop)

    loopConnection = RunService.Heartbeat:Connect(function(dt)
        local _, _, currentRoot = getCharacterComponents()
        if not currentRoot or not EasyTravel.Enabled then
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            cleanupForce()
            return
        end

        local force = getOrCreateForce(currentRoot)
        local camera = Workspace.CurrentCamera
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local moveDir = Vector3.zero
        local finalTargetY = isClimbing and climbTargetY or currentTargetY

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - currentRoot.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            end
        else
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

        local yError = finalTargetY - currentRoot.Position.Y
        local targetVelocity = Vector3.zero
        if moveDir.Magnitude > 0 then
            local speedMultiplier = 1
            if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
                speedMultiplier = 0
            end
            targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
        end

        local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
        force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)

        if moveDir.Magnitude > 0 then
            currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
        end
    end)
    print("[Easy Travel] Flight enabled.")
end

function EasyTravel.Stop()
    EasyTravel.Enabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    cleanupForce()
    print("[Easy Travel] Flight disabled.")
end

-- Completely shutdown everything
function EasyTravel.Cleanup()
    EasyTravel.Stop()
    for _, conn in ipairs(EasyTravel.Connections) do
        conn:Disconnect()
    end
    EasyTravel.Connections = {}
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(EasyTravel, "Easy Travel", EasyTravel.Start, EasyTravel.Stop, function()
    return EasyTravel.Enabled
end, Enum.KeyCode.P, true)

return EasyTravel


end

local function loadOverworldTester()
    
--[[
    ================================================================================
    CUPID DUNGEON ENGINE - OVERWORLD TESTER
    ================================================================================
    Instructions:
    1. Spawns a GUI to test the EXACT physics, rate-limited Geppo, and combat mechanics 
       used in cupid-v2.lua, but without place guards or dungeon step requirements.
    2. "Target Hover": Finds the nearest Character (NPC or Player) and hovers/CF-locks
       10.3 studs above them (like the main bot does in combat).
    3. "Dodge Jump (70 studs)": Flies 70 studs in the air and holds (simulates the Queen dodge).
    4. "Stop": Disables flight and cleans up forces.
    5. Death Detection: If you die while active, it auto-disables.
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace

local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = "idle" -- "idle" | "hover" | "dodge"

local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5 -- Rate-limited to avoid remote bans

local HOVER_OFFSET = 10.3
local HOVER_YVEL = 120
local XZ_SPEED = 5
local XZ_THRESHOLD = 3
local Y_THRESHOLD = 1.5

local currentHoverOffset = HOVER_OFFSET
local currentDodgeHeight = 70

local function debug(...)
    print("[OverworldTester]", ...)
end

local function getHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildWhichIsA("Humanoid")
end

-- ========================= GEPPO RATE-LIMITER =========================
local function invokeGeppo()
    local now = tick()
    if now - lastGeppoTime < GEPPO_COOLDOWN then
        return
    end
    lastGeppoTime = now

    local ok, err = pcall(function()
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then
            return
        end
        local statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
        if not statsFolder then
            return
        end
        local style = statsFolder.Stats.FightingStyle.Value
        local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
        local args = { char = char, cf = cf }
        if style == "Rokushiki" then
            ReplicatedStorage.Events.Skill:InvokeServer("Geppo", args)
        elseif style == "BlackLeg" then
            ReplicatedStorage.Events.Skill:InvokeServer("Sky Walk", args)
        elseif style == "Kamishiki" then
            ReplicatedStorage.Events.Skill:InvokeServer("KamishikiGeppo", args)
        else
            ReplicatedStorage.Events.Skill:InvokeServer("Sky Walk2", args)
        end
        debug("Fired Geppo Remote")
    end)
    if not ok then
        debug("invokeGeppo error:", err)
    end
end

-- ========================= FORCE ENGINE =========================
local function getOrCreateForce(root)
    local ok, result = pcall(function()
        local att = root:FindFirstChild("__TestHoverAtt") or Instance.new("Attachment")
        att.Name = "__TestHoverAtt"
        att.Parent = root
        local force = root:FindFirstChild("__TestHoverForce")
        if not force then
            force = Instance.new("LinearVelocity")
            force.Name = "__TestHoverForce"
            force.Attachment0 = att
            force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            force.RelativeTo = Enum.ActuatorRelativeTo.World
            force.MaxForce = 1000000
            force.VectorVelocity = Vector3.new(0, 0, 0)
            force.Parent = root
        end
        return force
    end)
    if ok then
        return result
    end
    return nil
end

local function cleanupForce()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then
            return
        end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then
            return
        end
        local force = root:FindFirstChild("__TestHoverForce")
        local att = root:FindFirstChild("__TestHoverAtt")
        if force then
            force:Destroy()
        end
        if att then
            att:Destroy()
        end
    end)
end

-- ========================= WALK TO POINT =========================
local VIM = game:GetService("VirtualInputManager")

local function walkToPoint(pos, timeout)
    timeout = timeout or 30
    local root = Core.GetRoot(LocalPlayer)
    if not root then
        return
    end

    debug("Walking to:", pos)
    cleanupForce()

    -- Press W
    local ok, err = pcall(function()
        VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
    end)
    if not ok then
        debug("walkToPoint W down error:", err)
    end

    local startT = tick()
    local lastDash = 0
    local dashCooldown = 3

    while enabled and (tick() - startT < timeout) do
        local currentRoot = Core.GetRoot(LocalPlayer)
        if not currentRoot then
            break
        end

        local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
        if dist < 5 then
            debug("Arrived at:", pos)
            break
        end

        -- Aim camera and body
        pcall(function()
            local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
            currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
            Workspace.CurrentCamera.CFrame = CFrame.lookAt(
                Workspace.CurrentCamera.CFrame.Position,
                currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10
            )
        end)

        -- Dash
        if tick() - lastDash >= dashCooldown then
            pcall(function()
                VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                task.wait(0.05)
                VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
            end)
            lastDash = tick()
        end

        task.wait()
    end

    -- Release W
    pcall(function()
        VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
    end)
end

-- ========================= NEAREST TARGET =========================
local function getNearestTarget()
    local root = Core.GetRoot(LocalPlayer)
    if not root then
        return nil
    end
    local nearest, nearestDist = nil, math.huge
    for _, item in ipairs(Workspace:GetDescendants()) do
        if
            item:IsA("Model")
            and item:FindFirstChild("HumanoidRootPart")
            and item:FindFirstChildWhichIsA("Humanoid")
        then
            if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA("Humanoid").Health > 0 then
                local dist = (item.HumanoidRootPart.Position - root.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = item
                end
            end
        end
    end
    return nearest
end

local function computeLookDownCFrame(root, targetPos)
    local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
    if horiz.Magnitude < 0.5 then
        local fwd = root.CFrame.LookVector
        local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
        if fwdFlat.Magnitude < 0.01 then
            fwdFlat = Vector3.new(0, 0, 1)
        end
        horiz = fwdFlat.Unit * 5
    end
    local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
    return CFrame.lookAt(root.Position, lookPoint)
end

-- ========================= DISABLE/ENABLE =========================
local function disableBot()
    if not enabled then
        return
    end
    enabled = false
    mode = "idle"
    if navConn then
        navConn:Disconnect()
        navConn = nil
    end
    cleanupForce()
    debug("Tester Disabled")
end

local function enableBot(targetMode)
    if enabled then
        disableBot()
    end
    enabled = true
    mode = targetMode
    debug("Tester Enabled. Mode:", mode)

    local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
    local climbStart = tick()

    navConn = RunService.Heartbeat:Connect(function()
        local root = Core.GetRoot(LocalPlayer)
        if not root then
            return
        end

        -- Stop on Death Check
        local hum = getHumanoid()
        if hum and hum.Health <= 0 then
            debug("Player died! Disabling bot.")
            disableBot()
            return
        end

        local aim, face = nil, nil

        if mode == "hover" then
            -- Hover X studs above nearest character
            local targetChar = getNearestTarget()
            if targetChar then
                aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
                face = targetChar.HumanoidRootPart.Position
            end
        elseif mode == "dodge" then
            -- Simulate dodge jump (X studs up)
            aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
            face = initialPos

            -- Call rate-limited Geppo to justify staying in air during dodge
            invokeGeppo()
        elseif mode == "square_dodge" then
            -- Let walkToPoint handle everything in its loop, so we exit this heartbeat logic early
            return
        end

        if not aim then
            aim = lastAim or root.Position
            face = lastFace or aim
        end
        lastAim = aim
        lastFace = face

        local pos = root.Position
        local yErr = aim.Y - pos.Y
        local xzDist = Vector3.new(pos.X - aim.X, 0, pos.Z - aim.Z).Magnitude
        local xzDir = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
        local xzVel = xzDir.Magnitude > 0 and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60)) or Vector3.zero

        local force = getOrCreateForce(root)
        if force then
            local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
            force.VectorVelocity = Vector3.new(xzVel.X, yVel, xzVel.Z)
        end

        -- Lock CFrame orientation and snap position if close (Combat Snapping)
        if xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
            pcall(function()
                root.CFrame = computeLookDownCFrame(root, face) + (aim - root.Position)
            end)
        else
            -- Normal orientation face while moving
            pcall(function()
                root.CFrame = computeLookDownCFrame(root, face)
            end)

            -- Call rate-limited Geppo if we are climbing up
            if yErr > 5 then
                invokeGeppo()
            end
        end
    end)
end

-- ========================= SAFE UI =========================
local function CreateUI()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
    if not playerGui then
        return
    end

    local existingGui = playerGui:FindFirstChild("OverworldTestGui")
    if existingGui then
        existingGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "OverworldTestGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 240, 0, 230)
    frame.Position = UDim2.new(0.05, 0, 0.4, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 30)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "🛡️ Cupid Engine Overworld Test"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 0, 35)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Status: Idle"
    statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.TextSize = 11
    statusLabel.Parent = frame

    local function createInputBtn(text, defaultVal, pos, callback, color)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.65, -10, 0, 30)
        btn.Position = pos
        btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.Parent = frame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        local input = Instance.new("TextBox")
        input.Size = UDim2.new(0.35, -10, 0, 30)
        input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
        input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
        input.TextColor3 = Color3.new(1, 1, 1)
        input.Text = tostring(defaultVal)
        input.Font = Enum.Font.GothamMedium
        input.TextSize = 11
        input.Parent = frame
        Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            local val = tonumber(input.Text) or defaultVal
            callback(val)
        end)
    end

    createInputBtn("Hover Above Target", 10.3, UDim2.new(0, 10, 0, 65), function(val)
        currentHoverOffset = val
        enableBot("hover")
        statusLabel.Text = "Status: Hovering " .. val .. " studs up"
    end)

    createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
        currentDodgeHeight = val
        enableBot("dodge")
        statusLabel.Text = "Status: Dodge-holding (" .. val .. " studs)"
    end)

    createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
        enableBot("square_dodge")
        statusLabel.Text = "Status: Square Walking (" .. val .. " studs)"
        task.spawn(function()
            local root = Core.GetRoot(LocalPlayer)
            if not root then
                return
            end
            local center = root.Position
            local d = val
            local corners = {
                center + Vector3.new(d, 0, d),
                center + Vector3.new(-d, 0, d),
                center + Vector3.new(-d, 0, -d),
                center + Vector3.new(d, 0, -d),
            }
            local startT = tick()
            local cornerIdx = 1
            while enabled and mode == "square_dodge" and (tick() - startT) < 30 do
                walkToPoint(corners[cornerIdx], 5)
                cornerIdx = (cornerIdx % 4) + 1
            end
            if mode == "square_dodge" then
                disableBot()
                statusLabel.Text = "Status: Idle (Square dodge done)"
            end
        end)
    end)

    local stopBtn = Instance.new("TextButton")
    stopBtn.Size = UDim2.new(1, -20, 0, 30)
    stopBtn.Position = UDim2.new(0, 10, 0, 185)
    stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
    stopBtn.Text = "EMERGENCY STOP"
    stopBtn.TextColor3 = Color3.new(1, 1, 1)
    stopBtn.Font = Enum.Font.GothamBlack
    stopBtn.TextSize = 13
    stopBtn.Parent = frame
    Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)
    stopBtn.MouseButton1Click:Connect(function()
        disableBot()
        statusLabel.Text = "Status: STOPPED (Idle)"
        local VIM = game:GetService("VirtualInputManager")
        VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
        VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    end)
end

CreateUI()
print("[OverworldTester] Loaded successfully.")


end

--------------------------------------------------------------------------------
-- LAUNCHER UI CREATION
--------------------------------------------------------------------------------
local function CreateLauncherUI()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
    if not playerGui then
        return
    end

    -- Cleanup any existing launcher instance
    local oldUI = playerGui:FindFirstChild("GPOLauncherUI")
    if oldUI then
        oldUI:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GPOLauncherUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- Main Panel
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 300, 0, 340)
    main.Position = UDim2.new(0.4, 0, 0.3, 0)
    main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    main.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = main

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 64, 78)
    stroke.Thickness = 1.5
    stroke.Parent = main

    -- Header Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 40)
    title.Position = UDim2.new(0, 15, 0, 5)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = Color3.fromRGB(240, 242, 248)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "🌌 GPO Hub Launcher"
    title.Parent = main

    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -34, 0, 13)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 11
    closeBtn.Parent = main
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Status Label
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -30, 0, 20)
    status.Position = UDim2.new(0, 15, 0, 45)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.GothamMedium
    status.TextSize = 11
    status.TextColor3 = Color3.fromRGB(150, 155, 170)
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.Text = "Choose a bot or utility to run:"
    status.Parent = main

    -- Helper to create buttons
    local buttonCount = 0
    local function CreateLaunchButton(text, desc, onClick)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -30, 0, 42)
        btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
        btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Text = "  " .. text
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = main

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Color3.fromRGB(48, 52, 68)
        btnStroke.Thickness = 1
        btnStroke.Parent = btn

        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(1, -20, 0, 15)
        descLabel.Position = UDim2.new(0, 10, 1, -18)
        descLabel.BackgroundTransparency = 1
        descLabel.Font = Enum.Font.GothamMedium
        descLabel.TextSize = 9
        descLabel.TextColor3 = Color3.fromRGB(140, 145, 160)
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Text = desc
        descLabel.Parent = btn

        btn.MouseButton1Click:Connect(function()
            screenGui:Destroy()
            task.spawn(onClick)
        end)

        buttonCount = buttonCount + 1
    end

    -- Launch Options
    CreateLaunchButton("Cupid Dungeon Farm", "Automate cupid dungeons & boss cycles", loadCupidDungeon)
    CreateLaunchButton("Horo Boss Farm (Silent Aim)", "Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
    CreateLaunchButton("Level & Mob Grinder", "Auto-level and farm local NPC mobs", loadLevelGrinder)
    CreateLaunchButton("Easy Travel (P Toggle)", "WASD Flight with ground follow & wall climbing", loadNavigationLab)
    CreateLaunchButton("Physics Overworld Tester", "Test combat hover, geppo & dodge heights", loadOverworldTester)
end

task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
