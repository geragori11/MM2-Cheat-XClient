local FlyMod = {
    Name = "Fly (Jump)",
    Category = "Movement",
    Enabled = false,
    Settings = {
        {Name = "No Delay", Type = "Toggle", Value = true},
        {Name = "Power", Type = "Slider", Value = 50, Min = 10, Max = 150}
    }
}

local UserInputService = game:GetService("UserInputService")
local LP = game:GetService("Players").LocalPlayer

function FlyMod:GetSetting(name)
    for _, s in pairs(self.Settings) do
        if s.Name == name then return s.Value end
    end
    return nil
end

function FlyMod:OnEnable()
    print("Fly Enabled")
    self.JumpConnection = UserInputService.JumpRequest:Connect(function()
        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if hum and self.Enabled then
            hum.JumpPower = self:GetSetting("Power") or 50
            if self:GetSetting("No Delay") then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            else
                hum.Jump = true
            end
        end
    end)
end

function FlyMod:OnDisable()
    print("Fly Disabled")
    if self.JumpConnection then
        self.JumpConnection:Disconnect()
        self.JumpConnection = nil
    end
end

return FlyMod