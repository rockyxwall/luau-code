--[[
    Offline Sandbox & Network Severing Tool
    Intercepts and blocks outbound RemoteEvents/RemoteFunctions with ']' toggle.
]]

local UserInputService = game:GetService("UserInputService")

local Sandbox = {
    Enabled = false,
    OriginalNamecall = nil,
}

-- Resolve executor environment globals safely (supports Real and all standard Luau executors)
local env = (type(getgenv) == "function" and getgenv()) or getfenv()
local hook_metamethod = env.hookmetamethod or hookmetamethod
local hook_function = env.hookfunction or hookfunction
local get_raw_mt = env.getrawmetatable or getrawmetatable
local set_ro = env.setreadonly or setreadonly
local new_cclosure = env.newcclosure or newcclosure
local get_nc_method = env.getnamecallmethod or getnamecallmethod

function Sandbox.Start()
    if Sandbox.Enabled then
        print("[Offline Sandbox] Already active.")
        return
    end

    Sandbox.Enabled = true
    print("[Offline Sandbox] 🛡️ Network severing active! Outbound remotes blocked.")

    if not Sandbox.OriginalNamecall then
        local handler = function(self, ...)
            if Sandbox.Enabled then
                local method = get_nc_method and get_nc_method()
                if method == "FireServer" or method == "InvokeServer" then
                    print("[Offline Sandbox BLOCKED]", method, self:GetFullName())
                    return nil
                end
            end
            return Sandbox.OriginalNamecall(self, ...)
        end

        local safeClosure = new_cclosure and new_cclosure(handler) or handler

        if hook_metamethod then
            Sandbox.OriginalNamecall = hook_metamethod(game, "__namecall", safeClosure)
        elseif get_raw_mt then
            local mt = get_raw_mt(game)
            if mt then
                if set_ro then
                    set_ro(mt, false)
                end
                Sandbox.OriginalNamecall = mt.__namecall
                mt.__namecall = safeClosure
                if set_ro then
                    set_ro(mt, true)
                end
            end
        else
            warn("[Offline Sandbox] Metamethod hooking not supported on this executor!")
        end
    end
end

function Sandbox.Stop()
    Sandbox.Enabled = false
    print("[Offline Sandbox] 🔓 Inactive. Normal traffic resumed.")
end

-- Start immediately
Sandbox.Start()
_G.Sandbox = Sandbox

-- Toggle hotkey ']' (RightBracket)
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightBracket then
        if Sandbox.Enabled then
            Sandbox.Stop()
        else
            Sandbox.Start()
        end
    end
end)

print("[Offline Sandbox] Active! Press ']' to toggle offline network severing.")
return Sandbox
