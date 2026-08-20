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
local MobileUI = {}
local CoreGui = game:GetService(_d({37,81,84,71,41,87,75},30))
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local LocalPlayer = Players.LocalPlayer
function MobileUI.CreateWindow(config)
local titleText = config.Title or _d({47,71,80,87},30)
local playerGui = LocalPlayer:WaitForChild(_d({50,78,67,91,71,84,41,87,75},30), 10)
if not playerGui then return nil end
local oldUI = playerGui:FindFirstChild(_d({47,81,68,75,78,71,55,43,65},30) .. titleText)
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({53,69,84,71,71,80,41,87,75},30))
screenGui.Name = _d({47,81,68,75,78,71,55,43,65},30) .. titleText
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({40,84,67,79,71},30))
main.Size = UDim2.new(0, 300, 0, 400)
main.Position = UDim2.new(0.5, -150, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true
main.Parent = screenGui
local corner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local topbar = Instance.new(_d({40,84,67,79,71},30))
topbar.Size = UDim2.new(1, 0, 0, 40)
topbar.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
topbar.BorderSizePixel = 0
topbar.Parent = main
local topCorner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
topCorner.CornerRadius = UDim.new(0, 8)
topCorner.Parent = topbar
local topbarBlock = Instance.new(_d({40,84,67,79,71},30))
topbarBlock.Size = UDim2.new(1, 0, 0, 10)
topbarBlock.Position = UDim2.new(0, 0, 1, -10)
topbarBlock.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
topbarBlock.BorderSizePixel = 0
topbarBlock.Parent = topbar
local title = Instance.new(_d({54,71,90,86,46,67,68,71,78},30))
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = titleText
title.Parent = topbar
local tabButtonsContainer = Instance.new(_d({53,69,84,81,78,78,75,80,73,40,84,67,79,71},30))
tabButtonsContainer.Size = UDim2.new(1, -20, 0, 30)
tabButtonsContainer.Position = UDim2.new(0, 10, 0, 45)
tabButtonsContainer.BackgroundTransparency = 1
tabButtonsContainer.BorderSizePixel = 0
tabButtonsContainer.ScrollBarThickness = 2
tabButtonsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
tabButtonsContainer.ScrollingDirection = Enum.ScrollingDirection.X
tabButtonsContainer.Parent = main
local tabLayout = Instance.new(_d({55,43,46,75,85,86,46,67,91,81,87,86},30))
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabButtonsContainer
local contentContainer = Instance.new(_d({40,84,67,79,71},30))
contentContainer.Size = UDim2.new(1, -20, 1, -90)
contentContainer.Position = UDim2.new(0, 10, 0, 80)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = main
local Window = {
Main = main,
ScreenGui = screenGui,
Tabs = {},
ActiveTab = nil
}
function Window:AddTab(name)
local tabBtn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
tabBtn.Size = UDim2.new(0, 80, 1, -5)
tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
tabBtn.BorderSizePixel = 0
tabBtn.Font = Enum.Font.GothamMedium
tabBtn.TextSize = 12
tabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
tabBtn.Text = name
tabBtn.Parent = tabButtonsContainer
local btnCorner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = tabBtn
local tabContent = Instance.new(_d({53,69,84,81,78,78,75,80,73,40,84,67,79,71},30))
tabContent.Size = UDim2.new(1, 0, 1, 0)
tabContent.BackgroundTransparency = 1
tabContent.BorderSizePixel = 0
tabContent.ScrollBarThickness = 4
tabContent.Visible = false
tabContent.Parent = contentContainer
local contentLayout = Instance.new(_d({55,43,46,75,85,86,46,67,91,81,87,86},30))
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 6)
contentLayout.Parent = tabContent
local contentPadding = Instance.new(_d({55,43,50,67,70,70,75,80,73},30))
contentPadding.PaddingTop = UDim.new(0, 2)
contentPadding.PaddingBottom = UDim.new(0, 2)
contentPadding.Parent = tabContent
contentLayout:GetPropertyChangedSignal(_d({35,68,85,81,78,87,86,71,37,81,80,86,71,80,86,53,75,92,71},30)):Connect(function()
tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
end)
tabLayout:GetPropertyChangedSignal(_d({35,68,85,81,78,87,86,71,37,81,80,86,71,80,86,53,75,92,71},30)):Connect(function()
tabButtonsContainer.CanvasSize = UDim2.new(0, tabLayout.AbsoluteContentSize.X + 10, 0, 0)
end)
local TabObj = {
Button = tabBtn,
Container = tabContent,
Elements = {}
}
tabBtn.MouseButton1Click:Connect(function()
Window:SelectTab(TabObj)
end)
table.insert(self.Tabs, TabObj)
if #self.Tabs == 1 then
Window:SelectTab(TabObj)
end
function TabObj:AddToggle(text, default, callback)
local state = default or false
local btn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
btn.Size = UDim2.new(1, 0, 0, 36)
btn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
btn.BorderSizePixel = 0
btn.Font = Enum.Font.GothamMedium
btn.TextSize = 13
btn.TextColor3 = Color3.fromRGB(220, 220, 220)
btn.Text = _d({2,2},30) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = self.Container
local btnCorner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = btn
local indicator = Instance.new(_d({40,84,67,79,71},30))
indicator.Size = UDim2.new(0, 16, 0, 16)
indicator.Position = UDim2.new(1, -26, 0.5, -8)
indicator.BackgroundColor3 = state and Color3.fromRGB(80, 200, 80) or Color3.fromRGB(60, 60, 60)
indicator.BorderSizePixel = 0
indicator.Parent = btn
local indCorner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
indCorner.CornerRadius = UDim.new(0, 4)
indCorner.Parent = indicator
btn.MouseButton1Click:Connect(function()
state = not state
indicator.BackgroundColor3 = state and Color3.fromRGB(80, 200, 80) or Color3.fromRGB(60, 60, 60)
if callback then pcall(callback, state) end
end)
return {
Update = function(newVal)
state = newVal
indicator.BackgroundColor3 = state and Color3.fromRGB(80, 200, 80) or Color3.fromRGB(60, 60, 60)
end
}
end
function TabObj:AddCycle(text, options, defaultVal, callback)
local currentIdx = 1
for i, v in ipairs(options) do
if v == defaultVal then currentIdx = i break end
end
local btn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
btn.Size = UDim2.new(1, 0, 0, 36)
btn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
btn.BorderSizePixel = 0
btn.Font = Enum.Font.GothamMedium
btn.TextSize = 13
btn.TextColor3 = Color3.fromRGB(220, 220, 220)
btn.Text = _d({2,2},30) .. text .. _d({28,2},30) .. tostring(options[currentIdx])
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = self.Container
local btnCorner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
currentIdx = currentIdx + 1
if currentIdx > #options then currentIdx = 1 end
btn.Text = _d({2,2},30) .. text .. _d({28,2},30) .. tostring(options[currentIdx])
if callback then pcall(callback, options[currentIdx]) end
end)
return {
Update = function(newVal)
for i, v in ipairs(options) do
if v == newVal then
currentIdx = i
btn.Text = _d({2,2},30) .. text .. _d({28,2},30) .. tostring(options[currentIdx])
break
end
end
end
}
end
function TabObj:AddButton(text, danger, callback)
local btn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
btn.Size = UDim2.new(1, 0, 0, 36)
btn.BackgroundColor3 = danger and Color3.fromRGB(180, 60, 60) or Color3.fromRGB(60, 90, 180)
btn.BorderSizePixel = 0
btn.Font = Enum.Font.GothamBold
btn.TextSize = 13
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = self.Container
local btnCorner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
if callback then pcall(callback) end
end)
end
function TabObj:AddLabel(text)
local lbl = Instance.new(_d({54,71,90,86,46,67,68,71,78},30))
lbl.Size = UDim2.new(1, 0, 0, 26)
lbl.BackgroundTransparency = 1
lbl.Font = Enum.Font.Gotham
lbl.TextSize = 13
lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Text = _d({2,2},30) .. text
lbl.Parent = self.Container
return {
SetText = function(t)
lbl.Text = _d({2,2},30) .. t
end
}
end
return TabObj
end
function Window:SelectTab(tabObj)
if self.ActiveTab then
self.ActiveTab.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
self.ActiveTab.Button.TextColor3 = Color3.fromRGB(150, 150, 150)
self.ActiveTab.Container.Visible = false
end
self.ActiveTab = tabObj
self.ActiveTab.Button.BackgroundColor3 = Color3.fromRGB(60, 90, 180)
self.ActiveTab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
self.ActiveTab.Container.Visible = true
end
local toggleGui = Instance.new(_d({53,69,84,71,71,80,41,87,75},30))
toggleGui.Name = _d({47,81,68,75,78,71,55,43,54,81,73,73,78,71,65},30) .. titleText
toggleGui.ResetOnSpawn = false
toggleGui.Parent = playerGui
local toggleBtn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
toggleBtn.Size = UDim2.new(0, 48, 0, 48)
toggleBtn.Position = UDim2.new(0, 15, 0.45, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 18
toggleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
toggleBtn.Text = "☰"
toggleBtn.Parent = toggleGui
local cornerT = Instance.new(_d({55,43,37,81,84,80,71,84},30))
cornerT.CornerRadius = UDim.new(0, 12)
cornerT.Parent = toggleBtn
local strokeT = Instance.new(_d({55,43,53,86,84,81,77,71},30))
strokeT.Color = Color3.fromRGB(60, 90, 180)
strokeT.Thickness = 2
strokeT.Parent = toggleBtn
toggleBtn.MouseButton1Click:Connect(function()
main.Visible = not main.Visible
end)
function Window:Destroy()
pcall(function() screenGui:Destroy() end)
pcall(function() toggleGui:Destroy() end)
end
return Window
end
return MobileUI
end)()