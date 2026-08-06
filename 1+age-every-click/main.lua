(function()
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(b[i] + k)
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local CoreGui = game:GetService(_d({51,95,98,85,55,101,89},16))
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,67,89,98,89,101,99,67,95,86,100,103,81,98,85,60,100,84,31,66,81,105,86,89,85,92,84,31,93,81,89,94,31,99,95,101,98,83,85,30,92,101,81},16),
_d({88,100,100,96,99,42,31,31,99,89,98,89,101,99,30,93,85,94,101,31,98,81,105,86,89,85,92,84},16),
_d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,99,88,92,85,104,103,81,98,85,31,66,81,105,86,89,85,92,84,31,93,81,89,94,31,99,95,101,98,83,85},16)
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
error(_d({75,51,95,93,96,81,83,100,16,56,101,82,77,16,54,81,89,92,85,84,16,100,95,16,92,95,81,84,16,66,81,105,86,89,85,92,84,16,69,57,16,60,89,82,98,81,98,105,30},16))
end
local Window = Rayfield:CreateWindow({
Name = _d({51,95,93,96,81,83,100,16,56,101,82},16),
LoadingTitle = _d({60,95,81,84,89,94,87,16,49,101,100,95,29,51,92,89,83,91,85,98,30,30,30},16),
LoadingSubtitle = _d({63,96,100,89,93,89,106,85,84,16,70,85,98,99,89,95,94},16),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({64,92,81,105,85,98,55,101,89},16))
local gui = parentGui:FindFirstChild(_d({66,81,105,86,89,85,92,84},16)) or LocalPlayer:WaitForChild(_d({64,92,81,105,85,98,55,101,89},16)):FindFirstChild(_d({66,81,105,86,89,85,92,84},16))
if gui and gui:FindFirstChild(_d({61,81,89,94},16)) then
local scale = Instance.new(_d({69,57,67,83,81,92,85},16))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({51,95,94,100,98,95,92,99},16), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({49,101,100,95,29,54,89,98,85,16,61,95,101,99,85,51,92,89,83,91,85,84},16),
CurrentValue = false,
Flag = _d({49,101,100,95,54,89,98,85},16),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({61,95,101,99,85,51,92,89,83,91,85,84},16))
if remote and remote:IsA(_d({66,85,93,95,100,85,53,102,85,94,100},16)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({51,92,89,83,91,16,52,85,92,81,105},16),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({52,85,92,81,105,67,92,89,84,85,98},16),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({52,85,99,100,98,95,105,16,67,83,98,89,96,100},16),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()