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
local ReplicatedStorage = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local CoreGui = game:GetService(_d({26,70,73,60,30,76,64},41))
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,42,64,73,64,76,74,42,70,61,75,78,56,73,60,35,75,59,6,41,56,80,61,64,60,67,59,6,68,56,64,69,6,74,70,76,73,58,60,5,67,76,56},41),
_d({63,75,75,71,74,17,6,6,74,64,73,64,76,74,5,68,60,69,76,6,73,56,80,61,64,60,67,59},41),
_d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,74,63,67,60,79,78,56,73,60,6,41,56,80,61,64,60,67,59,6,68,56,64,69,6,74,70,76,73,58,60},41)
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
error(_d({50,26,70,68,71,56,58,75,247,31,76,57,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,247,41,56,80,61,64,60,67,59,247,44,32,247,35,64,57,73,56,73,80,5},41))
end
local Window = Rayfield:CreateWindow({
Name = _d({26,70,68,71,56,58,75,247,31,76,57},41),
LoadingTitle = _d({35,70,56,59,64,69,62,247,24,76,75,70,4,26,67,64,58,66,60,73,5,5,5},41),
LoadingSubtitle = _d({38,71,75,64,68,64,81,60,59,247,45,60,73,74,64,70,69},41),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({39,67,56,80,60,73,30,76,64},41))
local gui = parentGui:FindFirstChild(_d({41,56,80,61,64,60,67,59},41)) or LocalPlayer:WaitForChild(_d({39,67,56,80,60,73,30,76,64},41)):FindFirstChild(_d({41,56,80,61,64,60,67,59},41))
if gui and gui:FindFirstChild(_d({36,56,64,69},41)) then
local scale = Instance.new(_d({44,32,42,58,56,67,60},41))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({26,70,69,75,73,70,67,74},41), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({24,76,75,70,4,29,64,73,60,247,36,70,76,74,60,26,67,64,58,66,60,59},41),
CurrentValue = false,
Flag = _d({24,76,75,70,29,64,73,60},41),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({36,70,76,74,60,26,67,64,58,66,60,59},41))
if remote and remote:IsA(_d({41,60,68,70,75,60,28,77,60,69,75},41)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({26,67,64,58,66,247,27,60,67,56,80},41),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({27,60,67,56,80,42,67,64,59,60,73},41),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({27,60,74,75,73,70,80,247,42,58,73,64,71,75},41),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()