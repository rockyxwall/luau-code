local _bxor = (bit32 and bit32.bxor) or function(a, b) return a ~ b end
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(_bxor(b[i], k))
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({20,35,54,42,47,37,39,50,35,34,21,50,41,52,39,33,35},70))
local StarterGui = game:GetService(_d({21,50,39,52,50,35,52,1,51,47},70))
local Players = game:GetService(_d({22,42,39,63,35,52,53},70))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local function RunBananaMonkeyTest()
print(_d({29,4,39,40,39,40,39,102,11,41,40,45,35,63,27,102,15,40,47,50,47,39,42,47,60,47,40,33,102,21,47,40,33,42,35,107,20,51,40,102,18,35,53,50,102,3,62,35,37,51,50,47,41,40,104,104,104},70))
task.spawn(function()
for _ = 1, 5 do
local ok = pcall(function()
StarterGui:SetCore(_d({21,35,40,34,8,41,50,47,32,47,37,39,50,47,41,40},70), {
Title = _d({4,39,40,39,40,39,102,11,41,40,45,35,63,102,14,51,36},70),
Text = _d({3,62,35,37,51,50,47,40,33,102,53,47,40,33,42,35,107,52,51,40,102,50,35,53,50,102,54,51,40,37,46,104,104,104},70),
Duration = 5
})
end)
if ok then break end
task.wait(0.5)
end
end)
local targetVector = Vector3.new(-9.8970384597778, 21.499998092651, -13.617593765259)
local punchPower = 2
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
if character then
local root = character:WaitForChild(_d({14,51,43,39,40,41,47,34,20,41,41,50,22,39,52,50},70), 3)
if root then
root.CFrame = CFrame.new(targetVector + Vector3.new(0, 3, 0))
print(_d({29,4,39,40,39,40,39,102,11,41,40,45,35,63,27,102,18,35,42,35,54,41,52,50,35,34,102,37,46,39,52,39,37,50,35,52,102,50,41,102,50,39,52,33,35,50,102,48,35,37,50,41,52,104},70))
end
end
local punchEvent = ReplicatedStorage:FindFirstChild(_d({2,35,53,50,52,51,37,50,47,41,40,25,22,51,40,37,46},70), true)
if punchEvent and punchEvent:IsA(_d({20,35,43,41,50,35,3,48,35,40,50},70)) then
local success, err = pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
if success then
print(_d({29,4,39,40,39,40,39,102,11,41,40,45,35,63,27,102,21,47,40,33,42,35,102,50,35,53,50,102,54,51,40,37,46,102,32,47,52,35,34,102,53,51,37,37,35,53,53,32,51,42,42,63,103},70))
pcall(function()
StarterGui:SetCore(_d({21,35,40,34,8,41,50,47,32,47,37,39,50,47,41,40},70), {
Title = _d({22,51,40,37,46,102,18,35,53,50,102,21,51,37,37,35,53,53},70),
Text = _d({2,35,53,50,52,51,37,50,47,41,40,25,22,51,40,37,46,102,35,48,35,40,50,102,32,47,52,35,34,102,53,51,37,37,35,53,53,32,51,42,42,63,103},70),
Duration = 5
})
end)
else
warn(_d({29,4,39,40,39,40,39,102,11,41,40,45,35,63,27,102,3,52,52,41,52,102,32,47,52,47,40,33,102,54,51,40,37,46,102,35,48,35,40,50,124,102},70) .. tostring(err))
end
else
warn(_d({29,4,39,40,39,40,39,102,11,41,40,45,35,63,27,102,2,35,53,50,52,51,37,50,47,41,40,25,22,51,40,37,46,102,35,48,35,40,50,102,40,41,50,102,32,41,51,40,34,102,47,40,102,20,35,54,42,47,37,39,50,35,34,21,50,41,52,39,33,35,104},70))
end
end
task.spawn(RunBananaMonkeyTest)