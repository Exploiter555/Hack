local function highlightPlayer(player)
    if player and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Color = Color3.new(1, 0, 0)
            end
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
    tag.Text = player.Name
    tag.Size = UDim2.new(0, 100, 0, 20)
    tag.BackgroundColor3 = Color3.new(1, 1, 1)
    tag.TextColor3 = Color3.new(0, 0, 0)
    tag.BorderSizePixel = 1
    tag.Parent = player.Character.Head
    tag.Position = UDim2.new(0, -tag.Size.X.Offset/2, 0, -30) -- Adjust the offset as needed
end

local function removeNameTag(player)
    local tag = player.Character:FindFirstChild("NameTag")
    if tag then
        tag:Destroy()
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

game.Players.PlayerAdded:Connect(function(player)
    highlightPlayer(player)
    addNameTag(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    removeHighlight(player)
    removeNameTag(player)
end)

highlightAllPlayers()