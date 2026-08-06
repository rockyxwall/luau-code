(function()
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(b[i] + k)
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local CoreGui = game:GetService(_d({44,88,91,78,48,94,82},23))
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,60,82,91,82,94,92,60,88,79,93,96,74,91,78,53,93,77,24,59,74,98,79,82,78,85,77,24,86,74,82,87,24,92,88,94,91,76,78,23,85,94,74},23),
_d({81,93,93,89,92,35,24,24,92,82,91,82,94,92,23,86,78,87,94,24,91,74,98,79,82,78,85,77},23),
_d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,92,81,85,78,97,96,74,91,78,24,59,74,98,79,82,78,85,77,24,86,74,82,87,24,92,88,94,91,76,78},23)
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
error(_d({68,44,88,86,89,74,76,93,9,49,94,75,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,9,59,74,98,79,82,78,85,77,9,62,50,9,53,82,75,91,74,91,98,23},23))
end
local Window = Rayfield:CreateWindow({
Name = _d({44,88,86,89,74,76,93,9,49,94,75},23),
LoadingTitle = _d({53,88,74,77,82,87,80,9,42,94,93,88,22,44,85,82,76,84,78,91,23,23,23},23),
LoadingSubtitle = _d({56,89,93,82,86,82,99,78,77,9,63,78,91,92,82,88,87},23),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({57,85,74,98,78,91,48,94,82},23))
local gui = parentGui:FindFirstChild(_d({59,74,98,79,82,78,85,77},23)) or LocalPlayer:WaitForChild(_d({57,85,74,98,78,91,48,94,82},23)):FindFirstChild(_d({59,74,98,79,82,78,85,77},23))
if gui and gui:FindFirstChild(_d({54,74,82,87},23)) then
local scale = Instance.new(_d({62,50,60,76,74,85,78},23))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({44,88,87,93,91,88,85,92},23), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({42,94,93,88,22,47,82,91,78,9,54,88,94,92,78,44,85,82,76,84,78,77},23),
CurrentValue = false,
Flag = _d({42,94,93,88,47,82,91,78},23),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({54,88,94,92,78,44,85,82,76,84,78,77},23))
if remote and remote:IsA(_d({59,78,86,88,93,78,46,95,78,87,93},23)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({44,85,82,76,84,9,45,78,85,74,98},23),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({45,78,85,74,98,60,85,82,77,78,91},23),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({45,78,92,93,91,88,98,9,60,76,91,82,89,93},23),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()