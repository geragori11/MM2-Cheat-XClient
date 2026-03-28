local Screen = {}
local Reg = shared.XClient.Reg

function Screen.CreateSetting(data, parent)
    local SettingBtn = Instance.new("TextButton", parent)
    SettingBtn.Size = UDim2.new(1, -10, 0, 25)
    SettingBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    SettingBtn.Font = Enum.Font.Gotham
    SettingBtn.TextSize = 12
    SettingBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", SettingBtn).CornerRadius = UDim.new(0, 4)

    local function update()
        if data.Type == "Toggle" then
            SettingBtn.Text = data.Name .. ": " .. (data.Value and "ON" or "OFF")
            SettingBtn.TextColor3 = data.Value and Color3.fromRGB(0, 255, 150) or Color3.new(1,1,1)
        elseif data.Type == "Slider" then
            SettingBtn.Text = data.Name .. ": " .. data.Value
        end
    end

    SettingBtn.MouseButton1Click:Connect(function()
        if data.Type == "Toggle" then data.Value = not data.Value
        elseif data.Type == "Slider" then
            data.Value = data.Value + 10
            if data.Value > data.Max then data.Value = data.Min end
        end
        update()
    end)
    update()
end

function Screen.Init()
    local old = game.CoreGui:FindFirstChild("XClient_UI")
    if old then old:Destroy() end

    local Gui = Instance.new("ScreenGui", game.CoreGui)
    Gui.Name = "XClient_UI"

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 650, 0, 20)
    Main.Position = UDim2.new(0.5, -325, 0.15, 0)
    Main.BackgroundTransparency = 1
    Main.Active = true
    Main.Draggable = true

    local Layout = Instance.new("UIListLayout", Main)
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.Padding = UDim.new(0, 10)

    for _, cat in pairs(Reg.Categories) do
        -- Общий контейнер для всей категории (Заднее меню)
        local FullCatFrame = Instance.new("Frame", Main)
        FullCatFrame.Size = UDim2.new(0, 140, 0, 300) 
        FullCatFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- Чернее
        FullCatFrame.BackgroundTransparency = 0.15 -- Меньше прозрачности
        Instance.new("UICorner", FullCatFrame)

        local Title = Instance.new("TextLabel", FullCatFrame)
        Title.Size = UDim2.new(1, 0, 0, 35)
        Title.Text = cat:upper()
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 14
        Title.BackgroundTransparency = 1

        local ModList = Instance.new("Frame", FullCatFrame)
        ModList.Size = UDim2.new(1, -10, 1, -45)
        ModList.Position = UDim2.new(0, 5, 0, 40)
        ModList.BackgroundTransparency = 1
        
        local MLayout = Instance.new("UIListLayout", ModList)
        MLayout.Padding = UDim.new(0, 4)

        for _, mod in pairs(Reg.Modules) do
            if mod.Category == cat then
                local Btn = Instance.new("TextButton", ModList)
                Btn.Size = UDim2.new(1, 0, 0, 30)
                Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Btn.BackgroundTransparency = 0.4 -- Кнопки прозрачнее фона
                Btn.Text = mod.Name
                Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                Btn.Font = Enum.Font.Gotham
                Instance.new("UICorner", Btn)

                -- ЛКМ: Вкл/Выкл
                Btn.MouseButton1Click:Connect(function()
                    local state = mod:Toggle()
                    Btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(30, 30, 30)
                    Btn.BackgroundTransparency = state and 0.2 or 0.4
                end)

                -- ПКМ: Настройки сбоку
                Btn.MouseButton2Click:Connect(function()
                    local sf = Btn:FindFirstChild("SettingsFrame")
                    if sf then 
                        sf.Visible = not sf.Visible 
                    elseif mod.Settings and #mod.Settings > 0 then
                        local SF = Instance.new("Frame", Btn)
                        SF.Name = "SettingsFrame"
                        SF.Size = UDim2.new(0, 130, 0, #mod.Settings * 35 + 10)
                        SF.Position = UDim2.new(1, 10, 0, 0)
                        SF.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                        SF.BackgroundTransparency = 0.1
                        SF.ZIndex = 20
                        Instance.new("UICorner", SF)
                        
                        local SLayout = Instance.new("UIListLayout", SF)
                        SLayout.Padding = UDim.new(0, 5)
                        SLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

                        for _, sData in pairs(mod.Settings) do
                            Screen.CreateSetting(sData, SF)
                        end
                    end
                end)
            end
        end
    end
end

return Screen