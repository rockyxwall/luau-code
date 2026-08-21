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
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local CoreGui = game:GetService(_d({22,66,69,56,26,72,60},45))
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,38,60,69,60,72,70,38,66,57,71,74,52,69,56,31,71,55,2,37,52,76,57,60,56,63,55,2,64,52,60,65,2,70,66,72,69,54,56,1,63,72,52},45),
_d({59,71,71,67,70,13,2,2,70,60,69,60,72,70,1,64,56,65,72,2,69,52,76,57,60,56,63,55},45),
_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,70,59,63,56,75,74,52,69,56,2,37,52,76,57,60,56,63,55,2,64,52,60,65,2,70,66,72,69,54,56},45)
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
error(_d({46,22,66,64,67,52,54,71,243,27,72,53,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,243,37,52,76,57,60,56,63,55,243,40,28,243,31,60,53,69,52,69,76,1},45))
end
local Window = Rayfield:CreateWindow({
Name = _d({22,66,64,67,52,54,71,243,27,72,53},45),
LoadingTitle = _d({31,66,52,55,60,65,58,243,20,72,71,66,0,22,63,60,54,62,56,69,1,1,1},45),
LoadingSubtitle = _d({34,67,71,60,64,60,77,56,55,243,41,56,69,70,60,66,65},45),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({35,63,52,76,56,69,26,72,60},45))
local gui = parentGui:FindFirstChild(_d({37,52,76,57,60,56,63,55},45)) or LocalPlayer:WaitForChild(_d({35,63,52,76,56,69,26,72,60},45)):FindFirstChild(_d({37,52,76,57,60,56,63,55},45))
if gui and gui:FindFirstChild(_d({32,52,60,65},45)) then
local scale = Instance.new(_d({40,28,38,54,52,63,56},45))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({22,66,65,71,69,66,63,70},45), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({20,72,71,66,0,25,60,69,56,243,32,66,72,70,56,22,63,60,54,62,56,55},45),
CurrentValue = false,
Flag = _d({20,72,71,66,25,60,69,56},45),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({32,66,72,70,56,22,63,60,54,62,56,55},45))
if remote and remote:IsA(_d({37,56,64,66,71,56,24,73,56,65,71},45)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({22,63,60,54,62,243,23,56,63,52,76},45),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({23,56,63,52,76,38,63,60,55,56,69},45),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({23,56,70,71,69,66,76,243,38,54,69,60,67,71},45),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()