local Reg = {
    Modules = {},
    Categories = {"Combat", "Visual", "Movement", "Misc"}
}

function Reg.RegisterModule(config)
    -- Структура модуля: {Name, Category, Description, OnEnable, OnDisable}
    config.Enabled = false
    
    function config:Toggle()
        self.Enabled = not self.Enabled
        if self.Enabled then
            self.OnEnable()
        else
            self.OnDisable()
        end
        return self.Enabled
    end

    table.insert(Reg.Modules, config)
    print("[Base] Зарегистрирован: " .. config.Name)
end

return Reg