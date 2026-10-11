--[[ ONE SHOT CHEAT V6 - PREMIUM UI ]]
-- PHẦN 1/4: Services + Theme + Config + UI Framework

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local WS = game:GetService("Workspace")
local RS = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")
local TS = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Cam = WS.CurrentCamera

-- THEME
local Theme = {
    Bg = Color3.fromRGB(15,15,20), Bg2 = Color3.fromRGB(22,22,30), Bg3 = Color3.fromRGB(30,30,40),
    Stroke = Color3.fromRGB(45,45,60), Text = Color3.fromRGB(240,240,245), TextDim = Color3.fromRGB(150,150,165),
    Accent = Color3.fromRGB(0,220,140), Accent2 = Color3.fromRGB(0,180,255), Danger = Color3.fromRGB(255,70,90),
    Font = Enum.Font.GothamMedium, FontBold = Enum.Font.GothamBold,
}

-- CONFIG
local C = {
    Aim=false,SilentAim=false,AutoShoot=false,MagicBullet=false,
    FOV=150,Smooth=35,Prediction=false,TargetLock=false,AimPart="Head",TeamCheck=true,
    ESP=false,ESPBox=false,ESPHealth=false,ESPName=false,ESPDistance=false,ESPTracer=false,ESPChams=false,
    Speed=false,SpeedVal=50,InfJump=false,Bhop=false,Fly=false,FlySpeed=100,Noclip=false,AntiAFK=true,
}

-- SCREENGUI
local SG = Instance.new("ScreenGui")
SG.Name="OSCheatV6"; SG.ResetOnSpawn=false; SG.IgnoreGuiInset=true
SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; SG.DisplayOrder=999
SG.Parent=game:GetService("CoreGui")

-- WATERMARK
local WM = Instance.new("Frame")
WM.Size=UDim2.new(0,240,0,30); WM.Position=UDim2.new(0.5,-120,0,10)
WM.BackgroundColor3=Theme.Bg; WM.BackgroundTransparency=0.1; WM.Parent=SG
Instance.new("UICorner",WM).CornerRadius=UDim.new(0,8)
local WMStroke=Instance.new("UIStroke",WM)
WMStroke.Color=Theme.Accent; WMStroke.Thickness=1; WMStroke.Transparency=0.5
local WMText=Instance.new("TextLabel")
WMText.Size=UDim2.new(1,0,1,0); WMText.BackgroundTransparency=1
WMText.Text="⚡ ONE SHOT  •  v6 Premium"; WMText.TextColor3=Theme.Text
WMText.Font=Theme.FontBold; WMText.TextSize=12; WMText.Parent=WM

-- NOTIFICATION
local NotifHolder=Instance.new("Frame")
NotifHolder.Size=UDim2.new(0,280,1,-40); NotifHolder.Position=UDim2.new(1,-300,0,20)
NotifHolder.BackgroundTransparency=1; NotifHolder.Parent=SG
local NL=Instance.new("UIListLayout",NotifHolder)
NL.SortOrder=Enum.SortOrder.LayoutOrder; NL.VerticalAlignment=Enum.VerticalAlignment.Top
NL.Padding=UDim.new(0,8)

local function Notify(title,desc,duration)
    duration=duration or 3
    local n=Instance.new("Frame")
    n.Size=UDim2.new(1,0,0,55); n.BackgroundColor3=Theme.Bg2
    n.BackgroundTransparency=0.05; n.Position=UDim2.new(1,50,0,0); n.Parent=NotifHolder
    Instance.new("UICorner",n).CornerRadius=UDim.new(0,10)
    local st=Instance.new("UIStroke",n); st.Color=Theme.Accent; st.Thickness=1; st.Transparency=0.6
    local bar=Instance.new("Frame")
    bar.Size=UDim2.new(0,3,1,-16); bar.Position=UDim2.new(0,8,0,8)
    bar.BackgroundColor3=Theme.Accent; bar.Parent=n
    Instance.new("UICorner",bar).CornerRadius=UDim.new(1,0)
    local t1=Instance.new("TextLabel")
    t1.Size=UDim2.new(1,-30,0,22); t1.Position=UDim2.new(0,18,0,6)
    t1.BackgroundTransparency=1; t1.Text=title; t1.TextColor3=Theme.Text
    t1.Font=Theme.FontBold; t1.TextSize=13; t1.TextXAlignment=Enum.TextXAlignment.Left; t1.Parent=n
    local t2=Instance.new("TextLabel")
    t2.Size=UDim2.new(1,-30,0,18); t2.Position=UDim2.new(0,18,0,26)
    t2.BackgroundTransparency=1; t2.Text=desc or ""; t2.TextColor3=Theme.TextDim
    t2.Font=Theme.Font; t2.TextSize=11; t2.TextXAlignment=Enum.TextXAlignment.Left; t2.Parent=n
    TS:Create(n,TweenInfo.new(0.35,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play()
    task.delay(duration,function()
        TS:Create(n,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(1,50,0,0),BackgroundTransparency=1}):Play()
        TS:Create(t1,TweenInfo.new(0.3),{TextTransparency=1}):Play()
        TS:Create(t2,TweenInfo.new(0.3),{TextTransparency=1}):Play()
        task.wait(0.35); n:Destroy()
    end)
end
-- PHẦN 2/4: Main Window + Sidebar + Topbar

-- MAIN WINDOW
local Main=Instance.new("Frame")
Main.Size=UDim2.new(0,540,0,380); Main.Position=UDim2.new(0.5,-270,0.5,-190)
Main.BackgroundColor3=Theme.Bg; Main.Parent=SG; Main.ClipsDescendants=true
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,14)
local MainStroke=Instance.new("UIStroke",Main)
MainStroke.Color=Theme.Stroke; MainStroke.Thickness=1

