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
local LoadingBackground = Instance.new("Frame")
local LoadingBar = Instance.new("Frame")
local ButtonsBackground = Instance.new("Frame")
local OuterBackground = Instance.new("Frame") -- New outer background
local ToggleButton = Instance.new("TextButton") -- New toggle button for sliding
local isMenuVisible = true -- Track menu visibility

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
LoginFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoginFrame.Size = UDim2.new(0, 0, 0, 0)
LoginFrame.AnchorPoint = Vector2.new(0.5, 0.5)
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
PasswordBox.TextXAlignment = Enum.TextXAlignment.Left
addUICorner(PasswordBox, 10)

local UIPadding = Instance.new("UIPadding")
UIPadding.Parent = PasswordBox
UIPadding.PaddingLeft = UDim.new(0, 10)

LoginButton.Parent = LoginFrame
LoginButton.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
LoginButton.Position = UDim2.new(0.1, 0, 0.6, 0)
LoginButton.Size = UDim2.new(0.8, 0, 0.3, 0)
LoginButton.Text = "Zaloguj się"
LoginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginButton.TextSize = 14
LoginButton.TextWrapped = true
LoginButton.TextXAlignment = Enum.TextXAlignment.Center
LoginButton.TextYAlignment = Enum.TextYAlignment.Center
addUICorner(LoginButton, 10)

-- Loading Frame
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.Size = UDim2.new(0, 100, 0, 100)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.Visible = false
addUICorner(LoadingFrame, 10)

LoadingBackground.Parent = LoadingFrame
LoadingBackground.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
LoadingBackground.Size = UDim2.new(0.8, 0, 0.1, 0)
LoadingBackground.Position = UDim2.new(0.1, 0, 0.45, 0)
addUICorner(LoadingBackground, 5)

LoadingBar.Parent = LoadingBackground
LoadingBar.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.Position = UDim2.new(0, 0, 0, 0)
addUICorner(LoadingBar, 5)

-- Main Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Frame.Position = UDim2.new(0.5, -300, 0.5, -100)
Frame.Size = UDim2.new(0, 600, 0, 300)
Frame.Active = true
Frame.Draggable = true
Frame.Visible = false
Frame.BorderSizePixel = 0

-- Outer Background
OuterBackground.Parent = Frame
OuterBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OuterBackground.Position = UDim2.new(0, 0, 0, 0)
OuterBackground.Size = UDim2.new(1, 0, 1, 0)
OuterBackground.BorderSizePixel = 0
addUICorner(OuterBackground, 10)

-- Scrolling Frame
ScrollingFrame.Parent = OuterBackground
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
ScrollingFrame.ScrollBarThickness = 10
ScrollingFrame.BorderSizePixel = 0

-- Add background under buttons
ButtonsBackground.Parent = ScrollingFrame
ButtonsBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ButtonsBackground.Position = UDim2.new(0.05, 0, 0.05, 0)
ButtonsBackground.Size = UDim2.new(0.9, 0, 0.5, 0)
ButtonsBackground.BorderSizePixel = 0
addUICorner(ButtonsBackground, 10)

SpeedHackButton.Parent = ButtonsBackground
SpeedHackButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedHackButton.Position = UDim2.new(0.05, 0, 0.05, 0)
SpeedHackButton.Size = UDim2.new(0.9, 0, 0.25, 0)
SpeedHackButton.Text = "Toggle SpeedHack"
SpeedHackButton.BorderColor3 = Color3.fromRGB(111, 106, 155)
SpeedHackButton.BorderSizePixel = 2
addUICorner(SpeedHackButton, 10)

SpeedHackCheckbox.Parent = SpeedHackButton
SpeedHackCheckbox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
SpeedHackCheckbox.Position = UDim2.new(0.85, 0, 0.1, 0)
SpeedHackCheckbox.Size = UDim2.new(0.1, 0, 0.8, 0.8) -- Make it square
SpeedHackCheckbox.Text = ""
SpeedHackCheckbox.BorderColor3 = Color3.fromRGB(111, 106, 155)
SpeedHackCheckbox.BorderSizePixel = 2
addUICorner(SpeedHackCheckbox, 10)

