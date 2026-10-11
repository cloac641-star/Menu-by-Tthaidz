--[[ TTHAIDZ CHEAT V7 - FIXED UI ]]
-- PHẦN 1/3

local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local WS=game:GetService("Workspace")
local RS=game:GetService("ReplicatedStorage")
local VIM=game:GetService("VirtualInputManager")
local TS=game:GetService("TweenService")
local LP=Players.LocalPlayer
local Cam=WS.CurrentCamera

-- THEME (đổi màu sáng hơn cho switch dễ thấy)
local T={
    Bg=Color3.fromRGB(15,15,20),
    Bg2=Color3.fromRGB(24,24,32),
    Bg3=Color3.fromRGB(45,45,58),
    Bg4=Color3.fromRGB(60,60,75),
    Stroke=Color3.fromRGB(55,55,70),
    Text=Color3.fromRGB(240,240,245),
    TextDim=Color3.fromRGB(150,150,165),
    Accent=Color3.fromRGB(0,220,140),
    Accent2=Color3.fromRGB(0,180,255),
    Danger=Color3.fromRGB(255,70,90),
    Warning=Color3.fromRGB(255,180,60),
    Font=Enum.Font.GothamMedium,
    FontBold=Enum.Font.GothamBold,
}

local C={
    Aim=false,SilentAim=false,AutoShoot=false,MagicBullet=false,
    FOV=150,Smooth=35,Prediction=false,TargetLock=false,AimPart="Head",TeamCheck=true,
    ESP=false,ESPBox=false,ESPHealth=false,ESPName=false,ESPDistance=false,ESPTracer=false,ESPChams=false,
    Speed=false,SpeedVal=50,InfJump=false,Bhop=false,Fly=false,FlySpeed=100,Noclip=false,AntiAFK=true,
}

-- SCREENGUI
local SG=Instance.new("ScreenGui")
SG.Name="TthaidzCheat"
SG.ResetOnSpawn=false
SG.IgnoreGuiInset=true
SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
SG.DisplayOrder=999
SG.Parent=game:GetService("CoreGui")

-- WATERMARK
local WM=Instance.new("Frame")
WM.Size=UDim2.new(0,240,0,30)
WM.Position=UDim2.new(0.5,-120,0,10)
WM.BackgroundColor3=T.Bg
WM.BackgroundTransparency=0.05
WM.Parent=SG
Instance.new("UICorner",WM).CornerRadius=UDim.new(0,8)
local wst=Instance.new("UIStroke",WM)
wst.Color=T.Accent; wst.Thickness=1; wst.Transparency=0.4
local WMT=Instance.new("TextLabel")
WMT.Size=UDim2.new(1,0,1,0)
WMT.BackgroundTransparency=1
WMT.Text="⚡ TTHAIDZ  •  Premium v7"
WMT.TextColor3=T.Text
WMT.Font=T.FontBold
WMT.TextSize=12
WMT.Parent=WM

-- NOTIFICATION
local NH=Instance.new("Frame")
NH.Size=UDim2.new(0,280,1,-40)
NH.Position=UDim2.new(1,-300,0,20)
NH.BackgroundTransparency=1
NH.Parent=SG
local NL=Instance.new("UIListLayout",NH)
NL.SortOrder=Enum.SortOrder.LayoutOrder
NL.Padding=UDim.new(0,8)

