(function()
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(b[i] + k)
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local CoreGui = game:GetService(_d({49,93,96,83,53,99,87},18))
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Rayfield = nil
local rayfieldSources = {
_d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,65,87,96,87,99,97,65,93,84,98,101,79,96,83,58,98,82,29,64,79,103,84,87,83,90,82,29,91,79,87,92,29,97,93,99,96,81,83,28,90,99,79},18),
_d({86,98,98,94,97,40,29,29,97,87,96,87,99,97,28,91,83,92,99,29,96,79,103,84,87,83,90,82},18),
_d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,97,86,90,83,102,101,79,96,83,29,64,79,103,84,87,83,90,82,29,91,79,87,92,29,97,93,99,96,81,83},18)
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
error(_d({73,48,79,92,79,92,79,14,59,93,92,89,83,103,14,54,99,80,75,14,52,79,87,90,83,82,14,98,93,14,90,93,79,82,14,64,79,103,84,87,83,90,82,14,67,55,14,58,87,80,96,79,96,103,28},18))
end
local Window = Rayfield:CreateWindow({
Name = _d({48,79,92,79,92,79,14,59,93,92,89,83,103,14,54,99,80,14,55338,57146},18),
LoadingTitle = _d({73,67,62,50,75,14,25,31,14,48,79,92,79,92,79,14,59,93,92,89,83,103},18),
LoadingSubtitle = _d({59,93,80,87,90,83,14,50,83,97,98,96,99,81,98,87,93,92,14,54,99,80},18),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18))
local gui = parentGui:FindFirstChild(_d({64,79,103,84,87,83,90,82},18)) or LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18)):FindFirstChild(_d({64,79,103,84,87,83,90,82},18))
if gui and gui:FindFirstChild(_d({59,79,87,92},18)) then
local scale = Instance.new(_d({67,55,65,81,79,90,83},18))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local mobileGui = nil
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18))
if parentGui:FindFirstChild(_d({48,79,92,79,92,79,59,93,92,89,83,103,59,93,80,87,90,83,66,93,85,85,90,83},18)) then
parentGui.BananaMonkeyMobileToggle:Destroy()
end
mobileGui = Instance.new(_d({65,81,96,83,83,92,53,99,87},18))
mobileGui.Name = _d({48,79,92,79,92,79,59,93,92,89,83,103,59,93,80,87,90,83,66,93,85,85,90,83},18)
mobileGui.ResetOnSpawn = false
mobileGui.Parent = parentGui
local toggleBtn = Instance.new(_d({66,83,102,98,48,99,98,98,93,92},18))
toggleBtn.Name = _d({66,93,85,85,90,83,48,99,98,98,93,92},18)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
toggleBtn.Text = _d({55338,57146},18)
toggleBtn.TextSize = 26
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Parent = mobileGui
local corner = Instance.new(_d({67,55,49,93,96,92,83,96},18))
corner.CornerRadius = UDim.new(0.5, 0)
corner.Parent = toggleBtn
local stroke = Instance.new(_d({67,55,65,98,96,93,89,83},18))
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 2
stroke.Parent = toggleBtn
toggleBtn.MouseButton1Click:Connect(function()
pcall(function()
if Rayfield then
Rayfield:ToggleUI()
end
end)
end)
end)
local MainTab = Window:CreateTab(_d({47,99,98,93,91,79,98,87,93,92},18), 4483362458)
local autoDestroying = false
local destroyDelay = 0.1
local punchPower = 2
MainTab:CreateToggle({
Name = _d({47,99,98,93,27,50,83,97,98,96,93,103,14,53,96,93,99,92,82},18),
CurrentValue = false,
Flag = _d({47,99,98,93,50,83,97,98,96,93,103},18),
Callback = function(Value)
autoDestroying = Value
if autoDestroying then
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if root then
local targetPos = root.Position - Vector3.new(0, 3.5, 0)
local punchEvent = ReplicatedStorage:FindFirstChild(_d({50,83,97,98,96,99,81,98,87,93,92,77,62,99,92,81,86},18), true)
if punchEvent and punchEvent:IsA(_d({64,83,91,93,98,83,51,100,83,92,98},18)) then
pcall(function()
punchEvent:FireServer(punchPower, targetPos)
end)
end
end
end
task.wait(destroyDelay)
end
end)
end
end,
})
MainTab:CreateSlider({
Name = _d({62,99,92,81,86,14,50,83,90,79,103},18),
Range = {0.05, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({62,99,92,81,86,50,83,90,79,103},18),
Callback = function(Value)
destroyDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({50,83,97,98,96,93,103,14,65,81,96,87,94,98},18),
Callback = function()
autoDestroying = false
if mobileGui then
pcall(function() mobileGui:Destroy() end)
end
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()
end)()