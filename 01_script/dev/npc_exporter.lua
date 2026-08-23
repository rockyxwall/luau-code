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
local npcsFolder = workspace:FindFirstChild(_d({49,51,38,86},29))
if not npcsFolder then
print(_d({62,49,51,38,3,40,91,83,82,85,87,72,85,64,3,10,49,51,38,86,10,3,73,82,79,71,72,85,3,81,82,87,3,73,82,88,81,71,3,76,81,3,90,82,85,78,86,83,68,70,72,4},29))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({48,82,71,72,79},29)) and npc.Name ~= "" then
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
error(_d({38,79,76,83,69,82,68,85,71,3,73,88,81,70,87,76,82,81,3,81,82,87,3,86,88,83,83,82,85,87,72,71,3,69,92,3,87,75,76,86,3,72,91,72,70,88,87,82,85,17},29))
end
end)
if success then
print(_d({62,49,51,38,3,40,91,83,82,85,87,72,85,64,3,54,88,70,70,72,86,86,73,88,79,79,92,3,70,82,83,76,72,71,3},29) .. #npcList .. _d({3,88,81,76,84,88,72,3,49,51,38,3,81,68,80,72,86,3,87,82,3,92,82,88,85,3,70,79,76,83,69,82,68,85,71,4},29))
print("NPCs found:\n" .. outputText)
else
warn(_d({62,49,51,38,3,40,91,83,82,85,87,72,85,64,3,41,68,76,79,72,71,3,87,82,3,70,82,83,92,3,87,82,3,70,79,76,83,69,82,68,85,71,29,3},29) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()