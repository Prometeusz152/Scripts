local players = game.Players
local plr = players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

getgenv().settings = {speedhack = false, noclip = false, jumpmode = false, phase = false, safeGlass = false}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local SpeedHackButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local JumpModeButton = Instance.new("TextButton")
local PhaseButton = Instance.new("TextButton") -- New phase button
local SafeGlassButton = Instance.new("TextButton") -- New safe glass button
local SpeedHackCheckbox = Instance.new("TextButton")
local NoclipCheckbox = Instance.new("TextButton")
local JumpModeCheckbox = Instance.new("TextButton")
local PhaseCheckbox = Instance.new("TextButton") -- New phase checkbox
local SafeGlassCheckbox = Instance.new("TextButton") -- New safe glass checkbox
local FirstGameButton = Instance.new("TextButton")
local FirstGameCheckbox = Instance.new("TextButton")
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
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0) -- Adjusted to fit all buttons
ScrollingFrame.ScrollBarThickness = 10
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ClipsDescendants = true -- Ensure buttons are clipped within the scrolling frame

-- Add background under buttons
ButtonsBackground.Parent = ScrollingFrame
ButtonsBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ButtonsBackground.Position = UDim2.new(0.05, 0, 0.05, 0)
ButtonsBackground.Size = UDim2.new(0.9, 0, 1.5, 0) -- Adjusted to fit all buttons
ButtonsBackground.BorderSizePixel = 0
addUICorner(ButtonsBackground, 10)

SpeedHackButton.Parent = ButtonsBackground
SpeedHackButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedHackButton.Position = UDim2.new(0.05, 0, 0.05, 0)
SpeedHackButton.Size = UDim2.new(0.9, 0, 0.05, 0) -- Adjusted size
SpeedHackButton.Text = "Toggle SpeedHack"
SpeedHackButton.BorderColor3 = Color3.fromRGB(111, 106, 155)
SpeedHackButton.BorderSizePixel = 2
addUICorner(SpeedHackButton, 10)

SpeedHackCheckbox.Parent = SpeedHackButton
SpeedHackCheckbox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
SpeedHackCheckbox.Position = UDim2.new(0.85, 0, 0.1, 0)
SpeedHackCheckbox.Size = UDim2.new(0.1, 0, 0.6, 0.8) -- Make it square
SpeedHackCheckbox.Text = ""
SpeedHackCheckbox.BorderColor3 = Color3.fromRGB(111, 106, 155)
SpeedHackCheckbox.BorderSizePixel = 2
addUICorner(SpeedHackCheckbox, 10)

local SpeedHackSlider = Instance.new("Frame")
SpeedHackSlider.Parent = ButtonsBackground
SpeedHackSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedHackSlider.Position = UDim2.new(0.05, 0, 0.11, 0) -- Adjusted position
SpeedHackSlider.Size = UDim2.new(0.9, 0, 0.03, 0) -- Adjusted size
SpeedHackSlider.BorderColor3 = Color3.fromRGB(200, 200, 200)
SpeedHackSlider.BorderSizePixel = 2
addUICorner(SpeedHackSlider, 10)

local SliderFill = Instance.new("Frame")
SliderFill.Parent = SpeedHackSlider
SliderFill.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
SliderFill.Size = UDim2.new(0, 0, 1, 0) -- Initial size
SliderFill.Position = UDim2.new(0, 0, 0, 0)
SliderFill.BorderColor3 = Color3.fromRGB(200, 200, 200)
SliderFill.BorderSizePixel = 2
addUICorner(SliderFill, 10)

local SliderButton = Instance.new("Frame")
SliderButton.Parent = SliderFill
SliderButton.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
SliderButton.Size = UDim2.new(0.1, 0, 1, 0) -- Initial size
SliderButton.Position = UDim2.new(1, -0.1, 0, 0)
SliderButton.BorderColor3 = Color3.fromRGB(200, 200, 200)
SliderButton.BorderSizePixel = 2
addUICorner(SliderButton, 10)

local SpeedText = Instance.new("TextLabel")
SpeedText.Parent = SpeedHackSlider
SpeedText.BackgroundTransparency = 1
SpeedText.Size = UDim2.new(1, 0, 1, 0)
SpeedText.Position = UDim2.new(0, 0, 0, 0)
SpeedText.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedText.TextSize = 14
SpeedText.Text = "Speed: 1.0"

