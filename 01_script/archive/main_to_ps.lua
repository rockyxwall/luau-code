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
local WindUI = loadstring(game:HttpGet(_d({45,57,57,53,56,255,244,244,44,46,57,45,58,39,243,40,52,50,244,11,52,52,57,38,44,42,56,58,56,244,28,46,51,41,26,14,244,55,42,49,42,38,56,42,56,244,49,38,57,42,56,57,244,41,52,60,51,49,52,38,41,244,50,38,46,51,243,49,58,38},59)))()
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local HttpService = game:GetService(_d({13,57,57,53,24,42,55,59,46,40,42},59))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({10,59,42,51,57,56},59), 10) and ReplicatedStorage.Events:WaitForChild(_d({57,38,48,42,56,57,38,50},59), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({10,59,42,51,57,56},59), 10) and ReplicatedStorage.Events:WaitForChild(_d({55,42,56,42,55,59,42,41},59), 10)
local CONFIG_FILE = _d({27,42,56,53,42,55,36,27,46,53,8,52,51,43,46,44,243,47,56,52,51},59)
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
if success and type(result) == _d({57,38,39,49,42},59) then
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
Title = _d({27,14,21,229,24,42,55,59,42,55,229,18,38,51,38,44,42,55},59),
Icon = _d({56,42,55,59,42,55},59),
Author = _d({39,62,229,27,42,56,53,42,55},59),
Folder = _d({27,42,56,53,42,55,27,46,53,8,52,51,43,46,44},59),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({9,38,55,48},59),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({27,14,21,229,8,52,51,57,55,52,49},59),
Icon = _d({56,45,46,42,49,41},59),
})
Tab:Input({
Title = _d({27,14,21,229,24,42,55,59,42,55,229,8,52,41,42},59),
Desc = _d({8,58,56,57,52,50,229,27,14,21,229,40,52,41,42},59),
Value = config.VipCode or "",
Placeholder = _d({10,51,57,42,55,229,27,14,21,229,40,52,41,42,229,45,42,55,42,243,243,243},59),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({234,56,240},59), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({43,58,51,40,57,46,52,51},59) then
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
local hrp = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({41,38,56,45},59), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({23,42,50,52,57,42,11,58,51,40,57,46,52,51},59)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({21,55,46,59,38,57,42,24,42,55,59,42,55,56},59)) and PlayerGui.PrivateServers:FindFirstChild(_d({21,55,46,59,38,57,42,24,42,55,59,42,55,56,21,38,51,42,49},59))
if privPanel and privPanel:FindFirstChild(_d({24,42,55,59,42,55,8,52,41,42,7,52,61},59)) and privPanel.ServerCodeBox:FindFirstChild(_d({25,42,61,57,7,52,61},59)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({43,58,51,40,57,46,52,51},59) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({24,57,38,55,57},59))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({18,42,51,58},59)) and startMenu.Menu:FindFirstChild(_d({18,38,46,51},59)) and startMenu.Menu.Main:FindFirstChild(_d({17,46,56,57},59)) and startMenu.Menu.Main.List:FindFirstChild(_d({21,55,46,59,38,57,42,24,42,55,59,42,55,56,7,58,57,57,52,51},59))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({40,45,52,52,56,42,25,62,53,42},59))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({11,55,38,50,42},59)) and chooseType.Frame:FindFirstChild(_d({23,42,50,52,57,42,10,59,42,51,57},59))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({11,55,38,50,42},59)) and chooseType.Frame:FindFirstChild(_d({20,53,57,46,52,51,56},59)) and chooseType.Frame.Options:FindFirstChild(_d({23,42,44,58,49,38,55},59))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({15,52,46,51,229,27,14,21,229,24,42,55,59,42,55},59),
Desc = _d({10,61,42,40,58,57,42,56,229,9,38,56,45,229,242,3,229,21,55,46,59,38,57,42,229,242,3,229,24,42,49,42,40,57,56,229,23,42,44,58,49,38,55,229,242,3,229,15,52,46,51,56},59),
Callback = function()
WindUI:Notify({
Title = _d({8,52,51,51,42,40,57,46,51,44},59),
Content = _d({24,42,49,42,40,57,46,51,44,229,23,42,44,58,49,38,55,229,27,14,21,229,24,42,55,59,42,55,243,243,243},59),
Duration = 2,
Icon = _d({38,55,55,52,60,242,55,46,44,45,57},59),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({6,58,57,52,229,23,42,242,15,52,46,51,229,17,52,52,53},59),
Desc = _d({8,52,51,57,46,51,58,52,58,56,49,62,229,56,42,49,42,40,57,56,229,23,42,44,58,49,38,55,229,27,14,21,229,24,42,55,59,42,55},59),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({15,52,46,51,229,9,42,49,38,62,229,237,24,42,40,52,51,41,56,238},59),
Desc = _d({9,42,49,38,62,229,46,51,57,42,55,59,38,49,229,43,52,55,229,38,58,57,52,229,55,42,47,52,46,51,229,49,52,52,53},59),
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
Title = _d({24,38,59,42,229,8,52,51,43,46,44},59),
Desc = _d({24,38,59,42,229,56,42,57,57,46,51,44,56,229,57,52,229,27,42,56,53,42,55,36,27,46,53,8,52,51,43,46,44,243,47,56,52,51},59),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({8,52,51,43,46,44},59),
Content = _d({8,52,51,43,46,44,58,55,38,57,46,52,51,229,56,38,59,42,41,243},59),
Duration = 2,
Icon = _d({40,45,42,40,48},59),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({40,45,52,52,56,42,25,62,53,42},59))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({11,55,38,50,42},59)) and chooseType.Frame:FindFirstChild(_d({23,42,50,52,57,42,10,59,42,51,57},59))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({11,55,38,50,42},59)) and chooseType.Frame:FindFirstChild(_d({20,53,57,46,52,51,56},59)) and chooseType.Frame.Options:FindFirstChild(_d({23,42,44,58,49,38,55},59))
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