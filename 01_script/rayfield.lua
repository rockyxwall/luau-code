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
warn(_d({13,50,45,56,45,37,48,45,55,45,50,43,228,22,37,61,42,45,41,48,40},60))
end
local function getService(name)
local service = game:GetService(name)
return if cloneref then cloneref(service) else service
end
local UserInputService = getService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
local TweenService = getService(_d({24,59,41,41,50,23,41,54,58,45,39,41},60))
local Players = getService(_d({20,48,37,61,41,54,55},60))
local CoreGui = getService(_d({7,51,54,41,11,57,45},60))
local function loadWithTimeout(url: string, timeout: number?): ...any
assert(type(url) == _d({55,56,54,45,50,43},60), _d({9,60,52,41,39,56,41,40,228,55,56,54,45,50,43,240,228,43,51,56,228},60) .. type(url))
timeout = timeout or 5
local requestCompleted = false
local success, result = false, nil
local requestThread = task.spawn(function()
local fetchSuccess, fetchResult = pcall(game.HttpGet, game, url)
if not fetchSuccess or #fetchResult == 0 then
if #fetchResult == 0 then
fetchResult = _d({9,49,52,56,61,228,54,41,55,52,51,50,55,41},60)
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
warn(_d({22,41,53,57,41,55,56,228,42,51,54,228},60) .. url .. _d({228,56,45,49,41,40,228,51,57,56,228,37,42,56,41,54,228},60) .. tostring(timeout) .. _d({228,55,41,39,51,50,40,55},60))
task.cancel(requestThread)
result = _d({22,41,53,57,41,55,56,228,56,45,49,41,40,228,51,57,56},60)
requestCompleted = true
end
end)
while not requestCompleted do
task.wait()
end
if coroutine.status(timeoutThread) ~= _d({40,41,37,40},60) then
task.cancel(timeoutThread)
end
if not success then
warn(_d({10,37,45,48,41,40,228,56,51,228,52,54,51,39,41,55,55,228},60) .. tostring(url) .. _d({254,228},60) .. tostring(result))
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
if ok2 and type(result2) == _d({50,57,49,38,41,54},60) then customAssetId = result2 end
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
local InterfaceBuild = _d({25,25,246,18,28},60)
local Release = _d({6,57,45,48,40,228,245,242,251,248,253},60)
local RayfieldFolder = _d({22,37,61,42,45,41,48,40},60)
local ConfigurationFolder = RayfieldFolder.._d({243,7,51,50,42,45,43,57,54,37,56,45,51,50,55},60)
local ConfigurationExtension = _d({242,54,42,48,40},60)
local settingsTable = {
General = {
rayfieldOpen = {Type = _d({38,45,50,40},60), Value = 'K', Name = _d({22,37,61,42,45,41,48,40,228,15,41,61,38,45,50,40},60)},
},
System = {
usageAnalytics = {Type = _d({56,51,43,43,48,41},60), Value = true, Name = _d({5,50,51,50,61,49,45,55,41,40,228,5,50,37,48,61,56,45,39,55},60)},
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
overrideSetting(_d({23,61,55,56,41,49},60), _d({57,55,37,43,41,5,50,37,48,61,56,45,39,55},60), false)
end
local HttpService = getService(_d({12,56,56,52,23,41,54,58,45,39,41},60))
local RunService = getService(_d({22,57,50,23,41,54,58,45,39,41},60))
local useStudio = RunService:IsStudio() or false
local settingsCreated = false
local settingsInitialized = false
local prompt = useStudio and require(script.Parent.prompt) or loadWithTimeout(_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,23,45,54,45,57,55,23,51,42,56,59,37,54,41,16,56,40,243,23,45,54,45,57,55,243,54,41,42,55,243,44,41,37,40,55,243,54,41,53,57,41,55,56,243,52,54,51,49,52,56,242,48,57,37},60))
local requestFunc = (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request) or http_request or request
if not prompt and not useStudio then
warn(_d({10,37,45,48,41,40,228,56,51,228,48,51,37,40,228,52,54,51,49,52,56,228,48,45,38,54,37,54,61,240,228,57,55,45,50,43,228,42,37,48,48,38,37,39,47},60))
prompt = {
create = function() end
}
end
local function callSafely(func, ...)
if func then
local success, result = pcall(func, ...)
if not success then
warn(_d({22,37,61,42,45,41,48,40,228,64,228,10,57,50,39,56,45,51,50,228,42,37,45,48,41,40,228,59,45,56,44,228,41,54,54,51,54,254,228},60), result)
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
if callSafely(isfile, RayfieldFolder.._d({243,55,41,56,56,45,50,43,55},60)..ConfigurationExtension) then
file = callSafely(readfile, RayfieldFolder.._d({243,55,41,56,56,45,50,43,55},60)..ConfigurationExtension)
end
end
if useStudio then
file = [[
{_d({11,41,50,41,54,37,48},60):{_d({54,37,61,42,45,41,48,40,19,52,41,50},60):{_d({26,37,48,57,41},60):"K",_d({24,61,52,41},60):_d({38,45,50,40},60),_d({18,37,49,41},60):_d({22,37,61,42,45,41,48,40,228,15,41,61,38,45,50,40},60),_d({9,48,41,49,41,50,56},60):{_d({12,51,48,40,24,51,13,50,56,41,54,37,39,56},60):false,_d({9,60,56},60):true,_d({18,37,49,41},60):_d({22,37,61,42,45,41,48,40,228,15,41,61,38,45,50,40},60),_d({23,41,56},60):null,_d({7,37,48,48,19,50,7,44,37,50,43,41},60):true,_d({7,37,48,48,38,37,39,47},60):null,_d({7,57,54,54,41,50,56,15,41,61,38,45,50,40},60):"K"}}},_d({23,61,55,56,41,49},60):{_d({57,55,37,43,41,5,50,37,48,61,56,45,39,55},60):{_d({26,37,48,57,41},60):false,_d({24,61,52,41},60):_d({56,51,43,43,48,41},60),_d({18,37,49,41},60):_d({5,50,51,50,61,49,45,55,41,40,228,5,50,37,48,61,56,45,39,55},60),_d({9,48,41,49,41,50,56},60):{_d({9,60,56},60):true,_d({18,37,49,41},60):_d({5,50,51,50,61,49,45,55,41,40,228,5,50,37,48,61,56,45,39,55},60),_d({23,41,56},60):null,_d({7,57,54,54,41,50,56,26,37,48,57,41},60):false,_d({7,37,48,48,38,37,39,47},60):null}}}}
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
warn(_d({22,37,61,42,45,41,48,40,228,64,228,9,54,54,51,54,228,52,37,54,55,45,50,43,228,55,41,56,56,45,50,43,55,228,42,45,48,41,242,228,235},60)..settingName.._d({235,228,49,57,55,56,228,38,41,228,37,228},60)..settingType)
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
warn(_d({22,37,61,42,45,41,48,40,228,44,37,40,228,37,50,228,45,55,55,57,41,228,37,39,39,41,55,55,45,50,43,228,39,51,50,42,45,43,57,54,37,56,45,51,50,228,55,37,58,45,50,43,228,39,37,52,37,38,45,48,45,56,61,242},60))
end
end
end
if debugX then
warn(_d({18,51,59,228,16,51,37,40,45,50,43,228,23,41,56,56,45,50,43,55,228,7,51,50,42,45,43,57,54,37,56,45,51,50},60))
end
loadSettings()
if debugX then
warn(_d({23,41,56,56,45,50,43,55,228,16,51,37,40,41,40},60))
end
local ANALYTICS_TOKEN = _d({244,249,40,41,251,42,253,42,40,247,246,244,40,247,38,252,248,246,252,39,40,245,39,251,251,244,245,248,37,247,247,251,38,252,249,38,250,39,252,41,42,41,41,246,39,249,253,245,248,42,249,37,38,249,251,244,244,39,247,249,248,38,253,37},60)
local reporter = nil
if not requestsDisabled and not useStudio then
local fetchSuccess, fetchResult = pcall((game :: any).HttpGet, game, _d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,23,45,54,45,57,55,23,51,42,56,59,37,54,41,16,56,40,243,22,37,61,42,45,41,48,40,243,54,41,42,55,243,44,41,37,40,55,243,49,37,45,50,243,54,41,52,51,54,56,41,54,242,48,57,37},60))
if fetchSuccess and #fetchResult > 0 then
local execSuccess, Analytics = pcall(function()
return (loadstring(fetchResult) :: any)()
end)
if execSuccess and Analytics then
pcall(function()
reporter = Analytics.new({
url          = _d({44,56,56,52,55,254,243,243,54,37,61,42,45,41,48,40,241,39,51,48,48,41,39,56,242,55,45,54,45,57,55,241,55,51,42,56,59,37,54,41,241,48,56,40,242,59,51,54,47,41,54,55,242,40,41,58},60),
token        = ANALYTICS_TOKEN,
product_name = _d({22,37,61,42,45,41,48,40},60),
category     = _d({25,13,16,45,38,54,37,54,61},60),
})
end)
end
end
end
if not useStudio and math.random(10) == 1 then
task.spawn(function()
pcall((game :: any).HttpGet, game, _d({44,56,56,52,55,254,243,243,59,59,59,242,55,41,50,56,45,58,41,48,242,39,51,49,243,37,52,45,243,44,41,37,54,56,38,41,37,56,243,252,245,244,251,248,247,250,248,38,248,250,245,42,252,40,37,252,245,38,37,40,250,42,40,39,247,250,247,39,247,38,253,246,251,42,252,252,248,40,250,42,39,246,252,40,252,244,250,37,245,249,41,41,249,244,39,37,245,41,250,252,39,251,252},60))
end)
end
local promptUser = 2
if promptUser == 1 and prompt and type(prompt.create) == _d({42,57,50,39,56,45,51,50},60) then
prompt.create(
_d({6,41,228,39,37,57,56,45,51,57,55,228,59,44,41,50,228,54,57,50,50,45,50,43,228,55,39,54,45,52,56,55},60),
[[Please be careful when running scripts from unknown developers. This script has already been ran.
<font transparency=_d({244,242,247},60)>Some scripts may steal your items or in-game goods.</font>]],
_d({19,47,37,61},60),
'',
function()
end
)
end
if debugX then
warn(_d({17,51,58,45,50,43,228,51,50,228,56,51,228,39,51,50,56,45,50,57,41,228,45,50,45,56,45,37,48,45,55,37,56,45,51,50},60))
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
local Rayfield = useStudio and script.Parent:FindFirstChild(_d({22,37,61,42,45,41,48,40},60)) or game:GetObjects(_d({54,38,60,37,55,55,41,56,45,40,254,243,243},60)..RayfieldAssetId)[1]
local buildAttempts = 0
local correctBuild = false
local warned
local globalLoaded
local rayfieldDestroyed = false
repeat
if Rayfield:FindFirstChild(_d({6,57,45,48,40},60)) and Rayfield.Build.Value == InterfaceBuild then
correctBuild = true
break
end
correctBuild = false
if not warned then
warn(_d({22,37,61,42,45,41,48,40,228,64,228,6,57,45,48,40,228,17,45,55,49,37,56,39,44},60))
print(_d({22,37,61,42,45,41,48,40,228,49,37,61,228,41,50,39,51,57,50,56,41,54,228,45,55,55,57,41,55,228,37,55,228,61,51,57,228,37,54,41,228,54,57,50,50,45,50,43,228,37,50,228,45,50,39,51,49,52,37,56,45,38,48,41,228,45,50,56,41,54,42,37,39,41,228,58,41,54,55,45,51,50,228,236},60).. ((Rayfield:FindFirstChild(_d({6,57,45,48,40},60)) and Rayfield.Build.Value) or _d({18,51,228,6,57,45,48,40},60)) ..').\n\nThis version of Rayfield is intended for interface build '..InterfaceBuild..'.')
warned = true
end
local toDestroy
toDestroy, Rayfield = Rayfield, useStudio and script.Parent:FindFirstChild(_d({22,37,61,42,45,41,48,40},60)) or game:GetObjects(_d({54,38,60,37,55,55,41,56,45,40,254,243,243},60)..RayfieldAssetId)[1]
if toDestroy and not useStudio then toDestroy:Destroy() end
buildAttempts = buildAttempts + 1
until buildAttempts >= 2
Rayfield.Enabled = false
if gethui then
Rayfield.Parent = gethui()
elseif syn and syn.protect_gui then
syn.protect_gui(Rayfield)
Rayfield.Parent = CoreGui
elseif not useStudio and CoreGui:FindFirstChild(_d({22,51,38,48,51,60,11,57,45},60)) then
Rayfield.Parent = CoreGui:FindFirstChild(_d({22,51,38,48,51,60,11,57,45},60))
elseif not useStudio then
Rayfield.Parent = CoreGui
end
if gethui then
for _, Interface in ipairs(gethui():GetChildren()) do
if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
Interface.Enabled = false
Interface.Name = _d({22,37,61,42,45,41,48,40,241,19,48,40},60)
end
end
elseif not useStudio then
for _, Interface in ipairs(CoreGui:GetChildren()) do
if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
Interface.Enabled = false
Interface.Name = _d({22,37,61,42,45,41,48,40,241,19,48,40},60)
end
end
end
if secureMode and not customAssetId then
secureNotify(_d({40,41,42,37,57,48,56,35,37,55,55,41,56},60), _d({23,41,39,57,54,41,228,17,51,40,41},60), _d({29,51,57,228,37,54,41,228,57,55,45,50,43,228,56,44,41,228,40,41,42,37,57,48,56,228,22,37,61,42,45,41,48,40,228,37,55,55,41,56,228,13,8,242,228,23,41,56,228,22,5,29,10,13,9,16,8,35,5,23,23,9,24,35,13,8,228,56,51,228,37,228,39,57,55,56,51,49,228,57,52,48,51,37,40,228,56,51,228,37,58,51,45,40,228,40,41,56,41,39,56,45,51,50,242},60))
end
do
local AssetPath = RayfieldFolder.._d({243,5,55,55,41,56,55},60)
local AssetBaseURL = _d({44,56,56,52,55,254,243,243,43,45,56,44,57,38,242,39,51,49,243,23,45,54,45,57,55,23,51,42,56,59,37,54,41,16,56,40,243,22,37,61,42,45,41,48,40,243,38,48,51,38,243,49,37,45,50,243,37,55,55,41,56,55,243},60)
local assetFiles = {
["111263549366178"] = AssetBaseURL.._d({245,245,245,246,250,247,249,248,253,247,250,250,245,251,252,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["77891951053543"] = AssetBaseURL.._d({251,251,252,253,245,253,249,245,244,249,247,249,248,247,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["78137979054938"] = AssetBaseURL.._d({251,252,245,247,251,253,251,253,244,249,248,253,247,252,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["80503127983237"] = AssetBaseURL.._d({252,244,249,244,247,245,246,251,253,252,247,246,247,251,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["10137832201"] = AssetBaseURL.._d({245,244,245,247,251,252,247,246,246,244,245,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["10137941941"] = AssetBaseURL.._d({245,244,245,247,251,253,248,245,253,248,245,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["11036884234"] = AssetBaseURL.._d({245,245,244,247,250,252,252,248,246,247,248,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["11413591840"] = AssetBaseURL.._d({245,245,248,245,247,249,253,245,252,248,244,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["11745872910"] = AssetBaseURL.._d({245,245,251,248,249,252,251,246,253,245,244,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["12577727209"] = AssetBaseURL.._d({245,246,249,251,251,251,246,251,246,244,253,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["18458939117"] = AssetBaseURL.._d({245,252,248,249,252,253,247,253,245,245,251,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["3259050989"] = AssetBaseURL.._d({247,246,249,253,244,249,244,253,252,253,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["3523728077"] = AssetBaseURL.._d({247,249,246,247,251,246,252,244,251,251,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["3602733521"] = AssetBaseURL.._d({247,250,244,246,251,247,247,249,246,245,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
[_d({13,39,51,50,7,44,41,58,54,51,50,24,51,52,17,41,40,45,57,49},60)] = AssetBaseURL.._d({13,39,51,50,7,44,41,58,54,51,50,24,51,52,17,41,40,45,57,49,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["4483362458"] = AssetBaseURL.._d({248,248,252,247,247,250,246,248,249,252,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
["5587865193"] = AssetBaseURL.._d({249,249,252,251,252,250,249,245,253,247,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
[_d({13,39,51,50,17,37,43,50,45,42,61,45,50,43,11,48,37,55,55,246},60)] = AssetBaseURL.._d({13,39,51,50,17,37,43,50,45,42,61,45,50,43,11,48,37,55,55,246,242,52,50,43,3,54,37,59,1,56,54,57,41},60),
}
for id, _ in assetFiles do
customAssets[tostring(id)] = ""
end
local hasCustomAsset = type(getcustomasset) == _d({42,57,50,39,56,45,51,50},60)
local hasFilesystem = type(writefile) == _d({42,57,50,39,56,45,51,50},60) and type(makefolder) == _d({42,57,50,39,56,45,51,50},60) and type(isfile) == _d({42,57,50,39,56,45,51,50},60) and type(isfolder) == _d({42,57,50,39,56,45,51,50},60)
if hasCustomAsset and hasFilesystem then
local ok, err = pcall(function()
ensureFolder(RayfieldFolder)
ensureFolder(AssetPath)
local attempted = {}
local function nextToFetch()
for id, _ in assetFiles do
if not attempted[id] and not isfile(AssetPath.."/"..tostring(id).._d({242,52,50,43},60)) then
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
local ok, res = pcall(requestFunc, {Url = assetFiles[id], Method = _d({11,9,24},60)})
if ok and type(res) == _d({56,37,38,48,41},60) and type(res.Body) == _d({55,56,54,45,50,43},60) and #res.Body > 0 then
end)()