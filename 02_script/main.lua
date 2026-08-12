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
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local CoreGui = game:GetService(_d({48,92,95,82,52,98,86},19))
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,64,86,95,86,98,96,64,92,83,97,100,78,95,82,57,97,81,28,63,78,102,83,86,82,89,81,28,90,78,86,91,28,96,92,98,95,80,82,27,89,98,78},19),
_d({85,97,97,93,96,39,28,28,96,86,95,86,98,96,27,90,82,91,98,28,95,78,102,83,86,82,89,81},19),
_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,96,85,89,82,101,100,78,95,82,28,63,78,102,83,86,82,89,81,28,90,78,86,91,28,96,92,98,95,80,82},19)
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
error(_d({72,48,92,90,93,78,80,97,13,53,98,79,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,13,63,78,102,83,86,82,89,81,13,66,54,13,57,86,79,95,78,95,102,27},19))
end
local Window = Rayfield:CreateWindow({
Name = _d({48,92,90,93,78,80,97,13,53,98,79},19),
LoadingTitle = _d({57,92,78,81,86,91,84,13,46,98,97,92,26,48,89,86,80,88,82,95,27,27,27},19),
LoadingSubtitle = _d({60,93,97,86,90,86,103,82,81,13,67,82,95,96,86,92,91},19),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19))
local gui = parentGui:FindFirstChild(_d({63,78,102,83,86,82,89,81},19)) or LocalPlayer:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19)):FindFirstChild(_d({63,78,102,83,86,82,89,81},19))
if gui and gui:FindFirstChild(_d({58,78,86,91},19)) then
local scale = Instance.new(_d({66,54,64,80,78,89,82},19))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({48,92,91,97,95,92,89,96},19), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({46,98,97,92,26,51,86,95,82,13,58,92,98,96,82,48,89,86,80,88,82,81},19),
CurrentValue = false,
Flag = _d({46,98,97,92,51,86,95,82},19),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({58,92,98,96,82,48,89,86,80,88,82,81},19))
if remote and remote:IsA(_d({63,82,90,92,97,82,50,99,82,91,97},19)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({48,89,86,80,88,13,49,82,89,78,102},19),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({49,82,89,78,102,64,89,86,81,82,95},19),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({49,82,96,97,95,92,102,13,64,80,95,86,93,97},19),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()