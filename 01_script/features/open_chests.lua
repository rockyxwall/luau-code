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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local LocalPlayer = Players.LocalPlayer
local OpenChests = {
Running = false,
Connections = {}
}
local ARRIVE_DIST = 6
local TIMEOUT_PER_CHEST = 20
local OPEN_WAIT = 2.5
local TRAVEL_HEIGHT = 4
local CHECK_HZ = 0.1
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(position)
return position.X >= ISLAND_MIN_X and position.X <= ISLAND_MAX_X
and position.Z >= ISLAND_MIN_Z and position.Z <= ISLAND_MAX_Z
end
local function collectChests()
local chests = {}
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA(_d({50,84,81,90,75,79,75,86,91,50,84,81,79,82,86},30)) then
local action = v.ActionText or ""
if action:find(_d({50,71,78,75,2,37,74,71,85,86},30)) then
local part = v.Parent
if part and part:IsA(_d({36,67,85,71,50,67,84,86},30)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({10,7,16,18,72,14,2,7,16,18,72,14,2,7,16,18,72,11},30), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
local function waitForRoot(timeout)
local t = 0
while t < timeout do
local r = Core.GetRoot(LocalPlayer)
if r then return r end
task.wait(0.1)
t = t + 0.1
end
return nil
end
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)) then
Core = loadstring(readfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
else
Core = loadstring(game:HttpGet(_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
end
end)
if not Core then warn(_d({61,37,81,84,71,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,53,86,81,82,82,71,70,16},30))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,35,78,84,71,67,70,91,2,84,87,80,80,75,80,73,3},30)); return end
if not Safeguard then warn(_d({61,53,67,72,71,73,87,67,84,70,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,40,81,87,80,70,2,7,70,2,50,71,78,75,2,37,74,71,85,86,85,2,86,81,86,67,78,2,75,80,2,89,81,84,77,85,82,67,69,71,16},30), #allChests))
if #allChests == 0 then
warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,48,81,2,69,74,71,85,86,85,2,72,81,87,80,70,2,196,98,118,2,67,84,71,2,91,81,87,2,75,80,2,86,74,71,2,84,75,73,74,86,2,67,84,71,67,33},30))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,37,81,87,78,70,2,80,81,86,2,72,75,80,70,2,69,74,67,84,67,69,86,71,84,2,84,81,81,86,3,2,35,68,81,84,86,75,80,73,16},30))
OpenChests.Stop()
return
end
local playerStartPos = startRoot.Position
local playerStartY = playerStartPos.Y
local filtered = {}
local skippedIsland = 0
local skippedY = 0
for _, c in ipairs(allChests) do
if not isInsideTownOfBeginnings(c.position) then
skippedIsland = skippedIsland + 1
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
else
table.insert(filtered, c)
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,7,70,2,69,74,71,85,86,85,2,83,87,71,87,71,70,2,94,2,7,70,2,81,87,86,85,75,70,71,2,75,85,78,67,80,70,2,94,2,7,70,2,86,81,81,2,74,75,73,74,16},30), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,48,81,2,84,71,67,69,74,67,68,78,71,2,69,74,71,85,86,85,2,67,72,86,71,84,2,72,75,78,86,71,84,75,80,73,16},30))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({18,19,15,73,82,81,17,78,75,68,17,71,67,85,91,65,86,84,67,88,71,78,16,78,87,67},30), _d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,71,67,85,91,65,86,84,67,88,71,78,16,78,87,67},30))
if not EasyTravel then
error(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,2,71,67,85,91,65,86,84,67,88,71,78,16,78,87,67},30))
end
EasyTravel.Start()
print(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,39,67,85,91,2,54,84,67,88,71,78,2,85,86,67,84,86,71,70,16},30))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,61,7,70,17,7,70,63,2,54,84,67,88,71,78,78,75,80,73,2,86,81,2,69,74,71,85,86,2,67,86,2,7,85},30), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,46,81,85,86,2,69,74,67,84,67,69,86,71,84,2,196,98,118,2,82,67,87,85,75,80,73,16},30))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then break end
end
if not OpenChests.Running then break end
local currentRoot = Core.GetRoot(LocalPlayer)
if currentRoot then EasyTravel.TargetPosition = currentRoot.Position end
if chest.prompt and chest.prompt.Parent then
local ok, err = pcall(function() fireproximityprompt(chest.prompt) end)
if not ok then
pcall(function() chest.prompt.Triggered:Fire(LocalPlayer) end)
end
end
task.wait(OPEN_WAIT)
end
if EasyTravel then
EasyTravel.TargetPosition = nil
pcall(EasyTravel.Stop)
end
if OpenChests.Running then
print(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,35,78,78,2,69,74,71,85,86,85,2,82,84,81,69,71,85,85,71,70,3},30))
OpenChests.Stop()
end
end)
end
if not _G.DisableStandalone then
table.insert(OpenChests.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if OpenChests.Running then
OpenChests.Stop()
else
OpenChests.Start()
end
end
end))
OpenChests.Start()
print(_d({61,49,82,71,80,37,74,71,85,86,85,63,2,53,86,67,80,70,67,78,81,80,71,2,47,81,70,71,28,2,50,84,71,85,85,2,9,63,9,2,86,81,2,86,81,73,73,78,71,16},30))
end
return OpenChests
end)()