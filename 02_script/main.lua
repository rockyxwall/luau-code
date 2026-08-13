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
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local CoreGui = game:GetService(_d({49,93,96,83,53,99,87},18))
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,65,87,96,87,99,97,65,93,84,98,101,79,96,83,58,98,82,29,64,79,103,84,87,83,90,82,29,91,79,87,92,29,97,93,99,96,81,83,28,90,99,79},18),
_d({86,98,98,94,97,40,29,29,97,87,96,87,99,97,28,91,83,92,99,29,96,79,103,84,87,83,90,82},18),
_d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,97,86,90,83,102,101,79,96,83,29,64,79,103,84,87,83,90,82,29,91,79,87,92,29,97,93,99,96,81,83},18)
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
error(_d({73,49,93,91,94,79,81,98,14,54,99,80,75,14,52,79,87,90,83,82,14,98,93,14,90,93,79,82,14,64,79,103,84,87,83,90,82,14,67,55,14,58,87,80,96,79,96,103,28},18))
end
local Window = Rayfield:CreateWindow({
Name = _d({49,93,91,94,79,81,98,14,54,99,80},18),
LoadingTitle = _d({58,93,79,82,87,92,85,14,47,99,98,93,27,49,90,87,81,89,83,96,28,28,28},18),
LoadingSubtitle = _d({61,94,98,87,91,87,104,83,82,14,68,83,96,97,87,93,92},18),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18))
local gui = parentGui:FindFirstChild(_d({64,79,103,84,87,83,90,82},18)) or LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18)):FindFirstChild(_d({64,79,103,84,87,83,90,82},18))
if gui and gui:FindFirstChild(_d({59,79,87,92},18)) then
local scale = Instance.new(_d({67,55,65,81,79,90,83},18))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({49,93,92,98,96,93,90,97},18), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({47,99,98,93,27,52,87,96,83,14,59,93,99,97,83,49,90,87,81,89,83,82},18),
CurrentValue = false,
Flag = _d({47,99,98,93,52,87,96,83},18),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({59,93,99,97,83,49,90,87,81,89,83,82},18))
if remote and remote:IsA(_d({64,83,91,93,98,83,51,100,83,92,98},18)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({49,90,87,81,89,14,50,83,90,79,103},18),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({50,83,90,79,103,65,90,87,82,83,96},18),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({50,83,97,98,96,93,103,14,65,81,96,87,94,98},18),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()