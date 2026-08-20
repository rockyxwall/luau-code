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
local npcsFolder = workspace:FindFirstChild(_d({37,39,26,74},41))
if not npcsFolder then
print(_d({50,37,39,26,247,28,79,71,70,73,75,60,73,52,247,254,37,39,26,74,254,247,61,70,67,59,60,73,247,69,70,75,247,61,70,76,69,59,247,64,69,247,78,70,73,66,74,71,56,58,60,248},41))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({36,70,59,60,67},41)) and npc.Name ~= "" then
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
error(_d({26,67,64,71,57,70,56,73,59,247,61,76,69,58,75,64,70,69,247,69,70,75,247,74,76,71,71,70,73,75,60,59,247,57,80,247,75,63,64,74,247,60,79,60,58,76,75,70,73,5},41))
end
end)
if success then
print(_d({50,37,39,26,247,28,79,71,70,73,75,60,73,52,247,42,76,58,58,60,74,74,61,76,67,67,80,247,58,70,71,64,60,59,247},41) .. #npcList .. _d({247,76,69,64,72,76,60,247,37,39,26,247,69,56,68,60,74,247,75,70,247,80,70,76,73,247,58,67,64,71,57,70,56,73,59,248},41))
print("NPCs found:\n" .. outputText)
else
warn(_d({50,37,39,26,247,28,79,71,70,73,75,60,73,52,247,29,56,64,67,60,59,247,75,70,247,58,70,71,80,247,75,70,247,58,67,64,71,57,70,56,73,59,17,247},41) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()