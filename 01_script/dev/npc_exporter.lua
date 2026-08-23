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
local npcsFolder = workspace:FindFirstChild(_d({22,24,11,59},56))
if not npcsFolder then
print(_d({35,22,24,11,232,13,64,56,55,58,60,45,58,37,232,239,22,24,11,59,239,232,46,55,52,44,45,58,232,54,55,60,232,46,55,61,54,44,232,49,54,232,63,55,58,51,59,56,41,43,45,233},56))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({21,55,44,45,52},56)) and npc.Name ~= "" then
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
error(_d({11,52,49,56,42,55,41,58,44,232,46,61,54,43,60,49,55,54,232,54,55,60,232,59,61,56,56,55,58,60,45,44,232,42,65,232,60,48,49,59,232,45,64,45,43,61,60,55,58,246},56))
end
end)
if success then
print(_d({35,22,24,11,232,13,64,56,55,58,60,45,58,37,232,27,61,43,43,45,59,59,46,61,52,52,65,232,43,55,56,49,45,44,232},56) .. #npcList .. _d({232,61,54,49,57,61,45,232,22,24,11,232,54,41,53,45,59,232,60,55,232,65,55,61,58,232,43,52,49,56,42,55,41,58,44,233},56))
print("NPCs found:\n" .. outputText)
else
warn(_d({35,22,24,11,232,13,64,56,55,58,60,45,58,37,232,14,41,49,52,45,44,232,60,55,232,43,55,56,65,232,60,55,232,43,52,49,56,42,55,41,58,44,2,232},56) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()