local function Notify(title,desc,dur)
    dur=dur or 3
    local n=Instance.new("Frame")
    n.Size=UDim2.new(1,0,0,55)
    n.BackgroundColor3=T.Bg2
    n.Position=UDim2.new(1,50,0,0)
    n.Parent=NH
    Instance.new("UICorner",n).CornerRadius=UDim.new(0,10)
    local st=Instance.new("UIStroke",n)
    st.Color=T.Accent; st.Thickness=1; st.Transparency=0.6
    local bar=Instance.new("Frame")
    bar.Size=UDim2.new(0,3,1,-16)
    bar.Position=UDim2.new(0,8,0,8)
    bar.BackgroundColor3=T.Accent
    bar.Parent=n
    Instance.new("UICorner",bar).CornerRadius=UDim.new(1,0)
    local t1=Instance.new("TextLabel")
    t1.Size=UDim2.new(1,-30,0,22)
    t1.Position=UDim2.new(0,18,0,6)
    t1.BackgroundTransparency=1
    t1.Text=title
    t1.TextColor3=T.Text
    t1.Font=T.FontBold
    t1.TextSize=13
    t1.TextXAlignment=Enum.TextXAlignment.Left
    t1.Parent=n
    local t2=Instance.new("TextLabel")
    t2.Size=UDim2.new(1,-30,0,18)
    t2.Position=UDim2.new(0,18,0,26)
    t2.BackgroundTransparency=1
    t2.Text=desc or ""
    t2.TextColor3=T.TextDim
    t2.Font=T.Font
    t2.TextSize=11
    t2.TextXAlignment=Enum.TextXAlignment.Left
    t2.Parent=n
    TS:Create(n,TweenInfo.new(0.35,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play()
    task.delay(dur,function()
        TS:Create(n,TweenInfo.new(0.3),{Position=UDim2.new(1,50,0,0)}):Play()
        TS:Create(t1,TweenInfo.new(0.3),{TextTransparency=1}):Play()
        TS:Create(t2,TweenInfo.new(0.3),{TextTransparency=1}):Play()
        task.wait(0.35); n:Destroy()
    end)
end
-- PHẦN 2/3: Main Window + Tabs + Widgets

-- MAIN WINDOW
local Main=Instance.new("Frame")
Main.Size=UDim2.new(0,560,0,400)
Main.Position=UDim2.new(0.5,-280,0.5,-200)
Main.BackgroundColor3=T.Bg
Main.Parent=SG
Main.ClipsDescendants=false
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,14)
local MStr=Instance.new("UIStroke",Main)
MStr.Color=T.Stroke; MStr.Thickness=1

local Glow=Instance.new("Frame")
Glow.Size=UDim2.new(1,0,0,3)
Glow.BackgroundColor3=T.Accent
Glow.BorderSizePixel=0
Glow.Parent=Main
local GG=Instance.new("UIGradient")
GG.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0,T.Accent),
    ColorSequenceKeypoint.new(0.5,T.Accent2),
    ColorSequenceKeypoint.new(1,T.Accent),
})
Instance.new("UICorner",Glow).CornerRadius=UDim.new(0,14)

-- SIDEBAR
local Side=Instance.new("Frame")
Side.Size=UDim2.new(0,160,1,0)
Side.BackgroundColor3=T.Bg2
Side.BorderSizePixel=0
Side.Parent=Main
Instance.new("UICorner",Side).CornerRadius=UDim.new(0,14)
local Cover=Instance.new("Frame")
Cover.Size=UDim2.new(0,20,1,0)
Cover.Position=UDim2.new(1,-20,0,0)
Cover.BackgroundColor3=T.Bg2
Cover.BorderSizePixel=0
Cover.Parent=Side

local Div=Instance.new("Frame")
Div.Size=UDim2.new(0,1,1,0)
Div.Position=UDim2.new(1,-1,0,0)
Div.BackgroundColor3=T.Stroke
Div.BorderSizePixel=0
Div.Parent=Side

-- LOGO
local LF=Instance.new("Frame")
LF.Size=UDim2.new(1,0,0,72)
LF.BackgroundTransparency=1
LF.Parent=Side
local LI=Instance.new("TextLabel")
LI.Size=UDim2.new(0,36,0,36)
LI.Position=UDim2.new(0,16,0,18)
LI.BackgroundColor3=T.Accent
LI.Text="⚡"
LI.TextColor3=T.Bg
LI.Font=T.FontBold
LI.TextSize=20
LI.Parent=LF
Instance.new("UICorner",LI).CornerRadius=UDim.new(0,10)
local LT=Instance.new("TextLabel")
LT.Size=UDim2.new(1,-62,0,20)
LT.Position=UDim2.new(0,60,0,20)
LT.BackgroundTransparency=1
LT.Text="TTHAIDZ"
LT.TextColor3=T.Text
LT.Font=T.FontBold
LT.TextSize=14
LT.TextXAlignment=Enum.TextXAlignment.Left
LT.Parent=LF
local LS=Instance.new("TextLabel")
LS.Size=UDim2.new(1,-62,0,16)
LS.Position=UDim2.new(0,60,0,38)
LS.BackgroundTransparency=1
LS.Text="Premium v7"
LS.TextColor3=T.Accent
LS.Font=T.Font
LS.TextSize=10
LS.TextXAlignment=Enum.TextXAlignment.Left
LS.Parent=LF

-- TAB LIST
local TL=Instance.new("Frame")
TL.Size=UDim2.new(1,0,1,-85)
TL.Position=UDim2.new(0,0,0,75)
TL.BackgroundTransparency=1
TL.Parent=Side
Instance.new("UIListLayout",TL).Padding=UDim.new(0,4)

