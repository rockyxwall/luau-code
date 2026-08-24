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
local ReplicatedStorage = game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38))
local CoreGui = game:GetService(_d({29,73,76,63,33,79,67},38))
local Players = game:GetService(_d({42,70,59,83,63,76,77},38))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,45,67,76,67,79,77,45,73,64,78,81,59,76,63,38,78,62,9,44,59,83,64,67,63,70,62,9,71,59,67,72,9,77,73,79,76,61,63,8,70,79,59},38),
_d({66,78,78,74,77,20,9,9,77,67,76,67,79,77,8,71,63,72,79,9,76,59,83,64,67,63,70,62},38),
_d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,77,66,70,63,82,81,59,76,63,9,44,59,83,64,67,63,70,62,9,71,59,67,72,9,77,73,79,76,61,63},38)
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
error(_d({53,29,73,71,74,59,61,78,250,34,79,60,55,250,32,59,67,70,63,62,250,78,73,250,70,73,59,62,250,44,59,83,64,67,63,70,62,250,47,35,250,38,67,60,76,59,76,83,8},38))
end
local Window = Rayfield:CreateWindow({
Name = _d({29,73,71,74,59,61,78,250,34,79,60},38),
LoadingTitle = _d({38,73,59,62,67,72,65,250,27,79,78,73,7,29,70,67,61,69,63,76,8,8,8},38),
LoadingSubtitle = _d({41,74,78,67,71,67,84,63,62,250,48,63,76,77,67,73,72},38),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({42,70,59,83,63,76,33,79,67},38))
local gui = parentGui:FindFirstChild(_d({44,59,83,64,67,63,70,62},38)) or LocalPlayer:WaitForChild(_d({42,70,59,83,63,76,33,79,67},38)):FindFirstChild(_d({44,59,83,64,67,63,70,62},38))
if gui and gui:FindFirstChild(_d({39,59,67,72},38)) then
local scale = Instance.new(_d({47,35,45,61,59,70,63},38))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({29,73,72,78,76,73,70,77},38), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({27,79,78,73,7,32,67,76,63,250,39,73,79,77,63,29,70,67,61,69,63,62},38),
CurrentValue = false,
Flag = _d({27,79,78,73,32,67,76,63},38),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({39,73,79,77,63,29,70,67,61,69,63,62},38))
if remote and remote:IsA(_d({44,63,71,73,78,63,31,80,63,72,78},38)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({29,70,67,61,69,250,30,63,70,59,83},38),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({30,63,70,59,83,45,70,67,62,63,76},38),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({30,63,77,78,76,73,83,250,45,61,76,67,74,78},38),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()