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
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local CoreGui = game:GetService(_d({40,84,87,74,44,90,78},27))
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,56,78,87,78,90,88,56,84,75,89,92,70,87,74,49,89,73,20,55,70,94,75,78,74,81,73,20,82,70,78,83,20,88,84,90,87,72,74,19,81,90,70},27),
_d({77,89,89,85,88,31,20,20,88,78,87,78,90,88,19,82,74,83,90,20,87,70,94,75,78,74,81,73},27),
_d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,88,77,81,74,93,92,70,87,74,20,55,70,94,75,78,74,81,73,20,82,70,78,83,20,88,84,90,87,72,74},27)
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
error(_d({64,40,84,82,85,70,72,89,5,45,90,71,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,5,55,70,94,75,78,74,81,73,5,58,46,5,49,78,71,87,70,87,94,19},27))
end
local Window = Rayfield:CreateWindow({
Name = _d({40,84,82,85,70,72,89,5,45,90,71},27),
LoadingTitle = _d({49,84,70,73,78,83,76,5,38,90,89,84,18,40,81,78,72,80,74,87,19,19,19},27),
LoadingSubtitle = _d({52,85,89,78,82,78,95,74,73,5,59,74,87,88,78,84,83},27),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27))
local gui = parentGui:FindFirstChild(_d({55,70,94,75,78,74,81,73},27)) or LocalPlayer:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27)):FindFirstChild(_d({55,70,94,75,78,74,81,73},27))
if gui and gui:FindFirstChild(_d({50,70,78,83},27)) then
local scale = Instance.new(_d({58,46,56,72,70,81,74},27))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({40,84,83,89,87,84,81,88},27), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({38,90,89,84,18,43,78,87,74,5,50,84,90,88,74,40,81,78,72,80,74,73},27),
CurrentValue = false,
Flag = _d({38,90,89,84,43,78,87,74},27),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({50,84,90,88,74,40,81,78,72,80,74,73},27))
if remote and remote:IsA(_d({55,74,82,84,89,74,42,91,74,83,89},27)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({40,81,78,72,80,5,41,74,81,70,94},27),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({41,74,81,70,94,56,81,78,73,74,87},27),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({41,74,88,89,87,84,94,5,56,72,87,78,85,89},27),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()