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
local ReplicatedStorage = game:GetService(_d({40,59,70,66,63,57,55,74,59,58,41,74,69,72,55,61,59},42))
local CoreGui = game:GetService(_d({25,69,72,59,29,75,63},42))
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,41,63,72,63,75,73,41,69,60,74,77,55,72,59,34,74,58,5,40,55,79,60,63,59,66,58,5,67,55,63,68,5,73,69,75,72,57,59,4,66,75,55},42),
_d({62,74,74,70,73,16,5,5,73,63,72,63,75,73,4,67,59,68,75,5,72,55,79,60,63,59,66,58},42),
_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,73,62,66,59,78,77,55,72,59,5,40,55,79,60,63,59,66,58,5,67,55,63,68,5,73,69,75,72,57,59},42)
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
error(_d({49,25,69,67,70,55,57,74,246,30,75,56,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,246,40,55,79,60,63,59,66,58,246,43,31,246,34,63,56,72,55,72,79,4},42))
end
local Window = Rayfield:CreateWindow({
Name = _d({25,69,67,70,55,57,74,246,30,75,56},42),
LoadingTitle = _d({34,69,55,58,63,68,61,246,23,75,74,69,3,25,66,63,57,65,59,72,4,4,4},42),
LoadingSubtitle = _d({37,70,74,63,67,63,80,59,58,246,44,59,72,73,63,69,68},42),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({38,66,55,79,59,72,29,75,63},42))
local gui = parentGui:FindFirstChild(_d({40,55,79,60,63,59,66,58},42)) or LocalPlayer:WaitForChild(_d({38,66,55,79,59,72,29,75,63},42)):FindFirstChild(_d({40,55,79,60,63,59,66,58},42))
if gui and gui:FindFirstChild(_d({35,55,63,68},42)) then
local scale = Instance.new(_d({43,31,41,57,55,66,59},42))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({25,69,68,74,72,69,66,73},42), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({23,75,74,69,3,28,63,72,59,246,35,69,75,73,59,25,66,63,57,65,59,58},42),
CurrentValue = false,
Flag = _d({23,75,74,69,28,63,72,59},42),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({35,69,75,73,59,25,66,63,57,65,59,58},42))
if remote and remote:IsA(_d({40,59,67,69,74,59,27,76,59,68,74},42)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({25,66,63,57,65,246,26,59,66,55,79},42),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({26,59,66,55,79,41,66,63,58,59,72},42),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({26,59,73,74,72,69,79,246,41,57,72,63,70,74},42),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()