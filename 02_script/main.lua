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
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local CoreGui = game:GetService(_d({31,75,78,65,35,81,69},36))
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,47,69,78,69,81,79,47,75,66,80,83,61,78,65,40,80,64,11,46,61,85,66,69,65,72,64,11,73,61,69,74,11,79,75,81,78,63,65,10,72,81,61},36),
_d({68,80,80,76,79,22,11,11,79,69,78,69,81,79,10,73,65,74,81,11,78,61,85,66,69,65,72,64},36),
_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,79,68,72,65,84,83,61,78,65,11,46,61,85,66,69,65,72,64,11,73,61,69,74,11,79,75,81,78,63,65},36)
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
error(_d({55,31,75,73,76,61,63,80,252,36,81,62,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,252,46,61,85,66,69,65,72,64,252,49,37,252,40,69,62,78,61,78,85,10},36))
end
local Window = Rayfield:CreateWindow({
Name = _d({31,75,73,76,61,63,80,252,36,81,62},36),
LoadingTitle = _d({40,75,61,64,69,74,67,252,29,81,80,75,9,31,72,69,63,71,65,78,10,10,10},36),
LoadingSubtitle = _d({43,76,80,69,73,69,86,65,64,252,50,65,78,79,69,75,74},36),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36))
local gui = parentGui:FindFirstChild(_d({46,61,85,66,69,65,72,64},36)) or LocalPlayer:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36)):FindFirstChild(_d({46,61,85,66,69,65,72,64},36))
if gui and gui:FindFirstChild(_d({41,61,69,74},36)) then
local scale = Instance.new(_d({49,37,47,63,61,72,65},36))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({31,75,74,80,78,75,72,79},36), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({29,81,80,75,9,34,69,78,65,252,41,75,81,79,65,31,72,69,63,71,65,64},36),
CurrentValue = false,
Flag = _d({29,81,80,75,34,69,78,65},36),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({41,75,81,79,65,31,72,69,63,71,65,64},36))
if remote and remote:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({31,72,69,63,71,252,32,65,72,61,85},36),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({32,65,72,61,85,47,72,69,64,65,78},36),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({32,65,79,80,78,75,85,252,47,63,78,69,76,80},36),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()