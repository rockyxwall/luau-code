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
local npcsFolder = workspace:FindFirstChild(_d({36,38,25,73},42))
if not npcsFolder then
print(_d({49,36,38,25,246,27,78,70,69,72,74,59,72,51,246,253,36,38,25,73,253,246,60,69,66,58,59,72,246,68,69,74,246,60,69,75,68,58,246,63,68,246,77,69,72,65,73,70,55,57,59,247},42))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({35,69,58,59,66},42)) and npc.Name ~= "" then
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
error(_d({25,66,63,70,56,69,55,72,58,246,60,75,68,57,74,63,69,68,246,68,69,74,246,73,75,70,70,69,72,74,59,58,246,56,79,246,74,62,63,73,246,59,78,59,57,75,74,69,72,4},42))
end
end)
if success then
print(_d({49,36,38,25,246,27,78,70,69,72,74,59,72,51,246,41,75,57,57,59,73,73,60,75,66,66,79,246,57,69,70,63,59,58,246},42) .. #npcList .. _d({246,75,68,63,71,75,59,246,36,38,25,246,68,55,67,59,73,246,74,69,246,79,69,75,72,246,57,66,63,70,56,69,55,72,58,247},42))
print("NPCs found:\n" .. outputText)
else
warn(_d({49,36,38,25,246,27,78,70,69,72,74,59,72,51,246,28,55,63,66,59,58,246,74,69,246,57,69,70,79,246,74,69,246,57,66,63,70,56,69,55,72,58,16,246},42) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()