local TopGlow=Instance.new("Frame")
TopGlow.Size=UDim2.new(1,0,0,2); TopGlow.BackgroundColor3=Theme.Accent
TopGlow.BorderSizePixel=0; TopGlow.Parent=Main
local TGrad=Instance.new("UIGradient")
TGrad.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0,Theme.Accent),
    ColorSequenceKeypoint.new(0.5,Theme.Accent2),
    ColorSequenceKeypoint.new(1,Theme.Accent),
})

-- SIDEBAR
local Sidebar=Instance.new("Frame")
Sidebar.Size=UDim2.new(0,150,1,0); Sidebar.BackgroundColor3=Theme.Bg2
Sidebar.BorderSizePixel=0; Sidebar.Parent=Main
local SidebarLine=Instance.new("Frame")
SidebarLine.Size=UDim2.new(0,1,1,0); SidebarLine.Position=UDim2.new(1,-1,0,0)
SidebarLine.BackgroundColor3=Theme.Stroke; SidebarLine.BorderSizePixel=0; SidebarLine.Parent=Sidebar

-- LOGO
local LogoFrame=Instance.new("Frame")
LogoFrame.Size=UDim2.new(1,0,0,70); LogoFrame.BackgroundTransparency=1; LogoFrame.Parent=Sidebar
local LogoIcon=Instance.new("TextLabel")
LogoIcon.Size=UDim2.new(0,32,0,32); LogoIcon.Position=UDim2.new(0,16,0,18)
LogoIcon.BackgroundColor3=Theme.Accent; LogoIcon.Text="⚡"; LogoIcon.TextColor3=Theme.Bg
LogoIcon.Font=Theme.FontBold; LogoIcon.TextSize=18; LogoIcon.Parent=LogoFrame
Instance.new("UICorner",LogoIcon).CornerRadius=UDim.new(0,8)
local LogoText=Instance.new("TextLabel")
LogoText.Size=UDim2.new(1,-60,0,20); LogoText.Position=UDim2.new(0,56,0,18)
LogoText.BackgroundTransparency=1; LogoText.Text="ONE SHOT"; LogoText.TextColor3=Theme.Text
LogoText.Font=Theme.FontBold; LogoText.TextSize=13; LogoText.TextXAlignment=Enum.TextXAlignment.Left
LogoText.Parent=LogoFrame
local LogoSub=Instance.new("TextLabel")
LogoSub.Size=UDim2.new(1,-60,0,16); LogoSub.Position=UDim2.new(0,56,0,34)
LogoSub.BackgroundTransparency=1; LogoSub.Text="Premium v6"; LogoSub.TextColor3=Theme.Accent
LogoSub.Font=Theme.Font; LogoSub.TextSize=10; LogoSub.TextXAlignment=Enum.TextXAlignment.Left
LogoSub.Parent=LogoFrame

-- TAB LIST
local TabList=Instance.new("Frame")
TabList.Size=UDim2.new(1,0,1,-110); TabList.Position=UDim2.new(0,0,0,75)
TabList.BackgroundTransparency=1; TabList.Parent=Sidebar
Instance.new("UIListLayout",TabList).Padding=UDim.new(0,3)

