local Reg = {
    Modules = {},
    Categories = {"Combat", "Visual", "Movement", "Misc"}
}

function Reg.RegisterModule(config)
    config.Enabled = false
    
    -- Исправленная функция переключения
    function config:Toggle()
        self.Enabled = not self.Enabled
        if self.Enabled then
            -- Если OnEnable это функция, вызываем её
            local s, e = pcall(self.OnEnable)
            if not s then warn("OnEnable Error: " .. tostring(e)) end
        else
            local s, e = pcall(self.OnDisable)
            if not s then warn("OnDisable Error: " .. tostring(e)) end
        end
        return self.Enabled
    end

    table.insert(Reg.Modules, config)
end

return Reg