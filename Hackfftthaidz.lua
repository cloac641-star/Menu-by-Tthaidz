local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local WS=game:GetService("Workspace")
local Lighting=game:GetService("Lighting")
local Tween=game:GetService("TweenService")
local CoreGui=game:GetService("CoreGui")
local Http=game:GetService("HttpService")
local Cam=WS.CurrentCamera
local LP=Players.LocalPlayer

local S={
AimOn=false,AimKey=Enum.KeyCode.E,AimMode="Hold",AimPart="Head",
AimSmooth=0.18,AimFOV=120,TeamCheck=false,WallCheck=true,VisCheck=true,
Predict=0,ShowFOV=true,FOVRainbow=false,AimHeld=false,SnapShoot=true,SnapDur=0.12,SnapUntil=0,
EspOn=false,EspBox=false,EspName=true,EspDist=true,EspHP=true,EspTracer=false,
EspSkel=false,EspChams=false,EspArrow=false,EspPos="Top",
EspCol=Color3.fromRGB(255,255,255),EspRainbow=false,EspMax=1000,
AutoShot=false,TriggerBot=false,Magic=false,MagicRate=0.08,
SpeedOn=false,SpeedVal=32,JumpOn=false,JumpVal=80,InfJump=false,
FlyOn=false,FlySpd=60,Noclip=false,AntiFling=false,AntiVoid=false,Bunny=false,
FOVChg=false,FOVVal=90,FullBright=false,NoFog=false,RainbowChar=false,
WMOn=true,Notify=true,CurTarget=nil}
local CFG="oneshot_v7.json"
local function notify(t,x,d)
if not S.Notify then return end
pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title=t,Text=x,Duration=d or 3}) end)
end
local function getChar() return LP.Character or LP.CharacterAdded:Wait() end
local function getHum() local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid") end
local function isAlive(p)
local c=p and p.Character if not c then return false end
local h=c:FindFirstChildOfClass("Humanoid") return h and h.Health>0
end
local function isVis(part,ignore)
if not part then return false end
local o=Cam.CFrame.Position
local ig={LP.Character}
if ignore then for _,v in ipairs(ignore) do table.insert(ig,v) end end
local hit=WS:FindPartOnRayWithIgnoreList(Ray.new(o,part.Position-o),ig)
return hit==part or (hit and hit:IsDescendantOf(part.Parent))
end
local function rainbow(o) return Color3.fromHSV((tick()*0.5+(o or 0))%1,1,1) end
local Gui=Instance.new("ScreenGui")
Gui.Name="OneShotV7"
Gui.ResetOnSpawn=false
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
pcall(function() Gui.Parent=CoreGui end)
if not Gui.Parent then Gui.Parent=LP:WaitForChild("PlayerGui") end
local blur=Instance.new("BlurEffect") blur.Size=0 blur.Parent=Lighting

local Main=Instance.new("Frame")
Main.Size=UDim2.new(0,560,0,380)
Main.Position=UDim2.new(0.5,-280,0.5,-190)
Main.BackgroundColor3=Color3.fromRGB(18,18,22)
Main.BackgroundTransparency=0.05
Main.BorderSizePixel=0
Main.Active=true Main.Draggable=true Main.Parent=Gui
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,10)
local MS=Instance.new("UIStroke",Main) MS.Thickness=1.5 MS.Color=Color3.fromRGB(0,170,255) MS.Transparency=0.2
local Grad=Instance.new("UIGradient",Main) Grad.Rotation=45
Grad.Color=ColorSequence.new(Color3.fromRGB(0,170,255),Color3.fromRGB(180,0,255))

local Side=Instance.new("Frame")
Side.Size=UDim2.new(0,130,1,0)
Side.BackgroundColor3=Color3.fromRGB(25,25,30)
Side.BorderSizePixel=0 Side.Parent=Main
Instance.new("UICorner",Side).CornerRadius=UDim.new(0,10)

local Title=Instance.new("TextLabel")
Title.Size=UDim2.new(1,-10,0,40) Title.Position=UDim2.new(0,5,0,5)
Title.BackgroundTransparency=1 Title.Text="ONE SHOT v7"
Title.TextColor3=Color3.fromRGB(255,255,255) Title.Font=Enum.Font.GothamBold
Title.TextSize=18 Title.Parent=Side

local Content=Instance.new("Frame")
Content.Size=UDim2.new(1,-140,1,-20) Content.Position=UDim2.new(0,135,0,10)
Content.BackgroundTransparency=1 Content.Parent=Main

