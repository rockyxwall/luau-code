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
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local CoreGui = game:GetService(_d({43,87,90,77,47,93,81},24))
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,59,81,90,81,93,91,59,87,78,92,95,73,90,77,52,92,76,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77,22,84,93,73},24),
_d({80,92,92,88,91,34,23,23,91,81,90,81,93,91,22,85,77,86,93,23,90,73,97,78,81,77,84,76},24),
_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,91,80,84,77,96,95,73,90,77,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77},24)
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
error(_d({67,43,87,85,88,73,75,92,8,48,93,74,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,58,73,97,78,81,77,84,76,8,61,49,8,52,81,74,90,73,90,97,22},24))
end
local Window = Rayfield:CreateWindow({
Name = _d({43,87,85,88,73,75,92,8,48,93,74},24),
LoadingTitle = _d({52,87,73,76,81,86,79,8,41,93,92,87,21,43,84,81,75,83,77,90,22,22,22},24),
LoadingSubtitle = _d({55,88,92,81,85,81,98,77,76,8,62,77,90,91,81,87,86},24),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({56,84,73,97,77,90,47,93,81},24))
local gui = parentGui:FindFirstChild(_d({58,73,97,78,81,77,84,76},24)) or LocalPlayer:WaitForChild(_d({56,84,73,97,77,90,47,93,81},24)):FindFirstChild(_d({58,73,97,78,81,77,84,76},24))
if gui and gui:FindFirstChild(_d({53,73,81,86},24)) then
local scale = Instance.new(_d({61,49,59,75,73,84,77},24))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({43,87,86,92,90,87,84,91},24), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({41,93,92,87,21,46,81,90,77,8,53,87,93,91,77,43,84,81,75,83,77,76},24),
CurrentValue = false,
Flag = _d({41,93,92,87,46,81,90,77},24),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({53,87,93,91,77,43,84,81,75,83,77,76},24))
if remote and remote:IsA(_d({58,77,85,87,92,77,45,94,77,86,92},24)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({43,84,81,75,83,8,44,77,84,73,97},24),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({44,77,84,73,97,59,84,81,76,77,90},24),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({44,77,91,92,90,87,97,8,59,75,90,81,88,92},24),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()