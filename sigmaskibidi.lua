local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()
local m = lib:Window("Scary Hide & Seek")
local t = lib:Window("Teleports")
local p = lib:Window("Auto Farm")
local players = game.Players
local plr = players.LocalPlayer
local characters = workspace:FindFirstChild("Characters")
local map = game.Workspace:FindFirstChild("Map")
getgenv().settings = {speedhack = false, props = false, players = false, crates = false, attack = false, noclip = false}
getgenv().play_settings = {props = false, seeker = false, taunt = false}
local function openCrate(name)
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("Crates.Buy", workspace:FindFirstChild("Crates")[name])    
end
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
m:Toggle("Props ESP", false, function (bool)
    getgenv().settings.props = bool
    if getgenv().settings.props then
        while getgenv().settings.props do
            if characters then
                for _, player in pairs(characters:GetChildren()) do
                    if player:GetAttribute("OriginalHipHeight") then
                        local mObject = player:FindFirstChild("MorphObject")
                        if mObject and not mObject:FindFirstChild("ESP_Props") then
                            local highlight = Instance.new("Highlight", mObject)
                            highlight.Name = "ESP_Props"
                            highlight.FillColor = Color3.new(0.35, 0.35, 1.000000)
                            highlight.FillTransparency = 0.6
                            highlight.OutlineColor = Color3.new(0.000000, 0.000000, 1.000000)
                        end
                    end
                end
            end
            wait(1)
        end
    else
        for _, e in pairs(characters:GetDescendants()) do
            if e:IsA("Highlight") and e.Name == "ESP_Props" then
                e:Destroy()
            end
        end
    end
end)
m:Toggle("Auto Attack", false, function (bool)
    getgenv().settings.attack = bool
    while getgenv().settings.attack do
        for _, p in pairs(players:GetPlayers()) do
            if p ~= plr then
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("Tool.Hit", p)
            end
        end
        wait()
    end
end)
local crate
m:Dropdown("Crates", {"Common", "Uncommon", "Rare", "Epic"}, function (name)
    if name == "Common" then
        crate = "BoxOne"
    elseif name == "Uncommon" then
        crate = "BoxTwo"
    elseif name == "Rare" then
        crate = "BoxThree"
    elseif name == "Epic" then
        crate = "BoxFour"
    end
end)
m:Button("Open Crate", function ()
    openCrate(crate)
end)
m:Toggle("Auto Open", false, function (bool)
    getgenv().settings.crates = bool
    while getgenv().settings.crates do
        openCrate(crate)
        wait(9)
    end
end)
m:Label("~ t.me/arceusxscripts", Color3.fromRGB(127, 143, 166))
m:Button("Destroy Gui", function ()
    for _, s in pairs(getgenv().settings) do
        getgenv().settings[s] = false
    end
    lib:Destroy()
end)
-- // Teleports
t:Button("Teleport to Lobby", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(113, 15, 359)
end)
t:Button("Teleport to Map", function()
    if map then
        for _, r in pairs(map:GetChildren()) do
            local spawn = r:FindFirstChild("SpawnToMap")
            if spawn then
                plr.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0,5,0)
            end
        end
    end
end)
local function getPlayer(name)
	local lowerName = string.lower(name)
	for _, p in pairs(players:GetPlayers()) do
		local lowerPlayer = string.lower(p.Name)
		if string.find(lowerPlayer, lowerName) then
			return p
		elseif string.find(string.lower(p.DisplayName), lowerName) then
			return p
		end
	end
end
local player = nil
t:Box("Player", function (name, focuslost)
    if focuslost then
        local player = getPlayer(name)
        if player then
            plr.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        end
    end
end)
-- // Auto Farm
p:Toggle("Auto Prop", false, function (bool)
    getgenv().play_settings.props = bool
    while getgenv().play_settings.props do
        if plr:GetAttribute("Hider") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(113, 15, 359)
        end
        wait(1)
    end
end)
p:Toggle("Auto Taunt", false, function (bool)
    getgenv().play_settings.taunt = bool
    while getgenv().play_settings.taunt do
        if plr:GetAttribute("Hider") then
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("Abilities.Fire", "Taunt")            
        end
        wait(10)
    end
end)
p:Toggle("Auto Seeker", false, function (bool)
    getgenv().play_settings.seeker = bool
    while getgenv().play_settings.seeker do
        pcall(function ()
            if plr:GetAttribute("MainSeeker") or plr:GetAttribute("Seeker") then
                for _, p in pairs(players:GetPlayers()) do
                    if p ~= plr then
                        if p:GetAttribute("Hider") then
                            repeat
                                if not getgenv().play_settings.seeker then
                                    break
                                end
                                plr.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("Tool.Hit", p)
                                wait(.1)
                            until p:GetAttribute("Hider") == false
                        end
                    end
                end
            end
        end)
        wait(1)
    end
end)
p:Button("Anti AFK", function()
    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
         v:Disable()
    end
 end)
