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
local npcsFolder = workspace:FindFirstChild(_d({27,29,16,64},51))
if not npcsFolder then
print(_d({40,27,29,16,237,18,69,61,60,63,65,50,63,42,237,244,27,29,16,64,244,237,51,60,57,49,50,63,237,59,60,65,237,51,60,66,59,49,237,54,59,237,68,60,63,56,64,61,46,48,50,238},51))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({26,60,49,50,57},51)) and npc.Name ~= "" then
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
error(_d({16,57,54,61,47,60,46,63,49,237,51,66,59,48,65,54,60,59,237,59,60,65,237,64,66,61,61,60,63,65,50,49,237,47,70,237,65,53,54,64,237,50,69,50,48,66,65,60,63,251},51))
end
end)
if success then
print(_d({40,27,29,16,237,18,69,61,60,63,65,50,63,42,237,32,66,48,48,50,64,64,51,66,57,57,70,237,48,60,61,54,50,49,237},51) .. #npcList .. _d({237,66,59,54,62,66,50,237,27,29,16,237,59,46,58,50,64,237,65,60,237,70,60,66,63,237,48,57,54,61,47,60,46,63,49,238},51))
print("NPCs found:\n" .. outputText)
else
warn(_d({40,27,29,16,237,18,69,61,60,63,65,50,63,42,237,19,46,54,57,50,49,237,65,60,237,48,60,61,70,237,65,60,237,48,57,54,61,47,60,46,63,49,7,237},51) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()