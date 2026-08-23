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
local npcsFolder = workspace:FindFirstChild(_d({46,48,35,83},32))
if not npcsFolder then
print(_d({59,46,48,35,0,37,88,80,79,82,84,69,82,61,0,7,46,48,35,83,7,0,70,79,76,68,69,82,0,78,79,84,0,70,79,85,78,68,0,73,78,0,87,79,82,75,83,80,65,67,69,1},32))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({45,79,68,69,76},32)) and npc.Name ~= "" then
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
error(_d({35,76,73,80,66,79,65,82,68,0,70,85,78,67,84,73,79,78,0,78,79,84,0,83,85,80,80,79,82,84,69,68,0,66,89,0,84,72,73,83,0,69,88,69,67,85,84,79,82,14},32))
end
end)
if success then
print(_d({59,46,48,35,0,37,88,80,79,82,84,69,82,61,0,51,85,67,67,69,83,83,70,85,76,76,89,0,67,79,80,73,69,68,0},32) .. #npcList .. _d({0,85,78,73,81,85,69,0,46,48,35,0,78,65,77,69,83,0,84,79,0,89,79,85,82,0,67,76,73,80,66,79,65,82,68,1},32))
print("NPCs found:\n" .. outputText)
else
warn(_d({59,46,48,35,0,37,88,80,79,82,84,69,82,61,0,38,65,73,76,69,68,0,84,79,0,67,79,80,89,0,84,79,0,67,76,73,80,66,79,65,82,68,26,0},32) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()