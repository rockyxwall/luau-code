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
local npcsFolder = workspace:FindFirstChild(_d({17,19,6,54},61))
if not npcsFolder then
print(_d({30,17,19,6,227,8,59,51,50,53,55,40,53,32,227,234,17,19,6,54,234,227,41,50,47,39,40,53,227,49,50,55,227,41,50,56,49,39,227,44,49,227,58,50,53,46,54,51,36,38,40,228},61))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({16,50,39,40,47},61)) and npc.Name ~= "" then
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
error(_d({6,47,44,51,37,50,36,53,39,227,41,56,49,38,55,44,50,49,227,49,50,55,227,54,56,51,51,50,53,55,40,39,227,37,60,227,55,43,44,54,227,40,59,40,38,56,55,50,53,241},61))
end
end)
if success then
print(_d({30,17,19,6,227,8,59,51,50,53,55,40,53,32,227,22,56,38,38,40,54,54,41,56,47,47,60,227,38,50,51,44,40,39,227},61) .. #npcList .. _d({227,56,49,44,52,56,40,227,17,19,6,227,49,36,48,40,54,227,55,50,227,60,50,56,53,227,38,47,44,51,37,50,36,53,39,228},61))
print("NPCs found:\n" .. outputText)
else
warn(_d({30,17,19,6,227,8,59,51,50,53,55,40,53,32,227,9,36,44,47,40,39,227,55,50,227,38,50,51,60,227,55,50,227,38,47,44,51,37,50,36,53,39,253,227},61) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()