-- TOPBAR
local Topbar=Instance.new("Frame")
Topbar.Size=UDim2.new(1,0,0,40); Topbar.BackgroundColor3=Theme.Bg2
Topbar.BackgroundTransparency=0.3; Topbar.Parent=Main
local PageTitle=Instance.new("TextLabel")
PageTitle.Size=UDim2.new(0,200,1,0); PageTitle.Position=UDim2.new(0,165,0,0)
PageTitle.BackgroundTransparency=1; PageTitle.Text="Aim Assist"; PageTitle.TextColor3=Theme.Text
PageTitle.Font=Theme.FontBold; PageTitle.TextSize=14; PageTitle.TextXAlignment=Enum.TextXAlignment.Left
PageTitle.Parent=Topbar

local function makeCircle(px,color,symbol)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0,14,0,14); b.Position=UDim2.new(1,px,0,13)
    b.BackgroundColor3=color; b.Text=symbol or ""; b.TextColor3=Theme.Bg
    b.Font=Theme.FontBold; b.TextSize=10; b.Parent=Topbar
    Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
    return b
end
local BtnClose=makeCircle(-25,Theme.Danger,"×")
local BtnMin=makeCircle(-45,Color3.fromRGB(255,180,60),"−")
-- PHẦN 3/4: Tab System + Toggle + Slider + Section + Pages

local pages={}

local function CreatePage(name)
    local page=Instance.new("ScrollingFrame")
    page.Size=UDim2.new(1,-20,1,-50); page.Position=UDim2.new(0,160,0,50)
    page.BackgroundTransparency=1; page.ScrollBarThickness=3
    page.ScrollBarImageColor3=Theme.Accent; page.CanvasSize=UDim2.new(0,0,0,0)
    page.Visible=false; page.Parent=Main
    local layout=Instance.new("UIListLayout",page)
    layout.Padding=UDim.new(0,8); layout.SortOrder=Enum.SortOrder.LayoutOrder
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
    end)
    pages[name]=page
    return page
end

local function CreateTab(name,icon,pageName)
    local tab=Instance.new("TextButton")
    tab.Size=UDim2.new(1,-16,0,34); tab.Position=UDim2.new(0,8,0,0)
    tab.BackgroundColor3=Theme.Bg2; tab.BackgroundTransparency=1
    tab.Text=""; tab.AutoButtonColor=false; tab.Parent=TabList
    Instance.new("UICorner",tab).CornerRadius=UDim.new(0,8)
    local ind=Instance.new("Frame")
    ind.Size=UDim2.new(0,3,0,0); ind.Position=UDim2.new(0,0,0.5,0)
    ind.AnchorPoint=Vector2.new(0,0.5); ind.BackgroundColor3=Theme.Accent; ind.Parent=tab
    Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
    local ic=Instance.new("TextLabel")
    ic.Size=UDim2.new(0,20,1,0); ic.Position=UDim2.new(0,12,0,0)
    ic.BackgroundTransparency=1; ic.Text=icon; ic.TextColor3=Theme.TextDim
    ic.Font=Theme.Font; ic.TextSize=14; ic.Parent=tab
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-36,1,0); lbl.Position=UDim2.new(0,36,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=name; lbl.TextColor3=Theme.TextDim
    lbl.Font=Theme.Font; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=tab
    tab.MouseEnter:Connect(function()
        if pages[pageName].Visible then return end
        TS:Create(tab,TweenInfo.new(0.2),{BackgroundTransparency=0.5}):Play()
        TS:Create(lbl,TweenInfo.new(0.2),{TextColor3=Theme.Text}):Play()
        TS:Create(ic,TweenInfo.new(0.2),{TextColor3=Theme.Text}):Play()
    end)
    tab.MouseLeave:Connect(function()
        if pages[pageName].Visible then return end
        TS:Create(tab,TweenInfo.new(0.2),{BackgroundTransparency=1}):Play()
        TS:Create(lbl,TweenInfo.new(0.2),{TextColor3=Theme.TextDim}):Play()
        TS:Create(ic,TweenInfo.new(0.2),{TextColor3=Theme.TextDim}):Play()
    end)
    tab.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible=false end
        pages[pageName].Visible=true; PageTitle.Text=name
        for _,t in ipairs(TabList:GetChildren()) do
            if t:IsA("TextButton") then
                local indicator=t:FindFirstChild("Frame")
                local lbls={}
                for _,c in ipairs(t:GetChildren()) do
                    if c:IsA("TextLabel") then table.insert(lbls,c) end
                end
                if t==tab then
                    TS:Create(t,TweenInfo.new(0.25),{BackgroundTransparency=0.3}):Play()
                    for _,l2 in ipairs(lbls) do TS:Create(l2,TweenInfo.new(0.2),{TextColor3=Theme.Text}):Play() end
                    if indicator then TS:Create(indicator,TweenInfo.new(0.25),{Size=UDim2.new(0,3,0,20)}):Play() end
                else
                    TS:Create(t,TweenInfo.new(0.25),{BackgroundTransparency=1}):Play()
                    for _,l2 in ipairs(lbls) do TS:Create(l2,TweenInfo.new(0.2),{TextColor3=Theme.TextDim}):Play() end
                    if indicator then TS:Create(indicator,TweenInfo.new(0.25),{Size=UDim2.new(0,3,0,0)}):Play() end
                end
            end
        end
    end)
    return tab
