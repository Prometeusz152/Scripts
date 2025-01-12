local players = game.Players
local plr = players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

getgenv().settings = {speedhack = false, noclip = false, jumpmode = false}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local SpeedHackButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local JumpModeButton = Instance.new("TextButton")
local SpeedHackCheckbox = Instance.new("TextButton")
local NoclipCheckbox = Instance.new("TextButton")
local JumpModeCheckbox = Instance.new("TextButton")
local InfoLabel = Instance.new("TextLabel")
local LoginFrame = Instance.new("Frame")
local PasswordBox = Instance.new("TextBox")
local LoginButton = Instance.new("TextButton")
local LoadingFrame = Instance.new("Frame")
local LoadingLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui

-- Add UICorner to round corners
local function addUICorner(instance, radius)
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, radius)
    uicorner.Parent = instance
end

-- Login Frame
LoginFrame.Parent = ScreenGui
LoginFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LoginFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
LoginFrame.Size = UDim2.new(0, 200, 0, 100)
LoginFrame.Active = true
LoginFrame.Visible = false
addUICorner(LoginFrame, 10)

PasswordBox.Parent = LoginFrame
PasswordBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
PasswordBox.Position = UDim2.new(0.1, 0, 0.2, 0)
PasswordBox.Size = UDim2.new(0.8, 0, 0.3, 0)
PasswordBox.PlaceholderText = "Enter Password"
PasswordBox.Text = ""
PasswordBox.TextSize = 13 
PasswordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PasswordBox.TextXAlignment = Enum.TextXAlignment.Left -- Align text to the left
addUICorner(PasswordBox, 10)

LoginButton.Parent = LoginFrame
LoginButton.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
LoginButton.Position = UDim2.new(0.1, 0, 0.6, 0)
LoginButton.Size = UDim2.new(0.8, 0, 0.3, 0)
LoginButton.Text = "Zaloguj się"
LoginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginButton.TextSize = 14 -- Set the text size to a smaller value
LoginButton.TextWrapped = true -- Ensure text wraps if necessary
LoginButton.TextXAlignment = Enum.TextXAlignment.Center -- Align text to the center horizontally
LoginButton.TextYAlignment = Enum.TextXAlignment.Center -- Align text to the center vertically
addUICorner(LoginButton, 10)

-- Loading Frame
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LoadingFrame.Position = UDim2.new(0.5, -50, 0.5, -50)
LoadingFrame.Size = UDim2.new(0, 100, 0, 100)
LoadingFrame.Visible = false
addUICorner(LoadingFrame, 10)

LoadingLabel.Parent = LoadingFrame
LoadingLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
LoadingLabel.Size = UDim2.new(0.8, 0, 0.8, 0)
LoadingLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
LoadingLabel.Text = ""
addUICorner(LoadingLabel, 10)

-- Main Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.5, -300, 0.5, -100) -- Adjust position to center the larger frame
Frame.Size = UDim2.new(0, 600, 0, 300) -- Increase width of the frame
Frame.Active = true
Frame.Draggable = true
Frame.Visible = false -- Hide main frame initially
Frame.BorderSizePixel = 0 -- Remove border

-- Scrolling Frame
ScrollingFrame.Parent = Frame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0) -- Adjust canvas size to allow scrolling
ScrollingFrame.ScrollBarThickness = 10
ScrollingFrame.BorderSizePixel = 0 -- Remove border

SpeedHackButton.Parent = ScrollingFrame
SpeedHackButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SpeedHackButton.Position = UDim2.new(0.55, 0, 0.1, 0) -- Move button to the right
SpeedHackButton.Size = UDim2.new(0.35, 0, 0.1, 0) -- Adjust width and height of the button
SpeedHackButton.Text = "Toggle SpeedHack"
SpeedHackButton.BorderColor3 = Color3.fromRGB(70, 70, 70) -- Add border color
SpeedHackButton.BorderSizePixel = 1 -- Add border size
addUICorner(SpeedHackButton, 10)

SpeedHackCheckbox.Parent = SpeedHackButton
SpeedHackCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Darker color for checkbox
SpeedHackCheckbox.Position = UDim2.new(0.8, 0, 0.1, 0)
SpeedHackCheckbox.Size = UDim2.new(0.15, 0, 0.8, 0) -- Make checkbox square
SpeedHackCheckbox.Text = ""
SpeedHackCheckbox.BorderColor3 = Color3.fromRGB(50, 50, 50) -- Add border color to checkbox
SpeedHackCheckbox.BorderSizePixel = 1 -- Add border size to checkbox
addUICorner(SpeedHackCheckbox, 10)

NoclipButton.Parent = ScrollingFrame
NoclipButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
NoclipButton.Position = UDim2.new(0.55, 0, 0.25, 0) -- Move button to the right
NoclipButton.Size = UDim2.new(0.35, 0, 0.1, 0) -- Adjust width and height of the button
NoclipButton.Text = "Toggle Noclip"
NoclipButton.BorderColor3 = Color3.fromRGB(70, 70, 70) -- Add border color
NoclipButton.BorderSizePixel = 1 -- Add border size
addUICorner(NoclipButton, 10)

NoclipCheckbox.Parent = NoclipButton
NoclipCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Darker color for checkbox
NoclipCheckbox.Position = UDim2.new(0.8, 0, 0.1, 0)
NoclipCheckbox.Size = UDim2.new(0.15, 0, 0.8, 0) -- Make checkbox square
NoclipCheckbox.Text = ""
NoclipCheckbox.BorderColor3 = Color3.fromRGB(50, 50, 50) -- Add border color to checkbox
NoclipCheckbox.BorderSizePixel = 1 -- Add border size to checkbox
addUICorner(NoclipCheckbox, 10)

