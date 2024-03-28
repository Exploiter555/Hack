local function highlightPlayer(player)
    if player and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Color = Color3.new(1, 0, 0)
            end
        end

        -- Create a part beneath the player's character
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local part = Instance.new("Part")
            part.Name = "HighlightPart"
            part.Size = Vector3.new(4, 0.2, 4) -- Adjust size as needed
            part.Position = rootPart.Position - Vector3.new(0, 2, 0) -- Position it beneath the character
            part.Anchored = true
            part.CanCollide = false -- Disable collision
            part.Transparency = 0.5
            part.Parent = workspace
        end
    end
end

local function removeHighlight(player)
    if player and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Color = Color3.new(1, 1, 1)
            end
        end
    end
end

local function addNameTag(player)
    local tag = Instance.new("TextLabel")
    tag.Name = "NameTag"
    tag.Text = player.Name .. " | " .. tostring((player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) .. " Studs Distance"
    tag.Size = UDim2.new(0, 200, 0, 20)
    tag.BackgroundColor3 = Color3.new(1, 1, 1)
    tag.TextColor3 = Color3.new(0, 0, 0)
    tag.BorderSizePixel = 1
    tag.Parent = player.Character.Head
    tag.Position = UDim2.new(0, -tag.Size.X.Offset/2, 0, -30)
end

local function removeNameTag(player)
    local tag = player.Character:FindFirstChild("NameTag")
    if tag then
        tag:Destroy()
    end
end

local function makePlayerTransparent(player)
    if player and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 0.5
            end
        end
    end
end

local function removePlayerTransparency(player)
    if player and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end
end

local function highlightAllPlayers()
    for _, player in pairs(game.Players:GetPlayers()) do
        highlightPlayer(player)
        addNameTag(player)
    end
end

local function removeAllHighlights()
    for _, player in pairs(game.Players:GetPlayers()) do
        removeHighlight(player)
        removeNameTag(player)
    end
end

local function activateXRay()
    for _, player in pairs(game.Players:GetPlayers()) do
        makePlayerTransparent(player)
    end
end

local function deactivateXRay()
    for _, player in pairs(game.Players:GetPlayers()) do
        removePlayerTransparency(player)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    highlightPlayer(player)
    addNameTag(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    removeHighlight(player)
    removeNameTag(player)
end)

highlightAllPlayers()

activateXRay()