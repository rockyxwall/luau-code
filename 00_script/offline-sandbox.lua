--[[
    Offline Sandbox & Network Severing Tool
    Single-file utility for safe, offline script testing with anti-disconnect keep-alive.
    
    Controls:
    - Press '\' (Backslash) to toggle Offline Network Severing ON / OFF.
    - _G.Sandbox.Start() / _G.Sandbox.Stop() via console.
    - _G.Sandbox.DumpHistory() to inspect blocked remotes.
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local Sandbox = {
    Enabled = false,
    BlockAll = true,
    BlockedRemotes = {},
    IgnoredRemotes = {},
    WhitelistedRemotes = {
        -- Keep essential ping/heartbeat packets alive if needed
        ["Ping"] = true,
        ["Heartbeat"] = true,
    },
    History = {},
    MaxHistory = 100,
    OriginalNamecall = nil,
}

local get_genv = rawget(getfenv(), "getgenv") or function()
    return _G
end
local hook_metamethod = rawget(getfenv(), "hookmetamethod") or get_genv().hookmetamethod
local new_cclosure = rawget(getfenv(), "newcclosure") or get_genv().newcclosure
local get_namecall_method = rawget(getfenv(), "getnamecallmethod") or get_genv().getnamecallmethod

local function logIntercept(method, remote, args)
    local entry = {
        Time = os.date("%X"),
        Method = method,
        RemoteName = remote.Name,
        RemotePath = remote:GetFullName(),
        Args = args,
    }
    table.insert(Sandbox.History, 1, entry)
    if #Sandbox.History > Sandbox.MaxHistory then
        table.remove(Sandbox.History)
    end
    print(string.format("[Offline Sandbox BLOCKED] %s on %s", method, entry.RemotePath))
end

-- Anti-Disconnect / Anti-AFK Keep-Alive
if LocalPlayer then
    LocalPlayer.Idled:Connect(function()
        if Sandbox.Enabled then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

function Sandbox.Start()
    if Sandbox.Enabled then
        print("[Offline Sandbox] Already active.")
        return
    end

    if not hook_metamethod then
        warn("[Offline Sandbox] hookmetamethod not supported by this executor!")
        return
    end

    Sandbox.Enabled = true
    print("[Offline Sandbox] 🛡️ Network severing active! Outbound remotes blocked.")

    if not Sandbox.OriginalNamecall then
        Sandbox.OriginalNamecall = hook_metamethod(
            game,
            "__namecall",
            new_cclosure(function(self, ...)
                if Sandbox.Enabled then
                    local method = get_namecall_method and get_namecall_method()
                    if method == "FireServer" or method == "InvokeServer" then
                        if
                            self:IsA("RemoteEvent")
                            or self:IsA("RemoteFunction")
                            or self:IsA("UnreliableRemoteEvent")
                        then
                            local remoteName = self.Name

                            -- Keep whitelisted heartbeat packets alive to prevent connection drops
                            if Sandbox.WhitelistedRemotes[remoteName] then
                                return Sandbox.OriginalNamecall(self, ...)
                            end

                            local isBlocked = Sandbox.BlockAll or Sandbox.BlockedRemotes[remoteName]

                            if isBlocked and not Sandbox.IgnoredRemotes[remoteName] then
                                logIntercept(method, self, { ... })
                                return nil
                            end
                        end
                    end
                end
                return Sandbox.OriginalNamecall(self, ...)
            end)
        )
    end
end

function Sandbox.Stop()
    if not Sandbox.Enabled then
        return
    end
    Sandbox.Enabled = false
    print("[Offline Sandbox] 🔓 Network severing stopped. Live traffic resumed.")
end

function Sandbox.BlockRemote(name)
    Sandbox.BlockedRemotes[name] = true
    print("[Offline Sandbox] Blocked remote: " .. name)
end

function Sandbox.UnblockRemote(name)
    Sandbox.BlockedRemotes[name] = nil
    print("[Offline Sandbox] Unblocked remote: " .. name)
end

function Sandbox.DumpHistory()
    print("=== [Offline Sandbox Blocked Remote History] ===")
    for i, entry in ipairs(Sandbox.History) do
        print(string.format("[%d] %s | %s -> %s", i, entry.Time, entry.Method, entry.RemotePath))
    end
end

-- Start offline sandbox immediately on execution
Sandbox.Start()
_G.Sandbox = Sandbox

-- Bind '\' (BackSlash) hotkey for instant toggling
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.BackSlash then
        if Sandbox.Enabled then
            Sandbox.Stop()
        else
            Sandbox.Start()
        end
    end
end)

print("[Offline Sandbox] Active! Press '\\' to toggle network severing.")
return Sandbox
