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
local npcsFolder = workspace:FindFirstChild(_d({44,46,33,81},34))
if not npcsFolder then
print(_d({57,44,46,33,254,35,86,78,77,80,82,67,80,59,254,5,44,46,33,81,5,254,68,77,74,66,67,80,254,76,77,82,254,68,77,83,76,66,254,71,76,254,85,77,80,73,81,78,63,65,67,255},34))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({43,77,66,67,74},34)) and npc.Name ~= "" then
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
error(_d({33,74,71,78,64,77,63,80,66,254,68,83,76,65,82,71,77,76,254,76,77,82,254,81,83,78,78,77,80,82,67,66,254,64,87,254,82,70,71,81,254,67,86,67,65,83,82,77,80,12},34))
end
end)
if success then
print(_d({57,44,46,33,254,35,86,78,77,80,82,67,80,59,254,49,83,65,65,67,81,81,68,83,74,74,87,254,65,77,78,71,67,66,254},34) .. #npcList .. _d({254,83,76,71,79,83,67,254,44,46,33,254,76,63,75,67,81,254,82,77,254,87,77,83,80,254,65,74,71,78,64,77,63,80,66,255},34))
print("NPCs found:\n" .. outputText)
else
warn(_d({57,44,46,33,254,35,86,78,77,80,82,67,80,59,254,36,63,71,74,67,66,254,82,77,254,65,77,78,87,254,82,77,254,65,74,71,78,64,77,63,80,66,24,254},34) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()