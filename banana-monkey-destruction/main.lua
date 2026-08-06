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
local ReplicatedStorage = game:GetService(_d({22,33,52,40,45,39,37,48,33,32,23,48,43,54,37,35,33},68))
local StarterGui = game:GetService(_d({23,48,37,54,48,33,54,3,49,45},68))
local Players = game:GetService(_d({20,40,37,61,33,54,55},68))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local function RunBananaMonkeyTest()
print(_d({31,6,37,42,37,42,37,100,9,43,42,47,33,61,25,100,13,42,45,48,45,37,40,45,62,45,42,35,100,23,45,42,35,40,33,105,22,49,42,100,16,33,55,48,100,1,60,33,39,49,48,45,43,42,106,106,106},68))
task.spawn(function()
for _ = 1, 5 do
local ok = pcall(function()
StarterGui:SetCore(_d({23,33,42,32,10,43,48,45,34,45,39,37,48,45,43,42},68), {
Title = _d({6,37,42,37,42,37,100,9,43,42,47,33,61,100,12,49,38},68),
Text = _d({1,60,33,39,49,48,45,42,35,100,55,45,42,35,40,33,105,54,49,42,100,48,33,55,48,100,52,49,42,39,44,106,106,106},68),
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
local root = character:WaitForChild(_d({12,49,41,37,42,43,45,32,22,43,43,48,20,37,54,48},68), 3)
if root then
root.CFrame = CFrame.new(targetVector + Vector3.new(0, 3, 0))
print(_d({31,6,37,42,37,42,37,100,9,43,42,47,33,61,25,100,16,33,40,33,52,43,54,48,33,32,100,39,44,37,54,37,39,48,33,54,100,48,43,100,48,37,54,35,33,48,100,50,33,39,48,43,54,106},68))
end
end
local punchEvent = ReplicatedStorage:FindFirstChild(_d({0,33,55,48,54,49,39,48,45,43,42,27,20,49,42,39,44},68), true)
if punchEvent and punchEvent:IsA(_d({22,33,41,43,48,33,1,50,33,42,48},68)) then
local success, err = pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
if success then
print(_d({31,6,37,42,37,42,37,100,9,43,42,47,33,61,25,100,23,45,42,35,40,33,100,48,33,55,48,100,52,49,42,39,44,100,34,45,54,33,32,100,55,49,39,39,33,55,55,34,49,40,40,61,101},68))
pcall(function()
StarterGui:SetCore(_d({23,33,42,32,10,43,48,45,34,45,39,37,48,45,43,42},68), {
Title = _d({20,49,42,39,44,100,16,33,55,48,100,23,49,39,39,33,55,55},68),
Text = _d({0,33,55,48,54,49,39,48,45,43,42,27,20,49,42,39,44,100,33,50,33,42,48,100,34,45,54,33,32,100,55,49,39,39,33,55,55,34,49,40,40,61,101},68),
Duration = 5
})
end)
else
warn(_d({31,6,37,42,37,42,37,100,9,43,42,47,33,61,25,100,1,54,54,43,54,100,34,45,54,45,42,35,100,52,49,42,39,44,100,33,50,33,42,48,126,100},68) .. tostring(err))
end
else
warn(_d({31,6,37,42,37,42,37,100,9,43,42,47,33,61,25,100,0,33,55,48,54,49,39,48,45,43,42,27,20,49,42,39,44,100,33,50,33,42,48,100,42,43,48,100,34,43,49,42,32,100,45,42,100,22,33,52,40,45,39,37,48,33,32,23,48,43,54,37,35,33,106},68))
end
end
task.spawn(RunBananaMonkeyTest)