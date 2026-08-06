local _bit = bit32 or {bxor = function(a,b) return a ~ b end}
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(_bit.bxor(b[i], k))
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({230,209,196,216,221,215,213,192,209,208,231,192,219,198,213,211,209},180))
local CoreGui = game:GetService(_d({247,219,198,209,243,193,221},180))
local Players = game:GetService(_d({228,216,213,205,209,198,199},180))
local Rayfield = loadstring(game:HttpGet(_d({220,192,192,196,199,142,155,155,199,221,198,221,193,199,154,217,209,218,193,155,198,213,205,210,221,209,216,208},180)))()
local Window = Rayfield:CreateWindow({
Name = _d({247,219,217,196,213,215,192,148,252,193,214},180),
LoadingTitle = _d({248,219,213,208,221,218,211,148,245,193,192,219,153,247,216,221,215,223,209,198,154,154,154},180),
LoadingSubtitle = _d({251,196,192,221,217,221,206,209,208,148,226,209,198,199,221,219,218},180),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.5)
local gui = CoreGui:FindFirstChild(_d({230,213,205,210,221,209,216,208},180)) or Players.LocalPlayer:WaitForChild(_d({228,216,213,205,209,198,243,193,221},180)):FindFirstChild(_d({230,213,205,210,221,209,216,208},180))
if gui and gui:FindFirstChild(_d({249,213,221,218},180)) then
local scale = Instance.new(_d({225,253,231,215,213,216,209},180))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
local MainTab = Window:CreateTab(_d({247,219,218,192,198,219,216,199},180), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({245,193,192,219,153,242,221,198,209,148,249,219,193,199,209,247,216,221,215,223,209,208},180),
CurrentValue = false,
Flag = _d({245,193,192,219,242,221,198,209},180),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({249,219,193,199,209,247,216,221,215,223,209,208},180))
if remote and remote:IsA(_d({230,209,217,219,192,209,241,194,209,218,192},180)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({247,216,221,215,223,148,240,209,216,213,205},180),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({240,209,216,213,205,231,216,221,208,209,198},180),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({240,209,199,192,198,219,205,148,231,215,198,221,196,192},180),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()