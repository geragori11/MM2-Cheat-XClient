local ESPMod = {
    Name = "MM2 ESP",
    Category = "MM2",
    Enabled = false,
    Settings = {
        {Name = "Names", Type = "Toggle", Value = true}
    }
}

local highlights = {}

local function createHighlight(plr, color)
    if highlights[plr] then highlights[plr]:Destroy() end
    local char = plr.Character
    if char then
        local hl = Instance.new("Highlight")
        hl.Parent = game.CoreGui
        hl.Adornee = char
        hl.FillColor = color
        hl.OutlineColor = Color3.new(1,1,1)
        hl.FillTransparency = 0.5
        highlights[plr] = hl
    end
end

function ESPMod:OnEnable()
    task.spawn(function()
        while self.Enabled do
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer and p.Character then
                    local backpack = p:FindFirstChild("Backpack")
                    local char = p.Character
                    
                    if backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife") then
                        createHighlight(p, Color3.new(1, 0, 0)) -- Убийца - Красный
                    elseif backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun") then
                        createHighlight(p, Color3.new(0, 0, 1)) -- Шериф - Синий
                    end
                end
            end
            task.wait(2)
        end
    end)
end

function ESPMod:OnDisable()
    for _, hl in pairs(highlights) do hl:Destroy() end
    highlights = {}
end

return ESPMod