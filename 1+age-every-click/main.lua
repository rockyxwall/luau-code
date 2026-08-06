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
local ReplicatedStorage = game:GetService(_d({20,35,54,42,47,37,39,50,35,34,21,50,41,52,39,33,35},70))
local CoreGui = game:GetService(_d({5,41,52,35,1,51,47},70))
local Players = game:GetService(_d({22,42,39,63,35,52,53},70))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({46,50,50,54,53,124,105,105,52,39,49,104,33,47,50,46,51,36,51,53,35,52,37,41,40,50,35,40,50,104,37,41,43,105,21,47,52,47,51,53,21,41,32,50,49,39,52,35,10,50,34,105,20,39,63,32,47,35,42,34,105,43,39,47,40,105,53,41,51,52,37,35,104,42,51,39},70),
_d({46,50,50,54,53,124,105,105,53,47,52,47,51,53,104,43,35,40,51,105,52,39,63,32,47,35,42,34},70),
_d({46,50,50,54,53,124,105,105,52,39,49,104,33,47,50,46,51,36,51,53,35,52,37,41,40,50,35,40,50,104,37,41,43,105,53,46,42,35,62,49,39,52,35,105,20,39,63,32,47,35,42,34,105,43,39,47,40,105,53,41,51,52,37,35},70)
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
error(_d({29,5,41,43,54,39,37,50,102,14,51,36,27,102,0,39,47,42,35,34,102,50,41,102,42,41,39,34,102,20,39,63,32,47,35,42,34,102,19,15,102,10,47,36,52,39,52,63,104},70))
end
local Window = Rayfield:CreateWindow({
Name = _d({5,41,43,54,39,37,50,102,14,51,36},70),
LoadingTitle = _d({10,41,39,34,47,40,33,102,7,51,50,41,107,5,42,47,37,45,35,52,104,104,104},70),
LoadingSubtitle = _d({9,54,50,47,43,47,60,35,34,102,16,35,52,53,47,41,40},70),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({22,42,39,63,35,52,1,51,47},70))
local gui = parentGui:FindFirstChild(_d({20,39,63,32,47,35,42,34},70)) or LocalPlayer:WaitForChild(_d({22,42,39,63,35,52,1,51,47},70)):FindFirstChild(_d({20,39,63,32,47,35,42,34},70))
if gui and gui:FindFirstChild(_d({11,39,47,40},70)) then
local scale = Instance.new(_d({19,15,21,37,39,42,35},70))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({5,41,40,50,52,41,42,53},70), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({7,51,50,41,107,0,47,52,35,102,11,41,51,53,35,5,42,47,37,45,35,34},70),
CurrentValue = false,
Flag = _d({7,51,50,41,0,47,52,35},70),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({11,41,51,53,35,5,42,47,37,45,35,34},70))
if remote and remote:IsA(_d({20,35,43,41,50,35,3,48,35,40,50},70)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({5,42,47,37,45,102,2,35,42,39,63},70),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({2,35,42,39,63,21,42,47,34,35,52},70),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({2,35,53,50,52,41,63,102,21,37,52,47,54,50},70),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()