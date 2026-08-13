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
local ReplicatedStorage = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local CoreGui = game:GetService(_d({4,48,51,38,8,54,42},63))
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,20,42,51,42,54,52,20,48,39,53,56,34,51,38,13,53,37,240,19,34,58,39,42,38,45,37,240,46,34,42,47,240,52,48,54,51,36,38,239,45,54,34},63),
_d({41,53,53,49,52,251,240,240,52,42,51,42,54,52,239,46,38,47,54,240,51,34,58,39,42,38,45,37},63),
_d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,52,41,45,38,57,56,34,51,38,240,19,34,58,39,42,38,45,37,240,46,34,42,47,240,52,48,54,51,36,38},63)
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
error(_d({28,4,48,46,49,34,36,53,225,9,54,35,30,225,7,34,42,45,38,37,225,53,48,225,45,48,34,37,225,19,34,58,39,42,38,45,37,225,22,10,225,13,42,35,51,34,51,58,239},63))
end
local Window = Rayfield:CreateWindow({
Name = _d({4,48,46,49,34,36,53,225,9,54,35},63),
LoadingTitle = _d({13,48,34,37,42,47,40,225,2,54,53,48,238,4,45,42,36,44,38,51,239,239,239},63),
LoadingSubtitle = _d({16,49,53,42,46,42,59,38,37,225,23,38,51,52,42,48,47},63),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({17,45,34,58,38,51,8,54,42},63))
local gui = parentGui:FindFirstChild(_d({19,34,58,39,42,38,45,37},63)) or LocalPlayer:WaitForChild(_d({17,45,34,58,38,51,8,54,42},63)):FindFirstChild(_d({19,34,58,39,42,38,45,37},63))
if gui and gui:FindFirstChild(_d({14,34,42,47},63)) then
local scale = Instance.new(_d({22,10,20,36,34,45,38},63))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({4,48,47,53,51,48,45,52},63), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({2,54,53,48,238,7,42,51,38,225,14,48,54,52,38,4,45,42,36,44,38,37},63),
CurrentValue = false,
Flag = _d({2,54,53,48,7,42,51,38},63),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({14,48,54,52,38,4,45,42,36,44,38,37},63))
if remote and remote:IsA(_d({19,38,46,48,53,38,6,55,38,47,53},63)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({4,45,42,36,44,225,5,38,45,34,58},63),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({5,38,45,34,58,20,45,42,37,38,51},63),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({5,38,52,53,51,48,58,225,20,36,51,42,49,53},63),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()