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
local ReplicatedStorage = game:GetService(_d({53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72},29))
local CoreGui = game:GetService(_d({38,82,85,72,42,88,76},29))
local Players = game:GetService(_d({51,79,68,92,72,85,86},29))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,54,76,85,76,88,86,54,82,73,87,90,68,85,72,47,87,71,18,53,68,92,73,76,72,79,71,18,80,68,76,81,18,86,82,88,85,70,72,17,79,88,68},29),
_d({75,87,87,83,86,29,18,18,86,76,85,76,88,86,17,80,72,81,88,18,85,68,92,73,76,72,79,71},29),
_d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,86,75,79,72,91,90,68,85,72,18,53,68,92,73,76,72,79,71,18,80,68,76,81,18,86,82,88,85,70,72},29)
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
error(_d({62,38,82,80,83,68,70,87,3,43,88,69,64,3,41,68,76,79,72,71,3,87,82,3,79,82,68,71,3,53,68,92,73,76,72,79,71,3,56,44,3,47,76,69,85,68,85,92,17},29))
end
local Window = Rayfield:CreateWindow({
Name = _d({38,82,80,83,68,70,87,3,43,88,69},29),
LoadingTitle = _d({47,82,68,71,76,81,74,3,36,88,87,82,16,38,79,76,70,78,72,85,17,17,17},29),
LoadingSubtitle = _d({50,83,87,76,80,76,93,72,71,3,57,72,85,86,76,82,81},29),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({51,79,68,92,72,85,42,88,76},29))
local gui = parentGui:FindFirstChild(_d({53,68,92,73,76,72,79,71},29)) or LocalPlayer:WaitForChild(_d({51,79,68,92,72,85,42,88,76},29)):FindFirstChild(_d({53,68,92,73,76,72,79,71},29))
if gui and gui:FindFirstChild(_d({48,68,76,81},29)) then
local scale = Instance.new(_d({56,44,54,70,68,79,72},29))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({38,82,81,87,85,82,79,86},29), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({36,88,87,82,16,41,76,85,72,3,48,82,88,86,72,38,79,76,70,78,72,71},29),
CurrentValue = false,
Flag = _d({36,88,87,82,41,76,85,72},29),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({48,82,88,86,72,38,79,76,70,78,72,71},29))
if remote and remote:IsA(_d({53,72,80,82,87,72,40,89,72,81,87},29)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({38,79,76,70,78,3,39,72,79,68,92},29),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({39,72,79,68,92,54,79,76,71,72,85},29),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({39,72,86,87,85,82,92,3,54,70,85,76,83,87},29),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()