end

local function CreateSection(parent,text)
    local s=Instance.new("TextLabel")
    s.Size=UDim2.new(1,-5,0,26); s.BackgroundTransparency=1
    s.Text="  "..string.upper(text); s.TextColor3=Theme.TextDim
    s.Font=Theme.FontBold; s.TextSize=10; s.TextXAlignment=Enum.TextXAlignment.Left
    s.Parent=parent
end

local function CreateToggle(parent,name,default,callback)
    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,-5,0,42); row.BackgroundColor3=Theme.Bg2
    row.BackgroundTransparency=0.2; row.Parent=parent
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,10)
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-80,1,0); lbl.Position=UDim2.new(0,16,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=name; lbl.TextColor3=Theme.Text
    lbl.Font=Theme.Font; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=row
    local sw=Instance.new("TextButton")
    sw.Size=UDim2.new(0,40,0,20); sw.Position=UDim2.new(1,-54,0.5,-10)
    sw.BackgroundColor3=default and Theme.Accent or Theme.Bg3
    sw.Text=""; sw.AutoButtonColor=false; sw.Parent=row
    Instance.new("UICorner",sw).CornerRadius=UDim.new(1,0)
    local knob=Instance.new("Frame")
    knob.Size=UDim2.new(0,16,0,16)
    knob.Position=default and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    knob.BackgroundColor3=Color3.fromRGB(255,255,255); knob.Parent=sw
    Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
    local state=default
    sw.MouseButton1Click:Connect(function()
        state=not state
        if state then
            TS:Create(sw,TweenInfo.new(0.25,Enum.EasingStyle.Quart),{BackgroundColor3=Theme.Accent}):Play()
            TS:Create(knob,TweenInfo.new(0.25,Enum.EasingStyle.Quart),{Position=UDim2.new(1,-18,0.5,-8)}):Play()
        else
            TS:Create(sw,TweenInfo.new(0.25,Enum.EasingStyle.Quart),{BackgroundColor3=Theme.Bg3}):Play()
            TS:Create(knob,TweenInfo.new(0.25,Enum.EasingStyle.Quart),{Position=UDim2.new(0,2,0.5,-8)}):Play()
        end
        callback(state)
    end)
end

local function CreateSlider(parent,name,mn,mx,default,callback)
    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,-5,0,52); row.BackgroundColor3=Theme.Bg2
    row.BackgroundTransparency=0.2; row.Parent=parent
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,10)
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-100,0,18); lbl.Position=UDim2.new(0,16,0,6)
    lbl.BackgroundTransparency=1; lbl.Text=name; lbl.TextColor3=Theme.Text
    lbl.Font=Theme.Font; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=row
    local val=Instance.new("TextLabel")
    val.Size=UDim2.new(0,50,0,18); val.Position=UDim2.new(1,-66,0,6)
    val.BackgroundTransparency=1; val.Text=tostring(default); val.TextColor3=Theme.Accent
    val.Font=Theme.FontBold; val.TextSize=12; val.Parent=row
    local bar=Instance.new("Frame")
    bar.Size=UDim2.new(1,-32,0,6); bar.Position=UDim2.new(0,16,0,34)
    bar.BackgroundColor3=Theme.Bg3; bar.Parent=row
    Instance.new("UICorner",bar).CornerRadius=UDim.new(1,0)
    local fill=Instance.new("Frame")
    fill.Size=UDim2.new((default-mn)/(mx-mn),0,1,0); fill.BackgroundColor3=Theme.Accent
    fill.Parent=bar; Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
    local dot=Instance.new("Frame")
    dot.Size=UDim2.new(0,14,0,14); dot.AnchorPoint=Vector2.new(0.5,0.5)
    dot.Position=UDim2.new((default-mn)/(mx-mn),0,0.5,0)
    dot.BackgroundColor3=Color3.fromRGB(255,255,255); dot.Parent=bar
    Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
    local dragging=false
    local function update(input)
        local p=math.clamp((input.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
        local v=math.floor(mn+(mx-mn)*p)
        fill.Size=UDim2.new(p,0,1,0); dot.Position=UDim2.new(p,0,0.5,0)
        val.Text=tostring(v); callback(v)
    end
    bar.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; update(i)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then update(i) end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
end

CreatePage("Aim"); CreatePage("Visual"); CreatePage("Move"); CreatePage("Misc")
CreateTab("Aim Assist","🎯","Aim")
CreateTab("Visuals","👁","Visual")
CreateTab("Movement","🏃","Move")
CreateTab("Misc","⚙","Misc")
pages["Aim"].Visible=true
-- PHẦN 4/4: Tab Contents + Aim + ESP + Movement + Main Loop

-- AIM TAB
local AimP=pages["Aim"]
CreateSection(AimP,"General")
CreateToggle(AimP,"Aim Assist",false,function(s) C.Aim=s Notify("Aim Assist",s and "Enabled" or "Disabled") end)
CreateToggle(AimP,"Silent Aim",false,function(s) C.SilentAim=s end)
CreateToggle(AimP,"Auto Shoot",false,function(s) C.AutoShoot=s end)
CreateToggle(AimP,"Magic Bullet",false,function(s) C.MagicBullet=s end)
CreateToggle(AimP,"Prediction",false,function(s) C.Prediction=s end)
CreateToggle(AimP,"Target Lock",false,function(s) C.TargetLock=s end)
CreateToggle(AimP,"Team Check",true,function(s) C.TeamCheck=s end)
CreateSection(AimP,"Adjust")
CreateSlider(AimP,"FOV Radius",50,500,150,function(v) C.FOV=v end)
CreateSlider(AimP,"Smoothness",5,100,35,function(v) C.Smooth=v/100 end)

-- VISUAL TAB
local VisP=pages["Visual"]
CreateSection(VisP,"Player ESP")
CreateToggle(VisP,"Enable ESP",false,function(s) C.ESP=s Notify("ESP",s and "Enabled" or "Disabled") end)
CreateToggle(VisP,"Box 2D",false,function(s) C.ESPBox=s end)
CreateToggle(VisP,"Health Bar",false,function(s) C.ESPHealth=s end)
CreateToggle(VisP,"Name Tag",false,function(s) C.ESPName=s end)
CreateToggle(VisP,"Distance",false,function(s) C.ESPDistance=s end)
CreateToggle(VisP,"Tracer Lines",false,function(s) C.ESPTracer=s end)
CreateToggle(VisP,"Chams (Highlight)",false,function(s) C.ESPChams=s end)

-- MOVE TAB
local MovP=pages["Move"]
CreateSection(MovP,"Speed")
CreateToggle(MovP,"Speed Hack",false,function(s) C.Speed=s end)
CreateSlider(MovP,"Walk Speed",16,300,50,function(v) C.SpeedVal=v end)
CreateSection(MovP,"Air")
CreateToggle(MovP,"Infinite Jump",false,function(s) C.InfJump=s end)
CreateToggle(MovP,"Bunny Hop",false,function(s) C.Bhop=s end)
CreateToggle(MovP,"Fly",false,function(s) C.Fly=s Notify("Fly",s and "Enabled" or "Disabled") end)
CreateSlider(MovP,"Fly Speed",30,500,100,function(v) C.FlySpeed=v end)
CreateSection(MovP,"Other")
CreateToggle(MovP,"Noclip",false,function(s) C.Noclip=s end)
CreateToggle(MovP,"Anti-AFK",true,function(s) C.AntiAFK=s end)

-- MISC TAB
local MiscP=pages["Misc"]
CreateSection(MiscP,"Config")
local SaveBtn=Instance.new("TextButton")
SaveBtn.Size=UDim2.new(1,-5,0,38); SaveBtn.BackgroundColor3=Theme.Bg3
SaveBtn.Text="💾   Save Config"; SaveBtn.TextColor3=Theme.Text
SaveBtn.Font=Theme.FontBold; SaveBtn.TextSize=12; SaveBtn.AutoButtonColor=false
SaveBtn.Parent=MiscP; Instance.new("UICorner",SaveBtn).CornerRadius=UDim.new(0,10)
SaveBtn.MouseEnter:Connect(function() TS:Create(SaveBtn,TweenInfo.new(0.2),{BackgroundColor3=Theme.Accent}):Play() end)
SaveBtn.MouseLeave:Connect(function() TS:Create(SaveBtn,TweenInfo.new(0.2),{BackgroundColor3=Theme.Bg3}):Play() end)
SaveBtn.MouseButton1Click:Connect(function()
    if not writefile then Notify("Error","Executor không hỗ trợ!",3) return end
    pcall(function() writefile("oscheat_v6.json",game:GetService("HttpService"):JSONEncode(C)) end)
    Notify("Success","Đã lưu config",2)
end)
local LoadBtn=Instance.new("TextButton")
LoadBtn.Size=UDim2.new(1,-5,0,38); LoadBtn.BackgroundColor3=Theme.Bg3
LoadBtn.Text="📂   Load Config"; LoadBtn.TextColor3=Theme.Text
LoadBtn.Font=Theme.FontBold; LoadBtn.TextSize=12; LoadBtn.AutoButtonColor=false
LoadBtn.Parent=MiscP; Instance.new("UICorner",LoadBtn).CornerRadius=UDim.new(0,10)
LoadBtn.MouseEnter:Connect(function() TS:Create(LoadBtn,TweenInfo.new(0.2),{BackgroundColor3=Theme.Accent2}):Play() end)
LoadBtn.MouseLeave:Connect(function() TS:Create(LoadBtn,TweenInfo.new(0.2),{BackgroundColor3=Theme.Bg3}):Play() end)
LoadBtn.MouseButton1Click:Connect(function()
    if not isfile then Notify("Error","Executor không hỗ trợ!",3) return end
    pcall(function()
        if isfile("oscheat_v6.json") then
            local data=game:GetService("HttpService"):JSONDecode(readfile("oscheat_v6.json"))
            for k,v in pairs(data) do C[k]=v end
            Notify("Success","Đã load config",2)
        else Notify("Warning","Không tìm thấy config",2) end
    end)
end)

-- DRAG
local drag,ds,sp
Topbar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        drag=true; ds=i.Position; sp=Main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local dd=i.Position-ds
        Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dd.X,sp.Y.Scale,sp.Y.Offset+dd.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
end)
BtnClose.MouseButton1Click:Connect(function()
    TS:Create(Main,TweenInfo.new(0.25),{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0)}):Play()
    task.wait(0.3); Main.Visible=false
    local fb=Instance.new("TextButton")
    fb.Size=UDim2.new(0,55,0,55); fb.Position=UDim2.new(0,15,0,100)
    fb.BackgroundColor3=Theme.Bg; fb.Text="⚡"; fb.TextColor3=Theme.Accent
    fb.Font=Theme.FontBold; fb.TextSize=22; fb.Parent=SG
    Instance.new("UICorner",fb).CornerRadius=UDim.new(0,14)
    local st=Instance.new("UIStroke",fb); st.Color=Theme.Accent; st.Thickness=1; st.Transparency=0.5
    fb.MouseButton1Click:Connect(function()
        fb:Destroy(); Main.Visible=true
        Main.Size=UDim2.new(0,0,0,0); Main.Position=UDim2.new(0.5,0,0.5,0)
        TS:Create(Main,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{
            Size=UDim2.new(0,540,0,380), Position=UDim2.new(0.5,-270,0.5,-190)}):Play()
    end)
end)
BtnMin.MouseButton1Click:Connect(function()
    TS:Create(Main,TweenInfo.new(0.3,Enum.EasingStyle.Quart),{Size=UDim2.new(0,540,0,40)}):Play()
    task.delay(0.35,function() TS:Create(Main,TweenInfo.new(0.3),{Position=UDim2.new(0,15,0,15)}):Play() end)
end)

