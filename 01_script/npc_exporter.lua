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
local npcsFolder = workspace:FindFirstChild(_d({43,45,32,80},35))
if not npcsFolder then
print(_d({56,43,45,32,253,34,85,77,76,79,81,66,79,58,253,4,43,45,32,80,4,253,67,76,73,65,66,79,253,75,76,81,253,67,76,82,75,65,253,70,75,253,84,76,79,72,80,77,62,64,66,254},35))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({42,76,65,66,73},35)) and npc.Name ~= "" then
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
error(_d({32,73,70,77,63,76,62,79,65,253,67,82,75,64,81,70,76,75,253,75,76,81,253,80,82,77,77,76,79,81,66,65,253,63,86,253,81,69,70,80,253,66,85,66,64,82,81,76,79,11},35))
end
end)
if success then
print(_d({56,43,45,32,253,34,85,77,76,79,81,66,79,58,253,48,82,64,64,66,80,80,67,82,73,73,86,253,64,76,77,70,66,65,253},35) .. #npcList .. _d({253,82,75,70,78,82,66,253,43,45,32,253,75,62,74,66,80,253,81,76,253,86,76,82,79,253,64,73,70,77,63,76,62,79,65,254},35))
print("NPCs found:\n" .. outputText)
else
warn(_d({56,43,45,32,253,34,85,77,76,79,81,66,79,58,253,35,62,70,73,66,65,253,81,76,253,64,76,77,86,253,81,76,253,64,73,70,77,63,76,62,79,65,23,253},35) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()