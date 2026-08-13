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
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local CoreGui = game:GetService(_d({3,47,50,37,7,53,41},64))
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,19,41,50,41,53,51,19,47,38,52,55,33,50,37,12,52,36,239,18,33,57,38,41,37,44,36,239,45,33,41,46,239,51,47,53,50,35,37,238,44,53,33},64),
_d({40,52,52,48,51,250,239,239,51,41,50,41,53,51,238,45,37,46,53,239,50,33,57,38,41,37,44,36},64),
_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,51,40,44,37,56,55,33,50,37,239,18,33,57,38,41,37,44,36,239,45,33,41,46,239,51,47,53,50,35,37},64)
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
error(_d({27,3,47,45,48,33,35,52,224,8,53,34,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,224,18,33,57,38,41,37,44,36,224,21,9,224,12,41,34,50,33,50,57,238},64))
end
local Window = Rayfield:CreateWindow({
Name = _d({3,47,45,48,33,35,52,224,8,53,34},64),
LoadingTitle = _d({12,47,33,36,41,46,39,224,1,53,52,47,237,3,44,41,35,43,37,50,238,238,238},64),
LoadingSubtitle = _d({15,48,52,41,45,41,58,37,36,224,22,37,50,51,41,47,46},64),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({16,44,33,57,37,50,7,53,41},64))
local gui = parentGui:FindFirstChild(_d({18,33,57,38,41,37,44,36},64)) or LocalPlayer:WaitForChild(_d({16,44,33,57,37,50,7,53,41},64)):FindFirstChild(_d({18,33,57,38,41,37,44,36},64))
if gui and gui:FindFirstChild(_d({13,33,41,46},64)) then
local scale = Instance.new(_d({21,9,19,35,33,44,37},64))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({3,47,46,52,50,47,44,51},64), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({1,53,52,47,237,6,41,50,37,224,13,47,53,51,37,3,44,41,35,43,37,36},64),
CurrentValue = false,
Flag = _d({1,53,52,47,6,41,50,37},64),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({13,47,53,51,37,3,44,41,35,43,37,36},64))
if remote and remote:IsA(_d({18,37,45,47,52,37,5,54,37,46,52},64)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({3,44,41,35,43,224,4,37,44,33,57},64),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({4,37,44,33,57,19,44,41,36,37,50},64),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({4,37,51,52,50,47,57,224,19,35,50,41,48,52},64),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()