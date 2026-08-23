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
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local CoreGui = game:GetService(_d({20,64,67,54,24,70,58},47))
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,36,58,67,58,70,68,36,64,55,69,72,50,67,54,29,69,53,0,35,50,74,55,58,54,61,53,0,62,50,58,63,0,68,64,70,67,52,54,255,61,70,50},47),
_d({57,69,69,65,68,11,0,0,68,58,67,58,70,68,255,62,54,63,70,0,67,50,74,55,58,54,61,53},47),
_d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,68,57,61,54,73,72,50,67,54,0,35,50,74,55,58,54,61,53,0,62,50,58,63,0,68,64,70,67,52,54},47)
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
error(_d({44,20,64,62,65,50,52,69,241,25,70,51,46,241,23,50,58,61,54,53,241,69,64,241,61,64,50,53,241,35,50,74,55,58,54,61,53,241,38,26,241,29,58,51,67,50,67,74,255},47))
end
local Window = Rayfield:CreateWindow({
Name = _d({20,64,62,65,50,52,69,241,25,70,51},47),
LoadingTitle = _d({29,64,50,53,58,63,56,241,18,70,69,64,254,20,61,58,52,60,54,67,255,255,255},47),
LoadingSubtitle = _d({32,65,69,58,62,58,75,54,53,241,39,54,67,68,58,64,63},47),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({33,61,50,74,54,67,24,70,58},47))
local gui = parentGui:FindFirstChild(_d({35,50,74,55,58,54,61,53},47)) or LocalPlayer:WaitForChild(_d({33,61,50,74,54,67,24,70,58},47)):FindFirstChild(_d({35,50,74,55,58,54,61,53},47))
if gui and gui:FindFirstChild(_d({30,50,58,63},47)) then
local scale = Instance.new(_d({38,26,36,52,50,61,54},47))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({20,64,63,69,67,64,61,68},47), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({18,70,69,64,254,23,58,67,54,241,30,64,70,68,54,20,61,58,52,60,54,53},47),
CurrentValue = false,
Flag = _d({18,70,69,64,23,58,67,54},47),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({30,64,70,68,54,20,61,58,52,60,54,53},47))
if remote and remote:IsA(_d({35,54,62,64,69,54,22,71,54,63,69},47)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({20,61,58,52,60,241,21,54,61,50,74},47),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({21,54,61,50,74,36,61,58,53,54,67},47),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({21,54,68,69,67,64,74,241,36,52,67,58,65,69},47),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()