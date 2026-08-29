--[[
    Offline Sandbox & Network Severing Tool
    Raw MCP remote blocking logic with '\' toggle.
]]

local UserInputService = game:GetService("UserInputService")

local Sandbox = {
    Enabled = false,
    Blocked = true,
    OriginalNamecall = nil,
}

local get_genv = rawget(getfenv(), "getgenv") or function()
    return _G
end
local hook_metamethod = rawget(getfenv(), "hookmetamethod") or get_genv().hookmetamethod
local new_cclosure = rawget(getfenv(), "newcclosure") or get_genv().newcclosure
local get_namecall_method = rawget(getfenv(), "getnamecallmethod") or get_genv().getnamecallmethod

function Sandbox.Start()
    if Sandbox.Enabled then
        return
    end

    if not hook_metamethod then
        warn("[Offline Sandbox] hookmetamethod not supported by this executor!")
        return
    end

    Sandbox.Enabled = true
    print("[Offline Sandbox] Active! All outbound remotes blocked.")

    if not Sandbox.OriginalNamecall then
        Sandbox.OriginalNamecall = hook_metamethod(
            game,
            "__namecall",
            new_cclosure(function(self, ...)
                if Sandbox.Enabled then
                    local method = get_namecall_method and get_namecall_method()
                    if method == "FireServer" or method == "InvokeServer" then
                        print("[Offline Sandbox Blocked]", method, self:GetFullName())
                        return nil
                    end
                end
                return Sandbox.OriginalNamecall(self, ...)
            end)
        )
    end
end

function Sandbox.Stop()
    Sandbox.Enabled = false
    print("[Offline Sandbox] Inactive. Normal traffic resumed.")
end

-- Start immediately
Sandbox.Start()
_G.Sandbox = Sandbox

-- Toggle hotkey '\'
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.BackSlash then
        if Sandbox.Enabled then
            Sandbox.Stop()
        else
            Sandbox.Start()
        end
    end
end)

return Sandbox
