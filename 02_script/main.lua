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
local ReplicatedStorage = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local CoreGui = game:GetService(_d({34,78,81,68,38,84,72},33))
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,50,72,81,72,84,82,50,78,69,83,86,64,81,68,43,83,67,14,49,64,88,69,72,68,75,67,14,76,64,72,77,14,82,78,84,81,66,68,13,75,84,64},33),
_d({71,83,83,79,82,25,14,14,82,72,81,72,84,82,13,76,68,77,84,14,81,64,88,69,72,68,75,67},33),
_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,82,71,75,68,87,86,64,81,68,14,49,64,88,69,72,68,75,67,14,76,64,72,77,14,82,78,84,81,66,68},33)
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
error(_d({58,34,78,76,79,64,66,83,255,39,84,65,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,255,49,64,88,69,72,68,75,67,255,52,40,255,43,72,65,81,64,81,88,13},33))
end
local Window = Rayfield:CreateWindow({
Name = _d({34,78,76,79,64,66,83,255,39,84,65},33),
LoadingTitle = _d({43,78,64,67,72,77,70,255,32,84,83,78,12,34,75,72,66,74,68,81,13,13,13},33),
LoadingSubtitle = _d({46,79,83,72,76,72,89,68,67,255,53,68,81,82,72,78,77},33),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({47,75,64,88,68,81,38,84,72},33))
local gui = parentGui:FindFirstChild(_d({49,64,88,69,72,68,75,67},33)) or LocalPlayer:WaitForChild(_d({47,75,64,88,68,81,38,84,72},33)):FindFirstChild(_d({49,64,88,69,72,68,75,67},33))
if gui and gui:FindFirstChild(_d({44,64,72,77},33)) then
local scale = Instance.new(_d({52,40,50,66,64,75,68},33))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({34,78,77,83,81,78,75,82},33), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({32,84,83,78,12,37,72,81,68,255,44,78,84,82,68,34,75,72,66,74,68,67},33),
CurrentValue = false,
Flag = _d({32,84,83,78,37,72,81,68},33),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({44,78,84,82,68,34,75,72,66,74,68,67},33))
if remote and remote:IsA(_d({49,68,76,78,83,68,36,85,68,77,83},33)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({34,75,72,66,74,255,35,68,75,64,88},33),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({35,68,75,64,88,50,75,72,67,68,81},33),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({35,68,82,83,81,78,88,255,50,66,81,72,79,83},33),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()