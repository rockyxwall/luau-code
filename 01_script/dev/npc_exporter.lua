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
local npcsFolder = workspace:FindFirstChild(_d({14,16,3,51},64))
if not npcsFolder then
print(_d({27,14,16,3,224,5,56,48,47,50,52,37,50,29,224,231,14,16,3,51,231,224,38,47,44,36,37,50,224,46,47,52,224,38,47,53,46,36,224,41,46,224,55,47,50,43,51,48,33,35,37,225},64))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({13,47,36,37,44},64)) and npc.Name ~= "" then
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
error(_d({3,44,41,48,34,47,33,50,36,224,38,53,46,35,52,41,47,46,224,46,47,52,224,51,53,48,48,47,50,52,37,36,224,34,57,224,52,40,41,51,224,37,56,37,35,53,52,47,50,238},64))
end
end)
if success then
print(_d({27,14,16,3,224,5,56,48,47,50,52,37,50,29,224,19,53,35,35,37,51,51,38,53,44,44,57,224,35,47,48,41,37,36,224},64) .. #npcList .. _d({224,53,46,41,49,53,37,224,14,16,3,224,46,33,45,37,51,224,52,47,224,57,47,53,50,224,35,44,41,48,34,47,33,50,36,225},64))
print("NPCs found:\n" .. outputText)
else
warn(_d({27,14,16,3,224,5,56,48,47,50,52,37,50,29,224,6,33,41,44,37,36,224,52,47,224,35,47,48,57,224,52,47,224,35,44,41,48,34,47,33,50,36,250,224},64) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()