local Pages,CurPage={},nil
local function newPage(n)
local p=Instance.new("ScrollingFrame")
p.Size=UDim2.new(1,0,1,0) p.BackgroundTransparency=1 p.BorderSizePixel=0
p.ScrollBarThickness=4 p.ScrollBarImageColor3=Color3.fromRGB(0,170,255)
p.CanvasSize=UDim2.new(0,0,0,0) p.AutomaticCanvasSize=Enum.AutomaticSize.Y
p.Visible=false p.Parent=Content
local l=Instance.new("UIListLayout",p) l.Padding=UDim.new(0,6)
Pages[n]=p return p end
local function selPage(n) for k,v in pairs(Pages) do v.Visible=(k==n) end CurPage=n end

local tabs={}
local function makeTab(n,o)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-10,0,32) b.Position=UDim2.new(0,5,0,50+(o-1)*36)
b.BackgroundColor3=Color3.fromRGB(35,35,42) b.BorderSizePixel=0
b.Text=n b.TextColor3=Color3.fromRGB(200,200,200)
b.Font=Enum.Font.Gotham b.TextSize=14 b.Parent=Side
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
selPage(n)
for _,x in ipairs(tabs) do x.bg.BackgroundColor3=Color3.fromRGB(35,35,42) x.bg.TextColor3=Color3.fromRGB(200,200,200) end
b.BackgroundColor3=Color3.fromRGB(0,170,255) b.TextColor3=Color3.fromRGB(255,255,255)
end)
table.insert(tabs,{bg=b}) newPage(n) return b end

local function section(pg,t)
local l=Instance.new("TextLabel")
l.Size=UDim2.new(1,0,0,24) l.BackgroundTransparency=1 l.Text="  "..t
l.TextColor3=Color3.fromRGB(0,170,255) l.Font=Enum.Font.GothamBold
l.TextSize=13 l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=pg return l end

local function toggle(pg,t,d,cb)
local f=Instance.new("Frame") f.Size=UDim2.new(1,-10,0,30)
f.BackgroundColor3=Color3.fromRGB(28,28,34) f.BorderSizePixel=0 f.Parent=pg
Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local lb=Instance.new("TextLabel") lb.Size=UDim2.new(1,-60,1,0) lb.Position=UDim2.new(0,10,0,0)
lb.BackgroundTransparency=1 lb.Text=t lb.TextColor3=Color3.fromRGB(230,230,230)
lb.Font=Enum.Font.Gotham lb.TextSize=13 lb.TextXAlignment=Enum.TextXAlignment.Left lb.Parent=f
local b=Instance.new("TextButton") b.Size=UDim2.new(0,44,0,20) b.Position=UDim2.new(1,-52,0.5,-10)
b.BackgroundColor3=d and Color3.fromRGB(0,170,255) or Color3.fromRGB(50,50,58)
b.Text=d and "ON" or "OFF" b.TextColor3=Color3.fromRGB(255,255,255)
b.Font=Enum.Font.GothamBold b.TextSize=11 b.BorderSizePixel=0 b.Parent=f
Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)
local st=d b.MouseButton1Click:Connect(function()
st=not st b.BackgroundColor3=st and Color3.fromRGB(0,170,255) or Color3.fromRGB(50,50,58)
b.Text=st and "ON" or "OFF" cb(st) end) return f end

local function slider(pg,t,mn,mx,d,cb)
local f=Instance.new("Frame") f.Size=UDim2.new(1,-10,0,44)
f.BackgroundColor3=Color3.fromRGB(28,28,34) f.BorderSizePixel=0 f.Parent=pg
Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local lb=Instance.new("TextLabel") lb.Size=UDim2.new(1,-20,0,20) lb.Position=UDim2.new(0,10,0,2)
lb.BackgroundTransparency=1 lb.Text=t..": "..d lb.TextColor3=Color3.fromRGB(230,230,230)
lb.Font=Enum.Font.Gotham lb.TextSize=13 lb.TextXAlignment=Enum.TextXAlignment.Left lb.Parent=f
local bar=Instance.new("Frame") bar.Size=UDim2.new(1,-20,0,8) bar.Position=UDim2.new(0,10,0,28)
bar.BackgroundColor3=Color3.fromRGB(50,50,58) bar.BorderSizePixel=0 bar.Parent=f
Instance.new("UICorner",bar).CornerRadius=UDim.new(0,4)
local fill=Instance.new("Frame") fill.Size=UDim2.new((d-mn)/(mx-mn),0,1,0)
fill.BackgroundColor3=Color3.fromRGB(0,170,255) fill.BorderSizePixel=0 fill.Parent=bar
Instance.new("UICorner",fill).CornerRadius=UDim.new(0,4)
local drg=false
local function upd(x)
local r=math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
local v=math.floor(mn+r*(mx-mn)+0.5)
fill.Size=UDim2.new(r,0,1,0) lb.Text=t..": "..v cb(v) end
bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drg=true upd(i.Position.X) end end)
UIS.InputChanged:Connect(function(i) if drg and i.UserInputType==Enum.UserInputType.MouseMovement then upd(i.Position.X) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drg=false end end) return f end

