local Util = {}
local Services = setmetatable({}, {
    __index = function(_, key)
        return game:GetService(key)
    end
})

Util.Services = Services
Util.LP = Services.Players.LocalPlayer

-- Вспомогательная функция для UI анимаций
function Util.Tween(obj, time, goal)
    local info = TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local t = Services.TweenService:Create(obj, info, goal)
    t:Play()
    return t
end

return Util