local dragging = false
local speedMultiplier = 1

SliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

SliderButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

userInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local sliderPosition = math.clamp(input.Position.X - SpeedHackSlider.AbsolutePosition.X, 0, SpeedHackSlider.AbsoluteSize.X)
        SliderFill.Size = UDim2.new(sliderPosition / SpeedHackSlider.AbsoluteSize.X, 0, 1, 0)
        SliderButton.Position = UDim2.new(sliderPosition / SpeedHackSlider.AbsoluteSize.X, -SliderButton.Size.X.Offset / 2, 0, 0)
        speedMultiplier = 1 + (sliderPosition / SpeedHackSlider.AbsoluteSize.X)
        SpeedText.Text = string.format("Speed: %.1f", speedMultiplier)
    end
end)

NoclipButton.Parent = ButtonsBackground
NoclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
NoclipButton.Position = UDim2.new(0.05, 0, 0.15, 0) -- Adjusted position
NoclipButton.Size = UDim2.new(0.9, 0, 0.05, 0) -- Adjusted size
NoclipButton.Text = "Toggle Noclip"
NoclipButton.BorderColor3 = Color3.fromRGB(111, 106, 155)
NoclipButton.BorderSizePixel = 2
addUICorner(NoclipButton, 10)

NoclipCheckbox.Parent = NoclipButton
NoclipCheckbox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
NoclipCheckbox.Position = UDim2.new(0.85, 0, 0.1, 0)
NoclipCheckbox.Size = UDim2.new(0.1, 0, 0.6, 0.8) -- Make it square
NoclipCheckbox.Text = ""
NoclipCheckbox.BorderColor3 = Color3.fromRGB(111, 106, 155)
NoclipCheckbox.BorderSizePixel = 2
addUICorner(NoclipCheckbox, 10)

JumpModeButton.Parent = ButtonsBackground
JumpModeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
JumpModeButton.Position = UDim2.new(0.05, 0, 0.25, 0) -- Adjusted position
JumpModeButton.Size = UDim2.new(0.9, 0, 0.05, 0) -- Adjusted size
JumpModeButton.Text = "Toggle JumpMode"
JumpModeButton.BorderColor3 = Color3.fromRGB(111, 106, 155)
JumpModeButton.BorderSizePixel = 2
addUICorner(JumpModeButton, 10)

JumpModeCheckbox.Parent = JumpModeButton
JumpModeCheckbox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
JumpModeCheckbox.Position = UDim2.new(0.85, 0, 0.1, 0)
JumpModeCheckbox.Size = UDim2.new(0.1, 0, 0.6, 0.8) -- Make it square
JumpModeCheckbox.Text = ""
JumpModeCheckbox.BorderColor3 = Color3.fromRGB(111, 106, 155)
JumpModeCheckbox.BorderSizePixel = 2
addUICorner(JumpModeCheckbox, 10)

PhaseButton.Parent = ButtonsBackground
PhaseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PhaseButton.Position = UDim2.new(0.05, 0, 0.35, 0) -- Adjusted position
PhaseButton.Size = UDim2.new(0.9, 0, 0.05, 0) -- Adjusted size
PhaseButton.Text = "Toggle Phase"
PhaseButton.BorderColor3 = Color3.fromRGB(111, 106, 155)
PhaseButton.BorderSizePixel = 2
addUICorner(PhaseButton, 10)

PhaseCheckbox.Parent = PhaseButton
PhaseCheckbox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
PhaseCheckbox.Position = UDim2.new(0.85, 0, 0.1, 0)
PhaseCheckbox.Size = UDim2.new(0.1, 0, 0.6, 0.8) -- Make it square
PhaseCheckbox.Text = ""
PhaseCheckbox.BorderColor3 = Color3.fromRGB(111, 106, 155)
PhaseCheckbox.BorderSizePixel = 2
addUICorner(PhaseCheckbox, 10)

