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
warn(_d({52,89,84,95,84,76,87,84,94,84,89,82,11,61,76,100,81,84,80,87,79},21))
end
local function getService(name)
local service = game:GetService(name)
return if cloneref then cloneref(service) else service
end
local UserInputService = getService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
local TweenService = getService(_d({63,98,80,80,89,62,80,93,97,84,78,80},21))
local Players = getService(_d({59,87,76,100,80,93,94},21))
local CoreGui = getService(_d({46,90,93,80,50,96,84},21))
local function loadWithTimeout(url: string, timeout: number?): ...any
assert(type(url) == _d({94,95,93,84,89,82},21), _d({48,99,91,80,78,95,80,79,11,94,95,93,84,89,82,23,11,82,90,95,11},21) .. type(url))
timeout = timeout or 5
local requestCompleted = false
local success, result = false, nil
local requestThread = task.spawn(function()
local fetchSuccess, fetchResult = pcall(game.HttpGet, game, url)
if not fetchSuccess or #fetchResult == 0 then
if #fetchResult == 0 then
fetchResult = _d({48,88,91,95,100,11,93,80,94,91,90,89,94,80},21)
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
warn(_d({61,80,92,96,80,94,95,11,81,90,93,11},21) .. url .. _d({11,95,84,88,80,79,11,90,96,95,11,76,81,95,80,93,11},21) .. tostring(timeout) .. _d({11,94,80,78,90,89,79,94},21))
task.cancel(requestThread)
result = _d({61,80,92,96,80,94,95,11,95,84,88,80,79,11,90,96,95},21)
requestCompleted = true
end
end)
while not requestCompleted do
task.wait()
end
if coroutine.status(timeoutThread) ~= _d({79,80,76,79},21) then
task.cancel(timeoutThread)
end
if not success then
warn(_d({49,76,84,87,80,79,11,95,90,11,91,93,90,78,80,94,94,11},21) .. tostring(url) .. _d({37,11},21) .. tostring(result))
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
if ok2 and type(result2) == _d({89,96,88,77,80,93},21) then customAssetId = result2 end
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
local InterfaceBuild = _d({64,64,29,57,67},21)
local Release = _d({45,96,84,87,79,11,28,25,34,31,36},21)
local RayfieldFolder = _d({61,76,100,81,84,80,87,79},21)
local ConfigurationFolder = RayfieldFolder.._d({26,46,90,89,81,84,82,96,93,76,95,84,90,89,94},21)
local ConfigurationExtension = _d({25,93,81,87,79},21)
local settingsTable = {
General = {
rayfieldOpen = {Type = _d({77,84,89,79},21), Value = 'K', Name = _d({61,76,100,81,84,80,87,79,11,54,80,100,77,84,89,79},21)},
},
System = {
usageAnalytics = {Type = _d({95,90,82,82,87,80},21), Value = true, Name = _d({44,89,90,89,100,88,84,94,80,79,11,44,89,76,87,100,95,84,78,94},21)},
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
overrideSetting(_d({62,100,94,95,80,88},21), _d({96,94,76,82,80,44,89,76,87,100,95,84,78,94},21), false)
end
local HttpService = getService(_d({51,95,95,91,62,80,93,97,84,78,80},21))
local RunService = getService(_d({61,96,89,62,80,93,97,84,78,80},21))
local useStudio = RunService:IsStudio() or false
local settingsCreated = false
local settingsInitialized = false
local prompt = useStudio and require(script.Parent.prompt) or loadWithTimeout(_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,62,84,93,84,96,94,62,90,81,95,98,76,93,80,55,95,79,26,62,84,93,84,96,94,26,93,80,81,94,26,83,80,76,79,94,26,93,80,92,96,80,94,95,26,91,93,90,88,91,95,25,87,96,76},21))
local requestFunc = (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request) or http_request or request
if not prompt and not useStudio then
warn(_d({49,76,84,87,80,79,11,95,90,11,87,90,76,79,11,91,93,90,88,91,95,11,87,84,77,93,76,93,100,23,11,96,94,84,89,82,11,81,76,87,87,77,76,78,86},21))
prompt = {
create = function() end
}
end
local function callSafely(func, ...)
if func then
local success, result = pcall(func, ...)
if not success then
warn(_d({61,76,100,81,84,80,87,79,11,103,11,49,96,89,78,95,84,90,89,11,81,76,84,87,80,79,11,98,84,95,83,11,80,93,93,90,93,37,11},21), result)
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
if callSafely(isfile, RayfieldFolder.._d({26,94,80,95,95,84,89,82,94},21)..ConfigurationExtension) then
file = callSafely(readfile, RayfieldFolder.._d({26,94,80,95,95,84,89,82,94},21)..ConfigurationExtension)
end
end
if useStudio then
file = [[
{_d({50,80,89,80,93,76,87},21):{_d({93,76,100,81,84,80,87,79,58,91,80,89},21):{_d({65,76,87,96,80},21):"K",_d({63,100,91,80},21):_d({77,84,89,79},21),_d({57,76,88,80},21):_d({61,76,100,81,84,80,87,79,11,54,80,100,77,84,89,79},21),_d({48,87,80,88,80,89,95},21):{_d({51,90,87,79,63,90,52,89,95,80,93,76,78,95},21):false,_d({48,99,95},21):true,_d({57,76,88,80},21):_d({61,76,100,81,84,80,87,79,11,54,80,100,77,84,89,79},21),_d({62,80,95},21):null,_d({46,76,87,87,58,89,46,83,76,89,82,80},21):true,_d({46,76,87,87,77,76,78,86},21):null,_d({46,96,93,93,80,89,95,54,80,100,77,84,89,79},21):"K"}}},_d({62,100,94,95,80,88},21):{_d({96,94,76,82,80,44,89,76,87,100,95,84,78,94},21):{_d({65,76,87,96,80},21):false,_d({63,100,91,80},21):_d({95,90,82,82,87,80},21),_d({57,76,88,80},21):_d({44,89,90,89,100,88,84,94,80,79,11,44,89,76,87,100,95,84,78,94},21),_d({48,87,80,88,80,89,95},21):{_d({48,99,95},21):true,_d({57,76,88,80},21):_d({44,89,90,89,100,88,84,94,80,79,11,44,89,76,87,100,95,84,78,94},21),_d({62,80,95},21):null,_d({46,96,93,93,80,89,95,65,76,87,96,80},21):false,_d({46,76,87,87,77,76,78,86},21):null}}}}
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
warn(_d({61,76,100,81,84,80,87,79,11,103,11,48,93,93,90,93,11,91,76,93,94,84,89,82,11,94,80,95,95,84,89,82,94,11,81,84,87,80,25,11,18},21)..settingName.._d({18,11,88,96,94,95,11,77,80,11,76,11},21)..settingType)
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
warn(_d({61,76,100,81,84,80,87,79,11,83,76,79,11,76,89,11,84,94,94,96,80,11,76,78,78,80,94,94,84,89,82,11,78,90,89,81,84,82,96,93,76,95,84,90,89,11,94,76,97,84,89,82,11,78,76,91,76,77,84,87,84,95,100,25},21))
end
end
end
if debugX then
warn(_d({57,90,98,11,55,90,76,79,84,89,82,11,62,80,95,95,84,89,82,94,11,46,90,89,81,84,82,96,93,76,95,84,90,89},21))
end
loadSettings()
if debugX then
warn(_d({62,80,95,95,84,89,82,94,11,55,90,76,79,80,79},21))
end
local ANALYTICS_TOKEN = _d({27,32,79,80,34,81,36,81,79,30,29,27,79,30,77,35,31,29,35,78,79,28,78,34,34,27,28,31,76,30,30,34,77,35,32,77,33,78,35,80,81,80,80,29,78,32,36,28,31,81,32,76,77,32,34,27,27,78,30,32,31,77,36,76},21)
local reporter = nil
if not requestsDisabled and not useStudio then
local fetchSuccess, fetchResult = pcall((game :: any).HttpGet, game, _d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,62,84,93,84,96,94,62,90,81,95,98,76,93,80,55,95,79,26,61,76,100,81,84,80,87,79,26,93,80,81,94,26,83,80,76,79,94,26,88,76,84,89,26,93,80,91,90,93,95,80,93,25,87,96,76},21))
if fetchSuccess and #fetchResult > 0 then
local execSuccess, Analytics = pcall(function()
return (loadstring(fetchResult) :: any)()
end)
if execSuccess and Analytics then
pcall(function()
reporter = Analytics.new({
url          = _d({83,95,95,91,94,37,26,26,93,76,100,81,84,80,87,79,24,78,90,87,87,80,78,95,25,94,84,93,84,96,94,24,94,90,81,95,98,76,93,80,24,87,95,79,25,98,90,93,86,80,93,94,25,79,80,97},21),
token        = ANALYTICS_TOKEN,
product_name = _d({61,76,100,81,84,80,87,79},21),
category     = _d({64,52,55,84,77,93,76,93,100},21),
})
end)
end
end
end
if not useStudio and math.random(10) == 1 then
task.spawn(function()
pcall((game :: any).HttpGet, game, _d({83,95,95,91,94,37,26,26,98,98,98,25,94,80,89,95,84,97,80,87,25,78,90,88,26,76,91,84,26,83,80,76,93,95,77,80,76,95,26,35,28,27,34,31,30,33,31,77,31,33,28,81,35,79,76,35,28,77,76,79,33,81,79,78,30,33,30,78,30,77,36,29,34,81,35,35,31,79,33,81,78,29,35,79,35,27,33,76,28,32,80,80,32,27,78,76,28,80,33,35,78,34,35},21))
end)
end
local promptUser = 2
if promptUser == 1 and prompt and type(prompt.create) == _d({81,96,89,78,95,84,90,89},21) then
prompt.create(
_d({45,80,11,78,76,96,95,84,90,96,94,11,98,83,80,89,11,93,96,89,89,84,89,82,11,94,78,93,84,91,95,94},21),
[[Please be careful when running scripts from unknown developers. This script has already been ran.
<font transparency=_d({27,25,30},21)>Some scripts may steal your items or in-game goods.</font>]],
_d({58,86,76,100},21),
'',
function()
end
)
end
if debugX then
warn(_d({56,90,97,84,89,82,11,90,89,11,95,90,11,78,90,89,95,84,89,96,80,11,84,89,84,95,84,76,87,84,94,76,95,84,90,89},21))
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
local Rayfield = useStudio and script.Parent:FindFirstChild(_d({61,76,100,81,84,80,87,79},21)) or game:GetObjects(_d({93,77,99,76,94,94,80,95,84,79,37,26,26},21)..RayfieldAssetId)[1]
local buildAttempts = 0
local correctBuild = false
local warned
local globalLoaded
local rayfieldDestroyed = false
repeat
if Rayfield:FindFirstChild(_d({45,96,84,87,79},21)) and Rayfield.Build.Value == InterfaceBuild then
correctBuild = true
break
end
correctBuild = false
if not warned then
warn(_d({61,76,100,81,84,80,87,79,11,103,11,45,96,84,87,79,11,56,84,94,88,76,95,78,83},21))
print(_d({61,76,100,81,84,80,87,79,11,88,76,100,11,80,89,78,90,96,89,95,80,93,11,84,94,94,96,80,94,11,76,94,11,100,90,96,11,76,93,80,11,93,96,89,89,84,89,82,11,76,89,11,84,89,78,90,88,91,76,95,84,77,87,80,11,84,89,95,80,93,81,76,78,80,11,97,80,93,94,84,90,89,11,19},21).. ((Rayfield:FindFirstChild(_d({45,96,84,87,79},21)) and Rayfield.Build.Value) or _d({57,90,11,45,96,84,87,79},21)) ..').\n\nThis version of Rayfield is intended for interface build '..InterfaceBuild..'.')
warned = true
end
local toDestroy
toDestroy, Rayfield = Rayfield, useStudio and script.Parent:FindFirstChild(_d({61,76,100,81,84,80,87,79},21)) or game:GetObjects(_d({93,77,99,76,94,94,80,95,84,79,37,26,26},21)..RayfieldAssetId)[1]
if toDestroy and not useStudio then toDestroy:Destroy() end
buildAttempts = buildAttempts + 1
until buildAttempts >= 2
Rayfield.Enabled = false
if gethui then
Rayfield.Parent = gethui()
elseif syn and syn.protect_gui then
syn.protect_gui(Rayfield)
Rayfield.Parent = CoreGui
elseif not useStudio and CoreGui:FindFirstChild(_d({61,90,77,87,90,99,50,96,84},21)) then
Rayfield.Parent = CoreGui:FindFirstChild(_d({61,90,77,87,90,99,50,96,84},21))
elseif not useStudio then
Rayfield.Parent = CoreGui
end
if gethui then
for _, Interface in ipairs(gethui():GetChildren()) do
if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
Interface.Enabled = false
Interface.Name = _d({61,76,100,81,84,80,87,79,24,58,87,79},21)
end
end
elseif not useStudio then
for _, Interface in ipairs(CoreGui:GetChildren()) do
if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
Interface.Enabled = false
Interface.Name = _d({61,76,100,81,84,80,87,79,24,58,87,79},21)
end
end
end
if secureMode and not customAssetId then
secureNotify(_d({79,80,81,76,96,87,95,74,76,94,94,80,95},21), _d({62,80,78,96,93,80,11,56,90,79,80},21), _d({68,90,96,11,76,93,80,11,96,94,84,89,82,11,95,83,80,11,79,80,81,76,96,87,95,11,61,76,100,81,84,80,87,79,11,76,94,94,80,95,11,52,47,25,11,62,80,95,11,61,44,68,49,52,48,55,47,74,44,62,62,48,63,74,52,47,11,95,90,11,76,11,78,96,94,95,90,88,11,96,91,87,90,76,79,11,95,90,11,76,97,90,84,79,11,79,80,95,80,78,95,84,90,89,25},21))
end
do
local AssetPath = RayfieldFolder.._d({26,44,94,94,80,95,94},21)
local AssetBaseURL = _d({83,95,95,91,94,37,26,26,82,84,95,83,96,77,25,78,90,88,26,62,84,93,84,96,94,62,90,81,95,98,76,93,80,55,95,79,26,61,76,100,81,84,80,87,79,26,77,87,90,77,26,88,76,84,89,26,76,94,94,80,95,94,26},21)
local assetFiles = {
["111263549366178"] = AssetBaseURL.._d({28,28,28,29,33,30,32,31,36,30,33,33,28,34,35,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["77891951053543"] = AssetBaseURL.._d({34,34,35,36,28,36,32,28,27,32,30,32,31,30,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["78137979054938"] = AssetBaseURL.._d({34,35,28,30,34,36,34,36,27,32,31,36,30,35,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["80503127983237"] = AssetBaseURL.._d({35,27,32,27,30,28,29,34,36,35,30,29,30,34,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["10137832201"] = AssetBaseURL.._d({28,27,28,30,34,35,30,29,29,27,28,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["10137941941"] = AssetBaseURL.._d({28,27,28,30,34,36,31,28,36,31,28,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["11036884234"] = AssetBaseURL.._d({28,28,27,30,33,35,35,31,29,30,31,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["11413591840"] = AssetBaseURL.._d({28,28,31,28,30,32,36,28,35,31,27,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["11745872910"] = AssetBaseURL.._d({28,28,34,31,32,35,34,29,36,28,27,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["12577727209"] = AssetBaseURL.._d({28,29,32,34,34,34,29,34,29,27,36,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["18458939117"] = AssetBaseURL.._d({28,35,31,32,35,36,30,36,28,28,34,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["3259050989"] = AssetBaseURL.._d({30,29,32,36,27,32,27,36,35,36,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["3523728077"] = AssetBaseURL.._d({30,32,29,30,34,29,35,27,34,34,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["3602733521"] = AssetBaseURL.._d({30,33,27,29,34,30,30,32,29,28,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
[_d({52,78,90,89,46,83,80,97,93,90,89,63,90,91,56,80,79,84,96,88},21)] = AssetBaseURL.._d({52,78,90,89,46,83,80,97,93,90,89,63,90,91,56,80,79,84,96,88,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["4483362458"] = AssetBaseURL.._d({31,31,35,30,30,33,29,31,32,35,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
["5587865193"] = AssetBaseURL.._d({32,32,35,34,35,33,32,28,36,30,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
[_d({52,78,90,89,56,76,82,89,84,81,100,84,89,82,50,87,76,94,94,29},21)] = AssetBaseURL.._d({52,78,90,89,56,76,82,89,84,81,100,84,89,82,50,87,76,94,94,29,25,91,89,82,42,93,76,98,40,95,93,96,80},21),
}
for id, _ in assetFiles do
customAssets[tostring(id)] = ""
end
local hasCustomAsset = type(getcustomasset) == _d({81,96,89,78,95,84,90,89},21)
local hasFilesystem = type(writefile) == _d({81,96,89,78,95,84,90,89},21) and type(makefolder) == _d({81,96,89,78,95,84,90,89},21) and type(isfile) == _d({81,96,89,78,95,84,90,89},21) and type(isfolder) == _d({81,96,89,78,95,84,90,89},21)
if hasCustomAsset and hasFilesystem then
local ok, err = pcall(function()
ensureFolder(RayfieldFolder)
ensureFolder(AssetPath)
local attempted = {}
local function nextToFetch()
for id, _ in assetFiles do
if not attempted[id] and not isfile(AssetPath.."/"..tostring(id).._d({25,91,89,82},21)) then
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
local ok, res = pcall(requestFunc, {Url = assetFiles[id], Method = _d({50,48,63},21)})
if ok and type(res) == _d({95,76,77,87,80},21) and type(res.Body) == _d({94,95,93,84,89,82},21) and #res.Body > 0 then
end)()