local function dropdown(pg,t,opts,d,cb)
local f=Instance.new("Frame") f.Size=UDim2.new(1,-10,0,32)
f.BackgroundColor3=Color3.fromRGB(28,28,34) f.BorderSizePixel=0 f.Parent=pg
Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local b=Instance.new("TextButton") b.Size=UDim2.new(1,0,1,0) b.BackgroundTransparency=1
b.Text=t..": "..d b.TextColor3=Color3.fromRGB(230,230,230)
b.Font=Enum.Font.Gotham b.TextSize=13 b.TextXAlignment=Enum.TextXAlignment.Left b.Parent=f
local pad=Instance.new("UIPadding",b) pad.PaddingLeft=UDim.new(0,10)
local op=false
local ls=Instance.new("Frame") ls.Size=UDim2.new(1,0,0,#opts*26) ls.Position=UDim2.new(0,0,1,4)
ls.BackgroundColor3=Color3.fromRGB(22,22,28) ls.BorderSizePixel=0 ls.Visible=false
ls.ZIndex=5 ls.Parent=f
Instance.new("UICorner",ls).CornerRadius=UDim.new(0,6)
for i,o in ipairs(opts) do
local ob=Instance.new("TextButton") ob.Size=UDim2.new(1,0,0,26) ob.Position=UDim2.new(0,0,0,(i-1)*26)
ob.BackgroundTransparency=1 ob.Text=o ob.TextColor3=Color3.fromRGB(220,220,220)
ob.Font=Enum.Font.Gotham ob.TextSize=13 ob.Parent=ls
ob.MouseButton1Click:Connect(function()
b.Text=t..": "..o ls.Visible=false op=false cb(o) end) end
b.MouseButton1Click:Connect(function() op=not op ls.Visible=op end) return f end

local function button(pg,t,cb)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-10,0,32) b.BackgroundColor3=Color3.fromRGB(0,170,255)
b.Text=t b.TextColor3=Color3.fromRGB(255,255,255)
b.Font=Enum.Font.GothamBold b.TextSize=13 b.BorderSizePixel=0 b.Parent=pg
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(cb) return b end

local function keybind(pg,t,d,cb)
local f=Instance.new("Frame") f.Size=UDim2.new(1,-10,0,30)
f.BackgroundColor3=Color3.fromRGB(28,28,34) f.BorderSizePixel=0 f.Parent=pg
Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local lb=Instance.new("TextLabel") lb.Size=UDim2.new(1,-90,1,0) lb.Position=UDim2.new(0,10,0,0)
lb.BackgroundTransparency=1 lb.Text=t lb.TextColor3=Color3.fromRGB(230,230,230)
lb.Font=Enum.Font.Gotham lb.TextSize=13 lb.TextXAlignment=Enum.TextXAlignment.Left lb.Parent=f
local b=Instance.new("TextButton") b.Size=UDim2.new(0,80,0,22) b.Position=UDim2.new(1,-88,0.5,-11)
b.BackgroundColor3=Color3.fromRGB(50,50,58) b.Text=d.Name
b.TextColor3=Color3.fromRGB(255,255,255) b.Font=Enum.Font.Gotham b.TextSize=12
b.BorderSizePixel=0 b.Parent=f
Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)
local li=false b.MouseButton1Click:Connect(function() li=true b.Text="..." end)
UIS.InputBegan:Connect(function(i,gp)
if li and i.UserInputType==Enum.UserInputType.Keyboard then
b.Text=i.KeyCode.Name li=false cb(i.KeyCode) end end) return f end
makeTab("Aim",1) makeTab("ESP",2) makeTab("Movement",3)
makeTab("Combat",4) makeTab("Visual",5) makeTab("Config",6)
selPage("Aim")
tabs[1].bg.BackgroundColor3=Color3.fromRGB(0,170,255)
tabs[1].bg.TextColor3=Color3.fromRGB(255,255,255)

