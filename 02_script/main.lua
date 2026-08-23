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
local ReplicatedStorage = game:GetService(_d({67,86,97,93,90,84,82,101,86,85,68,101,96,99,82,88,86},15))
local CoreGui = game:GetService(_d({52,96,99,86,56,102,90},15))
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,68,90,99,90,102,100,68,96,87,101,104,82,99,86,61,101,85,32,67,82,106,87,90,86,93,85,32,94,82,90,95,32,100,96,102,99,84,86,31,93,102,82},15),
_d({89,101,101,97,100,43,32,32,100,90,99,90,102,100,31,94,86,95,102,32,99,82,106,87,90,86,93,85},15),
_d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,100,89,93,86,105,104,82,99,86,32,67,82,106,87,90,86,93,85,32,94,82,90,95,32,100,96,102,99,84,86},15)
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
error(_d({76,52,96,94,97,82,84,101,17,57,102,83,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,17,67,82,106,87,90,86,93,85,17,70,58,17,61,90,83,99,82,99,106,31},15))
end
local Window = Rayfield:CreateWindow({
Name = _d({52,96,94,97,82,84,101,17,57,102,83},15),
LoadingTitle = _d({61,96,82,85,90,95,88,17,50,102,101,96,30,52,93,90,84,92,86,99,31,31,31},15),
LoadingSubtitle = _d({64,97,101,90,94,90,107,86,85,17,71,86,99,100,90,96,95},15),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({65,93,82,106,86,99,56,102,90},15))
local gui = parentGui:FindFirstChild(_d({67,82,106,87,90,86,93,85},15)) or LocalPlayer:WaitForChild(_d({65,93,82,106,86,99,56,102,90},15)):FindFirstChild(_d({67,82,106,87,90,86,93,85},15))
if gui and gui:FindFirstChild(_d({62,82,90,95},15)) then
local scale = Instance.new(_d({70,58,68,84,82,93,86},15))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({52,96,95,101,99,96,93,100},15), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({50,102,101,96,30,55,90,99,86,17,62,96,102,100,86,52,93,90,84,92,86,85},15),
CurrentValue = false,
Flag = _d({50,102,101,96,55,90,99,86},15),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({62,96,102,100,86,52,93,90,84,92,86,85},15))
if remote and remote:IsA(_d({67,86,94,96,101,86,54,103,86,95,101},15)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({52,93,90,84,92,17,53,86,93,82,106},15),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({53,86,93,82,106,68,93,90,85,86,99},15),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({53,86,100,101,99,96,106,17,68,84,99,90,97,101},15),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()