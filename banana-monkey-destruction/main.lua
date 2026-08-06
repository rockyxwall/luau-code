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
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local CoreGui = game:GetService(_d({41,85,88,75,45,91,79},26))
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Rayfield = nil
local rayfieldSources = {
_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,57,79,88,79,91,89,57,85,76,90,93,71,88,75,50,90,74,21,56,71,95,76,79,75,82,74,21,83,71,79,84,21,89,85,91,88,73,75,20,82,91,71},26),
_d({78,90,90,86,89,32,21,21,89,79,88,79,91,89,20,83,75,84,91,21,88,71,95,76,79,75,82,74},26),
_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,89,78,82,75,94,93,71,88,75,21,56,71,95,76,79,75,82,74,21,83,71,79,84,21,89,85,91,88,73,75},26)
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
error(_d({65,40,71,84,71,84,71,6,51,85,84,81,75,95,6,46,91,72,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,6,56,71,95,76,79,75,82,74,6,59,47,6,50,79,72,88,71,88,95,20},26))
end
local Window = Rayfield:CreateWindow({
Name = _d({40,71,84,71,84,71,6,51,85,84,81,75,95,6,46,91,72,6,55330,57138},26),
LoadingTitle = _d({65,59,54,42,67,6,17,23,6,40,71,84,71,84,71,6,51,85,84,81,75,95},26),
LoadingSubtitle = _d({51,85,72,79,82,75,6,42,75,89,90,88,91,73,90,79,85,84,6,46,91,72},26),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26))
local gui = parentGui:FindFirstChild(_d({56,71,95,76,79,75,82,74},26)) or LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26)):FindFirstChild(_d({56,71,95,76,79,75,82,74},26))
if gui and gui:FindFirstChild(_d({51,71,79,84},26)) then
local scale = Instance.new(_d({59,47,57,73,71,82,75},26))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local mobileGui = nil
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26))
if parentGui:FindFirstChild(_d({40,71,84,71,84,71,51,85,84,81,75,95,51,85,72,79,82,75,58,85,77,77,82,75},26)) then
parentGui.BananaMonkeyMobileToggle:Destroy()
end
mobileGui = Instance.new(_d({57,73,88,75,75,84,45,91,79},26))
mobileGui.Name = _d({40,71,84,71,84,71,51,85,84,81,75,95,51,85,72,79,82,75,58,85,77,77,82,75},26)
mobileGui.ResetOnSpawn = false
mobileGui.Parent = parentGui
local toggleBtn = Instance.new(_d({58,75,94,90,40,91,90,90,85,84},26))
toggleBtn.Name = _d({58,85,77,77,82,75,40,91,90,90,85,84},26)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
toggleBtn.Text = _d({55330,57138},26)
toggleBtn.TextSize = 26
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Parent = mobileGui
local corner = Instance.new(_d({59,47,41,85,88,84,75,88},26))
corner.CornerRadius = UDim.new(0.5, 0)
corner.Parent = toggleBtn
local stroke = Instance.new(_d({59,47,57,90,88,85,81,75},26))
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
local MainTab = Window:CreateTab(_d({39,91,90,85,83,71,90,79,85,84},26), 4483362458)
local autoDestroying = false
local destroyDelay = 0.1
local punchPower = 2
MainTab:CreateToggle({
Name = _d({39,91,90,85,19,42,75,89,90,88,85,95,6,45,88,85,91,84,74},26),
CurrentValue = false,
Flag = _d({39,91,90,85,42,75,89,90,88,85,95},26),
Callback = function(Value)
autoDestroying = Value
if autoDestroying then
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if root then
local targetPos = root.Position - Vector3.new(0, 3.5, 0)
local punchEvent = ReplicatedStorage:FindFirstChild(_d({42,75,89,90,88,91,73,90,79,85,84,69,54,91,84,73,78},26), true)
if punchEvent and punchEvent:IsA(_d({56,75,83,85,90,75,43,92,75,84,90},26)) then
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
Name = _d({54,91,84,73,78,6,42,75,82,71,95},26),
Range = {0.05, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({54,91,84,73,78,42,75,82,71,95},26),
Callback = function(Value)
destroyDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({42,75,89,90,88,85,95,6,57,73,88,79,86,90},26),
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