local AimP=Pages["Aim"]
section(AimP,"AIMBOT")
toggle(AimP,"Enable Aim",false,function(v) S.AimOn=v end)
keybind(AimP,"Aim Key",Enum.KeyCode.E,function(k) S.AimKey=k end)
dropdown(AimP,"Aim Mode",{"Hold","Toggle"},"Hold",function(v) S.AimMode=v end)
dropdown(AimP,"Aim Part",{"Head","Torso","Random","Nearest"},"Head",function(v) S.AimPart=v end)
slider(AimP,"Smooth x100",1,100,18,function(v) S.AimSmooth=v/100 end)
slider(AimP,"Aim FOV",20,500,120,function(v) S.AimFOV=v end)
toggle(AimP,"Team Check",false,function(v) S.TeamCheck=v end)
toggle(AimP,"Wall Check",true,function(v) S.WallCheck=v end)
toggle(AimP,"Visible Check",true,function(v) S.VisCheck=v end)
slider(AimP,"Prediction x100",0,50,0,function(v) S.Predict=v/100 end)
section(AimP,"SNAP AIM ON SHOOT")
toggle(AimP,"Snap on Shoot",true,function(v) S.SnapShoot=v end)
slider(AimP,"Snap Duration x10ms",5,50,12,function(v) S.SnapDur=v/100 end)
section(AimP,"FOV CIRCLE")
toggle(AimP,"Show FOV",true,function(v) S.ShowFOV=v end)
toggle(AimP,"Rainbow FOV",false,function(v) S.FOVRainbow=v end)

local Fov=Drawing.new("Circle")
Fov.Thickness=1.5 Fov.NumSides=64 Fov.Transparency=1 Fov.Filled=false Fov.Visible=false

local EspP=Pages["ESP"]
section(EspP,"ESP")
toggle(EspP,"Enable ESP",false,function(v) S.EspOn=v end)
toggle(EspP,"Box",false,function(v) S.EspBox=v end)
toggle(EspP,"Name",true,function(v) S.EspName=v end)
toggle(EspP,"Distance",true,function(v) S.EspDist=v end)
toggle(EspP,"Health Bar",true,function(v) S.EspHP=v end)
toggle(EspP,"Tracer",false,function(v) S.EspTracer=v end)
toggle(EspP,"Skeleton",false,function(v) S.EspSkel=v end)
toggle(EspP,"Chams",false,function(v) S.EspChams=v end)
toggle(EspP,"Off-screen Arrow",false,function(v) S.EspArrow=v end)
section(EspP,"STYLE")
dropdown(EspP,"Position",{"Top","Middle","Bottom"},"Top",function(v) S.EspPos=v end)
toggle(EspP,"Rainbow Color",false,function(v) S.EspRainbow=v end)
slider(EspP,"Max Distance",100,5000,1000,function(v) S.EspMax=v end)
local MvP=Pages["Movement"]
section(MvP,"SPEED")
toggle(MvP,"Enable Speed",false,function(v)
S.SpeedOn=v
if not v then local h=getHum() if h then h.WalkSpeed=16 end end end)
slider(MvP,"Speed Value",16,300,32,function(v)
S.SpeedVal=v
if S.SpeedOn then local h=getHum() if h then h.WalkSpeed=v end end end)
section(MvP,"JUMP")
toggle(MvP,"Jump Power",false,function(v)
S.JumpOn=v
local h=getHum() if h then h.UseJumpPower=true h.JumpPower=v and S.JumpVal or 50 end end)
slider(MvP,"Jump Value",50,500,80,function(v)
S.JumpVal=v
if S.JumpOn then local h=getHum() if h then h.JumpPower=v end end end)
toggle(MvP,"Infinite Jump",false,function(v) S.InfJump=v end)
section(MvP,"FLY")
toggle(MvP,"Enable Fly",false,function(v) S.FlyOn=v if not v then stopFly() end end)
slider(MvP,"Fly Speed",10,500,60,function(v) S.FlySpd=v end)
section(MvP,"OTHER")
toggle(MvP,"Noclip",false,function(v) S.Noclip=v end)
toggle(MvP,"Anti-Fling",false,function(v) S.AntiFling=v end)
toggle(MvP,"Anti-Void",false,function(v) S.AntiVoid=v end)
toggle(MvP,"Bunny Hop",false,function(v) S.Bunny=v end)

