local FlyMod = {
    Name = "Fly (V3)",
    Category = "Movement",
    Enabled = false,
    Settings = {{Name = "Speed", Type = "Slider", Value = 50, Min = 10, Max = 150}}
}

function FlyMod:OnEnable()
    local lp = game.Players.LocalPlayer
    spawn(function()
        while self.Enabled do
            local char = lp.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                root.Velocity = Vector3.new(0, 2, 0) -- Гравитация почти 0
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                    root.CFrame = root.CFrame * CFrame.new(0, 2, 0)
                end
            end
            task.wait()
        end
    end)
end

function FlyMod:OnDisable() end
return FlyMod