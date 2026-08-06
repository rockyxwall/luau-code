local _bxor = (bit32 and bit32.bxor) or function(a, b) return a ~ b end
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(_bxor(b[i], k))
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({49,6,19,15,10,0,2,23,6,7,48,23,12,17,2,4,6},99))
local CoreGui = game:GetService(_d({32,12,17,6,36,22,10},99))
local Players = game:GetService(_d({51,15,2,26,6,17,16},99))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({11,23,23,19,16,89,76,76,17,2,20,77,4,10,23,11,22,1,22,16,6,17,0,12,13,23,6,13,23,77,0,12,14,76,48,10,17,10,22,16,48,12,5,23,20,2,17,6,47,23,7,76,49,2,26,5,10,6,15,7,76,14,2,10,13,76,16,12,22,17,0,6,77,15,22,2},99),
_d({11,23,23,19,16,89,76,76,16,10,17,10,22,16,77,14,6,13,22,76,17,2,26,5,10,6,15,7},99),
_d({11,23,23,19,16,89,76,76,17,2,20,77,4,10,23,11,22,1,22,16,6,17,0,12,13,23,6,13,23,77,0,12,14,76,16,11,15,6,27,20,2,17,6,76,49,2,26,5,10,6,15,7,76,14,2,10,13,76,16,12,22,17,0,6},99)
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
error(_d({56,32,12,14,19,2,0,23,67,43,22,1,62,67,37,2,10,15,6,7,67,23,12,67,15,12,2,7,67,49,2,26,5,10,6,15,7,67,54,42,67,47,10,1,17,2,17,26,77},99))
end
local Window = Rayfield:CreateWindow({
Name = _d({32,12,14,19,2,0,23,67,43,22,1},99),
LoadingTitle = _d({47,12,2,7,10,13,4,67,34,22,23,12,78,32,15,10,0,8,6,17,77,77,77},99),
LoadingSubtitle = _d({44,19,23,10,14,10,25,6,7,67,53,6,17,16,10,12,13},99),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({51,15,2,26,6,17,36,22,10},99))
local gui = parentGui:FindFirstChild(_d({49,2,26,5,10,6,15,7},99)) or LocalPlayer:WaitForChild(_d({51,15,2,26,6,17,36,22,10},99)):FindFirstChild(_d({49,2,26,5,10,6,15,7},99))
if gui and gui:FindFirstChild(_d({46,2,10,13},99)) then
local scale = Instance.new(_d({54,42,48,0,2,15,6},99))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({32,12,13,23,17,12,15,16},99), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({34,22,23,12,78,37,10,17,6,67,46,12,22,16,6,32,15,10,0,8,6,7},99),
CurrentValue = false,
Flag = _d({34,22,23,12,37,10,17,6},99),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({46,12,22,16,6,32,15,10,0,8,6,7},99))
if remote and remote:IsA(_d({49,6,14,12,23,6,38,21,6,13,23},99)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({32,15,10,0,8,67,39,6,15,2,26},99),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({39,6,15,2,26,48,15,10,7,6,17},99),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({39,6,16,23,17,12,26,67,48,0,17,10,19,23},99),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()