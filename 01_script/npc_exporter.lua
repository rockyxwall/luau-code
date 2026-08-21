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
local npcsFolder = workspace:FindFirstChild(_d({56,58,45,93},22))
if not npcsFolder then
print(_d({69,56,58,45,10,47,98,90,89,92,94,79,92,71,10,17,56,58,45,93,17,10,80,89,86,78,79,92,10,88,89,94,10,80,89,95,88,78,10,83,88,10,97,89,92,85,93,90,75,77,79,11},22))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({55,89,78,79,86},22)) and npc.Name ~= "" then
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
error(_d({45,86,83,90,76,89,75,92,78,10,80,95,88,77,94,83,89,88,10,88,89,94,10,93,95,90,90,89,92,94,79,78,10,76,99,10,94,82,83,93,10,79,98,79,77,95,94,89,92,24},22))
end
end)
if success then
print(_d({69,56,58,45,10,47,98,90,89,92,94,79,92,71,10,61,95,77,77,79,93,93,80,95,86,86,99,10,77,89,90,83,79,78,10},22) .. #npcList .. _d({10,95,88,83,91,95,79,10,56,58,45,10,88,75,87,79,93,10,94,89,10,99,89,95,92,10,77,86,83,90,76,89,75,92,78,11},22))
print("NPCs found:\n" .. outputText)
else
warn(_d({69,56,58,45,10,47,98,90,89,92,94,79,92,71,10,48,75,83,86,79,78,10,94,89,10,77,89,90,99,10,94,89,10,77,86,83,90,76,89,75,92,78,36,10},22) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()