local _bit = bit32 or {bxor = function(a,b) return a ~ b end}
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(_bit.bxor(b[i], k))
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({76,123,110,114,119,125,127,106,123,122,77,106,113,108,127,121,123},30))
local CoreGui = game:GetService(_d({93,113,108,123,89,107,119},30))
local Players = game:GetService(_d({78,114,127,103,123,108,109},30))
local LocalPlayer = Players.LocalPlayer
local Rayfield = loadstring(game:HttpGet(_d({118,106,106,110,109,36,49,49,109,119,108,119,107,109,48,115,123,112,107,49,108,127,103,120,119,123,114,122},30)))()
local Window = Rayfield:CreateWindow({
Name = _d({53,47,62,92,127,112,127,112,127,62,83,113,112,117,123,103,62,90,123,109,106,108,107,125,106,119,113,112},30),
LoadingTitle = _d({82,113,127,122,119,112,121,62,90,123,109,106,108,107,125,106,119,113,112,62,86,107,124,48,48,48},30),
LoadingSubtitle = _d({95,107,106,113,115,127,106,123,122,62,78,107,112,125,118,62,56,62,74,123,114,123,110,113,108,106,62,91,112,121,119,112,123},30),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.5)
local gui = CoreGui:FindFirstChild(_d({76,127,103,120,119,123,114,122},30)) or LocalPlayer:WaitForChild(_d({78,114,127,103,123,108,89,107,119},30)):FindFirstChild(_d({76,127,103,120,119,123,114,122},30))
if gui and gui:FindFirstChild(_d({83,127,119,112},30)) then
local scale = Instance.new(_d({75,87,77,125,127,114,123},30))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
local autoPunching = false
local fastMultiPunch = false
local autoTeleport = false
local punchPower = 2
local punchDelay = 0.1
local targetVector = Vector3.new(-9.8970384597778, 21.499998092651, -13.617593765259)
local function GetPunchEvent()
local shared = ReplicatedStorage:FindFirstChild(_d({77,118,127,108,123,122},30))
if shared then
local events = shared:FindFirstChild(_d({91,104,123,112,106,109},30))
if events then
return events:FindFirstChild(_d({90,123,109,106,108,107,125,106,119,113,112,65,78,107,112,125,118},30))
end
end
return ReplicatedStorage:FindFirstChild(_d({90,123,109,106,108,107,125,106,119,113,112,65,78,107,112,125,118},30), true)
end
local function TeleportToTarget(pos)
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({86,107,115,127,112,113,119,122,76,113,113,106,78,127,108,106},30))
if root then
root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
end
end
end
local MainTab = Window:CreateTab(_d({95,107,106,113,62,78,107,112,125,118},30), 4483362458)
local LocationTab = Window:CreateTab(_d({82,113,125,127,106,119,113,112},30), 4483362458)
local SettingsTab = Window:CreateTab(_d({77,123,106,106,119,112,121,109},30), 4483362458)
MainTab:CreateToggle({
Name = _d({95,107,106,113,62,90,123,109,106,108,107,125,106,119,113,112,62,78,107,112,125,118},30),
CurrentValue = false,
Flag = _d({95,107,106,113,78,107,112,125,118},30),
Callback = function(Value)
autoPunching = Value
if autoPunching then
task.spawn(function()
while autoPunching do
local punchEvent = GetPunchEvent()
if punchEvent and punchEvent:IsA(_d({76,123,115,113,106,123,91,104,123,112,106},30)) then
if autoTeleport then
TeleportToTarget(targetVector)
end
pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
if fastMultiPunch then
for _ = 1, 4 do
pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
end
end
else
Rayfield:Notify({
Title = _d({91,104,123,112,106,62,73,127,108,112,119,112,121},30),
Content = _d({90,123,109,106,108,107,125,106,119,113,112,65,78,107,112,125,118,62,123,104,123,112,106,62,112,113,106,62,120,113,107,112,122,62,119,112,62,76,123,110,114,119,125,127,106,123,122,77,106,113,108,127,121,123},30),
Duration = 3,
Image = 4483362458,
})
end
task.wait(punchDelay)
end
end)
end
end,
})
MainTab:CreateToggle({
Name = _d({88,127,109,106,62,83,107,114,106,119,51,78,107,112,125,118,62,54,43,102,62,86,119,106,55},30),
CurrentValue = false,
Flag = _d({88,127,109,106,78,107,112,125,118},30),
Callback = function(Value)
fastMultiPunch = Value
end,
})
MainTab:CreateToggle({
Name = _d({95,107,106,113,51,74,123,114,123,110,113,108,106,62,106,113,62,78,107,112,125,118,62,72,123,125,106,113,108},30),
CurrentValue = false,
Flag = _d({95,107,106,113,74,78},30),
Callback = function(Value)
autoTeleport = Value
end,
})
MainTab:CreateSlider({
Name = _d({78,107,112,125,118,62,90,123,114,127,103,62,54,77,123,125,113,112,122,109,55},30),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({90,123,114,127,103,77,114,119,122,123,108},30),
Callback = function(Value)
punchDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({78,107,112,125,118,62,78,113,105,123,108,62,82,123,104,123,114},30),
Range = {1, 50},
Increment = 1,
Suffix = _d({62,82,123,104,123,114},30),
CurrentValue = 2,
Flag = _d({78,113,105,123,108,77,114,119,122,123,108},30),
Callback = function(Value)
punchPower = Value
end,
})
LocationTab:CreateButton({
Name = _d({74,123,114,123,110,113,108,106,62,106,113,62,90,123,120,127,107,114,106,62,78,114,127,125,123,62,54,51,39,48,39,50,62,44,47,48,43,50,62,51,47,45,48,40,55},30),
Callback = function()
targetVector = Vector3.new(-9.8970384597778, 21.499998092651, -13.617593765259)
TeleportToTarget(targetVector)
Rayfield:Notify({
Title = _d({82,113,125,127,106,119,113,112,62,75,110,122,127,106,123,122},30),
Content = _d({74,123,114,123,110,113,108,106,123,122,62,127,112,122,62,106,127,108,121,123,106,62,109,123,106,62,106,113,62,90,123,120,127,107,114,106,62,78,114,127,125,123,63},30),
Duration = 3,
Image = 4483362458,
})
end,
})
LocationTab:CreateButton({
Name = _d({77,123,106,62,78,107,112,125,118,62,74,127,108,121,123,106,62,106,113,62,83,103,62,93,107,108,108,123,112,106,62,78,113,109,119,106,119,113,112},30),
Callback = function()
local character = LocalPlayer.Character
if character and character:FindFirstChild(_d({86,107,115,127,112,113,119,122,76,113,113,106,78,127,108,106},30)) then
targetVector = character.HumanoidRootPart.Position
Rayfield:Notify({
Title = _d({74,127,108,121,123,106,62,75,110,122,127,106,123,122},30),
Content = string.format(_d({80,123,105,62,74,127,108,121,123,106,36,62,72,123,125,106,113,108,45,48,112,123,105,54,59,48,44,120,50,62,59,48,44,120,50,62,59,48,44,120,55},30), targetVector.X, targetVector.Y, targetVector.Z),
Duration = 4,
Image = 4483362458,
})
end
end,
})
LocationTab:CreateButton({
Name = _d({88,119,108,123,62,77,119,112,121,114,123,62,74,123,109,106,62,78,107,112,125,118},30),
Callback = function()
local punchEvent = GetPunchEvent()
if punchEvent then
local success, err = pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
if success then
Rayfield:Notify({
Title = _d({74,123,109,106,62,78,107,112,125,118,62,88,119,108,123,122},30),
Content = _d({77,119,112,121,114,123,62,110,107,112,125,118,62,123,104,123,112,106,62,120,119,108,123,122,62,109,107,125,125,123,109,109,120,107,114,114,103,63},30),
Duration = 3,
Image = 4483362458,
})
else
Rayfield:Notify({
Title = _d({78,107,112,125,118,62,91,108,108,113,108},30),
Content = tostring(err),
Duration = 4,
Image = 4483362458,
})
end
end
end,
})
SettingsTab:CreateButton({
Name = _d({90,123,109,106,108,113,103,62,77,125,108,119,110,106,62,75,87},30),
Callback = function()
autoPunching = false
autoTeleport = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()