NoclipButton.Parent = ButtonsBackground
NoclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
NoclipButton.Position = UDim2.new(0.05, 0, 0.35, 0)
NoclipButton.Size = UDim2.new(0.9, 0, 0.25, 0)
NoclipButton.Text = "Toggle Noclip"
NoclipButton.BorderColor3 = Color3.fromRGB(111, 106, 155)
NoclipButton.BorderSizePixel = 2
addUICorner(NoclipButton, 10)

NoclipCheckbox.Parent = NoclipButton
NoclipCheckbox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
NoclipCheckbox.Position = UDim2.new(0.85, 0, 0.1, 0)
NoclipCheckbox.Size = UDim2.new(0.1, 0, 0.8, 0.8) -- Make it square
NoclipCheckbox.Text = ""
NoclipCheckbox.BorderColor3 = Color3.fromRGB(111, 106, 155)
NoclipCheckbox.BorderSizePixel = 2
addUICorner(NoclipCheckbox, 10)

JumpModeButton.Parent = ButtonsBackground
JumpModeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
JumpModeButton.Position = UDim2.new(0.05, 0, 0.65, 0)
JumpModeButton.Size = UDim2.new(0.9, 0, 0.25, 0)
JumpModeButton.Text = "Toggle JumpMode"
JumpModeButton.BorderColor3 = Color3.fromRGB(111, 106, 155)
JumpModeButton.BorderSizePixel = 2
addUICorner(JumpModeButton, 10)

JumpModeCheckbox.Parent = JumpModeButton
JumpModeCheckbox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
JumpModeCheckbox.Position = UDim2.new(0.85, 0, 0.1, 0)
JumpModeCheckbox.Size = UDim2.new(0.1, 0, 0.8, 0.8) -- Make it square
JumpModeCheckbox.Text = ""
JumpModeCheckbox.BorderColor3 = Color3.fromRGB(111, 106, 155)
JumpModeCheckbox.BorderSizePixel = 2
addUICorner(JumpModeCheckbox, 10)

addUICorner(Frame, 10)

InfoLabel.Parent = Frame
InfoLabel.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
InfoLabel.BorderSizePixel = 0
InfoLabel.Position = UDim2.new(0, 0, 0, -50)
InfoLabel.Size = UDim2.new(1, 0, 0, 50)
InfoLabel.Text = "ethereal. 0.3\n" .. plr.Name
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.TextSize = 14
InfoLabel.TextWrapped = true
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextYAlignment = Enum.TextYAlignment.Center
InfoLabel.Font = Enum.Font.GothamBold
InfoLabel.TextStrokeTransparency = 1
InfoLabel.Visible = false

-- Add padding to InfoLabel
local padding = Instance.new("UIPadding")
padding.Parent = InfoLabel
padding.PaddingLeft = UDim.new(0, 40)

-- Add Avatar Image
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Parent = Frame
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AvatarImage.BorderSizePixel = 0
AvatarImage.Position = UDim2.new(0, 5, 0, -40)
AvatarImage.Size = UDim2.new(0, 30, 0, 30)
AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=420&h=420"
addUICorner(AvatarImage, 10)
AvatarImage.Visible = false

-- Toggle Button for sliding menu
ToggleButton.Parent = InfoLabel
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleButton.Position = UDim2.new(1, -40, 0, 10) -- Position at the top right corner
ToggleButton.Size = UDim2.new(0, 30, 0, 30)
ToggleButton.Text = "▲" -- Arrow icon
addUICorner(ToggleButton, 5)

local function toggleMenu()
    isMenuVisible = not isMenuVisible
    local targetPosition = isMenuVisible and UDim2.new(0.05, 0, 0.05, 0) or UDim2.new(0.05, 0, -0.5, 0)
    local targetScrollSize = isMenuVisible and UDim2.new(1, 0, 1, 0) or UDim2.new(1, 0, 0, 0)
    local targetOuterSize = isMenuVisible and UDim2.new(1, 0, 1, 0) or UDim2.new(1, 0, 0, 0)
    local tweenBackground = tweenService:Create(ButtonsBackground, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPosition})
    local tweenScroll = tweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetScrollSize})
    tweenBackground:Play()
    tweenScroll:Play()
    ToggleButton.Text = isMenuVisible and "▲" or "▼"
