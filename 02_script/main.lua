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
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local CoreGui = game:GetService(_d({7,51,54,41,11,57,45},60))
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,23,45,54,45,57,55,23,51,42,56,59,37,54,41,16,56,40,243,22,37,61,42,45,41,48,40,243,49,37,45,50,243,55,51,57,54,39,41,242,48,57,37},60),
_d({44,56,56,52,55,254,243,243,55,45,54,45,57,55,242,49,41,50,57,243,54,37,61,42,45,41,48,40},60),
_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,55,44,48,41,60,59,37,54,41,243,22,37,61,42,45,41,48,40,243,49,37,45,50,243,55,51,57,54,39,41},60)
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
error(_d({31,7,51,49,52,37,39,56,228,12,57,38,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,228,22,37,61,42,45,41,48,40,228,25,13,228,16,45,38,54,37,54,61,242},60))
end
local Window = Rayfield:CreateWindow({
Name = _d({7,51,49,52,37,39,56,228,12,57,38},60),
LoadingTitle = _d({16,51,37,40,45,50,43,228,5,57,56,51,241,7,48,45,39,47,41,54,242,242,242},60),
LoadingSubtitle = _d({19,52,56,45,49,45,62,41,40,228,26,41,54,55,45,51,50},60),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({20,48,37,61,41,54,11,57,45},60))
local gui = parentGui:FindFirstChild(_d({22,37,61,42,45,41,48,40},60)) or LocalPlayer:WaitForChild(_d({20,48,37,61,41,54,11,57,45},60)):FindFirstChild(_d({22,37,61,42,45,41,48,40},60))
if gui and gui:FindFirstChild(_d({17,37,45,50},60)) then
local scale = Instance.new(_d({25,13,23,39,37,48,41},60))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({7,51,50,56,54,51,48,55},60), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({5,57,56,51,241,10,45,54,41,228,17,51,57,55,41,7,48,45,39,47,41,40},60),
CurrentValue = false,
Flag = _d({5,57,56,51,10,45,54,41},60),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({17,51,57,55,41,7,48,45,39,47,41,40},60))
if remote and remote:IsA(_d({22,41,49,51,56,41,9,58,41,50,56},60)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({7,48,45,39,47,228,8,41,48,37,61},60),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({8,41,48,37,61,23,48,45,40,41,54},60),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({8,41,55,56,54,51,61,228,23,39,54,45,52,56},60),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()