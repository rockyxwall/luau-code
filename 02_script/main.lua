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
local ReplicatedStorage = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local CoreGui = game:GetService(_d({42,86,89,76,46,92,80},25))
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,58,80,89,80,92,90,58,86,77,91,94,72,89,76,51,91,75,22,57,72,96,77,80,76,83,75,22,84,72,80,85,22,90,86,92,89,74,76,21,83,92,72},25),
_d({79,91,91,87,90,33,22,22,90,80,89,80,92,90,21,84,76,85,92,22,89,72,96,77,80,76,83,75},25),
_d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,90,79,83,76,95,94,72,89,76,22,57,72,96,77,80,76,83,75,22,84,72,80,85,22,90,86,92,89,74,76},25)
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
error(_d({66,42,86,84,87,72,74,91,7,47,92,73,68,7,45,72,80,83,76,75,7,91,86,7,83,86,72,75,7,57,72,96,77,80,76,83,75,7,60,48,7,51,80,73,89,72,89,96,21},25))
end
local Window = Rayfield:CreateWindow({
Name = _d({42,86,84,87,72,74,91,7,47,92,73},25),
LoadingTitle = _d({51,86,72,75,80,85,78,7,40,92,91,86,20,42,83,80,74,82,76,89,21,21,21},25),
LoadingSubtitle = _d({54,87,91,80,84,80,97,76,75,7,61,76,89,90,80,86,85},25),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({55,83,72,96,76,89,46,92,80},25))
local gui = parentGui:FindFirstChild(_d({57,72,96,77,80,76,83,75},25)) or LocalPlayer:WaitForChild(_d({55,83,72,96,76,89,46,92,80},25)):FindFirstChild(_d({57,72,96,77,80,76,83,75},25))
if gui and gui:FindFirstChild(_d({52,72,80,85},25)) then
local scale = Instance.new(_d({60,48,58,74,72,83,76},25))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({42,86,85,91,89,86,83,90},25), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({40,92,91,86,20,45,80,89,76,7,52,86,92,90,76,42,83,80,74,82,76,75},25),
CurrentValue = false,
Flag = _d({40,92,91,86,45,80,89,76},25),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({52,86,92,90,76,42,83,80,74,82,76,75},25))
if remote and remote:IsA(_d({57,76,84,86,91,76,44,93,76,85,91},25)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({42,83,80,74,82,7,43,76,83,72,96},25),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({43,76,83,72,96,58,83,80,75,76,89},25),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({43,76,90,91,89,86,96,7,58,74,89,80,87,91},25),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()