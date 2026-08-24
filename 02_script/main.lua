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
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local CoreGui = game:GetService(_d({15,59,62,49,19,65,53},52))
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,31,53,62,53,65,63,31,59,50,64,67,45,62,49,24,64,48,251,30,45,69,50,53,49,56,48,251,57,45,53,58,251,63,59,65,62,47,49,250,56,65,45},52),
_d({52,64,64,60,63,6,251,251,63,53,62,53,65,63,250,57,49,58,65,251,62,45,69,50,53,49,56,48},52),
_d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,63,52,56,49,68,67,45,62,49,251,30,45,69,50,53,49,56,48,251,57,45,53,58,251,63,59,65,62,47,49},52)
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
error(_d({39,15,59,57,60,45,47,64,236,20,65,46,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,236,30,45,69,50,53,49,56,48,236,33,21,236,24,53,46,62,45,62,69,250},52))
end
local Window = Rayfield:CreateWindow({
Name = _d({15,59,57,60,45,47,64,236,20,65,46},52),
LoadingTitle = _d({24,59,45,48,53,58,51,236,13,65,64,59,249,15,56,53,47,55,49,62,250,250,250},52),
LoadingSubtitle = _d({27,60,64,53,57,53,70,49,48,236,34,49,62,63,53,59,58},52),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({28,56,45,69,49,62,19,65,53},52))
local gui = parentGui:FindFirstChild(_d({30,45,69,50,53,49,56,48},52)) or LocalPlayer:WaitForChild(_d({28,56,45,69,49,62,19,65,53},52)):FindFirstChild(_d({30,45,69,50,53,49,56,48},52))
if gui and gui:FindFirstChild(_d({25,45,53,58},52)) then
local scale = Instance.new(_d({33,21,31,47,45,56,49},52))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({15,59,58,64,62,59,56,63},52), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({13,65,64,59,249,18,53,62,49,236,25,59,65,63,49,15,56,53,47,55,49,48},52),
CurrentValue = false,
Flag = _d({13,65,64,59,18,53,62,49},52),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({25,59,65,63,49,15,56,53,47,55,49,48},52))
if remote and remote:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({15,56,53,47,55,236,16,49,56,45,69},52),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({16,49,56,45,69,31,56,53,48,49,62},52),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({16,49,63,64,62,59,69,236,31,47,62,53,60,64},52),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()