-- FOV
local hasDrawing=pcall(function() return Drawing end)
local FOVCircle
if hasDrawing then
    FOVCircle=Drawing.new("Circle")
    FOVCircle.Thickness=2; FOVCircle.NumSides=60; FOVCircle.Radius=C.FOV
    FOVCircle.Filled=false; FOVCircle.Color=Theme.Accent; FOVCircle.Transparency=0.8; FOVCircle.Visible=false
end

-- DETECTION
local function isTeam(plr)
    if not C.TeamCheck then return false end
    if not plr.Team or not LP.Team then return false end
    return plr.Team==LP.Team
end
local function findChar(plr)
    local ch=plr.Character
    if ch and ch:FindFirstChildOfClass("Humanoid") then return ch end
    for _,obj in ipairs(WS:GetChildren()) do
        if obj:IsA("Model") then
            local hum=obj:FindFirstChildOfClass("Humanoid")
            if hum and (obj.Name==plr.Name or obj.Name==plr.DisplayName) then return obj end
        end
    end
    return nil
end
local function getAimPart(ch)
    if not ch then return nil end
    return ch:FindFirstChild(C.AimPart) or ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")
        or ch:FindFirstChild("UpperTorso") or ch.PrimaryPart
end
local cachedTarget,lastScan=nil,0
local function getTarget()
    local now=tick()
    if now-lastScan<0.05 and cachedTarget and cachedTarget.Parent then return cachedTarget end
    lastScan=now
    local vp=Cam.ViewportSize; local cx,cy=vp.X/2,vp.Y/2
    local best,bestDist=nil,C.FOV
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP and not isTeam(plr) then
            local ch=findChar(plr)
            if ch then
                local hum=ch:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health>0 then
                    local part=getAimPart(ch)
                    if part then
                        local sp,on=Cam:WorldToViewportPoint(part.Position)
                        if on then
                            local dx,dy=sp.X-cx,sp.Y-cy
                            local d=math.sqrt(dx*dx+dy*dy)
                            if d<bestDist then bestDist=d; best=part end
                        end
                    end
                end
            end
        end
    end
    cachedTarget=best; return best
