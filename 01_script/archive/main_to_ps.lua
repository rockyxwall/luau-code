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
local WindUI = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,55,57,68,56,69,50,254,51,63,61,255,22,63,63,68,49,55,53,67,69,67,255,39,57,62,52,37,25,255,66,53,60,53,49,67,53,67,255,60,49,68,53,67,68,255,52,63,71,62,60,63,49,52,255,61,49,57,62,254,60,69,49},48)))()
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local HttpService = game:GetService(_d({24,68,68,64,35,53,66,70,57,51,53},48))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({32,60,49,73,53,66,23,69,57},48))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({21,70,53,62,68,67},48), 10) and ReplicatedStorage.Events:WaitForChild(_d({68,49,59,53,67,68,49,61},48), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({21,70,53,62,68,67},48), 10) and ReplicatedStorage.Events:WaitForChild(_d({66,53,67,53,66,70,53,52},48), 10)
local CONFIG_FILE = _d({38,53,67,64,53,66,47,38,57,64,19,63,62,54,57,55,254,58,67,63,62},48)
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
if success and type(result) == _d({68,49,50,60,53},48) then
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
Title = _d({38,25,32,240,35,53,66,70,53,66,240,29,49,62,49,55,53,66},48),
Icon = _d({67,53,66,70,53,66},48),
Author = _d({50,73,240,38,53,67,64,53,66},48),
Folder = _d({38,53,67,64,53,66,38,57,64,19,63,62,54,57,55},48),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({20,49,66,59},48),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({38,25,32,240,19,63,62,68,66,63,60},48),
Icon = _d({67,56,57,53,60,52},48),
})
Tab:Input({
Title = _d({38,25,32,240,35,53,66,70,53,66,240,19,63,52,53},48),
Desc = _d({19,69,67,68,63,61,240,38,25,32,240,51,63,52,53},48),
Value = config.VipCode or "",
Placeholder = _d({21,62,68,53,66,240,38,25,32,240,51,63,52,53,240,56,53,66,53,254,254,254},48),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({245,67,251},48), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({54,69,62,51,68,57,63,62},48) then
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
local hrp = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({52,49,67,56},48), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({34,53,61,63,68,53,22,69,62,51,68,57,63,62},48)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({32,66,57,70,49,68,53,35,53,66,70,53,66,67},48)) and PlayerGui.PrivateServers:FindFirstChild(_d({32,66,57,70,49,68,53,35,53,66,70,53,66,67,32,49,62,53,60},48))
if privPanel and privPanel:FindFirstChild(_d({35,53,66,70,53,66,19,63,52,53,18,63,72},48)) and privPanel.ServerCodeBox:FindFirstChild(_d({36,53,72,68,18,63,72},48)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({54,69,62,51,68,57,63,62},48) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({35,68,49,66,68},48))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({29,53,62,69},48)) and startMenu.Menu:FindFirstChild(_d({29,49,57,62},48)) and startMenu.Menu.Main:FindFirstChild(_d({28,57,67,68},48)) and startMenu.Menu.Main.List:FindFirstChild(_d({32,66,57,70,49,68,53,35,53,66,70,53,66,67,18,69,68,68,63,62},48))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({51,56,63,63,67,53,36,73,64,53},48))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({22,66,49,61,53},48)) and chooseType.Frame:FindFirstChild(_d({34,53,61,63,68,53,21,70,53,62,68},48))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({22,66,49,61,53},48)) and chooseType.Frame:FindFirstChild(_d({31,64,68,57,63,62,67},48)) and chooseType.Frame.Options:FindFirstChild(_d({34,53,55,69,60,49,66},48))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({26,63,57,62,240,38,25,32,240,35,53,66,70,53,66},48),
Desc = _d({21,72,53,51,69,68,53,67,240,20,49,67,56,240,253,14,240,32,66,57,70,49,68,53,240,253,14,240,35,53,60,53,51,68,67,240,34,53,55,69,60,49,66,240,253,14,240,26,63,57,62,67},48),
Callback = function()
WindUI:Notify({
Title = _d({19,63,62,62,53,51,68,57,62,55},48),
Content = _d({35,53,60,53,51,68,57,62,55,240,34,53,55,69,60,49,66,240,38,25,32,240,35,53,66,70,53,66,254,254,254},48),
Duration = 2,
Icon = _d({49,66,66,63,71,253,66,57,55,56,68},48),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({17,69,68,63,240,34,53,253,26,63,57,62,240,28,63,63,64},48),
Desc = _d({19,63,62,68,57,62,69,63,69,67,60,73,240,67,53,60,53,51,68,67,240,34,53,55,69,60,49,66,240,38,25,32,240,35,53,66,70,53,66},48),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({26,63,57,62,240,20,53,60,49,73,240,248,35,53,51,63,62,52,67,249},48),
Desc = _d({20,53,60,49,73,240,57,62,68,53,66,70,49,60,240,54,63,66,240,49,69,68,63,240,66,53,58,63,57,62,240,60,63,63,64},48),
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
Title = _d({35,49,70,53,240,19,63,62,54,57,55},48),
Desc = _d({35,49,70,53,240,67,53,68,68,57,62,55,67,240,68,63,240,38,53,67,64,53,66,47,38,57,64,19,63,62,54,57,55,254,58,67,63,62},48),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({19,63,62,54,57,55},48),
Content = _d({19,63,62,54,57,55,69,66,49,68,57,63,62,240,67,49,70,53,52,254},48),
Duration = 2,
Icon = _d({51,56,53,51,59},48),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({51,56,63,63,67,53,36,73,64,53},48))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({22,66,49,61,53},48)) and chooseType.Frame:FindFirstChild(_d({34,53,61,63,68,53,21,70,53,62,68},48))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({22,66,49,61,53},48)) and chooseType.Frame:FindFirstChild(_d({31,64,68,57,63,62,67},48)) and chooseType.Frame.Options:FindFirstChild(_d({34,53,55,69,60,49,66},48))
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