SafeGlassButton.Parent = ButtonsBackground
SafeGlassButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SafeGlassButton.Position = UDim2.new(0.05, 0, 0.45, 0) -- Adjusted position
SafeGlassButton.Size = UDim2.new(0.9, 0, 0.05, 0) -- Adjusted size
SafeGlassButton.Text = "Toggle Safe Glass"
SafeGlassButton.BorderColor3 = Color3.fromRGB(111, 106, 155)
SafeGlassButton.BorderSizePixel = 2
addUICorner(SafeGlassButton, 10)

SafeGlassCheckbox.Parent = SafeGlassButton
SafeGlassCheckbox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
SafeGlassCheckbox.Position = UDim2.new(0.85, 0, 0.1, 0)
SafeGlassCheckbox.Size = UDim2.new(0.1, 0, 0.6, 0.8) -- Make it square
SafeGlassCheckbox.Text = ""
SafeGlassCheckbox.BorderColor3 = Color3.fromRGB(111, 106, 155)
SafeGlassCheckbox.BorderSizePixel = 2
addUICorner(SafeGlassCheckbox, 10)

FirstGameButton.Parent = ButtonsBackground
FirstGameButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FirstGameButton.Position = UDim2.new(0.05, 0, 0.55, 0) -- Adjusted position
FirstGameButton.Size = UDim2.new(0.9, 0, 0.05, 0) -- Adjusted size
FirstGameButton.Text = "Toggle First Game"
FirstGameButton.BorderColor3 = Color3.fromRGB(111, 106, 155)
FirstGameButton.BorderSizePixel = 2
addUICorner(FirstGameButton, 10)

FirstGameCheckbox.Parent = FirstGameButton
FirstGameCheckbox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
FirstGameCheckbox.Position = UDim2.new(0.85, 0, 0.1, 0)
FirstGameCheckbox.Size = UDim2.new(0.1, 0, 0.6, 0.8) -- Make it square
FirstGameCheckbox.Text = ""
FirstGameCheckbox.BorderColor3 = Color3.fromRGB(111, 106, 155)
FirstGameCheckbox.BorderSizePixel = 2
addUICorner(FirstGameCheckbox, 10)

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

ToggleButton.Parent = InfoLabel
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleButton.Position = UDim2.new(1, -40, 0, 10) -- Position at the top right corner
ToggleButton.Size = UDim2.new(0, 30, 0, 30)
ToggleButton.Text = "▲" -- Arrow icon
addUICorner(ToggleButton, 5)

local function toggleMenu()
    isMenuVisible = not isMenuVisible
    local targetPosition = isMenuVisible and UDim2.new(0.05, 0, 0.05, 0) or UDim2.new(0.05, 0, -0.5, 0)
    local targetOuterSize = isMenuVisible and UDim2.new(1, 0, 1, 0) or UDim2.new(1, 0, 0, 0)
    local targetScrollSize = isMenuVisible and UDim2.new(1, 0, 1, 0) or UDim2.new(1, 0, 0, 0)
    local tweenBackground = tweenService:Create(ButtonsBackground, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPosition})
    local tweenOuterBackground = tweenService:Create(OuterBackground, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetOuterSize})
    local tweenScroll = tweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetScrollSize})
    tweenBackground:Play()
    tweenOuterBackground:Play()
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
                    plr.Character:TranslateBy(plr.Character.Humanoid.MoveDirection * speedMultiplier * delta * 10)
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
local inputBeganConnection
local inputEndedConnection
local moveDirection = Vector3.new(0, 0, 0)
local activeKeys = {}

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
            bodyVelocity.Velocity = moveDirection * 50
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        end)

        inputBeganConnection = userInputService.InputBegan:Connect(function(input)
            activeKeys[input.KeyCode] = true
            updateMoveDirection()
        end)

        inputEndedConnection = userInputService.InputEnded:Connect(function(input)
            activeKeys[input.KeyCode] = false
            updateMoveDirection()
        end)

        function updateMoveDirection()
            moveDirection = Vector3.new(0, 0, 0)
            if activeKeys[Enum.KeyCode.W] then
                moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
            end
            if activeKeys[Enum.KeyCode.S] then
                moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
            end
            if activeKeys[Enum.KeyCode.Space] then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if activeKeys[Enum.KeyCode.LeftShift] then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
        end
    else
        NoclipCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if inputBeganConnection then
            inputBeganConnection:Disconnect()
            inputBeganConnection = nil
        end
        if inputEndedConnection then
            inputEndedConnection:Disconnect()
            inputEndedConnection = nil
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
local function togglePhase()
    getgenv().settings.phase = not getgenv().settings.phase
    PhaseCheckbox.BackgroundColor3 = getgenv().settings.phase and Color3.fromRGB(111, 106, 155) or Color3.fromRGB(80, 80, 80)
    
    if getgenv().settings.phase then
        local function onStepped()
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                for _, part in pairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
        phaseConnection = runService.Stepped:Connect(onStepped)
    else
        if phaseConnection then
            phaseConnection:Disconnect()
            phaseConnection = nil
        end
        if plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end
