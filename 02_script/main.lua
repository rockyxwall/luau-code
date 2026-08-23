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
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local CoreGui = game:GetService(_d({35,79,82,69,39,85,73},32))
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,51,73,82,73,85,83,51,79,70,84,87,65,82,69,44,84,68,15,50,65,89,70,73,69,76,68,15,77,65,73,78,15,83,79,85,82,67,69,14,76,85,65},32),
_d({72,84,84,80,83,26,15,15,83,73,82,73,85,83,14,77,69,78,85,15,82,65,89,70,73,69,76,68},32),
_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,83,72,76,69,88,87,65,82,69,15,50,65,89,70,73,69,76,68,15,77,65,73,78,15,83,79,85,82,67,69},32)
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
error(_d({59,35,79,77,80,65,67,84,0,40,85,66,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,0,50,65,89,70,73,69,76,68,0,53,41,0,44,73,66,82,65,82,89,14},32))
end
local Window = Rayfield:CreateWindow({
Name = _d({35,79,77,80,65,67,84,0,40,85,66},32),
LoadingTitle = _d({44,79,65,68,73,78,71,0,33,85,84,79,13,35,76,73,67,75,69,82,14,14,14},32),
LoadingSubtitle = _d({47,80,84,73,77,73,90,69,68,0,54,69,82,83,73,79,78},32),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32))
local gui = parentGui:FindFirstChild(_d({50,65,89,70,73,69,76,68},32)) or LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32)):FindFirstChild(_d({50,65,89,70,73,69,76,68},32))
if gui and gui:FindFirstChild(_d({45,65,73,78},32)) then
local scale = Instance.new(_d({53,41,51,67,65,76,69},32))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({35,79,78,84,82,79,76,83},32), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({33,85,84,79,13,38,73,82,69,0,45,79,85,83,69,35,76,73,67,75,69,68},32),
CurrentValue = false,
Flag = _d({33,85,84,79,38,73,82,69},32),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({45,79,85,83,69,35,76,73,67,75,69,68},32))
if remote and remote:IsA(_d({50,69,77,79,84,69,37,86,69,78,84},32)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({35,76,73,67,75,0,36,69,76,65,89},32),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({36,69,76,65,89,51,76,73,68,69,82},32),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({36,69,83,84,82,79,89,0,51,67,82,73,80,84},32),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()