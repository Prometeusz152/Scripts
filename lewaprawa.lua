local players = game.Players
local plr = players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

getgenv().settings = {speedhack = false, noclip = false}

-- Load the GUI library
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()
local m = lib:Window("skid.gg HVH", Color3.fromRGB(50, 50, 50), Color3.fromRGB(100, 100, 100))

-- Add UICorner to round corners
local function addUICorner(instance, radius)
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, radius)
    uicorner.Parent = instance
end

-- SpeedHack
local function toggleSpeedHack(enabled)
    getgenv().settings.speedhack = enabled
    if enabled then
        runService.Heartbeat:Connect(function(delta)
            if getgenv().settings.speedhack and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                if plr.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    plr.Character:TranslateBy(plr.Character.Humanoid.MoveDirection * 4 * delta * 10)
                end
            end
        end)
    end
end

-- Noclip
local noclipConnection
local function toggleNoclip(enabled)
    getgenv().settings.noclip = enabled
    if enabled then
        noclipConnection = runService.Stepped:Connect(function()
            if plr.Character then
                for _, child in pairs(plr.Character:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide == true then
                        child.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
    end
end

-- Create GUI buttons
local speedHackToggle = m:Toggle("SpeedHack", false, function (bool)
    toggleSpeedHack(bool)
end)

local noclipToggle = m:Toggle("Noclip", false, function (bool)
    toggleNoclip(bool)
end)

-- Apply rounded corners to GUI elements
addUICorner(speedHackToggle, 10)
addUICorner(noclipToggle, 10)
addUICorner(m, 10)

print("GUI Loaded: Use buttons to toggle SpeedHack and Noclip")
