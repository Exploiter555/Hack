-- Function to create a rainbow color
local function rainbowColor()
    local frequency = 0.3
    local phase = 0
    local center = 128
    local width = 127
    local red = math.sin(frequency*1 + phase) * width + center
    local green = math.sin(frequency*2 + phase) * width + center
    local blue = math.sin(frequency*3 + phase) * width + center
    return Color3.fromRGB(red, green, blue)
end

-- Function to draw rainbow line
local function drawRainbowLine(startPos, endPos)
    local rainbowLine = Instance.new("Part")
    rainbowLine.Anchored = true
    rainbowLine.Size = Vector3.new(0.1, 0.1, (startPos - endPos).magnitude)
    rainbowLine.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -rainbowLine.Size.Z/2)
    rainbowLine.Color = rainbowColor()
    rainbowLine.Parent = workspace
    return rainbowLine
end

-- Function to track all players
local function trackPlayers()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local otherRootPart = otherPlayer.Character.HumanoidRootPart
                    drawRainbowLine(rootPart.Position, otherRootPart.Position)
                end
            end
        end
    end
end

-- Call trackPlayers function repeatedly
while true do
    trackPlayers()
    wait(0.028) -- Adjust the wait time as needed
end


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