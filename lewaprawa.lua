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
local InfoLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Active = true
Frame.Draggable = true

-- Add UICorner to round corners
local function addUICorner(instance, radius)
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, radius)
    uicorner.Parent = instance
end

SpeedHackButton.Parent = Frame
SpeedHackButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SpeedHackButton.Position = UDim2.new(0.1, 0, 0.2, 0)
SpeedHackButton.Size = UDim2.new(0.8, 0, 0.2, 0)
SpeedHackButton.Text = "Toggle SpeedHack"
addUICorner(SpeedHackButton, 10)

NoclipButton.Parent = Frame
NoclipButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
NoclipButton.Position = UDim2.new(0.1, 0, 0.5, 0)
NoclipButton.Size = UDim2.new(0.8, 0, 0.2, 0)
NoclipButton.Text = "Toggle Noclip"
addUICorner(NoclipButton, 10)

addUICorner(Frame, 10)

-- Info Label
InfoLabel.Parent = Frame
InfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
InfoLabel.Position = UDim2.new(0, 0, 0, -35) -- Adjust position to be above the frame
InfoLabel.Size = UDim2.new(1, 0, 0, 40) -- Adjust size to be slightly smaller than the frame
InfoLabel.Text = "ethereal. 0.1\n" .. plr.Name -- Display "ethereal. 0.1" and player name
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.TextScaled = true
InfoLabel.TextWrapped = true -- Wrap text to fit within the label
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left -- Align text to the left
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top -- Align text to the top
InfoLabel.Font = Enum.Font.GothamBold -- Change font to GothamBold

-- SpeedHack
local speedHackConnection
local function toggleSpeedHack()
    getgenv().settings.speedhack = not getgenv().settings.speedhack
    if getgenv().settings.speedhack then
        SpeedHackButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Purple color when active
        speedHackConnection = runService.Heartbeat:Connect(function(delta)
            if getgenv().settings.speedhack and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                if plr.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    plr.Character:TranslateBy(plr.Character.Humanoid.MoveDirection * 4 * delta * 10)
                end
            end
        end)
    else
        SpeedHackButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Default color when inactive
        if speedHackConnection then
            speedHackConnection:Disconnect()
            speedHackConnection = nil
        end
    end
end

-- Noclip
local noclipConnection
local function toggleNoclip()
    getgenv().settings.noclip = not getgenv().settings.noclip
    if getgenv().settings.noclip then
        NoclipButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Purple color when active
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
        NoclipButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Default color when inactive
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end

SpeedHackButton.MouseButton1Click:Connect(toggleSpeedHack)
NoclipButton.MouseButton1Click:Connect(toggleNoclip)

print("GUI Loaded: Use buttons to toggle SpeedHack and Noclip")
