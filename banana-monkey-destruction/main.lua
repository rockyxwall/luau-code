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
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
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
error(_d({32,7,38,51,38,51,38,229,18,52,51,48,42,62,229,13,58,39,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,229,23,38,62,43,46,42,49,41,229,26,14,229,17,46,39,55,38,55,62,243},59))
end
local Window = Rayfield:CreateWindow({
Name = _d({7,38,51,38,51,38,229,18,52,51,48,42,62,229,13,58,39,229,181,100,82,81},59),
LoadingTitle = _d({32,26,21,9,34,229,240,246,229,7,38,51,38,51,38,229,18,52,51,48,42,62},59),
LoadingSubtitle = _d({18,52,39,46,49,42,229,9,42,56,57,55,58,40,57,46,52,51,229,13,58,39},59),
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
local mobileGui = nil
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59))
if parentGui:FindFirstChild(_d({7,38,51,38,51,38,18,52,51,48,42,62,18,52,39,46,49,42,25,52,44,44,49,42},59)) then
parentGui.BananaMonkeyMobileToggle:Destroy()
end
mobileGui = Instance.new(_d({24,40,55,42,42,51,12,58,46},59))
mobileGui.Name = _d({7,38,51,38,51,38,18,52,51,48,42,62,18,52,39,46,49,42,25,52,44,44,49,42},59)
mobileGui.ResetOnSpawn = false
mobileGui.Parent = parentGui
local toggleBtn = Instance.new(_d({25,42,61,57,7,58,57,57,52,51},59))
toggleBtn.Name = _d({25,52,44,44,49,42,7,58,57,57,52,51},59)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
toggleBtn.Text = _d({181,100,82,81},59)
toggleBtn.TextSize = 26
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Parent = mobileGui
local corner = Instance.new(_d({26,14,8,52,55,51,42,55},59))
corner.CornerRadius = UDim.new(0.5, 0)
corner.Parent = toggleBtn
local stroke = Instance.new(_d({26,14,24,57,55,52,48,42},59))
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
local MainTab = Window:CreateTab(_d({6,58,57,52,50,38,57,46,52,51},59), 4483362458)
local autoDestroying = false
local destroyDelay = 0.1
local punchPower = 2
MainTab:CreateToggle({
Name = _d({6,58,57,52,242,9,42,56,57,55,52,62,229,12,55,52,58,51,41},59),
CurrentValue = false,
Flag = _d({6,58,57,52,9,42,56,57,55,52,62},59),
Callback = function(Value)
autoDestroying = Value
if autoDestroying then
task.spawn(function()
while autoDestroying do
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if root then
local targetPos = root.Position - Vector3.new(0, 3.5, 0)
local punchEvent = ReplicatedStorage:FindFirstChild(_d({9,42,56,57,55,58,40,57,46,52,51,36,21,58,51,40,45},59), true)
if punchEvent and punchEvent:IsA(_d({23,42,50,52,57,42,10,59,42,51,57},59)) then
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
Name = _d({21,58,51,40,45,229,9,42,49,38,62},59),
Range = {0.05, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({21,58,51,40,45,9,42,49,38,62},59),
Callback = function(Value)
destroyDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({9,42,56,57,55,52,62,229,24,40,55,46,53,57},59),
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