local safeGlassConnection
local monitoredParts = {}

local function isGlassPart(part)
    return part:IsA("Part") and (part.Material == Enum.Material.Glass or part.Name:lower():find("glass") or part.Transparency > 0.5)
end

local function markSafeGlass()
    for _, part in pairs(workspace:GetDescendants()) do
        if isGlassPart(part) then
            if part.Transparency == 0 then
                part.Color = Color3.fromRGB(0, 255, 0) -- Zielone dla bezpiecznego szkła
                monitoredParts[part] = true
            else
                monitoredParts[part] = false
            end
        end
    end
end

local function restoreGlass()
    for part, isSafe in pairs(monitoredParts) do
        if isSafe then
            part.Color = Color3.fromRGB(255, 255, 255) -- Przywraca oryginalny kolor
        end
    end
    monitoredParts = {}
end

local function toggleSafeGlass()
    getgenv().settings.safeGlass = not getgenv().settings.safeGlass
    if getgenv().settings.safeGlass then
        SafeGlassCheckbox.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
        markSafeGlass()
        safeGlassConnection = workspace.DescendantAdded:Connect(function(descendant)
            if isGlassPart(descendant) then
                if descendant.Transparency == 0 then
                    descendant.Color = Color3.fromRGB(0, 255, 0) -- Zielone dla bezpiecznego szkła
                    monitoredParts[descendant] = true
                else
                    monitoredParts[descendant] = false
                end
            end
        end)
    else
        SafeGlassCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        if safeGlassConnection then
            safeGlassConnection:Disconnect()
            safeGlassConnection = nil
        end
        restoreGlass()
    end
end

local firstGameConnection

local function toggleFirstGame()
    getgenv().settings.firstGame = not getgenv().settings.firstGame
    if getgenv().settings.firstGame then
        FirstGameCheckbox.BackgroundColor3 = Color3.fromRGB(111, 106, 155)
        firstGameConnection = runService.RenderStepped:Connect(function()
            for _, textLabel in pairs(game:GetService("CoreGui"):GetDescendants()) do
                if textLabel:IsA("TextLabel") then
                    local text = textLabel.Text:lower()
                    if text:find("green light") then -- Zielony napis
                        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                            plr.Character.Humanoid:Move(Vector3.new(0, 0, -1), true) -- Idź do przodu
                        end
                    elseif text:find("red light") then -- Czerwony napis
                        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                            plr.Character.Humanoid:Move(Vector3.new(0, 0, 0), true) -- Zatrzymaj się
                        end
                    end
                end
            end
        end)
    else
        FirstGameCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        if firstGameConnection then
            firstGameConnection:Disconnect()
            firstGameConnection = nil
        end
    end
end

FirstGameCheckbox.MouseButton1Click:Connect(toggleFirstGame)
SafeGlassCheckbox.MouseButton1Click:Connect(toggleSafeGlass)
PhaseCheckbox.MouseButton1Click:Connect(togglePhase)
SpeedHackCheckbox.MouseButton1Click:Connect(toggleSpeedHack)
NoclipCheckbox.MouseButton1Click:Connect(toggleNoclip)
JumpModeCheckbox.MouseButton1Click:Connect(toggleJumpMode)

-- Login functionality
LoginButton.MouseButton1Click:Connect(function()
    if PasswordBox.Text == "sigma" and plr.Name == "Pandusia687" then
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
