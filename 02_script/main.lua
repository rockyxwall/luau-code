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
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local CoreGui = game:GetService(_d({41,85,88,75,45,91,79},26))
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,57,79,88,79,91,89,57,85,76,90,93,71,88,75,50,90,74,21,56,71,95,76,79,75,82,74,21,83,71,79,84,21,89,85,91,88,73,75,20,82,91,71},26),
_d({78,90,90,86,89,32,21,21,89,79,88,79,91,89,20,83,75,84,91,21,88,71,95,76,79,75,82,74},26),
_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,89,78,82,75,94,93,71,88,75,21,56,71,95,76,79,75,82,74,21,83,71,79,84,21,89,85,91,88,73,75},26)
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
error(_d({65,41,85,83,86,71,73,90,6,46,91,72,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,6,56,71,95,76,79,75,82,74,6,59,47,6,50,79,72,88,71,88,95,20},26))
end
local Window = Rayfield:CreateWindow({
Name = _d({41,85,83,86,71,73,90,6,46,91,72},26),
LoadingTitle = _d({50,85,71,74,79,84,77,6,39,91,90,85,19,41,82,79,73,81,75,88,20,20,20},26),
LoadingSubtitle = _d({53,86,90,79,83,79,96,75,74,6,60,75,88,89,79,85,84},26),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26))
local gui = parentGui:FindFirstChild(_d({56,71,95,76,79,75,82,74},26)) or LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26)):FindFirstChild(_d({56,71,95,76,79,75,82,74},26))
if gui and gui:FindFirstChild(_d({51,71,79,84},26)) then
local scale = Instance.new(_d({59,47,57,73,71,82,75},26))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({41,85,84,90,88,85,82,89},26), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({39,91,90,85,19,44,79,88,75,6,51,85,91,89,75,41,82,79,73,81,75,74},26),
CurrentValue = false,
Flag = _d({39,91,90,85,44,79,88,75},26),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({51,85,91,89,75,41,82,79,73,81,75,74},26))
if remote and remote:IsA(_d({56,75,83,85,90,75,43,92,75,84,90},26)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({41,82,79,73,81,6,42,75,82,71,95},26),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({42,75,82,71,95,57,82,79,74,75,88},26),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({42,75,89,90,88,85,95,6,57,73,88,79,86,90},26),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()