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
local npcsFolder = workspace:FindFirstChild(_d({34,36,23,71},44))
if not npcsFolder then
print(_d({47,34,36,23,244,25,76,68,67,70,72,57,70,49,244,251,34,36,23,71,251,244,58,67,64,56,57,70,244,66,67,72,244,58,67,73,66,56,244,61,66,244,75,67,70,63,71,68,53,55,57,245},44))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({33,67,56,57,64},44)) and npc.Name ~= "" then
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
error(_d({23,64,61,68,54,67,53,70,56,244,58,73,66,55,72,61,67,66,244,66,67,72,244,71,73,68,68,67,70,72,57,56,244,54,77,244,72,60,61,71,244,57,76,57,55,73,72,67,70,2},44))
end
end)
if success then
print(_d({47,34,36,23,244,25,76,68,67,70,72,57,70,49,244,39,73,55,55,57,71,71,58,73,64,64,77,244,55,67,68,61,57,56,244},44) .. #npcList .. _d({244,73,66,61,69,73,57,244,34,36,23,244,66,53,65,57,71,244,72,67,244,77,67,73,70,244,55,64,61,68,54,67,53,70,56,245},44))
print("NPCs found:\n" .. outputText)
else
warn(_d({47,34,36,23,244,25,76,68,67,70,72,57,70,49,244,26,53,61,64,57,56,244,72,67,244,55,67,68,77,244,72,67,244,55,64,61,68,54,67,53,70,56,14,244},44) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()