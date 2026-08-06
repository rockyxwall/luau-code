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
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local CoreGui = game:GetService(_d({17,61,64,51,21,67,55},50))
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,33,55,64,55,67,65,33,61,52,66,69,47,64,51,26,66,50,253,32,47,71,52,55,51,58,50,253,59,47,55,60,253,65,61,67,64,49,51,252,58,67,47},50),
_d({54,66,66,62,65,8,253,253,65,55,64,55,67,65,252,59,51,60,67,253,64,47,71,52,55,51,58,50},50),
_d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,65,54,58,51,70,69,47,64,51,253,32,47,71,52,55,51,58,50,253,59,47,55,60,253,65,61,67,64,49,51},50)
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
error(_d({41,17,61,59,62,47,49,66,238,22,67,48,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,238,32,47,71,52,55,51,58,50,238,35,23,238,26,55,48,64,47,64,71,252},50))
end
local Window = Rayfield:CreateWindow({
Name = _d({17,61,59,62,47,49,66,238,22,67,48},50),
LoadingTitle = _d({26,61,47,50,55,60,53,238,15,67,66,61,251,17,58,55,49,57,51,64,252,252,252},50),
LoadingSubtitle = _d({29,62,66,55,59,55,72,51,50,238,36,51,64,65,55,61,60},50),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({30,58,47,71,51,64,21,67,55},50))
local gui = parentGui:FindFirstChild(_d({32,47,71,52,55,51,58,50},50)) or LocalPlayer:WaitForChild(_d({30,58,47,71,51,64,21,67,55},50)):FindFirstChild(_d({32,47,71,52,55,51,58,50},50))
if gui and gui:FindFirstChild(_d({27,47,55,60},50)) then
local scale = Instance.new(_d({35,23,33,49,47,58,51},50))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({17,61,60,66,64,61,58,65},50), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({15,67,66,61,251,20,55,64,51,238,27,61,67,65,51,17,58,55,49,57,51,50},50),
CurrentValue = false,
Flag = _d({15,67,66,61,20,55,64,51},50),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({27,61,67,65,51,17,58,55,49,57,51,50},50))
if remote and remote:IsA(_d({32,51,59,61,66,51,19,68,51,60,66},50)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({17,58,55,49,57,238,18,51,58,47,71},50),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({18,51,58,47,71,33,58,55,50,51,64},50),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({18,51,65,66,64,61,71,238,33,49,64,55,62,66},50),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()