-- TOPBAR
local TB=Instance.new("Frame")
TB.Size=UDim2.new(1,-160,0,44)
TB.Position=UDim2.new(0,160,0,0)
TB.BackgroundColor3=T.Bg2
TB.BackgroundTransparency=0.4
TB.Parent=Main
local PT=Instance.new("TextLabel")
PT.Size=UDim2.new(0,200,1,0)
PT.Position=UDim2.new(0,16,0,0)
PT.BackgroundTransparency=1
PT.Text="Aim Assist"
PT.TextColor3=T.Text
PT.Font=T.FontBold
PT.TextSize=14
PT.TextXAlignment=Enum.TextXAlignment.Left
PT.Parent=TB

-- NÚT WINDOW TO HƠN (22px)
local function makeBtn(px,color,symbol)
    local wrap=Instance.new("Frame")
    wrap.Size=UDim2.new(0,26,0,26)
    wrap.Position=UDim2.new(1,px,0,9)
    wrap.BackgroundTransparency=1
    wrap.Parent=TB
    
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0,22,0,22)
    b.Position=UDim2.new(0.5,-11,0.5,-11)
    b.BackgroundColor3=color
    b.Text=symbol
    b.TextColor3=Color3.fromRGB(15,15,20)
    b.Font=T.FontBold
    b.TextSize=14
    b.AutoButtonColor=false
    b.Parent=wrap
    Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
    
    b.MouseEnter:Connect(function()
        TS:Create(b,TweenInfo.new(0.15),{BackgroundColor3=color:Lerp(Color3.new(1,1,1),0.3)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TS:Create(b,TweenInfo.new(0.15),{BackgroundColor3=color}):Play()
    end)
    return b
end

local BClose=makeBtn(-32,T.Danger,"×")
local BMin=makeBtn(-64,T.Warning,"−")

-- PAGES + TAB SYSTEM
local pages={}

local function CreatePage(name)
    local p=Instance.new("ScrollingFrame")
    p.Size=UDim2.new(1,-180,1,-60)
    p.Position=UDim2.new(0,172,0,52)
    p.BackgroundTransparency=1
    p.ScrollBarThickness=4
    p.ScrollBarImageColor3=T.Accent
    p.CanvasSize=UDim2.new(0,0,0,0)
    p.Visible=false
    p.Parent=Main
    local L=Instance.new("UIListLayout",p)
    L.Padding=UDim.new(0,8)
    L.SortOrder=Enum.SortOrder.LayoutOrder
    L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        p.CanvasSize=UDim2.new(0,0,0,L.AbsoluteContentSize.Y+10)
    end)
    pages[name]=p
    return p
end

local function CreateTab(name,icon,pageName)
    local tab=Instance.new("TextButton")
    tab.Size=UDim2.new(1,-16,0,38)
    tab.Position=UDim2.new(0,8,0,0)
    tab.BackgroundColor3=T.Bg3
    tab.BackgroundTransparency=1
    tab.Text=""
    tab.AutoButtonColor=false
    tab.Parent=TL
    Instance.new("UICorner",tab).CornerRadius=UDim.new(0,10)
    
    local ind=Instance.new("Frame")
    ind.Size=UDim2.new(0,3,0,0)
    ind.Position=UDim2.new(0,0,0.5,0)
    ind.AnchorPoint=Vector2.new(0,0.5)
    ind.BackgroundColor3=T.Accent
    ind.Parent=tab
    Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
    
    local ic=Instance.new("TextLabel")
    ic.Size=UDim2.new(0,20,1,0)
    ic.Position=UDim2.new(0,14,0,0)
    ic.BackgroundTransparency=1
    ic.Text=icon
    ic.TextColor3=T.TextDim
    ic.Font=T.Font
    ic.TextSize=14
    ic.Parent=tab
    
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-40,1,0)
    lbl.Position=UDim2.new(0,40,0,0)
    lbl.BackgroundTransparency=1
    lbl.Text=name
    lbl.TextColor3=T.TextDim
    lbl.Font=T.Font
    lbl.TextSize=12
    lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=tab
    
    tab.MouseEnter:Connect(function()
        if pages[pageName].Visible then return end
        TS:Create(tab,TweenInfo.new(0.2),{BackgroundTransparency=0.5}):Play()
        TS:Create(lbl,TweenInfo.new(0.2),{TextColor3=T.Text}):Play()
        TS:Create(ic,TweenInfo.new(0.2),{TextColor3=T.Text}):Play()
    end)
    tab.MouseLeave:Connect(function()
        if pages[pageName].Visible then return end
        TS:Create(tab,TweenInfo.new(0.2),{BackgroundTransparency=1}):Play()
        TS:Create(lbl,TweenInfo.new(0.2),{TextColor3=T.TextDim}):Play()
        TS:Create(ic,TweenInfo.new(0.2),{TextColor3=T.TextDim}):Play()
    end)
    
    tab.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible=false end
        pages[pageName].Visible=true
        PT.Text=name
        for _,tb in ipairs(TL:GetChildren()) do
            if tb:IsA("TextButton") then
                local indicator=tb:FindFirstChildOfClass("Frame")
                local lbls={}
                for _,c in ipairs(tb:GetChildren()) do
                    if c:IsA("TextLabel") then table.insert(lbls,c) end
                end
                if tb==tab then
                    TS:Create(tb,TweenInfo.new(0.25),{BackgroundTransparency=0.3}):Play()
                    for _,l2 in ipairs(lbls) do TS:Create(l2,TweenInfo.new(0.2),{TextColor3=T.Text}):Play() end
                    if indicator then TS:Create(indicator,TweenInfo.new(0.25),{Size=UDim2.new(0,3,0,22)}):Play() end
                else
                    TS:Create(tb,TweenInfo.new(0.25),{BackgroundTransparency=1}):Play()
                    for _,l2 in ipairs(lbls) do TS:Create(l2,TweenInfo.new(0.2),{TextColor3=T.TextDim}):Play() end
                    if indicator then TS:Create(indicator,TweenInfo.new(0.25),{Size=UDim2.new(0,3,0,0)}):Play() end
                end
            end
        end
    end)
    return tab