JumpModeButton.Parent = ScrollingFrame
JumpModeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
JumpModeButton.Position = UDim2.new(0.55, 0, 0.4, 0) -- Move button to the right
JumpModeButton.Size = UDim2.new(0.35, 0, 0.1, 0) -- Adjust width and height of the button
JumpModeButton.Text = "Toggle JumpMode"
JumpModeButton.BorderColor3 = Color3.fromRGB(70, 70, 70) -- Add border color
JumpModeButton.BorderSizePixel = 1 -- Add border size
addUICorner(JumpModeButton, 10)

JumpModeCheckbox.Parent = JumpModeButton
JumpModeCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Darker color for checkbox
JumpModeCheckbox.Position = UDim2.new(0.8, 0, 0.1, 0)
JumpModeCheckbox.Size = UDim2.new(0.15, 0, 0.8, 0) -- Make checkbox square
JumpModeCheckbox.Text = ""
JumpModeCheckbox.BorderColor3 = Color3.fromRGB(50, 50, 50) -- Add border color to checkbox
JumpModeCheckbox.BorderSizePixel = 1 -- Add border size to checkbox
addUICorner(JumpModeCheckbox, 10)

addUICorner(Frame, 10)

InfoLabel.Parent = Frame
InfoLabel.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
InfoLabel.BorderSizePixel = 0 -- Remove the border
InfoLabel.Position = UDim2.new(0, 0, 0, -50) -- Adjust position to be aligned with the frame
InfoLabel.Size = UDim2.new(1, 0, 0, 50) -- Adjust size to be slightly larger in height
InfoLabel.Text = "ethereal. 0.3\n" .. plr.Name -- Display "ethereal. 0.1" and player name
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.TextSize = 14 -- Set the text size to a smaller value
InfoLabel.TextWrapped = true -- Wrap text to fit within the label
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left -- Align text to the left
InfoLabel.TextYAlignment = Enum.TextYAlignment.Center -- Align text to the center vertically
InfoLabel.Font = Enum.Font.GothamBold -- Change font to GothamBold
InfoLabel.TextStrokeTransparency = 1 -- Remove text stroke
InfoLabel.Visible = false -- Hide InfoLabel initially

-- Add padding to InfoLabel
local padding = Instance.new("UIPadding")
padding.Parent = InfoLabel
padding.PaddingLeft = UDim.new(0, 10) -- Adjust the value to move the text to the right

-- Add Avatar Image
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Parent = Frame
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AvatarImage.BorderSizePixel = 0
AvatarImage.Position = UDim2.new(0, 5, 0, -45) -- Position to the left of the text
AvatarImage.Size = UDim2.new(0, 30, 0, 30) -- Adjust size as needed
AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=420&h=420" -- Load player's avatar
addUICorner(AvatarImage, 10) -- Add rounded corners to the avatar image
AvatarImage.Visible = false -- Hide AvatarImage initially

local speedHackConnection
local function toggleSpeedHack()
    getgenv().settings.speedhack = not getgenv().settings.speedhack
    if getgenv().settings.speedhack then
        SpeedHackCheckbox.BackgroundColor3 = Color3.fromRGB(111, 106, 155) -- Purple color when active
        speedHackConnection = runService.Heartbeat:Connect(function(delta)
            if getgenv().settings.speedhack and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                if plr.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    plr.Character:TranslateBy(plr.Character.Humanoid.MoveDirection * 4 * delta * 10)
                end
            end
        end)
    else
        SpeedHackCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Default color when inactive
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
        NoclipCheckbox.BackgroundColor3 = Color3.fromRGB(111, 106, 155) -- Purple color when active
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
        NoclipCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Default color when inactive
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end

-- JumpMode
local jumpModeConnection
local function toggleJumpMode()
    getgenv().settings.jumpmode = not getgenv().settings.jumpmode
    if getgenv().settings.jumpmode then
        JumpModeCheckbox.BackgroundColor3 = Color3.fromRGB(111, 106, 155) -- Purple color when active
        jumpModeConnection = userInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Space then
                while getgenv().settings.jumpmode and userInputService:IsKeyDown(Enum.KeyCode.Space) do
                    if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                        plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                    wait(0.1)
                end
            end
        end)
    else
        JumpModeCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Default color when inactive
        if jumpModeConnection then
            jumpModeConnection:Disconnect()
            jumpModeConnection = nil
        end
    end
end

SpeedHackCheckbox.MouseButton1Click:Connect(toggleSpeedHack)
NoclipCheckbox.MouseButton1Click:Connect(toggleNoclip)
JumpModeCheckbox.MouseButton1Click:Connect(toggleJumpMode)

-- Login functionality
LoginButton.MouseButton1Click:Connect(function()
    if PasswordBox.Text == "sigma" and plr.Name == "LearnHow_ToHustle" then
        LoginFrame.Visible = false
        LoadingFrame.Visible = true

        -- Loading animation
        local loadingTween = tweenService:Create(LoadingLabel, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Rotation = 360})
        loadingTween:Play()

        wait(5) -- Simulate loading time

        loadingTween:Cancel()
        LoadingFrame.Visible = false
        Frame.Visible = true
        InfoLabel.Visible = true -- Show InfoLabel after login
        AvatarImage.Visible = true -- Show AvatarImage after login
    else
        PasswordBox.Text = ""
        PasswordBox.PlaceholderText = "Incorrect Password or Username"
    end
end)

-- Show login frame with animation
local function showLoginFrame()
    LoginFrame.Visible = true
    LoginFrame.Position = UDim2.new(0.5, -100, 0.5, -200)
    local tween = tweenService:Create(LoginFrame, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -100, 0.5, -50)})
    tween:Play()
end

showLoginFrame()

print("GUI Loaded: Use buttons to toggle SpeedHack, Noclip, and JumpMode")
