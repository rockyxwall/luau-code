--[[
    ============================================================
    DEV SCRIPT: Auto Open Peli Chests
    ============================================================
    Uses easy_travel.lua (helper mode) to fly to each chest
    and fires the ProximityPrompt to open them automatically.

    HOW IT WORKS:
      1. Scans workspace for all "Peli Chest" ProximityPrompts.
      2. Loads easy_travel in helper mode (no keyboard control).
      3. Flies to each chest one-by-one, fires the prompt, waits.
      4. Stops flight and cleans up when done.

    CONTROLS:
      P — Emergency stop (abort and clean up mid-run)
    ============================================================
--]]

-- ── Safety Guard ─────────────────────────────────────────────
if _G.OpenChestsRunning then
    warn("[OpenChests] Already running! Aborting duplicate launch.")
    return
end
_G.OpenChestsRunning = true

-- ── Services ─────────────────────────────────────────────────
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- ── State ────────────────────────────────────────────────
local running = true -- Set to false by P key or natural completion

-- ── Config ───────────────────────────────────────────────────
local ARRIVE_DIST = 6 -- How close (studs) before firing prompt
local TIMEOUT_PER_CHEST = 20 -- Max seconds to travel to one chest
local OPEN_WAIT = 2.5 -- Wait after firing prompt before moving on
local TRAVEL_HEIGHT = 4 -- Y offset above chest position for approach
local CHECK_HZ = 0.1 -- Arrival-check frequency (seconds)

-- ── Step 1: Collect all Peli Chest ProximityPrompts ──────────
local function collectChests()
    local chests = {}
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local action = v.ActionText
            if action:find("Peli Chest") then
                local part = v.Parent
                if part and part:IsA("BasePart") then
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

-- ── Helpers: character root ──────────────────────────────────
local function getRoot()
    local char = LocalPlayer.Character
    if not char then
        return nil
    end
    return char:FindFirstChild("HumanoidRootPart")
end

local function waitForRoot(timeout)
    local t = 0
    while t < timeout do
        local r = getRoot()
        if r then
            return r
        end
        task.wait(0.1)
        t = t + 0.1
    end
    return nil
end

local chests = collectChests()
print(string.format("[OpenChests] Found %d Peli Chests.", #chests))

if #chests == 0 then
    warn("[OpenChests] No chests found — are you in the right area?")
    _G.OpenChestsRunning = false
    return
end

-- ── Filter + Sort chests ──────────────────────────────────────
local startRoot = waitForRoot(5)
if not startRoot then
    warn("[OpenChests] Could not find character root! Aborting.")
    _G.OpenChestsRunning = false
    return
end
local playerStartPos = startRoot.Position
local playerStartY = playerStartPos.Y

-- Exclude chests more than 20 studs above the player
local filtered = {}
for _, c in ipairs(chests) do
    if c.position.Y <= playerStartY + 20 then
        table.insert(filtered, c)
    else
        print(
            string.format(
                "[OpenChests] Skipping elevated chest at %s (Y=%.0f > limit %.0f)",
                c.label,
                c.position.Y,
                playerStartY + 20
            )
        )
    end
end

-- Sort nearest-first from player start position
table.sort(filtered, function(a, b)
    return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)

chests = filtered
print(string.format("[OpenChests] %d chests queued (nearest-first, after Y filter).", #chests))

if #chests == 0 then
    warn("[OpenChests] No reachable chests after filtering.")
    _G.OpenChestsRunning = false
    return
end

-- ── Step 2: Load Easy Travel in helper mode ───────────────────
-- Helper mode disables keyboard input so we retain full API control
_G.EasyTravelHelperMode = true

-- Clean up any old instance first
if _G.EasyTravelCleanup then
    pcall(_G.EasyTravelCleanup)
    task.wait(0.3)
end

-- Inline-load easy_travel.lua from executor workspace
local easyTravelSrc = readfile("lib/easy_travel.lua")
local loader = loadstring(easyTravelSrc)
if not loader then
    error("[OpenChests] Failed to load easy_travel.lua — check workspace file!")
end
local ET = loader()

if not ET or not ET.Start then
    error("[OpenChests] easy_travel API not returned correctly.")
end

task.wait(0.2)
ET.Start()
print("[OpenChests] Easy Travel started in helper mode.")

-- ── Shared cleanup (called by P key or natural end) ──────────────
local function cleanup(reason)
    running = false
    if ET then
        ET.TargetPosition = nil
        pcall(ET.Stop)
    end
    if _G.EasyTravelCleanup then
        pcall(_G.EasyTravelCleanup)
    end
    _G.EasyTravelHelperMode = nil
    _G.OpenChestsRunning = false
    print("[OpenChests] Stopped: " .. (reason or "done") .. ".")
end

-- ── P key safety stop (same pattern as level_grinder.lua) ─────────
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.P then
        if running then
            print("[OpenChests] P pressed — aborting!")
            cleanup("P key abort")
        end
    end
end)

-- ── Step 3: Travel + Open loop ──────────────────────────────
for i, chest in ipairs(chests) do
    print(string.format("[OpenChests] [%d/%d] Travelling to chest at %s", i, #chests, chest.label))

    -- Target slightly above chest so we don't clip inside geometry
    local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
    ET.TargetPosition = target

    -- Wait until we arrive or timeout
    local elapsed = 0
    while running and elapsed < TIMEOUT_PER_CHEST do
        task.wait(CHECK_HZ)
        elapsed = elapsed + CHECK_HZ

        local root = Core.GetRoot(LocalPlayer)
        if not root then
            warn("[OpenChests] Lost character — pausing.")
            task.wait(1)
            root = waitForRoot(5)
            if not root then
                break
            end
        end

        local dist = (root.Position - chest.position).Magnitude
        if dist <= ARRIVE_DIST then
            print(string.format("[OpenChests] Arrived! (dist=%.1f)", dist))
            break
        end
    end

    if not running then
        break
    end

    -- Hover in place while opening
    local currentRoot = Core.GetRoot(LocalPlayer)
    if currentRoot then
        ET.TargetPosition = currentRoot.Position
    end

    -- Fire the ProximityPrompt to open the chest
    if chest.prompt and chest.prompt.Parent then
        local ok, err = pcall(function()
            fireproximityprompt(chest.prompt)
        end)
        if ok then
            print(string.format("[OpenChests] Opened chest %d!", i))
        else
            warn(string.format("[OpenChests] fireproximityprompt failed: %s", tostring(err)))
            -- Fallback: trigger via ProximityPrompt.Triggered signal (client-side only)
            pcall(function()
                chest.prompt.Triggered:Fire(LocalPlayer)
            end)
        end
    else
        warn(string.format("[OpenChests] Chest %d prompt no longer exists (may have despawned).", i))
    end

    task.wait(OPEN_WAIT)
end

-- ── Cleanup ────────────────────────────────────────────
if running then
    print("[OpenChests] All chests processed!")
    cleanup("all done")
end
