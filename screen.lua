local Screen = {}
local Util = shared.XClient.Util
local Reg = shared.XClient.Reg

function Screen.Init()
    -- Удаляем старое меню если есть
    local old = game.CoreGui:FindFirstChild("XClient_UI")
    if old then old:Destroy() end

    local Gui = Instance.new("ScreenGui", game.CoreGui)
    Gui.Name = "XClient_UI"

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.Active = true
    Main.Draggable = true -- Можно двигать мышкой
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1, -20, 1, -20)
    Content.Position = UDim2.new(0, 10, 0, 10)
    Content.BackgroundTransparency = 1

    local Layout = Instance.new("UIGridLayout", Content)
    Layout.CellSize = UDim2.new(0, 110, 0, 40)
    Layout.Padding = UDim2.new(0, 10, 0, 10)

    for _, mod in pairs(Reg.Modules) do
        local Btn = Instance.new("TextButton", Content)
        Btn.Size = UDim2.new(0, 110, 0, 40)
        Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Btn.Text = mod.Name
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.GothamSemibold
        Btn.TextSize = 14
        Instance.new("UICorner", Btn)

        -- Функция клика
        Btn.MouseButton1Click:Connect(function()
            local newState = mod:Toggle()
            if newState then
                Btn.BackgroundColor3 = Color3.fromRGB(60, 160, 80) -- Зеленый
            else
                Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Серый
            end
        end)
    end
end

return Screen