end

ToggleButton.MouseButton1Click:Connect(toggleMenu)
local speedHackConnection
local function toggleSpeedHack()
    getgenv().settings.speedhack = not getgenv().settings.speedhack
    if getgenv().settings.speedhack then
        SpeedHackCheckbox.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
        speedHackConnection = runService.Heartbeat:Connect(function(delta)
            if getgenv().settings.speedhack and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                if plr.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    plr.Character:TranslateBy(plr.Character.Humanoid.MoveDirection * 4 * delta * 10)
                end
            end
        end)
    else
        SpeedHackCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        if speedHackConnection then
            speedHackConnection:Disconnect()
            speedHackConnection = nil
        end
    end
end

-- Noclip (Fly Mode)
local noclipConnection
local flyUpConnection
local flyDownConnection
local function toggleNoclip()
    getgenv().settings.noclip = not getgenv().settings.noclip
    if getgenv().settings.noclip then
        NoclipCheckbox.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
        local bodyGyro = Instance.new("BodyGyro")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyGyro.P = 9e4
        bodyGyro.Parent = plr.Character.HumanoidRootPart
        bodyVelocity.Parent = plr.Character.HumanoidRootPart
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        noclipConnection = runService.RenderStepped:Connect(function()
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = true
            end
            local moveDirection = plr.Character.Humanoid.MoveDirection
            local cameraDirection = workspace.CurrentCamera.CFrame.LookVector
            bodyVelocity.Velocity = (moveDirection + cameraDirection) * 50
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        end)

        flyUpConnection = userInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Space then
                bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, 50, 0)
            end
        end)

        flyDownConnection = userInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.LeftShift then
                bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, -50, 0)
            end
        end)
    else
        NoclipCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if flyUpConnection then
            flyUpConnection:Disconnect()
            flyUpConnection = nil
        end
        if flyDownConnection then
            flyDownConnection:Disconnect()
            flyDownConnection = nil
        end
        if plr.Character then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
            if plr.Character.HumanoidRootPart:FindFirstChild("BodyGyro") then
                plr.Character.HumanoidRootPart.BodyGyro:Destroy()
            end
            if plr.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                plr.Character.HumanoidRootPart.BodyVelocity:Destroy()
            end
        end
    end
end
-- JumpMode
local jumpModeConnection
local function toggleJumpMode()
    getgenv().settings.jumpmode = not getgenv().settings.jumpmode
    if getgenv().settings.jumpmode then
        JumpModeCheckbox.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
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
        JumpModeCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
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
        local function animateLoadingBar()
            local function loopLoadingBar()
                LoadingBar.Position = UDim2.new(0, 0, 0, 0)
                LoadingBar.Size = UDim2.new(0, 0, 1, 0)
                local tween1 = tweenService:Create(LoadingBar, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0, 1, 0)})
                local tween2 = tweenService:Create(LoadingBar, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 1, 0)})
                tween1.Completed:Connect(function()
                    tween2:Play()
                end)
                tween2.Completed:Connect(function()
                    LoadingBar.Position = UDim2.new(0, 0, 0, 0)
                    tween1:Play()
                end)
                tween1:Play()
            end
            loopLoadingBar()
        end

        animateLoadingBar()

        wait(5)

        LoadingFrame.Visible = false
        Frame.Visible = true
        InfoLabel.Visible = true
        AvatarImage.Visible = true
    else
        PasswordBox.Text = ""
        PasswordBox.PlaceholderText = "Incorrect Password or Username"
    end
end)

-- Show login frame with animation
local function showLoginFrame()
    LoginFrame.Visible = true
    local tween = tweenService:Create(LoginFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 200, 0, 100)})
    tween:Play()
end

showLoginFrame()

print("GUI Loaded: Use buttons to toggle SpeedHack, Noclip, and JumpMode")
