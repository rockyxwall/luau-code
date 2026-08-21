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
local npcsFolder = workspace:FindFirstChild(_d({16,18,5,53},62))
if not npcsFolder then
print(_d({29,16,18,5,226,7,58,50,49,52,54,39,52,31,226,233,16,18,5,53,233,226,40,49,46,38,39,52,226,48,49,54,226,40,49,55,48,38,226,43,48,226,57,49,52,45,53,50,35,37,39,227},62))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({15,49,38,39,46},62)) and npc.Name ~= "" then
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
error(_d({5,46,43,50,36,49,35,52,38,226,40,55,48,37,54,43,49,48,226,48,49,54,226,53,55,50,50,49,52,54,39,38,226,36,59,226,54,42,43,53,226,39,58,39,37,55,54,49,52,240},62))
end
end)
if success then
print(_d({29,16,18,5,226,7,58,50,49,52,54,39,52,31,226,21,55,37,37,39,53,53,40,55,46,46,59,226,37,49,50,43,39,38,226},62) .. #npcList .. _d({226,55,48,43,51,55,39,226,16,18,5,226,48,35,47,39,53,226,54,49,226,59,49,55,52,226,37,46,43,50,36,49,35,52,38,227},62))
print("NPCs found:\n" .. outputText)
else
warn(_d({29,16,18,5,226,7,58,50,49,52,54,39,52,31,226,8,35,43,46,39,38,226,54,49,226,37,49,50,59,226,54,49,226,37,46,43,50,36,49,35,52,38,252,226},62) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()