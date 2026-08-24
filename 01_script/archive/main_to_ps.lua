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
local WindUI = loadstring(game:HttpGet(_d({43,55,55,51,54,253,242,242,42,44,55,43,56,37,241,38,50,48,242,9,50,50,55,36,42,40,54,56,54,242,26,44,49,39,24,12,242,53,40,47,40,36,54,40,54,242,47,36,55,40,54,55,242,39,50,58,49,47,50,36,39,242,48,36,44,49,241,47,56,36},61)))()
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local HttpService = game:GetService(_d({11,55,55,51,22,40,53,57,44,38,40},61))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({19,47,36,60,40,53,10,56,44},61))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({8,57,40,49,55,54},61), 10) and ReplicatedStorage.Events:WaitForChild(_d({55,36,46,40,54,55,36,48},61), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({8,57,40,49,55,54},61), 10) and ReplicatedStorage.Events:WaitForChild(_d({53,40,54,40,53,57,40,39},61), 10)
local CONFIG_FILE = _d({25,40,54,51,40,53,34,25,44,51,6,50,49,41,44,42,241,45,54,50,49},61)
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
if success and type(result) == _d({55,36,37,47,40},61) then
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
Title = _d({25,12,19,227,22,40,53,57,40,53,227,16,36,49,36,42,40,53},61),
Icon = _d({54,40,53,57,40,53},61),
Author = _d({37,60,227,25,40,54,51,40,53},61),
Folder = _d({25,40,54,51,40,53,25,44,51,6,50,49,41,44,42},61),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({7,36,53,46},61),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({25,12,19,227,6,50,49,55,53,50,47},61),
Icon = _d({54,43,44,40,47,39},61),
})
Tab:Input({
Title = _d({25,12,19,227,22,40,53,57,40,53,227,6,50,39,40},61),
Desc = _d({6,56,54,55,50,48,227,25,12,19,227,38,50,39,40},61),
Value = config.VipCode or "",
Placeholder = _d({8,49,55,40,53,227,25,12,19,227,38,50,39,40,227,43,40,53,40,241,241,241},61),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({232,54,238},61), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({41,56,49,38,55,44,50,49},61) then
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
local hrp = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({39,36,54,43},61), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({21,40,48,50,55,40,9,56,49,38,55,44,50,49},61)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({19,53,44,57,36,55,40,22,40,53,57,40,53,54},61)) and PlayerGui.PrivateServers:FindFirstChild(_d({19,53,44,57,36,55,40,22,40,53,57,40,53,54,19,36,49,40,47},61))
if privPanel and privPanel:FindFirstChild(_d({22,40,53,57,40,53,6,50,39,40,5,50,59},61)) and privPanel.ServerCodeBox:FindFirstChild(_d({23,40,59,55,5,50,59},61)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({41,56,49,38,55,44,50,49},61) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({22,55,36,53,55},61))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({16,40,49,56},61)) and startMenu.Menu:FindFirstChild(_d({16,36,44,49},61)) and startMenu.Menu.Main:FindFirstChild(_d({15,44,54,55},61)) and startMenu.Menu.Main.List:FindFirstChild(_d({19,53,44,57,36,55,40,22,40,53,57,40,53,54,5,56,55,55,50,49},61))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({38,43,50,50,54,40,23,60,51,40},61))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({9,53,36,48,40},61)) and chooseType.Frame:FindFirstChild(_d({21,40,48,50,55,40,8,57,40,49,55},61))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({9,53,36,48,40},61)) and chooseType.Frame:FindFirstChild(_d({18,51,55,44,50,49,54},61)) and chooseType.Frame.Options:FindFirstChild(_d({21,40,42,56,47,36,53},61))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({13,50,44,49,227,25,12,19,227,22,40,53,57,40,53},61),
Desc = _d({8,59,40,38,56,55,40,54,227,7,36,54,43,227,240,1,227,19,53,44,57,36,55,40,227,240,1,227,22,40,47,40,38,55,54,227,21,40,42,56,47,36,53,227,240,1,227,13,50,44,49,54},61),
Callback = function()
WindUI:Notify({
Title = _d({6,50,49,49,40,38,55,44,49,42},61),
Content = _d({22,40,47,40,38,55,44,49,42,227,21,40,42,56,47,36,53,227,25,12,19,227,22,40,53,57,40,53,241,241,241},61),
Duration = 2,
Icon = _d({36,53,53,50,58,240,53,44,42,43,55},61),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({4,56,55,50,227,21,40,240,13,50,44,49,227,15,50,50,51},61),
Desc = _d({6,50,49,55,44,49,56,50,56,54,47,60,227,54,40,47,40,38,55,54,227,21,40,42,56,47,36,53,227,25,12,19,227,22,40,53,57,40,53},61),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({13,50,44,49,227,7,40,47,36,60,227,235,22,40,38,50,49,39,54,236},61),
Desc = _d({7,40,47,36,60,227,44,49,55,40,53,57,36,47,227,41,50,53,227,36,56,55,50,227,53,40,45,50,44,49,227,47,50,50,51},61),
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
Title = _d({22,36,57,40,227,6,50,49,41,44,42},61),
Desc = _d({22,36,57,40,227,54,40,55,55,44,49,42,54,227,55,50,227,25,40,54,51,40,53,34,25,44,51,6,50,49,41,44,42,241,45,54,50,49},61),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({6,50,49,41,44,42},61),
Content = _d({6,50,49,41,44,42,56,53,36,55,44,50,49,227,54,36,57,40,39,241},61),
Duration = 2,
Icon = _d({38,43,40,38,46},61),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({38,43,50,50,54,40,23,60,51,40},61))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({9,53,36,48,40},61)) and chooseType.Frame:FindFirstChild(_d({21,40,48,50,55,40,8,57,40,49,55},61))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({9,53,36,48,40},61)) and chooseType.Frame:FindFirstChild(_d({18,51,55,44,50,49,54},61)) and chooseType.Frame.Options:FindFirstChild(_d({21,40,42,56,47,36,53},61))
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