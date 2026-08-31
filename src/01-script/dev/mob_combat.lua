--[[
    ============================================================
    DEV TEST HARNESS: Mob Combat (Hover & Attack Engine)
    ============================================================
    Tests the pure mob_combat.lua module in Roblox executor.
    Controls:
      - Press ']' (RightBracket) to toggle Mob Combat on / off.
      - Target Name: "Bandit" (or change TARGET_NAME below).
    ============================================================
--]]

local UserInputService = game:GetService("UserInputService")

local MobCombat = (function()
    
--[[
    ================================================================================
    MOB COMBAT LIBRARY (Pure Hover & Remote Combat Engine)
    ================================================================================
    - Proportional Hover Lift: Keeps player strictly elevated above mob (no falling).
    - Anti-Ragdoll & Protection: Resets states, clears constraints, noclipped.
    - Pure Combat Engine: Calls Attack:PC_Activate() with natural 0.42s swing pacing.
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer

local MobCombat = {
    Enabled = false,
    CurrentTarget = nil,
    TargetName = nil,
    HoverHeight = 4.5,
    Speed = 50.0,
    AttackRange = 7.5,
    AttackDelay = 0.42,
    MaxDistance = 250.0,
    LoopConnection = nil,
    AttackThread = nil,
}

local function getCharacterComponents()
    local char = LocalPlayer.Character
    if not char then
        return nil, nil, nil
    end
    return char, char:FindFirstChildWhichIsA("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

local function getOrCreateForce(root)
    local att = root:FindFirstChild("__MobCombatAtt") or Instance.new("Attachment")
    att.Name = "__MobCombatAtt"
    att.Parent = root

    local force = root:FindFirstChild("__MobCombatForce")
    if not force then
        force = Instance.new("LinearVelocity")
        force.Name = "__MobCombatForce"
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
        local force = root:FindFirstChild("__MobCombatForce")
        local att = root:FindFirstChild("__MobCombatAtt")
        if force then
            force:Destroy()
        end
        if att then
            att:Destroy()
        end
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
end

function MobCombat.Init()
    pcall(function()
        local sg = ReplicatedStorage:FindFirstChild("Modules")
            and ReplicatedStorage.Modules:FindFirstChild("SharedGlobals")
        if sg then
            require(sg)()
        end
    end)
    if not _G.hitbox then
        pcall(function()
            local hb = ReplicatedStorage:FindFirstChild("Modules")
                and ReplicatedStorage.Modules:FindFirstChild("Hitbox")
            if hb then
                _G.hitbox = require(hb)
            end
        end)
    end
    if not _G.check then
        pcall(function()
            local hc = ReplicatedStorage:FindFirstChild("Modules")
                and ReplicatedStorage.Modules:FindFirstChild("HumanoidChecks")
            if hc then
                _G.check = require(hc)
            end
        end)
    end
end

function MobCombat.ClearRagdoll()
    local char, hum, _ = getCharacterComponents()
    if not char or not hum then
        return
    end

    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    hum.AutoRotate = true
    hum.Sit = false

    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("BallSocketConstraint") or child.Name:match("Ragdoll") or child.Name == "Rag" then
            child:Destroy()
        end
    end

    char:SetAttribute("RagdollTrigger", nil)
    char:SetAttribute("isRagdolled", nil)
    char:SetAttribute("evading", nil)
    char:SetAttribute("gripped", nil)
    hum:SetAttribute("isRagdolled", nil)
end

function MobCombat.NeutralizeMob(mob)
    if not mob then
        return
    end

    local mobRoot = mob:FindFirstChild("HumanoidRootPart") or mob:FindFirstChild("Torso")
    if mobRoot and mobRoot:IsA("BasePart") then
        mobRoot.AssemblyLinearVelocity = Vector3.zero
        mobRoot.AssemblyAngularVelocity = Vector3.zero
        for _, child in ipairs(mobRoot:GetChildren()) do
            if child:IsA("BodyVelocity") or child:IsA("BodyPosition") or child:IsA("LinearVelocity") then
                child:Destroy()
            end
        end
    end

    for _, part in ipairs(mob:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

function MobCombat.ApplyNoClip()
    local char, _, _ = getCharacterComponents()
    if not char then
        return
    end

    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

function MobCombat.EquipWeapon()
    local char, hum, _ = getCharacterComponents()
    if not char or not hum then
        return nil
    end

    local equipped = char:FindFirstChildWhichIsA("Tool")
    if equipped then
        return equipped.Name
    end

    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then
        local tool = bp:FindFirstChild("Melee") or bp:FindFirstChildWhichIsA("Tool")
        if tool then
            hum:EquipTool(tool)
            task.wait(0.1)
            return tool.Name
        end
    end

    return "Melee"
end

function MobCombat.FindTarget(targetName)
    if not targetName or targetName == "" then
        return nil, nil, 9999
    end

    local _, _, root = getCharacterComponents()
    local npcFolder = Workspace:FindFirstChild("NPCs")
    if not root or not npcFolder then
        return nil, nil, 9999
    end

    local bestMob, bestPart = nil, nil
    local bestDist = MobCombat.MaxDistance

    for _, npc in ipairs(npcFolder:GetChildren()) do
        if npc.Name == targetName or npc.Name:match(targetName) then
            local hum = npc:FindFirstChild("Humanoid")
            local part = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Torso")

            if hum and part and hum.Health > 0 then
                local dist = (part.Position - root.Position).Magnitude
                if dist < bestDist then
                    bestDist = dist
                    bestMob = npc
                    bestPart = part
                end
            end
        end
    end

    return bestMob, bestPart, bestDist
end

function MobCombat.AttackTarget(targetPart)
    local char, hum, root = getCharacterComponents()
    if not char or not hum or not root then
        return
    end

    local weaponName = MobCombat.EquipWeapon() or "Melee"

    -- Set required combat flags
    _G.canuse = true
    _G.canM1 = true
    _G.blocking = false
    _G.midM1 = false

    local bp = LocalPlayer:FindFirstChild("Backpack")
    local ic = bp and bp:FindFirstChild("InputCallbacks")
    if ic then
        local ok, icMain = pcall(require, ic)
        if ok and icMain and icMain.Callbacks and icMain.Callbacks.Attack then
            local attackHandler = icMain.Callbacks.Attack
            attackHandler.Handler.PunchCooldown = false
            attackHandler:PC_Activate()
        end
    end

    -- Direct damage packet with table-wrapped targetPart
    local events = ReplicatedStorage:FindFirstChild("Events")
    local combatReg = events and events:FindFirstChild("CombatRegister")
    if combatReg and targetPart then
        MobCombat.Combo = (MobCombat.Combo % 5) + 1
        local comboNum = MobCombat.Combo
        pcall(function()
            combatReg:InvokeServer({
                "damage",
                { targetPart },
                weaponName,
                { comboNum, "Ground", weaponName },
                true,
                root.CFrame,
                aircombo = "Ground",
            })
        end)
    end
end

function MobCombat.Start(targetName)
    if MobCombat.Enabled then
        return
    end

    if not targetName or targetName == "" then
        warn("[MobCombat] Cannot start: TargetName is required!")
        return
    end

    local _, hum, root = getCharacterComponents()
    if not root or not hum then
        return
    end

    MobCombat.Init()
    MobCombat.Enabled = true
    MobCombat.TargetName = targetName
    cleanupForce()

    -- Hover & Protection Loop (Proportional Lift + Stable Tracking)
    MobCombat.LoopConnection = RunService.Heartbeat:Connect(function()
        if not MobCombat.Enabled then
            if MobCombat.LoopConnection then
                MobCombat.LoopConnection:Disconnect()
                MobCombat.LoopConnection = nil
            end
            cleanupForce()
            return
        end

        local _, currentHum, currentRoot = getCharacterComponents()
        if not currentRoot or not currentHum or currentHum.Health <= 0 then
            MobCombat.Stop()
            return
        end

        local mob, targetPart, _ = MobCombat.FindTarget(MobCombat.TargetName)
        MobCombat.CurrentTarget = mob

        MobCombat.ClearRagdoll()
        MobCombat.ApplyNoClip()
        MobCombat.NeutralizeMob(mob)

        local force = getOrCreateForce(currentRoot)
        if targetPart and targetPart.Parent then
            local targetPos = targetPart.Position
            local desiredHoverPos = targetPos + Vector3.new(0, MobCombat.HoverHeight, 0)
            local currentPos = currentRoot.Position

            -- Horizontal flight velocity
            local hDiff = Vector3.new(desiredHoverPos.X - currentPos.X, 0, desiredHoverPos.Z - currentPos.Z)
            local hDist = hDiff.Magnitude
            local hVel = Vector3.zero
            if hDist > 0.8 then
                hVel = hDiff.Unit * math.min(MobCombat.Speed, hDist * 10)
            end

            -- Proportional vertical lift to lock altitude without falling
            local yDiff = desiredHoverPos.Y - currentPos.Y
            local yVel = math.clamp(yDiff * 20.0, -MobCombat.Speed, MobCombat.Speed)

            force.VectorVelocity = Vector3.new(hVel.X, yVel, hVel.Z)

            -- Face toward target
            currentRoot.CFrame = CFrame.lookAt(currentPos, Vector3.new(targetPos.X, currentPos.Y, targetPos.Z))
        else
            force.VectorVelocity = Vector3.zero
        end
    end)

    -- Combat Attack Loop (0.42s pacing, strictly within attack range)
    MobCombat.AttackThread = task.spawn(function()
        while MobCombat.Enabled do
            local _, _, currentRoot = getCharacterComponents()
            if not currentRoot then
                break
            end

            local mob, targetPart, dist = MobCombat.FindTarget(MobCombat.TargetName)
            if mob and targetPart and dist <= MobCombat.AttackRange then
                MobCombat.AttackTarget(targetPart)
            end

            task.wait(MobCombat.AttackDelay)
        end
    end)
end

function MobCombat.Stop()
    MobCombat.Enabled = false
    MobCombat.CurrentTarget = nil

    if MobCombat.LoopConnection then
        MobCombat.LoopConnection:Disconnect()
        MobCombat.LoopConnection = nil
    end

    if MobCombat.AttackThread then
        task.cancel(MobCombat.AttackThread)
        MobCombat.AttackThread = nil
    end

    cleanupForce()
end

return MobCombat


end)()

if not MobCombat then
    warn("[Dev MobCombat] ERROR: Failed to load mob_combat library!")
    return
end

local TARGET_NAME = "Bandit"
local enabled = false

local function toggle()
    enabled = not enabled
    if enabled then
        MobCombat.Start(TARGET_NAME)
        local mob, _, dist = MobCombat.FindTarget(TARGET_NAME)
        local status = mob and string.format("Target: %s (Dist: %.1f)", mob.Name, dist) or "Searching..."
        print(string.format("[Dev MobCombat] 🟢 Combat ENABLED [%s] (%s). Press ']' to stop.", TARGET_NAME, status))
    else
        MobCombat.Stop()
        print(string.format("[Dev MobCombat] 🔴 Combat DISABLED [%s]. Press ']' to enable.", TARGET_NAME))
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end
    if input.KeyCode == Enum.KeyCode.RightBracket then
        toggle()
    end
end)

print(
    string.format(
        "[Dev MobCombat] Loaded successfully! Target: '%s'. Press ']' (Right Bracket) to toggle.",
        TARGET_NAME
    )
)
