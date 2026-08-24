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
local WindUI = loadstring(game:HttpGet(_d({80,92,92,88,91,34,23,23,79,81,92,80,93,74,22,75,87,85,23,46,87,87,92,73,79,77,91,93,91,23,63,81,86,76,61,49,23,90,77,84,77,73,91,77,91,23,84,73,92,77,91,92,23,76,87,95,86,84,87,73,76,23,85,73,81,86,22,84,93,73},24)))()
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local HttpService = game:GetService(_d({48,92,92,88,59,77,90,94,81,75,77},24))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({56,84,73,97,77,90,47,93,81},24))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({45,94,77,86,92,91},24), 10) and ReplicatedStorage.Events:WaitForChild(_d({92,73,83,77,91,92,73,85},24), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({45,94,77,86,92,91},24), 10) and ReplicatedStorage.Events:WaitForChild(_d({90,77,91,77,90,94,77,76},24), 10)
local CONFIG_FILE = _d({62,77,91,88,77,90,71,62,81,88,43,87,86,78,81,79,22,82,91,87,86},24)
local config = {
VipCode = "",
AutoJoin = false,
RetryInterval = 5,
}
local function loadConfig()
if isfile and isfile(CONFIG_FILE) then
local success, result = pcall(function()
return HttpService:JSONDecode(readfile(CONFIG_FILE))
end)
if success and type(result) == _d({92,73,74,84,77},24) then
for k, v in pairs(result) do
config[k] = v
end
end
end
end
local function saveConfig()
if writefile then
pcall(function()
writefile(CONFIG_FILE, HttpService:JSONEncode(config))
end)
end
end
loadConfig()
local Window = WindUI:CreateWindow({
Title = _d({62,49,56,8,59,77,90,94,77,90,8,53,73,86,73,79,77,90},24),
Icon = _d({91,77,90,94,77,90},24),
Author = _d({74,97,8,62,77,91,88,77,90},24),
Folder = _d({62,77,91,88,77,90,62,81,88,43,87,86,78,81,79},24),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({44,73,90,83},24),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({62,49,56,8,43,87,86,92,90,87,84},24),
Icon = _d({91,80,81,77,84,76},24),
})
Tab:Input({
Title = _d({62,49,56,8,59,77,90,94,77,90,8,43,87,76,77},24),
Desc = _d({43,93,91,92,87,85,8,62,49,56,8,75,87,76,77},24),
Value = config.VipCode or "",
Placeholder = _d({45,86,92,77,90,8,62,49,56,8,75,87,76,77,8,80,77,90,77,22,22,22},24),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({13,91,19},24), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({78,93,86,75,92,81,87,86},24) then
if btn.MouseButton1Click then firesignal(btn.MouseButton1Click) end
if btn.Activated then firesignal(btn.Activated) end
if btn.MouseButton1Down then firesignal(btn.MouseButton1Down) end
if btn.MouseButton1Up then firesignal(btn.MouseButton1Up) end
return true
end
return false
end
local function triggerFullVipJoin()
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({76,73,91,80},24), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({58,77,85,87,92,77,46,93,86,75,92,81,87,86},24)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({56,90,81,94,73,92,77,59,77,90,94,77,90,91},24)) and PlayerGui.PrivateServers:FindFirstChild(_d({56,90,81,94,73,92,77,59,77,90,94,77,90,91,56,73,86,77,84},24))
if privPanel and privPanel:FindFirstChild(_d({59,77,90,94,77,90,43,87,76,77,42,87,96},24)) and privPanel.ServerCodeBox:FindFirstChild(_d({60,77,96,92,42,87,96},24)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({78,93,86,75,92,81,87,86},24) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({59,92,73,90,92},24))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({53,77,86,93},24)) and startMenu.Menu:FindFirstChild(_d({53,73,81,86},24)) and startMenu.Menu.Main:FindFirstChild(_d({52,81,91,92},24)) and startMenu.Menu.Main.List:FindFirstChild(_d({56,90,81,94,73,92,77,59,77,90,94,77,90,91,42,93,92,92,87,86},24))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({75,80,87,87,91,77,60,97,88,77},24))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({46,90,73,85,77},24)) and chooseType.Frame:FindFirstChild(_d({58,77,85,87,92,77,45,94,77,86,92},24))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({46,90,73,85,77},24)) and chooseType.Frame:FindFirstChild(_d({55,88,92,81,87,86,91},24)) and chooseType.Frame.Options:FindFirstChild(_d({58,77,79,93,84,73,90},24))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({50,87,81,86,8,62,49,56,8,59,77,90,94,77,90},24),
Desc = _d({45,96,77,75,93,92,77,91,8,44,73,91,80,8,21,38,8,56,90,81,94,73,92,77,8,21,38,8,59,77,84,77,75,92,91,8,58,77,79,93,84,73,90,8,21,38,8,50,87,81,86,91},24),
Callback = function()
WindUI:Notify({
Title = _d({43,87,86,86,77,75,92,81,86,79},24),
Content = _d({59,77,84,77,75,92,81,86,79,8,58,77,79,93,84,73,90,8,62,49,56,8,59,77,90,94,77,90,22,22,22},24),
Duration = 2,
Icon = _d({73,90,90,87,95,21,90,81,79,80,92},24),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({41,93,92,87,8,58,77,21,50,87,81,86,8,52,87,87,88},24),
Desc = _d({43,87,86,92,81,86,93,87,93,91,84,97,8,91,77,84,77,75,92,91,8,58,77,79,93,84,73,90,8,62,49,56,8,59,77,90,94,77,90},24),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({50,87,81,86,8,44,77,84,73,97,8,16,59,77,75,87,86,76,91,17},24),
Desc = _d({44,77,84,73,97,8,81,86,92,77,90,94,73,84,8,78,87,90,8,73,93,92,87,8,90,77,82,87,81,86,8,84,87,87,88},24),
Value = {
Min = 2,
Max = 20,
Default = config.RetryInterval or 5,
},
Callback = function(val)
config.RetryInterval = val
saveConfig()
end,
})
Tab:Button({
Title = _d({59,73,94,77,8,43,87,86,78,81,79},24),
Desc = _d({59,73,94,77,8,91,77,92,92,81,86,79,91,8,92,87,8,62,77,91,88,77,90,71,62,81,88,43,87,86,78,81,79,22,82,91,87,86},24),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({43,87,86,78,81,79},24),
Content = _d({43,87,86,78,81,79,93,90,73,92,81,87,86,8,91,73,94,77,76,22},24),
Duration = 2,
Icon = _d({75,80,77,75,83},24),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({75,80,87,87,91,77,60,97,88,77},24))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({46,90,73,85,77},24)) and chooseType.Frame:FindFirstChild(_d({58,77,85,87,92,77,45,94,77,86,92},24))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({46,90,73,85,77},24)) and chooseType.Frame:FindFirstChild(_d({55,88,92,81,87,86,91},24)) and chooseType.Frame.Options:FindFirstChild(_d({58,77,79,93,84,73,90},24))
if regBtn then
clickGuiButton(regBtn)
end
end
task.wait(0.2)
end
end)
task.spawn(function()
while true do
if config.AutoJoin then
triggerFullVipJoin()
task.wait(config.RetryInterval or 5)
else
task.wait(0.5)
end
end
end)
end)()