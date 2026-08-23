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
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local CoreGui = game:GetService(_d({11,55,58,45,15,61,49},56))
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,27,49,58,49,61,59,27,55,46,60,63,41,58,45,20,60,44,247,26,41,65,46,49,45,52,44,247,53,41,49,54,247,59,55,61,58,43,45,246,52,61,41},56),
_d({48,60,60,56,59,2,247,247,59,49,58,49,61,59,246,53,45,54,61,247,58,41,65,46,49,45,52,44},56),
_d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,59,48,52,45,64,63,41,58,45,247,26,41,65,46,49,45,52,44,247,53,41,49,54,247,59,55,61,58,43,45},56)
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
error(_d({35,11,55,53,56,41,43,60,232,16,61,42,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,232,26,41,65,46,49,45,52,44,232,29,17,232,20,49,42,58,41,58,65,246},56))
end
local Window = Rayfield:CreateWindow({
Name = _d({11,55,53,56,41,43,60,232,16,61,42},56),
LoadingTitle = _d({20,55,41,44,49,54,47,232,9,61,60,55,245,11,52,49,43,51,45,58,246,246,246},56),
LoadingSubtitle = _d({23,56,60,49,53,49,66,45,44,232,30,45,58,59,49,55,54},56),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({24,52,41,65,45,58,15,61,49},56))
local gui = parentGui:FindFirstChild(_d({26,41,65,46,49,45,52,44},56)) or LocalPlayer:WaitForChild(_d({24,52,41,65,45,58,15,61,49},56)):FindFirstChild(_d({26,41,65,46,49,45,52,44},56))
if gui and gui:FindFirstChild(_d({21,41,49,54},56)) then
local scale = Instance.new(_d({29,17,27,43,41,52,45},56))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({11,55,54,60,58,55,52,59},56), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({9,61,60,55,245,14,49,58,45,232,21,55,61,59,45,11,52,49,43,51,45,44},56),
CurrentValue = false,
Flag = _d({9,61,60,55,14,49,58,45},56),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({21,55,61,59,45,11,52,49,43,51,45,44},56))
if remote and remote:IsA(_d({26,45,53,55,60,45,13,62,45,54,60},56)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({11,52,49,43,51,232,12,45,52,41,65},56),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({12,45,52,41,65,27,52,49,44,45,58},56),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({12,45,59,60,58,55,65,232,27,43,58,49,56,60},56),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()