end

-- MAGIC BULLET
local mt=getrawmetatable and getrawmetatable(game)
if mt and setreadonly then
    local old=mt.__namecall
    setreadonly(mt,false)
    mt.__namecall=newcclosure(function(self,...)
        local m=getnamecallmethod()
        if (C.MagicBullet or C.SilentAim) and m=="FireServer" then
            local t=getTarget()
            if t then
                local args={...}
                for i,v in ipairs(args) do
                    if typeof(v)=="Vector3" then args[i]=t.Position
                    elseif typeof(v)=="CFrame" then args[i]=CFrame.new(v.Position,t.Position) end
                end
                return old(self,unpack(args))
            end
        end
        return old(self,...)
    end)
    setreadonly(mt,true)
end

-- AUTO SHOOT
task.spawn(function()
    while task.wait(0.08) do
        if C.AutoShoot and getTarget() then
            if LP.Character then
                local tool=LP.Character:FindFirstChildOfClass("Tool")
                if tool then pcall(function() tool:Activate() end) end
            end
            pcall(function()
                local m=UIS:GetMouseLocation()
                VIM:SendMouseButtonEvent(m.X,m.Y,0,true,game,1)
                VIM:SendMouseButtonEvent(m.X,m.Y,0,false,game,1)
            end)
        end
    end
end)

