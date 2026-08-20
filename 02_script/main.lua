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
local ReplicatedStorage = game:GetService(_d({36,55,66,62,59,53,51,70,55,54,37,70,65,68,51,57,55},46))
local CoreGui = game:GetService(_d({21,65,68,55,25,71,59},46))
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({58,70,70,66,69,12,1,1,68,51,73,0,57,59,70,58,71,52,71,69,55,68,53,65,64,70,55,64,70,0,53,65,63,1,37,59,68,59,71,69,37,65,56,70,73,51,68,55,30,70,54,1,36,51,75,56,59,55,62,54,1,63,51,59,64,1,69,65,71,68,53,55,0,62,71,51},46),
_d({58,70,70,66,69,12,1,1,69,59,68,59,71,69,0,63,55,64,71,1,68,51,75,56,59,55,62,54},46),
_d({58,70,70,66,69,12,1,1,68,51,73,0,57,59,70,58,71,52,71,69,55,68,53,65,64,70,55,64,70,0,53,65,63,1,69,58,62,55,74,73,51,68,55,1,36,51,75,56,59,55,62,54,1,63,51,59,64,1,69,65,71,68,53,55},46)
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
error(_d({45,21,65,63,66,51,53,70,242,26,71,52,47,242,24,51,59,62,55,54,242,70,65,242,62,65,51,54,242,36,51,75,56,59,55,62,54,242,39,27,242,30,59,52,68,51,68,75,0},46))
end
local Window = Rayfield:CreateWindow({
Name = _d({21,65,63,66,51,53,70,242,26,71,52},46),
LoadingTitle = _d({30,65,51,54,59,64,57,242,19,71,70,65,255,21,62,59,53,61,55,68,0,0,0},46),
LoadingSubtitle = _d({33,66,70,59,63,59,76,55,54,242,40,55,68,69,59,65,64},46),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({34,62,51,75,55,68,25,71,59},46))
local gui = parentGui:FindFirstChild(_d({36,51,75,56,59,55,62,54},46)) or LocalPlayer:WaitForChild(_d({34,62,51,75,55,68,25,71,59},46)):FindFirstChild(_d({36,51,75,56,59,55,62,54},46))
if gui and gui:FindFirstChild(_d({31,51,59,64},46)) then
local scale = Instance.new(_d({39,27,37,53,51,62,55},46))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({21,65,64,70,68,65,62,69},46), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({19,71,70,65,255,24,59,68,55,242,31,65,71,69,55,21,62,59,53,61,55,54},46),
CurrentValue = false,
Flag = _d({19,71,70,65,24,59,68,55},46),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({31,65,71,69,55,21,62,59,53,61,55,54},46))
if remote and remote:IsA(_d({36,55,63,65,70,55,23,72,55,64,70},46)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({21,62,59,53,61,242,22,55,62,51,75},46),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({22,55,62,51,75,37,62,59,54,55,68},46),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({22,55,69,70,68,65,75,242,37,53,68,59,66,70},46),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()