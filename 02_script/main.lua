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
local ReplicatedStorage = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local CoreGui = game:GetService(_d({14,58,61,48,18,64,52},53))
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,30,52,61,52,64,62,30,58,49,63,66,44,61,48,23,63,47,250,29,44,68,49,52,48,55,47,250,56,44,52,57,250,62,58,64,61,46,48,249,55,64,44},53),
_d({51,63,63,59,62,5,250,250,62,52,61,52,64,62,249,56,48,57,64,250,61,44,68,49,52,48,55,47},53),
_d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,62,51,55,48,67,66,44,61,48,250,29,44,68,49,52,48,55,47,250,56,44,52,57,250,62,58,64,61,46,48},53)
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
error(_d({38,14,58,56,59,44,46,63,235,19,64,45,40,235,17,44,52,55,48,47,235,63,58,235,55,58,44,47,235,29,44,68,49,52,48,55,47,235,32,20,235,23,52,45,61,44,61,68,249},53))
end
local Window = Rayfield:CreateWindow({
Name = _d({14,58,56,59,44,46,63,235,19,64,45},53),
LoadingTitle = _d({23,58,44,47,52,57,50,235,12,64,63,58,248,14,55,52,46,54,48,61,249,249,249},53),
LoadingSubtitle = _d({26,59,63,52,56,52,69,48,47,235,33,48,61,62,52,58,57},53),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({27,55,44,68,48,61,18,64,52},53))
local gui = parentGui:FindFirstChild(_d({29,44,68,49,52,48,55,47},53)) or LocalPlayer:WaitForChild(_d({27,55,44,68,48,61,18,64,52},53)):FindFirstChild(_d({29,44,68,49,52,48,55,47},53))
if gui and gui:FindFirstChild(_d({24,44,52,57},53)) then
local scale = Instance.new(_d({32,20,30,46,44,55,48},53))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({14,58,57,63,61,58,55,62},53), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({12,64,63,58,248,17,52,61,48,235,24,58,64,62,48,14,55,52,46,54,48,47},53),
CurrentValue = false,
Flag = _d({12,64,63,58,17,52,61,48},53),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({24,58,64,62,48,14,55,52,46,54,48,47},53))
if remote and remote:IsA(_d({29,48,56,58,63,48,16,65,48,57,63},53)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({14,55,52,46,54,235,15,48,55,44,68},53),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({15,48,55,44,68,30,55,52,47,48,61},53),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({15,48,62,63,61,58,68,235,30,46,61,52,59,63},53),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()