-- ESP DRAWINGS
local EspD={}
local function G(plr,t)
    if not hasDrawing then return nil end
    if not EspD[plr] then EspD[plr]={} end
    if EspD[plr][t] then return EspD[plr][t] end
    local o
    if t=="box" then o=Drawing.new("Square"); o.Thickness=1; o.Filled=false; o.Transparency=1; o.Color=Theme.Danger
    elseif t=="hp" then o=Drawing.new("Square"); o.Thickness=0; o.Filled=true
    elseif t=="name" then o=Drawing.new("Text"); o.Size=13; o.Center=true; o.Outline=true; o.Color=Color3.new(1,1,1)
    elseif t=="dist" then o=Drawing.new("Text"); o.Size=12; o.Center=true; o.Outline=true; o.Color=Color3.fromRGB(200,200,200)
    elseif t=="tracer" then o=Drawing.new("Line"); o.Thickness=1; o.Color=Theme.Danger; o.Transparency=0.7 end
    EspD[plr][t]=o; return o
end
local function ClearEsp(plr)
    if EspD[plr] then
        for _,d in pairs(EspD[plr]) do if d.Remove then d:Remove() end end
        EspD[plr]=nil
    end
end

-- CHAMS
local chams={}
local function updateChams()
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP and not isTeam(plr) then
            local ch=findChar(plr)
            if ch and C.ESP and C.ESPChams then
                if not chams[plr] or chams[plr].Parent~=ch then
                    if chams[plr] then chams[plr]:Destroy() end
                    local h=Instance.new("Highlight")
                    h.FillColor=Theme.Danger; h.OutlineColor=Color3.fromRGB(255,255,255)
                    h.FillTransparency=0.5; h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
                    h.Parent=ch; chams[plr]=h
                end
            elseif chams[plr] then chams[plr]:Destroy(); chams[plr]=nil end
        elseif chams[plr] then chams[plr]:Destroy(); chams[plr]=nil end
    end
end

-- MOVEMENT
UIS.JumpRequest:Connect(function()
    if (C.InfJump or C.Bhop) and LP.Character then
        local h=LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)
local fbv,fbg
local function startFly()
    if not LP.Character then return end
    local hrp=LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    fbv=Instance.new("BodyVelocity",hrp); fbv.MaxForce=Vector3.new(1e5,1e5,1e5); fbv.Velocity=Vector3.zero
    fbg=Instance.new("BodyGyro",hrp); fbg.MaxTorque=Vector3.new(1e5,1e5,1e5); fbg.P=1000; fbg.D=50
end
local function stopFly()
    if fbv then fbv:Destroy() fbv=nil end
    if fbg then fbg:Destroy() fbg=nil end
