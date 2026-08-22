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
local ReplicatedStorage = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local CoreGui = game:GetService(_d({27,71,74,61,31,77,65},40))
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,43,65,74,65,77,75,43,71,62,76,79,57,74,61,36,76,60,7,42,57,81,62,65,61,68,60,7,69,57,65,70,7,75,71,77,74,59,61,6,68,77,57},40),
_d({64,76,76,72,75,18,7,7,75,65,74,65,77,75,6,69,61,70,77,7,74,57,81,62,65,61,68,60},40),
_d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,75,64,68,61,80,79,57,74,61,7,42,57,81,62,65,61,68,60,7,69,57,65,70,7,75,71,77,74,59,61},40)
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
error(_d({51,27,71,69,72,57,59,76,248,32,77,58,53,248,30,57,65,68,61,60,248,76,71,248,68,71,57,60,248,42,57,81,62,65,61,68,60,248,45,33,248,36,65,58,74,57,74,81,6},40))
end
local Window = Rayfield:CreateWindow({
Name = _d({27,71,69,72,57,59,76,248,32,77,58},40),
LoadingTitle = _d({36,71,57,60,65,70,63,248,25,77,76,71,5,27,68,65,59,67,61,74,6,6,6},40),
LoadingSubtitle = _d({39,72,76,65,69,65,82,61,60,248,46,61,74,75,65,71,70},40),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({40,68,57,81,61,74,31,77,65},40))
local gui = parentGui:FindFirstChild(_d({42,57,81,62,65,61,68,60},40)) or LocalPlayer:WaitForChild(_d({40,68,57,81,61,74,31,77,65},40)):FindFirstChild(_d({42,57,81,62,65,61,68,60},40))
if gui and gui:FindFirstChild(_d({37,57,65,70},40)) then
local scale = Instance.new(_d({45,33,43,59,57,68,61},40))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({27,71,70,76,74,71,68,75},40), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({25,77,76,71,5,30,65,74,61,248,37,71,77,75,61,27,68,65,59,67,61,60},40),
CurrentValue = false,
Flag = _d({25,77,76,71,30,65,74,61},40),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({37,71,77,75,61,27,68,65,59,67,61,60},40))
if remote and remote:IsA(_d({42,61,69,71,76,61,29,78,61,70,76},40)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({27,68,65,59,67,248,28,61,68,57,81},40),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({28,61,68,57,81,43,68,65,60,61,74},40),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({28,61,75,76,74,71,81,248,43,59,74,65,72,76},40),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()