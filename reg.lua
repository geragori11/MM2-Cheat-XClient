local Reg = {
    Modules = {},
    Categories = {"Combat", "Visual", "Movement", "Misc"}
}

function Reg.RegisterModule(config)
    config.Enabled = false
    config.Settings = config.Settings or {} -- Сюда пишем слайдеры и тд
    
    function config:Toggle()
        self.Enabled = not self.Enabled
        local s, e = pcall(function()
            if self.Enabled then self:OnEnable() else self:OnDisable() end
        end)
        if not s then warn("Module Error: "..tostring(e)) end
        return self.Enabled
    end

    table.insert(Reg.Modules, config)
end

return Reg