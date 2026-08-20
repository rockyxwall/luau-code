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
local ReplicatedStorage = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local CoreGui = game:GetService(_d({5,49,52,39,9,55,43},62))
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,21,43,52,43,55,53,21,49,40,54,57,35,52,39,14,54,38,241,20,35,59,40,43,39,46,38,241,47,35,43,48,241,53,49,55,52,37,39,240,46,55,35},62),
_d({42,54,54,50,53,252,241,241,53,43,52,43,55,53,240,47,39,48,55,241,52,35,59,40,43,39,46,38},62),
_d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,53,42,46,39,58,57,35,52,39,241,20,35,59,40,43,39,46,38,241,47,35,43,48,241,53,49,55,52,37,39},62)
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
error(_d({29,5,49,47,50,35,37,54,226,10,55,36,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,226,20,35,59,40,43,39,46,38,226,23,11,226,14,43,36,52,35,52,59,240},62))
end
local Window = Rayfield:CreateWindow({
Name = _d({5,49,47,50,35,37,54,226,10,55,36},62),
LoadingTitle = _d({14,49,35,38,43,48,41,226,3,55,54,49,239,5,46,43,37,45,39,52,240,240,240},62),
LoadingSubtitle = _d({17,50,54,43,47,43,60,39,38,226,24,39,52,53,43,49,48},62),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({18,46,35,59,39,52,9,55,43},62))
local gui = parentGui:FindFirstChild(_d({20,35,59,40,43,39,46,38},62)) or LocalPlayer:WaitForChild(_d({18,46,35,59,39,52,9,55,43},62)):FindFirstChild(_d({20,35,59,40,43,39,46,38},62))
if gui and gui:FindFirstChild(_d({15,35,43,48},62)) then
local scale = Instance.new(_d({23,11,21,37,35,46,39},62))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({5,49,48,54,52,49,46,53},62), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({3,55,54,49,239,8,43,52,39,226,15,49,55,53,39,5,46,43,37,45,39,38},62),
CurrentValue = false,
Flag = _d({3,55,54,49,8,43,52,39},62),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({15,49,55,53,39,5,46,43,37,45,39,38},62))
if remote and remote:IsA(_d({20,39,47,49,54,39,7,56,39,48,54},62)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({5,46,43,37,45,226,6,39,46,35,59},62),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({6,39,46,35,59,21,46,43,38,39,52},62),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({6,39,53,54,52,49,59,226,21,37,52,43,50,54},62),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()