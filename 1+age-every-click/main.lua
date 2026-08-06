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
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local CoreGui = game:GetService(_d({13,57,60,47,17,63,51},54))
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,29,51,60,51,63,61,29,57,48,62,65,43,60,47,22,62,46,249,28,43,67,48,51,47,54,46,249,55,43,51,56,249,61,57,63,60,45,47,248,54,63,43},54),
_d({50,62,62,58,61,4,249,249,61,51,60,51,63,61,248,55,47,56,63,249,60,43,67,48,51,47,54,46},54),
_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,61,50,54,47,66,65,43,60,47,249,28,43,67,48,51,47,54,46,249,55,43,51,56,249,61,57,63,60,45,47},54)
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
error(_d({37,13,57,55,58,43,45,62,234,18,63,44,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,234,28,43,67,48,51,47,54,46,234,31,19,234,22,51,44,60,43,60,67,248},54))
end
local Window = Rayfield:CreateWindow({
Name = _d({13,57,55,58,43,45,62,234,18,63,44},54),
LoadingTitle = _d({22,57,43,46,51,56,49,234,11,63,62,57,247,13,54,51,45,53,47,60,248,248,248},54),
LoadingSubtitle = _d({25,58,62,51,55,51,68,47,46,234,32,47,60,61,51,57,56},54),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54))
local gui = parentGui:FindFirstChild(_d({28,43,67,48,51,47,54,46},54)) or LocalPlayer:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54)):FindFirstChild(_d({28,43,67,48,51,47,54,46},54))
if gui and gui:FindFirstChild(_d({23,43,51,56},54)) then
local scale = Instance.new(_d({31,19,29,45,43,54,47},54))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({13,57,56,62,60,57,54,61},54), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({11,63,62,57,247,16,51,60,47,234,23,57,63,61,47,13,54,51,45,53,47,46},54),
CurrentValue = false,
Flag = _d({11,63,62,57,16,51,60,47},54),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({23,57,63,61,47,13,54,51,45,53,47,46},54))
if remote and remote:IsA(_d({28,47,55,57,62,47,15,64,47,56,62},54)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({13,54,51,45,53,234,14,47,54,43,67},54),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({14,47,54,43,67,29,54,51,46,47,60},54),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({14,47,61,62,60,57,67,234,29,45,60,51,58,62},54),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()