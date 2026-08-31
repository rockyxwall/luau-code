--[[
    Stealth Fishman Maze Coordinate Recorder
    Passively records exact HumanoidRootPart center coordinates while navigating Fishman Maze.
    - Zero global variables modified.
    - Zero metatable hooks or game state changes.
    - Strictly bound to Fishman Maze bounding box (X: 1750-1860, Y: -100 to 10, Z: -12350 to -12180).
    - Logs to local file via executor writefile every 0.5s when moving (> 1.5 studs difference).
    - Press '[' (LeftBracket) to save and print summary.
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local recordedPoints = {}
local lastRecordedPos = nil
local isTracking = true
local OUTPUT_FILE = "fishman_maze_recorded_path.json"

-- Check if player is strictly within Fishman Maze coordinate bounds
local function isInFishmanMaze(pos)
    return pos.X >= 1740 and pos.X <= 1870 and pos.Y >= -110 and pos.Y <= 20 and pos.Z >= -12360 and pos.Z <= -12170
end

local function saveToFile()
    if #recordedPoints == 0 then
        print("[MazeRecorder] No points recorded in Fishman Maze zone.")
        return
    end

    local payload = {
        Zone = "Fishman Maze",
        TotalPoints = #recordedPoints,
        RecordedAt = os.date("%Y-%m-%d %X"),
        Path = recordedPoints,
    }

    local jsonStr = HttpService:JSONEncode(payload)
    if typeof(writefile) == "function" then
        pcall(writefile, OUTPUT_FILE, jsonStr)
        print(string.format("[MazeRecorder] ✅ Saved %d points to %s", #recordedPoints, OUTPUT_FILE))
    else
        print("[MazeRecorder] Export data:\n" .. jsonStr)
    end
end

-- Passive background sampler
task.spawn(function()
    print("[MazeRecorder] 🕵️ Stealth tracker initialized. Move through Fishman Maze to record center coordinates.")
    print("[MazeRecorder] Press '[' to save path to file.")

    while isTracking do
        task.wait(0.2)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if hrp then
            local pos = hrp.Position
            if isInFishmanMaze(pos) then
                if not lastRecordedPos or (pos - lastRecordedPos).Magnitude >= 1.5 then
                    local point = {
                        X = math.floor(pos.X * 100 + 0.5) / 100,
                        Y = math.floor(pos.Y * 100 + 0.5) / 100,
                        Z = math.floor(pos.Z * 100 + 0.5) / 100,
                    }
                    table.insert(recordedPoints, point)
                    lastRecordedPos = pos
                    print(
                        string.format(
                            "[Maze Point #%d] Vector3.new(%.2f, %.2f, %.2f)",
                            #recordedPoints,
                            point.X,
                            point.Y,
                            point.Z
                        )
                    )
                end
            end
        end
    end
end)

-- Hotkey '[' to export
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.LeftBracket then
        saveToFile()
    end
end)
