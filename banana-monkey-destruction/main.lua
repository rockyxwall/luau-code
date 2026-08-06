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
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local StarterGui = game:GetService(_d({55,88,69,86,88,73,86,43,89,77},28))
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local function RunBananaMonkeyTest()
print(_d({63,38,69,82,69,82,69,4,49,83,82,79,73,93,65,4,45,82,77,88,77,69,80,77,94,77,82,75,4,55,77,82,75,80,73,17,54,89,82,4,56,73,87,88,4,41,92,73,71,89,88,77,83,82,18,18,18},28))
task.spawn(function()
for _ = 1, 5 do
local ok = pcall(function()
StarterGui:SetCore(_d({55,73,82,72,50,83,88,77,74,77,71,69,88,77,83,82},28), {
Title = _d({38,69,82,69,82,69,4,49,83,82,79,73,93,4,44,89,70},28),
Text = _d({41,92,73,71,89,88,77,82,75,4,87,77,82,75,80,73,17,86,89,82,4,88,73,87,88,4,84,89,82,71,76,18,18,18},28),
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
local root = character:WaitForChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28), 3)
if root then
root.CFrame = CFrame.new(targetVector + Vector3.new(0, 3, 0))
print(_d({63,38,69,82,69,82,69,4,49,83,82,79,73,93,65,4,56,73,80,73,84,83,86,88,73,72,4,71,76,69,86,69,71,88,73,86,4,88,83,4,88,69,86,75,73,88,4,90,73,71,88,83,86,18},28))
end
end
local punchEvent = ReplicatedStorage:FindFirstChild(_d({40,73,87,88,86,89,71,88,77,83,82,67,52,89,82,71,76},28), true)
if punchEvent and punchEvent:IsA(_d({54,73,81,83,88,73,41,90,73,82,88},28)) then
local success, err = pcall(function()
punchEvent:FireServer(punchPower, targetVector)
end)
if success then
print(_d({63,38,69,82,69,82,69,4,49,83,82,79,73,93,65,4,55,77,82,75,80,73,4,88,73,87,88,4,84,89,82,71,76,4,74,77,86,73,72,4,87,89,71,71,73,87,87,74,89,80,80,93,5},28))
pcall(function()
StarterGui:SetCore(_d({55,73,82,72,50,83,88,77,74,77,71,69,88,77,83,82},28), {
Title = _d({52,89,82,71,76,4,56,73,87,88,4,55,89,71,71,73,87,87},28),
Text = _d({40,73,87,88,86,89,71,88,77,83,82,67,52,89,82,71,76,4,73,90,73,82,88,4,74,77,86,73,72,4,87,89,71,71,73,87,87,74,89,80,80,93,5},28),
Duration = 5
})
end)
else
warn(_d({63,38,69,82,69,82,69,4,49,83,82,79,73,93,65,4,41,86,86,83,86,4,74,77,86,77,82,75,4,84,89,82,71,76,4,73,90,73,82,88,30,4},28) .. tostring(err))
end
else
warn(_d({63,38,69,82,69,82,69,4,49,83,82,79,73,93,65,4,40,73,87,88,86,89,71,88,77,83,82,67,52,89,82,71,76,4,73,90,73,82,88,4,82,83,88,4,74,83,89,82,72,4,77,82,4,54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73,18},28))
end
end
task.spawn(RunBananaMonkeyTest)
end)()