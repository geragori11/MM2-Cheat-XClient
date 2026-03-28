local Reg = shared.XClient.Reg
local Screen = shared.XClient.Screen

-- Можно вынести Fly в отдельный файл на GitHub и грузить через fetch(), 
-- но для примера зарегистрируем прямо здесь:

Reg.RegisterModule({
    Name = "Fly",
    Category = "Movement",
    Description = "Полет",
    OnEnable = function() 
        print("Fly ON")
        -- Сюда код самого полета
    end,
    OnDisable = function() 
        print("Fly OFF")
    end
})



-- Запуск интерфейса
Screen.Init()
print("[X-Client] Полностью загружен.")