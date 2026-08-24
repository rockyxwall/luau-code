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
local WindUI = loadstring(game:HttpGet(_d({51,63,63,59,62,5,250,250,50,52,63,51,64,45,249,46,58,56,250,17,58,58,63,44,50,48,62,64,62,250,34,52,57,47,32,20,250,61,48,55,48,44,62,48,62,250,55,44,63,48,62,63,250,47,58,66,57,55,58,44,47,250,56,44,52,57,249,55,64,44},53)))()
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local ReplicatedStorage = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local HttpService = game:GetService(_d({19,63,63,59,30,48,61,65,52,46,48},53))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({27,55,44,68,48,61,18,64,52},53))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({16,65,48,57,63,62},53), 10) and ReplicatedStorage.Events:WaitForChild(_d({63,44,54,48,62,63,44,56},53), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({16,65,48,57,63,62},53), 10) and ReplicatedStorage.Events:WaitForChild(_d({61,48,62,48,61,65,48,47},53), 10)
local CONFIG_FILE = _d({33,48,62,59,48,61,42,33,52,59,14,58,57,49,52,50,249,53,62,58,57},53)
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
if success and type(result) == _d({63,44,45,55,48},53) then
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
Title = _d({33,20,27,235,30,48,61,65,48,61,235,24,44,57,44,50,48,61},53),
Icon = _d({62,48,61,65,48,61},53),
Author = _d({45,68,235,33,48,62,59,48,61},53),
Folder = _d({33,48,62,59,48,61,33,52,59,14,58,57,49,52,50},53),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({15,44,61,54},53),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({33,20,27,235,14,58,57,63,61,58,55},53),
Icon = _d({62,51,52,48,55,47},53),
})
Tab:Input({
Title = _d({33,20,27,235,30,48,61,65,48,61,235,14,58,47,48},53),
Desc = _d({14,64,62,63,58,56,235,33,20,27,235,46,58,47,48},53),
Value = config.VipCode or "",
Placeholder = _d({16,57,63,48,61,235,33,20,27,235,46,58,47,48,235,51,48,61,48,249,249,249},53),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({240,62,246},53), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({49,64,57,46,63,52,58,57},53) then
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
local hrp = char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({47,44,62,51},53), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({29,48,56,58,63,48,17,64,57,46,63,52,58,57},53)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({27,61,52,65,44,63,48,30,48,61,65,48,61,62},53)) and PlayerGui.PrivateServers:FindFirstChild(_d({27,61,52,65,44,63,48,30,48,61,65,48,61,62,27,44,57,48,55},53))
if privPanel and privPanel:FindFirstChild(_d({30,48,61,65,48,61,14,58,47,48,13,58,67},53)) and privPanel.ServerCodeBox:FindFirstChild(_d({31,48,67,63,13,58,67},53)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({49,64,57,46,63,52,58,57},53) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({30,63,44,61,63},53))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({24,48,57,64},53)) and startMenu.Menu:FindFirstChild(_d({24,44,52,57},53)) and startMenu.Menu.Main:FindFirstChild(_d({23,52,62,63},53)) and startMenu.Menu.Main.List:FindFirstChild(_d({27,61,52,65,44,63,48,30,48,61,65,48,61,62,13,64,63,63,58,57},53))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({46,51,58,58,62,48,31,68,59,48},53))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({17,61,44,56,48},53)) and chooseType.Frame:FindFirstChild(_d({29,48,56,58,63,48,16,65,48,57,63},53))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({17,61,44,56,48},53)) and chooseType.Frame:FindFirstChild(_d({26,59,63,52,58,57,62},53)) and chooseType.Frame.Options:FindFirstChild(_d({29,48,50,64,55,44,61},53))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({21,58,52,57,235,33,20,27,235,30,48,61,65,48,61},53),
Desc = _d({16,67,48,46,64,63,48,62,235,15,44,62,51,235,248,9,235,27,61,52,65,44,63,48,235,248,9,235,30,48,55,48,46,63,62,235,29,48,50,64,55,44,61,235,248,9,235,21,58,52,57,62},53),
Callback = function()
WindUI:Notify({
Title = _d({14,58,57,57,48,46,63,52,57,50},53),
Content = _d({30,48,55,48,46,63,52,57,50,235,29,48,50,64,55,44,61,235,33,20,27,235,30,48,61,65,48,61,249,249,249},53),
Duration = 2,
Icon = _d({44,61,61,58,66,248,61,52,50,51,63},53),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({12,64,63,58,235,29,48,248,21,58,52,57,235,23,58,58,59},53),
Desc = _d({14,58,57,63,52,57,64,58,64,62,55,68,235,62,48,55,48,46,63,62,235,29,48,50,64,55,44,61,235,33,20,27,235,30,48,61,65,48,61},53),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({21,58,52,57,235,15,48,55,44,68,235,243,30,48,46,58,57,47,62,244},53),
Desc = _d({15,48,55,44,68,235,52,57,63,48,61,65,44,55,235,49,58,61,235,44,64,63,58,235,61,48,53,58,52,57,235,55,58,58,59},53),
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
Title = _d({30,44,65,48,235,14,58,57,49,52,50},53),
Desc = _d({30,44,65,48,235,62,48,63,63,52,57,50,62,235,63,58,235,33,48,62,59,48,61,42,33,52,59,14,58,57,49,52,50,249,53,62,58,57},53),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({14,58,57,49,52,50},53),
Content = _d({14,58,57,49,52,50,64,61,44,63,52,58,57,235,62,44,65,48,47,249},53),
Duration = 2,
Icon = _d({46,51,48,46,54},53),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({46,51,58,58,62,48,31,68,59,48},53))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({17,61,44,56,48},53)) and chooseType.Frame:FindFirstChild(_d({29,48,56,58,63,48,16,65,48,57,63},53))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({17,61,44,56,48},53)) and chooseType.Frame:FindFirstChild(_d({26,59,63,52,58,57,62},53)) and chooseType.Frame.Options:FindFirstChild(_d({29,48,50,64,55,44,61},53))
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