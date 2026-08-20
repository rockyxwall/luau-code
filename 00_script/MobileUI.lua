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
local CoreGui = game:GetService(_d({4,48,51,38,8,54,42},63))
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local LocalPlayer = Players.LocalPlayer
function MobileUI.CreateWindow(config)
local titleText = config.Title or _d({14,38,47,54},63)
local secureParent
if gethui then
secureParent = gethui()
elseif syn and syn.protect_gui then
secureParent = CoreGui
else
secureParent = CoreGui
end
local oldUI = secureParent:FindFirstChild(_d({14,48,35,42,45,38,22,10,32},63) .. titleText)
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({20,36,51,38,38,47,8,54,42},63))
screenGui.Name = _d({14,48,35,42,45,38,22,10,32},63) .. titleText
screenGui.ResetOnSpawn = false
screenGui.Parent = secureParent
if syn and syn.protect_gui then
pcall(syn.protect_gui, screenGui)
end
local main = Instance.new(_d({7,51,34,46,38},63))
main.Size = UDim2.new(0, 300, 0, 400)
main.Position = UDim2.new(0.5, -150, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true
main.Parent = screenGui
local corner = Instance.new(_d({22,10,4,48,51,47,38,51},63))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local topbar = Instance.new(_d({7,51,34,46,38},63))
topbar.Size = UDim2.new(1, 0, 0, 40)
topbar.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
topbar.BorderSizePixel = 0
topbar.Parent = main
local topCorner = Instance.new(_d({22,10,4,48,51,47,38,51},63))
topCorner.CornerRadius = UDim.new(0, 8)
topCorner.Parent = topbar
local topbarBlock = Instance.new(_d({7,51,34,46,38},63))
topbarBlock.Size = UDim2.new(1, 0, 0, 10)
topbarBlock.Position = UDim2.new(0, 0, 1, -10)
topbarBlock.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
topbarBlock.BorderSizePixel = 0
topbarBlock.Parent = topbar
local title = Instance.new(_d({21,38,57,53,13,34,35,38,45},63))
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = titleText
title.Parent = topbar
local tabButtonsContainer = Instance.new(_d({20,36,51,48,45,45,42,47,40,7,51,34,46,38},63))
tabButtonsContainer.Size = UDim2.new(1, -20, 0, 30)
tabButtonsContainer.Position = UDim2.new(0, 10, 0, 45)
tabButtonsContainer.BackgroundTransparency = 1
tabButtonsContainer.BorderSizePixel = 0
tabButtonsContainer.ScrollBarThickness = 2
tabButtonsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
tabButtonsContainer.ScrollingDirection = Enum.ScrollingDirection.X
tabButtonsContainer.Parent = main
local tabLayout = Instance.new(_d({22,10,13,42,52,53,13,34,58,48,54,53},63))
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabButtonsContainer
local contentContainer = Instance.new(_d({7,51,34,46,38},63))
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
local tabBtn = Instance.new(_d({21,38,57,53,3,54,53,53,48,47},63))
tabBtn.Size = UDim2.new(0, 80, 1, -5)
tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
tabBtn.BorderSizePixel = 0
tabBtn.Font = Enum.Font.GothamMedium
tabBtn.TextSize = 12
tabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
tabBtn.Text = name
tabBtn.Parent = tabButtonsContainer
local btnCorner = Instance.new(_d({22,10,4,48,51,47,38,51},63))
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = tabBtn
local tabContent = Instance.new(_d({20,36,51,48,45,45,42,47,40,7,51,34,46,38},63))
tabContent.Size = UDim2.new(1, 0, 1, 0)
tabContent.BackgroundTransparency = 1
tabContent.BorderSizePixel = 0
tabContent.ScrollBarThickness = 4
tabContent.Visible = false
tabContent.Parent = contentContainer
local contentLayout = Instance.new(_d({22,10,13,42,52,53,13,34,58,48,54,53},63))
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 6)
contentLayout.Parent = tabContent
local contentPadding = Instance.new(_d({22,10,17,34,37,37,42,47,40},63))
contentPadding.PaddingTop = UDim.new(0, 2)
contentPadding.PaddingBottom = UDim.new(0, 2)
contentPadding.Parent = tabContent
contentLayout:GetPropertyChangedSignal(_d({2,35,52,48,45,54,53,38,4,48,47,53,38,47,53,20,42,59,38},63)):Connect(function()
tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
end)
tabLayout:GetPropertyChangedSignal(_d({2,35,52,48,45,54,53,38,4,48,47,53,38,47,53,20,42,59,38},63)):Connect(function()
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
local btn = Instance.new(_d({21,38,57,53,3,54,53,53,48,47},63))
btn.Size = UDim2.new(1, 0, 0, 36)
btn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
btn.BorderSizePixel = 0
btn.Font = Enum.Font.GothamMedium
btn.TextSize = 13
btn.TextColor3 = Color3.fromRGB(220, 220, 220)
btn.Text = _d({225,225},63) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = self.Container
local btnCorner = Instance.new(_d({22,10,4,48,51,47,38,51},63))
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = btn
local indicator = Instance.new(_d({7,51,34,46,38},63))
indicator.Size = UDim2.new(0, 16, 0, 16)
indicator.Position = UDim2.new(1, -26, 0.5, -8)
indicator.BackgroundColor3 = state and Color3.fromRGB(80, 200, 80) or Color3.fromRGB(60, 60, 60)
indicator.BorderSizePixel = 0
indicator.Parent = btn
local indCorner = Instance.new(_d({22,10,4,48,51,47,38,51},63))
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
local btn = Instance.new(_d({21,38,57,53,3,54,53,53,48,47},63))
btn.Size = UDim2.new(1, 0, 0, 36)
btn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
btn.BorderSizePixel = 0
btn.Font = Enum.Font.GothamMedium
btn.TextSize = 13
btn.TextColor3 = Color3.fromRGB(220, 220, 220)
btn.Text = _d({225,225},63) .. text .. _d({251,225},63) .. tostring(options[currentIdx])
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = self.Container
local btnCorner = Instance.new(_d({22,10,4,48,51,47,38,51},63))
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
currentIdx = currentIdx + 1
if currentIdx > #options then currentIdx = 1 end
btn.Text = _d({225,225},63) .. text .. _d({251,225},63) .. tostring(options[currentIdx])
if callback then pcall(callback, options[currentIdx]) end
end)
return {
Update = function(newVal)
for i, v in ipairs(options) do
if v == newVal then
currentIdx = i
btn.Text = _d({225,225},63) .. text .. _d({251,225},63) .. tostring(options[currentIdx])
break
end
end
end
}
end
function TabObj:AddButton(text, danger, callback)
local btn = Instance.new(_d({21,38,57,53,3,54,53,53,48,47},63))
btn.Size = UDim2.new(1, 0, 0, 36)
btn.BackgroundColor3 = danger and Color3.fromRGB(180, 60, 60) or Color3.fromRGB(60, 90, 180)
btn.BorderSizePixel = 0
btn.Font = Enum.Font.GothamBold
btn.TextSize = 13
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = text
btn.Parent = self.Container
local btnCorner = Instance.new(_d({22,10,4,48,51,47,38,51},63))
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = btn
btn.MouseButton1Click:Connect(function()
if callback then pcall(callback) end
end)
end
function TabObj:AddLabel(text)
local lbl = Instance.new(_d({21,38,57,53,13,34,35,38,45},63))
lbl.Size = UDim2.new(1, 0, 0, 26)
lbl.BackgroundTransparency = 1
lbl.Font = Enum.Font.Gotham
lbl.TextSize = 13
lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Text = _d({225,225},63) .. text
lbl.Parent = self.Container
return {
SetText = function(t)
lbl.Text = _d({225,225},63) .. t
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
local toggleGui = Instance.new(_d({20,36,51,38,38,47,8,54,42},63))
toggleGui.Name = _d({14,48,35,42,45,38,22,10,21,48,40,40,45,38,32},63) .. titleText
toggleGui.ResetOnSpawn = false
toggleGui.Parent = secureParent
if syn and syn.protect_gui then
pcall(syn.protect_gui, toggleGui)
end
local toggleBtn = Instance.new(_d({21,38,57,53,3,54,53,53,48,47},63))
toggleBtn.Size = UDim2.new(0, 48, 0, 48)
toggleBtn.Position = UDim2.new(0, 15, 0.45, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 18
toggleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
toggleBtn.Text = "☰"
toggleBtn.Parent = toggleGui
local cornerT = Instance.new(_d({22,10,4,48,51,47,38,51},63))
cornerT.CornerRadius = UDim.new(0, 12)
cornerT.Parent = toggleBtn
local strokeT = Instance.new(_d({22,10,20,53,51,48,44,38},63))
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