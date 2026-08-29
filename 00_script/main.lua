--[[
    Offline Sandbox & Network Severing Tool
    Single-file utility for safe, offline script testing.
    
    Controls:
    - Press 'P' to toggle Offline Network Severing ON / OFF.
    - _G.Sandbox.Start() / _G.Sandbox.Stop() via console.
    - _G.Sandbox.DumpHistory() to inspect blocked remotes.
]]

local UserInputService = game:GetService("UserInputService")

local Sandbox = {
    Enabled = false,
    BlockAll = true,
    BlockedRemotes = {},
    IgnoredRemotes = {},
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
    print("[Offline Sandbox] 🛡️ Network severing active! All outbound remotes blocked.")

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

-- Bind 'P' hotkey for instant toggling
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.P then
        if Sandbox.Enabled then
            Sandbox.Stop()
        else
            Sandbox.Start()
        end
    end
end)

print("[Offline Sandbox] Active! Press 'P' to toggle network severing.")
return Sandbox
