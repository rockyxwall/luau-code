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
local npcsFolder = workspace:FindFirstChild(_d({18,20,7,55},60))
if not npcsFolder then
print(_d({31,18,20,7,228,9,60,52,51,54,56,41,54,33,228,235,18,20,7,55,235,228,42,51,48,40,41,54,228,50,51,56,228,42,51,57,50,40,228,45,50,228,59,51,54,47,55,52,37,39,41,229},60))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({17,51,40,41,48},60)) and npc.Name ~= "" then
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
error(_d({7,48,45,52,38,51,37,54,40,228,42,57,50,39,56,45,51,50,228,50,51,56,228,55,57,52,52,51,54,56,41,40,228,38,61,228,56,44,45,55,228,41,60,41,39,57,56,51,54,242},60))
end
end)
if success then
print(_d({31,18,20,7,228,9,60,52,51,54,56,41,54,33,228,23,57,39,39,41,55,55,42,57,48,48,61,228,39,51,52,45,41,40,228},60) .. #npcList .. _d({228,57,50,45,53,57,41,228,18,20,7,228,50,37,49,41,55,228,56,51,228,61,51,57,54,228,39,48,45,52,38,51,37,54,40,229},60))
print("NPCs found:\n" .. outputText)
else
warn(_d({31,18,20,7,228,9,60,52,51,54,56,41,54,33,228,10,37,45,48,41,40,228,56,51,228,39,51,52,61,228,56,51,228,39,48,45,52,38,51,37,54,40,254,228},60) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()