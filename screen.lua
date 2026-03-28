local Screen = {}
local Reg = shared.XClient.Reg

function Screen.Init()
    local old = game.CoreGui:FindFirstChild("XClient_UI")
    if old then old:Destroy() end

    local Gui = Instance.new("ScreenGui", game.CoreGui)
    Gui.Name = "XClient_UI"

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 600, 0, 40)
    Main.Position = UDim2.new(0.5, -300, 0.1, 0)
    Main.BackgroundTransparency = 1
    Main.Active = true
    Main.Draggable = true

    local Layout = Instance.new("UIListLayout", Main)
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.Padding = UDim.new(0, 15)

    for _, cat in pairs(Reg.Categories) do
        local CatFrame = Instance.new("Frame", Main)
        CatFrame.Size = UDim2.new(0, 130, 0, 35)
        CatFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        CatFrame.BackgroundTransparency = 0.4 -- ПРОЗРАЧНОСТЬ
        Instance.new("UICorner", CatFrame)

        local Title = Instance.new("TextLabel", CatFrame)
        Title.Size = UDim2.new(1, 0, 1, 0)
        Title.Text = cat:upper()
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.BackgroundTransparency = 1

        local ModList = Instance.new("Frame", CatFrame)
        ModList.Size = UDim2.new(1, 0, 0, 500)
        ModList.Position = UDim2.new(0, 0, 1, 5)
        ModList.BackgroundTransparency = 1
        local ModLayout = Instance.new("UIListLayout", ModList)
        ModLayout.Padding = UDim.new(0, 3)

        for _, mod in pairs(Reg.Modules) do
            if mod.Category == cat then
                local Btn = Instance.new("TextButton", ModList)
                Btn.Size = UDim2.new(1, 0, 0, 30)
                Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Btn.BackgroundTransparency = 0.3
                Btn.Text = mod.Name
                Btn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
                Instance.new("UICorner", Btn)

                -- ЛКМ
                Btn.MouseButton1Click:Connect(function()
                    local state = mod:Toggle()
                    Btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(30, 30, 30)
                end)

                -- ПКМ (Настройки теперь выпадают ВНИЗ)
                Btn.MouseButton2Click:Connect(function()
                    local setFrame = Btn:FindFirstChild("Settings")
                    if setFrame then
                        setFrame.Visible = not setFrame.Visible
                        Btn.Size = setFrame.Visible and UDim2.new(1, 0, 0, 100) or UDim2.new(1, 0, 0, 30)
                    elseif mod.Settings then
                        local SF = Instance.new("Frame", Btn)
                        SF.Name = "Settings"
                        SF.Size = UDim2.new(1, 0, 0, 70)
                        SF.Position = UDim2.new(0, 0, 0, 30)
                        SF.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        SF.BorderSizePixel = 0
                        
                        local SLayout = Instance.new("UIListLayout", SF)
                        for _, s in pairs(mod.Settings) do
                            local SBtn = Instance.new("TextButton", SF)
                            SBtn.Size = UDim2.new(1, 0, 0, 25)
                            SBtn.Text = s.Name .. ": " .. tostring(s.Value)
                            SBtn.BackgroundTransparency = 1
                            SBtn.TextColor3 = Color3.new(1,1,1)
                            
                            SBtn.MouseButton1Click:Connect(function()
                                if s.Type == "Toggle" then s.Value = not s.Value
                                elseif s.Type == "Slider" then s.Value = (s.Value >= s.Max and s.Min or s.Value + 10) end
                                SBtn.Text = s.Name .. ": " .. tostring(s.Value)
                            end)
                        end
                        Btn.Size = UDim2.new(1, 0, 0, 100)
                    end
                end)
            end
        end
    end
end

return Screen