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
local WindUI = loadstring(game:HttpGet(_d({84,96,96,92,95,38,27,27,83,85,96,84,97,78,26,79,91,89,27,50,91,91,96,77,83,81,95,97,95,27,67,85,90,80,65,53,27,94,81,88,81,77,95,81,95,27,88,77,96,81,95,96,27,80,91,99,90,88,91,77,80,27,89,77,85,90,26,88,97,77},20)))()
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local HttpService = game:GetService(_d({52,96,96,92,63,81,94,98,85,79,81},20))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({49,98,81,90,96,95},20), 10) and ReplicatedStorage.Events:WaitForChild(_d({96,77,87,81,95,96,77,89},20), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({49,98,81,90,96,95},20), 10) and ReplicatedStorage.Events:WaitForChild(_d({94,81,95,81,94,98,81,80},20), 10)
local CONFIG_FILE = _d({66,81,95,92,81,94,75,66,85,92,47,91,90,82,85,83,26,86,95,91,90},20)
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
if success and type(result) == _d({96,77,78,88,81},20) then
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
Title = _d({66,53,60,12,63,81,94,98,81,94,12,57,77,90,77,83,81,94},20),
Icon = _d({95,81,94,98,81,94},20),
Author = _d({78,101,12,66,81,95,92,81,94},20),
Folder = _d({66,81,95,92,81,94,66,85,92,47,91,90,82,85,83},20),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({48,77,94,87},20),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({66,53,60,12,47,91,90,96,94,91,88},20),
Icon = _d({95,84,85,81,88,80},20),
})
Tab:Input({
Title = _d({66,53,60,12,63,81,94,98,81,94,12,47,91,80,81},20),
Desc = _d({47,97,95,96,91,89,12,66,53,60,12,79,91,80,81},20),
Value = config.VipCode or "",
Placeholder = _d({49,90,96,81,94,12,66,53,60,12,79,91,80,81,12,84,81,94,81,26,26,26},20),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({17,95,23},20), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({82,97,90,79,96,85,91,90},20) then
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
local hrp = char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({80,77,95,84},20), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({62,81,89,91,96,81,50,97,90,79,96,85,91,90},20)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({60,94,85,98,77,96,81,63,81,94,98,81,94,95},20)) and PlayerGui.PrivateServers:FindFirstChild(_d({60,94,85,98,77,96,81,63,81,94,98,81,94,95,60,77,90,81,88},20))
if privPanel and privPanel:FindFirstChild(_d({63,81,94,98,81,94,47,91,80,81,46,91,100},20)) and privPanel.ServerCodeBox:FindFirstChild(_d({64,81,100,96,46,91,100},20)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({82,97,90,79,96,85,91,90},20) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({63,96,77,94,96},20))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({57,81,90,97},20)) and startMenu.Menu:FindFirstChild(_d({57,77,85,90},20)) and startMenu.Menu.Main:FindFirstChild(_d({56,85,95,96},20)) and startMenu.Menu.Main.List:FindFirstChild(_d({60,94,85,98,77,96,81,63,81,94,98,81,94,95,46,97,96,96,91,90},20))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({79,84,91,91,95,81,64,101,92,81},20))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({50,94,77,89,81},20)) and chooseType.Frame:FindFirstChild(_d({62,81,89,91,96,81,49,98,81,90,96},20))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({50,94,77,89,81},20)) and chooseType.Frame:FindFirstChild(_d({59,92,96,85,91,90,95},20)) and chooseType.Frame.Options:FindFirstChild(_d({62,81,83,97,88,77,94},20))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({54,91,85,90,12,66,53,60,12,63,81,94,98,81,94},20),
Desc = _d({49,100,81,79,97,96,81,95,12,48,77,95,84,12,25,42,12,60,94,85,98,77,96,81,12,25,42,12,63,81,88,81,79,96,95,12,62,81,83,97,88,77,94,12,25,42,12,54,91,85,90,95},20),
Callback = function()
WindUI:Notify({
Title = _d({47,91,90,90,81,79,96,85,90,83},20),
Content = _d({63,81,88,81,79,96,85,90,83,12,62,81,83,97,88,77,94,12,66,53,60,12,63,81,94,98,81,94,26,26,26},20),
Duration = 2,
Icon = _d({77,94,94,91,99,25,94,85,83,84,96},20),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({45,97,96,91,12,62,81,25,54,91,85,90,12,56,91,91,92},20),
Desc = _d({47,91,90,96,85,90,97,91,97,95,88,101,12,95,81,88,81,79,96,95,12,62,81,83,97,88,77,94,12,66,53,60,12,63,81,94,98,81,94},20),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({54,91,85,90,12,48,81,88,77,101,12,20,63,81,79,91,90,80,95,21},20),
Desc = _d({48,81,88,77,101,12,85,90,96,81,94,98,77,88,12,82,91,94,12,77,97,96,91,12,94,81,86,91,85,90,12,88,91,91,92},20),
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
Title = _d({63,77,98,81,12,47,91,90,82,85,83},20),
Desc = _d({63,77,98,81,12,95,81,96,96,85,90,83,95,12,96,91,12,66,81,95,92,81,94,75,66,85,92,47,91,90,82,85,83,26,86,95,91,90},20),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({47,91,90,82,85,83},20),
Content = _d({47,91,90,82,85,83,97,94,77,96,85,91,90,12,95,77,98,81,80,26},20),
Duration = 2,
Icon = _d({79,84,81,79,87},20),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({79,84,91,91,95,81,64,101,92,81},20))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({50,94,77,89,81},20)) and chooseType.Frame:FindFirstChild(_d({62,81,89,91,96,81,49,98,81,90,96},20))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({50,94,77,89,81},20)) and chooseType.Frame:FindFirstChild(_d({59,92,96,85,91,90,95},20)) and chooseType.Frame.Options:FindFirstChild(_d({62,81,83,97,88,77,94},20))
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