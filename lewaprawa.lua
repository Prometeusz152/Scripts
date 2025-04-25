-- UTILITYS
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

-- GUI SETUP
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "RemoteSpyGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 500, 0, 400)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(90, 90, 90)

local Scroll = Instance.new("ScrollingFrame", Frame)
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 6
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local UIList = Instance.new("UIListLayout", Scroll)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 4)

-- FUNCTION TO ADD LOG ENTRY
local function addRemoteLog(remotePath, method, args)
    local entry = Instance.new("TextButton")
    entry.Size = UDim2.new(1, -10, 0, 50)
    entry.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    entry.TextColor3 = Color3.fromRGB(255, 255, 255)
    entry.TextWrapped = true
    entry.TextXAlignment = Enum.TextXAlignment.Left
    entry.Text = ("%s :%s(...)"):format(remotePath, method)

    entry.MouseButton1Click:Connect(function()
        local copied = ("game.%s:%s(%s)"):format(
            remotePath,
            method,
            #args > 0 and "unpack(" .. get_table(args) .. ")" or ""
        )
        setclipboard(copied)
        entry.Text = "✅ Skopiowano!"
        task.wait(1.5)
        entry.Text = ("%s :%s(...)"):format(remotePath, method)
    end)

    entry.Parent = Scroll
    Scroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end

-- HOOK __namecall
getgenv().Methods = {
    FireServer = true,
    InvokeServer = true
}
getgenv().Blacklisted = {
    ["SendPosition"] = true
}

local meta = getrawmetatable(game)
local old = meta.__namecall
local methodCaller = getnamecallmethod or get_namecall_method
local protect = newcclosure or function(f) return f end

if setreadonly then setreadonly(meta, false) else make_writeable(meta, true) end

meta.__namecall = protect(function(self, ...)
    local method = methodCaller()
    local args = {...}
    local name = tostring(self.Name)
    if getgenv().Methods[method] and not getgenv().Blacklisted[name] then
        local path = self:GetFullName()
        addRemoteLog(path, method, args)
    end
    return old(self, ...)
end)

if setreadonly then setreadonly(meta, true) else make_writeable(meta, false) end

print("✅ RemoteSpy GUI Loaded.")
