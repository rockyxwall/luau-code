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
local npcsFolder = workspace:FindFirstChild(_d({33,35,22,70},45))
if not npcsFolder then
print(_d({46,33,35,22,243,24,75,67,66,69,71,56,69,48,243,250,33,35,22,70,250,243,57,66,63,55,56,69,243,65,66,71,243,57,66,72,65,55,243,60,65,243,74,66,69,62,70,67,52,54,56,244},45))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({32,66,55,56,63},45)) and npc.Name ~= "" then
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
error(_d({22,63,60,67,53,66,52,69,55,243,57,72,65,54,71,60,66,65,243,65,66,71,243,70,72,67,67,66,69,71,56,55,243,53,76,243,71,59,60,70,243,56,75,56,54,72,71,66,69,1},45))
end
end)
if success then
print(_d({46,33,35,22,243,24,75,67,66,69,71,56,69,48,243,38,72,54,54,56,70,70,57,72,63,63,76,243,54,66,67,60,56,55,243},45) .. #npcList .. _d({243,72,65,60,68,72,56,243,33,35,22,243,65,52,64,56,70,243,71,66,243,76,66,72,69,243,54,63,60,67,53,66,52,69,55,244},45))
print("NPCs found:\n" .. outputText)
else
warn(_d({46,33,35,22,243,24,75,67,66,69,71,56,69,48,243,25,52,60,63,56,55,243,71,66,243,54,66,67,76,243,71,66,243,54,63,60,67,53,66,52,69,55,13,243},45) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()