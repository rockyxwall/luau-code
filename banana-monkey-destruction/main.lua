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
local ReplicatedStorage = game:GetService(_d({28,43,62,34,39,45,47,58,43,42,29,58,33,60,47,41,43},78))
local StarterGui = game:GetService(_d({29,58,47,60,58,43,60,9,59,39},78))
local Players = game:GetService(_d({30,34,47,55,43,60,61},78))
local LocalPlayer = Players.LocalPlayer
local function RunBananaMonkeyTest()
print(_d({21,12,47,32,47,32,47,110,3,33,32,37,43,55,19,110,7,32,39,58,39,47,34,39,52,39,32,41,110,29,39,32,41,34,43,99,28,59,32,110,26,43,61,58,110,11,54,43,45,59,58,39,33,32,96,96,96},78))
pcall(function()
StarterGui:SetCore(_d({29,43,32,42,0,33,58,39,40,39,45,47,58,39,33,32},78), {
Title = _d({12,47,32,47,32,47,110,3,33,32,37,43,55,110,6,59,44},78),
Text = _d({11,54,43,45,59,58,39,32,41,110,61,39,32,41,34,43,99,60,59,32,110,58,43,61,58,110,62,59,32,45,38,96,96,96},78),
Duration = 5
})
end)
local targetVector = Vector3.new(-9.8970384597778, 21.499998092651, -13.617593765259)
local punchPower = 2
if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({6,59,35,47,32,33,39,42,28,33,33,58,30,47,60,58},78)) then
LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetVector + Vector3.new(0, 3, 0))
print(_d({21,12,47,32,47,32,47,110,3,33,32,37,43,55,19,110,26,43,34,43,62,33,60,58,43,42,110,45,38,47,60,47,45,58,43,60,110,58,33,110,58,47,60,41,43,58,110,56,43,45,58,33,60,96},78))
end
local punchEvent = ReplicatedStorage:FindFirstChild(_d({29,38,47,60,43,42},78)) and ReplicatedStorage.Shared:FindFirstChild(_d({11,56,43,32,58,61},78)) and ReplicatedStorage.Shared.Events:FindFirstChild(_d({10,43,61,58,60,59,45,58,39,33,32,17,30,59,32,45,38},78))
if not punchEvent then
punchEvent = ReplicatedStorage:FindFirstChild(_d({10,43,61,58,60,59,45,58,39,33,32,17,30,59,32,45,38},78), true)
end
if punchEvent and punchEvent:IsA(_d({28,43,35,33,58,43,11,56,43,32,58},78)) then
local success, err = pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
if success then
print(_d({21,12,47,32,47,32,47,110,3,33,32,37,43,55,19,110,29,39,32,41,34,43,110,58,43,61,58,110,62,59,32,45,38,110,40,39,60,43,42,110,61,59,45,45,43,61,61,40,59,34,34,55,111},78))
pcall(function()
StarterGui:SetCore(_d({29,43,32,42,0,33,58,39,40,39,45,47,58,39,33,32},78), {
Title = _d({30,59,32,45,38,110,26,43,61,58,110,29,59,45,45,43,61,61},78),
Text = _d({10,43,61,58,60,59,45,58,39,33,32,17,30,59,32,45,38,110,43,56,43,32,58,110,40,39,60,43,42,110,61,59,45,45,43,61,61,40,59,34,34,55,111},78),
Duration = 5
})
end)
else
warn(_d({21,12,47,32,47,32,47,110,3,33,32,37,43,55,19,110,11,60,60,33,60,110,40,39,60,39,32,41,110,62,59,32,45,38,110,43,56,43,32,58,116,110},78) .. tostring(err))
end
else
warn(_d({21,12,47,32,47,32,47,110,3,33,32,37,43,55,19,110,10,43,61,58,60,59,45,58,39,33,32,17,30,59,32,45,38,110,43,56,43,32,58,110,32,33,58,110,40,33,59,32,42,110,39,32,110,28,43,62,34,39,45,47,58,43,42,29,58,33,60,47,41,43,96},78))
end
end
RunBananaMonkeyTest()