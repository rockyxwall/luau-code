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
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local CoreGui = game:GetService(_d({32,76,79,66,36,82,70},35))
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,48,70,79,70,82,80,48,76,67,81,84,62,79,66,41,81,65,12,47,62,86,67,70,66,73,65,12,74,62,70,75,12,80,76,82,79,64,66,11,73,82,62},35),
_d({69,81,81,77,80,23,12,12,80,70,79,70,82,80,11,74,66,75,82,12,79,62,86,67,70,66,73,65},35),
_d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,80,69,73,66,85,84,62,79,66,12,47,62,86,67,70,66,73,65,12,74,62,70,75,12,80,76,82,79,64,66},35)
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
error(_d({56,32,76,74,77,62,64,81,253,37,82,63,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,253,47,62,86,67,70,66,73,65,253,50,38,253,41,70,63,79,62,79,86,11},35))
end
local Window = Rayfield:CreateWindow({
Name = _d({32,76,74,77,62,64,81,253,37,82,63},35),
LoadingTitle = _d({41,76,62,65,70,75,68,253,30,82,81,76,10,32,73,70,64,72,66,79,11,11,11},35),
LoadingSubtitle = _d({44,77,81,70,74,70,87,66,65,253,51,66,79,80,70,76,75},35),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35))
local gui = parentGui:FindFirstChild(_d({47,62,86,67,70,66,73,65},35)) or LocalPlayer:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35)):FindFirstChild(_d({47,62,86,67,70,66,73,65},35))
if gui and gui:FindFirstChild(_d({42,62,70,75},35)) then
local scale = Instance.new(_d({50,38,48,64,62,73,66},35))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({32,76,75,81,79,76,73,80},35), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({30,82,81,76,10,35,70,79,66,253,42,76,82,80,66,32,73,70,64,72,66,65},35),
CurrentValue = false,
Flag = _d({30,82,81,76,35,70,79,66},35),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({42,76,82,80,66,32,73,70,64,72,66,65},35))
if remote and remote:IsA(_d({47,66,74,76,81,66,34,83,66,75,81},35)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({32,73,70,64,72,253,33,66,73,62,86},35),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({33,66,73,62,86,48,73,70,65,66,79},35),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({33,66,80,81,79,76,86,253,48,64,79,70,77,81},35),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()