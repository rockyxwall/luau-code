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
local npcsFolder = workspace:FindFirstChild(_d({47,49,36,84},31))
if not npcsFolder then
print(_d({60,47,49,36,1,38,89,81,80,83,85,70,83,62,1,8,47,49,36,84,8,1,71,80,77,69,70,83,1,79,80,85,1,71,80,86,79,69,1,74,79,1,88,80,83,76,84,81,66,68,70,2},31))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({46,80,69,70,77},31)) and npc.Name ~= "" then
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
error(_d({36,77,74,81,67,80,66,83,69,1,71,86,79,68,85,74,80,79,1,79,80,85,1,84,86,81,81,80,83,85,70,69,1,67,90,1,85,73,74,84,1,70,89,70,68,86,85,80,83,15},31))
end
end)
if success then
print(_d({60,47,49,36,1,38,89,81,80,83,85,70,83,62,1,52,86,68,68,70,84,84,71,86,77,77,90,1,68,80,81,74,70,69,1},31) .. #npcList .. _d({1,86,79,74,82,86,70,1,47,49,36,1,79,66,78,70,84,1,85,80,1,90,80,86,83,1,68,77,74,81,67,80,66,83,69,2},31))
print("NPCs found:\n" .. outputText)
else
warn(_d({60,47,49,36,1,38,89,81,80,83,85,70,83,62,1,39,66,74,77,70,69,1,85,80,1,68,80,81,90,1,85,80,1,68,77,74,81,67,80,66,83,69,27,1},31) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()