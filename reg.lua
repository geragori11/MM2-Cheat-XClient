local Reg = {}

-- Список всех доступных категорий
Reg.Categories = {"Combat", "Visual", "Movement", "MM2", "Misc"}

-- Функция загрузки модуля с GitHub
local function loadMod(name)
    local owner = "geragori11"
    local repo = "MM2-Cheat-XClient"
    local cacheBuster = "?t=" .. os.time()
    local url = "https://raw.githubusercontent.com/"..owner.."/"..repo.."/main/modules/"..name..".lua"..cacheBuster
    
    local success, content = pcall(function() return game:HttpGet(url) end)
    if success then
        local func = loadstring(content)
        if func then return func() end
    end
    warn("Не удалось загрузить модуль: " .. name)
end

-- Регистрация модулей
Reg.Modules = {
    -- Вкладка MM2 (будет видна только в Murder Mystery 2)
    loadMod("esp_mm2"), 
    
    -- Другие твои модули
    loadMod("killaura"),
    -- fly мы удалили по твоему запросу
}

-- Метод переключения модуля (используется в screen.lua)
for _, mod in pairs(Reg.Modules) do
    if mod then
        function mod:Toggle()
            self.Enabled = not self.Enabled
            if self.Enabled then
                if self.OnEnable then self:OnEnable() end
            else
                if self.OnDisable then self:OnDisable() end
            end
            return self.Enabled
        end
    end
end

return Reg