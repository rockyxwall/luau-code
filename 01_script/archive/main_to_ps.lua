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
local WindUI = loadstring(game:HttpGet(_d({62,74,74,70,73,16,5,5,61,63,74,62,75,56,4,57,69,67,5,28,69,69,74,55,61,59,73,75,73,5,45,63,68,58,43,31,5,72,59,66,59,55,73,59,73,5,66,55,74,59,73,74,5,58,69,77,68,66,69,55,58,5,67,55,63,68,4,66,75,55},42)))()
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local ReplicatedStorage = game:GetService(_d({40,59,70,66,63,57,55,74,59,58,41,74,69,72,55,61,59},42))
local HttpService = game:GetService(_d({30,74,74,70,41,59,72,76,63,57,59},42))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_d({38,66,55,79,59,72,29,75,63},42))
local takeStamRemote = ReplicatedStorage:WaitForChild(_d({27,76,59,68,74,73},42), 10) and ReplicatedStorage.Events:WaitForChild(_d({74,55,65,59,73,74,55,67},42), 10)
local reservedRemote = ReplicatedStorage:WaitForChild(_d({27,76,59,68,74,73},42), 10) and ReplicatedStorage.Events:WaitForChild(_d({72,59,73,59,72,76,59,58},42), 10)
local CONFIG_FILE = _d({44,59,73,70,59,72,53,44,63,70,25,69,68,60,63,61,4,64,73,69,68},42)
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
if success and type(result) == _d({74,55,56,66,59},42) then
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
Title = _d({44,31,38,246,41,59,72,76,59,72,246,35,55,68,55,61,59,72},42),
Icon = _d({73,59,72,76,59,72},42),
Author = _d({56,79,246,44,59,73,70,59,72},42),
Folder = _d({44,59,73,70,59,72,44,63,70,25,69,68,60,63,61},42),
Size = UDim2.fromOffset(480, 360),
Transparent = true,
Theme = _d({26,55,72,65},42),
SideBarWidth = 140,
HasOutline = true,
})
local Tab = Window:Tab({
Title = _d({44,31,38,246,25,69,68,74,72,69,66},42),
Icon = _d({73,62,63,59,66,58},42),
})
Tab:Input({
Title = _d({44,31,38,246,41,59,72,76,59,72,246,25,69,58,59},42),
Desc = _d({25,75,73,74,69,67,246,44,31,38,246,57,69,58,59},42),
Value = config.VipCode or "",
Placeholder = _d({27,68,74,59,72,246,44,31,38,246,57,69,58,59,246,62,59,72,59,4,4,4},42),
Callback = function(val)
config.VipCode = tostring(val or ""):gsub(_d({251,73,1},42), "")
saveConfig()
end,
})
local function clickGuiButton(btn)
if not btn then return false end
if typeof(firesignal) == _d({60,75,68,57,74,63,69,68},42) then
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
local hrp = char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
local cframe = hrp and hrp.CFrame or CFrame.new(307.57550048828125, 8.017972946166992, -11449.29296875, 0.05065685138106346, -4.452865098869552e-08, -0.9987161159515381, 1.0139391548591448e-08, 1, -4.407160503205887e-08, 0.9987161159515381, -7.893845577200409e-09, 0.05065685138106346)
if takeStamRemote then
pcall(function()
takeStamRemote:FireServer(1, _d({58,55,73,62},42), cframe)
end)
end
task.wait(0.1)
local code = config.VipCode
if code and code ~= "" then
pcall(function()
if reservedRemote and reservedRemote:IsA(_d({40,59,67,69,74,59,28,75,68,57,74,63,69,68},42)) then
reservedRemote:InvokeServer(code)
end
end)
local privPanel = PlayerGui:FindFirstChild(_d({38,72,63,76,55,74,59,41,59,72,76,59,72,73},42)) and PlayerGui.PrivateServers:FindFirstChild(_d({38,72,63,76,55,74,59,41,59,72,76,59,72,73,38,55,68,59,66},42))
if privPanel and privPanel:FindFirstChild(_d({41,59,72,76,59,72,25,69,58,59,24,69,78},42)) and privPanel.ServerCodeBox:FindFirstChild(_d({42,59,78,74,24,69,78},42)) then
privPanel.ServerCodeBox.TextBox.Text = code
if typeof(firesignal) == _d({60,75,68,57,74,63,69,68},42) and privPanel.ServerCodeBox.TextBox.FocusLost then
firesignal(privPanel.ServerCodeBox.TextBox.FocusLost, true)
end
end
end
local startMenu = PlayerGui:FindFirstChild(_d({41,74,55,72,74},42))
local privateBtn = startMenu and startMenu:FindFirstChild(_d({35,59,68,75},42)) and startMenu.Menu:FindFirstChild(_d({35,55,63,68},42)) and startMenu.Menu.Main:FindFirstChild(_d({34,63,73,74},42)) and startMenu.Menu.Main.List:FindFirstChild(_d({38,72,63,76,55,74,59,41,59,72,76,59,72,73,24,75,74,74,69,68},42))
if privateBtn then
clickGuiButton(privateBtn)
end
task.wait(0.15)
local chooseType = PlayerGui:FindFirstChild(_d({57,62,69,69,73,59,42,79,70,59},42))
if chooseType then
local chooseRemote = chooseType:FindFirstChild(_d({28,72,55,67,59},42)) and chooseType.Frame:FindFirstChild(_d({40,59,67,69,74,59,27,76,59,68,74},42))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({28,72,55,67,59},42)) and chooseType.Frame:FindFirstChild(_d({37,70,74,63,69,68,73},42)) and chooseType.Frame.Options:FindFirstChild(_d({40,59,61,75,66,55,72},42))
if regBtn then
clickGuiButton(regBtn)
end
end
end
Tab:Button({
Title = _d({32,69,63,68,246,44,31,38,246,41,59,72,76,59,72},42),
Desc = _d({27,78,59,57,75,74,59,73,246,26,55,73,62,246,3,20,246,38,72,63,76,55,74,59,246,3,20,246,41,59,66,59,57,74,73,246,40,59,61,75,66,55,72,246,3,20,246,32,69,63,68,73},42),
Callback = function()
WindUI:Notify({
Title = _d({25,69,68,68,59,57,74,63,68,61},42),
Content = _d({41,59,66,59,57,74,63,68,61,246,40,59,61,75,66,55,72,246,44,31,38,246,41,59,72,76,59,72,4,4,4},42),
Duration = 2,
Icon = _d({55,72,72,69,77,3,72,63,61,62,74},42),
})
task.spawn(triggerFullVipJoin)
end,
})
Tab:Toggle({
Title = _d({23,75,74,69,246,40,59,3,32,69,63,68,246,34,69,69,70},42),
Desc = _d({25,69,68,74,63,68,75,69,75,73,66,79,246,73,59,66,59,57,74,73,246,40,59,61,75,66,55,72,246,44,31,38,246,41,59,72,76,59,72},42),
Value = config.AutoJoin,
Callback = function(state)
config.AutoJoin = state
saveConfig()
end,
})
Tab:Slider({
Title = _d({32,69,63,68,246,26,59,66,55,79,246,254,41,59,57,69,68,58,73,255},42),
Desc = _d({26,59,66,55,79,246,63,68,74,59,72,76,55,66,246,60,69,72,246,55,75,74,69,246,72,59,64,69,63,68,246,66,69,69,70},42),
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
Title = _d({41,55,76,59,246,25,69,68,60,63,61},42),
Desc = _d({41,55,76,59,246,73,59,74,74,63,68,61,73,246,74,69,246,44,59,73,70,59,72,53,44,63,70,25,69,68,60,63,61,4,64,73,69,68},42),
Callback = function()
saveConfig()
WindUI:Notify({
Title = _d({25,69,68,60,63,61},42),
Content = _d({25,69,68,60,63,61,75,72,55,74,63,69,68,246,73,55,76,59,58,4},42),
Duration = 2,
Icon = _d({57,62,59,57,65},42),
})
end,
})
task.spawn(function()
while true do
local chooseType = PlayerGui:FindFirstChild(_d({57,62,69,69,73,59,42,79,70,59},42))
if chooseType and chooseType.Enabled then
local chooseRemote = chooseType:FindFirstChild(_d({28,72,55,67,59},42)) and chooseType.Frame:FindFirstChild(_d({40,59,67,69,74,59,27,76,59,68,74},42))
if chooseRemote then
pcall(function()
chooseRemote:FireServer(true)
end)
end
local regBtn = chooseType:FindFirstChild(_d({28,72,55,67,59},42)) and chooseType.Frame:FindFirstChild(_d({37,70,74,63,69,68,73},42)) and chooseType.Frame.Options:FindFirstChild(_d({40,59,61,75,66,55,72},42))
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