--[[
    SCRIPT FULL MENU - FPS GAME (ONE SHOT)
    - Menu bật tắt di chuyển (Speed, Jump, Fly, Inf Jump)
    - Aim Assist + FOV Circle kéo chỉnh
    - ESP (Nhìn xuyên tường)
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- ================= CẤU HÌNH =================
local Config = {
    -- Aim
    AimEnabled = false,
    FOVRadius = 150,
    Smoothness = 0.2,
    AimPart = "Head",
    TeamCheck = true,
    WallCheck = false,
    AutoShoot = false,
    
    -- Movement
    SpeedEnabled = false,
    SpeedValue = 50,
    JumpEnabled = false,
    JumpValue = 100,
    InfJump = false,
    FlyEnabled = false,
    FlySpeed = 100,
    
    -- Visual
    ESPEnabled = false
}

-- ================= TẠO UI MENU =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CheatMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Nút bật/tắt Menu
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.Text = "MENU"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)

-- Khung Menu chính
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(0, 255, 150)
Stroke.Thickness = 2

-- Tiêu đề Menu
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
Title.Text = "ONE SHOT CHEAT MENU"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 10)

-- Danh sách tính năng (ScrollingFrame)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.Parent = MainFrame
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 8)

-- Hàm tạo nút Toggle
local function CreateToggle(name, defaultState, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(50, 50, 50)
    Btn.Text = name .. ": " .. (defaultState and "ON" or "OFF")
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Btn.Parent = Scroll
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local state = defaultState
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(50, 50, 50)
        Btn.Text = name .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
    return Btn
end

-- Hàm tạo Slider (kéo chỉnh giá trị)
local function CreateSlider(name, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.Parent = Scroll
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 20)
    Label.Position = UDim2.new(0, 5, 0, 2)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. default
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.Parent = Frame

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, -20, 0, 8)
    Bar.Position = UDim2.new(0, 10, 0, 28)
    Bar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Bar.Parent = Frame
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    Fill.Parent = Bar
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local mouseX = input.Position.X
            local barPos = Bar.AbsolutePosition.X
            local barSize = Bar.AbsoluteSize.X
            local percent = math.clamp((mouseX - barPos) / barSize, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            Fill.Size = UDim2.new(percent, 0, 1, 0)
            Label.Text = name .. ": " .. value
            callback(value)
        end
    end)
end

-- ================= MENU ITEMS =================
-- Aim
CreateToggle("Aim Assist (FOV)", Config.AimEnabled, function(state) Config.AimEnabled = state end)
CreateToggle("Auto Shoot", Config.AutoShoot, function(state) Config.AutoShoot = state end)
CreateSlider("FOV Size", 50, 500, Config.FOVRadius, function(val) Config.FOVRadius = val end)
CreateSlider("Smoothness", 1, 30, 20, function(val) Config.Smoothness = val / 100 end)

-- Movement
CreateToggle("Speed Hack", Config.SpeedEnabled, function(state) Config.SpeedEnabled = state end)
CreateSlider("Speed Value", 16, 200, Config.SpeedValue, function(val) 
    Config.SpeedValue = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.SpeedEnabled and val or 16
    end
end)
CreateToggle("Jump Power", Config.JumpEnabled, function(state) Config.JumpEnabled = state end)
CreateSlider("Jump Value", 50, 300, Config.JumpValue, function(val)
    Config.JumpValue = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = Config.JumpEnabled and val or 50
        LocalPlayer.Character.Humanoid.UseJumpPower = true
    end
end)
CreateToggle("Infinite Jump", Config.InfJump, function(state) Config.InfJump = state end)
CreateToggle("Fly (Bay)", Config.FlyEnabled, function(state) Config.FlyEnabled = state end)
CreateSlider("Fly Speed", 50, 500, Config.FlySpeed, function(val) Config.FlySpeed = val end)

