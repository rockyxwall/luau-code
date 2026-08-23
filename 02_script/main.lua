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
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local CoreGui = game:GetService(_d({10,54,57,44,14,60,48},57))
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,26,48,57,48,60,58,26,54,45,59,62,40,57,44,19,59,43,246,25,40,64,45,48,44,51,43,246,52,40,48,53,246,58,54,60,57,42,44,245,51,60,40},57),
_d({47,59,59,55,58,1,246,246,58,48,57,48,60,58,245,52,44,53,60,246,57,40,64,45,48,44,51,43},57),
_d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,58,47,51,44,63,62,40,57,44,246,25,40,64,45,48,44,51,43,246,52,40,48,53,246,58,54,60,57,42,44},57)
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
error(_d({34,10,54,52,55,40,42,59,231,15,60,41,36,231,13,40,48,51,44,43,231,59,54,231,51,54,40,43,231,25,40,64,45,48,44,51,43,231,28,16,231,19,48,41,57,40,57,64,245},57))
end
local Window = Rayfield:CreateWindow({
Name = _d({10,54,52,55,40,42,59,231,15,60,41},57),
LoadingTitle = _d({19,54,40,43,48,53,46,231,8,60,59,54,244,10,51,48,42,50,44,57,245,245,245},57),
LoadingSubtitle = _d({22,55,59,48,52,48,65,44,43,231,29,44,57,58,48,54,53},57),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57))
local gui = parentGui:FindFirstChild(_d({25,40,64,45,48,44,51,43},57)) or LocalPlayer:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57)):FindFirstChild(_d({25,40,64,45,48,44,51,43},57))
if gui and gui:FindFirstChild(_d({20,40,48,53},57)) then
local scale = Instance.new(_d({28,16,26,42,40,51,44},57))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({10,54,53,59,57,54,51,58},57), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({8,60,59,54,244,13,48,57,44,231,20,54,60,58,44,10,51,48,42,50,44,43},57),
CurrentValue = false,
Flag = _d({8,60,59,54,13,48,57,44},57),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({20,54,60,58,44,10,51,48,42,50,44,43},57))
if remote and remote:IsA(_d({25,44,52,54,59,44,12,61,44,53,59},57)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({10,51,48,42,50,231,11,44,51,40,64},57),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({11,44,51,40,64,26,51,48,43,44,57},57),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({11,44,58,59,57,54,64,231,26,42,57,48,55,59},57),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()