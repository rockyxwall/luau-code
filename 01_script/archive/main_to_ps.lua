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
local WindUI = loadstring(game:HttpGet(_d({40,52,52,48,51,250,239,239,39,41,52,40,53,34,238,35,47,45,239,6,47,47,52,33,39,37,51,53,51,239,23,41,46,36,21,9,239,50,37,44,37,33,51,37,51,239,44,33,52,37,51,52,239,36,47,55,46,44,47,33,36,239,45,33,41,46,238,44,53,33},64)))()
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local HttpService = game:GetService(_d({8,52,52,48,19,37,50,54,41,35,37},64))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({16,44,33,57,37,50,7,53,41},64))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({5,54,37,46,52,51},64), 10) and ReplicatedStorage.Events:WaitForChild(_d({52,33,43,37,51,52,33,45},64), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({5,54,37,46,52,51},64), 10) and ReplicatedStorage.Events:WaitForChild(_d({50,37,51,37,50,54,37,36},64), 10)
local CONFIG_FILE = _d({22,37,51,48,37,50,31,22,41,48,3,47,46,38,41,39,238,42,51,47,46},64)
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
if success and type(result) == _d({52,33,34,44,37},64) then
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
Title = _d({22,9,16,224,19,37,50,54,37,50,224,13,33,46,33,39,37,50},64),
Icon = _d({51,37,50,54,37,50},64),
Author = _d({34,57,224,22,37,51,48,37,50},64),
Folder = _d({22,37,51,48,37,50,22,41,48,3,47,46,38,41,39},64),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({4,33,50,43},64),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({22,9,16,224,3,47,46,52,50,47,44},64),
Icon = _d({51,40,41,37,44,36},64),
})
Tab:Input({
Title = _d({22,9,16,224,19,37,50,54,37,50,224,3,47,36,37},64),
Desc = _d({3,53,51,52,47,45,224,22,9,16,224,35,47,36,37},64),
Value = config.VipCode or "",
Placeholder = _d({5,46,52,37,50,224,22,9,16,224,35,47,36,37,224,40,37,50,37,238,238,238},64),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({229,51,235},64), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({38,53,46,35,52,41,47,46},64) then
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
local hrp = char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({36,33,51,40},64), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({18,37,45,47,52,37,6,53,46,35,52,41,47,46},64)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({16,50,41,54,33,52,37,19,37,50,54,37,50,51},64)) and PlayerGui.PrivateServers:FindFirstChild(_d({16,50,41,54,33,52,37,19,37,50,54,37,50,51,16,33,46,37,44},64))
if privPanel and privPanel:FindFirstChild(_d({19,37,50,54,37,50,3,47,36,37,2,47,56},64)) and privPanel.ServerCodeBox:FindFirstChild(_d({20,37,56,52,2,47,56},64)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({38,53,46,35,52,41,47,46},64) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({19,52,33,50,52},64))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({13,37,46,53},64)) and startMenu.Menu:FindFirstChild(_d({13,33,41,46},64)) and startMenu.Menu.Main:FindFirstChild(_d({12,41,51,52},64)) and startMenu.Menu.Main.List:FindFirstChild(_d({16,50,41,54,33,52,37,19,37,50,54,37,50,51,2,53,52,52,47,46},64))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({35,40,47,47,51,37,20,57,48,37},64))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({6,50,33,45,37},64)) and chooseType.Frame:FindFirstChild(_d({18,37,45,47,52,37,5,54,37,46,52},64))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({6,50,33,45,37},64)) and chooseType.Frame:FindFirstChild(_d({15,48,52,41,47,46,51},64)) and chooseType.Frame.Options:FindFirstChild(_d({18,37,39,53,44,33,50},64))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({10,47,41,46,224,22,9,16,224,19,37,50,54,37,50},64),
Desc = _d({5,56,37,35,53,52,37,51,224,4,33,51,40,224,237,254,224,16,50,41,54,33,52,37,224,237,254,224,19,37,44,37,35,52,51,224,18,37,39,53,44,33,50,224,237,254,224,10,47,41,46,51},64),
Callback = function()
WindUI:Notify({
Title = _d({3,47,46,46,37,35,52,41,46,39},64),
Content = _d({19,37,44,37,35,52,41,46,39,224,18,37,39,53,44,33,50,224,22,9,16,224,19,37,50,54,37,50,238,238,238},64),
Duration = 2,
Icon = _d({33,50,50,47,55,237,50,41,39,40,52},64),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({1,53,52,47,224,18,37,237,10,47,41,46,224,12,47,47,48},64),
Desc = _d({3,47,46,52,41,46,53,47,53,51,44,57,224,51,37,44,37,35,52,51,224,18,37,39,53,44,33,50,224,22,9,16,224,19,37,50,54,37,50},64),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({10,47,41,46,224,4,37,44,33,57,224,232,19,37,35,47,46,36,51,233},64),
Desc = _d({4,37,44,33,57,224,41,46,52,37,50,54,33,44,224,38,47,50,224,33,53,52,47,224,50,37,42,47,41,46,224,44,47,47,48},64),
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
Title = _d({19,33,54,37,224,3,47,46,38,41,39},64),
Desc = _d({19,33,54,37,224,51,37,52,52,41,46,39,51,224,52,47,224,22,37,51,48,37,50,31,22,41,48,3,47,46,38,41,39,238,42,51,47,46},64),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({3,47,46,38,41,39},64),
Content = _d({3,47,46,38,41,39,53,50,33,52,41,47,46,224,51,33,54,37,36,238},64),
Duration = 2,
Icon = _d({35,40,37,35,43},64),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({35,40,47,47,51,37,20,57,48,37},64))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({6,50,33,45,37},64)) and chooseType.Frame:FindFirstChild(_d({18,37,45,47,52,37,5,54,37,46,52},64))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({6,50,33,45,37},64)) and chooseType.Frame:FindFirstChild(_d({15,48,52,41,47,46,51},64)) and chooseType.Frame.Options:FindFirstChild(_d({18,37,39,53,44,33,50},64))
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