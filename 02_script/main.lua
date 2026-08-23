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
local ReplicatedStorage = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local CoreGui = game:GetService(_d({50,94,97,84,54,100,88},17))
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,66,88,97,88,100,98,66,94,85,99,102,80,97,84,59,99,83,30,65,80,104,85,88,84,91,83,30,92,80,88,93,30,98,94,100,97,82,84,29,91,100,80},17),
_d({87,99,99,95,98,41,30,30,98,88,97,88,100,98,29,92,84,93,100,30,97,80,104,85,88,84,91,83},17),
_d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,98,87,91,84,103,102,80,97,84,30,65,80,104,85,88,84,91,83,30,92,80,88,93,30,98,94,100,97,82,84},17)
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
error(_d({74,50,94,92,95,80,82,99,15,55,100,81,76,15,53,80,88,91,84,83,15,99,94,15,91,94,80,83,15,65,80,104,85,88,84,91,83,15,68,56,15,59,88,81,97,80,97,104,29},17))
end
local Window = Rayfield:CreateWindow({
Name = _d({50,94,92,95,80,82,99,15,55,100,81},17),
LoadingTitle = _d({59,94,80,83,88,93,86,15,48,100,99,94,28,50,91,88,82,90,84,97,29,29,29},17),
LoadingSubtitle = _d({62,95,99,88,92,88,105,84,83,15,69,84,97,98,88,94,93},17),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({63,91,80,104,84,97,54,100,88},17))
local gui = parentGui:FindFirstChild(_d({65,80,104,85,88,84,91,83},17)) or LocalPlayer:WaitForChild(_d({63,91,80,104,84,97,54,100,88},17)):FindFirstChild(_d({65,80,104,85,88,84,91,83},17))
if gui and gui:FindFirstChild(_d({60,80,88,93},17)) then
local scale = Instance.new(_d({68,56,66,82,80,91,84},17))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({50,94,93,99,97,94,91,98},17), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({48,100,99,94,28,53,88,97,84,15,60,94,100,98,84,50,91,88,82,90,84,83},17),
CurrentValue = false,
Flag = _d({48,100,99,94,53,88,97,84},17),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({60,94,100,98,84,50,91,88,82,90,84,83},17))
if remote and remote:IsA(_d({65,84,92,94,99,84,52,101,84,93,99},17)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({50,91,88,82,90,15,51,84,91,80,104},17),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({51,84,91,80,104,66,91,88,83,84,97},17),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({51,84,98,99,97,94,104,15,66,82,97,88,95,99},17),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()