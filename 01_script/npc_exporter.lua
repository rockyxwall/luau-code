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
local npcsFolder = workspace:FindFirstChild(_d({40,42,29,77},38))
if not npcsFolder then
print(_d({53,40,42,29,250,31,82,74,73,76,78,63,76,55,250,1,40,42,29,77,1,250,64,73,70,62,63,76,250,72,73,78,250,64,73,79,72,62,250,67,72,250,81,73,76,69,77,74,59,61,63,251},38))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({39,73,62,63,70},38)) and npc.Name ~= "" then
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
error(_d({29,70,67,74,60,73,59,76,62,250,64,79,72,61,78,67,73,72,250,72,73,78,250,77,79,74,74,73,76,78,63,62,250,60,83,250,78,66,67,77,250,63,82,63,61,79,78,73,76,8},38))
end
end)
if success then
print(_d({53,40,42,29,250,31,82,74,73,76,78,63,76,55,250,45,79,61,61,63,77,77,64,79,70,70,83,250,61,73,74,67,63,62,250},38) .. #npcList .. _d({250,79,72,67,75,79,63,250,40,42,29,250,72,59,71,63,77,250,78,73,250,83,73,79,76,250,61,70,67,74,60,73,59,76,62,251},38))
print("NPCs found:\n" .. outputText)
else
warn(_d({53,40,42,29,250,31,82,74,73,76,78,63,76,55,250,32,59,67,70,63,62,250,78,73,250,61,73,74,83,250,78,73,250,61,70,67,74,60,73,59,76,62,20,250},38) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()