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
local npcsFolder = workspace:FindFirstChild(_d({42,44,31,79},36))
if not npcsFolder then
print(_d({55,42,44,31,252,33,84,76,75,78,80,65,78,57,252,3,42,44,31,79,3,252,66,75,72,64,65,78,252,74,75,80,252,66,75,81,74,64,252,69,74,252,83,75,78,71,79,76,61,63,65,253},36))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({41,75,64,65,72},36)) and npc.Name ~= "" then
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
error(_d({31,72,69,76,62,75,61,78,64,252,66,81,74,63,80,69,75,74,252,74,75,80,252,79,81,76,76,75,78,80,65,64,252,62,85,252,80,68,69,79,252,65,84,65,63,81,80,75,78,10},36))
end
end)
if success then
print(_d({55,42,44,31,252,33,84,76,75,78,80,65,78,57,252,47,81,63,63,65,79,79,66,81,72,72,85,252,63,75,76,69,65,64,252},36) .. #npcList .. _d({252,81,74,69,77,81,65,252,42,44,31,252,74,61,73,65,79,252,80,75,252,85,75,81,78,252,63,72,69,76,62,75,61,78,64,253},36))
print("NPCs found:\n" .. outputText)
else
warn(_d({55,42,44,31,252,33,84,76,75,78,80,65,78,57,252,34,61,69,72,65,64,252,80,75,252,63,75,76,85,252,80,75,252,63,72,69,76,62,75,61,78,64,22,252},36) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()