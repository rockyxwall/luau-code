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
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local CoreGui = game:GetService(_d({37,81,84,71,41,87,75},30))
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,53,75,84,75,87,85,53,81,72,86,89,67,84,71,46,86,70,17,52,67,91,72,75,71,78,70,17,79,67,75,80,17,85,81,87,84,69,71,16,78,87,67},30),
_d({74,86,86,82,85,28,17,17,85,75,84,75,87,85,16,79,71,80,87,17,84,67,91,72,75,71,78,70},30),
_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,85,74,78,71,90,89,67,84,71,17,52,67,91,72,75,71,78,70,17,79,67,75,80,17,85,81,87,84,69,71},30)
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
error(_d({61,37,81,79,82,67,69,86,2,42,87,68,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,2,52,67,91,72,75,71,78,70,2,55,43,2,46,75,68,84,67,84,91,16},30))
end
local Window = Rayfield:CreateWindow({
Name = _d({37,81,79,82,67,69,86,2,42,87,68},30),
LoadingTitle = _d({46,81,67,70,75,80,73,2,35,87,86,81,15,37,78,75,69,77,71,84,16,16,16},30),
LoadingSubtitle = _d({49,82,86,75,79,75,92,71,70,2,56,71,84,85,75,81,80},30),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({50,78,67,91,71,84,41,87,75},30))
local gui = parentGui:FindFirstChild(_d({52,67,91,72,75,71,78,70},30)) or LocalPlayer:WaitForChild(_d({50,78,67,91,71,84,41,87,75},30)):FindFirstChild(_d({52,67,91,72,75,71,78,70},30))
if gui and gui:FindFirstChild(_d({47,67,75,80},30)) then
local scale = Instance.new(_d({55,43,53,69,67,78,71},30))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({37,81,80,86,84,81,78,85},30), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({35,87,86,81,15,40,75,84,71,2,47,81,87,85,71,37,78,75,69,77,71,70},30),
CurrentValue = false,
Flag = _d({35,87,86,81,40,75,84,71},30),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({47,81,87,85,71,37,78,75,69,77,71,70},30))
if remote and remote:IsA(_d({52,71,79,81,86,71,39,88,71,80,86},30)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({37,78,75,69,77,2,38,71,78,67,91},30),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({38,71,78,67,91,53,78,75,70,71,84},30),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({38,71,85,86,84,81,91,2,53,69,84,75,82,86},30),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()