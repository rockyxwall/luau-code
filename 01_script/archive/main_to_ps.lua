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
local WindUI = loadstring(game:HttpGet(_d({79,91,91,87,90,33,22,22,78,80,91,79,92,73,21,74,86,84,22,45,86,86,91,72,78,76,90,92,90,22,62,80,85,75,60,48,22,89,76,83,76,72,90,76,90,22,83,72,91,76,90,91,22,75,86,94,85,83,86,72,75,22,84,72,80,85,21,83,92,72},25)))()
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
local ReplicatedStorage = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local HttpService = game:GetService(_d({47,91,91,87,58,76,89,93,80,74,76},25))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({55,83,72,96,76,89,46,92,80},25))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({44,93,76,85,91,90},25), 10) and ReplicatedStorage.Events:WaitForChild(_d({91,72,82,76,90,91,72,84},25), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({44,93,76,85,91,90},25), 10) and ReplicatedStorage.Events:WaitForChild(_d({89,76,90,76,89,93,76,75},25), 10)
local CONFIG_FILE = _d({61,76,90,87,76,89,70,61,80,87,42,86,85,77,80,78,21,81,90,86,85},25)
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
if success and type(result) == _d({91,72,73,83,76},25) then
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
Title = _d({61,48,55,7,58,76,89,93,76,89,7,52,72,85,72,78,76,89},25),
Icon = _d({90,76,89,93,76,89},25),
Author = _d({73,96,7,61,76,90,87,76,89},25),
Folder = _d({61,76,90,87,76,89,61,80,87,42,86,85,77,80,78},25),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({43,72,89,82},25),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({61,48,55,7,42,86,85,91,89,86,83},25),
Icon = _d({90,79,80,76,83,75},25),
})
Tab:Input({
Title = _d({61,48,55,7,58,76,89,93,76,89,7,42,86,75,76},25),
Desc = _d({42,92,90,91,86,84,7,61,48,55,7,74,86,75,76},25),
Value = config.VipCode or "",
Placeholder = _d({44,85,91,76,89,7,61,48,55,7,74,86,75,76,7,79,76,89,76,21,21,21},25),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({12,90,18},25), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({77,92,85,74,91,80,86,85},25) then
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
local hrp = char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({75,72,90,79},25), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({57,76,84,86,91,76,45,92,85,74,91,80,86,85},25)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({55,89,80,93,72,91,76,58,76,89,93,76,89,90},25)) and PlayerGui.PrivateServers:FindFirstChild(_d({55,89,80,93,72,91,76,58,76,89,93,76,89,90,55,72,85,76,83},25))
if privPanel and privPanel:FindFirstChild(_d({58,76,89,93,76,89,42,86,75,76,41,86,95},25)) and privPanel.ServerCodeBox:FindFirstChild(_d({59,76,95,91,41,86,95},25)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({77,92,85,74,91,80,86,85},25) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({58,91,72,89,91},25))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({52,76,85,92},25)) and startMenu.Menu:FindFirstChild(_d({52,72,80,85},25)) and startMenu.Menu.Main:FindFirstChild(_d({51,80,90,91},25)) and startMenu.Menu.Main.List:FindFirstChild(_d({55,89,80,93,72,91,76,58,76,89,93,76,89,90,41,92,91,91,86,85},25))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({74,79,86,86,90,76,59,96,87,76},25))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({45,89,72,84,76},25)) and chooseType.Frame:FindFirstChild(_d({57,76,84,86,91,76,44,93,76,85,91},25))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({45,89,72,84,76},25)) and chooseType.Frame:FindFirstChild(_d({54,87,91,80,86,85,90},25)) and chooseType.Frame.Options:FindFirstChild(_d({57,76,78,92,83,72,89},25))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({49,86,80,85,7,61,48,55,7,58,76,89,93,76,89},25),
Desc = _d({44,95,76,74,92,91,76,90,7,43,72,90,79,7,20,37,7,55,89,80,93,72,91,76,7,20,37,7,58,76,83,76,74,91,90,7,57,76,78,92,83,72,89,7,20,37,7,49,86,80,85,90},25),
Callback = function()
WindUI:Notify({
Title = _d({42,86,85,85,76,74,91,80,85,78},25),
Content = _d({58,76,83,76,74,91,80,85,78,7,57,76,78,92,83,72,89,7,61,48,55,7,58,76,89,93,76,89,21,21,21},25),
Duration = 2,
Icon = _d({72,89,89,86,94,20,89,80,78,79,91},25),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({40,92,91,86,7,57,76,20,49,86,80,85,7,51,86,86,87},25),
Desc = _d({42,86,85,91,80,85,92,86,92,90,83,96,7,90,76,83,76,74,91,90,7,57,76,78,92,83,72,89,7,61,48,55,7,58,76,89,93,76,89},25),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({49,86,80,85,7,43,76,83,72,96,7,15,58,76,74,86,85,75,90,16},25),
Desc = _d({43,76,83,72,96,7,80,85,91,76,89,93,72,83,7,77,86,89,7,72,92,91,86,7,89,76,81,86,80,85,7,83,86,86,87},25),
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
Title = _d({58,72,93,76,7,42,86,85,77,80,78},25),
Desc = _d({58,72,93,76,7,90,76,91,91,80,85,78,90,7,91,86,7,61,76,90,87,76,89,70,61,80,87,42,86,85,77,80,78,21,81,90,86,85},25),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({42,86,85,77,80,78},25),
Content = _d({42,86,85,77,80,78,92,89,72,91,80,86,85,7,90,72,93,76,75,21},25),
Duration = 2,
Icon = _d({74,79,76,74,82},25),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({74,79,86,86,90,76,59,96,87,76},25))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({45,89,72,84,76},25)) and chooseType.Frame:FindFirstChild(_d({57,76,84,86,91,76,44,93,76,85,91},25))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({45,89,72,84,76},25)) and chooseType.Frame:FindFirstChild(_d({54,87,91,80,86,85,90},25)) and chooseType.Frame.Options:FindFirstChild(_d({57,76,78,92,83,72,89},25))
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