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
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local CoreGui = game:GetService(_d({30,74,77,64,34,80,68},37))
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,46,68,77,68,80,78,46,74,65,79,82,60,77,64,39,79,63,10,45,60,84,65,68,64,71,63,10,72,60,68,73,10,78,74,80,77,62,64,9,71,80,60},37),
_d({67,79,79,75,78,21,10,10,78,68,77,68,80,78,9,72,64,73,80,10,77,60,84,65,68,64,71,63},37),
_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,78,67,71,64,83,82,60,77,64,10,45,60,84,65,68,64,71,63,10,72,60,68,73,10,78,74,80,77,62,64},37)
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
error(_d({54,30,74,72,75,60,62,79,251,35,80,61,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,45,60,84,65,68,64,71,63,251,48,36,251,39,68,61,77,60,77,84,9},37))
end
local Window = Rayfield:CreateWindow({
Name = _d({30,74,72,75,60,62,79,251,35,80,61},37),
LoadingTitle = _d({39,74,60,63,68,73,66,251,28,80,79,74,8,30,71,68,62,70,64,77,9,9,9},37),
LoadingSubtitle = _d({42,75,79,68,72,68,85,64,63,251,49,64,77,78,68,74,73},37),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({43,71,60,84,64,77,34,80,68},37))
local gui = parentGui:FindFirstChild(_d({45,60,84,65,68,64,71,63},37)) or LocalPlayer:WaitForChild(_d({43,71,60,84,64,77,34,80,68},37)):FindFirstChild(_d({45,60,84,65,68,64,71,63},37))
if gui and gui:FindFirstChild(_d({40,60,68,73},37)) then
local scale = Instance.new(_d({48,36,46,62,60,71,64},37))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({30,74,73,79,77,74,71,78},37), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({28,80,79,74,8,33,68,77,64,251,40,74,80,78,64,30,71,68,62,70,64,63},37),
CurrentValue = false,
Flag = _d({28,80,79,74,33,68,77,64},37),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({40,74,80,78,64,30,71,68,62,70,64,63},37))
if remote and remote:IsA(_d({45,64,72,74,79,64,32,81,64,73,79},37)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({30,71,68,62,70,251,31,64,71,60,84},37),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({31,64,71,60,84,46,71,68,63,64,77},37),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({31,64,78,79,77,74,84,251,46,62,77,68,75,79},37),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()