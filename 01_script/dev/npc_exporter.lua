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
local npcsFolder = workspace:FindFirstChild(_d({41,43,30,78},37))
if not npcsFolder then
print(_d({54,41,43,30,251,32,83,75,74,77,79,64,77,56,251,2,41,43,30,78,2,251,65,74,71,63,64,77,251,73,74,79,251,65,74,80,73,63,251,68,73,251,82,74,77,70,78,75,60,62,64,252},37))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({40,74,63,64,71},37)) and npc.Name ~= "" then
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
error(_d({30,71,68,75,61,74,60,77,63,251,65,80,73,62,79,68,74,73,251,73,74,79,251,78,80,75,75,74,77,79,64,63,251,61,84,251,79,67,68,78,251,64,83,64,62,80,79,74,77,9},37))
end
end)
if success then
print(_d({54,41,43,30,251,32,83,75,74,77,79,64,77,56,251,46,80,62,62,64,78,78,65,80,71,71,84,251,62,74,75,68,64,63,251},37) .. #npcList .. _d({251,80,73,68,76,80,64,251,41,43,30,251,73,60,72,64,78,251,79,74,251,84,74,80,77,251,62,71,68,75,61,74,60,77,63,252},37))
print("NPCs found:\n" .. outputText)
else
warn(_d({54,41,43,30,251,32,83,75,74,77,79,64,77,56,251,33,60,68,71,64,63,251,79,74,251,62,74,75,84,251,79,74,251,62,71,68,75,61,74,60,77,63,21,251},37) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()