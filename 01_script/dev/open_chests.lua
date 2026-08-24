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
if _G.OpenChestsRunning then
warn(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,6,49,55,42,38,41,62,229,55,58,51,51,46,51,44,230,229,6,39,52,55,57,46,51,44,229,41,58,53,49,46,40,38,57,42,229,49,38,58,51,40,45,243},59))
return
end
_G.OpenChestsRunning = true
local Players          = game:GetService(_d({21,49,38,62,42,55,56},59))
local RunService       = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local LocalPlayer      = Players.LocalPlayer
local running = true
local ARRIVE_DIST     = 6
local TIMEOUT_PER_CHEST = 20
local OPEN_WAIT       = 2.5
local TRAVEL_HEIGHT   = 4
local CHECK_HZ        = 0.1
local function collectChests()
local chests = {}
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA(_d({21,55,52,61,46,50,46,57,62,21,55,52,50,53,57},59)) then
local action = v.ActionText
if action:find(_d({21,42,49,46,229,8,45,42,56,57},59)) then
local part = v.Parent
if part and part:IsA(_d({7,38,56,42,21,38,55,57},59)) then
table.insert(chests, {
prompt   = v,
position = part.Position,
label    = string.format(_d({237,234,243,245,43,241,229,234,243,245,43,241,229,234,243,245,43,238},59), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
local function Core.GetRoot(LocalPlayer)
local char = LocalPlayer.Character
if not char then return nil end
return char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end
local function waitForRoot(timeout)
local t = 0
while t < timeout do
local r = Core.GetRoot(LocalPlayer)
if r then return r end
task.wait(0.1)
t = t + 0.1
end
return nil
end
local chests = collectChests()
print(string.format(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,11,52,58,51,41,229,234,41,229,21,42,49,46,229,8,45,42,56,57,56,243},59), #chests))
if #chests == 0 then
warn(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,19,52,229,40,45,42,56,57,56,229,43,52,58,51,41,229,167,69,89,229,38,55,42,229,62,52,58,229,46,51,229,57,45,42,229,55,46,44,45,57,229,38,55,42,38,4},59))
_G.OpenChestsRunning = false
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,8,52,58,49,41,229,51,52,57,229,43,46,51,41,229,40,45,38,55,38,40,57,42,55,229,55,52,52,57,230,229,6,39,52,55,57,46,51,44,243},59))
_G.OpenChestsRunning = false
return
end
local playerStartPos = startRoot.Position
local playerStartY   = playerStartPos.Y
local filtered = {}
for _, c in ipairs(chests) do
if c.position.Y <= playerStartY + 20 then
table.insert(filtered, c)
else
print(string.format(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,24,48,46,53,53,46,51,44,229,42,49,42,59,38,57,42,41,229,40,45,42,56,57,229,38,57,229,234,56,229,237,30,2,234,243,245,43,229,3,229,49,46,50,46,57,229,234,243,245,43,238},59),
c.label, c.position.Y, playerStartY + 20))
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
chests = filtered
print(string.format(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,234,41,229,40,45,42,56,57,56,229,54,58,42,58,42,41,229,237,51,42,38,55,42,56,57,242,43,46,55,56,57,241,229,38,43,57,42,55,229,30,229,43,46,49,57,42,55,238,243},59), #chests))
if #chests == 0 then
warn(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,19,52,229,55,42,38,40,45,38,39,49,42,229,40,45,42,56,57,56,229,38,43,57,42,55,229,43,46,49,57,42,55,46,51,44,243},59))
_G.OpenChestsRunning = false
return
end
_G.EasyTravelHelperMode = true
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
task.wait(0.3)
end
local easyTravelSrc = readfile(_d({49,46,39,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59))
local loader = loadstring(easyTravelSrc)
if not loader then
error(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,229,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38,229,167,69,89,229,40,45,42,40,48,229,60,52,55,48,56,53,38,40,42,229,43,46,49,42,230},59))
end
local ET = loader()
if not ET or not ET.Start then
error(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,42,38,56,62,36,57,55,38,59,42,49,229,6,21,14,229,51,52,57,229,55,42,57,58,55,51,42,41,229,40,52,55,55,42,40,57,49,62,243},59))
end
task.wait(0.2)
ET.Start()
print(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,10,38,56,62,229,25,55,38,59,42,49,229,56,57,38,55,57,42,41,229,46,51,229,45,42,49,53,42,55,229,50,52,41,42,243},59))
local function cleanup(reason)
running = false
if ET then
ET.TargetPosition = nil
pcall(ET.Stop)
end
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
_G.EasyTravelHelperMode = nil
_G.OpenChestsRunning = false
print(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,24,57,52,53,53,42,41,255,229},59) .. (reason or _d({41,52,51,42},59)) .. ".")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,21,229,53,55,42,56,56,42,41,229,167,69,89,229,38,39,52,55,57,46,51,44,230},59))
cleanup(_d({21,229,48,42,62,229,38,39,52,55,57},59))
end
end
end)
for i, chest in ipairs(chests) do
print(string.format(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,32,234,41,244,234,41,34,229,25,55,38,59,42,49,49,46,51,44,229,57,52,229,40,45,42,56,57,229,38,57,229,234,56},59), i, #chests, chest.label))
local target = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
ET.TargetPosition = target
local elapsed = 0
while running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,17,52,56,57,229,40,45,38,55,38,40,57,42,55,229,167,69,89,229,53,38,58,56,46,51,44,243},59))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
print(string.format(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,6,55,55,46,59,42,41,230,229,237,41,46,56,57,2,234,243,246,43,238},59), dist))
break
end
end
if not running then break end
local currentRoot = Core.GetRoot(LocalPlayer)
if currentRoot then
ET.TargetPosition = currentRoot.Position
end
if chest.prompt and chest.prompt.Parent then
local ok, err = pcall(function()
fireproximityprompt(chest.prompt)
end)
if ok then
print(string.format(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,20,53,42,51,42,41,229,40,45,42,56,57,229,234,41,230},59), i))
else
warn(string.format(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,43,46,55,42,53,55,52,61,46,50,46,57,62,53,55,52,50,53,57,229,43,38,46,49,42,41,255,229,234,56},59), tostring(err)))
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
else
warn(string.format(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,8,45,42,56,57,229,234,41,229,53,55,52,50,53,57,229,51,52,229,49,52,51,44,42,55,229,42,61,46,56,57,56,229,237,50,38,62,229,45,38,59,42,229,41,42,56,53,38,60,51,42,41,238,243},59), i))
end
task.wait(OPEN_WAIT)
end
if running then
print(_d({32,20,53,42,51,8,45,42,56,57,56,34,229,6,49,49,229,40,45,42,56,57,56,229,53,55,52,40,42,56,56,42,41,230},59))
cleanup(_d({38,49,49,229,41,52,51,42},59))
end
end)()