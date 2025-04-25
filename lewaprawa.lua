-- Configuration
local IGNORED = {
    ["SendPosition"] = true,
    ["UpdateMovement"] = true,
    ["Heartbeat"] = true
}

local MAX_ENTRIES = 100 -- Maximum log entries to display
local LOG_DELAY = 0.1    -- Delay between logging the same remote to avoid spam
local LOG_TO_SCREEN = true -- Set to true to log to the screen as well

-- GUI for showing logs on the screen
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "RemoteSpyGUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 500, 0, 400)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -10)
scroll.Position = UDim2.new(0, 5, 0, 5)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 4)

-- Function to format table to string (for argument inspection)
local function get_table(node)
    local str = ""
    local function recur(tbl, depth)
        local indent = string.rep("  ", depth)
        str = str .. "{\n"
        for k, v in pairs(tbl) do
            local key = type(k) == "string" and ("['%s']"):format(k) or ("[%s]"):format(tostring(k))
            if type(v) == "table" then
                str = str .. indent .. key .. " = "
                recur(v, depth + 1)
            else
                str = str .. indent .. key .. " = " .. (type(v) == "string" and ("'%s'"):format(v) or tostring(v)) .. ",\n"
            end
        end
        str = str .. string.rep("  ", depth - 1) .. "},\n"
    end
    recur(node, 1)
    return str
end

-- Asynchronous function to log to the screen and console
local function asyncLog(message)
    -- Log to console (rconsoleprint if available)
    if rconsoleprint then
        rconsoleprint(message .. "\n")
    end

    -- Log to screen (if enabled)
    if LOG_TO_SCREEN then
        local textLabel = Instance.new("TextLabel", scroll)
        textLabel.Size = UDim2.new(1, -10, 0, 50)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextWrapped = true
        textLabel.Text = message
        textLabel.TextXAlignment = Enum.TextXAlignment.Left

        -- Automatically remove old logs
        if #scroll:GetChildren() > MAX_ENTRIES then
            scroll:GetChildren()[1]:Destroy()
        end

        -- Update scroll
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end
end

-- Hook function for RemoteEvent/RemoteFunction calls
local lastCalls = {}
local meta = getrawmetatable(game)
local old = meta.__namecall
local methodCall = getnamecallmethod or get_namecall_method
local protect = newcclosure or function(f) return f end

if setreadonly then setreadonly(meta, false) else make_writeable(meta, true) end

meta.__namecall = protect(function(...)
    local args = {...}
    local self = args[1]
    local method = methodCall()

    if typeof(self) == "Instance" and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
        local name = tostring(self.Name)
        if not IGNORED[name] then
            local path = self:GetFullName()
            local sig = path .. method
            local now = tick()

            -- Anti-spam: only log every LOG_DELAY seconds
            if (not lastCalls[sig]) or (now - lastCalls[sig] > LOG_DELAY) then
                lastCalls[sig] = now
                local callStr = ("game.%s:%s(%s)"):format(path, method, (#args > 1 and "unpack(" .. get_table({select(2, unpack(args))}) .. ")" or ""))
                asyncLog(("%s :%s(...)"):format(path, method))
            end
        end
    end

    return old(...)
end)

if setreadonly then setreadonly(meta, true) else make_writeable(meta, false) end

print("✅ RemoteSpy Loaded with Async Logging and Optimized Performance.")