-- Fly logic (fixed)
local flyBV,flyBG,flyConn
local FK={W=false,A=false,S=false,D=false,SP=false,CT=false}
local function startFly()
local c=getChar()
local hrp=c:WaitForChild("HumanoidRootPart",5)
local hum=c:FindFirstChildOfClass("Humanoid")
if not hrp or not hum then return end
hum.PlatformStand=true
flyBV=Instance.new("BodyVelocity")
flyBV.Name="OneShotFly"
flyBV.MaxForce=Vector3.new(1e5,1e5,1e5)
flyBV.Velocity=Vector3.zero
flyBV.Parent=hrp
flyBG=Instance.new("BodyGyro")
flyBG.Name="OneShotGyro"
flyBG.MaxTorque=Vector3.new(1e5,1e5,1e5)
flyBG.P=1e4
flyBG.CFrame=hrp.CFrame
flyBG.Parent=hrp
if flyConn then flyConn:Disconnect() end
flyConn=RunService.RenderStepped:Connect(function()
if not S.FlyOn or not flyBV or not flyBV.Parent then return end
local cam=Cam.CFrame
local mv=Vector3.zero
if FK.W then mv=mv+cam.LookVector end
if FK.S then mv=mv-cam.LookVector end
if FK.A then mv=mv-cam.RightVector end
if FK.D then mv=mv+cam.RightVector end
if FK.SP then mv=mv+Vector3.new(0,1,0) end
if FK.CT then mv=mv-Vector3.new(0,1,0) end
if mv.Magnitude>0 then mv=mv.Unit*S.FlySpd end
flyBV.Velocity=mv
flyBG.CFrame=Cam.CFrame
end)
notify("Fly","Đã bật Fly")
end
function stopFly()
if flyConn then flyConn:Disconnect() flyConn=nil end
if flyBV then flyBV:Destroy() flyBV=nil end
if flyBG then flyBG:Destroy() flyBG=nil end
local hum=getHum() if hum then hum.PlatformStand=false end
end
UIS.InputBegan:Connect(function(i,gp)
if gp then return end
local k=i.KeyCode
if k==Enum.KeyCode.W then FK.W=true end
if k==Enum.KeyCode.A then FK.A=true end
if k==Enum.KeyCode.S then FK.S=true end
if k==Enum.KeyCode.D then FK.D=true end
if k==Enum.KeyCode.Space then FK.SP=true end
if k==Enum.KeyCode.LeftControl then FK.CT=true end
end)
UIS.InputEnded:Connect(function(i)
local k=i.KeyCode
if k==Enum.KeyCode.W then FK.W=false end
if k==Enum.KeyCode.A then FK.A=false end
if k==Enum.KeyCode.S then FK.S=false end
if k==Enum.KeyCode.D then FK.D=false end
if k==Enum.KeyCode.Space then FK.SP=false end
if k==Enum.KeyCode.LeftControl then FK.CT=false end
end)
local CbP=Pages["Combat"]
section(CbP,"AUTO SHOT")
toggle(CbP,"Auto Shot (RMB)",false,function(v) S.AutoShot=v end)
toggle(CbP,"Trigger Bot",false,function(v) S.TriggerBot=v end)
section(CbP,"MAGIC BULLET")
toggle(CbP,"Magic Bullet",false,function(v) S.Magic=v end)
slider(CbP,"Fire Rate x10ms",3,50,8,function(v) S.MagicRate=v/100 end)

-- Auto Shot: gửi tín hiệu chuột phải (MouseButton2) khi đã aim vào địch
local function sendMouse2()
pcall(function()
game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,2,true,game,1)
task.wait(0.05)
game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,2,false,game,1)
end)
end

-- Trigger Bot: bắn khi crosshair chạm địch (M1)
local function sendMouse1()
pcall(function()
game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,1,true,game,1)
task.wait(0.03)
game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,1,false,game,1)
end)
end

-- Tìm tool hiện tại
local function getTool()
local c=LP.Character if not c then return nil end
return c:FindFirstChildOfClass("Tool")
end

