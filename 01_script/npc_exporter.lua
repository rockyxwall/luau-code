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
local npcsFolder = workspace:FindFirstChild(_d({26,28,15,63},52))
if not npcsFolder then
print(_d({39,26,28,15,236,17,68,60,59,62,64,49,62,41,236,243,26,28,15,63,243,236,50,59,56,48,49,62,236,58,59,64,236,50,59,65,58,48,236,53,58,236,67,59,62,55,63,60,45,47,49,237},52))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({25,59,48,49,56},52)) and npc.Name ~= "" then
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
error(_d({15,56,53,60,46,59,45,62,48,236,50,65,58,47,64,53,59,58,236,58,59,64,236,63,65,60,60,59,62,64,49,48,236,46,69,236,64,52,53,63,236,49,68,49,47,65,64,59,62,250},52))
end
end)
if success then
print(_d({39,26,28,15,236,17,68,60,59,62,64,49,62,41,236,31,65,47,47,49,63,63,50,65,56,56,69,236,47,59,60,53,49,48,236},52) .. #npcList .. _d({236,65,58,53,61,65,49,236,26,28,15,236,58,45,57,49,63,236,64,59,236,69,59,65,62,236,47,56,53,60,46,59,45,62,48,237},52))
print("NPCs found:\n" .. outputText)
else
warn(_d({39,26,28,15,236,17,68,60,59,62,64,49,62,41,236,18,45,53,56,49,48,236,64,59,236,47,59,60,69,236,64,59,236,47,56,53,60,46,59,45,62,48,6,236},52) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()