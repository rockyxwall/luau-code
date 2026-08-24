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
local npcsFolder = workspace:FindFirstChild(_d({23,25,12,60},55))
if not npcsFolder then
print(_d({36,23,25,12,233,14,65,57,56,59,61,46,59,38,233,240,23,25,12,60,240,233,47,56,53,45,46,59,233,55,56,61,233,47,56,62,55,45,233,50,55,233,64,56,59,52,60,57,42,44,46,234},55))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({22,56,45,46,53},55)) and npc.Name ~= "" then
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
error(_d({12,53,50,57,43,56,42,59,45,233,47,62,55,44,61,50,56,55,233,55,56,61,233,60,62,57,57,56,59,61,46,45,233,43,66,233,61,49,50,60,233,46,65,46,44,62,61,56,59,247},55))
end
end)
if success then
print(_d({36,23,25,12,233,14,65,57,56,59,61,46,59,38,233,28,62,44,44,46,60,60,47,62,53,53,66,233,44,56,57,50,46,45,233},55) .. #npcList .. _d({233,62,55,50,58,62,46,233,23,25,12,233,55,42,54,46,60,233,61,56,233,66,56,62,59,233,44,53,50,57,43,56,42,59,45,234},55))
print("NPCs found:\n" .. outputText)
else
warn(_d({36,23,25,12,233,14,65,57,56,59,61,46,59,38,233,15,42,50,53,46,45,233,61,56,233,44,56,57,66,233,61,56,233,44,53,50,57,43,56,42,59,45,3,233},55) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()