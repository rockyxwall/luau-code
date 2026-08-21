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
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local CoreGui = game:GetService(_d({6,50,53,40,10,56,44},61))
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,22,44,53,44,56,54,22,50,41,55,58,36,53,40,15,55,39,242,21,36,60,41,44,40,47,39,242,48,36,44,49,242,54,50,56,53,38,40,241,47,56,36},61),
_d({43,55,55,51,54,253,242,242,54,44,53,44,56,54,241,48,40,49,56,242,53,36,60,41,44,40,47,39},61),
_d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,54,43,47,40,59,58,36,53,40,242,21,36,60,41,44,40,47,39,242,48,36,44,49,242,54,50,56,53,38,40},61)
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
error(_d({30,6,50,48,51,36,38,55,227,11,56,37,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,227,21,36,60,41,44,40,47,39,227,24,12,227,15,44,37,53,36,53,60,241},61))
end
local Window = Rayfield:CreateWindow({
Name = _d({6,50,48,51,36,38,55,227,11,56,37},61),
LoadingTitle = _d({15,50,36,39,44,49,42,227,4,56,55,50,240,6,47,44,38,46,40,53,241,241,241},61),
LoadingSubtitle = _d({18,51,55,44,48,44,61,40,39,227,25,40,53,54,44,50,49},61),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({19,47,36,60,40,53,10,56,44},61))
local gui = parentGui:FindFirstChild(_d({21,36,60,41,44,40,47,39},61)) or LocalPlayer:WaitForChild(_d({19,47,36,60,40,53,10,56,44},61)):FindFirstChild(_d({21,36,60,41,44,40,47,39},61))
if gui and gui:FindFirstChild(_d({16,36,44,49},61)) then
local scale = Instance.new(_d({24,12,22,38,36,47,40},61))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({6,50,49,55,53,50,47,54},61), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({4,56,55,50,240,9,44,53,40,227,16,50,56,54,40,6,47,44,38,46,40,39},61),
CurrentValue = false,
Flag = _d({4,56,55,50,9,44,53,40},61),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({16,50,56,54,40,6,47,44,38,46,40,39},61))
if remote and remote:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({6,47,44,38,46,227,7,40,47,36,60},61),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({7,40,47,36,60,22,47,44,39,40,53},61),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({7,40,54,55,53,50,60,227,22,38,53,44,51,55},61),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()