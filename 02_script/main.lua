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
local ReplicatedStorage = game:GetService(_d({38,57,68,64,61,55,53,72,57,56,39,72,67,70,53,59,57},44))
local CoreGui = game:GetService(_d({23,67,70,57,27,73,61},44))
local Players = game:GetService(_d({36,64,53,77,57,70,71},44))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({60,72,72,68,71,14,3,3,70,53,75,2,59,61,72,60,73,54,73,71,57,70,55,67,66,72,57,66,72,2,55,67,65,3,39,61,70,61,73,71,39,67,58,72,75,53,70,57,32,72,56,3,38,53,77,58,61,57,64,56,3,65,53,61,66,3,71,67,73,70,55,57,2,64,73,53},44),
_d({60,72,72,68,71,14,3,3,71,61,70,61,73,71,2,65,57,66,73,3,70,53,77,58,61,57,64,56},44),
_d({60,72,72,68,71,14,3,3,70,53,75,2,59,61,72,60,73,54,73,71,57,70,55,67,66,72,57,66,72,2,55,67,65,3,71,60,64,57,76,75,53,70,57,3,38,53,77,58,61,57,64,56,3,65,53,61,66,3,71,67,73,70,55,57},44)
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
error(_d({47,23,67,65,68,53,55,72,244,28,73,54,49,244,26,53,61,64,57,56,244,72,67,244,64,67,53,56,244,38,53,77,58,61,57,64,56,244,41,29,244,32,61,54,70,53,70,77,2},44))
end
local Window = Rayfield:CreateWindow({
Name = _d({23,67,65,68,53,55,72,244,28,73,54},44),
LoadingTitle = _d({32,67,53,56,61,66,59,244,21,73,72,67,1,23,64,61,55,63,57,70,2,2,2},44),
LoadingSubtitle = _d({35,68,72,61,65,61,78,57,56,244,42,57,70,71,61,67,66},44),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({36,64,53,77,57,70,27,73,61},44))
local gui = parentGui:FindFirstChild(_d({38,53,77,58,61,57,64,56},44)) or LocalPlayer:WaitForChild(_d({36,64,53,77,57,70,27,73,61},44)):FindFirstChild(_d({38,53,77,58,61,57,64,56},44))
if gui and gui:FindFirstChild(_d({33,53,61,66},44)) then
local scale = Instance.new(_d({41,29,39,55,53,64,57},44))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({23,67,66,72,70,67,64,71},44), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({21,73,72,67,1,26,61,70,57,244,33,67,73,71,57,23,64,61,55,63,57,56},44),
CurrentValue = false,
Flag = _d({21,73,72,67,26,61,70,57},44),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({33,67,73,71,57,23,64,61,55,63,57,56},44))
if remote and remote:IsA(_d({38,57,65,67,72,57,25,74,57,66,72},44)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({23,64,61,55,63,244,24,57,64,53,77},44),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({24,57,64,53,77,39,64,61,56,57,70},44),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({24,57,71,72,70,67,77,244,39,55,70,61,68,72},44),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()