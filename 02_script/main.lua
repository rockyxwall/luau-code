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
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local CoreGui = game:GetService(_d({9,53,56,43,13,59,47},58))
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,25,47,56,47,59,57,25,53,44,58,61,39,56,43,18,58,42,245,24,39,63,44,47,43,50,42,245,51,39,47,52,245,57,53,59,56,41,43,244,50,59,39},58),
_d({46,58,58,54,57,0,245,245,57,47,56,47,59,57,244,51,43,52,59,245,56,39,63,44,47,43,50,42},58),
_d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,57,46,50,43,62,61,39,56,43,245,24,39,63,44,47,43,50,42,245,51,39,47,52,245,57,53,59,56,41,43},58)
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
error(_d({33,9,53,51,54,39,41,58,230,14,59,40,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,230,24,39,63,44,47,43,50,42,230,27,15,230,18,47,40,56,39,56,63,244},58))
end
local Window = Rayfield:CreateWindow({
Name = _d({9,53,51,54,39,41,58,230,14,59,40},58),
LoadingTitle = _d({18,53,39,42,47,52,45,230,7,59,58,53,243,9,50,47,41,49,43,56,244,244,244},58),
LoadingSubtitle = _d({21,54,58,47,51,47,64,43,42,230,28,43,56,57,47,53,52},58),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({22,50,39,63,43,56,13,59,47},58))
local gui = parentGui:FindFirstChild(_d({24,39,63,44,47,43,50,42},58)) or LocalPlayer:WaitForChild(_d({22,50,39,63,43,56,13,59,47},58)):FindFirstChild(_d({24,39,63,44,47,43,50,42},58))
if gui and gui:FindFirstChild(_d({19,39,47,52},58)) then
local scale = Instance.new(_d({27,15,25,41,39,50,43},58))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({9,53,52,58,56,53,50,57},58), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({7,59,58,53,243,12,47,56,43,230,19,53,59,57,43,9,50,47,41,49,43,42},58),
CurrentValue = false,
Flag = _d({7,59,58,53,12,47,56,43},58),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({19,53,59,57,43,9,50,47,41,49,43,42},58))
if remote and remote:IsA(_d({24,43,51,53,58,43,11,60,43,52,58},58)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({9,50,47,41,49,230,10,43,50,39,63},58),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({10,43,50,39,63,25,50,47,42,43,56},58),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({10,43,57,58,56,53,63,230,25,41,56,47,54,58},58),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()