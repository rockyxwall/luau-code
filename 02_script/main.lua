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
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local CoreGui = game:GetService(_d({12,56,59,46,16,62,50},55))
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,28,50,59,50,62,60,28,56,47,61,64,42,59,46,21,61,45,248,27,42,66,47,50,46,53,45,248,54,42,50,55,248,60,56,62,59,44,46,247,53,62,42},55),
_d({49,61,61,57,60,3,248,248,60,50,59,50,62,60,247,54,46,55,62,248,59,42,66,47,50,46,53,45},55),
_d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,60,49,53,46,65,64,42,59,46,248,27,42,66,47,50,46,53,45,248,54,42,50,55,248,60,56,62,59,44,46},55)
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
error(_d({36,12,56,54,57,42,44,61,233,17,62,43,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,233,27,42,66,47,50,46,53,45,233,30,18,233,21,50,43,59,42,59,66,247},55))
end
local Window = Rayfield:CreateWindow({
Name = _d({12,56,54,57,42,44,61,233,17,62,43},55),
LoadingTitle = _d({21,56,42,45,50,55,48,233,10,62,61,56,246,12,53,50,44,52,46,59,247,247,247},55),
LoadingSubtitle = _d({24,57,61,50,54,50,67,46,45,233,31,46,59,60,50,56,55},55),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({25,53,42,66,46,59,16,62,50},55))
local gui = parentGui:FindFirstChild(_d({27,42,66,47,50,46,53,45},55)) or LocalPlayer:WaitForChild(_d({25,53,42,66,46,59,16,62,50},55)):FindFirstChild(_d({27,42,66,47,50,46,53,45},55))
if gui and gui:FindFirstChild(_d({22,42,50,55},55)) then
local scale = Instance.new(_d({30,18,28,44,42,53,46},55))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({12,56,55,61,59,56,53,60},55), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({10,62,61,56,246,15,50,59,46,233,22,56,62,60,46,12,53,50,44,52,46,45},55),
CurrentValue = false,
Flag = _d({10,62,61,56,15,50,59,46},55),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({22,56,62,60,46,12,53,50,44,52,46,45},55))
if remote and remote:IsA(_d({27,46,54,56,61,46,14,63,46,55,61},55)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({12,53,50,44,52,233,13,46,53,42,66},55),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({13,46,53,42,66,28,53,50,45,46,59},55),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({13,46,60,61,59,56,66,233,28,44,59,50,57,61},55),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()