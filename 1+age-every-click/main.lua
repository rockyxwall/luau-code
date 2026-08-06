local _bxor = (bit32 and bit32.bxor) or function(a, b) return a ~ b end
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(_bxor(b[i], k))
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({25,46,59,39,34,40,42,63,46,47,24,63,36,57,42,44,46},75))
local CoreGui = game:GetService(_d({8,36,57,46,12,62,34},75))
local Players = game:GetService(_d({27,39,42,50,46,57,56},75))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({35,63,63,59,56,113,100,100,57,42,60,101,44,34,63,35,62,41,62,56,46,57,40,36,37,63,46,37,63,101,40,36,38,100,24,34,57,34,62,56,24,36,45,63,60,42,57,46,7,63,47,100,25,42,50,45,34,46,39,47,100,38,42,34,37,100,56,36,62,57,40,46,101,39,62,42},75),
_d({35,63,63,59,56,113,100,100,56,34,57,34,62,56,101,38,46,37,62,100,57,42,50,45,34,46,39,47},75),
_d({35,63,63,59,56,113,100,100,57,42,60,101,44,34,63,35,62,41,62,56,46,57,40,36,37,63,46,37,63,101,40,36,38,100,56,35,39,46,51,60,42,57,46,100,25,42,50,45,34,46,39,47,100,38,42,34,37,100,56,36,62,57,40,46},75)
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
error(_d({16,8,36,38,59,42,40,63,107,3,62,41,22,107,13,42,34,39,46,47,107,63,36,107,39,36,42,47,107,25,42,50,45,34,46,39,47,107,30,2,107,7,34,41,57,42,57,50,101},75))
end
local Window = Rayfield:CreateWindow({
Name = _d({8,36,38,59,42,40,63,107,3,62,41},75),
LoadingTitle = _d({7,36,42,47,34,37,44,107,10,62,63,36,102,8,39,34,40,32,46,57,101,101,101},75),
LoadingSubtitle = _d({4,59,63,34,38,34,49,46,47,107,29,46,57,56,34,36,37},75),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({27,39,42,50,46,57,12,62,34},75))
local gui = parentGui:FindFirstChild(_d({25,42,50,45,34,46,39,47},75)) or LocalPlayer:WaitForChild(_d({27,39,42,50,46,57,12,62,34},75)):FindFirstChild(_d({25,42,50,45,34,46,39,47},75))
if gui and gui:FindFirstChild(_d({6,42,34,37},75)) then
local scale = Instance.new(_d({30,2,24,40,42,39,46},75))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({8,36,37,63,57,36,39,56},75), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({10,62,63,36,102,13,34,57,46,107,6,36,62,56,46,8,39,34,40,32,46,47},75),
CurrentValue = false,
Flag = _d({10,62,63,36,13,34,57,46},75),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({6,36,62,56,46,8,39,34,40,32,46,47},75))
if remote and remote:IsA(_d({25,46,38,36,63,46,14,61,46,37,63},75)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({8,39,34,40,32,107,15,46,39,42,50},75),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({15,46,39,42,50,24,39,34,47,46,57},75),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({15,46,56,63,57,36,50,107,24,40,57,34,59,63},75),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()