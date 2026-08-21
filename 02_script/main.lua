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
local ReplicatedStorage = game:GetService(_d({33,52,63,59,56,50,48,67,52,51,34,67,62,65,48,54,52},49))
local CoreGui = game:GetService(_d({18,62,65,52,22,68,56},49))
local Players = game:GetService(_d({31,59,48,72,52,65,66},49))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,34,56,65,56,68,66,34,62,53,67,70,48,65,52,27,67,51,254,33,48,72,53,56,52,59,51,254,60,48,56,61,254,66,62,68,65,50,52,253,59,68,48},49),
_d({55,67,67,63,66,9,254,254,66,56,65,56,68,66,253,60,52,61,68,254,65,48,72,53,56,52,59,51},49),
_d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,66,55,59,52,71,70,48,65,52,254,33,48,72,53,56,52,59,51,254,60,48,56,61,254,66,62,68,65,50,52},49)
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
error(_d({42,18,62,60,63,48,50,67,239,23,68,49,44,239,21,48,56,59,52,51,239,67,62,239,59,62,48,51,239,33,48,72,53,56,52,59,51,239,36,24,239,27,56,49,65,48,65,72,253},49))
end
local Window = Rayfield:CreateWindow({
Name = _d({18,62,60,63,48,50,67,239,23,68,49},49),
LoadingTitle = _d({27,62,48,51,56,61,54,239,16,68,67,62,252,18,59,56,50,58,52,65,253,253,253},49),
LoadingSubtitle = _d({30,63,67,56,60,56,73,52,51,239,37,52,65,66,56,62,61},49),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({31,59,48,72,52,65,22,68,56},49))
local gui = parentGui:FindFirstChild(_d({33,48,72,53,56,52,59,51},49)) or LocalPlayer:WaitForChild(_d({31,59,48,72,52,65,22,68,56},49)):FindFirstChild(_d({33,48,72,53,56,52,59,51},49))
if gui and gui:FindFirstChild(_d({28,48,56,61},49)) then
local scale = Instance.new(_d({36,24,34,50,48,59,52},49))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({18,62,61,67,65,62,59,66},49), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({16,68,67,62,252,21,56,65,52,239,28,62,68,66,52,18,59,56,50,58,52,51},49),
CurrentValue = false,
Flag = _d({16,68,67,62,21,56,65,52},49),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({28,62,68,66,52,18,59,56,50,58,52,51},49))
if remote and remote:IsA(_d({33,52,60,62,67,52,20,69,52,61,67},49)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({18,59,56,50,58,239,19,52,59,48,72},49),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({19,52,59,48,72,34,59,56,51,52,65},49),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({19,52,66,67,65,62,72,239,34,50,65,56,63,67},49),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()