local FlyMod = {
    Name = "Fly (V3)",
    Category = "Movement",
    Enabled = false,
    Settings = {
        {Name = "Speed", Type = "Slider", Value = 50, Min = 10, Max = 250}
    }
}

local lp = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local speed = 0

function FlyMod:GetSetting(name)
    for _, s in pairs(self.Settings) do
        if s.Name == name then return s.Value end
    end
    return 50
end

function FlyMod:OnEnable()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    local bg = Instance.new("BodyGyro", root)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = root.CFrame
    
    local bv = Instance.new("BodyVelocity", root)
    bv.velocity = Vector3.new(0, 0.1, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

    task.spawn(function()
        while self.Enabled do
            hum.PlatformStand = true
            local maxspeed = self:GetSetting("Speed")
            
            -- Управление
            ctrl.f = UIS:IsKeyDown(Enum.KeyCode.W) and 1 or 0
            ctrl.b = UIS:IsKeyDown(Enum.KeyCode.S) and -1 or 0
            ctrl.l = UIS:IsKeyDown(Enum.KeyCode.A) and -1 or 0
            ctrl.r = UIS:IsKeyDown(Enum.KeyCode.D) and 1 or 0

            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = math.min(speed + 0.5 + (speed/maxspeed), maxspeed)
            else
                speed = math.max(speed - 1, 0)
            end
            
            local cam = workspace.CurrentCamera.CFrame
            if speed > 0 then
                bv.velocity = ((cam.lookVector * (ctrl.f + ctrl.b)) + ((cam * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - cam.p)) * speed
            else
                bv.velocity = Vector3.new(0, 0.1, 0)
            end
            
            bg.cframe = cam * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / maxspeed), 0, 0)
            task.wait()
        end
        
        bg:Destroy()
        bv:Destroy()
        hum.PlatformStand = false
    end)
end

function FlyMod:OnDisable()
    -- Цикл завершится сам через проверку self.Enabled
end

return FlyMod