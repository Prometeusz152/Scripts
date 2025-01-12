local players = game.Players
local plr = players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

getgenv().settings = {speedhack = false, noclip = false}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local SpeedHackButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.Size = UDim2.new(0, 200, 0, 100)

-- Add UICorner to round corners
local function addUICorner(instance, radius)
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, radius)
    uicorner.Parent = instance
end

SpeedHackButton.Parent = Frame
SpeedHackButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SpeedHackButton.Position = UDim2.new(0.1, 0, 0.1, 0)
SpeedHackButton.Size = UDim2.new(0.8, 0, 0.3, 0)
SpeedHackButton.Text = "Toggle SpeedHack"
addUICorner(SpeedHackButton, 10)

NoclipButton.Parent = Frame
NoclipButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
NoclipButton.Position = UDim2.new(0.1, 0, 0.6, 0)
NoclipButton.Size = UDim2.new(0.8, 0, 0.3, 0)
NoclipButton.Text = "Toggle Noclip"
addUICorner(NoclipButton, 10)

addUICorner(Frame, 10)

-- SpeedHack
local function toggleSpeedHack()
    getgenv().settings.speedhack = not getgenv().settings.speedhack
    if getgenv().settings.speedhack then
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
local function toggleNoclip()
    getgenv().settings.noclip = not getgenv().settings.noclip
    if getgenv().settings.noclip then
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

SpeedHackButton.MouseButton1Click:Connect(toggleSpeedHack)
NoclipButton.MouseButton1Click:Connect(toggleNoclip)

print("GUI Loaded: Use buttons to toggle SpeedHack and Noclip")
