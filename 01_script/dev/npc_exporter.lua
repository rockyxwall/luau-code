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
local npcsFolder = workspace:FindFirstChild(_d({28,30,17,65},50))
if not npcsFolder then
print(_d({41,28,30,17,238,19,70,62,61,64,66,51,64,43,238,245,28,30,17,65,245,238,52,61,58,50,51,64,238,60,61,66,238,52,61,67,60,50,238,55,60,238,69,61,64,57,65,62,47,49,51,239},50))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({27,61,50,51,58},50)) and npc.Name ~= "" then
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
error(_d({17,58,55,62,48,61,47,64,50,238,52,67,60,49,66,55,61,60,238,60,61,66,238,65,67,62,62,61,64,66,51,50,238,48,71,238,66,54,55,65,238,51,70,51,49,67,66,61,64,252},50))
end
end)
if success then
print(_d({41,28,30,17,238,19,70,62,61,64,66,51,64,43,238,33,67,49,49,51,65,65,52,67,58,58,71,238,49,61,62,55,51,50,238},50) .. #npcList .. _d({238,67,60,55,63,67,51,238,28,30,17,238,60,47,59,51,65,238,66,61,238,71,61,67,64,238,49,58,55,62,48,61,47,64,50,239},50))
print("NPCs found:\n" .. outputText)
else
warn(_d({41,28,30,17,238,19,70,62,61,64,66,51,64,43,238,20,47,55,58,51,50,238,66,61,238,49,61,62,71,238,66,61,238,49,58,55,62,48,61,47,64,50,8,238},50) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()