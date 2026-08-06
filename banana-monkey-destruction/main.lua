(function()
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char(b[i] + k)
end
return _concat(t)
end
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local StarterGui = game:GetService(_d({32,65,46,63,65,50,63,20,66,54},51))
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local function RunBananaMonkeyTest()
print(_d({40,15,46,59,46,59,46,-19,26,60,59,56,50,70,42,-19,22,59,54,65,54,46,57,54,71,54,59,52,-19,32,54,59,52,57,50,-6,31,66,59,-19,33,50,64,65,-19,18,69,50,48,66,65,54,60,59,-5,-5,-5},51))
task.spawn(function()
for _ = 1, 5 do
local ok = pcall(function()
StarterGui:SetCore(_d({32,50,59,49,27,60,65,54,51,54,48,46,65,54,60,59},51), {
Title = _d({15,46,59,46,59,46,-19,26,60,59,56,50,70,-19,21,66,47},51),
Text = _d({18,69,50,48,66,65,54,59,52,-19,64,54,59,52,57,50,-6,63,66,59,-19,65,50,64,65,-19,61,66,59,48,53,-5,-5,-5},51),
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
local root = character:WaitForChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51), 3)
if root then
root.CFrame = CFrame.new(targetVector + Vector3.new(0, 3, 0))
print(_d({40,15,46,59,46,59,46,-19,26,60,59,56,50,70,42,-19,33,50,57,50,61,60,63,65,50,49,-19,48,53,46,63,46,48,65,50,63,-19,65,60,-19,65,46,63,52,50,65,-19,67,50,48,65,60,63,-5},51))
end
end
local punchEvent = ReplicatedStorage:FindFirstChild(_d({17,50,64,65,63,66,48,65,54,60,59,44,29,66,59,48,53},51), true)
if punchEvent and punchEvent:IsA(_d({31,50,58,60,65,50,18,67,50,59,65},51)) then
local success, err = pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
if success then
print(_d({40,15,46,59,46,59,46,-19,26,60,59,56,50,70,42,-19,32,54,59,52,57,50,-19,65,50,64,65,-19,61,66,59,48,53,-19,51,54,63,50,49,-19,64,66,48,48,50,64,64,51,66,57,57,70,-18},51))
pcall(function()
StarterGui:SetCore(_d({32,50,59,49,27,60,65,54,51,54,48,46,65,54,60,59},51), {
Title = _d({29,66,59,48,53,-19,33,50,64,65,-19,32,66,48,48,50,64,64},51),
Text = _d({17,50,64,65,63,66,48,65,54,60,59,44,29,66,59,48,53,-19,50,67,50,59,65,-19,51,54,63,50,49,-19,64,66,48,48,50,64,64,51,66,57,57,70,-18},51),
Duration = 5
})
end)
else
warn(_d({40,15,46,59,46,59,46,-19,26,60,59,56,50,70,42,-19,18,63,63,60,63,-19,51,54,63,54,59,52,-19,61,66,59,48,53,-19,50,67,50,59,65,7,-19},51) .. tostring(err))
end
else
warn(_d({40,15,46,59,46,59,46,-19,26,60,59,56,50,70,42,-19,17,50,64,65,63,66,48,65,54,60,59,44,29,66,59,48,53,-19,50,67,50,59,65,-19,59,60,65,-19,51,60,66,59,49,-19,54,59,-19,31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50,-5},51))
end
end
task.spawn(RunBananaMonkeyTest)
end)()