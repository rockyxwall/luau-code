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
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local CoreGui = game:GetService(_d({46,90,93,80,50,96,84},21))
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,62,84,93,84,96,94,62,90,81,95,98,76,93,80,55,95,79,26,61,76,100,81,84,80,87,79,26,88,76,84,89,26,94,90,96,93,78,80,25,87,96,76},21),
_d({83,95,95,91,94,37,26,26,94,84,93,84,96,94,25,88,80,89,96,26,93,76,100,81,84,80,87,79},21),
_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,94,83,87,80,99,98,76,93,80,26,61,76,100,81,84,80,87,79,26,88,76,84,89,26,94,90,96,93,78,80},21)
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
error(_d({70,46,90,88,91,76,78,95,11,51,96,77,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,11,61,76,100,81,84,80,87,79,11,64,52,11,55,84,77,93,76,93,100,25},21))
end
local Window = Rayfield:CreateWindow({
Name = _d({46,90,88,91,76,78,95,11,51,96,77},21),
LoadingTitle = _d({55,90,76,79,84,89,82,11,44,96,95,90,24,46,87,84,78,86,80,93,25,25,25},21),
LoadingSubtitle = _d({58,91,95,84,88,84,101,80,79,11,65,80,93,94,84,90,89},21),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21))
local gui = parentGui:FindFirstChild(_d({61,76,100,81,84,80,87,79},21)) or LocalPlayer:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21)):FindFirstChild(_d({61,76,100,81,84,80,87,79},21))
if gui and gui:FindFirstChild(_d({56,76,84,89},21)) then
local scale = Instance.new(_d({64,52,62,78,76,87,80},21))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({46,90,89,95,93,90,87,94},21), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({44,96,95,90,24,49,84,93,80,11,56,90,96,94,80,46,87,84,78,86,80,79},21),
CurrentValue = false,
Flag = _d({44,96,95,90,49,84,93,80},21),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({56,90,96,94,80,46,87,84,78,86,80,79},21))
if remote and remote:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({46,87,84,78,86,11,47,80,87,76,100},21),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({47,80,87,76,100,62,87,84,79,80,93},21),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({47,80,94,95,93,90,100,11,62,78,93,84,91,95},21),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()