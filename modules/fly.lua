local FlyModule = {
    Name = "Fly",
    Category = "Movement",
    Enabled = false,
    Description = "Позволяет летать по карте"
}

function FlyModule:Toggle()
    self.Enabled = not self.Enabled
    if self.Enabled then
        self:OnEnable()
    else
        self:OnDisable()
    end
end

function FlyModule:OnEnable()
    print("Fly активирован")
    -- Логика полета здесь
end

function FlyModule:OnDisable()
    print("Fly деактивирован")
    -- Остановка полета
end

return FlyModule