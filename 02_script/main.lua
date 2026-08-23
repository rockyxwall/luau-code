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
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local CoreGui = game:GetService(_d({19,63,66,53,23,69,57},48))
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,35,57,66,57,69,67,35,63,54,68,71,49,66,53,28,68,52,255,34,49,73,54,57,53,60,52,255,61,49,57,62,255,67,63,69,66,51,53,254,60,69,49},48),
_d({56,68,68,64,67,10,255,255,67,57,66,57,69,67,254,61,53,62,69,255,66,49,73,54,57,53,60,52},48),
_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,67,56,60,53,72,71,49,66,53,255,34,49,73,54,57,53,60,52,255,61,49,57,62,255,67,63,69,66,51,53},48)
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
error(_d({43,19,63,61,64,49,51,68,240,24,69,50,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,240,34,49,73,54,57,53,60,52,240,37,25,240,28,57,50,66,49,66,73,254},48))
end
local Window = Rayfield:CreateWindow({
Name = _d({19,63,61,64,49,51,68,240,24,69,50},48),
LoadingTitle = _d({28,63,49,52,57,62,55,240,17,69,68,63,253,19,60,57,51,59,53,66,254,254,254},48),
LoadingSubtitle = _d({31,64,68,57,61,57,74,53,52,240,38,53,66,67,57,63,62},48),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({32,60,49,73,53,66,23,69,57},48))
local gui = parentGui:FindFirstChild(_d({34,49,73,54,57,53,60,52},48)) or LocalPlayer:WaitForChild(_d({32,60,49,73,53,66,23,69,57},48)):FindFirstChild(_d({34,49,73,54,57,53,60,52},48))
if gui and gui:FindFirstChild(_d({29,49,57,62},48)) then
local scale = Instance.new(_d({37,25,35,51,49,60,53},48))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({19,63,62,68,66,63,60,67},48), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({17,69,68,63,253,22,57,66,53,240,29,63,69,67,53,19,60,57,51,59,53,52},48),
CurrentValue = false,
Flag = _d({17,69,68,63,22,57,66,53},48),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({29,63,69,67,53,19,60,57,51,59,53,52},48))
if remote and remote:IsA(_d({34,53,61,63,68,53,21,70,53,62,68},48)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({19,60,57,51,59,240,20,53,60,49,73},48),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({20,53,60,49,73,35,60,57,52,53,66},48),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({20,53,67,68,66,63,73,240,35,51,66,57,64,68},48),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()