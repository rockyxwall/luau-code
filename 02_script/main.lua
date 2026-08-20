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
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local CoreGui = game:GetService(_d({39,83,86,73,43,89,77},28))
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,55,77,86,77,89,87,55,83,74,88,91,69,86,73,48,88,72,19,54,69,93,74,77,73,80,72,19,81,69,77,82,19,87,83,89,86,71,73,18,80,89,69},28),
_d({76,88,88,84,87,30,19,19,87,77,86,77,89,87,18,81,73,82,89,19,86,69,93,74,77,73,80,72},28),
_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,87,76,80,73,92,91,69,86,73,19,54,69,93,74,77,73,80,72,19,81,69,77,82,19,87,83,89,86,71,73},28)
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
error(_d({63,39,83,81,84,69,71,88,4,44,89,70,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,4,54,69,93,74,77,73,80,72,4,57,45,4,48,77,70,86,69,86,93,18},28))
end
local Window = Rayfield:CreateWindow({
Name = _d({39,83,81,84,69,71,88,4,44,89,70},28),
LoadingTitle = _d({48,83,69,72,77,82,75,4,37,89,88,83,17,39,80,77,71,79,73,86,18,18,18},28),
LoadingSubtitle = _d({51,84,88,77,81,77,94,73,72,4,58,73,86,87,77,83,82},28),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({52,80,69,93,73,86,43,89,77},28))
local gui = parentGui:FindFirstChild(_d({54,69,93,74,77,73,80,72},28)) or LocalPlayer:WaitForChild(_d({52,80,69,93,73,86,43,89,77},28)):FindFirstChild(_d({54,69,93,74,77,73,80,72},28))
if gui and gui:FindFirstChild(_d({49,69,77,82},28)) then
local scale = Instance.new(_d({57,45,55,71,69,80,73},28))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local MainTab = Window:CreateTab(_d({39,83,82,88,86,83,80,87},28), 4483362458)
local autoFiring = false
local fireDelay = 0.1
local AutoToggle = MainTab:CreateToggle({
Name = _d({37,89,88,83,17,42,77,86,73,4,49,83,89,87,73,39,80,77,71,79,73,72},28),
CurrentValue = false,
Flag = _d({37,89,88,83,42,77,86,73},28),
Callback = function(Value)
autoFiring = Value
if autoFiring then
task.spawn(function()
while autoFiring do
local remote = ReplicatedStorage:FindFirstChild(_d({49,83,89,87,73,39,80,77,71,79,73,72},28))
if remote and remote:IsA(_d({54,73,81,83,88,73,41,90,73,82,88},28)) then
pcall(function() remote:FireServer() end)
end
task.wait(fireDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({39,80,77,71,79,4,40,73,80,69,93},28),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({40,73,80,69,93,55,80,77,72,73,86},28),
Callback = function(Value)
fireDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({40,73,87,88,86,83,93,4,55,71,86,77,84,88},28),
Callback = function()
autoFiring = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()