-- Fire tool theo cách an toàn
local function fireTool()
local t=getTool()
if t then pcall(function() t:Activate() end) end
end
local VsP=Pages["Visual"]
section(VsP,"CAMERA")
toggle(VsP,"FOV Changer",false,function(v)
S.FOVChg=v Cam.FieldOfView=v and S.FOVVal or 70 end)
slider(VsP,"FOV Value",70,120,90,function(v)
S.FOVVal=v if S.FOVChg then Cam.FieldOfView=v end end)
section(VsP,"LIGHTING")
toggle(VsP,"Full Bright",false,function(v)
S.FullBright=v
if v then Lighting.Brightness=3 Lighting.ClockTime=14
Lighting.Ambient=Color3.fromRGB(180,180,180)
Lighting.OutdoorAmbient=Color3.fromRGB(180,180,180)
else Lighting.Brightness=1 end end)
toggle(VsP,"No Fog",false,function(v)
S.NoFog=v Lighting.FogEnd=v and 1e6 or 100000 end)
section(VsP,"CHARACTER")
toggle(VsP,"Rainbow Character",false,function(v) S.RainbowChar=v end)
section(VsP,"UI")
toggle(VsP,"Watermark",true,function(v) S.WMOn=v WM.Visible=v end)
toggle(VsP,"Notifications",true,function(v) S.Notify=v end)

local CgP=Pages["Config"]
section(CgP,"SAVE / LOAD")
button(CgP,"Save Config",function()
local d={}
for k,v in pairs(S) do
if type(v)=="number" or type(v)=="boolean" or type(v)=="string" then d[k]=v end end
if writefile then writefile(CFG,Http:JSONEncode(d)) notify("Config","Đã lưu!") end end)
button(CgP,"Load Config",function()
if isfile and isfile(CFG) and readfile then
local ok,d=pcall(function() return Http:JSONDecode(readfile(CFG)) end)
if ok then for k,v in pairs(d) do S[k]=v end notify("Config","Đã load!") end end end)

local WM=Instance.new("TextLabel")
WM.Size=UDim2.new(0,220,0,26) WM.Position=UDim2.new(0,12,0,12)
WM.BackgroundColor3=Color3.fromRGB(15,15,20) WM.BackgroundTransparency=0.3
WM.TextColor3=Color3.fromRGB(0,170,255) WM.Font=Enum.Font.GothamBold
WM.TextSize=13 WM.Text="ONE SHOT v7" WM.Parent=Gui
Instance.new("UICorner",WM).CornerRadius=UDim.new(0,6)
local WMS=Instance.new("UIStroke",WM)
WMS.Color=Color3.fromRGB(0,170,255) WMS.Transparency=0.3
--===== ESP Storage =====
local EspData={}
local function newEsp(plr)
local bg=Instance.new("BillboardGui")
bg.Size=UDim2.new(0,200,0,80)
bg.AlwaysOnTop=true
bg.StudsOffsetWorldSpace=Vector3.new(0,3,0)
bg.Parent=Gui
local container=Instance.new("Frame",bg)
container.Size=UDim2.new(1,0,1,0)
container.BackgroundTransparency=1
local nameL=Instance.new("TextLabel",container)
nameL.Size=UDim2.new(1,0,0,18) nameL.Position=UDim2.new(0,0,0,0)
nameL.BackgroundTransparency=1 nameL.TextColor3=Color3.fromRGB(255,255,255)
nameL.Font=Enum.Font.GothamBold nameL.TextSize=13
nameL.TextStrokeTransparency=0 nameL.TextStrokeColor3=Color3.fromRGB(0,0,0)
local distL=Instance.new("TextLabel",container)
distL.Size=UDim2.new(1,0,0,14) distL.Position=UDim2.new(0,0,0,18)
distL.BackgroundTransparency=1 distL.TextColor3=Color3.fromRGB(255,255,255)
distL.Font=Enum.Font.Gotham distL.TextSize=11
distL.TextStrokeTransparency=0 distL.TextStrokeColor3=Color3.fromRGB(0,0,0)
local hpBG=Instance.new("Frame",container)
hpBG.Size=UDim2.new(0,60,0,5) hpBG.Position=UDim2.new(0.5,-30,0,34)
hpBG.BackgroundColor3=Color3.fromRGB(30,30,30) hpBG.BorderSizePixel=0
Instance.new("UICorner",hpBG).CornerRadius=UDim.new(0,2)
local hpFill=Instance.new("Frame",hpBG)
hpFill.Size=UDim2.new(1,0,1,0)
hpFill.BackgroundColor3=Color3.fromRGB(0,255,0)
hpFill.BorderSizePixel=0
Instance.new("UICorner",hpFill).CornerRadius=UDim.new(0,2)
local box=Instance.new("Frame",container)
box.Size=UDim2.new(0,50,0,60) box.Position=UDim2.new(0.5,-25,0,0)
box.BackgroundTransparency=1 box.BorderSizePixel=0 box.Visible=false
local boxSt=Instance.new("UIStroke",box) boxSt.Thickness=1 boxSt.Color=Color3.fromRGB(255,255,255)
local chams=Instance.new("Highlight")
chams.FillTransparency=1 chams.OutlineTransparency=1
chams.Parent=plr.Character or plr.CharacterAdded:Wait()
EspData[plr]={bg=bg,name=nameL,dist=distL,hp=hpFill,hpBG=hpBG,box=box,boxSt=boxSt,chams=chams}
end
local function delEsp(plr)
local d=EspData[plr]
if d then
if d.bg then d.bg:Destroy() end
if d.chams then d.chams:Destroy() end
EspData[plr]=nil end end

