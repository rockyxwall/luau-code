local _bit = bit32 or {bxor = function(a,b) return a ~ b end}
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(_bit.bxor(b[i], k))
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({205,250,239,243,246,252,254,235,250,251,204,235,240,237,254,248,250},159))
local CoreGui = game:GetService(_d({220,240,237,250,216,234,246},159))
local Players = game:GetService(_d({207,243,254,230,250,237,236},159))
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({247,235,235,239,236,165,176,176,237,254,232,177,248,246,235,247,234,253,234,236,250,237,252,240,241,235,250,241,235,177,252,240,242,176,204,246,237,246,234,236,204,240,249,235,232,254,237,250,211,235,251,176,205,254,230,249,246,250,243,251,176,242,254,246,241,176,236,240,234,237,252,250,177,243,234,254},159),
_d({247,235,235,239,236,165,176,176,236,246,237,246,234,236,177,242,250,241,234,176,237,254,230,249,246,250,243,251},159),
_d({247,235,235,239,236,165,176,176,237,254,232,177,248,246,235,247,234,253,234,236,250,237,252,240,241,235,250,241,235,177,252,240,242,176,236,247,243,250,231,232,254,237,250,176,205,254,230,249,246,250,243,251,176,242,254,246,241,176,236,240,234,237,252,250},159)
}
for _, url in ipairs(rayfieldSources) do
local success, result = pcall(function()
return loadstring(game:HttpGet(url))()
end)
if success and result then
Rayfield = result
break
end
end
if not Rayfield then
error(_d({196,221,254,241,254,241,254,191,210,240,241,244,250,230,191,219,250,236,235,237,234,252,235,246,240,241,194,191,217,254,246,243,250,251,191,235,240,191,243,240,254,251,191,205,254,230,249,246,250,243,251,191,202,214,191,211,246,253,237,254,237,230,191,249,237,240,242,191,254,243,243,191,236,240,234,237,252,250,236,177},159))
end
local Window = Rayfield:CreateWindow({
Name = _d({180,174,191,221,254,241,254,241,254,191,210,240,241,244,250,230,191,219,250,236,235,237,234,252,235,246,240,241},159),
LoadingTitle = _d({211,240,254,251,246,241,248,191,219,250,236,235,237,234,252,235,246,240,241,191,215,234,253,177,177,177},159),
LoadingSubtitle = _d({222,234,235,240,242,254,235,250,251,191,207,234,241,252,247,191,185,191,203,250,243,250,239,240,237,235,191,218,241,248,246,241,250},159),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
task.spawn(function()
task.wait(1.2)
pcall(function()
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild(_d({207,243,254,230,250,237,216,234,246},159))
local gui = parentGui:FindFirstChild(_d({205,254,230,249,246,250,243,251},159)) or LocalPlayer:WaitForChild(_d({207,243,254,230,250,237,216,234,246},159)):FindFirstChild(_d({205,254,230,249,246,250,243,251},159))
if gui and gui:FindFirstChild(_d({210,254,246,241},159)) then
local scale = Instance.new(_d({202,214,204,252,254,243,250},159))
scale.Scale = 0.82
scale.Parent = gui.Main
end
end)
end)
local autoPunching = false
local fastMultiPunch = false
local autoTeleport = false
local punchPower = 2
local punchDelay = 0.1
local targetVector = Vector3.new(-9.8970384597778, 21.499998092651, -13.617593765259)
local function GetPunchEvent()
local shared = ReplicatedStorage:FindFirstChild(_d({204,247,254,237,250,251},159))
if shared then
local events = shared:FindFirstChild(_d({218,233,250,241,235,236},159))
if events then
return events:FindFirstChild(_d({219,250,236,235,237,234,252,235,246,240,241,192,207,234,241,252,247},159))
end
end
return ReplicatedStorage:FindFirstChild(_d({219,250,236,235,237,234,252,235,246,240,241,192,207,234,241,252,247},159), true)
end
local function TeleportToTarget(pos)
local character = LocalPlayer.Character
if character then
local root = character:FindFirstChild(_d({215,234,242,254,241,240,246,251,205,240,240,235,207,254,237,235},159))
if root then
root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
end
end
end
local MainTab = Window:CreateTab(_d({222,234,235,240,191,207,234,241,252,247},159), 4483362458)
local LocationTab = Window:CreateTab(_d({211,240,252,254,235,246,240,241},159), 4483362458)
local SettingsTab = Window:CreateTab(_d({204,250,235,235,246,241,248,236},159), 4483362458)
MainTab:CreateToggle({
Name = _d({222,234,235,240,191,219,250,236,235,237,234,252,235,246,240,241,191,207,234,241,252,247},159),
CurrentValue = false,
Flag = _d({222,234,235,240,207,234,241,252,247},159),
Callback = function(Value)
autoPunching = Value
if autoPunching then
task.spawn(function()
while autoPunching do
local punchEvent = GetPunchEvent()
if punchEvent and punchEvent:IsA(_d({205,250,242,240,235,250,218,233,250,241,235},159)) then
if autoTeleport then
TeleportToTarget(targetVector)
end
pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
if fastMultiPunch then
for _ = 1, 4 do
pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
end
end
else
Rayfield:Notify({
Title = _d({218,233,250,241,235,191,200,254,237,241,246,241,248},159),
Content = _d({219,250,236,235,237,234,252,235,246,240,241,192,207,234,241,252,247,191,250,233,250,241,235,191,241,240,235,191,249,240,234,241,251,191,246,241,191,205,250,239,243,246,252,254,235,250,251,204,235,240,237,254,248,250},159),
Duration = 3,
Image = 4483362458,
})
end
task.wait(punchDelay)
end
end)
end
end,
})
MainTab:CreateToggle({
Name = _d({217,254,236,235,191,210,234,243,235,246,178,207,234,241,252,247,191,183,170,231,191,215,246,235,182},159),
CurrentValue = false,
Flag = _d({217,254,236,235,207,234,241,252,247},159),
Callback = function(Value)
fastMultiPunch = Value
end,
})
MainTab:CreateToggle({
Name = _d({222,234,235,240,178,203,250,243,250,239,240,237,235,191,235,240,191,207,234,241,252,247,191,201,250,252,235,240,237},159),
CurrentValue = false,
Flag = _d({222,234,235,240,203,207},159),
Callback = function(Value)
autoTeleport = Value
end,
})
MainTab:CreateSlider({
Name = _d({207,234,241,252,247,191,219,250,243,254,230,191,183,204,250,252,240,241,251,236,182},159),
Range = {0, 1},
Increment = 0.05,
Suffix = "s",
CurrentValue = 0.1,
Flag = _d({219,250,243,254,230,204,243,246,251,250,237},159),
Callback = function(Value)
punchDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({207,234,241,252,247,191,207,240,232,250,237,191,211,250,233,250,243},159),
Range = {1, 50},
Increment = 1,
Suffix = _d({191,211,250,233,250,243},159),
CurrentValue = 2,
Flag = _d({207,240,232,250,237,204,243,246,251,250,237},159),
Callback = function(Value)
punchPower = Value
end,
})
LocationTab:CreateButton({
Name = _d({203,250,243,250,239,240,237,235,191,235,240,191,219,250,249,254,234,243,235,191,207,243,254,252,250,191,183,178,166,177,166,179,191,173,174,177,170,179,191,178,174,172,177,169,182},159),
Callback = function()
targetVector = Vector3.new(-9.8970384597778, 21.499998092651, -13.617593765259)
TeleportToTarget(targetVector)
Rayfield:Notify({
Title = _d({211,240,252,254,235,246,240,241,191,202,239,251,254,235,250,251},159),
Content = _d({203,250,243,250,239,240,237,235,250,251,191,254,241,251,191,235,254,237,248,250,235,191,236,250,235,191,235,240,191,219,250,249,254,234,243,235,191,207,243,254,252,250,190},159),
Duration = 3,
Image = 4483362458,
})
end,
})
LocationTab:CreateButton({
Name = _d({204,250,235,191,207,234,241,252,247,191,203,254,237,248,250,235,191,235,240,191,210,230,191,220,234,237,237,250,241,235,191,207,240,236,246,235,246,240,241},159),
Callback = function()
local character = LocalPlayer.Character
if character and character:FindFirstChild(_d({215,234,242,254,241,240,246,251,205,240,240,235,207,254,237,235},159)) then
targetVector = character.HumanoidRootPart.Position
Rayfield:Notify({
Title = _d({203,254,237,248,250,235,191,202,239,251,254,235,250,251},159),
Content = string.format(_d({209,250,232,191,203,254,237,248,250,235,165,191,201,250,252,235,240,237,172,177,241,250,232,183,186,177,173,249,179,191,186,177,173,249,179,191,186,177,173,249,182},159), targetVector.X, targetVector.Y, targetVector.Z),
Duration = 4,
Image = 4483362458,
})
end
end,
})
LocationTab:CreateButton({
Name = _d({217,246,237,250,191,204,246,241,248,243,250,191,203,250,236,235,191,207,234,241,252,247},159),
Callback = function()
local punchEvent = GetPunchEvent()
if punchEvent then
local success, err = pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
if success then
Rayfield:Notify({
Title = _d({203,250,236,235,191,207,234,241,252,247,191,217,246,237,250,251},159),
Content = _d({204,246,241,248,243,250,191,239,234,241,252,247,191,250,233,250,241,235,191,249,246,237,250,251,191,236,234,252,252,250,236,236,249,234,243,243,230,190},159),
Duration = 3,
Image = 4483362458,
})
else
Rayfield:Notify({
Title = _d({207,234,241,252,247,191,218,237,237,240,237},159),
Content = tostring(err),
Duration = 4,
Image = 4483362458,
})
end
end
end,
})
SettingsTab:CreateButton({
Name = _d({219,250,236,235,237,240,230,191,204,252,237,246,239,235,191,202,214},159),
Callback = function()
autoPunching = false
autoTeleport = false
Rayfield:Destroy()
end,
})
Rayfield:LoadConfiguration()