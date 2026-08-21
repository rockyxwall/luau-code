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
local npcsFolder = workspace:FindFirstChild(_d({45,47,34,82},33))
if not npcsFolder then
print(_d({58,45,47,34,255,36,87,79,78,81,83,68,81,60,255,6,45,47,34,82,6,255,69,78,75,67,68,81,255,77,78,83,255,69,78,84,77,67,255,72,77,255,86,78,81,74,82,79,64,66,68,0},33))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({44,78,67,68,75},33)) and npc.Name ~= "" then
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
error(_d({34,75,72,79,65,78,64,81,67,255,69,84,77,66,83,72,78,77,255,77,78,83,255,82,84,79,79,78,81,83,68,67,255,65,88,255,83,71,72,82,255,68,87,68,66,84,83,78,81,13},33))
end
end)
if success then
print(_d({58,45,47,34,255,36,87,79,78,81,83,68,81,60,255,50,84,66,66,68,82,82,69,84,75,75,88,255,66,78,79,72,68,67,255},33) .. #npcList .. _d({255,84,77,72,80,84,68,255,45,47,34,255,77,64,76,68,82,255,83,78,255,88,78,84,81,255,66,75,72,79,65,78,64,81,67,0},33))
print("NPCs found:\n" .. outputText)
else
warn(_d({58,45,47,34,255,36,87,79,78,81,83,68,81,60,255,37,64,72,75,68,67,255,83,78,255,66,78,79,88,255,83,78,255,66,75,72,79,65,78,64,81,67,25,255},33) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()