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
local WindUI = loadstring(game:HttpGet(_d({60,72,72,68,71,14,3,3,59,61,72,60,73,54,2,55,67,65,3,26,67,67,72,53,59,57,71,73,71,3,43,61,66,56,41,29,3,70,57,64,57,53,71,57,71,3,64,53,72,57,71,72,3,56,67,75,66,64,67,53,56,3,65,53,61,66,2,64,73,53},44)))()
local Players = game:GetService(_d({36,64,53,77,57,70,71},44))
local ReplicatedStorage = game:GetService(_d({38,57,68,64,61,55,53,72,57,56,39,72,67,70,53,59,57},44))
local HttpService = game:GetService(_d({28,72,72,68,39,57,70,74,61,55,57},44))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({36,64,53,77,57,70,27,73,61},44))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({25,74,57,66,72,71},44), 10) and ReplicatedStorage.Events:WaitForChild(_d({72,53,63,57,71,72,53,65},44), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({25,74,57,66,72,71},44), 10) and ReplicatedStorage.Events:WaitForChild(_d({70,57,71,57,70,74,57,56},44), 10)
local CONFIG_FILE = _d({42,57,71,68,57,70,51,42,61,68,23,67,66,58,61,59,2,62,71,67,66},44)
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
if success and type(result) == _d({72,53,54,64,57},44) then
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
Title = _d({42,29,36,244,39,57,70,74,57,70,244,33,53,66,53,59,57,70},44),
Icon = _d({71,57,70,74,57,70},44),
Author = _d({54,77,244,42,57,71,68,57,70},44),
Folder = _d({42,57,71,68,57,70,42,61,68,23,67,66,58,61,59},44),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({24,53,70,63},44),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({42,29,36,244,23,67,66,72,70,67,64},44),
Icon = _d({71,60,61,57,64,56},44),
})
Tab:Input({
Title = _d({42,29,36,244,39,57,70,74,57,70,244,23,67,56,57},44),
Desc = _d({23,73,71,72,67,65,244,42,29,36,244,55,67,56,57},44),
Value = config.VipCode or "",
Placeholder = _d({25,66,72,57,70,244,42,29,36,244,55,67,56,57,244,60,57,70,57,2,2,2},44),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({249,71,255},44), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({58,73,66,55,72,61,67,66},44) then
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
local hrp = char and char:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({56,53,71,60},44), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({38,57,65,67,72,57,26,73,66,55,72,61,67,66},44)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({36,70,61,74,53,72,57,39,57,70,74,57,70,71},44)) and PlayerGui.PrivateServers:FindFirstChild(_d({36,70,61,74,53,72,57,39,57,70,74,57,70,71,36,53,66,57,64},44))
if privPanel and privPanel:FindFirstChild(_d({39,57,70,74,57,70,23,67,56,57,22,67,76},44)) and privPanel.ServerCodeBox:FindFirstChild(_d({40,57,76,72,22,67,76},44)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({58,73,66,55,72,61,67,66},44) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({39,72,53,70,72},44))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({33,57,66,73},44)) and startMenu.Menu:FindFirstChild(_d({33,53,61,66},44)) and startMenu.Menu.Main:FindFirstChild(_d({32,61,71,72},44)) and startMenu.Menu.Main.List:FindFirstChild(_d({36,70,61,74,53,72,57,39,57,70,74,57,70,71,22,73,72,72,67,66},44))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({55,60,67,67,71,57,40,77,68,57},44))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({26,70,53,65,57},44)) and chooseType.Frame:FindFirstChild(_d({38,57,65,67,72,57,25,74,57,66,72},44))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({26,70,53,65,57},44)) and chooseType.Frame:FindFirstChild(_d({35,68,72,61,67,66,71},44)) and chooseType.Frame.Options:FindFirstChild(_d({38,57,59,73,64,53,70},44))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({30,67,61,66,244,42,29,36,244,39,57,70,74,57,70},44),
Desc = _d({25,76,57,55,73,72,57,71,244,24,53,71,60,244,1,18,244,36,70,61,74,53,72,57,244,1,18,244,39,57,64,57,55,72,71,244,38,57,59,73,64,53,70,244,1,18,244,30,67,61,66,71},44),
Callback = function()
WindUI:Notify({
Title = _d({23,67,66,66,57,55,72,61,66,59},44),
Content = _d({39,57,64,57,55,72,61,66,59,244,38,57,59,73,64,53,70,244,42,29,36,244,39,57,70,74,57,70,2,2,2},44),
Duration = 2,
Icon = _d({53,70,70,67,75,1,70,61,59,60,72},44),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({21,73,72,67,244,38,57,1,30,67,61,66,244,32,67,67,68},44),
Desc = _d({23,67,66,72,61,66,73,67,73,71,64,77,244,71,57,64,57,55,72,71,244,38,57,59,73,64,53,70,244,42,29,36,244,39,57,70,74,57,70},44),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({30,67,61,66,244,24,57,64,53,77,244,252,39,57,55,67,66,56,71,253},44),
Desc = _d({24,57,64,53,77,244,61,66,72,57,70,74,53,64,244,58,67,70,244,53,73,72,67,244,70,57,62,67,61,66,244,64,67,67,68},44),
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
Title = _d({39,53,74,57,244,23,67,66,58,61,59},44),
Desc = _d({39,53,74,57,244,71,57,72,72,61,66,59,71,244,72,67,244,42,57,71,68,57,70,51,42,61,68,23,67,66,58,61,59,2,62,71,67,66},44),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({23,67,66,58,61,59},44),
Content = _d({23,67,66,58,61,59,73,70,53,72,61,67,66,244,71,53,74,57,56,2},44),
Duration = 2,
Icon = _d({55,60,57,55,63},44),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({55,60,67,67,71,57,40,77,68,57},44))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({26,70,53,65,57},44)) and chooseType.Frame:FindFirstChild(_d({38,57,65,67,72,57,25,74,57,66,72},44))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({26,70,53,65,57},44)) and chooseType.Frame:FindFirstChild(_d({35,68,72,61,67,66,71},44)) and chooseType.Frame.Options:FindFirstChild(_d({38,57,59,73,64,53,70},44))
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