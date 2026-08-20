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
local npcsFolder = workspace:FindFirstChild(_d({20,22,9,57},58))
if not npcsFolder then
print(_d({33,20,22,9,230,11,62,54,53,56,58,43,56,35,230,237,20,22,9,57,237,230,44,53,50,42,43,56,230,52,53,58,230,44,53,59,52,42,230,47,52,230,61,53,56,49,57,54,39,41,43,231},58))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({19,53,42,43,50},58)) and npc.Name ~= "" then
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
error(_d({9,50,47,54,40,53,39,56,42,230,44,59,52,41,58,47,53,52,230,52,53,58,230,57,59,54,54,53,56,58,43,42,230,40,63,230,58,46,47,57,230,43,62,43,41,59,58,53,56,244},58))
end
end)
if success then
print(_d({33,20,22,9,230,11,62,54,53,56,58,43,56,35,230,25,59,41,41,43,57,57,44,59,50,50,63,230,41,53,54,47,43,42,230},58) .. #npcList .. _d({230,59,52,47,55,59,43,230,20,22,9,230,52,39,51,43,57,230,58,53,230,63,53,59,56,230,41,50,47,54,40,53,39,56,42,231},58))
print("NPCs found:\n" .. outputText)
else
warn(_d({33,20,22,9,230,11,62,54,53,56,58,43,56,35,230,12,39,47,50,43,42,230,58,53,230,41,53,54,63,230,58,53,230,41,50,47,54,40,53,39,56,42,0,230},58) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()