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
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local CoreGui = game:GetService(_d({8,52,55,42,12,58,46},59))
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,24,46,55,46,58,56,24,52,43,57,60,38,55,42,17,57,41,244,23,38,62,43,46,42,49,41,244,50,38,46,51,244,56,52,58,55,40,42,243,49,58,38},59),
_d({45,57,57,53,56,255,244,244,56,46,55,46,58,56,243,50,42,51,58,244,55,38,62,43,46,42,49,41},59),
_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,56,45,49,42,61,60,38,55,42,244,23,38,62,43,46,42,49,41,244,50,38,46,51,244,56,52,58,55,40,42},59)
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
error(_d({32,8,52,50,53,38,40,57,229,13,58,39,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,229,23,38,62,43,46,42,49,41,229,26,14,229,17,46,39,55,38,55,62,243},59))
end
local Window = Rayfield:CreateWindow({
Name = _d({8,52,50,53,38,40,57,229,13,58,39},59),
LoadingTitle = _d({17,52,38,41,46,51,44,229,6,58,57,52,242,8,49,46,40,48,42,55,243,243,243},59),
LoadingSubtitle = _d({20,53,57,46,50,46,63,42,41,229,27,42,55,56,46,52,51},59),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59))
local gui = parentGui:FindFirstChild(_d({23,38,62,43,46,42,49,41},59)) or LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59)):FindFirstChild(_d({23,38,62,43,46,42,49,41},59))
if gui and gui:FindFirstChild(_d({18,38,46,51},59)) then
local scale = Instance.new(_d({26,14,24,40,38,49,42},59))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({8,52,51,57,55,52,49,56},59), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({6,58,57,52,242,11,46,55,42,229,18,52,58,56,42,8,49,46,40,48,42,41},59),
CurrentValue = false,
Flag = _d({6,58,57,52,11,46,55,42},59),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({18,52,58,56,42,8,49,46,40,48,42,41},59))
if remote and remote:IsA(_d({23,42,50,52,57,42,10,59,42,51,57},59)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({8,49,46,40,48,229,9,42,49,38,62},59),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({9,42,49,38,62,24,49,46,41,42,55},59),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({9,42,56,57,55,52,62,229,24,40,55,46,53,57},59),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()