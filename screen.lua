local Screen = {}
local Reg = shared.XClient.Reg

function Screen.CreateSetting(mod, data, parent)
    local SettingBtn = Instance.new("TextButton", parent)
    SettingBtn.Size = UDim2.new(1, -10, 0, 25)
    SettingBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SettingBtn.Font = Enum.Font.Gotham
    SettingBtn.TextSize = 12
    SettingBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", SettingBtn)

    if data.Type == "Toggle" then
        SettingBtn.Text = data.Name .. ": " .. (data.Value and "ON" or "OFF")
        SettingBtn.MouseButton1Click:Connect(function()
            data.Value = not data.Value
            SettingBtn.Text = data.Name .. ": " .. (data.Value and "ON" or "OFF")
            SettingBtn.BackgroundColor3 = data.Value and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(60, 60, 60)
        end)
    elseif data.Type == "Slider" then
        SettingBtn.Text = data.Name .. ": " .. data.Value
        SettingBtn.MouseButton1Click:Connect(function()
            -- Упрощенный слайдер циклом для примера
            data.Value = data.Value + 5
            if data.Value > data.Max then data.Value = data.Min end
            SettingBtn.Text = data.Name .. ": " .. data.Value
        end)
    end
end

function Screen.Init()
    local old = game.CoreGui:FindFirstChild("XClient_UI")
    if old then old:Destroy() end

    local Gui = Instance.new("ScreenGui", game.CoreGui)
    Gui.Name = "XClient_UI"

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 600, 0, 20)
    Main.Position = UDim2.new(0.1, 0, 0.1, 0)
    Main.BackgroundTransparency = 1
    Main.Active = true
    Main.Draggable = true

    local Layout = Instance.new("UIListLayout", Main)
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.Padding = UDim.new(0, 10)

    for _, cat in pairs(Reg.Categories) do
        local CatFrame = Instance.new("Frame", Main)
        CatFrame.Size = UDim2.new(0, 130, 0, 30)
        CatFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", CatFrame)

        local Title = Instance.new("TextLabel", CatFrame)
        Title.Size = UDim2.new(1, 0, 1, 0)
        Title.Text = cat:upper()
        Title.TextColor3 = Color3.new(1,1,1)
        Title.Font = Enum.Font.GothamBold
        Title.BackgroundTransparency = 1

        local ModList = Instance.new("Frame", CatFrame)
        ModList.Size = UDim2.new(1, 0, 0, 0)
        ModList.Position = UDim2.new(0, 0, 1, 5)
        ModList.BackgroundTransparency = 1
        Instance.new("UIListLayout", ModList).Padding = UDim.new(0, 2)

        for _, mod in pairs(Reg.Modules) do
            if mod.Category == cat then
                local Btn = Instance.new("TextButton", ModList)
                Btn.Size = UDim2.new(1, 0, 0, 30)
                Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Btn.Text = mod.Name
                Btn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
                Instance.new("UICorner", Btn)

                -- ЛКМ: Вкл/Выкл
                Btn.MouseButton1Click:Connect(function()
                    local state = mod:Toggle()
                    Btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(45, 45, 45)
                end)

                -- ПКМ: Авто-настройки
                Btn.MouseButton2Click:Connect(function()
                    local sf = Btn:FindFirstChild("SettingsFrame")
                    if sf then sf.Visible = not sf.Visible 
                    elseif mod.Settings and #mod.Settings > 0 then
                        local SF = Instance.new("Frame", Btn)
                        SF.Name = "SettingsFrame"
                        SF.Size = UDim2.new(1, 0, 0, #mod.Settings * 30 + 10)
                        SF.Position = UDim2.new(1, 5, 0, 0)
                        SF.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        Instance.new("UICorner", SF)
                        local SLayout = Instance.new("UIListLayout", SF)
                        SLayout.Padding = UDim.new(0, 5)
                        SLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

                        for _, sData in pairs(mod.Settings) do
                            Screen.CreateSetting(mod, sData, SF)
                        end
                    end
                end)
            end
        end
    end
end

return Screen