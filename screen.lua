local Screen = {}
local Reg = shared.XClient.Reg

function Screen.Init()
    local old = game.CoreGui:FindFirstChild("XClient_UI")
    if old then old:Destroy() end

    local Gui = Instance.new("ScreenGui", game.CoreGui)
    Gui.Name = "XClient_UI"
    Gui.DisplayOrder = 999 -- Поверх всего

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 200, 0, 300)
    Main.Position = UDim2.new(0, 50, 0.5, -150) -- Слева по центру
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true 

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Title.Text = "X-CLIENT MM2"
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14

    local Scroll = Instance.new("ScrollingFrame", Main)
    Scroll.Size = UDim2.new(1, -10, 1, -40)
    Scroll.Position = UDim2.new(0, 5, 0, 35)
    Scroll.BackgroundTransparency = 1
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0) -- Авто-размер ниже
    Scroll.ScrollBarThickness = 2

    local Layout = Instance.new("UIListLayout", Scroll)
    Layout.Padding = UDim.new(0, 5)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Автоматическое изменение размера скролла
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
    end)

    for _, mod in pairs(Reg.Modules) do
        local Btn = Instance.new("TextButton", Scroll)
        Btn.Size = UDim2.new(1, 0, 0, 30)
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Btn.BorderSizePixel = 0
        Btn.Text = mod.Name
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Btn.AutoButtonColor = true

        Btn.MouseButton1Click:Connect(function()
            local state = mod:Toggle()
            Btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(50, 50, 50)
            print("[X-Client] " .. mod.Name .. " is now " .. tostring(state))
        end)
    end
end

return Screen