end

-- SECTION
local function Section(parent,text)
    local s=Instance.new("TextLabel")
    s.Size=UDim2.new(1,-5,0,24)
    s.BackgroundTransparency=1
    s.Text="  "..string.upper(text)
    s.TextColor3=T.TextDim
    s.Font=T.FontBold
    s.TextSize=10
    s.TextXAlignment=Enum.TextXAlignment.Left
    s.Parent=parent
end

-- TOGGLE MỚI: dùng nút ON/OFF có viền rõ ràng
local function Toggle(parent,name,default,cb)
    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,-10,0,46)
    row.BackgroundColor3=T.Bg2
    row.BackgroundTransparency=0.2
    row.Parent=parent
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,10)
    local rs=Instance.new("UIStroke",row)
    rs.Color=T.Stroke
    rs.Thickness=1
    rs.Transparency=0.5
    
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-90,1,0)
    lbl.Position=UDim2.new(0,16,0,0)
    lbl.BackgroundTransparency=1
    lbl.Text=name
    lbl.TextColor3=T.Text
    lbl.Font=T.Font
    lbl.TextSize=13
    lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=row
    
    -- Nút ON/OFF rõ ràng
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(0,62,0,28)
    btn.Position=UDim2.new(1,-76,0.5,-14)
    btn.BackgroundColor3=default and T.Accent or T.Bg4
    btn.Text=default and "ON" or "OFF"
    btn.TextColor3=Color3.new(1,1,1)
    btn.Font=T.FontBold
    btn.TextSize=11
    btn.AutoButtonColor=false
    btn.Parent=row
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
    local bs=Instance.new("UIStroke",btn)
    bs.Color=default and T.Accent or T.Stroke
    bs.Thickness=1.5
    
    local st=default
    btn.MouseButton1Click:Connect(function()
        st=not st
        TS:Create(btn,TweenInfo.new(0.2,Enum.EasingStyle.Quart),{
            BackgroundColor3=st and T.Accent or T.Bg4
        }):Play()
        TS:Create(bs,TweenInfo.new(0.2),{Color=st and T.Accent or T.Stroke}):Play()
        btn.Text=st and "ON" or "OFF"
        cb(st)
    end)
end

