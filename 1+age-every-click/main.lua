local _bit = bit32 or {bxor = function(a,b) return a ~ b end}
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(_bit.bxor(b[i], k))
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({7,48,37,57,60,54,52,33,48,49,6,33,58,39,52,50,48},85))
local CoreGui = game:GetService(_d({22,58,39,48,18,32,60},85))
local Players = game:GetService(_d({5,57,52,44,48,39,38},85))
local Rayfield = loadstring(game:HttpGet(_d({61,33,33,37,38,111,122,122,38,60,39,60,32,38,123,56,48,59,32,122,39,52,44,51,60,48,57,49},85)))()
local Window = Rayfield:CreateWindow({
Name = _d({22,58,56,37,52,54,33,117,29,32,55},85),
LoadingTitle = _d({25,58,52,49,60,59,50,117,20,32,33,58,120,22,57,60,54,62,48,39,123,123,123},85),
LoadingSubtitle = _d({26,37,33,60,56,60,47,48,49,117,3,48,39,38,60,58,59},85),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.5)
local gui = CoreGui:FindFirstChild(_d({7,52,44,51,60,48,57,49},85)) or Players.LocalPlayer:WaitForChild(_d({5,57,52,44,48,39,18,32,60},85)):FindFirstChild(_d({7,52,44,51,60,48,57,49},85))
if gui and gui:FindFirstChild(_d({24,52,60,59},85)) then
local scale = Instance.new(_d({0,28,6,54,52,57,48},85))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
local MainTab = Window:CreateTab(_d({22,58,59,33,39,58,57,38},85), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({20,32,33,58,120,19,60,39,48,117,24,58,32,38,48,22,57,60,54,62,48,49},85),
CurrentValue = false,
Flag = _d({20,32,33,58,19,60,39,48},85),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({24,58,32,38,48,22,57,60,54,62,48,49},85))
if remote and remote:IsA(_d({7,48,56,58,33,48,16,35,48,59,33},85)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({22,57,60,54,62,117,17,48,57,52,44},85),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({17,48,57,52,44,6,57,60,49,48,39},85),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({17,48,38,33,39,58,44,117,6,54,39,60,37,33},85),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()