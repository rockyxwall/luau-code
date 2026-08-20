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
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local CoreGui = game:GetService(_d({36,80,83,70,40,86,74},31))
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,52,74,83,74,86,84,52,80,71,85,88,66,83,70,45,85,69,16,51,66,90,71,74,70,77,69,16,78,66,74,79,16,84,80,86,83,68,70,15,77,86,66},31),
_d({73,85,85,81,84,27,16,16,84,74,83,74,86,84,15,78,70,79,86,16,83,66,90,71,74,70,77,69},31),
_d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,84,73,77,70,89,88,66,83,70,16,51,66,90,71,74,70,77,69,16,78,66,74,79,16,84,80,86,83,68,70},31)
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
error(_d({60,36,80,78,81,66,68,85,1,41,86,67,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,1,51,66,90,71,74,70,77,69,1,54,42,1,45,74,67,83,66,83,90,15},31))
end
local Window = Rayfield:CreateWindow({
Name = _d({36,80,78,81,66,68,85,1,41,86,67},31),
LoadingTitle = _d({45,80,66,69,74,79,72,1,34,86,85,80,14,36,77,74,68,76,70,83,15,15,15},31),
LoadingSubtitle = _d({48,81,85,74,78,74,91,70,69,1,55,70,83,84,74,80,79},31),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({49,77,66,90,70,83,40,86,74},31))
local gui = parentGui:FindFirstChild(_d({51,66,90,71,74,70,77,69},31)) or LocalPlayer:WaitForChild(_d({49,77,66,90,70,83,40,86,74},31)):FindFirstChild(_d({51,66,90,71,74,70,77,69},31))
if gui and gui:FindFirstChild(_d({46,66,74,79},31)) then
local scale = Instance.new(_d({54,42,52,68,66,77,70},31))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({36,80,79,85,83,80,77,84},31), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({34,86,85,80,14,39,74,83,70,1,46,80,86,84,70,36,77,74,68,76,70,69},31),
CurrentValue = false,
Flag = _d({34,86,85,80,39,74,83,70},31),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({46,80,86,84,70,36,77,74,68,76,70,69},31))
if remote and remote:IsA(_d({51,70,78,80,85,70,38,87,70,79,85},31)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({36,77,74,68,76,1,37,70,77,66,90},31),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({37,70,77,66,90,52,77,74,69,70,83},31),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({37,70,84,85,83,80,90,1,52,68,83,74,81,85},31),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()