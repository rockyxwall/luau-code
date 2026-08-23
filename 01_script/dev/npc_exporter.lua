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
local npcsFolder = workspace:FindFirstChild(_d({54,56,43,91},24))
if not npcsFolder then
print(_d({67,54,56,43,8,45,96,88,87,90,92,77,90,69,8,15,54,56,43,91,15,8,78,87,84,76,77,90,8,86,87,92,8,78,87,93,86,76,8,81,86,8,95,87,90,83,91,88,73,75,77,9},24))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({53,87,76,77,84},24)) and npc.Name ~= "" then
uniqueNPCs[npc.Name] = true
end
end
local npcList = {}
for name, _ in pairs(uniqueNPCs) do
table.insert(npcList, name)
end
table.sort(npcList)
local outputText = table.concat(npcList, "\n")
local success, err = pcall(function()
if setclipboard then
setclipboard(outputText)
elseif toclipboard then
toclipboard(outputText)
else
error(_d({43,84,81,88,74,87,73,90,76,8,78,93,86,75,92,81,87,86,8,86,87,92,8,91,93,88,88,87,90,92,77,76,8,74,97,8,92,80,81,91,8,77,96,77,75,93,92,87,90,22},24))
end
end)
if success then
print(_d({67,54,56,43,8,45,96,88,87,90,92,77,90,69,8,59,93,75,75,77,91,91,78,93,84,84,97,8,75,87,88,81,77,76,8},24) .. #npcList .. _d({8,93,86,81,89,93,77,8,54,56,43,8,86,73,85,77,91,8,92,87,8,97,87,93,90,8,75,84,81,88,74,87,73,90,76,9},24))
print("NPCs found:\n" .. outputText)
else
warn(_d({67,54,56,43,8,45,96,88,87,90,92,77,90,69,8,46,73,81,84,77,76,8,92,87,8,75,87,88,97,8,92,87,8,75,84,81,88,74,87,73,90,76,34,8},24) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()