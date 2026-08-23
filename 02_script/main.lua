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
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local CoreGui = game:GetService(_d({33,77,80,67,37,83,71},34))
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,49,71,80,71,83,81,49,77,68,82,85,63,80,67,42,82,66,13,48,63,87,68,71,67,74,66,13,75,63,71,76,13,81,77,83,80,65,67,12,74,83,63},34),
_d({70,82,82,78,81,24,13,13,81,71,80,71,83,81,12,75,67,76,83,13,80,63,87,68,71,67,74,66},34),
_d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,81,70,74,67,86,85,63,80,67,13,48,63,87,68,71,67,74,66,13,75,63,71,76,13,81,77,83,80,65,67},34)
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
error(_d({57,33,77,75,78,63,65,82,254,38,83,64,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,254,48,63,87,68,71,67,74,66,254,51,39,254,42,71,64,80,63,80,87,12},34))
end
local Window = Rayfield:CreateWindow({
Name = _d({33,77,75,78,63,65,82,254,38,83,64},34),
LoadingTitle = _d({42,77,63,66,71,76,69,254,31,83,82,77,11,33,74,71,65,73,67,80,12,12,12},34),
LoadingSubtitle = _d({45,78,82,71,75,71,88,67,66,254,52,67,80,81,71,77,76},34),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({46,74,63,87,67,80,37,83,71},34))
local gui = parentGui:FindFirstChild(_d({48,63,87,68,71,67,74,66},34)) or LocalPlayer:WaitForChild(_d({46,74,63,87,67,80,37,83,71},34)):FindFirstChild(_d({48,63,87,68,71,67,74,66},34))
if gui and gui:FindFirstChild(_d({43,63,71,76},34)) then
local scale = Instance.new(_d({51,39,49,65,63,74,67},34))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({33,77,76,82,80,77,74,81},34), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({31,83,82,77,11,36,71,80,67,254,43,77,83,81,67,33,74,71,65,73,67,66},34),
CurrentValue = false,
Flag = _d({31,83,82,77,36,71,80,67},34),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({43,77,83,81,67,33,74,71,65,73,67,66},34))
if remote and remote:IsA(_d({48,67,75,77,82,67,35,84,67,76,82},34)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({33,74,71,65,73,254,34,67,74,63,87},34),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({34,67,74,63,87,49,74,71,66,67,80},34),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({34,67,81,82,80,77,87,254,49,65,80,71,78,82},34),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()