for _,p in ipairs(Players:GetPlayers()) do
if p~=LP then newEsp(p) end end
Players.PlayerAdded:Connect(function(p) if p~=LP then newEsp(p) end end)
Players.PlayerRemoving:Connect(delEsp)

--===== Target helpers =====
local function getTarget()
local best,bestDist=nil,math.huge
local camPos=Cam.CFrame.Position
local center=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2)
for _,p in ipairs(Players:GetPlayers()) do
if p~=LP and isAlive(p) then
local skip=false
if S.TeamCheck and p.Team==LP.Team then skip=true end
if not skip then
local char=p.Character
local hum=char:FindFirstChildOfClass("Humanoid")
if hum then
local part
if S.AimPart=="Head" then part=char:FindFirstChild("Head")
elseif S.AimPart=="Torso" then part=char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
elseif S.AimPart=="Random" then
local parts={char:FindFirstChild("Head"),char:FindFirstChild("Torso"),char:FindFirstChild("UpperTorso"),char:FindFirstChild("LowerTorso")}
part=parts[math.random(1,#parts)]
else part=char:FindFirstChild("Head") end
if part then
local sPos,onScreen=Cam:WorldToViewportPoint(part.Position)
if onScreen then
local d=(Vector2.new(sPos.X,sPos.Y)-center).Magnitude
if d<S.AimFOV and d<bestDist then
local ok=true
if S.WallCheck and not isVis(part,{char}) then ok=false end
if ok then best=part bestDist=d end
end end end end end end end
return best
end

--===== Input hook cho aim key =====
UIS.InputBegan:Connect(function(i,gp)
if gp then return end
if i.KeyCode==S.AimKey then
if S.AimMode=="Hold" then S.AimHeld=true
else S.AimHeld=not S.AimHeld end end
if i.UserInputType==Enum.UserInputType.MouseButton1 and S.SnapShoot then
S.SnapUntil=tick()+S.SnapDur end
end)
UIS.InputEnded:Connect(function(i)
if i.KeyCode==S.AimKey and S.AimMode=="Hold" then S.AimHeld=false end
end)

--===== Main Render Loop =====
local lastMagic=0
RunService.RenderStepped:Connect(function(dt)
--=== FOV circle ===
if S.ShowFOV and S.AimOn then
Fov.Visible=true
Fov.Position=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2)
Fov.Radius=S.AimFOV
if S.FOVRainbow then Fov.Color=rainbow() else Fov.Color=S.AimCol or Color3.fromRGB(0,170,255) end
else Fov.Visible=false end

--=== Aim ===
local target=getTarget()
S.CurTarget=target
local aiming=S.AimOn and (S.AimHeld or S.AimMode=="Toggle")
local snapping=tick()<S.SnapUntil
if target and (aiming or snapping) then
local aimPos=target.Position
if S.Predict>0 then
local vel=target.AssemblyLinearVelocity or Vector3.zero
aimPos=aimPos+vel*S.Predict end
local alpha=1-math.exp(-(1/math.max(S.AimSmooth,0.01))*dt*10)
local newCF=CFrame.new(Cam.CFrame.Position,aimPos)
Cam.CFrame=Cam.CFrame:Lerp(newCF,alpha)
end

--=== ESP ===
for plr,d in pairs(EspData) do
if not plr.Parent or not plr.Character or not isAlive(plr) or not S.EspOn then
d.bg.Enabled=false
if d.chams then d.chams.FillTransparency=1 d.chams.OutlineTransparency=1 end
else
local char=plr.Character
local head=char:FindFirstChild("Head")
local hrp=char:FindFirstChild("HumanoidRootPart")
local hum=char:FindFirstChildOfClass("Humanoid")
local dist=hrp and (Cam.CFrame.Position-hrp.Position).Magnitude or 0
if dist>S.EspMax or not head then d.bg.Enabled=false
else
d.bg.Enabled=true
local col=S.EspRainbow and rainbow() or S.EspCol
d.name.Visible=S.EspName
d.name.Text=plr.Name
d.name.TextColor3=col
d.dist.Visible=S.EspDist
d.dist.Text=math.floor(dist).." studs"
d.hpBG.Visible=S.EspHP
if hum then
local r=hum.Health/hum.MaxHealth
d.hp.Size=UDim2.new(r,0,1,0)
d.hp.BackgroundColor3=Color3.fromRGB(255*(1-r),255*r,0) end
d.box.Visible=S.EspBox
d.boxSt.Color=col
if S.EspPos=="Top" then d.bg.StudsOffsetWorldSpace=Vector3.new(0,3,0)
elseif S.EspPos=="Middle" then d.bg.StudsOffsetWorldSpace=Vector3.new(0,1.5,0)
else d.bg.StudsOffsetWorldSpace=Vector3.new(0,0,0) end
if d.chams then
if S.EspChams then
d.chams.FillColor=col d.chams.OutlineColor=col
d.chams.FillTransparency=0.5 d.chams.OutlineTransparency=0
else
d.chams.FillTransparency=1 d.chams.OutlineTransparency=1 end end
end end end

--=== Speed ===
if S.SpeedOn then
local h=getHum()
if h and h.WalkSpeed~=S.SpeedVal then h.WalkSpeed=S.SpeedVal end end
--=== Jump ===
if S.JumpOn then
local h=getHum()
if h and h.JumpPower~=S.JumpVal then h.UseJumpPower=true h.JumpPower=S.JumpVal end end
--=== Noclip ===
if S.Noclip then
local c=LP.Character
if c then for _,p in ipairs(c:GetDescendants()) do
if p:IsA("BasePart") and p.CanCollide then p.CanCollide=false end end end end

--=== Auto Shot ===
if S.AutoShot and target then sendMouse2() end
--=== Trigger Bot ===
if S.TriggerBot and target then
local cx=Cam.ViewportSize.X/2
local cy=Cam.ViewportSize.Y/2
local sPos=Cam:WorldToViewportPoint(target.Position)
if (Vector2.new(sPos.X,sPos.Y)-Vector2.new(cx,cy)).Magnitude<10 then sendMouse1() end end
--=== Magic Bullet ===
if S.Magic and target then
if tick()-lastMagic>S.MagicRate then
lastMagic=tick()
fireTool() end end
--=== Rainbow character ===
if S.RainbowChar then
local c=LP.Character
if c then for _,p in ipairs(c:GetDescendants()) do
if p:IsA("BasePart") then
pcall(function() p.Color=rainbow(0.1) end) end end end end
--=== Watermark update ===
if S.WMOn then
local fps=math.floor(1/math.max(dt,1e-4))
WM.Text=string.format("ONE SHOT v7 | %d FPS | Target: %s",fps,target and "YES" or "NO") end
end)

--===== Anti Void / Anti Fling / Bunny Hop / Inf Jump =====
RunService.Heartbeat:Connect(function()
local c=LP.Character
local hrp=c and c:FindFirstChild("HumanoidRootPart")
if hrp then
if S.AntiVoid and hrp.Position.Y<-100 then
hrp.CFrame=CFrame.new(0,50,0) end end
end)
UIS.JumpRequest:Connect(function()
if S.InfJump then
local h=getHum()
if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
if S.Bunny then
local h=getHum()
if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
end)

--===== Hotkey ẩn/hiện UI: RightShift =====
UIS.InputBegan:Connect(function(i,gp)
if gp then return end
if i.KeyCode==Enum.KeyCode.RightShift then
Main.Visible=not Main.Visible
Tween:Create(blur,TweenInfo.new(0.3),{Size=Main.Visible and 0 or 16}):Play()
end
end)

notify("One Shot v7","Script đã load! Nhấn RightShift để ẩn/hiện UI.")
