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
local ReplicatedStorage = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local CoreGui = game:GetService(_d({28,72,75,62,32,78,66},39))
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,44,66,75,66,78,76,44,72,63,77,80,58,75,62,37,77,61,8,43,58,82,63,66,62,69,61,8,70,58,66,71,8,76,72,78,75,60,62,7,69,78,58},39),
_d({65,77,77,73,76,19,8,8,76,66,75,66,78,76,7,70,62,71,78,8,75,58,82,63,66,62,69,61},39),
_d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,76,65,69,62,81,80,58,75,62,8,43,58,82,63,66,62,69,61,8,70,58,66,71,8,76,72,78,75,60,62},39)
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
error(_d({52,28,72,70,73,58,60,77,249,33,78,59,54,249,31,58,66,69,62,61,249,77,72,249,69,72,58,61,249,43,58,82,63,66,62,69,61,249,46,34,249,37,66,59,75,58,75,82,7},39))
end
local Window = Rayfield:CreateWindow({
Name = _d({28,72,70,73,58,60,77,249,33,78,59},39),
LoadingTitle = _d({37,72,58,61,66,71,64,249,26,78,77,72,6,28,69,66,60,68,62,75,7,7,7},39),
LoadingSubtitle = _d({40,73,77,66,70,66,83,62,61,249,47,62,75,76,66,72,71},39),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({41,69,58,82,62,75,32,78,66},39))
local gui = parentGui:FindFirstChild(_d({43,58,82,63,66,62,69,61},39)) or LocalPlayer:WaitForChild(_d({41,69,58,82,62,75,32,78,66},39)):FindFirstChild(_d({43,58,82,63,66,62,69,61},39))
if gui and gui:FindFirstChild(_d({38,58,66,71},39)) then
local scale = Instance.new(_d({46,34,44,60,58,69,62},39))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({28,72,71,77,75,72,69,76},39), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({26,78,77,72,6,31,66,75,62,249,38,72,78,76,62,28,69,66,60,68,62,61},39),
CurrentValue = false,
Flag = _d({26,78,77,72,31,66,75,62},39),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({38,72,78,76,62,28,69,66,60,68,62,61},39))
if remote and remote:IsA(_d({43,62,70,72,77,62,30,79,62,71,77},39)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({28,69,66,60,68,249,29,62,69,58,82},39),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({29,62,69,58,82,44,69,66,61,62,75},39),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({29,62,76,77,75,72,82,249,44,60,75,66,73,77},39),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()