-- SLIDER
local function Slider(parent,name,mn,mx,default,cb)
    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,-10,0,56)
    row.BackgroundColor3=T.Bg2
    row.BackgroundTransparency=0.2
    row.Parent=parent
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,10)
    local rs=Instance.new("UIStroke",row)
    rs.Color=T.Stroke; rs.Thickness=1; rs.Transparency=0.5
    
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-100,0,18)
    lbl.Position=UDim2.new(0,16,0,8)
    lbl.BackgroundTransparency=1
    lbl.Text=name
    lbl.TextColor3=T.Text
    lbl.Font=T.Font
    lbl.TextSize=12
    lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=row
    
    local val=Instance.new("TextLabel")
    val.Size=UDim2.new(0,50,0,18)
    val.Position=UDim2.new(1,-66,0,8)
    val.BackgroundTransparency=1
    val.Text=tostring(default)
    val.TextColor3=T.Accent
    val.Font=T.FontBold
    val.TextSize=12
    val.Parent=row
    
    local bar=Instance.new("Frame")
    bar.Size=UDim2.new(1,-32,0,8)
    bar.Position=UDim2.new(0,16,0,36)
    bar.BackgroundColor3=T.Bg3
    bar.Parent=row
    Instance.new("UICorner",bar).CornerRadius=UDim.new(1,0)
    
    local fill=Instance.new("Frame")
    fill.Size=UDim2.new((default-mn)/(mx-mn),0,1,0)
    fill.BackgroundColor3=T.Accent
    fill.Parent=bar
    Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
    
    local dot=Instance.new("Frame")
    dot.Size=UDim2.new(0,16,0,16)
    dot.AnchorPoint=Vector2.new(0.5,0.5)
    dot.Position=UDim2.new((default-mn)/(mx-mn),0,0.5,0)
    dot.BackgroundColor3=Color3.fromRGB(255,255,255)
    dot.Parent=bar
    Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
    
    local dragging=false
    local function update(input)
        local p=math.clamp((input.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
        local v=math.floor(mn+(mx-mn)*p)
        fill.Size=UDim2.new(p,0,1,0)
        dot.Position=UDim2.new(p,0,0.5,0)
        val.Text=tostring(v)
        cb(v)
    end
    bar.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; update(i)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            update(i)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
end

-- TẠO PAGES + TABS
CreatePage("Aim")
CreatePage("Visual")
CreatePage("Move")
CreatePage("Misc")
CreateTab("Aim Assist","🎯","Aim")
CreateTab("Visuals","👁","Visual")
CreateTab("Movement","🏃","Move")
CreateTab("Misc","⚙","Misc")
pages["Aim"].Visible=true
-- PHẦN 3/3: Content + Logic + Main Loop

-- AIM TAB
local AP=pages["Aim"]
Section(AP,"General")
Toggle(AP,"Aim Assist",false,function(s) C.Aim=s Notify("Aim Assist",s and "ON" or "OFF") end)
Toggle(AP,"Silent Aim",false,function(s) C.SilentAim=s end)
Toggle(AP,"Auto Shoot",false,function(s) C.AutoShoot=s end)
Toggle(AP,"Magic Bullet",false,function(s) C.MagicBullet=s end)
Toggle(AP,"Prediction",false,function(s) C.Prediction=s end)
Toggle(AP,"Target Lock",false,function(s) C.TargetLock=s end)
Toggle(AP,"Team Check",true,function(s) C.TeamCheck=s end)
Section(AP,"Adjust")
Slider(AP,"FOV Radius",50,500,150,function(v) C.FOV=v end)
Slider(AP,"Smoothness",5,100,35,function(v) C.Smooth=v/100 end)

-- VISUAL TAB
local VP=pages["Visual"]
Section(VP,"Player ESP")
Toggle(VP,"Enable ESP",false,function(s) C.ESP=s Notify("ESP",s and "ON" or "OFF") end)
Toggle(VP,"Box 2D",false,function(s) C.ESPBox=s end)
Toggle(VP,"Health Bar",false,function(s) C.ESPHealth=s end)
Toggle(VP,"Name Tag",false,function(s) C.ESPName=s end)
Toggle(VP,"Distance",false,function(s) C.ESPDistance=s end)
Toggle(VP,"Tracer Lines",false,function(s) C.ESPTracer=s end)
Toggle(VP,"Chams",false,function(s) C.ESPChams=s end)

-- MOVE TAB
local MP=pages["Move"]
Section(MP,"Speed")
Toggle(MP,"Speed Hack",false,function(s) C.Speed=s end)
Slider(MP,"Walk Speed",16,300,50,function(v) C.SpeedVal=v end)
Section(MP,"Air")
Toggle(MP,"Infinite Jump",false,function(s) C.InfJump=s end)
Toggle(MP,"Bunny Hop",false,function(s) C.Bhop=s end)
Toggle(MP,"Fly",false,function(s) C.Fly=s Notify("Fly",s and "ON" or "OFF") end)
Slider(MP,"Fly Speed",30,500,100,function(v) C.FlySpeed=v end)
Section(MP,"Other")
Toggle(MP,"Noclip",false,function(s) C.Noclip=s end)
Toggle(MP,"Anti-AFK",true,function(s) C.AntiAFK=s end)

-- MISC TAB
local XP=pages["Misc"]
Section(XP,"Config")
local SB=Instance.new("TextButton")
SB.Size=UDim2.new(1,-10,0,42)
SB.BackgroundColor3=T.Bg3
SB.Text="💾   Save Config"
SB.TextColor3=T.Text
SB.Font=T.FontBold
SB.TextSize=13
SB.AutoButtonColor=false
SB.Parent=XP
Instance.new("UICorner",SB).CornerRadius=UDim.new(0,10)
local sbs=Instance.new("UIStroke",SB)
sbs.Color=T.Stroke; sbs.Thickness=1
SB.MouseEnter:Connect(function() TS:Create(SB,TweenInfo.new(0.2),{BackgroundColor3=T.Accent}):Play() end)
SB.MouseLeave:Connect(function() TS:Create(SB,TweenInfo.new(0.2),{BackgroundColor3=T.Bg3}):Play() end)
SB.MouseButton1Click:Connect(function()
    if not writefile then Notify("Error","Executor không hỗ trợ!",3) return end
    pcall(function() writefile("tthaidz_config.json",game:GetService("HttpService"):JSONEncode(C)) end)
    Notify("Success","Đã lưu config",2)
end)

local LB=Instance.new("TextButton")
LB.Size=UDim2.new(1,-10,0,42)
LB.BackgroundColor3=T.Bg3
LB.Text="📂   Load Config"
LB.TextColor3=T.Text
LB.Font=T.FontBold
LB.TextSize=13
LB.AutoButtonColor=false
LB.Parent=XP
Instance.new("UICorner",LB).CornerRadius=UDim.new(0,10)
local lbs=Instance.new("UIStroke",LB)
lbs.Color=T.Stroke; lbs.Thickness=1
LB.MouseEnter:Connect(function() TS:Create(LB,TweenInfo.new(0.2),{BackgroundColor3=T.Accent2}):Play() end)
LB.MouseLeave:Connect(function() TS:Create(LB,TweenInfo.new(0.2),{BackgroundColor3=T.Bg3}):Play() end)
LB.MouseButton1Click:Connect(function()
    if not isfile then Notify("Error","Executor không hỗ trợ!",3) return end
    pcall(function()
        if isfile("tthaidz_config.json") then
            local d=game:GetService("HttpService"):JSONDecode(readfile("tthaidz_config.json"))
            for k,v in pairs(d) do C[k]=v end
            Notify("Success","Đã load config",2)
        else Notify("Warning","Không có config",2) end
    end)
end)

-- DRAG
local dg,ds,sp
TB.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        dg=true; ds=i.Position; sp=Main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local dd=i.Position-ds
        Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dd.X,sp.Y.Scale,sp.Y.Offset+dd.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end
end)

-- MINIMIZE / RESTORE
local isMin=false
local savedSize,savedPos
local minimizedBar

BMin.MouseButton1Click:Connect(function()
    if isMin then
        -- Restore
        if minimizedBar then minimizedBar:Destroy() end
        Main.Visible=true
        TS:Create(Main,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{
            Size=savedSize or UDim2.new(0,560,0,400),
            Position=savedPos or UDim2.new(0.5,-280,0.5,-200)
        }):Play()
        isMin=false
    else
        -- Minimize
        savedSize=Main.Size
        savedPos=Main.Position
        Main.Visible=false
        isMin=true
        
        minimizedBar=Instance.new("TextButton")
        minimizedBar.Size=UDim2.new(0,200,0,40)
        minimizedBar.Position=UDim2.new(0,15,0,15)
        minimizedBar.BackgroundColor3=T.Bg
        minimizedBar.Text="⚡ TTHAIDZ  •  Click to open"
        minimizedBar.TextColor3=T.Accent
        minimizedBar.Font=T.FontBold
        minimizedBar.TextSize=12
        minimizedBar.AutoButtonColor=false
        minimizedBar.Parent=SG
        Instance.new("UICorner",minimizedBar).CornerRadius=UDim.new(0,10)
        local st=Instance.new("UIStroke",minimizedBar)
        st.Color=T.Accent; st.Thickness=1; st.Transparency=0.4
        minimizedBar.MouseButton1Click:Connect(function()
            if minimizedBar then minimizedBar:Destroy() end
            Main.Visible=true
            Main.Size=UDim2.new(0,200,0,40)
            Main.Position=UDim2.new(0,15,0,15)
            TS:Create(Main,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{
                Size=savedSize or UDim2.new(0,560,0,400),
                Position=savedPos or UDim2.new(0.5,-280,0.5,-200)
            }):Play()
            isMin=false
        end)
        Notify("Minimized","Click thanh nhỏ để mở lại",2)
    end
end)

BClose.MouseButton1Click:Connect(function()
    TS:Create(Main,TweenInfo.new(0.25),{
        Size=UDim2.new(0,0,0,0),
        Position=UDim2.new(0.5,0,0.5,0)
    }):Play()
    task.wait(0.3)
    Main.Visible=false
    local fb=Instance.new("TextButton")
    fb.Size=UDim2.new(0,60,0,60)
    fb.Position=UDim2.new(0,15,0,100)
    fb.BackgroundColor3=T.Bg
    fb.Text="⚡"
    fb.TextColor3=T.Accent
    fb.Font=T.FontBold
    fb.TextSize=24
    fb.AutoButtonColor=false
    fb.Parent=SG
    Instance.new("UICorner",fb).CornerRadius=UDim.new(0,16)
    local st=Instance.new("UIStroke",fb)
    st.Color=T.Accent; st.Thickness=1.5; st.Transparency=0.3
    fb.MouseButton1Click:Connect(function()
        fb:Destroy()
        Main.Visible=true
        Main.Size=UDim2.new(0,0,0,0)
        Main.Position=UDim2.new(0.5,0,0.5,0)
        TS:Create(Main,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{
            Size=UDim2.new(0,560,0,400),
            Position=UDim2.new(0.5,-280,0.5,-200)
        }):Play()
    end)
    Notify("Closed","Click ⚡ góc trái để mở lại",2)
end)

-- FOV DRAWING
local hasDraw=pcall(function() return Drawing end)
local FOVC
if hasDraw then
    FOVC=Drawing.new("Circle")
    FOVC.Thickness=2
    FOVC.NumSides=60
    FOVC.Radius=C.FOV
    FOVC.Filled=false
    FOVC.Color=T.Accent
    FOVC.Transparency=0.8
    FOVC.Visible=false
end

-- DETECTION
local function isTeam(p)
    if not C.TeamCheck then return false end
    if not p.Team or not LP.Team then return false end
    return p.Team==LP.Team
end
local function findChar(p)
    local c=p.Character
    if c and c:FindFirstChildOfClass("Humanoid") then return c end
    for _,o in ipairs(WS:GetChildren()) do
        if o:IsA("Model") then
            local h=o:FindFirstChildOfClass("Humanoid")
            if h and (o.Name==p.Name or o.Name==p.DisplayName) then return o end
        end
    end
    return nil
end
local function getAimPart(c)
    if not c then return nil end
    return c:FindFirstChild(C.AimPart) or c:FindFirstChild("Head") 
        or c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("UpperTorso") or c.PrimaryPart
end
local cached,lastScan=nil,0
local function getTarget()
    local now=tick()
    if now-lastScan<0.05 and cached and cached.Parent then return cached end
    lastScan=now
    local vp=Cam.ViewportSize
    local cx,cy=vp.X/2,vp.Y/2
    local best,bd=nil,C.FOV
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and not isTeam(p) then
            local c=findChar(p)
            if c then
                local h=c:FindFirstChildOfClass("Humanoid")
                if h and h.Health>0 then
                    local part=getAimPart(c)
                    if part then
                        local sp,on=Cam:WorldToViewportPoint(part.Position)
                        if on then
                            local d=math.sqrt((sp.X-cx)^2+(sp.Y-cy)^2)
                            if d<bd then bd=d; best=part end
                        end
                    end
                end
            end
        end
    end
    cached=best
    return best
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

-- ESP
local ED={}
local function G(p,t)
    if not hasDraw then return nil end
    if not ED[p] then ED[p]={} end
    if ED[p][t] then return ED[p][t] end
    local o
    if t=="box" then o=Drawing.new("Square"); o.Thickness=1; o.Filled=false; o.Transparency=1; o.Color=T.Danger
    elseif t=="hp" then o=Drawing.new("Square"); o.Thickness=0; o.Filled=true
    elseif t=="name" then o=Drawing.new("Text"); o.Size=13; o.Center=true; o.Outline=true; o.Color=Color3.new(1,1,1)
    elseif t=="dist" then o=Drawing.new("Text"); o.Size=12; o.Center=true; o.Outline=true; o.Color=Color3.fromRGB(200,200,200)
    elseif t=="tracer" then o=Drawing.new("Line"); o.Thickness=1; o.Color=T.Danger; o.Transparency=0.7 end
    ED[p][t]=o
    return o
end
local function ClrEsp(p)
    if ED[p] then
        for _,d in pairs(ED[p]) do if d.Remove then d:Remove() end end
        ED[p]=nil
    end
end

-- CHAMS
local chams={}
local function updChams()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and not isTeam(p) then
            local c=findChar(p)
            if c and C.ESP and C.ESPChams then
                if not chams[p] or chams[p].Parent~=c then
                    if chams[p] then chams[p]:Destroy() end
                    local h=Instance.new("Highlight")
                    h.FillColor=T.Danger
                    h.OutlineColor=Color3.fromRGB(255,255,255)
                    h.FillTransparency=0.5
                    h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
                    h.Parent=c
                    chams[p]=h
                end
            elseif chams[p] then chams[p]:Destroy(); chams[p]=nil end
        elseif chams[p] then chams[p]:Destroy(); chams[p]=nil end
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
    fbv=Instance.new("BodyVelocity",hrp)
    fbv.MaxForce=Vector3.new(1e5,1e5,1e5)
    fbv.Velocity=Vector3.zero
    fbg=Instance.new("BodyGyro",hrp)
    fbg.MaxTorque=Vector3.new(1e5,1e5,1e5)
    fbg.P=1000; fbg.D=50
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
local fr=0
RunService.RenderStepped:Connect(function()
    fr=fr+1
    local vp=Cam.ViewportSize
    local cx,cy=vp.X/2,vp.Y/2
    if hasDraw then
        FOVC.Visible=C.Aim
        FOVC.Position=Vector2.new(cx,cy)
        FOVC.Radius=C.FOV
    end
    if fr%3==0 and LP.Character then
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
            fbv.Velocity=dir*C.FlySpeed
            fbg.CFrame=Cam.CFrame
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
    if fr%2==0 and hasDraw then
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and not isTeam(p) then
                local c=findChar(p)
                if c and C.ESP then
                    local h=c:FindFirstChildOfClass("Humanoid")
                    local hrp=c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
                    local head=c:FindFirstChild("Head") or hrp
                    if h and h.Health>0 and hrp and head then
                        local tP,tO=Cam:WorldToViewportPoint(head.Position+Vector3.new(0,1,0))
                        local bP,bO=Cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,3,0))
                        if tO and bO then
                            local bh=math.abs(bP.Y-tP.Y)
                            local bw=bh*0.5
                            if C.ESPBox then
                                local b=G(p,"box")
                                b.Size=Vector2.new(bw,bh)
                                b.Position=Vector2.new(tP.X-bw/2,tP.Y)
                                b.Visible=true
                            else local b=G(p,"box"); if b then b.Visible=false end end
                            if C.ESPHealth then
                                local hp=G(p,"hp")
                                local r=h.Health/h.MaxHealth
                                hp.Size=Vector2.new(3,bh*r)
                                hp.Position=Vector2.new(tP.X-bw/2-6,tP.Y+bh*(1-r))
                                hp.Color=Color3.fromRGB(255*(1-r),255*r,0)
                                hp.Visible=true
                            else local hp=G(p,"hp"); if hp then hp.Visible=false end end
                            if C.ESPName then
                                local nm=G(p,"name")
                                nm.Text=p.Name
                                nm.Position=Vector2.new(tP.X,tP.Y-15)
                                nm.Visible=true
                            else local nm=G(p,"name"); if nm then nm.Visible=false end end
                            if C.ESPDistance then
                                local dm=G(p,"dist")
                                dm.Text="["..math.floor((Cam.CFrame.Position-hrp.Position).Magnitude).."m]"
                                dm.Position=Vector2.new(tP.X,bP.Y+3)
                                dm.Visible=true
                            else local dm=G(p,"dist"); if dm then dm.Visible=false end end
                            if C.ESPTracer then
                                local tr=G(p,"tracer")
                                tr.From=Vector2.new(cx,cy+30)
                                tr.To=Vector2.new(tP.X,tP.Y+bh/2)
                                tr.Visible=true
                            else local tr=G(p,"tracer"); if tr then tr.Visible=false end end
                        end
                    end
                else ClrEsp(p) end
            else ClrEsp(p) end
        end
    end
    if fr%10==0 then updChams() end
    if C.Aim and LP.Character then
        local t=getTarget()
        if t then
            local tCF=CFrame.new(Cam.CFrame.Position,t.Position)
            Cam.CFrame=Cam.CFrame:Lerp(tCF,C.Smooth)
        end
    end
end)

for _,p in ipairs(Players:GetPlayers()) do
    p.CharacterRemoving:Connect(function() ClrEsp(p) end)
end
Players.PlayerRemoving:Connect(function(p) ClrEsp(p) end)

task.wait(0.5)
Notify("Chào em nha","Tthaidz Cheat v7 đang tải",3)
print("[Tthaidz Cheat V7] Đã tải!")
