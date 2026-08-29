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
local npcsFolder = workspace:FindFirstChild(_d({58,60,47,95},20))
if not npcsFolder then
print(_d({71,58,60,47,12,49,100,92,91,94,96,81,94,73,12,19,58,60,47,95,19,12,82,91,88,80,81,94,12,90,91,96,12,82,91,97,90,80,12,85,90,12,99,91,94,87,95,92,77,79,81,13},20))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({57,91,80,81,88},20)) and npc.Name ~= "" then
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
error(_d({47,88,85,92,78,91,77,94,80,12,82,97,90,79,96,85,91,90,12,90,91,96,12,95,97,92,92,91,94,96,81,80,12,78,101,12,96,84,85,95,12,81,100,81,79,97,96,91,94,26},20))
end
end)
if success then
print(_d({71,58,60,47,12,49,100,92,91,94,96,81,94,73,12,63,97,79,79,81,95,95,82,97,88,88,101,12,79,91,92,85,81,80,12},20) .. #npcList .. _d({12,97,90,85,93,97,81,12,58,60,47,12,90,77,89,81,95,12,96,91,12,101,91,97,94,12,79,88,85,92,78,91,77,94,80,13},20))
print("NPCs found:\n" .. outputText)
else
warn(_d({71,58,60,47,12,49,100,92,91,94,96,81,94,73,12,50,77,85,88,81,80,12,96,91,12,79,91,92,101,12,96,91,12,79,88,85,92,78,91,77,94,80,38,12},20) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()