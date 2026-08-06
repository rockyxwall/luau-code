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
local ReplicatedStorage = game:GetService(_d({130,181,160,188,185,179,177,164,181,180,131,164,191,162,177,183,181},208))
local CoreGui = game:GetService(_d({147,191,162,181,151,165,185},208))
local Players = game:GetService(_d({128,188,177,169,181,162,163},208))
local Rayfield = loadstring(game:HttpGet(_d({184,164,164,160,163,234,255,255,163,185,162,185,165,163,254,189,181,190,165,255,162,177,169,182,185,181,188,180},208)))()
local Window = Rayfield:CreateWindow({
Name = _d({147,191,189,160,177,179,164,240,152,165,178},208),
LoadingTitle = _d({156,191,177,180,185,190,183,240,145,165,164,191,253,147,188,185,179,187,181,162,254,254,254},208),
LoadingSubtitle = _d({159,160,164,185,189,185,170,181,180,240,134,181,162,163,185,191,190},208),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.5)
local gui = CoreGui:FindFirstChild(_d({130,177,169,182,185,181,188,180},208)) or Players.LocalPlayer:WaitForChild(_d({128,188,177,169,181,162,151,165,185},208)):FindFirstChild(_d({130,177,169,182,185,181,188,180},208))
if gui and gui:FindFirstChild(_d({157,177,185,190},208)) then
local scale = Instance.new(_d({133,153,131,179,177,188,181},208))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
local MainTab = Window:CreateTab(_d({147,191,190,164,162,191,188,163},208), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({145,165,164,191,253,150,185,162,181,240,157,191,165,163,181,147,188,185,179,187,181,180},208),
CurrentValue = false,
Flag = _d({145,165,164,191,150,185,162,181},208),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({157,191,165,163,181,147,188,185,179,187,181,180},208))
if remote and remote:IsA(_d({130,181,189,191,164,181,149,166,181,190,164},208)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({147,188,185,179,187,240,148,181,188,177,169},208),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({148,181,188,177,169,131,188,185,180,181,162},208),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({148,181,163,164,162,191,169,240,131,179,162,185,160,164},208),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()