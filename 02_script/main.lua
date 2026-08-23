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
local ReplicatedStorage = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local CoreGui = game:GetService(_d({24,68,71,58,28,74,62},43))
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,40,62,71,62,74,72,40,68,59,73,76,54,71,58,33,73,57,4,39,54,78,59,62,58,65,57,4,66,54,62,67,4,72,68,74,71,56,58,3,65,74,54},43),
_d({61,73,73,69,72,15,4,4,72,62,71,62,74,72,3,66,58,67,74,4,71,54,78,59,62,58,65,57},43),
_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,72,61,65,58,77,76,54,71,58,4,39,54,78,59,62,58,65,57,4,66,54,62,67,4,72,68,74,71,56,58},43)
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
error(_d({48,24,68,66,69,54,56,73,245,29,74,55,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,245,39,54,78,59,62,58,65,57,245,42,30,245,33,62,55,71,54,71,78,3},43))
end
local Window = Rayfield:CreateWindow({
Name = _d({24,68,66,69,54,56,73,245,29,74,55},43),
LoadingTitle = _d({33,68,54,57,62,67,60,245,22,74,73,68,2,24,65,62,56,64,58,71,3,3,3},43),
LoadingSubtitle = _d({36,69,73,62,66,62,79,58,57,245,43,58,71,72,62,68,67},43),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43))
local gui = parentGui:FindFirstChild(_d({39,54,78,59,62,58,65,57},43)) or LocalPlayer:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43)):FindFirstChild(_d({39,54,78,59,62,58,65,57},43))
if gui and gui:FindFirstChild(_d({34,54,62,67},43)) then
local scale = Instance.new(_d({42,30,40,56,54,65,58},43))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({24,68,67,73,71,68,65,72},43), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({22,74,73,68,2,27,62,71,58,245,34,68,74,72,58,24,65,62,56,64,58,57},43),
CurrentValue = false,
Flag = _d({22,74,73,68,27,62,71,58},43),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({34,68,74,72,58,24,65,62,56,64,58,57},43))
if remote and remote:IsA(_d({39,58,66,68,73,58,26,75,58,67,73},43)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({24,65,62,56,64,245,25,58,65,54,78},43),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({25,58,65,54,78,40,65,62,57,58,71},43),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({25,58,72,73,71,68,78,245,40,56,71,62,69,73},43),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()