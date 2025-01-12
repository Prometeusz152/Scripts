local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()
local m = lib:Window("ethereal. HVH")
local players = game.Players
local plr = players.LocalPlayer
getgenv().settings = {speedhack = false, props = false, players = false, crates = false, attack = false, noclip = false}
getgenv().play_settings = {props = false, seeker = false, taunt = false}

-- // Main
m:Toggle("SpeedHack", false, function (bool)
    getgenv().settings.speedhack = bool
    while getgenv().settings.speedhack do
        local delta = game:GetService("RunService").Heartbeat:Wait()
        if plr.Character.Humanoid.MoveDirection.Magnitude > 0 then
            plr.Character:TranslateBy(plr.Character.Humanoid.MoveDirection * 4 * delta * 10)
        end
    end
end)

local nc = nil
m:Toggle("Noclip", false, function (bool)
    getgenv().settings.noclip = bool
    if getgenv().settings.noclip then
        nc = game:GetService("RunService").Stepped:Connect(function ()
            pcall(function ()
                for _, child in pairs(plr.Character:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide == true then
                        child.CanCollide = false
                    end
                end
            end)
        end)
    elseif not getgenv().settings.noclip then
        if nc then
            nc:Disconnect()
        end
    end
end)

m:Button("Destroy Gui", function ()
    for key in pairs(getgenv().settings) do
        getgenv().settings[key] = false
    end
    lib:Destroy()
end)