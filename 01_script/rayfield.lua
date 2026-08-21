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
if debugX then
warn(_d({22,59,54,65,54,46,57,54,64,54,59,52,237,31,46,70,51,54,50,57,49},51))
end
local function getService(name)
local service = game:GetService(name)
return if cloneref then cloneref(service) else service
end
local UserInputService = getService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
local TweenService = getService(_d({33,68,50,50,59,32,50,63,67,54,48,50},51))
local Players = getService(_d({29,57,46,70,50,63,64},51))
local CoreGui = getService(_d({16,60,63,50,20,66,54},51))
local function loadWithTimeout(url: string, timeout: number?): ...any
assert(type(url) == _d({64,65,63,54,59,52},51), _d({18,69,61,50,48,65,50,49,237,64,65,63,54,59,52,249,237,52,60,65,237},51) .. type(url))
timeout = timeout or 5
local requestCompleted = false
local success, result = false, nil
local requestThread = task.spawn(function()
local fetchSuccess, fetchResult = pcall(game.HttpGet, game, url)
if not fetchSuccess or #fetchResult == 0 then
if #fetchResult == 0 then
fetchResult = _d({18,58,61,65,70,237,63,50,64,61,60,59,64,50},51)
end
success, result = false, fetchResult
requestCompleted = true
return
end
local content = fetchResult
local execSuccess, execResult = pcall(function()
return loadstring(content)()
end)
success, result = execSuccess, execResult
requestCompleted = true
end)
local timeoutThread = task.delay(timeout, function()
if not requestCompleted then
warn(_d({31,50,62,66,50,64,65,237,51,60,63,237},51) .. url .. _d({237,65,54,58,50,49,237,60,66,65,237,46,51,65,50,63,237},51) .. tostring(timeout) .. _d({237,64,50,48,60,59,49,64},51))
task.cancel(requestThread)
result = _d({31,50,62,66,50,64,65,237,65,54,58,50,49,237,60,66,65},51)
requestCompleted = true
end
end)
while not requestCompleted do
task.wait()
end
if coroutine.status(timeoutThread) ~= _d({49,50,46,49},51) then
task.cancel(timeoutThread)
end
if not success then
warn(_d({19,46,54,57,50,49,237,65,60,237,61,63,60,48,50,64,64,237},51) .. tostring(url) .. _d({7,237},51) .. tostring(result))
end
return if success then result else nil
end
local requestsDisabled = false
local customAssetId = nil
local secureMode = false
if getgenv then
local ok, result = pcall(function() return getgenv().DISABLE_RAYFIELD_REQUESTS end)
if ok and result then requestsDisabled = true end
local ok2, result2 = pcall(function() return getgenv().RAYFIELD_ASSET_ID end)
if ok2 and type(result2) == _d({59,66,58,47,50,63},51) then customAssetId = result2 end
local ok3, result3 = pcall(function() return getgenv().RAYFIELD_SECURE end)
if ok3 and result3 then secureMode = true end
end
if secureMode then
local _error = error
local _assert = assert
warn = function(...) end
print = function(...) end
error = function(_, level) _error("", level) end
assert = function(v, ...) return _assert(v) end
end
local secureWarnings = {}
local customAssets = {}
local function secureNotify(wType, title, content)
if secureWarnings[wType] then return end
secureWarnings[wType] = true
task.spawn(function()
while not RayfieldLibrary or not RayfieldLibrary.Notify do task.wait(0.5) end
RayfieldLibrary:Notify({
Title = title,
Content = content,
Duration = 8,
})
end)
end
local InterfaceBuild = _d({34,34,255,27,37},51)
local Release = _d({15,66,54,57,49,237,254,251,4,1,6},51)
local RayfieldFolder = _d({31,46,70,51,54,50,57,49},51)
local ConfigurationFolder = RayfieldFolder.._d({252,16,60,59,51,54,52,66,63,46,65,54,60,59,64},51)
local ConfigurationExtension = _d({251,63,51,57,49},51)
local settingsTable = {
General = {
rayfieldOpen = {Type = _d({47,54,59,49},51), Value = 'K', Name = _d({31,46,70,51,54,50,57,49,237,24,50,70,47,54,59,49},51)},
},
System = {
usageAnalytics = {Type = _d({65,60,52,52,57,50},51), Value = true, Name = _d({14,59,60,59,70,58,54,64,50,49,237,14,59,46,57,70,65,54,48,64},51)},
}
}
local overriddenSettings: { [string]: any } = {}
local function overrideSetting(category: string, name: string, value: any)
overriddenSettings[category .. "." .. name] = value
end
local function getSetting(category: string, name: string): any
if overriddenSettings[category .. "." .. name] ~= nil then
return overriddenSettings[category .. "." .. name]
elseif settingsTable[category][name] ~= nil then
return settingsTable[category][name].Value
end
end
if requestsDisabled then
overrideSetting(_d({32,70,64,65,50,58},51), _d({66,64,46,52,50,14,59,46,57,70,65,54,48,64},51), false)
end
local HttpService = getService(_d({21,65,65,61,32,50,63,67,54,48,50},51))
local RunService = getService(_d({31,66,59,32,50,63,67,54,48,50},51))
local useStudio = RunService:IsStudio() or false
local settingsCreated = false
local settingsInitialized = false
local prompt = useStudio and require(script.Parent.prompt) or loadWithTimeout(_d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,32,54,63,54,66,64,32,60,51,65,68,46,63,50,25,65,49,252,32,54,63,54,66,64,252,63,50,51,64,252,53,50,46,49,64,252,63,50,62,66,50,64,65,252,61,63,60,58,61,65,251,57,66,46},51))
local requestFunc = (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request) or http_request or request
if not prompt and not useStudio then
warn(_d({19,46,54,57,50,49,237,65,60,237,57,60,46,49,237,61,63,60,58,61,65,237,57,54,47,63,46,63,70,249,237,66,64,54,59,52,237,51,46,57,57,47,46,48,56},51))
prompt = {
create = function() end
}
end
local function callSafely(func, ...)
if func then
local success, result = pcall(func, ...)
if not success then
warn(_d({31,46,70,51,54,50,57,49,237,73,237,19,66,59,48,65,54,60,59,237,51,46,54,57,50,49,237,68,54,65,53,237,50,63,63,60,63,7,237},51), result)
return false
else
return result
end
end
end
local function ensureFolder(folderPath)
if isfolder and not callSafely(isfolder, folderPath) then
callSafely(makefolder, folderPath)
end
end
local function loadSettings()
local file = nil
local success, result =	pcall(function()
if callSafely(isfolder, RayfieldFolder) then
if callSafely(isfile, RayfieldFolder.._d({252,64,50,65,65,54,59,52,64},51)..ConfigurationExtension) then
file = callSafely(readfile, RayfieldFolder.._d({252,64,50,65,65,54,59,52,64},51)..ConfigurationExtension)
end
end
if useStudio then
file = [[
{_d({20,50,59,50,63,46,57},51):{_d({63,46,70,51,54,50,57,49,28,61,50,59},51):{_d({35,46,57,66,50},51):"K",_d({33,70,61,50},51):_d({47,54,59,49},51),_d({27,46,58,50},51):_d({31,46,70,51,54,50,57,49,237,24,50,70,47,54,59,49},51),_d({18,57,50,58,50,59,65},51):{_d({21,60,57,49,33,60,22,59,65,50,63,46,48,65},51):false,_d({18,69,65},51):true,_d({27,46,58,50},51):_d({31,46,70,51,54,50,57,49,237,24,50,70,47,54,59,49},51),_d({32,50,65},51):null,_d({16,46,57,57,28,59,16,53,46,59,52,50},51):true,_d({16,46,57,57,47,46,48,56},51):null,_d({16,66,63,63,50,59,65,24,50,70,47,54,59,49},51):"K"}}},_d({32,70,64,65,50,58},51):{_d({66,64,46,52,50,14,59,46,57,70,65,54,48,64},51):{_d({35,46,57,66,50},51):false,_d({33,70,61,50},51):_d({65,60,52,52,57,50},51),_d({27,46,58,50},51):_d({14,59,60,59,70,58,54,64,50,49,237,14,59,46,57,70,65,54,48,64},51),_d({18,57,50,58,50,59,65},51):{_d({18,69,65},51):true,_d({27,46,58,50},51):_d({14,59,60,59,70,58,54,64,50,49,237,14,59,46,57,70,65,54,48,64},51),_d({32,50,65},51):null,_d({16,66,63,63,50,59,65,35,46,57,66,50},51):false,_d({16,46,57,57,47,46,48,56},51):null}}}}
]]
end
if file then
local decodeSuccess, decodedFile = pcall(function() return HttpService:JSONDecode(file) end)
if decodeSuccess then
file = decodedFile
else
file = {}
end
else
file = {}
end
if not settingsCreated then
return
end
if next(file) ~= nil then
for categoryName, categoryTable in file do
for settingName, setting in categoryTable do
local default = settingsTable[categoryName] and settingsTable[categoryName][settingName]
if not default then continue end
local settingType = typeof(default.Value)
if not (settingType == typeof(setting.Value)) then
warn(_d({31,46,70,51,54,50,57,49,237,73,237,18,63,63,60,63,237,61,46,63,64,54,59,52,237,64,50,65,65,54,59,52,64,237,51,54,57,50,251,237,244},51)..settingName.._d({244,237,58,66,64,65,237,47,50,237,46,237},51)..settingType)
continue
end
default.Value = setting.Value
end
end
end
for categoryName, categoryTable in settingsTable do
for settingName, setting in categoryTable do
if setting.Element then
setting.Element:Set(getSetting(categoryName, settingName))
end
end
end
settingsInitialized = true
end)
if not success then
if writefile then
warn(_d({31,46,70,51,54,50,57,49,237,53,46,49,237,46,59,237,54,64,64,66,50,237,46,48,48,50,64,64,54,59,52,237,48,60,59,51,54,52,66,63,46,65,54,60,59,237,64,46,67,54,59,52,237,48,46,61,46,47,54,57,54,65,70,251},51))
end
end
end
if debugX then
warn(_d({27,60,68,237,25,60,46,49,54,59,52,237,32,50,65,65,54,59,52,64,237,16,60,59,51,54,52,66,63,46,65,54,60,59},51))
end
loadSettings()
if debugX then
warn(_d({32,50,65,65,54,59,52,64,237,25,60,46,49,50,49},51))
end
local ANALYTICS_TOKEN = _d({253,2,49,50,4,51,6,51,49,0,255,253,49,0,47,5,1,255,5,48,49,254,48,4,4,253,254,1,46,0,0,4,47,5,2,47,3,48,5,50,51,50,50,255,48,2,6,254,1,51,2,46,47,2,4,253,253,48,0,2,1,47,6,46},51)
local reporter = nil
if not requestsDisabled and not useStudio then
local fetchSuccess, fetchResult = pcall((game :: any).HttpGet, game, _d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,32,54,63,54,66,64,32,60,51,65,68,46,63,50,25,65,49,252,31,46,70,51,54,50,57,49,252,63,50,51,64,252,53,50,46,49,64,252,58,46,54,59,252,63,50,61,60,63,65,50,63,251,57,66,46},51))
if fetchSuccess and #fetchResult > 0 then
local execSuccess, Analytics = pcall(function()
return (loadstring(fetchResult) :: any)()
end)
if execSuccess and Analytics then
pcall(function()
reporter = Analytics.new({
url          = _d({53,65,65,61,64,7,252,252,63,46,70,51,54,50,57,49,250,48,60,57,57,50,48,65,251,64,54,63,54,66,64,250,64,60,51,65,68,46,63,50,250,57,65,49,251,68,60,63,56,50,63,64,251,49,50,67},51),
token        = ANALYTICS_TOKEN,
product_name = _d({31,46,70,51,54,50,57,49},51),
category     = _d({34,22,25,54,47,63,46,63,70},51),
})
end)
end
end
end
if not useStudio and math.random(10) == 1 then
task.spawn(function()
pcall((game :: any).HttpGet, game, _d({53,65,65,61,64,7,252,252,68,68,68,251,64,50,59,65,54,67,50,57,251,48,60,58,252,46,61,54,252,53,50,46,63,65,47,50,46,65,252,5,254,253,4,1,0,3,1,47,1,3,254,51,5,49,46,5,254,47,46,49,3,51,49,48,0,3,0,48,0,47,6,255,4,51,5,5,1,49,3,51,48,255,5,49,5,253,3,46,254,2,50,50,2,253,48,46,254,50,3,5,48,4,5},51))
end)
end
local promptUser = 2
if promptUser == 1 and prompt and type(prompt.create) == _d({51,66,59,48,65,54,60,59},51) then
prompt.create(
_d({15,50,237,48,46,66,65,54,60,66,64,237,68,53,50,59,237,63,66,59,59,54,59,52,237,64,48,63,54,61,65,64},51),
[[Please be careful when running scripts from unknown developers. This script has already been ran.
<font transparency=_d({253,251,0},51)>Some scripts may steal your items or in-game goods.</font>]],
_d({28,56,46,70},51),
'',
function()
end
)
end
if debugX then
warn(_d({26,60,67,54,59,52,237,60,59,237,65,60,237,48,60,59,65,54,59,66,50,237,54,59,54,65,54,46,57,54,64,46,65,54,60,59},51))
end
local RayfieldLibrary = {
Flags = {},
Theme = {
Default = {
TextColor = Color3.fromRGB(240, 240, 240),
Background = Color3.fromRGB(25, 25, 25),
Topbar = Color3.fromRGB(34, 34, 34),
Shadow = Color3.fromRGB(20, 20, 20),
NotificationBackground = Color3.fromRGB(20, 20, 20),
NotificationActionsBackground = Color3.fromRGB(230, 230, 230),
TabBackground = Color3.fromRGB(80, 80, 80),
TabStroke = Color3.fromRGB(85, 85, 85),
TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
TabTextColor = Color3.fromRGB(240, 240, 240),
SelectedTabTextColor = Color3.fromRGB(50, 50, 50),
ElementBackground = Color3.fromRGB(35, 35, 35),
ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
ElementStroke = Color3.fromRGB(50, 50, 50),
SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
SliderBackground = Color3.fromRGB(50, 138, 220),
SliderProgress = Color3.fromRGB(50, 138, 220),
SliderStroke = Color3.fromRGB(58, 163, 255),
ToggleBackground = Color3.fromRGB(30, 30, 30),
ToggleEnabled = Color3.fromRGB(0, 146, 214),
ToggleDisabled = Color3.fromRGB(100, 100, 100),
ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),
DropdownSelected = Color3.fromRGB(40, 40, 40),
DropdownUnselected = Color3.fromRGB(30, 30, 30),
InputBackground = Color3.fromRGB(30, 30, 30),
InputStroke = Color3.fromRGB(65, 65, 65),
PlaceholderColor = Color3.fromRGB(178, 178, 178)
},
Ocean = {
TextColor = Color3.fromRGB(230, 240, 240),
Background = Color3.fromRGB(20, 30, 30),
Topbar = Color3.fromRGB(25, 40, 40),
Shadow = Color3.fromRGB(15, 20, 20),
NotificationBackground = Color3.fromRGB(25, 35, 35),
NotificationActionsBackground = Color3.fromRGB(230, 240, 240),
TabBackground = Color3.fromRGB(40, 60, 60),
TabStroke = Color3.fromRGB(50, 70, 70),
TabBackgroundSelected = Color3.fromRGB(100, 180, 180),
TabTextColor = Color3.fromRGB(210, 230, 230),
SelectedTabTextColor = Color3.fromRGB(20, 50, 50),
ElementBackground = Color3.fromRGB(30, 50, 50),
ElementBackgroundHover = Color3.fromRGB(40, 60, 60),
SecondaryElementBackground = Color3.fromRGB(30, 45, 45),
ElementStroke = Color3.fromRGB(45, 70, 70),
SecondaryElementStroke = Color3.fromRGB(40, 65, 65),
SliderBackground = Color3.fromRGB(0, 110, 110),
SliderProgress = Color3.fromRGB(0, 140, 140),
SliderStroke = Color3.fromRGB(0, 160, 160),
ToggleBackground = Color3.fromRGB(30, 50, 50),
ToggleEnabled = Color3.fromRGB(0, 130, 130),
ToggleDisabled = Color3.fromRGB(70, 90, 90),
ToggleEnabledStroke = Color3.fromRGB(0, 160, 160),
ToggleDisabledStroke = Color3.fromRGB(85, 105, 105),
ToggleEnabledOuterStroke = Color3.fromRGB(50, 100, 100),
ToggleDisabledOuterStroke = Color3.fromRGB(45, 65, 65),
DropdownSelected = Color3.fromRGB(30, 60, 60),
DropdownUnselected = Color3.fromRGB(25, 40, 40),
InputBackground = Color3.fromRGB(30, 50, 50),
InputStroke = Color3.fromRGB(50, 70, 70),
PlaceholderColor = Color3.fromRGB(140, 160, 160)
},
AmberGlow = {
TextColor = Color3.fromRGB(255, 245, 230),
Background = Color3.fromRGB(45, 30, 20),
Topbar = Color3.fromRGB(55, 40, 25),
Shadow = Color3.fromRGB(35, 25, 15),
NotificationBackground = Color3.fromRGB(50, 35, 25),
NotificationActionsBackground = Color3.fromRGB(245, 230, 215),
TabBackground = Color3.fromRGB(75, 50, 35),
TabStroke = Color3.fromRGB(90, 60, 45),
TabBackgroundSelected = Color3.fromRGB(230, 180, 100),
TabTextColor = Color3.fromRGB(250, 220, 200),
SelectedTabTextColor = Color3.fromRGB(50, 30, 10),
ElementBackground = Color3.fromRGB(60, 45, 35),
ElementBackgroundHover = Color3.fromRGB(70, 50, 40),
SecondaryElementBackground = Color3.fromRGB(55, 40, 30),
ElementStroke = Color3.fromRGB(85, 60, 45),
SecondaryElementStroke = Color3.fromRGB(75, 50, 35),
SliderBackground = Color3.fromRGB(220, 130, 60),
SliderProgress = Color3.fromRGB(250, 150, 75),
SliderStroke = Color3.fromRGB(255, 170, 85),
ToggleBackground = Color3.fromRGB(55, 40, 30),
ToggleEnabled = Color3.fromRGB(240, 130, 30),
ToggleDisabled = Color3.fromRGB(90, 70, 60),
ToggleEnabledStroke = Color3.fromRGB(255, 160, 50),
ToggleDisabledStroke = Color3.fromRGB(110, 85, 75),
ToggleEnabledOuterStroke = Color3.fromRGB(200, 100, 50),
ToggleDisabledOuterStroke = Color3.fromRGB(75, 60, 55),
DropdownSelected = Color3.fromRGB(70, 50, 40),
DropdownUnselected = Color3.fromRGB(55, 40, 30),
InputBackground = Color3.fromRGB(60, 45, 35),
InputStroke = Color3.fromRGB(90, 65, 50),
PlaceholderColor = Color3.fromRGB(190, 150, 130)
},
Light = {
TextColor = Color3.fromRGB(40, 40, 40),
Background = Color3.fromRGB(245, 245, 245),
Topbar = Color3.fromRGB(230, 230, 230),
Shadow = Color3.fromRGB(200, 200, 200),
NotificationBackground = Color3.fromRGB(250, 250, 250),
NotificationActionsBackground = Color3.fromRGB(240, 240, 240),
TabBackground = Color3.fromRGB(235, 235, 235),
TabStroke = Color3.fromRGB(215, 215, 215),
TabBackgroundSelected = Color3.fromRGB(255, 255, 255),
TabTextColor = Color3.fromRGB(80, 80, 80),
SelectedTabTextColor = Color3.fromRGB(0, 0, 0),
ElementBackground = Color3.fromRGB(240, 240, 240),
ElementBackgroundHover = Color3.fromRGB(225, 225, 225),
SecondaryElementBackground = Color3.fromRGB(235, 235, 235),
ElementStroke = Color3.fromRGB(210, 210, 210),
SecondaryElementStroke = Color3.fromRGB(210, 210, 210),
SliderBackground = Color3.fromRGB(150, 180, 220),
SliderProgress = Color3.fromRGB(100, 150, 200),
SliderStroke = Color3.fromRGB(120, 170, 220),
ToggleBackground = Color3.fromRGB(220, 220, 220),
ToggleEnabled = Color3.fromRGB(0, 146, 214),
ToggleDisabled = Color3.fromRGB(150, 150, 150),
ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
ToggleDisabledStroke = Color3.fromRGB(170, 170, 170),
ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
ToggleDisabledOuterStroke = Color3.fromRGB(180, 180, 180),
DropdownSelected = Color3.fromRGB(230, 230, 230),
DropdownUnselected = Color3.fromRGB(220, 220, 220),
InputBackground = Color3.fromRGB(240, 240, 240),
InputStroke = Color3.fromRGB(180, 180, 180),
PlaceholderColor = Color3.fromRGB(140, 140, 140)
},
Amethyst = {
TextColor = Color3.fromRGB(240, 240, 240),
Background = Color3.fromRGB(30, 20, 40),
Topbar = Color3.fromRGB(40, 25, 50),
Shadow = Color3.fromRGB(20, 15, 30),
NotificationBackground = Color3.fromRGB(35, 20, 40),
NotificationActionsBackground = Color3.fromRGB(240, 240, 250),
TabBackground = Color3.fromRGB(60, 40, 80),
TabStroke = Color3.fromRGB(70, 45, 90),
TabBackgroundSelected = Color3.fromRGB(180, 140, 200),
TabTextColor = Color3.fromRGB(230, 230, 240),
SelectedTabTextColor = Color3.fromRGB(50, 20, 50),
ElementBackground = Color3.fromRGB(45, 30, 60),
ElementBackgroundHover = Color3.fromRGB(50, 35, 70),
SecondaryElementBackground = Color3.fromRGB(40, 30, 55),
ElementStroke = Color3.fromRGB(70, 50, 85),
SecondaryElementStroke = Color3.fromRGB(65, 45, 80),
SliderBackground = Color3.fromRGB(100, 60, 150),
SliderProgress = Color3.fromRGB(130, 80, 180),
SliderStroke = Color3.fromRGB(150, 100, 200),
ToggleBackground = Color3.fromRGB(45, 30, 55),
ToggleEnabled = Color3.fromRGB(120, 60, 150),
ToggleDisabled = Color3.fromRGB(94, 47, 117),
ToggleEnabledStroke = Color3.fromRGB(140, 80, 170),
ToggleDisabledStroke = Color3.fromRGB(124, 71, 150),
ToggleEnabledOuterStroke = Color3.fromRGB(90, 40, 120),
ToggleDisabledOuterStroke = Color3.fromRGB(80, 50, 110),
DropdownSelected = Color3.fromRGB(50, 35, 70),
DropdownUnselected = Color3.fromRGB(35, 25, 50),
InputBackground = Color3.fromRGB(45, 30, 60),
InputStroke = Color3.fromRGB(80, 50, 110),
PlaceholderColor = Color3.fromRGB(178, 150, 200)
},
Green = {
TextColor = Color3.fromRGB(30, 60, 30),
Background = Color3.fromRGB(235, 245, 235),
Topbar = Color3.fromRGB(210, 230, 210),
Shadow = Color3.fromRGB(200, 220, 200),
NotificationBackground = Color3.fromRGB(240, 250, 240),
NotificationActionsBackground = Color3.fromRGB(220, 235, 220),
TabBackground = Color3.fromRGB(215, 235, 215),
TabStroke = Color3.fromRGB(190, 210, 190),
TabBackgroundSelected = Color3.fromRGB(245, 255, 245),
TabTextColor = Color3.fromRGB(50, 80, 50),
SelectedTabTextColor = Color3.fromRGB(20, 60, 20),
ElementBackground = Color3.fromRGB(225, 240, 225),
ElementBackgroundHover = Color3.fromRGB(210, 225, 210),
SecondaryElementBackground = Color3.fromRGB(235, 245, 235),
ElementStroke = Color3.fromRGB(180, 200, 180),
SecondaryElementStroke = Color3.fromRGB(180, 200, 180),
SliderBackground = Color3.fromRGB(90, 160, 90),
SliderProgress = Color3.fromRGB(70, 130, 70),
SliderStroke = Color3.fromRGB(100, 180, 100),
ToggleBackground = Color3.fromRGB(215, 235, 215),
ToggleEnabled = Color3.fromRGB(60, 130, 60),
ToggleDisabled = Color3.fromRGB(150, 175, 150),
ToggleEnabledStroke = Color3.fromRGB(80, 150, 80),
ToggleDisabledStroke = Color3.fromRGB(130, 150, 130),
ToggleEnabledOuterStroke = Color3.fromRGB(100, 160, 100),
ToggleDisabledOuterStroke = Color3.fromRGB(160, 180, 160),
DropdownSelected = Color3.fromRGB(225, 240, 225),
DropdownUnselected = Color3.fromRGB(210, 225, 210),
InputBackground = Color3.fromRGB(235, 245, 235),
InputStroke = Color3.fromRGB(180, 200, 180),
PlaceholderColor = Color3.fromRGB(120, 140, 120)
},
Bloom = {
TextColor = Color3.fromRGB(60, 40, 50),
Background = Color3.fromRGB(255, 240, 245),
Topbar = Color3.fromRGB(250, 220, 225),
Shadow = Color3.fromRGB(230, 190, 195),
NotificationBackground = Color3.fromRGB(255, 235, 240),
NotificationActionsBackground = Color3.fromRGB(245, 215, 225),
TabBackground = Color3.fromRGB(240, 210, 220),
TabStroke = Color3.fromRGB(230, 200, 210),
TabBackgroundSelected = Color3.fromRGB(255, 225, 235),
TabTextColor = Color3.fromRGB(80, 40, 60),
SelectedTabTextColor = Color3.fromRGB(50, 30, 50),
ElementBackground = Color3.fromRGB(255, 235, 240),
ElementBackgroundHover = Color3.fromRGB(245, 220, 230),
SecondaryElementBackground = Color3.fromRGB(255, 235, 240),
ElementStroke = Color3.fromRGB(230, 200, 210),
SecondaryElementStroke = Color3.fromRGB(230, 200, 210),
SliderBackground = Color3.fromRGB(240, 130, 160),
SliderProgress = Color3.fromRGB(250, 160, 180),
SliderStroke = Color3.fromRGB(255, 180, 200),
ToggleBackground = Color3.fromRGB(240, 210, 220),
ToggleEnabled = Color3.fromRGB(255, 140, 170),
ToggleDisabled = Color3.fromRGB(200, 180, 185),
ToggleEnabledStroke = Color3.fromRGB(250, 160, 190),
ToggleDisabledStroke = Color3.fromRGB(210, 180, 190),
ToggleEnabledOuterStroke = Color3.fromRGB(220, 160, 180),
ToggleDisabledOuterStroke = Color3.fromRGB(190, 170, 180),
DropdownSelected = Color3.fromRGB(250, 220, 225),
DropdownUnselected = Color3.fromRGB(240, 210, 220),
InputBackground = Color3.fromRGB(255, 235, 240),
InputStroke = Color3.fromRGB(220, 190, 200),
PlaceholderColor = Color3.fromRGB(170, 130, 140)
},
DarkBlue = {
TextColor = Color3.fromRGB(230, 230, 230),
Background = Color3.fromRGB(20, 25, 30),
Topbar = Color3.fromRGB(30, 35, 40),
Shadow = Color3.fromRGB(15, 20, 25),
NotificationBackground = Color3.fromRGB(25, 30, 35),
NotificationActionsBackground = Color3.fromRGB(45, 50, 55),
TabBackground = Color3.fromRGB(35, 40, 45),
TabStroke = Color3.fromRGB(45, 50, 60),
TabBackgroundSelected = Color3.fromRGB(40, 70, 100),
TabTextColor = Color3.fromRGB(200, 200, 200),
SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
ElementBackground = Color3.fromRGB(30, 35, 40),
ElementBackgroundHover = Color3.fromRGB(40, 45, 50),
SecondaryElementBackground = Color3.fromRGB(35, 40, 45),
ElementStroke = Color3.fromRGB(45, 50, 60),
SecondaryElementStroke = Color3.fromRGB(40, 45, 55),
SliderBackground = Color3.fromRGB(0, 90, 180),
SliderProgress = Color3.fromRGB(0, 120, 210),
SliderStroke = Color3.fromRGB(0, 150, 240),
ToggleBackground = Color3.fromRGB(35, 40, 45),
ToggleEnabled = Color3.fromRGB(0, 120, 210),
ToggleDisabled = Color3.fromRGB(70, 70, 80),
ToggleEnabledStroke = Color3.fromRGB(0, 150, 240),
ToggleDisabledStroke = Color3.fromRGB(75, 75, 85),
ToggleEnabledOuterStroke = Color3.fromRGB(20, 100, 180),
ToggleDisabledOuterStroke = Color3.fromRGB(55, 55, 65),
DropdownSelected = Color3.fromRGB(30, 70, 90),
DropdownUnselected = Color3.fromRGB(25, 30, 35),
InputBackground = Color3.fromRGB(25, 30, 35),
InputStroke = Color3.fromRGB(45, 50, 60),
PlaceholderColor = Color3.fromRGB(150, 150, 160)
},
Serenity = {
TextColor = Color3.fromRGB(50, 55, 60),
Background = Color3.fromRGB(240, 245, 250),
Topbar = Color3.fromRGB(215, 225, 235),
Shadow = Color3.fromRGB(200, 210, 220),
NotificationBackground = Color3.fromRGB(210, 220, 230),
NotificationActionsBackground = Color3.fromRGB(225, 230, 240),
TabBackground = Color3.fromRGB(200, 210, 220),
TabStroke = Color3.fromRGB(180, 190, 200),
TabBackgroundSelected = Color3.fromRGB(175, 185, 200),
TabTextColor = Color3.fromRGB(50, 55, 60),
SelectedTabTextColor = Color3.fromRGB(30, 35, 40),
ElementBackground = Color3.fromRGB(210, 220, 230),
ElementBackgroundHover = Color3.fromRGB(220, 230, 240),
SecondaryElementBackground = Color3.fromRGB(200, 210, 220),
ElementStroke = Color3.fromRGB(190, 200, 210),
SecondaryElementStroke = Color3.fromRGB(180, 190, 200),
SliderBackground = Color3.fromRGB(200, 220, 235),
SliderProgress = Color3.fromRGB(70, 130, 180),
SliderStroke = Color3.fromRGB(150, 180, 220),
ToggleBackground = Color3.fromRGB(210, 220, 230),
ToggleEnabled = Color3.fromRGB(70, 160, 210),
ToggleDisabled = Color3.fromRGB(180, 180, 180),
ToggleEnabledStroke = Color3.fromRGB(60, 150, 200),
ToggleDisabledStroke = Color3.fromRGB(140, 140, 140),
ToggleEnabledOuterStroke = Color3.fromRGB(100, 120, 140),
ToggleDisabledOuterStroke = Color3.fromRGB(120, 120, 130),
DropdownSelected = Color3.fromRGB(220, 230, 240),
DropdownUnselected = Color3.fromRGB(200, 210, 220),
InputBackground = Color3.fromRGB(220, 230, 240),
InputStroke = Color3.fromRGB(180, 190, 200),
PlaceholderColor = Color3.fromRGB(150, 150, 150)
},
}
}
local RayfieldAssetId = customAssetId or 10804731440
local Rayfield = useStudio and script.Parent:FindFirstChild(_d({31,46,70,51,54,50,57,49},51)) or game:GetObjects(_d({63,47,69,46,64,64,50,65,54,49,7,252,252},51)..RayfieldAssetId)[1]
local buildAttempts = 0
local correctBuild = false
local warned
local globalLoaded
local rayfieldDestroyed = false
repeat
if Rayfield:FindFirstChild(_d({15,66,54,57,49},51)) and Rayfield.Build.Value == InterfaceBuild then
correctBuild = true
break
end
correctBuild = false
if not warned then
warn(_d({31,46,70,51,54,50,57,49,237,73,237,15,66,54,57,49,237,26,54,64,58,46,65,48,53},51))
print(_d({31,46,70,51,54,50,57,49,237,58,46,70,237,50,59,48,60,66,59,65,50,63,237,54,64,64,66,50,64,237,46,64,237,70,60,66,237,46,63,50,237,63,66,59,59,54,59,52,237,46,59,237,54,59,48,60,58,61,46,65,54,47,57,50,237,54,59,65,50,63,51,46,48,50,237,67,50,63,64,54,60,59,237,245},51).. ((Rayfield:FindFirstChild(_d({15,66,54,57,49},51)) and Rayfield.Build.Value) or _d({27,60,237,15,66,54,57,49},51)) ..').\n\nThis version of Rayfield is intended for interface build '..InterfaceBuild..'.')
warned = true
end
local toDestroy
toDestroy, Rayfield = Rayfield, useStudio and script.Parent:FindFirstChild(_d({31,46,70,51,54,50,57,49},51)) or game:GetObjects(_d({63,47,69,46,64,64,50,65,54,49,7,252,252},51)..RayfieldAssetId)[1]
if toDestroy and not useStudio then toDestroy:Destroy() end
buildAttempts = buildAttempts + 1
until buildAttempts >= 2
Rayfield.Enabled = false
if gethui then
Rayfield.Parent = gethui()
elseif syn and syn.protect_gui then
syn.protect_gui(Rayfield)
Rayfield.Parent = CoreGui
elseif not useStudio and CoreGui:FindFirstChild(_d({31,60,47,57,60,69,20,66,54},51)) then
Rayfield.Parent = CoreGui:FindFirstChild(_d({31,60,47,57,60,69,20,66,54},51))
elseif not useStudio then
Rayfield.Parent = CoreGui
end
if gethui then
for _, Interface in ipairs(gethui():GetChildren()) do
if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
Interface.Enabled = false
Interface.Name = _d({31,46,70,51,54,50,57,49,250,28,57,49},51)
end
end
elseif not useStudio then
for _, Interface in ipairs(CoreGui:GetChildren()) do
if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
Interface.Enabled = false
Interface.Name = _d({31,46,70,51,54,50,57,49,250,28,57,49},51)
end
end
end
if secureMode and not customAssetId then
secureNotify(_d({49,50,51,46,66,57,65,44,46,64,64,50,65},51), _d({32,50,48,66,63,50,237,26,60,49,50},51), _d({38,60,66,237,46,63,50,237,66,64,54,59,52,237,65,53,50,237,49,50,51,46,66,57,65,237,31,46,70,51,54,50,57,49,237,46,64,64,50,65,237,22,17,251,237,32,50,65,237,31,14,38,19,22,18,25,17,44,14,32,32,18,33,44,22,17,237,65,60,237,46,237,48,66,64,65,60,58,237,66,61,57,60,46,49,237,65,60,237,46,67,60,54,49,237,49,50,65,50,48,65,54,60,59,251},51))
end
do
local AssetPath = RayfieldFolder.._d({252,14,64,64,50,65,64},51)
local AssetBaseURL = _d({53,65,65,61,64,7,252,252,52,54,65,53,66,47,251,48,60,58,252,32,54,63,54,66,64,32,60,51,65,68,46,63,50,25,65,49,252,31,46,70,51,54,50,57,49,252,47,57,60,47,252,58,46,54,59,252,46,64,64,50,65,64,252},51)
local assetFiles = {
["111263549366178"] = AssetBaseURL.._d({254,254,254,255,3,0,2,1,6,0,3,3,254,4,5,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["77891951053543"] = AssetBaseURL.._d({4,4,5,6,254,6,2,254,253,2,0,2,1,0,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["78137979054938"] = AssetBaseURL.._d({4,5,254,0,4,6,4,6,253,2,1,6,0,5,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["80503127983237"] = AssetBaseURL.._d({5,253,2,253,0,254,255,4,6,5,0,255,0,4,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["10137832201"] = AssetBaseURL.._d({254,253,254,0,4,5,0,255,255,253,254,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["10137941941"] = AssetBaseURL.._d({254,253,254,0,4,6,1,254,6,1,254,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["11036884234"] = AssetBaseURL.._d({254,254,253,0,3,5,5,1,255,0,1,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["11413591840"] = AssetBaseURL.._d({254,254,1,254,0,2,6,254,5,1,253,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["11745872910"] = AssetBaseURL.._d({254,254,4,1,2,5,4,255,6,254,253,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["12577727209"] = AssetBaseURL.._d({254,255,2,4,4,4,255,4,255,253,6,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["18458939117"] = AssetBaseURL.._d({254,5,1,2,5,6,0,6,254,254,4,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["3259050989"] = AssetBaseURL.._d({0,255,2,6,253,2,253,6,5,6,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["3523728077"] = AssetBaseURL.._d({0,2,255,0,4,255,5,253,4,4,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["3602733521"] = AssetBaseURL.._d({0,3,253,255,4,0,0,2,255,254,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
[_d({22,48,60,59,16,53,50,67,63,60,59,33,60,61,26,50,49,54,66,58},51)] = AssetBaseURL.._d({22,48,60,59,16,53,50,67,63,60,59,33,60,61,26,50,49,54,66,58,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["4483362458"] = AssetBaseURL.._d({1,1,5,0,0,3,255,1,2,5,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
["5587865193"] = AssetBaseURL.._d({2,2,5,4,5,3,2,254,6,0,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
[_d({22,48,60,59,26,46,52,59,54,51,70,54,59,52,20,57,46,64,64,255},51)] = AssetBaseURL.._d({22,48,60,59,26,46,52,59,54,51,70,54,59,52,20,57,46,64,64,255,251,61,59,52,12,63,46,68,10,65,63,66,50},51),
}
for id, _ in assetFiles do
customAssets[tostring(id)] = ""
end
local hasCustomAsset = type(getcustomasset) == _d({51,66,59,48,65,54,60,59},51)
local hasFilesystem = type(writefile) == _d({51,66,59,48,65,54,60,59},51) and type(makefolder) == _d({51,66,59,48,65,54,60,59},51) and type(isfile) == _d({51,66,59,48,65,54,60,59},51) and type(isfolder) == _d({51,66,59,48,65,54,60,59},51)
if hasCustomAsset and hasFilesystem then
local ok, err = pcall(function()
ensureFolder(RayfieldFolder)
ensureFolder(AssetPath)
local attempted = {}
local function nextToFetch()
for id, _ in assetFiles do
if not attempted[id] and not isfile(AssetPath.."/"..tostring(id).._d({251,61,59,52},51)) then
return id
end
end
return nil
end
if nextToFetch() then
task.spawn(function()
while true do
local id = nextToFetch()
if not id then break end
local ok, res = pcall(requestFunc, {Url = assetFiles[id], Method = _d({20,18,33},51)})
if ok and type(res) == _d({65,46,47,57,50},51) and type(res.Body) == _d({64,65,63,54,59,52},51) and #res.Body > 0 then
end)()