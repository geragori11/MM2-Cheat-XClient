local FlyMod = {
    Name = "Fly",
    Category = "Movement",
    Enabled = false,
    Speed = 50
}

local LP = game.Players.LocalPlayer
local BV, BG

function FlyMod.OnEnable()
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    BV = Instance.new("BodyVelocity", char.HumanoidRootPart)
    BV.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    BV.Velocity = Vector3.new(0, 0, 0)
    
    BG = Instance.new("BodyGyro", char.HumanoidRootPart)
    BG.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    BG.P = 1e4
    
    -- Цикл полета
    task.spawn(function()
        while FlyMod.Enabled do
            local cam = workspace.CurrentCamera
            local moveDir = char.Humanoid.MoveDirection
            
            -- Управление через камеру
            BV.Velocity = cam.CFrame.LookVector * (char.Humanoid.MoveDirection.Magnitude > 0 and FlyMod.Speed or 0)
            BG.CFrame = cam.CFrame
            task.wait()
        end
    end)
end

function FlyMod.OnDisable()
    if BV then BV:Destroy() end
    if BG then BG:Destroy() end
end

return FlyMod