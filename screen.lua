local Screen = {}
local Reg = shared.XClient.Reg

function Screen.CreateSetting(data, parent)
    local SettingBtn = Instance.new("TextButton", parent)
    SettingBtn.Size = UDim2.new(1, -10, 0, 25)
    SettingBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SettingBtn.BackgroundTransparency = 0.2
    SettingBtn.Font = Enum.Font.Gotham
    SettingBtn.TextSize = 12
    SettingBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", SettingBtn)

    local function updateText()
        if data.Type == "Toggle" then
            SettingBtn.Text = data.Name .. ": " .. (data.Value and "ON" or "OFF")
            SettingBtn.TextColor3 = data.Value and Color3.fromRGB(0, 255, 150) or Color3.new(1,1,1)
        elseif data.Type == "Slider" then
            SettingBtn.Text = data.Name .. ": " .. data.Value
        end
    end

    SettingBtn.MouseButton1Click:Connect(function()
        if data.Type == "Toggle" then
            data.Value = not data.Value
        elseif data.Type == "Slider" then
            data.Value = data.Value + 5
            if data.Value > data.Max then data.Value = data.Min end
        end
        updateText()
    end)
    updateText()
end

function Screen.Init()
    local old = game.CoreGui:FindFirstChild("XClient_UI")
    if old then old:Destroy() end

    local Gui = Instance.new("ScreenGui", game.CoreGui)
    Gui.Name = "XClient_UI"
    Gui.DisplayOrder = 10

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 600, 0, 20)
    Main.Position = UDim2.new(0.5, -300, 0.2, 0)
    Main.BackgroundTransparency = 1
    Main.Active = true
    Main.Draggable = true

    local Layout = Instance.new("UIListLayout", Main)
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.Padding = UDim.new(0, 15)

    for _, cat in pairs(Reg.Categories) do
        local CatFrame = Instance.new("Frame", Main)
        CatFrame.Size = UDim2.new(0, 130, 0, 30)
        CatFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        CatFrame.BackgroundTransparency = 0.3 -- Полупрозрачность
        Instance.new("UICorner", CatFrame)

        local Title = Instance.new("TextLabel", CatFrame)
        Title.Size = UDim2.new(1, 0, 1, 0)
        Title.Text = cat:upper()
        Title.TextColor3 = Color3.new(1,1,1)
        Title.Font = Enum.Font.GothamBold
        Title.BackgroundTransparency = 1

        local ModList = Instance.new("Frame", CatFrame)
        ModList.Size = UDim2.new(1, 0, 0, 500)
        ModList.Position = UDim2.new(0, 0, 1, 5)
        ModList.BackgroundTransparency = 1
        Instance.new("UIListLayout", ModList).Padding = UDim.new(0, 3)

        for _, mod in pairs(Reg.Modules) do
            if mod.Category == cat then
                local Btn = Instance.new("TextButton", ModList)
                Btn.Size = UDim2.new(1, 0, 0, 30)
                Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                Btn.BackgroundTransparency = 0.3
                Btn.Text = mod.Name
                Btn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
                Instance.new("UICorner", Btn)

                Btn.MouseButton1Click:Connect(function()
                    local state = mod:Toggle()
                    Btn.TextColor3 = state and Color3.fromRGB(0, 255, 150) or Color3.new(0.9, 0.9, 0.9)
                end)

                -- ПКМ через InputBegan (более надежно для инжекторов)
                Btn.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton2 then
                        local sf = Btn:FindFirstChild("SettingsFrame")
                        if sf then 
                            sf.Visible = not sf.Visible 
                        elseif mod.Settings and #mod.Settings > 0 then
                            local SF = Instance.new("Frame", Btn)
                            SF.Name = "SettingsFrame"
                            SF.ZIndex = 5
                            SF.Size = UDim2.new(1.2, 0, 0, #mod.Settings * 30 + 10)
                            SF.Position = UDim2.new(1.1, 0, 0, 0)
                            SF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                            SF.BackgroundTransparency = 0.2
                            Instance.new("UICorner", SF)
                            local SLayout = Instance.new("UIListLayout", SF)
                            SLayout.Padding = UDim.new(0, 5)
                            SLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

                            for _, sData in pairs(mod.Settings) do
                                Screen.CreateSetting(sData, SF)
                            end
                        end
                    end
                end)
            end
        end
    end
end

return Screen