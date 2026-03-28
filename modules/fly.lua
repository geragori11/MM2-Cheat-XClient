local FlyMod = {
    Name = "Fly (Jump)",
    Category = "Movement",
    Enabled = false,
    -- ВОТ ТУТ ОПИСЫВАЕШЬ ВСЁ ЧТО ХОЧЕШЬ
    Settings = {
        {Name = "No Delay", Type = "Toggle", Value = true},
        {Name = "Power", Type = "Slider", Value = 50, Min = 10, Max = 200}
    }
}

local UserInputService = game:GetService("UserInputService")
local LP = game:GetService("Players").LocalPlayer
local connection

-- Функция для получения значения настройки по имени
function FlyMod:GetSetting(name)
    for _, s in pairs(self.Settings) do
        if s.Name == name then return s.Value end
    end
end

function FlyMod:OnEnable()
    connection = UserInputService.JumpRequest:Connect(function()
        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if hum then
            -- Используем настройки динамически
            if self:GetSetting("No Delay") then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            else
                hum.Jump = true
            end
            hum.JumpPower = self:GetSetting("Power")
        end
    end)
end

function FlyMod:OnDisable()
    if connection then connection:Disconnect() end
end

return FlyMod