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
local ReplicatedStorage = game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
local CoreGui = game:GetService(_d({45,89,92,79,49,95,83},22))
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,61,83,92,83,95,93,61,89,80,94,97,75,92,79,54,94,78,25,60,75,99,80,83,79,86,78,25,87,75,83,88,25,93,89,95,92,77,79,24,86,95,75},22),
_d({82,94,94,90,93,36,25,25,93,83,92,83,95,93,24,87,79,88,95,25,92,75,99,80,83,79,86,78},22),
_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,93,82,86,79,98,97,75,92,79,25,60,75,99,80,83,79,86,78,25,87,75,83,88,25,93,89,95,92,77,79},22)
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
error(_d({69,45,89,87,90,75,77,94,10,50,95,76,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,10,60,75,99,80,83,79,86,78,10,63,51,10,54,83,76,92,75,92,99,24},22))
end
local Window = Rayfield:CreateWindow({
Name = _d({45,89,87,90,75,77,94,10,50,95,76},22),
LoadingTitle = _d({54,89,75,78,83,88,81,10,43,95,94,89,23,45,86,83,77,85,79,92,24,24,24},22),
LoadingSubtitle = _d({57,90,94,83,87,83,100,79,78,10,64,79,92,93,83,89,88},22),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({58,86,75,99,79,92,49,95,83},22))
local gui = parentGui:FindFirstChild(_d({60,75,99,80,83,79,86,78},22)) or LocalPlayer:WaitForChild(_d({58,86,75,99,79,92,49,95,83},22)):FindFirstChild(_d({60,75,99,80,83,79,86,78},22))
if gui and gui:FindFirstChild(_d({55,75,83,88},22)) then
local scale = Instance.new(_d({63,51,61,77,75,86,79},22))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({45,89,88,94,92,89,86,93},22), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({43,95,94,89,23,48,83,92,79,10,55,89,95,93,79,45,86,83,77,85,79,78},22),
CurrentValue = false,
Flag = _d({43,95,94,89,48,83,92,79},22),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({55,89,95,93,79,45,86,83,77,85,79,78},22))
if remote and remote:IsA(_d({60,79,87,89,94,79,47,96,79,88,94},22)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({45,86,83,77,85,10,46,79,86,75,99},22),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({46,79,86,75,99,61,86,83,78,79,92},22),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({46,79,93,94,92,89,99,10,61,77,92,83,90,94},22),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()