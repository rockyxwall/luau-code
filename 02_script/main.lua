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
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local CoreGui = game:GetService(_d({16,60,63,50,20,66,54},51))
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,32,54,63,54,66,64,32,60,51,65,68,46,63,50,25,65,49,252,31,46,70,51,54,50,57,49,252,58,46,54,59,252,64,60,66,63,48,50,251,57,66,46},51),
_d({53,65,65,61,64,7,252,252,64,54,63,54,66,64,251,58,50,59,66,252,63,46,70,51,54,50,57,49},51),
_d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,64,53,57,50,69,68,46,63,50,252,31,46,70,51,54,50,57,49,252,58,46,54,59,252,64,60,66,63,48,50},51)
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
error(_d({40,16,60,58,61,46,48,65,237,21,66,47,42,237,19,46,54,57,50,49,237,65,60,237,57,60,46,49,237,31,46,70,51,54,50,57,49,237,34,22,237,25,54,47,63,46,63,70,251},51))
end
local Window = Rayfield:CreateWindow({
Name = _d({16,60,58,61,46,48,65,237,21,66,47},51),
LoadingTitle = _d({25,60,46,49,54,59,52,237,14,66,65,60,250,16,57,54,48,56,50,63,251,251,251},51),
LoadingSubtitle = _d({28,61,65,54,58,54,71,50,49,237,35,50,63,64,54,60,59},51),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({29,57,46,70,50,63,20,66,54},51))
local gui = parentGui:FindFirstChild(_d({31,46,70,51,54,50,57,49},51)) or LocalPlayer:WaitForChild(_d({29,57,46,70,50,63,20,66,54},51)):FindFirstChild(_d({31,46,70,51,54,50,57,49},51))
if gui and gui:FindFirstChild(_d({26,46,54,59},51)) then
local scale = Instance.new(_d({34,22,32,48,46,57,50},51))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({16,60,59,65,63,60,57,64},51), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({14,66,65,60,250,19,54,63,50,237,26,60,66,64,50,16,57,54,48,56,50,49},51),
CurrentValue = false,
Flag = _d({14,66,65,60,19,54,63,50},51),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({26,60,66,64,50,16,57,54,48,56,50,49},51))
if remote and remote:IsA(_d({31,50,58,60,65,50,18,67,50,59,65},51)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({16,57,54,48,56,237,17,50,57,46,70},51),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({17,50,57,46,70,32,57,54,49,50,63},51),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({17,50,64,65,63,60,70,237,32,48,63,54,61,65},51),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()