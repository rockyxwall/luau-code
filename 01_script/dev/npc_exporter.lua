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
local npcsFolder = workspace:FindFirstChild(_d({19,21,8,56},59))
if not npcsFolder then
print(_d({32,19,21,8,229,10,61,53,52,55,57,42,55,34,229,236,19,21,8,56,236,229,43,52,49,41,42,55,229,51,52,57,229,43,52,58,51,41,229,46,51,229,60,52,55,48,56,53,38,40,42,230},59))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({18,52,41,42,49},59)) and npc.Name ~= "" then
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
error(_d({8,49,46,53,39,52,38,55,41,229,43,58,51,40,57,46,52,51,229,51,52,57,229,56,58,53,53,52,55,57,42,41,229,39,62,229,57,45,46,56,229,42,61,42,40,58,57,52,55,243},59))
end
end)
if success then
print(_d({32,19,21,8,229,10,61,53,52,55,57,42,55,34,229,24,58,40,40,42,56,56,43,58,49,49,62,229,40,52,53,46,42,41,229},59) .. #npcList .. _d({229,58,51,46,54,58,42,229,19,21,8,229,51,38,50,42,56,229,57,52,229,62,52,58,55,229,40,49,46,53,39,52,38,55,41,230},59))
print("NPCs found:\n" .. outputText)
else
warn(_d({32,19,21,8,229,10,61,53,52,55,57,42,55,34,229,11,38,46,49,42,41,229,57,52,229,40,52,53,62,229,57,52,229,40,49,46,53,39,52,38,55,41,255,229},59) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()