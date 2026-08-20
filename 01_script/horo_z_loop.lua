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
local ReplicatedStorage = game:GetService(_d({40,59,70,66,63,57,55,74,59,58,41,74,69,72,55,61,59},42))
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,41,63,72,63,75,73,41,69,60,74,77,55,72,59,34,74,58,5,40,55,79,60,63,59,66,58,5,67,55,63,68,5,73,69,75,72,57,59,4,66,75,55},42),
_d({62,74,74,70,73,16,5,5,73,63,72,63,75,73,4,67,59,68,75,5,72,55,79,60,63,59,66,58},42),
_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,73,62,66,59,78,77,55,72,59,5,40,55,79,60,63,59,66,58,5,67,55,63,68,5,73,69,75,72,57,59},42)
}
for _, url in ipairs(rayfieldSources) do
local success, result = pcall(function()
return loadstring(game:HttpGet(url))()
end)
if success and result then
Rayfield = result
break
end
end
if not Rayfield then
error(_d({49,30,69,72,69,24,69,74,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,246,40,55,79,60,63,59,66,58,246,43,31,246,34,63,56,72,55,72,79,4},42))
end
local Window = Rayfield:CreateWindow({
Name = _d({30,69,72,69,246,30,69,72,69,246,48,3,34,69,69,70},42),
LoadingTitle = _d({34,69,55,58,63,68,61,246,30,69,72,69,246,24,69,74,4,4,4},42),
LoadingSubtitle = _d({35,63,68,63,246,30,69,66,66,69,77,246,23,75,74,69,67,55,74,69,72},42),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoZ = false
local targetName = ""
local summonAimDelay = 0.3
local cooldownDelay = 10.0
local function getTargetNPC()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if not root then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({36,38,25,73},42))
local searchPool = npcsFolder and npcsFolder:GetChildren() or Workspace:GetChildren()
local nearest, nearestDist = nil, math.huge
for _, model in ipairs(searchPool) do
if model:IsA(_d({35,69,58,59,66},42)) and model ~= char then
local hrp = model:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
local hum = model:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
if hrp and hum and hum.Health > 0 then
if targetName ~= "" then
if string.find(string.lower(model.Name), string.lower(targetName)) then
return hrp
end
else
local dist = (hrp.Position - root.Position).Magnitude
if dist < nearestDist then
nearestDist = dist
nearest = hrp
end
end
end
end
end
return nearest
end
local function executeZSkill()
local skillRemote = ReplicatedStorage:FindFirstChild(_d({27,76,59,68,74,73},42)) and ReplicatedStorage.Events:FindFirstChild(_d({41,65,63,66,66},42))
if skillRemote and skillRemote:IsA(_d({40,59,67,69,74,59,28,75,68,57,74,63,69,68},42)) then
pcall(function()
skillRemote:InvokeServer(_d({35,63,68,63,246,30,69,66,66,69,77,246,24,55,72,72,55,61,59},42))
end)
end
task.wait(summonAimDelay)
local targetRoot = getTargetNPC()
if not targetRoot then
warn(_d({49,30,69,72,69,24,69,74,51,246,36,69,246,74,55,72,61,59,74,246,60,69,75,68,58,246,60,69,72,246,48,246,73,65,63,66,66,4},42))
return
end
local dynamicRemoteName = LocalPlayer.Name .. _d({82,41,59,72,76,59,72,41,57,72,63,70,74,41,59,72,76,63,57,59,4,41,65,63,66,66,73,4,41,65,63,66,66,73,4,41,65,63,66,66,25,69,68,74,55,63,68,59,72,4,30,69,72,69,3,30,69,72,69,4,35,63,68,63,246,30,69,66,66,69,77,246,24,55,72,72,55,61,59},42)
local targetRemote = ReplicatedStorage:FindFirstChild(dynamicRemoteName)
if targetRemote and targetRemote:IsA(_d({40,59,67,69,74,59,27,76,59,68,74},42)) then
pcall(function()
targetRemote:FireServer({
Target = targetRoot,
cf = targetRoot.CFrame
})
end)
else
warn(_d({49,30,69,72,69,24,69,74,51,246,26,79,68,55,67,63,57,246,74,55,72,61,59,74,63,68,61,246,72,59,67,69,74,59,246,68,69,74,246,60,69,75,68,58,16,246},42) .. tostring(dynamicRemoteName))
end
end
local MainTab = Window:CreateTab(_d({25,69,67,56,55,74,246,23,75,74,69,67,55,74,63,69,68},42), 4483362458)
local AutoToggle = MainTab:CreateToggle({
Name = _d({23,75,74,69,246,48,246,34,69,69,70},42),
CurrentValue = false,
Flag = _d({23,75,74,69,48,34,69,69,70},42),
Callback = function(Value)
autoZ = Value
if autoZ then
task.spawn(function()
while autoZ do
pcall(executeZSkill)
task.wait(cooldownDelay)
end
end)
end
end,
})
MainTab:CreateInput({
Name = _d({42,55,72,61,59,74,246,24,69,73,73,5,36,38,25,246,36,55,67,59},42),
PlaceholderText = _d({23,78,59,246,30,55,68,58,246,34,69,61,55,68},42),
RemoveTextAfterFocusLost = false,
Callback = function(Text)
targetName = Text or ""
end,
})
MainTab:CreateSlider({
Name = _d({41,75,67,67,69,68,246,74,69,246,42,55,72,61,59,74,246,26,59,66,55,79},42),
Range = {0.1, 1.0},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.3,
Flag = _d({41,75,67,67,69,68,26,59,66,55,79},42),
Callback = function(Value)
summonAimDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({48,246,25,69,69,66,58,69,77,68,246,26,59,66,55,79},42),
Range = {5.0, 15.0},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.0,
Flag = _d({25,69,69,66,58,69,77,68,26,59,66,55,79},42),
Callback = function(Value)
cooldownDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({26,59,73,74,72,69,79,246,41,57,72,63,70,74,246,43,31},42),
Callback = function()
autoZ = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
print(_d({49,30,69,72,69,24,69,74,51,246,34,69,55,58,59,58,246,48,3,66,69,69,70,246,73,75,57,57,59,73,73,60,75,66,66,79,4},42))
end)()