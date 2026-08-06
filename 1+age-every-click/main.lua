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
local ReplicatedStorage = game:GetService(_d({138,189,168,180,177,187,185,172,189,188,139,172,183,170,185,191,189},216))
local CoreGui = game:GetService(_d({155,183,170,189,159,173,177},216))
local Players = game:GetService(_d({136,180,185,161,189,170,171},216))
local Rayfield = loadstring(game:HttpGet(_d({176,172,172,168,171,226,247,247,171,177,170,177,173,171,246,181,189,182,173,247,170,185,161,190,177,189,180,188},216)))()
local Window = Rayfield:CreateWindow({
Name = _d({155,183,181,168,185,187,172,248,144,173,186},216),
LoadingTitle = _d({148,183,185,188,177,182,191,248,153,173,172,183,245,155,180,177,187,179,189,170,246,246,246},216),
LoadingSubtitle = _d({151,168,172,177,181,177,162,189,188,248,142,189,170,171,177,183,182},216),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.5)
local gui = CoreGui:FindFirstChild(_d({138,185,161,190,177,189,180,188},216)) or Players.LocalPlayer:WaitForChild(_d({136,180,185,161,189,170,159,173,177},216)):FindFirstChild(_d({138,185,161,190,177,189,180,188},216))
if gui and gui:FindFirstChild(_d({149,185,177,182},216)) then
local scale = Instance.new(_d({141,145,139,187,185,180,189},216))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
local MainTab = Window:CreateTab(_d({155,183,182,172,170,183,180,171},216), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({153,173,172,183,245,158,177,170,189,248,149,183,173,171,189,155,180,177,187,179,189,188},216),
CurrentValue = false,
Flag = _d({153,173,172,183,158,177,170,189},216),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({149,183,173,171,189,155,180,177,187,179,189,188},216))
if remote and remote:IsA(_d({138,189,181,183,172,189,157,174,189,182,172},216)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({155,180,177,187,179,248,156,189,180,185,161},216),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({156,189,180,185,161,139,180,177,188,189,170},216),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({156,189,171,172,170,183,161,248,139,187,170,177,168,172},216),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()