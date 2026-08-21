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
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local CoreGui = game:GetService(_d({47,91,94,81,51,97,85},20))
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({84,96,96,92,95,38,27,27,94,77,99,26,83,85,96,84,97,78,97,95,81,94,79,91,90,96,81,90,96,26,79,91,89,27,63,85,94,85,97,95,63,91,82,96,99,77,94,81,56,96,80,27,62,77,101,82,85,81,88,80,27,89,77,85,90,27,95,91,97,94,79,81,26,88,97,77},20),
_d({84,96,96,92,95,38,27,27,95,85,94,85,97,95,26,89,81,90,97,27,94,77,101,82,85,81,88,80},20),
_d({84,96,96,92,95,38,27,27,94,77,99,26,83,85,96,84,97,78,97,95,81,94,79,91,90,96,81,90,96,26,79,91,89,27,95,84,88,81,100,99,77,94,81,27,62,77,101,82,85,81,88,80,27,89,77,85,90,27,95,91,97,94,79,81},20)
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
error(_d({71,47,91,89,92,77,79,96,12,52,97,78,73,12,50,77,85,88,81,80,12,96,91,12,88,91,77,80,12,62,77,101,82,85,81,88,80,12,65,53,12,56,85,78,94,77,94,101,26},20))
end
local Window = Rayfield:CreateWindow({
Name = _d({47,91,89,92,77,79,96,12,52,97,78},20),
LoadingTitle = _d({56,91,77,80,85,90,83,12,45,97,96,91,25,47,88,85,79,87,81,94,26,26,26},20),
LoadingSubtitle = _d({59,92,96,85,89,85,102,81,80,12,66,81,94,95,85,91,90},20),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20))
local gui = parentGui:FindFirstChild(_d({62,77,101,82,85,81,88,80},20)) or LocalPlayer:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20)):FindFirstChild(_d({62,77,101,82,85,81,88,80},20))
if gui and gui:FindFirstChild(_d({57,77,85,90},20)) then
local scale = Instance.new(_d({65,53,63,79,77,88,81},20))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({47,91,90,96,94,91,88,95},20), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({45,97,96,91,25,50,85,94,81,12,57,91,97,95,81,47,88,85,79,87,81,80},20),
CurrentValue = false,
Flag = _d({45,97,96,91,50,85,94,81},20),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({57,91,97,95,81,47,88,85,79,87,81,80},20))
if remote and remote:IsA(_d({62,81,89,91,96,81,49,98,81,90,96},20)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({47,88,85,79,87,12,48,81,88,77,101},20),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({48,81,88,77,101,63,88,85,80,81,94},20),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({48,81,95,96,94,91,101,12,63,79,94,85,92,96},20),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()