end
task.spawn(function()
    while task.wait(60) do
        if C.AntiAFK then
            pcall(function()
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton2(Vector2.new())
            end)
        end
    end
end)

-- MAIN LOOP
local frame=0
RunService.RenderStepped:Connect(function()
    frame=frame+1
    local vp=Cam.ViewportSize; local cx,cy=vp.X/2,vp.Y/2
    if hasDrawing then
        FOVCircle.Visible=C.Aim; FOVCircle.Position=Vector2.new(cx,cy); FOVCircle.Radius=C.FOV
    end
    if frame%3==0 and LP.Character then
        local h=LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=C.Speed and C.SpeedVal or 16 end
        if C.Fly and not fbv then startFly() elseif not C.Fly and fbv then stopFly() end
    end
    if C.Fly and fbv and fbg and LP.Character then
        local hrp=LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local dir=Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir=dir+Cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir=dir-Cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir=dir-Cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir=dir+Cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir=dir+Vector3.new(0,1,0) end
            fbv.Velocity=dir*C.FlySpeed; fbg.CFrame=Cam.CFrame
        end
    end
    if C.Noclip and LP.Character then
        for _,p in ipairs(LP.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide=false end
        end
    end
    if C.Bhop and LP.Character then
        local h=LP.Character:FindFirstChildOfClass("Humanoid")
        if h and h.MoveDirection.Magnitude>0 then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
    if frame%2==0 and hasDrawing then
        for _,plr in ipairs(Players:GetPlayers()) do
            if plr~=LP and not isTeam(plr) then
                local ch=findChar(plr)
                if ch and C.ESP then
                    local hum=ch:FindFirstChildOfClass("Humanoid")
                    local hrp=ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart
                    local head=ch:FindFirstChild("Head") or hrp
                    if hum and hum.Health>0 and hrp and head then
                        local tP,tO=Cam:WorldToViewportPoint(head.Position+Vector3.new(0,1,0))
                        local bP,bO=Cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,3,0))
                        if tO and bO then
                            local bh=math.abs(bP.Y-tP.Y); local bw=bh*0.5
                            if C.ESPBox then
                                local b=G(plr,"box")
                                b.Size=Vector2.new(bw,bh); b.Position=Vector2.new(tP.X-bw/2,tP.Y); b.Visible=true
                            else local b=G(plr,"box"); if b then b.Visible=false end end
                            if C.ESPHealth then
                                local hp=G(plr,"hp"); local r=hum.Health/hum.MaxHealth
                                hp.Size=Vector2.new(3,bh*r); hp.Position=Vector2.new(tP.X-bw/2-6,tP.Y+bh*(1-r))
                                hp.Color=Color3.fromRGB(255*(1-r),255*r,0); hp.Visible=true
                            else local hp=G(plr,"hp"); if hp then hp.Visible=false end end
                            if C.ESPName then
                                local nm=G(plr,"name")
                                nm.Text=plr.Name; nm.Position=Vector2.new(tP.X,tP.Y-15); nm.Visible=true
                            else local nm=G(plr,"name"); if nm then nm.Visible=false end end
                            if C.ESPDistance then
                                local dm=G(plr,"dist")
                                dm.Text="["..math.floor((Cam.CFrame.Position-hrp.Position).Magnitude).."m]"
                                dm.Position=Vector2.new(tP.X,bP.Y+3); dm.Visible=true
                            else local dm=G(plr,"dist"); if dm then dm.Visible=false end end
                            if C.ESPTracer then
                                local tr=G(plr,"tracer")
                                tr.From=Vector2.new(cx,cy+30); tr.To=Vector2.new(tP.X,tP.Y+bh/2); tr.Visible=true
                            else local tr=G(plr,"tracer"); if tr then tr.Visible=false end end
                        end
                    end
                else ClearEsp(plr) end
            else ClearEsp(plr) end
        end
    end
    if frame%10==0 then updateChams() end
    if C.Aim and LP.Character then
        local t=getTarget()
        if t then
            local targetCF=CFrame.new(Cam.CFrame.Position,t.Position)
            Cam.CFrame=Cam.CFrame:Lerp(targetCF,C.Smooth)
        end
    end
end)

for _,plr in ipairs(Players:GetPlayers()) do
    plr.CharacterRemoving:Connect(function() ClearEsp(plr) end)
end
Players.PlayerRemoving:Connect(function(plr) ClearEsp(plr) end)

task.wait(0.5)
Notify("Welcome","One Shot Cheat v6 Loaded",3)
Notify("Info","Draw API: "..tostring(hasDrawing),3)
print("[One Shot Cheat V6] Loaded!")