-- Visual
CreateToggle("ESP (Xuyên Tường)", Config.ESPEnabled, function(state) 
    Config.ESPEnabled = state
    if not state then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                local hl = plr.Character:FindFirstChild("CheatHighlight")
                if hl then hl:Destroy() end
            end
        end
    end
end)

-- Kéo thả Menu
local dragging, dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ================= FOV CIRCLE =================
local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "FOVCircle"
FOVCircle.BackgroundTransparency = 1
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Size = UDim2.new(0, Config.FOVRadius * 2, 0, Config.FOVRadius * 2)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.Parent = ScreenGui
FOVCircle.Visible = false
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)
local CircleStroke = Instance.new("UIStroke", FOVCircle)
CircleStroke.Color = Color3.fromRGB(0, 255, 150)
CircleStroke.Thickness = 2
CircleStroke.Transparency = 0.3

-- ================= MOVEMENT LOGIC =================
-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if Config.InfJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Fly Logic
local flyBV = nil
local flyBG = nil
local function startFly()
    if not LocalPlayer.Character then return end
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    flyBV.Velocity = Vector3.zero
    flyBV.Parent = hrp
    
    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    flyBG.P = 1000
    flyBG.D = 50
    flyBG.Parent = hrp
end

local function stopFly()
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
end

RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    if Config.AimEnabled then
        FOVCircle.Visible = true
        FOVCircle.Size = UDim2.new(0, Config.FOVRadius * 2, 0, Config.FOVRadius * 2)
        local mousePos = UserInputService:GetMouseLocation()
        FOVCircle.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)
    else
        FOVCircle.Visible = false
    end

    -- Update Movement
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            -- Speed
            if Config.SpeedEnabled then
                hum.WalkSpeed = Config.SpeedValue
            else
                hum.WalkSpeed = 16
            end
            
            -- Jump
            if Config.JumpEnabled then
                hum.UseJumpPower = true
                hum.JumpPower = Config.JumpValue
            else
                hum.JumpPower = 50
            end
        end
        
        -- Fly
        if Config.FlyEnabled and not flyBV then
            startFly()
        elseif not Config.FlyEnabled and flyBV then
            stopFly()
        end
        
        if Config.FlyEnabled and flyBV and flyBG then
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local moveDir = Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                
                flyBV.Velocity = moveDir * Config.FlySpeed
                flyBG.CFrame = Camera.CFrame
            end
        end
    end
end)

-- ================= AIM & ESP LOGIC =================
local function isTeammate(plr)
    if not Config.TeamCheck then return false end
    return plr.Team == LocalPlayer.Team
end

local function getTarget()
    local closest, shortest = nil, Config.FOVRadius
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        if isTeammate(plr) then continue end
        local char = plr.Character
        if not char then continue end
        local part = char:FindFirstChild(Config.AimPart) or char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not part or not hum or hum.Health <= 0 then continue end

        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        local mouseDist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        if mouseDist < shortest then
            shortest = mouseDist
            closest = part
        end
    end
    return closest
end

-- ESP Logic
RunService.Heartbeat:Connect(function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = plr.Character:FindFirstChild("CheatHighlight")
            if Config.ESPEnabled and not isTeammate(plr) then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "CheatHighlight"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.5
                    hl.Parent = plr.Character
                end
            else
                if hl then hl:Destroy() end
            end
        end
    end
end)

-- Aim Assist + Auto Shoot
RunService.RenderStepped:Connect(function()
    if not Config.AimEnabled then return end
    if not LocalPlayer.Character then return end
    
    local target = getTarget()
    if target then
        local camPos = Camera.CFrame.Position
        local targetPos = target.Position
        local direction = (targetPos - camPos).Unit
        local newCFrame = CFrame.new(camPos, camPos + direction)
        Camera.CFrame = Camera.CFrame:Lerp(newCFrame, Config.Smoothness)
        
        -- Auto Shoot
        if Config.AutoShoot then
            local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
    end
end)

print("[FULL MENU] Đã load thành công! Bấm nút MENU để bật/tắt")
