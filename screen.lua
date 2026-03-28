local Screen = {}
local Util = shared.XClient.Util
local Reg = shared.XClient.Reg

function Screen.Init()
    local Gui = Instance.new("ScreenGui", game.CoreGui)
    Gui.Name = "XClient_UI"

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 550, 0, 400)
    Main.Position = UDim2.new(0.5, -275, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

    -- Контейнер для категорий
    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1, -20, 1, -60)
    Content.Position = UDim2.new(0, 10, 0, 50)
    Content.BackgroundTransparency = 1

    local Layout = Instance.new("UIListLayout", Content)
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.Padding = UDim.new(0, 10)

    -- Создаем колонки для каждой категории
    for _, catName in pairs(Reg.Categories) do
        local Column = Instance.new("ScrollingFrame", Content)
        Column.Size = UDim2.new(0, 125, 1, 0)
        Column.BackgroundTransparency = 1
        Column.CanvasSize = UDim2.new(0, 0, 2, 0)
        Column.ScrollBarThickness = 0
        
        local ColLayout = Instance.new("UIListLayout", Column)
        ColLayout.Padding = UDim.new(0, 5)

        local Title = Instance.new("TextLabel", Column)
        Title.Text = catName:upper()
        Title.Size = UDim2.new(1, 0, 0, 20)
        Title.TextColor3 = Color3.fromRGB(150, 150, 150)
        Title.Font = Enum.Font.GothamBold
        Title.BackgroundTransparency = 1

        -- Отрисовка модулей в этой категории
        for _, mod in pairs(Reg.Modules) do
            if mod.Category == catName then
                local Btn = Instance.new("TextButton", Column)
                Btn.Size = UDim2.new(1, 0, 0, 35)
                Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                Btn.Text = mod.Name
                Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                Instance.new("UICorner", Btn)

                Btn.MouseButton1Click:Connect(function()
                    local state = mod:Toggle()
                    Util.Tween(Btn, 0.3, {BackgroundColor3 = state and Color3.fromRGB(60, 180, 100) or Color3.fromRGB(35, 35, 35)})
                end)
            end
        end
    end
end

return Screen