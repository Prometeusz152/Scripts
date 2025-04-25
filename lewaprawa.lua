-- Sprawdź czy masz podstawowe funkcje
assert(getrawmetatable, "Your exploit doesn't support getrawmetatable")
assert((setreadonly or make_writeable), "Your exploit doesn't support setreadonly/make_writeable")
assert((getnamecallmethod or get_namecall_method), "Your exploit doesn't support getnamecallmethod/get_namecall_method")

-- get_table funkcja – konwertuje tablice na tekst
local function get_table(node)
    local cache, stack, output = {},{},{}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k,v in pairs(node) do size = size + 1 end

        local cur_index = 1
        for k,v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then
                if string.find(output_str,"}",output_str:len()) then
                    output_str = output_str .. ",\n"
                elseif not string.find(output_str,"\n",output_str:len()) then
                    output_str = output_str .. "\n"
                end

                table.insert(output,output_str)
                output_str = ""

                local key = (type(k) == "number" or type(k) == "boolean") and "["..tostring(k).."]" or "['"..tostring(k).."']"

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = "..tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = {\n"
                    table.insert(stack,node)
                    table.insert(stack,v)
                    cache[node] = cur_index+1
                    break
                else
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = '"..tostring(v).."'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    table.insert(output,output_str)
    output_str = table.concat(output)

    return output_str
end

-- Ustawienie domyślnych filtrów
getgenv().Methods = {
    FireServer = true,
    InvokeServer = true
}
getgenv().Blacklisted = {}

-- Funkcja logowania (do konsoli + opcjonalny notify)
local function log(Method, Event, Args)
    local path = Event:GetFullName()
    print("====== REMOTE CALL ======")
    print("Method:", Method)
    print("Event:", tostring(Event))
    print("Path:", path)
    if #Args > 0 then
        print("Args:\n", get_table(Args))
    else
        print("Args: {}")
    end
    print(("Script Call: game.%s:%s(%s)\n"):format(path, Method, #Args > 0 and "..." or ""))
    
    -- Opcjonalny Notify
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Remote Spy",
            Text = ("%s | %s"):format(Method, Event.Name),
            Duration = 3
        })
    end)
end

-- Hookowanie __namecall
local meta = getrawmetatable(game)
local old = meta.__namecall
local callMethod = getnamecallmethod or get_namecall_method
local protect = newcclosure or function(f) return f end

if setreadonly then setreadonly(meta, false) else make_writeable(meta, true) end

meta.__namecall = protect(function(Self, ...)
    local method = callMethod()
    local args = {...}
    if getgenv().Methods[method] and not getgenv().Blacklisted[tostring(Self)] then
        log(method, Self, args)
    end
    return old(Self, ...)
end)

if setreadonly then setreadonly(meta, true) else make_writeable(meta, false) end

print("✅ RemoteSpy by ChatGPT loaded – monitoring FireServer/InvokeServer.")
