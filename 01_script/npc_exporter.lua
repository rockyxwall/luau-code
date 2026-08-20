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
local npcsFolder = workspace:FindFirstChild(_d({38,40,27,75},40))
if not npcsFolder then
print(_d({51,38,40,27,248,29,80,72,71,74,76,61,74,53,248,255,38,40,27,75,255,248,62,71,68,60,61,74,248,70,71,76,248,62,71,77,70,60,248,65,70,248,79,71,74,67,75,72,57,59,61,249},40))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({37,71,60,61,68},40)) and npc.Name ~= "" then
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
error(_d({27,68,65,72,58,71,57,74,60,248,62,77,70,59,76,65,71,70,248,70,71,76,248,75,77,72,72,71,74,76,61,60,248,58,81,248,76,64,65,75,248,61,80,61,59,77,76,71,74,6},40))
end
end)
if success then
print(_d({51,38,40,27,248,29,80,72,71,74,76,61,74,53,248,43,77,59,59,61,75,75,62,77,68,68,81,248,59,71,72,65,61,60,248},40) .. #npcList .. _d({248,77,70,65,73,77,61,248,38,40,27,248,70,57,69,61,75,248,76,71,248,81,71,77,74,248,59,68,65,72,58,71,57,74,60,249},40))
print("NPCs found:\n" .. outputText)
else
warn(_d({51,38,40,27,248,29,80,72,71,74,76,61,74,53,248,30,57,65,68,61,60,248,76,71,248,59,71,72,81,248,76,71,248,59,68,65,72,58,71,57,74,60,18,248},40) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()