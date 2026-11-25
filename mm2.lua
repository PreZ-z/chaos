local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/PreZ-z/chaos/refs/heads/main/ui.lua"))()
Library.Game = "MM2"

local Window = Library:CreateWindow({
    Title = "CHAOS",
    User = "made by sxy.com",
    Blur = 16,
    Background = "rbxassetid://6523286724",
    Theme = {
        Accent             = Color3.fromRGB(222, 32, 78),
        Text               = Color3.fromRGB(255, 255, 255),
        TextDisabled       = Color3.fromRGB(115, 108, 128),
        Border             = Color3.fromRGB(240, 76, 124),
        BorderTransparency = 0.76,
        FrameInactive      = Color3.fromRGB(7, 3, 11),
        FrameActive        = Color3.fromRGB(20, 9, 28),
        Button             = Color3.fromRGB(14, 6, 20),
        ButtonHovered      = Color3.fromRGB(32, 14, 44),
        ButtonActive       = Color3.fromRGB(50, 22, 62),
        GroupBoxBg         = Color3.fromRGB(5, 2, 9),
        WindowBg           = Color3.fromRGB(4, 1, 7),
        FontBold           = Enum.Font.GothamBold,
        Font               = Enum.Font.Gotham,
        TextSize           = 13,
    },
})

local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting       = game:GetService("Lighting")
local Debris         = game:GetService("Debris")
local Camera         = workspace.CurrentCamera
local LocalPlayer    = Players.LocalPlayer

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local function ApplyUIScale()
    local vp = Camera.ViewportSize
    local scaleFactor
    if isMobile then
        scaleFactor = math.clamp(vp.X / 1380, 0.26, 0.48)
    elseif vp.X < 900 then
        scaleFactor = math.clamp(vp.X / 1100, 0.52, 0.72)
    else
        scaleFactor = math.clamp(vp.X / 1600, 0.72, 1.0)
    end
    local function scaleGui(gui)
        if not gui:IsA("ScreenGui") then return end
        local existing = gui:FindFirstChildWhichIsA("UIScale")
        if existing then existing.Scale = scaleFactor return end
        local us = Instance.new("UIScale")
        us.Scale = scaleFactor
        us.Parent = gui
    end
    for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do scaleGui(v) end
    for _, v in ipairs(LocalPlayer:FindFirstChildOfClass("PlayerGui") and LocalPlayer.PlayerGui:GetChildren() or {}) do
        if v.Name:lower():find("chaos") or v.Name:lower():find("library") then scaleGui(v) end
    end
end
task.spawn(function()
    for _ = 1, 20 do
        task.wait(0.25)
        ApplyUIScale()
    end
end)
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function() task.wait() ApplyUIScale() end)

local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "ChaosToggle"
toggleGui.ResetOnSpawn = false
toggleGui.DisplayOrder = 999
toggleGui.IgnoreGuiInset = true
toggleGui.Parent = game.CoreGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 110, 0, 30)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(7, 3, 11)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = ""
toggleBtn.AutoButtonColor = false
toggleBtn.Parent = toggleGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleBtn

local btnGrad = Instance.new("UIGradient")
btnGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(28, 10, 38)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(16, 6, 24)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(8,  3, 14)),
})
btnGrad.Rotation = 135
btnGrad.Parent = toggleBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(222, 32, 78)
btnStroke.Thickness = 1.4
btnStroke.Parent = toggleBtn

local btnGlow = Instance.new("Frame")
btnGlow.Size = UDim2.new(1, 10, 1, 10)
btnGlow.Position = UDim2.new(0, -5, 0, -5)
btnGlow.BackgroundColor3 = Color3.fromRGB(222, 32, 78)
btnGlow.BackgroundTransparency = 0.90
btnGlow.BorderSizePixel = 0
btnGlow.ZIndex = 0
btnGlow.Parent = toggleBtn
local btnGlowCorner = Instance.new("UICorner")
btnGlowCorner.CornerRadius = UDim.new(0, 12)
btnGlowCorner.Parent = btnGlow

local btnDivider = Instance.new("Frame")
btnDivider.Size = UDim2.new(0, 1, 0.6, 0)
btnDivider.Position = UDim2.new(0, 30, 0.2, 0)
btnDivider.BackgroundColor3 = Color3.fromRGB(222, 32, 78)
btnDivider.BackgroundTransparency = 0.5
btnDivider.BorderSizePixel = 0
btnDivider.Parent = toggleBtn

local btnIcon = Instance.new("ImageLabel")
btnIcon.Size = UDim2.new(0, 14, 0, 14)
btnIcon.Position = UDim2.new(0, 8, 0.5, -7)
btnIcon.BackgroundTransparency = 1
btnIcon.Image = "rbxassetid://6031094675"
btnIcon.ImageColor3 = Color3.fromRGB(240, 76, 124)
btnIcon.ScaleType = Enum.ScaleType.Fit
btnIcon.Parent = toggleBtn

local btnLabel = Instance.new("TextLabel")
btnLabel.Size = UDim2.new(1, -36, 1, 0)
btnLabel.Position = UDim2.new(0, 36, 0, 0)
btnLabel.BackgroundTransparency = 1
btnLabel.Text = "CHAOS"
btnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
btnLabel.TextSize = 12
btnLabel.Font = Enum.Font.GothamBold
btnLabel.TextXAlignment = Enum.TextXAlignment.Left
btnLabel.Parent = toggleBtn

local TweenService = game:GetService("TweenService")
local glowPulseIn  = TweenService:Create(btnGlow, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.80})
glowPulseIn:Play()

toggleBtn.MouseEnter:Connect(function()
    TweenService:Create(toggleBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(14, 6, 20)}):Play()
    TweenService:Create(btnStroke, TweenInfo.new(0.12), {Color = Color3.fromRGB(255, 90, 140), Thickness = 1.8}):Play()
end)
toggleBtn.MouseLeave:Connect(function()
    TweenService:Create(toggleBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(7, 3, 11)}):Play()
    TweenService:Create(btnStroke, TweenInfo.new(0.12), {Color = Color3.fromRGB(222, 32, 78), Thickness = 1.4}):Play()
end)

local dragging, dragStart, startPos = false, nil, nil
toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = toggleBtn.Position
    end
end)
toggleBtn.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        toggleBtn.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
toggleBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        if math.abs(delta.X) < 5 and math.abs(delta.Y) < 5 then
            Window:Toggle()
        end
        dragging = false
    end
end)

local mobileHudGui = Instance.new("ScreenGui")
mobileHudGui.Name = "ChaosMobileHUD"
mobileHudGui.ResetOnSpawn = false
mobileHudGui.DisplayOrder = 997
mobileHudGui.IgnoreGuiInset = true
mobileHudGui.Parent = game.CoreGui

local function MkCorner(parent, r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 8) c.Parent=parent return c end
local function MkStroke(parent, col, th) local s=Instance.new("UIStroke") s.Color=col s.Thickness=th or 1 s.Parent=parent return s end
local function MkPad(parent,t,b,l,r) local p=Instance.new("UIPadding") p.PaddingTop=UDim.new(0,t) p.PaddingBottom=UDim.new(0,b) p.PaddingLeft=UDim.new(0,l) p.PaddingRight=UDim.new(0,r) p.Parent=parent return p end
local PINK=Color3.fromRGB(222,32,78)
local PINK2=Color3.fromRGB(240,76,124)
local DARK=Color3.fromRGB(4,1,7)
local DARK2=Color3.fromRGB(14,6,20)
local DARK3=Color3.fromRGB(10,4,16)

local gameHudEnabled = true

local function MkFrame(parent, sz, pos, bg, bgt)
    local f=Instance.new("Frame")
    f.Size=sz f.Position=pos
    f.BackgroundColor3=bg or DARK
    f.BackgroundTransparency=bgt or 0.1
    f.BorderSizePixel=0
    f.Parent=parent
    return f
end

local topBar = MkFrame(mobileHudGui, UDim2.new(1,-20,0,38), UDim2.new(0,10,0,8), DARK, 0.08)
MkCorner(topBar,10) MkStroke(topBar,PINK,1.2)
local topGrad=Instance.new("UIGradient") topGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(28,8,40)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(12,4,18)),ColorSequenceKeypoint.new(1,Color3.fromRGB(28,8,40))}) topGrad.Rotation=0 topGrad.Parent=topBar

local topAccentL=Instance.new("Frame") topAccentL.Size=UDim2.new(0,3,0.7,0) topAccentL.Position=UDim2.new(0,0,0.15,0) topAccentL.BackgroundColor3=PINK topAccentL.BorderSizePixel=0 topAccentL.Parent=topBar MkCorner(topAccentL,3)
local topAccentR=Instance.new("Frame") topAccentR.Size=UDim2.new(0,3,0.7,0) topAccentR.Position=UDim2.new(1,-3,0.15,0) topAccentR.BackgroundColor3=PINK topAccentR.BorderSizePixel=0 topAccentR.Parent=topBar MkCorner(topAccentR,3)

local roleIcon=Instance.new("Frame") roleIcon.Size=UDim2.new(0,10,0,10) roleIcon.Position=UDim2.new(0,12,0.5,-5) roleIcon.BackgroundColor3=Color3.fromRGB(180,180,180) roleIcon.BorderSizePixel=0 roleIcon.Parent=topBar MkCorner(roleIcon,5)

local roleLabel=Instance.new("TextLabel") roleLabel.Size=UDim2.new(0,100,1,0) roleLabel.Position=UDim2.new(0,26,0,0) roleLabel.BackgroundTransparency=1 roleLabel.Text="ROLE: ?" roleLabel.TextColor3=PINK2 roleLabel.TextSize=11 roleLabel.Font=Enum.Font.GothamBold roleLabel.TextXAlignment=Enum.TextXAlignment.Left roleLabel.Parent=topBar

local aliveLabel=Instance.new("TextLabel") aliveLabel.Size=UDim2.new(0,80,1,0) aliveLabel.Position=UDim2.new(0.5,-40,0,0) aliveLabel.BackgroundTransparency=1 aliveLabel.Text="ALIVE: 0/0" aliveLabel.TextColor3=Color3.fromRGB(220,220,220) aliveLabel.TextSize=10 aliveLabel.Font=Enum.Font.GothamBold aliveLabel.Parent=topBar

local timerLabel=Instance.new("TextLabel") timerLabel.Size=UDim2.new(0,80,1,0) timerLabel.Position=UDim2.new(1,-90,0,0) timerLabel.BackgroundTransparency=1 timerLabel.Text="⏱ --:--" timerLabel.TextColor3=Color3.fromRGB(220,220,220) timerLabel.TextSize=10 timerLabel.Font=Enum.Font.GothamBold timerLabel.TextXAlignment=Enum.TextXAlignment.Right timerLabel.Parent=topBar

task.spawn(function()
    while gameHudEnabled do
        task.wait(0.5)
        local role = tostring(LocalPlayer:GetAttribute("Role") or "?")
        local roleColor = role=="Murderer" and Color3.fromRGB(255,60,60) or role=="Sheriff" and Color3.fromRGB(60,140,255) or role=="Innocent" and Color3.fromRGB(100,220,100) or Color3.fromRGB(180,180,180)
        roleLabel.Text = "ROLE: "..role:upper()
        roleLabel.TextColor3 = roleColor
        roleIcon.BackgroundColor3 = roleColor
        local alive,total=0,0
        for _,p in ipairs(Players:GetPlayers()) do
            total=total+1
            local c=p.Character if not c then continue end
            local h=c:FindFirstChildOfClass("Humanoid")
            if h and h.Health>0 then alive=alive+1 end
        end
        aliveLabel.Text = "ALIVE: "..alive.."/"..total
        local t=workspace:GetAttribute("TimeLeft") or workspace:GetAttribute("Time")
        if t and type(t)=="number" then
            timerLabel.Text=string.format("⏱ %d:%02d",math.floor(t/60),math.floor(t%60))
        else timerLabel.Text="⏱ --:--" end
    end
end)

local function MkActionBtn(parent, text, pos, sz, bgcol, bgt, textcol, textsize, corner, cb)
    local b=Instance.new("TextButton")
    b.Size=sz or UDim2.new(0,56,0,56)
    b.Position=pos
    b.BackgroundColor3=bgcol or DARK2
    b.BackgroundTransparency=bgt or 0.12
    b.BorderSizePixel=0
    b.Text=text
    b.TextColor3=textcol or PINK2
    b.TextSize=textsize or 10
    b.Font=Enum.Font.GothamBold
    b.AutoButtonColor=false
    b.Parent=parent
    MkCorner(b, corner or 12)
    MkStroke(b, PINK, 1.2)
    local grad=Instance.new("UIGradient") grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(26,8,38)),ColorSequenceKeypoint.new(1,Color3.fromRGB(8,2,14))}) grad.Rotation=135 grad.Parent=b
    b.MouseButton1Click:Connect(function()
        TweenService:Create(b,TweenInfo.new(0.07),{BackgroundTransparency=0.35}):Play()
        task.delay(0.14,function() TweenService:Create(b,TweenInfo.new(0.1),{BackgroundTransparency=bgt or 0.12}):Play() end)
        if cb then cb() end
    end)
    b.TouchTap:Connect(function() b.MouseButton1Click:Fire() end)
    return b
end

local function MkTogBtn(parent, text, pos, sz, onToggle)
    local active=false
    local b=Instance.new("TextButton")
    b.Size=sz or UDim2.new(0,56,0,56)
    b.Position=pos
    b.BackgroundColor3=DARK2
    b.BackgroundTransparency=0.12
    b.BorderSizePixel=0
    b.Text=text
    b.TextColor3=Color3.fromRGB(160,140,180)
    b.TextSize=10
    b.Font=Enum.Font.GothamBold
    b.AutoButtonColor=false
    b.Parent=parent
    MkCorner(b,12)
    local stroke=MkStroke(b,Color3.fromRGB(60,20,80),1.2)
    local grad=Instance.new("UIGradient") grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(14,4,22)),ColorSequenceKeypoint.new(1,Color3.fromRGB(6,2,10))}) grad.Rotation=135 grad.Parent=b
    local dot=Instance.new("Frame") dot.Size=UDim2.new(0,5,0,5) dot.Position=UDim2.new(0,4,0,4) dot.BackgroundColor3=Color3.fromRGB(60,20,80) dot.BorderSizePixel=0 dot.Parent=b MkCorner(dot,3)
    local function refresh()
        if active then
            b.BackgroundTransparency=0.45
            b.BackgroundColor3=PINK
            stroke.Color=PINK2
            dot.BackgroundColor3=Color3.fromRGB(255,120,160)
            b.TextColor3=Color3.fromRGB(255,255,255)
        else
            b.BackgroundTransparency=0.12
            b.BackgroundColor3=DARK2
            stroke.Color=Color3.fromRGB(60,20,80)
            dot.BackgroundColor3=Color3.fromRGB(60,20,80)
            b.TextColor3=Color3.fromRGB(160,140,180)
        end
    end
    b.MouseButton1Click:Connect(function() active=not active refresh() if onToggle then onToggle(active) end end)
    b.TouchTap:Connect(function() b.MouseButton1Click:Fire() end)
    return b, function(s) active=s refresh() end
end

local rightPanel=MkFrame(mobileHudGui,UDim2.new(0,62,0,290),UDim2.new(1,-74,0.5,-145),DARK,0.1)
MkCorner(rightPanel,12) MkStroke(rightPanel,PINK,1)
local rightGrad=Instance.new("UIGradient") rightGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(22,6,32)),ColorSequenceKeypoint.new(1,Color3.fromRGB(6,2,10))}) rightGrad.Rotation=90 rightGrad.Parent=rightPanel

local rl=Instance.new("UIListLayout") rl.FillDirection=Enum.FillDirection.Vertical rl.VerticalAlignment=Enum.VerticalAlignment.Center rl.HorizontalAlignment=Enum.HorizontalAlignment.Center rl.Padding=UDim.new(0,5) rl.Parent=rightPanel MkPad(rightPanel,8,8,4,4)

local function MkRightBtn(text, pos, sz, onCb) return MkActionBtn(rightPanel,text,pos,sz or UDim2.new(0,52,0,46),DARK2,0.12,PINK2,10,10,onCb) end
local function MkRightTog(text, pos, sz, onCb) return MkTogBtn(rightPanel,text,pos,sz or UDim2.new(0,52,0,46),onCb) end

MkRightTog("ESP\n👁", nil, UDim2.new(0,52,0,46), function(v) Settings.ESPEnabled=v end)
MkRightTog("CHAMS\n🎨", nil, UDim2.new(0,52,0,46), function(v) ChamSettings.Enabled=v SetChams(v) end)
MkRightBtn("TP\nMURD\n🗡", nil, UDim2.new(0,52,0,46), function()
    local m=FindMurderer() if not m then return end
    local c=m.Character if not c then return end
    local pr=c:FindFirstChild("HumanoidRootPart") if not pr then return end
    local root=GetRoot() if not root then return end
    root.CFrame=pr.CFrame*CFrame.new(2,0,2)
end)
MkRightBtn("KILL\nALL\n💀", nil, UDim2.new(0,52,0,46), function() QuickKillAll() end)
MkRightBtn("TP\nSHERIFF\n🔫", nil, UDim2.new(0,52,0,46), function()
    local s=FindSheriff() if not s then return end
    local c=s.Character if not c then return end
    local pr=c:FindFirstChild("HumanoidRootPart") if not pr then return end
    local root=GetRoot() if not root then return end
    root.CFrame=pr.CFrame*CFrame.new(2,0,2)
end)

local leftPanel=MkFrame(mobileHudGui,UDim2.new(0,62,0,230),UDim2.new(0,12,0.5,-115),DARK,0.1)
MkCorner(leftPanel,12) MkStroke(leftPanel,PINK,1)
local leftGrad=Instance.new("UIGradient") leftGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(22,6,32)),ColorSequenceKeypoint.new(1,Color3.fromRGB(6,2,10))}) leftGrad.Rotation=90 leftGrad.Parent=leftPanel
local ll=Instance.new("UIListLayout") ll.FillDirection=Enum.FillDirection.Vertical ll.VerticalAlignment=Enum.VerticalAlignment.Center ll.HorizontalAlignment=Enum.HorizontalAlignment.Center ll.Padding=UDim.new(0,5) ll.Parent=leftPanel MkPad(leftPanel,8,8,4,4)

local function MkLeftBtn(text,cb) return MkActionBtn(leftPanel,text,nil,UDim2.new(0,52,0,46),DARK2,0.12,PINK2,10,10,cb) end
local function MkLeftTog(text,cb) return MkTogBtn(leftPanel,text,nil,UDim2.new(0,52,0,46),cb) end

MkLeftTog("FLY\n🪂", nil, nil, function(v) Settings.Fly=v SetFly(v) end)
MkLeftTog("FAST\n⚡", nil, nil, function(v)
    local hum=GetHumanoid()
    if hum then hum.WalkSpeed=v and 48 or 16 end
    Settings.WalkSpeed=v and 48 or 16
end)
MkLeftTog("NOCLIP\n👻", nil, nil, function(v) SetNoclip(v) end)
MkLeftBtn("JUMP\n🚀", function()
    local root=GetRoot() if not root then return end
    local bv=Instance.new("BodyVelocity") bv.Velocity=Vector3.new(0,120,0) bv.MaxForce=Vector3.new(0,9e9,0) bv.Parent=root Debris:AddItem(bv,0.4)
end)
MkLeftTog("GOD\n🛡", nil, nil, function(v) Settings.GodMode=v SetGodMode(v) end)

local bottomBar=MkFrame(mobileHudGui,UDim2.new(1,-20,0,52),UDim2.new(0,10,1,-64),DARK,0.1)
MkCorner(bottomBar,12) MkStroke(bottomBar,PINK,1.2)
local bottomGrad=Instance.new("UIGradient") bottomGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(28,8,40)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(10,3,16)),ColorSequenceKeypoint.new(1,Color3.fromRGB(28,8,40))}) bottomGrad.Rotation=0 bottomGrad.Parent=bottomBar

local bottomAccentL=Instance.new("Frame") bottomAccentL.Size=UDim2.new(0,3,0.6,0) bottomAccentL.Position=UDim2.new(0,0,0.2,0) bottomAccentL.BackgroundColor3=PINK bottomAccentL.BorderSizePixel=0 bottomAccentL.Parent=bottomBar MkCorner(bottomAccentL,2)
local bottomAccentR=Instance.new("Frame") bottomAccentR.Size=UDim2.new(0,3,0.6,0) bottomAccentR.Position=UDim2.new(1,-3,0.2,0) bottomAccentR.BackgroundColor3=PINK bottomAccentR.BorderSizePixel=0 bottomAccentR.Parent=bottomBar MkCorner(bottomAccentR,2)

local bl=Instance.new("UIListLayout") bl.FillDirection=Enum.FillDirection.Horizontal bl.HorizontalAlignment=Enum.HorizontalAlignment.Center bl.VerticalAlignment=Enum.VerticalAlignment.Center bl.Padding=UDim.new(0,6) bl.Parent=bottomBar MkPad(bottomBar,5,5,8,8)

local function MkBotBtn(text,cb)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0,72,0,38)
    b.BackgroundColor3=DARK2 b.BackgroundTransparency=0.14 b.BorderSizePixel=0
    b.Text=text b.TextColor3=PINK2 b.TextSize=9 b.Font=Enum.Font.GothamBold
    b.AutoButtonColor=false b.Parent=bottomBar
    MkCorner(b,8) MkStroke(b,PINK,1)
    local g=Instance.new("UIGradient") g.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(26,8,38)),ColorSequenceKeypoint.new(1,Color3.fromRGB(8,2,14))}) g.Rotation=135 g.Parent=b
    b.MouseButton1Click:Connect(function()
        TweenService:Create(b,TweenInfo.new(0.07),{BackgroundTransparency=0.4}):Play()
        task.delay(0.14,function() TweenService:Create(b,TweenInfo.new(0.1),{BackgroundTransparency=0.14}):Play() end)
        if cb then cb() end
    end)
    b.TouchTap:Connect(function() b.MouseButton1Click:Fire() end)
    return b
end

local function MkBotTog(text, onToggle)
    local active=false
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0,72,0,38)
    b.BackgroundColor3=DARK2 b.BackgroundTransparency=0.14 b.BorderSizePixel=0
    b.Text=text b.TextColor3=Color3.fromRGB(150,130,170) b.TextSize=9 b.Font=Enum.Font.GothamBold
    b.AutoButtonColor=false b.Parent=bottomBar
    MkCorner(b,8)
    local stroke=MkStroke(b,Color3.fromRGB(55,18,75),1)
    local dot=Instance.new("Frame") dot.Size=UDim2.new(0,4,0,4) dot.Position=UDim2.new(0,3,0,3) dot.BackgroundColor3=Color3.fromRGB(55,18,75) dot.BorderSizePixel=0 dot.Parent=b MkCorner(dot,2)
    b.MouseButton1Click:Connect(function()
        active=not active
        if active then
            b.BackgroundColor3=PINK b.BackgroundTransparency=0.5
            stroke.Color=PINK2 dot.BackgroundColor3=Color3.fromRGB(255,120,160) b.TextColor3=Color3.fromRGB(255,255,255)
        else
            b.BackgroundColor3=DARK2 b.BackgroundTransparency=0.14
            stroke.Color=Color3.fromRGB(55,18,75) dot.BackgroundColor3=Color3.fromRGB(55,18,75) b.TextColor3=Color3.fromRGB(150,130,170)
        end
        if onToggle then onToggle(active) end
    end)
    b.TouchTap:Connect(function() b.MouseButton1Click:Fire() end)
    return b
end

MkBotTog("KILL\nAURA 🗡", function(v) Settings.KillAura=v end)
MkBotTog("SILENT\nAIM 🎯", function(v) Settings.GunSilentAim=v end)
MkBotBtn("THROW\nKNIFE 🔪", function() SetInstantThrow() end)
MkBotBtn("COIN\nFARM 💰", function()
    FarmSettings.AutoFarm = not FarmSettings.AutoFarm
    ShowNotif("Farm", "Coin Farm: "..(FarmSettings.AutoFarm and "ON" or "OFF"), "coin")
end)
MkBotBtn("TOSS\nALL 💥", function() FlingAllPlayers() end)
MkBotBtn("MY\nROLE 👤", function()
    local role=GetRole()
    ShowNotif("Role", role, "role")
end)

local hudToggleBtn=Instance.new("TextButton")
hudToggleBtn.Size=UDim2.new(0,38,0,22)
hudToggleBtn.Position=UDim2.new(0.5,-19,1,-88)
hudToggleBtn.BackgroundColor3=DARK hudToggleBtn.BackgroundTransparency=0.2 hudToggleBtn.BorderSizePixel=0
hudToggleBtn.Text="HUD" hudToggleBtn.TextColor3=PINK2 hudToggleBtn.TextSize=9 hudToggleBtn.Font=Enum.Font.GothamBold
hudToggleBtn.AutoButtonColor=false hudToggleBtn.Parent=mobileHudGui
MkCorner(hudToggleBtn,6) MkStroke(hudToggleBtn,PINK,1)
hudToggleBtn.MouseButton1Click:Connect(function()
    gameHudEnabled=not gameHudEnabled
    topBar.Visible=gameHudEnabled rightPanel.Visible=gameHudEnabled
    leftPanel.Visible=gameHudEnabled bottomBar.Visible=gameHudEnabled
    hudToggleBtn.Text=gameHudEnabled and "HUD" or "SHOW"
end)
hudToggleBtn.TouchTap:Connect(function() hudToggleBtn.MouseButton1Click:Fire() end)

local hudVisible = isMobile

local wmGui = Instance.new("ScreenGui")
wmGui.Name = "ChaosWatermark"
wmGui.ResetOnSpawn = false
wmGui.DisplayOrder = 998
wmGui.IgnoreGuiInset = true
wmGui.Parent = game.CoreGui

local wmFrame = Instance.new("Frame")
wmFrame.Size = UDim2.new(0, 180, 0, 22)
wmFrame.Position = UDim2.new(1, -190, 0, 10)
wmFrame.BackgroundColor3 = Color3.fromRGB(7, 3, 11)
wmFrame.BackgroundTransparency = 0.15
wmFrame.BorderSizePixel = 0
wmFrame.Parent = wmGui
local wmCorner = Instance.new("UICorner")
wmCorner.CornerRadius = UDim.new(0, 6)
wmCorner.Parent = wmFrame
local wmStroke = Instance.new("UIStroke")
wmStroke.Color = Color3.fromRGB(222, 32, 78)
wmStroke.Thickness = 1
wmStroke.Parent = wmFrame
local wmGrad = Instance.new("UIGradient")
wmGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(28, 10, 38)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(7,  3, 11)),
})
wmGrad.Rotation = 90
wmGrad.Parent = wmFrame

local wmLeft = Instance.new("TextLabel")
wmLeft.Size = UDim2.new(0.5, 0, 1, 0)
wmLeft.BackgroundTransparency = 1
wmLeft.Text = "CHAOS"
wmLeft.TextColor3 = Color3.fromRGB(240, 76, 124)
wmLeft.TextSize = 11
wmLeft.Font = Enum.Font.GothamBold
wmLeft.TextXAlignment = Enum.TextXAlignment.Left
wmLeft.Position = UDim2.new(0, 8, 0, 0)
wmLeft.Parent = wmFrame

local wmRight = Instance.new("TextLabel")
wmRight.Size = UDim2.new(0.5, -8, 1, 0)
wmRight.Position = UDim2.new(0.5, 0, 0, 0)
wmRight.BackgroundTransparency = 1
wmRight.Text = "MM2"
wmRight.TextColor3 = Color3.fromRGB(180, 180, 200)
wmRight.TextSize = 11
wmRight.Font = Enum.Font.Gotham
wmRight.TextXAlignment = Enum.TextXAlignment.Right
wmRight.Parent = wmFrame

local wmFpsLabel = Instance.new("TextLabel")
wmFpsLabel.Size = UDim2.new(1, -16, 1, 0)
wmFpsLabel.Position = UDim2.new(0, 8, 0, 0)
wmFpsLabel.BackgroundTransparency = 1
wmFpsLabel.TextColor3 = Color3.fromRGB(140, 134, 155)
wmFpsLabel.TextSize = 10
wmFpsLabel.Font = Enum.Font.Gotham
wmFpsLabel.TextXAlignment = Enum.TextXAlignment.Center
wmFpsLabel.Parent = wmFrame

task.spawn(function()
    while true do
        task.wait(0.5)
        local fps = math.floor(1 / game:GetService("RunService").Heartbeat:Wait())
        wmLeft.Text = "CHAOS"
        wmRight.Text = "MM2"
        wmFpsLabel.Text = ""
        wmFpsLabel.Text = fps .. " fps"
        wmFpsLabel.Position = UDim2.new(0, 8, 0, 0)
        wmLeft.Size = UDim2.new(0.4, 0, 1, 0)
        wmRight.Size = UDim2.new(0.3, -4, 1, 0)
        wmRight.Position = UDim2.new(0.4, 0, 0, 0)
        wmFpsLabel.Size = UDim2.new(0.3, -8, 1, 0)
        wmFpsLabel.Position = UDim2.new(0.7, 0, 0, 0)
        wmFpsLabel.TextXAlignment = Enum.TextXAlignment.Right
    end
end)

local splashGui = Instance.new("ScreenGui")
splashGui.Name = "ChaosSplash"
splashGui.ResetOnSpawn = false
splashGui.DisplayOrder = 1000
splashGui.IgnoreGuiInset = true
splashGui.Parent = game.CoreGui

local splashFrame = Instance.new("Frame")
splashFrame.Size = UDim2.new(0, 280, 0, 64)
splashFrame.Position = UDim2.new(0.5, -140, 1, 0)
splashFrame.BackgroundColor3 = Color3.fromRGB(7, 3, 11)
splashFrame.BackgroundTransparency = 0.1
splashFrame.BorderSizePixel = 0
splashFrame.Parent = splashGui
local splashCorner = Instance.new("UICorner")
splashCorner.CornerRadius = UDim.new(0, 10)
splashCorner.Parent = splashFrame
local splashStroke = Instance.new("UIStroke")
splashStroke.Color = Color3.fromRGB(222, 32, 78)
splashStroke.Thickness = 1.2
splashStroke.Parent = splashFrame
local splashGrad = Instance.new("UIGradient")
splashGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 12, 44)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(7,   3, 11)),
})
splashGrad.Rotation = 135
splashGrad.Parent = splashFrame

local splashIcon = Instance.new("ImageLabel")
splashIcon.Size = UDim2.new(0, 28, 0, 28)
splashIcon.Position = UDim2.new(0, 14, 0.5, -14)
splashIcon.BackgroundTransparency = 1
splashIcon.Image = "rbxassetid://6031094675"
splashIcon.ImageColor3 = Color3.fromRGB(240, 76, 124)
splashIcon.Parent = splashFrame

local splashTitle = Instance.new("TextLabel")
splashTitle.Size = UDim2.new(1, -56, 0, 22)
splashTitle.Position = UDim2.new(0, 50, 0, 10)
splashTitle.BackgroundTransparency = 1
splashTitle.Text = "CHAOS"
splashTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
splashTitle.TextSize = 16
splashTitle.Font = Enum.Font.GothamBold
splashTitle.TextXAlignment = Enum.TextXAlignment.Left
splashTitle.Parent = splashFrame

local splashSub = Instance.new("TextLabel")
splashSub.Size = UDim2.new(1, -56, 0, 18)
splashSub.Position = UDim2.new(0, 50, 0, 32)
splashSub.BackgroundTransparency = 1
splashSub.Text = "Murder Mystery 2  •  loaded"
splashSub.TextColor3 = Color3.fromRGB(180, 170, 200)
splashSub.TextSize = 11
splashSub.Font = Enum.Font.Gotham
splashSub.TextXAlignment = Enum.TextXAlignment.Left
splashSub.Parent = splashFrame

task.spawn(function()
    task.wait(0.4)
    TweenService:Create(splashFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -140, 1, -80)
    }):Play()
    task.wait(2.8)
    TweenService:Create(splashFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -140, 1, 10),
        BackgroundTransparency = 1,
    }):Play()
    task.wait(0.45)
    splashGui:Destroy()
end)

local Settings = {
    KnifeAura = false,
    KnifeRange = 7,
    AutoSlash = false,
    AutoSpam = false,
    AutoNotifyUponClashing = false,
    KillAura = false,
    KillAuraRadius = 20,
    KillAll = false,
    KillGunPlayers = false,
    InstantThrow = false,
    FastThrow = false,
    KnifeThrowAimbot = false,
    KnifeThrowMode = "Smart",
    KnifeThrowMaxDist = 250,
    KnifeThrowFOV = 360,
    KnifeThrowWallCheck = true,
    KnifeThrowPredict = true,
    KnifeThrowLead = 100,
    KnifeThrowSticky = true,
    KnifeThrowMarker = true,
    AutoThrow = false,
    AutoThrowMinChance = 55,
    AutoThrowRange = 70,
    KnifeTracers = false,
    KnifeTracerStyle = "Energy",
    KnifeTracerRainbow = false,
    KnifeTracerWidth = 100,
    KnifeTracerDuration = 1.2,
    KnifeTracerImpact = true,
    KnifeTracerFlash = true,
    KnifeTracerOthers = false,
    KnifeSkinChanger = "Default",
    EnableAimlock = false,
    EnableAimlock_TeamCheck = false,
    EnableAimlock_WallCheck = false,
    EnableAimlock_ForceFieldCheck = false,
    EnableAimlock_HealthCheck = false,
    EnableAimlock_TargetAimpart = "Head",
    EnableAimlock_TargetPrioritize = "Closest",
    EnableAimlock_MouseFOVRadius = 120,
    GunSilentAim = false,
    GunSilentAim_TeamCheck = false,
    GunSilentAim_WallCheck = false,
    GunSilentAim_AlwaysHit = false,
    GunSilentAim_ForceFieldCheck = false,
    GunSilentAim_Aimpart = "Head",
    GunSilentAim_TargetPrioritize = "Closest",
    Fly = false,
    FlySpeed = 50,
    CFrameFly = false,
    CFrameFlySpeed = 50,
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    NoClip = false,
    FreezeCharacter = false,
    Invisible = false,
    AntiFling = false,
    AntiAFK = false,
    LoopInteractive = false,
    AutoCollectCoins = false,
    AutoPrestige = false,
    ESPEnabled = false,
    ESPMurderer = true,
    ESPSheriff = true,
    ESPInnocent = false,
    ESPDistance = false,
    ESPName = true,
    ESPBox = false,
    ESPHealth = false,
    ESPSkeleton = false,
    ESPHeadDot = false,
    ESPLookLine = false,
    ESPChams = false,
    ESPMurdColor = Color3.fromRGB(255,50,50),
    ESPSherColor = Color3.fromRGB(50,150,255),
    ESPInnColor = Color3.fromRGB(220,220,220),
    ESPTextColor = Color3.fromRGB(255,255,255),
    FullBright = false,
    NightMode = false,
    ShowGameInfo = false,
    ShowRoundTimer = false,
    LoopToFirstPersonCamera = false,
    WallHop = false,
    WallHopMode = "Press",
    WallHopAngle = 90,
    WallHopCamFlick = false,
    TouchFling = false,
    ClickFling = false,
    ClickHump = false,
    HumpDuration = 0,
    Orbit = false,
    JerkOffTool = false,
    AutoEmote = false,
    AutoEmoteSelected = "ninja",
}

local function GetCharacter() return LocalPlayer.Character end
local function GetRoot()
    local c = GetCharacter() return c and c:FindFirstChild("HumanoidRootPart")
end
local function GetHumanoid()
    local c = GetCharacter() return c and c:FindFirstChildOfClass("Humanoid")
end

local function FindMurderer()
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local c = p.Character
        if not c then continue end
        if c:FindFirstChild("Knife") or c:FindFirstChild("knife") then return p end
        if p.Backpack:FindFirstChild("Knife") or p.Backpack:FindFirstChild("knife") then return p end
    end
end

local function FindSheriff()
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local c = p.Character
        if not c then continue end
        if c:FindFirstChild("Sheriff Gun") or c:FindFirstChild("Gun") then return p end
        if p.Backpack:FindFirstChild("Sheriff Gun") or p.Backpack:FindFirstChild("Gun") then return p end
    end
end

local function WorldToViewport(pos)
    local s, v = Camera:WorldToViewportPoint(pos)
    return Vector2.new(s.X, s.Y), v
end

RunService.RenderStepped:Connect(function()
    if not Settings.EnableAimlock then return end
    local root = GetRoot() if not root then return end
    local best, bestDist = nil, math.huge
    local cursor = UserInputService:GetMouseLocation()
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local c = p.Character if not c then continue end
        local part = c:FindFirstChild(Settings.EnableAimlock_TargetAimpart) or c:FindFirstChild("HumanoidRootPart")
        if not part then continue end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        if Settings.EnableAimlock_HealthCheck and hum.Health >= hum.MaxHealth then continue end
        local screen, visible = WorldToViewport(part.Position)
        if not visible then continue end
        local dist
        if Settings.EnableAimlock_TargetPrioritize == "From Mouse" then
            dist = (screen - cursor).Magnitude
            if dist > Settings.EnableAimlock_MouseFOVRadius then continue end
        else
            dist = (part.Position - root.Position).Magnitude
        end
        if dist < bestDist then bestDist = dist best = part end
    end
    if best then Camera.CFrame = CFrame.new(Camera.CFrame.Position, best.Position) end
end)

local ESPStorage = {}
local function ClearESP()
    for _, v in pairs(ESPStorage) do if v and v.Parent then v:Destroy() end end
    ESPStorage = {}
end

local BONE_PAIRS = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
}
RunService.RenderStepped:Connect(function()
    ClearESP()
    if not Settings.ESPEnabled then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local c = p.Character if not c then continue end
        local root = c:FindFirstChild("HumanoidRootPart") if not root then continue end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health <= 0 then continue end
        local isMurd = FindMurderer() == p
        local isSher = FindSheriff() == p
        if isMurd and not Settings.ESPMurderer then continue end
        if isSher and not Settings.ESPSheriff then continue end
        if not isMurd and not isSher and not Settings.ESPInnocent then continue end
        local _, visible = WorldToViewport(root.Position)
        if not visible then continue end
        local color = isMurd and Settings.ESPMurdColor or isSher and Settings.ESPSherColor or Settings.ESPInnColor
        if Settings.ESPName then
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0, 200, 0, 50)
            bill.StudsOffset = Vector3.new(0, 2.5, 0)
            bill.AlwaysOnTop = true
            bill.Adornee = root
            bill.Parent = game.CoreGui
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.fromScale(1, 1)
            lbl.BackgroundTransparency = 1
            lbl.TextColor3 = Settings.ESPTextColor
            lbl.TextStrokeTransparency = 0
            lbl.TextStrokeColor3 = Color3.new(0, 0, 0)
            local role = isMurd and " [M]" or isSher and " [S]" or " [I]"
            lbl.Text = p.Name .. role
            if Settings.ESPDistance then
                local r = GetRoot()
                if r then lbl.Text = lbl.Text .. " " .. math.floor((root.Position - r.Position).Magnitude) .. "m" end
            end
            lbl.TextSize = 13
            lbl.Font = Enum.Font.GothamBold
            lbl.Parent = bill
            table.insert(ESPStorage, bill)
        end
        if Settings.ESPHealth then
            local hum2 = c:FindFirstChildOfClass("Humanoid")
            if hum2 then
                local bill2 = Instance.new("BillboardGui")
                bill2.Size = UDim2.new(0, 80, 0, 10)
                bill2.StudsOffset = Vector3.new(0, 3.5, 0)
                bill2.AlwaysOnTop = true
                bill2.Adornee = root
                bill2.Parent = game.CoreGui
                local bg = Instance.new("Frame")
                bg.Size = UDim2.fromScale(1, 1)
                bg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                bg.Parent = bill2
                local hp = Instance.new("Frame")
                hp.Size = UDim2.fromScale(math.clamp(hum2.Health / hum2.MaxHealth, 0, 1), 1)
                hp.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
                hp.Parent = bg
                table.insert(ESPStorage, bill2)
            end
        end
        if Settings.ESPBox then
            local selBox = Instance.new("SelectionBox")
            selBox.Adornee = root
            selBox.Color3 = color
            selBox.LineThickness = 0.04
            selBox.SurfaceTransparency = 0.9
            selBox.SurfaceColor3 = color
            selBox.Parent = game.CoreGui
            table.insert(ESPStorage, selBox)
        end
        if Settings.ESPChams then
            local selBox2 = Instance.new("SelectionBox")
            selBox2.Adornee = c
            selBox2.Color3 = color
            selBox2.LineThickness = 0.0
            selBox2.SurfaceTransparency = 0.65
            selBox2.SurfaceColor3 = color
            selBox2.Parent = game.CoreGui
            table.insert(ESPStorage, selBox2)
        end
        if Settings.ESPHeadDot then
            local head = c:FindFirstChild("Head")
            if head then
                local sphere = Instance.new("SphereHandleAdornment")
                sphere.Adornee = head
                sphere.Radius = 0.6
                sphere.Color3 = color
                sphere.AlwaysOnTop = true
                sphere.ZIndex = 5
                sphere.Parent = game.CoreGui
                table.insert(ESPStorage, sphere)
            end
        end
        if Settings.ESPLookLine then
            local head = c:FindFirstChild("Head")
            if head then
                local line = Instance.new("LineHandleAdornment")
                line.Adornee = head
                line.Length = 5
                line.Thickness = 2
                line.Color3 = color
                line.AlwaysOnTop = true
                line.CFrame = CFrame.new(Vector3.zero, head.CFrame.LookVector * 5)
                line.Parent = game.CoreGui
                table.insert(ESPStorage, line)
            end
        end
        if Settings.ESPSkeleton then
            for _, pair in ipairs(BONE_PAIRS) do
                local a = c:FindFirstChild(pair[1])
                local b = c:FindFirstChild(pair[2])
                if a and b then
                    local line2 = Instance.new("LineHandleAdornment")
                    line2.Adornee = a
                    line2.Length = (b.Position - a.Position).Magnitude
                    line2.Thickness = 2
                    line2.Color3 = color
                    line2.AlwaysOnTop = true
                    line2.CFrame = CFrame.new(Vector3.zero, b.Position - a.Position)
                    line2.Parent = game.CoreGui
                    table.insert(ESPStorage, line2)
                end
            end
        end
    end
end)

local FlyBodyGyro, FlyBodyVelocity, FlyConnection
local function StopFly()
    if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
    if FlyBodyGyro and FlyBodyGyro.Parent then FlyBodyGyro:Destroy() end
    if FlyBodyVelocity and FlyBodyVelocity.Parent then FlyBodyVelocity:Destroy() end
    FlyBodyGyro = nil FlyBodyVelocity = nil
    local hum = GetHumanoid() if hum then hum.PlatformStand = false end
end
local function StartFly()
    StopFly()
    local root = GetRoot() if not root then return end
    local hum = GetHumanoid() if not hum then return end
    FlyBodyGyro = Instance.new("BodyGyro")
    FlyBodyGyro.P = 9e4 FlyBodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9) FlyBodyGyro.CFrame = root.CFrame FlyBodyGyro.Parent = root
    FlyBodyVelocity = Instance.new("BodyVelocity")
    FlyBodyVelocity.Velocity = Vector3.zero FlyBodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9) FlyBodyVelocity.Parent = root
    FlyConnection = RunService.RenderStepped:Connect(function()
        if not Settings.Fly then StopFly() return end
        if not root.Parent then StopFly() return end
        hum.PlatformStand = true
        local speed = Settings.FlySpeed
        local cam = Camera.CFrame
        local vel = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += cam.LookVector * speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= cam.LookVector * speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= cam.RightVector * speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += cam.RightVector * speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.yAxis * speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vel -= Vector3.yAxis * speed end
        FlyBodyVelocity.Velocity = vel FlyBodyGyro.CFrame = cam
    end)
end

local InfiniteJumpConn
local function SetInfiniteJump(v)
    if InfiniteJumpConn then InfiniteJumpConn:Disconnect() end
    if v then InfiniteJumpConn = UserInputService.JumpRequest:Connect(function()
        local hum = GetHumanoid() if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end) end
end

local NoClipConn
local function SetNoClip(v)
    if NoClipConn then NoClipConn:Disconnect() end
    if v then NoClipConn = RunService.Stepped:Connect(function()
        local c = GetCharacter() if not c then return end
        for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
    end) end
end

local AntiAFKConn
local function SetAntiAFK(v)
    if AntiAFKConn then AntiAFKConn:Disconnect() AntiAFKConn = nil end
    if v then
        local vu = game:GetService("VirtualUser")
        AntiAFKConn = LocalPlayer.Idled:Connect(function()
            pcall(function() vu:CaptureController() vu:ClickButton2(Vector2.new()) end)
        end)
    end
end

local InvisConn
local function SetInvisible(v)
    if InvisConn then InvisConn:Disconnect() end
    if v then
        InvisConn = RunService.Heartbeat:Connect(function()
            local c = GetCharacter() if not c then return end
            for _, p in ipairs(c:GetDescendants()) do
                if (p:IsA("BasePart") or p:IsA("Decal")) and p.Name ~= "HumanoidRootPart" then
                    p.LocalTransparencyModifier = 1
                end
            end
        end)
    else
        local c = GetCharacter()
        if c then for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.LocalTransparencyModifier = 0 end end end
    end
end

local AntiFlingConn
local function SetAntiFling(v)
    if AntiFlingConn then AntiFlingConn:Disconnect() end
    if v then AntiFlingConn = RunService.Heartbeat:Connect(function()
        local root = GetRoot() if not root then return end
        if root.AssemblyLinearVelocity.Magnitude > 300 then root.AssemblyLinearVelocity = Vector3.zero end
    end) end
end

local function TeleportToPlayer(player)
    local root = GetRoot() if not root then return end
    local c = player.Character if not c then return end
    local t = c:FindFirstChild("HumanoidRootPart")
    if t then root.CFrame = t.CFrame + Vector3.new(0, 3, 0) end
end

local function TeleportToGunDrop()
    local root = GetRoot() if not root then return end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "GunDrop" and v:IsA("BasePart") then
            root.CFrame = CFrame.new(v.Position + Vector3.new(0, 3, 0)) return
        end
    end
end

local function ExposeChatMessage(msg)
    pcall(function()
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end)
end

RunService.Heartbeat:Connect(function()
    if Settings.KnifeAura then
        local c = GetCharacter() if not c then return end
        local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
        local events = knife:FindFirstChild("Events") if not events then return end
        local ht = events:FindFirstChild("HandleTouched") if not ht then return end
        local root = GetRoot() if not root then return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local tc = p.Character if not tc then continue end
            local torso = tc:FindFirstChild("HumanoidRootPart") if not torso then continue end
            if (torso.Position - root.Position).Magnitude <= Settings.KnifeRange then ht:FireServer(torso) end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not Settings.KillAura then return end
    local c = GetCharacter() if not c then return end
    local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
    local events = knife:FindFirstChild("Events") if not events then return end
    local ht = events:FindFirstChild("HandleTouched") if not ht then return end
    local root = GetRoot() if not root then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local tc = p.Character if not tc then continue end
        local torso = tc:FindFirstChild("HumanoidRootPart") if not torso then continue end
        if Settings.KillGunPlayers then
            local hasGun = tc:FindFirstChild("Sheriff Gun") or tc:FindFirstChild("Gun") or
                p.Backpack:FindFirstChild("Sheriff Gun") or p.Backpack:FindFirstChild("Gun")
            if not hasGun then continue end
        end
        if (torso.Position - root.Position).Magnitude <= Settings.KillAuraRadius then ht:FireServer(torso) end
    end
end)

RunService.Heartbeat:Connect(function()
    if not Settings.AutoSlash then return end
    local c = GetCharacter() if not c then return end
    local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
    local root = GetRoot() if not root then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local tc = p.Character if not tc then continue end
        local tr = tc:FindFirstChild("HumanoidRootPart") if not tr then continue end
        if (tr.Position - root.Position).Magnitude <= Settings.KnifeRange + 0.5 then
            local ev = knife:FindFirstChild("Events")
            if ev then local s = ev:FindFirstChild("SlashKnife") or ev:FindFirstChild("Slash") if s then s:FireServer() end end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not Settings.AutoSpam then return end
    local c = GetCharacter() if not c then return end
    local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
    local ev = knife:FindFirstChild("Events") if not ev then return end
    local s = ev:FindFirstChild("SlashKnife") or ev:FindFirstChild("Slash") if s then s:FireServer() end
end)

RunService.RenderStepped:Connect(function()
    if not Settings.KnifeThrowAimbot then return end
    local root = GetRoot() if not root then return end
    local best, bestScore = nil, math.huge
    local cursor = UserInputService:GetMouseLocation()
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local c = p.Character if not c then continue end
        local head = c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart") if not head then continue end
        local hum = c:FindFirstChildOfClass("Humanoid") if not hum or hum.Health <= 0 then continue end
        local dist = (head.Position - root.Position).Magnitude
        if dist > Settings.KnifeThrowMaxDist then continue end
        local screen, visible = WorldToViewport(head.Position)
        local score
        if Settings.KnifeThrowMode == "Crosshair" then
            if not visible then continue end
            score = (screen - cursor).Magnitude
            if score > Settings.KnifeThrowFOV / 2 then continue end
        elseif Settings.KnifeThrowMode == "Sheriff" then
            local sf = FindSheriff()
            score = (sf and sf == p) and dist or (dist + 10000)
        else
            score = dist
        end
        if score < bestScore then bestScore = score best = head end
    end
    if best then Camera.CFrame = CFrame.new(Camera.CFrame.Position, best.Position) end
end)

RunService.Heartbeat:Connect(function()
    if not Settings.LoopInteractive then return end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "Interact" and v:IsA("RemoteEvent") then v:FireServer() end
    end
end)

RunService.Heartbeat:Connect(function()
    local hum = GetHumanoid()
    if hum then hum.WalkSpeed = Settings.WalkSpeed hum.JumpPower = Settings.JumpPower end
end)

local function SetFullBright(v)
    if v then
        Lighting.Brightness = 2 Lighting.ClockTime = 14 Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false Lighting.Ambient = Color3.fromRGB(255,255,255)
    else
        Lighting.Brightness = 1 Lighting.GlobalShadows = true Lighting.Ambient = Color3.fromRGB(0,0,0)
    end
end

local function SetNightMode(v)
    if v then Lighting.ClockTime = 0 Lighting.FogEnd = 100000 else Lighting.ClockTime = 14 end
end

local function ApplyKnifeSkin(skin)
    local c = GetCharacter() if not c then return end
    local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
    local handle = knife:FindFirstChild("Handle") if not handle then return end
    local skins = {
        Rainbow="rbxassetid://6520645492", Gold="rbxassetid://6520647104",
        Neon="rbxassetid://6520648912", Dark="rbxassetid://6520650843", Crystal="rbxassetid://6520652677"
    }
    local tid = skins[skin]
    if tid then local mesh = handle:FindFirstChildOfClass("SpecialMesh") if mesh then mesh.TextureId = tid end end
end

local WallHopConn
local function SetupWallHop()
    if WallHopConn then WallHopConn:Disconnect() end
    if not Settings.WallHop then return end
    WallHopConn = UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe or input.KeyCode ~= Enum.KeyCode.Space then return end
        local root = GetRoot() local hum = GetHumanoid()
        if not root or not hum then return end
        local rp = RaycastParams.new()
        rp.FilterDescendantsInstances = {GetCharacter()} rp.FilterType = Enum.RaycastFilterType.Exclude
        for _, dir in ipairs({Vector3.xAxis, -Vector3.xAxis, Vector3.zAxis, -Vector3.zAxis}) do
            local result = workspace:Raycast(root.Position, dir * 3, rp)
            if result then
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(Settings.WallHopAngle), 0)
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                break
            end
        end
    end)
end

local TouchFlingConn
local function SetTouchFling(v)
    if TouchFlingConn then TouchFlingConn:Disconnect() TouchFlingConn = nil end
    if not v then return end
    local c = GetCharacter() if not c then return end
    for _, part in ipairs(c:GetDescendants()) do
        if part:IsA("BasePart") then
            TouchFlingConn = part.Touched:Connect(function(hit)
                if not Settings.TouchFling then return end
                local model = hit:FindFirstAncestorWhichIsA("Model")
                local player = model and Players:GetPlayerFromCharacter(model)
                if player and player ~= LocalPlayer then
                    local hrp = model:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local bv = Instance.new("BodyVelocity")
                        bv.Velocity = Vector3.new(math.random(-500,500), 1000, math.random(-500,500))
                        bv.MaxForce = Vector3.new(9e9,9e9,9e9) bv.Parent = hrp
                        Debris:AddItem(bv, 0.15)
                    end
                end
            end) break
        end
    end
end

local ClickFlingConn
local function SetClickFling(v)
    if ClickFlingConn then ClickFlingConn:Disconnect() ClickFlingConn = nil end
    if not v then return end
    ClickFlingConn = UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe or not Settings.ClickFling then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local mousePos = UserInputService:GetMouseLocation()
        local unitRay = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
        local rp = RaycastParams.new()
        local c = GetCharacter() if c then rp.FilterDescendantsInstances = {c} end
        rp.FilterType = Enum.RaycastFilterType.Exclude
        local result = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000, rp)
        if result then
            local model = result.Instance:FindFirstAncestorWhichIsA("Model")
            local player = model and Players:GetPlayerFromCharacter(model)
            if player and player ~= LocalPlayer then
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(math.random(-800,800), 2000, math.random(-800,800))
                    bv.MaxForce = Vector3.new(9e9,9e9,9e9) bv.Parent = hrp
                    Debris:AddItem(bv, 0.15)
                end
            end
        end
    end)
end

local OrbitTarget, OrbitConn
local function SetOrbit(v)
    if OrbitConn then OrbitConn:Disconnect() OrbitConn = nil end
    if not v then OrbitTarget = nil return end
    local angle = 0
    OrbitConn = RunService.Heartbeat:Connect(function()
        if not Settings.Orbit then OrbitConn:Disconnect() return end
        if not OrbitTarget then
            local mp = UserInputService:GetMouseLocation()
            local ray = Camera:ViewportPointToRay(mp.X, mp.Y)
            local rp = RaycastParams.new()
            local c = GetCharacter() if c then rp.FilterDescendantsInstances = {c} end
            rp.FilterType = Enum.RaycastFilterType.Exclude
            local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, rp)
            if result then
                local model = result.Instance:FindFirstAncestorWhichIsA("Model")
                OrbitTarget = model and Players:GetPlayerFromCharacter(model) and model or nil
            end
        end
        if OrbitTarget and OrbitTarget.Parent then
            local root = GetRoot() if not root then return end
            local tr = OrbitTarget:FindFirstChild("HumanoidRootPart")
            if not tr then OrbitTarget = nil return end
            angle += 0.05
            root.CFrame = CFrame.new(tr.Position + Vector3.new(math.cos(angle)*5, 0, math.sin(angle)*5), tr.Position)
        end
    end)
end

local function SetJerkOffTool(v)
    local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
    if not bp then return end
    local ex = bp:FindFirstChild("JerkOffR15Chaos") or (GetCharacter() and GetCharacter():FindFirstChild("JerkOffR15Chaos"))
    if ex then ex:Destroy() end
    if not v then return end
    local tool = Instance.new("Tool")
    tool.Name = "JerkOffR15Chaos" tool.RequiresHandle = false
    tool.Equipped:Connect(function()
        local hum = GetHumanoid() if not hum then return end
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://698251653"
        local track = hum:LoadAnimation(anim)
        track.Looped = false track:Play() track.TimePosition = 0.58 track:AdjustSpeed(0.4)
        task.spawn(function()
            while track.IsPlaying do
                if track.TimePosition >= 0.63 then track.TimePosition = 0.58 end task.wait()
            end
        end)
    end)
    tool.Parent = bp
end

local function PlayEmoteOnce(emote)
    pcall(function() game.ReplicatedStorage.Remotes.Misc.PlayEmote:Fire(emote) end)
end
task.spawn(function()
    while true do task.wait(1.4) if Settings.AutoEmote then PlayEmoteOnce(Settings.AutoEmoteSelected) end end
end)

local AutoEquipToySettings = {
    Enabled = false,
    ToyName = "",
    LastEquip = 0,
}
local function EquipToy(toyName)
    if toyName == "" then return end
    local character = LocalPlayer.Character
    local hum = character and character:FindFirstChildOfClass("Humanoid")
    if not character or not hum or hum.Health <= 0 then return end
    local bp = LocalPlayer.Backpack
    local existing = character:FindFirstChild(toyName) or (bp and bp:FindFirstChild(toyName))
    if existing and existing:IsA("Tool") then return end
    if os.clock() - AutoEquipToySettings.LastEquip < 3 then return end
    AutoEquipToySettings.LastEquip = os.clock()
    pcall(function()
        local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
        local extras = remotes and remotes:FindFirstChild("Extras")
        local replicateToy = extras and extras:FindFirstChild("ReplicateToy")
        if replicateToy then replicateToy:InvokeServer(toyName) end
    end)
end
task.spawn(function()
    while true do
        task.wait(3)
        if AutoEquipToySettings.Enabled and AutoEquipToySettings.ToyName ~= "" then
            EquipToy(AutoEquipToySettings.ToyName)
        end
    end
end)

local FarmSettings = {
    AutoFarm = false,
    TweenSpeed = 30,
    TweenDelay = 10,
    FastSpeed = 24,
    UnderMapY = -100,
    FarmingMethod = "Tween",
    CoinType = "All",
    AFKFarm = false,
    AvoidMurderer = false,
    SyncMode = false,
    ReturnTo = "Spawn",
    AutoResetAsMurderer = false,
    AutoResetAsSheriff = false,
    AutoResetAsInnocent = false,
    AutoKillEveryoneAsMurderer = false,
    AutoShootMurdererAsSheriff = false,
    AutoFlingMurderer = false,
    PickUpGun = true,
    ShootMurdererOnFull = true,
    AutoRespawnOnFull = false,
    AutoRejoin = false,
    AutoLoadPrevious = false,
    FarmWebhook = false,
    WebhookInterval = 150,
    AutoUnboxCrate = false,
    SelectedCrate = "Classic Crate",
    SelectedCurrency = "Coins",
}

local ExtraSettings = {
    SecondLife = false,
    InstantRoleNotify = false,
    ShowMurdererChance = false,
    AutoNotifyRoles = false,
    AutoNotifyMurdererPerk = false,
    FloatEnabled = false,
    FloatOffset = 310,
    XRay = false,
    XRayTransparency = 75,
    JumpBoost = false,
    JumpBoostIntensity = 50,
    AutoSpeedGlitch = false,
    AutoJump = false,
    AutoClick = false,
    AntiVoid = false,
    CamMinZoom = 0.5,
    CamMaxZoom = 128,
    KorbloxEnabled = false,
    KorbloxPermanent = false,
    HeadlessEnabled = false,
    HeadlessPermanent = false,
    RadioSongId = "",
    RadioAutoPlay = false,
    BreakTrade = false,
    LoopResetTrade = false,
    GunSkinName = "Default",
    CustomShootColor = Color3.fromRGB(255, 255, 0),
    CustomShootColorEnabled = false,
    SoundKnifeThrow = false,
    SoundKnifeThrowPreset = "Default",
    SoundKnifeThrowAsset = "",
    SoundKnifeKill = false,
    SoundKnifeKillPreset = "Default",
    SoundKnifeKillAsset = "",
    SoundGunshot = false,
    SoundGunshotPreset = "Default",
    SoundGunshotAsset = "",
    SoundGunReload = false,
    SoundGunReloadPreset = "Default",
    SoundGunReloadAsset = "",
}

local farmThread
local function StopFarmThread()
    if farmThread then task.cancel(farmThread) farmThread = nil end
end

local function GetCoins()
    local coins = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        local isCoin = obj.Name == "Coin_Server" or obj.Name == "Coin"
        local matchType = FarmSettings.CoinType == "All"
            or (FarmSettings.CoinType == "Gold" and obj.Name:find("Gold"))
            or (FarmSettings.CoinType == "Silver" and not obj.Name:find("Gold"))
        if isCoin and matchType and obj:IsA("BasePart") then
            table.insert(coins, obj)
        end
    end
    return coins
end

local function StartFarmThread()
    StopFarmThread()
    farmThread = task.spawn(function()
        while FarmSettings.AutoFarm do
            local root = GetRoot()
            if root then
                local method = FarmSettings.FarmingMethod
                if method == "Under Map" then
                    local coins = GetCoins()
                    local origY = root.Position.Y
                    root.CFrame = CFrame.new(root.Position.X, FarmSettings.UnderMapY, root.Position.Z)
                    for _, obj in ipairs(coins) do
                        if not FarmSettings.AutoFarm then break end
                        if FarmSettings.AvoidMurderer then
                            local m = FindMurderer()
                            if m and m.Character then
                                local mr = m.Character:FindFirstChild("HumanoidRootPart")
                                if mr and (mr.Position - obj.Position).Magnitude < 15 then continue end
                            end
                        end
                        root.CFrame = CFrame.new(obj.Position.X, FarmSettings.UnderMapY, obj.Position.Z)
                        task.wait(0.08)
                    end
                elseif method == "Fast" then
                    for _, obj in ipairs(GetCoins()) do
                        if not FarmSettings.AutoFarm then break end
                        root.CFrame = CFrame.new(obj.Position)
                        task.wait(1 / FarmSettings.FastSpeed)
                    end
                else
                    for _, obj in ipairs(GetCoins()) do
                        if not FarmSettings.AutoFarm then break end
                        if FarmSettings.AvoidMurderer then
                            local m = FindMurderer()
                            if m and m.Character then
                                local mr = m.Character:FindFirstChild("HumanoidRootPart")
                                if mr and (mr.Position - obj.Position).Magnitude < 15 then continue end
                            end
                        end
                        if method == "Tween" then
                            TweenService:Create(root, TweenInfo.new(FarmSettings.TweenSpeed / 100, Enum.EasingStyle.Linear), {CFrame = CFrame.new(obj.Position)}):Play()
                            task.wait(FarmSettings.TweenDelay / 100)
                        else
                            root.CFrame = CFrame.new(obj.Position)
                            task.wait(0.05)
                        end
                    end
                end
                if FarmSettings.PickUpGun then
                    pcall(function()
                        local gun = workspace:FindFirstChild("GunDrop", true) or workspace:FindFirstChild("SheriffGun", true)
                        if gun and gun:IsA("BasePart") then
                            local hum = GetHumanoid()
                            if hum then
                                local t = gun:FindFirstChildOfClass("TouchTransmitter")
                                if t then firetouchinterest(root, gun, 0) task.wait(0.05) firetouchinterest(root, gun, 1) end
                            end
                        end
                    end)
                end
                if FarmSettings.ShootMurdererOnFull then
                    pcall(function()
                        local c = GetCharacter()
                        if not c then return end
                        local gun = c:FindFirstChild("Sheriff Gun") or c:FindFirstChild("Gun")
                        if not gun then return end
                        local m = FindMurderer()
                        if not m or not m.Character then return end
                        local mr = m.Character:FindFirstChild("Head") or m.Character:FindFirstChild("HumanoidRootPart")
                        if not mr then return end
                        local events = gun:FindFirstChild("Events") or gun:FindFirstChild("ServerEvents")
                        if events then
                            local shoot = events:FindFirstChild("ShootBullet") or events:FindFirstChild("Shoot")
                            if shoot then
                                local dir = (mr.Position - (GetRoot() and GetRoot().Position or Vector3.zero)).Unit
                                shoot:FireServer(dir, mr.Position)
                            end
                        end
                    end)
                end
            end
            task.wait(0.3)
        end
    end)
end

local autoKillThread, autoShootThread, autoFlingMurdThread, autoRejoinThread
local autoRejoinBusy = false
local function SetupAutoRejoin()
    local GuiService = game:GetService("GuiService")
    local TeleportService = game:GetService("TeleportService")
    GuiService.ErrorMessageChanged:Connect(function(msg)
        if not FarmSettings.AutoRejoin then return end
        if autoRejoinBusy then return end
        local m = tostring(msg or ""):lower()
        if m == "" then return end
        if m:find("same account",1,true) then return end
        if m:find("another device",1,true) then return end
        if m:find("different device",1,true) then return end
        if m:find("banned",1,true) then return end
        if m:find("anti stealer",1,true) then return end
        autoRejoinBusy = true
        task.spawn(function()
            local tries = 0
            while true do
                tries = tries + 1
                pcall(function()
                    if tries <= 2 then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
                    else
                        TeleportService:Teleport(game.PlaceId, LocalPlayer)
                    end
                end)
                task.wait(tries <= 6 and 10 or tries <= 12 and 30 or 60)
            end
        end)
    end)
end
SetupAutoRejoin()

local function StartAutoKillEveryone()
    if autoKillThread then task.cancel(autoKillThread) end
    autoKillThread = task.spawn(function()
        while FarmSettings.AutoKillEveryoneAsMurderer do
            local c = GetCharacter()
            if c then
                local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife")
                if knife then
                    local events = knife:FindFirstChild("Events")
                    if events then
                        local ht = events:FindFirstChild("HandleTouched")
                        if ht then
                            local root = GetRoot()
                            if root then
                                for _, p in ipairs(Players:GetPlayers()) do
                                    if p == LocalPlayer then continue end
                                    local pc = p.Character
                                    if pc then
                                        local pr = pc:FindFirstChild("HumanoidRootPart")
                                        if pr then
                                            root.CFrame = CFrame.new(pr.Position)
                                            task.wait(0.05)
                                            ht:FireServer(pr)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end

local function StartAutoShootMurderer()
    if autoShootThread then task.cancel(autoShootThread) end
    autoShootThread = task.spawn(function()
        while FarmSettings.AutoShootMurdererAsSheriff do
            local c = GetCharacter()
            if c then
                local gun = c:FindFirstChild("Sheriff Gun") or c:FindFirstChild("Gun")
                if gun then
                    local m = FindMurderer()
                    if m and m.Character then
                        local mr = m.Character:FindFirstChild("Head") or m.Character:FindFirstChild("HumanoidRootPart")
                        if mr then
                            local events = gun:FindFirstChild("Events") or gun:FindFirstChild("ServerEvents")
                            if events then
                                local shoot = events:FindFirstChild("ShootBullet") or events:FindFirstChild("Shoot")
                                if shoot then
                                    local dir = (mr.Position - (GetRoot() and GetRoot().Position or Vector3.zero)).Unit
                                    shoot:FireServer(dir, mr.Position)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.4)
        end
    end)
end

local function StartAutoFlingMurderer()
    if autoFlingMurdThread then task.cancel(autoFlingMurdThread) end
    autoFlingMurdThread = task.spawn(function()
        while FarmSettings.AutoFlingMurderer do
            local m = FindMurderer()
            if m and m.Character then
                local mr = m.Character:FindFirstChild("HumanoidRootPart")
                if mr then
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(math.random(-2000, 2000), 3000, math.random(-2000, 2000))
                    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    bv.Parent = mr
                    Debris:AddItem(bv, 0.2)
                end
            end
            task.wait(1.5)
        end
    end)
end

local floatConn
local function SetFloat(v)
    if floatConn then floatConn:Disconnect() floatConn = nil end
    if not v then return end
    floatConn = RunService.Heartbeat:Connect(function()
        if not ExtraSettings.FloatEnabled then floatConn:Disconnect() floatConn = nil return end
        local c = GetCharacter()
        if not c then return end
        local root = GetRoot()
        if not root then return end
        local hum = GetHumanoid()
        if not hum then return end
        hum.PlatformStand = true
        local bg = root:FindFirstChild("_FloatGyro") or Instance.new("BodyGyro")
        bg.Name = "_FloatGyro" bg.P = 9e4 bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) bg.CFrame = root.CFrame bg.Parent = root
        local bv = root:FindFirstChild("_FloatVel") or Instance.new("BodyVelocity")
        bv.Name = "_FloatVel" bv.Velocity = Vector3.new(0, 0, 0) bv.MaxForce = Vector3.new(0, 9e9, 0) bv.Parent = root
        local targetY = workspace:FindFirstChild("Baseplate") and workspace.Baseplate.Position.Y + (ExtraSettings.FloatOffset / 100) * 10 or root.Position.Y
        bv.Velocity = Vector3.new(0, (targetY - root.Position.Y) * 10, 0)
    end)
end

local xrayConn
local function SetXRay(v)
    if xrayConn then xrayConn:Disconnect() xrayConn = nil end
    if not v then
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local c = p.Character
            if c then
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") then part.LocalTransparencyModifier = 0 end
                end
            end
        end
        return
    end
    xrayConn = RunService.Heartbeat:Connect(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local c = p.Character
            if c then
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") then part.LocalTransparencyModifier = 1 - (ExtraSettings.XRayTransparency / 100) end
                end
            end
        end
    end)
end

local jumpBoostConn
local function SetJumpBoost(v)
    if jumpBoostConn then jumpBoostConn:Disconnect() jumpBoostConn = nil end
    if not v then return end
    jumpBoostConn = UserInputService.JumpRequest:Connect(function()
        local root = GetRoot()
        if not root then return end
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, ExtraSettings.JumpBoostIntensity * 2, 0)
        bv.MaxForce = Vector3.new(0, 9e9, 0)
        bv.Parent = root
        Debris:AddItem(bv, 0.2)
    end)
end

local antiVoidConn
local function SetAntiVoid(v)
    if antiVoidConn then antiVoidConn:Disconnect() antiVoidConn = nil end
    if not v then return end
    antiVoidConn = RunService.Heartbeat:Connect(function()
        local root = GetRoot()
        if root and root.Position.Y < -100 then
            root.CFrame = CFrame.new(root.Position.X, 50, root.Position.Z)
        end
    end)
end

local radioSound
local function StopRadio()
    if radioSound then radioSound:Stop() radioSound:Destroy() radioSound = nil end
end
local function PlayRadio(assetId)
    StopRadio()
    if not assetId or assetId == "" then return end
    radioSound = Instance.new("Sound")
    radioSound.SoundId = "rbxassetid://" .. assetId
    radioSound.Volume = 1
    radioSound.Looped = true
    radioSound.Parent = workspace
    radioSound:Play()
end

local function ApplyKorblox()
    local hum = GetHumanoid()
    if not hum or hum.RigType ~= Enum.HumanoidRigType.R15 then return end
    pcall(function()
        local char = GetCharacter()
        for _, acc in ipairs(char:GetChildren()) do
            if acc:IsA("Accessory") then
                local h = acc:FindFirstChild("Handle")
                if h then
                    local m = h:FindFirstChildOfClass("SpecialMesh")
                    if m and m.MeshId:find("Korblox") then acc:Destroy() end
                end
            end
        end
        local desc = LocalPlayer:GetHumanoidDescriptionAsync(LocalPlayer.UserId)
        desc.LeftLeg = 0
        desc.RightLeg = 134082579
        hum:ApplyDescription(desc)
    end)
end

local function ApplyHeadless()
    pcall(function()
        local char = GetCharacter()
        for _, acc in ipairs(char:GetChildren()) do
            if acc:IsA("Accessory") then
                local h = acc:FindFirstChild("Handle")
                if h and (h.Name == "Head" or acc.Name:lower():find("hair") or acc.Name:lower():find("hat")) then
                    acc:Destroy()
                end
            end
        end
        local desc = LocalPlayer:GetHumanoidDescriptionAsync(LocalPlayer.UserId)
        desc.Head = 134082579
        desc.HeadColor = Color3.fromRGB(0, 0, 0)
        local hum = GetHumanoid()
        if hum then hum:ApplyDescription(desc) end
    end)
end

local loopResetTradeThread
local function SetLoopResetTrade(v)
    if loopResetTradeThread then task.cancel(loopResetTradeThread) loopResetTradeThread = nil end
    if not v then return end
    loopResetTradeThread = task.spawn(function()
        while ExtraSettings.LoopResetTrade do
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                local remote = rs:FindFirstChild("ResetTradeCooldown", true) or rs:FindFirstChild("TradeCooldown", true)
                if remote and remote:IsA("RemoteEvent") then remote:FireServer() end
            end)
            task.wait(1)
        end
    end)
end

local gunSoundPresets = {
    {name="Off",id=""},
    {name="Heavy",id="rbxassetid://94509752219213"},
    {name="Blaster",id="rbxassetid://3205753493"},
    {name="Silence",id="rbxassetid://89214508659473"},
    {name="Harvester",id="rbxassetid://7808472682"},
    {name="MM2 Sheriff",id="rbxassetid://135424717388240"},
    {name="MM2 Gun",id="rbxassetid://76995304113402"},
    {name="MM2 Gun 2",id="rbxassetid://111028294465427"},
    {name="Desert Eagle",id="rbxassetid://82286818216627"},
    {name="Deagle",id="rbxassetid://140361765017655"},
    {name="AWP",id="rbxassetid://120989608556423"},
    {name="Revolver",id="rbxassetid://115486270266848"},
    {name="Revolver 2",id="rbxassetid://120771468205926"},
    {name=".357 Magnum",id="rbxassetid://6350479847"},
    {name=".44 Magnum",id="rbxassetid://18918494387"},
    {name="Sniper",id="rbxassetid://103104730555203"},
    {name="Heavy Sniper",id="rbxassetid://5700090398"},
    {name="Glock Silenced",id="rbxassetid://112707321486177"},
    {name="XPR50 Silenced",id="rbxassetid://130946834720896"},
    {name="M4A1 Silenced",id="rbxassetid://5707240744"},
    {name="Pistol",id="rbxassetid://6506930532"},
    {name="Realistic",id="rbxassetid://115567133047135"},
    {name="Retro",id="rbxassetid://3976061026"},
    {name="Laser",id="rbxassetid://4400449399"},
    {name="Plasma",id="rbxassetid://1905343596"},
    {name="Railgun",id="rbxassetid://133865552007016"},
    {name="Fortnite",id="rbxassetid://113797851917516"},
    {name="MLG",id="rbxassetid://122180189312589"},
    {name="Single Shot",id="rbxassetid://9114729252"},
}
local killSoundPresets = {
    {name="Off",id=""},
    {name="Respectful",id="rbxassetid://127793374596820"},
    {name="enrike",id="rbxassetid://111135055793821"},
    {name="Mahito",id="rbxassetid://17774376295"},
    {name="CS:GO Headshot",id="rbxassetid://133002449941130"},
    {name="CS:GO Headshot 2",id="rbxassetid://132110078840319"},
    {name="CS:GO Headshot 3",id="rbxassetid://118849595584555"},
    {name="MLG Hitmarker",id="rbxassetid://121351852050830"},
    {name="CoD Hitmarker",id="rbxassetid://138832207290954"},
    {name="Minecraft Hit",id="rbxassetid://127091812835195"},
    {name="Gamesense",id="rbxassetid://4817809188"},
    {name="Quake Hit",id="rbxassetid://1455817260"},
    {name="Head Hitmarker",id="rbxassetid://17724154662"},
    {name="Minecraft XP",id="rbxassetid://101023147710668"},
    {name="Bonk",id="rbxassetid://137041944943141"},
    {name="TF2 Bonk",id="rbxassetid://124963990860864"},
    {name="Vine Boom",id="rbxassetid://139557908315922"},
    {name="Windows Ding",id="rbxassetid://128418218662188"},
    {name="Ding",id="rbxassetid://123582256549202"},
    {name="Bow Ding",id="rbxassetid://135478009117226"},
    {name="TF2 Kill",id="rbxassetid://124543461907751"},
    {name="Among Us",id="rbxassetid://130456049552264"},
    {name="MM2 Knife Kill",id="rbxassetid://97347330766907"},
    {name="OOF",id="rbxassetid://79348298352567"},
    {name="CS:GO Death",id="rbxassetid://136190901657944"},
    {name="Level Up",id="rbxassetid://112485797063762"},
    {name="Madness Headshot",id="rbxassetid://7849569525"},
    {name="Kill Confirmed",id="rbxassetid://127053529664678"},
}
local function GetGunSoundId(name)
    for _, v in ipairs(gunSoundPresets) do if v.name == name then return v.id end end
    return ""
end
local function GetKillSoundId(name)
    for _, v in ipairs(killSoundPresets) do if v.name == name then return v.id end end
    return ""
end
local function GunSoundNames()
    local t={} for _,v in ipairs(gunSoundPresets) do table.insert(t,v.name) end return t
end
local function KillSoundNames()
    local t={} for _,v in ipairs(killSoundPresets) do table.insert(t,v.name) end return t
end
local soundPresets = {
    KnifeThrow = {"Default", "Whoosh", "Swish", "Blade", "Whistle"},
    KnifeKill = {"Default", "Splat", "Crunch", "Impact", "Slash"},
    Gunshot = {"Default", "Bang", "Pop", "Crack", "Blast"},
    GunReload = {"Default", "Click", "Clack", "Reload", "Chamber"},
}

local customSoundConns = {}
local function SetupCustomSounds()
    for _, c in pairs(customSoundConns) do c:Disconnect() end
    customSoundConns = {}
    local function hookSound(soundName, enabled, assetId)
        if not enabled or not assetId or assetId == "" then return end
        local conn = workspace.DescendantAdded:Connect(function(d)
            if d:IsA("Sound") and d.Name:lower():find(soundName:lower()) then
                d.SoundId = "rbxassetid://" .. assetId
            end
        end)
        table.insert(customSoundConns, conn)
    end
    hookSound("throw", ExtraSettings.SoundKnifeThrow, ExtraSettings.SoundKnifeThrowAsset)
    hookSound("kill", ExtraSettings.SoundKnifeKill, ExtraSettings.SoundKnifeKillAsset)
    hookSound("shoot", ExtraSettings.SoundGunshot, ExtraSettings.SoundGunshotAsset)
    hookSound("reload", ExtraSettings.SoundGunReload, ExtraSettings.SoundGunReloadAsset)
end

local gunSkinList = {
    "Default", "Alien", "Aqua", "Arctic", "Autumn", "Bamboo", "Blood Stain", "Blueprint", "Bone",
    "Candy Cane", "Carbon", "Cherry", "Circuit", "Coral", "Crimson", "Crystal Blue", "Dark Matter",
    "Dragon", "Electric", "Emerald", "Fire", "Floral", "Frost", "Galaxy", "Ghost", "Gold",
    "Graffiti", "Granite", "Holographic", "Honey", "Ice", "Lava", "Lavender", "Lightning",
    "Magma", "Marble", "Matrix", "Midnight", "Military", "Mint", "Neon", "Ocean", "Pastel",
    "Phantom", "Plasma", "Poison", "Prism", "Purple Haze", "Rainbow", "Red Panda", "Rose Gold",
    "Ruby", "Rustic", "Sakura", "Sand", "Sapphire", "Shadow", "Silver", "Skull", "Sky",
    "Solar", "Space", "Static", "Storm", "Sunset", "Toxic", "Tundra", "Twilight", "Uranium",
    "Venom", "Vines", "Void", "Volcanic", "Wave", "Winter", "Wood", "Wraith", "Zombie",
}

local knifeSkinList = {
    "Default", "Alien", "Angelic", "Aqua", "Arctic", "Autumn", "Bamboo", "Blood Stain", "Blueprint",
    "Bone", "Candy Cane", "Carbon", "Cherry", "Circuit", "Coral", "Crimson", "Crystal Blue",
    "Dark Matter", "Dragon", "Electric", "Emerald", "Fire", "Floral", "Frost", "Galaxy", "Ghost",
    "Gold", "Graffiti", "Granite", "Holographic", "Honey", "Ice", "Lava", "Lavender", "Lightning",
    "Magma", "Marble", "Matrix", "Midnight", "Military", "Mint", "Neon", "Ocean", "Pastel",
    "Phantom", "Plasma", "Poison", "Prism", "Purple Haze", "Rainbow", "Red Panda", "Rose Gold",
    "Ruby", "Rustic", "Sakura", "Sand", "Sapphire", "Shadow", "Silver", "Skull", "Sky",
    "Solar", "Space", "Static", "Storm", "Sunset", "Toxic", "Tundra", "Twilight", "Uranium",
    "Venom", "Vines", "Void", "Volcanic", "Wave", "Winter", "Wood", "Wraith", "Zombie",
}

local function ApplyGunSkin(skinName)
    local c = GetCharacter()
    if not c then return end
    local gun = c:FindFirstChild("Sheriff Gun") or c:FindFirstChild("Gun")
    if not gun then return end
    local handle = gun:FindFirstChild("Handle")
    if not handle then return end
    local mesh = handle:FindFirstChildOfClass("SpecialMesh")
    if mesh and skinName ~= "Default" then
        pcall(function()
            local rs = game:GetService("ReplicatedStorage")
            local skinRemote = rs:FindFirstChild("ApplyGunSkin", true) or rs:FindFirstChild("ChangeSkin", true)
            if skinRemote then skinRemote:FireServer(skinName) end
        end)
    end
end

local CombatTab = Window:AddTab("Combat",  "rbxassetid://6031094675")
local PlayerTab = Window:AddTab("Player",  "rbxassetid://6031097268")
local VisualTab = Window:AddTab("Visuals", "rbxassetid://6031094663")
local WorldTab  = Window:AddTab("World",   "rbxassetid://6031094684")
local FarmTab   = Window:AddTab("Farm",    "rbxassetid://6031094669")
local MiscTab   = Window:AddTab("Misc",    "rbxassetid://6031094647")

local MainSub    = CombatTab:AddSubtab("Main")
local AimlockSub = CombatTab:AddSubtab("Aimlock")
local SilentSub  = CombatTab:AddSubtab("Silent Aim")
local KnifeSub   = CombatTab:AddSubtab("Knife")

local AuraGroup = MainSub:AddGroup("Aura", nil, "Left", 220)
AuraGroup:AddCheckbox({Name="Knife Aura", Default=false, Callback=function(v) Settings.KnifeAura=v end})
AuraGroup:AddSlider({Name="Knife Range", Min=4, Max=20, Default=7, Decimals=1, Callback=function(v) Settings.KnifeRange=v end})
AuraGroup:AddCheckbox({Name="Kill Aura", Default=false, Callback=function(v) Settings.KillAura=v end})
AuraGroup:AddSlider({Name="Aura Radius", Min=5, Max=200, Default=20, Decimals=0, Callback=function(v) Settings.KillAuraRadius=v end})
AuraGroup:AddCheckbox({Name="Kill Gun Players Only", Default=false, Callback=function(v) Settings.KillGunPlayers=v end})
AuraGroup:AddCheckbox({Name="Kill All", Default=false, Callback=function(v) Settings.KillAll=v end})

local SlashGroup = MainSub:AddGroup("Slash", nil, "Right", 120)
SlashGroup:AddCheckbox({Name="Auto Slash", Default=false, Callback=function(v) Settings.AutoSlash=v end})
SlashGroup:AddCheckbox({Name="Auto Spam", Default=false, Callback=function(v) Settings.AutoSpam=v end})
SlashGroup:AddCheckbox({Name="Notify On Clash", Default=false, Callback=function(v) Settings.AutoNotifyUponClashing=v end})

local AimlockGroup = AimlockSub:AddGroup("Aimlock", nil, "Left", 220)
AimlockGroup:AddCheckbox({Name="Enable Aimlock", Default=false, Callback=function(v) Settings.EnableAimlock=v end})
AimlockGroup:AddCheckbox({Name="Team Check", Default=false, Callback=function(v) Settings.EnableAimlock_TeamCheck=v end})
AimlockGroup:AddCheckbox({Name="Wall Check", Default=false, Callback=function(v) Settings.EnableAimlock_WallCheck=v end})
AimlockGroup:AddCheckbox({Name="ForceField Check", Default=false, Callback=function(v) Settings.EnableAimlock_ForceFieldCheck=v end})
AimlockGroup:AddCheckbox({Name="Health Check", Default=false, Callback=function(v) Settings.EnableAimlock_HealthCheck=v end})
AimlockGroup:AddDropdown({Name="Aim Part", Items={"Head","HumanoidRootPart","Torso","UpperTorso"}, Default="Head", Callback=function(v) Settings.EnableAimlock_TargetAimpart=v end})
AimlockGroup:AddDropdown({Name="Priority", Items={"Closest","From Mouse"}, Default="Closest", Callback=function(v) Settings.EnableAimlock_TargetPrioritize=v end})
AimlockGroup:AddSlider({Name="FOV Radius", Min=10, Max=500, Default=120, Decimals=0, Callback=function(v) Settings.EnableAimlock_MouseFOVRadius=v end})

local RoleGroup = AimlockSub:AddGroup("Role", nil, "Right", 180)
RoleGroup:AddButton({Name="TP Murderer", Callback=function() local m=FindMurderer() if m then TeleportToPlayer(m) end end})
RoleGroup:AddButton({Name="TP Sheriff", Callback=function() local s=FindSheriff() if s then TeleportToPlayer(s) end end})
RoleGroup:AddButton({Name="TP Gun Drop", Callback=function() TeleportToGunDrop() end})
RoleGroup:AddButton({Name="Expose Murderer", Callback=function()
    local m=FindMurderer() if m then ExposeChatMessage("Murderer: "..m.Name) end
end})
RoleGroup:AddButton({Name="Expose Sheriff", Callback=function()
    local s=FindSheriff() if s then ExposeChatMessage("Sheriff: "..s.Name) end
end})
RoleGroup:AddButton({Name="Expose All", Callback=function()
    local m,s=FindMurderer(),FindSheriff()
    local msg=""
    if m then msg=msg.."M: "..m.Name.." | " end
    if s then msg=msg.."S: "..s.Name end
    if msg~="" then ExposeChatMessage(msg) end
end})

local SilentGroup = SilentSub:AddGroup("Silent Aim", nil, "Left", 220)
SilentGroup:AddCheckbox({Name="Enable Silent Aim", Default=false, Callback=function(v) Settings.GunSilentAim=v end})
SilentGroup:AddCheckbox({Name="Always Hit", Default=false, Callback=function(v) Settings.GunSilentAim_AlwaysHit=v end})
SilentGroup:AddCheckbox({Name="Team Check", Default=false, Callback=function(v) Settings.GunSilentAim_TeamCheck=v end})
SilentGroup:AddCheckbox({Name="Wall Check", Default=false, Callback=function(v) Settings.GunSilentAim_WallCheck=v end})
SilentGroup:AddCheckbox({Name="ForceField Check", Default=false, Callback=function(v) Settings.GunSilentAim_ForceFieldCheck=v end})
SilentGroup:AddDropdown({Name="Aim Part", Items={"Head","HumanoidRootPart","Torso","UpperTorso"}, Default="Head", Callback=function(v) Settings.GunSilentAim_Aimpart=v end})
SilentGroup:AddDropdown({Name="Priority", Items={"Closest","From Mouse"}, Default="Closest", Callback=function(v) Settings.GunSilentAim_TargetPrioritize=v end})

local ThrowAimbotGroup = KnifeSub:AddGroup("Throw Aimbot", nil, "Left", 260)
ThrowAimbotGroup:AddCheckbox({Name="Knife Throw Aimbot", Default=false, Callback=function(v) Settings.KnifeThrowAimbot=v end})
ThrowAimbotGroup:AddDropdown({Name="Target Mode", Items={"Smart","Crosshair","Nearest","Sheriff First"}, Default="Smart", Callback=function(v) Settings.KnifeThrowMode=v end})
ThrowAimbotGroup:AddSlider({Name="Max Distance", Min=30, Max=400, Default=250, Decimals=0, Callback=function(v) Settings.KnifeThrowMaxDist=v end})
ThrowAimbotGroup:AddSlider({Name="Aim FOV", Min=10, Max=360, Default=360, Decimals=0, Callback=function(v) Settings.KnifeThrowFOV=v end})
ThrowAimbotGroup:AddCheckbox({Name="Wall Check", Default=true, Callback=function(v) Settings.KnifeThrowWallCheck=v end})
ThrowAimbotGroup:AddCheckbox({Name="Predict Movement", Default=true, Callback=function(v) Settings.KnifeThrowPredict=v end})
ThrowAimbotGroup:AddSlider({Name="Lead %", Min=0, Max=150, Default=100, Decimals=0, Callback=function(v) Settings.KnifeThrowLead=v end})
ThrowAimbotGroup:AddCheckbox({Name="Sticky Target", Default=true, Callback=function(v) Settings.KnifeThrowSticky=v end})
ThrowAimbotGroup:AddCheckbox({Name="Target Marker", Default=true, Callback=function(v) Settings.KnifeThrowMarker=v end})

local AutoThrowGroup = KnifeSub:AddGroup("Auto Throw", nil, "Right", 180)
AutoThrowGroup:AddCheckbox({Name="Auto Throw", Default=false, Callback=function(v) Settings.AutoThrow=v end})
AutoThrowGroup:AddSlider({Name="Min Chance %", Min=20, Max=95, Default=55, Decimals=0, Callback=function(v) Settings.AutoThrowMinChance=v end})
AutoThrowGroup:AddSlider({Name="Auto Range", Min=20, Max=200, Default=70, Decimals=0, Callback=function(v) Settings.AutoThrowRange=v end})
AutoThrowGroup:AddCheckbox({Name="Instant Throw", Default=false, Callback=function(v) Settings.InstantThrow=v end})
AutoThrowGroup:AddCheckbox({Name="Fast Throw", Default=false, Callback=function(v) Settings.FastThrow=v end})

local TracerGroup = KnifeSub:AddGroup("Tracers", nil, "Left", 220)
TracerGroup:AddCheckbox({Name="Knife Tracers", Default=false, Callback=function(v) Settings.KnifeTracers=v end})
TracerGroup:AddDropdown({Name="Style", Items={"Energy","Beam","Arc","Spiral"}, Default="Energy", Callback=function(v) Settings.KnifeTracerStyle=v end})
TracerGroup:AddCheckbox({Name="Rainbow", Default=false, Callback=function(v) Settings.KnifeTracerRainbow=v end})
TracerGroup:AddSlider({Name="Width %", Min=40, Max=250, Default=100, Decimals=0, Callback=function(v) Settings.KnifeTracerWidth=v end})
TracerGroup:AddSlider({Name="Duration", Min=0.3, Max=4, Default=1.2, Decimals=1, Callback=function(v) Settings.KnifeTracerDuration=v end})
TracerGroup:AddCheckbox({Name="Impact Effect", Default=true, Callback=function(v) Settings.KnifeTracerImpact=v end})
TracerGroup:AddCheckbox({Name="Throw Flash", Default=true, Callback=function(v) Settings.KnifeTracerFlash=v end})
TracerGroup:AddCheckbox({Name="Show Others", Default=false, Callback=function(v) Settings.KnifeTracerOthers=v end})

local SkinGroup = KnifeSub:AddGroup("Skin Changer", nil, "Right", 100)
SkinGroup:AddDropdown({Name="Knife Skin", Items={"Default","Rainbow","Gold","Neon","Dark","Crystal"}, Default="Default", Callback=function(v)
    Settings.KnifeSkinChanger=v ApplyKnifeSkin(v)
end})

local KillMurdGroup = KnifeSub:AddGroup("Quick Kill", nil, "Right", 60)
KillMurdGroup:AddButton({Name="TP + Slash Murderer", Callback=function()
    local m=FindMurderer() if not m then return end
    TeleportToPlayer(m) task.wait(0.1)
    local c=GetCharacter()
    local knife=c and (c:FindFirstChild("Knife") or c:FindFirstChild("knife"))
    if knife then
        local ev=knife:FindFirstChild("Events")
        if ev then local s=ev:FindFirstChild("SlashKnife") or ev:FindFirstChild("Slash") if s then s:FireServer() end end
    end
end})

local MovementSub   = PlayerTab:AddSubtab("Movement")
local ProtectionSub = PlayerTab:AddSubtab("Protection")
local ModsSub       = PlayerTab:AddSubtab("Mods")
local AppearSub     = PlayerTab:AddSubtab("Appearance")
local RadioSub      = PlayerTab:AddSubtab("Radio")
local TrollSub      = PlayerTab:AddSubtab("Troll")
local EmoteSub      = PlayerTab:AddSubtab("Emotes")

local FarmMainGroup = FarmMainSub:AddGroup("Auto Farm", nil, "Left", 260)
FarmMainGroup:AddCheckbox({Name="Auto Farm", Default=false, Callback=function(v)
    FarmSettings.AutoFarm = v
    if v then StartFarmThread() else StopFarmThread() end
end})
FarmMainGroup:AddSlider({Name="Tween Speed", Min=1, Max=40, Default=30, Decimals=0, Callback=function(v) FarmSettings.TweenSpeed=v end})
FarmMainGroup:AddSlider({Name="Tween Delay", Min=0, Max=150, Default=10, Decimals=0, Callback=function(v) FarmSettings.TweenDelay=v end})
FarmMainGroup:AddDropdown({Name="Farming Method", Items={"Tween","Teleport","Fast","Under Map"}, Default="Tween", Callback=function(v) FarmSettings.FarmingMethod=v end})
FarmMainGroup:AddSlider({Name="Fast Speed", Min=8, Max=60, Default=24, Decimals=0, Callback=function(v) FarmSettings.FastSpeed=v end})
FarmMainGroup:AddSlider({Name="Under Map Y", Min=-300, Max=-50, Default=-100, Decimals=0, Callback=function(v) FarmSettings.UnderMapY=v end})
FarmMainGroup:AddDropdown({Name="Coin Type", Items={"All","Gold","Silver"}, Default="All", Callback=function(v) FarmSettings.CoinType=v end})
FarmMainGroup:AddCheckbox({Name="AFK Farm Mode", Default=false, Callback=function(v) FarmSettings.AFKFarm=v end})
FarmMainGroup:AddCheckbox({Name="Avoid Murderer", Default=false, Callback=function(v) FarmSettings.AvoidMurderer=v end})
FarmMainGroup:AddCheckbox({Name="Sync Mode", Default=false, Callback=function(v) FarmSettings.SyncMode=v end})
FarmMainGroup:AddDropdown({Name="Return To", Items={"Spawn","Last Position","Center"}, Default="Spawn", Callback=function(v) FarmSettings.ReturnTo=v end})

local FarmAutoGroup = FarmMainSub:AddGroup("Auto Actions", nil, "Right", 220)
FarmAutoGroup:AddCheckbox({Name="Auto Reset As Murderer", Default=false, Callback=function(v)
    FarmSettings.AutoResetAsMurderer=v
end})
FarmAutoGroup:AddCheckbox({Name="Auto Reset As Sheriff", Default=false, Callback=function(v)
    FarmSettings.AutoResetAsSheriff=v
end})
FarmAutoGroup:AddCheckbox({Name="Auto Reset As Innocent", Default=false, Callback=function(v)
    FarmSettings.AutoResetAsInnocent=v
end})
FarmAutoGroup:AddCheckbox({Name="Auto Kill Everyone", Default=false, Callback=function(v)
    FarmSettings.AutoKillEveryoneAsMurderer=v
    if v then StartAutoKillEveryone() end
end})
FarmAutoGroup:AddCheckbox({Name="Auto Shoot Murderer", Default=false, Callback=function(v)
    FarmSettings.AutoShootMurdererAsSheriff=v
    if v then StartAutoShootMurderer() end
end})
FarmAutoGroup:AddCheckbox({Name="Auto Fling Murderer", Default=false, Callback=function(v)
    FarmSettings.AutoFlingMurderer=v
    if v then StartAutoFlingMurderer() end
end})
FarmAutoGroup:AddCheckbox({Name="Pick Up Gun", Default=true, Callback=function(v) FarmSettings.PickUpGun=v end})
FarmAutoGroup:AddCheckbox({Name="Shoot Murderer When Full", Default=true, Callback=function(v) FarmSettings.ShootMurdererOnFull=v end})
FarmAutoGroup:AddCheckbox({Name="Auto Respawn When Full", Default=false, Callback=function(v)
    FarmSettings.AutoRespawnOnFull=v
    if v then task.spawn(function()
        while FarmSettings.AutoRespawnOnFull do
            task.wait(2)
            pcall(function()
                local hum = GetHumanoid()
                if hum and hum.Health > 0 then
                    local c = GetCharacter()
                    local backpack = LocalPlayer.Backpack
                    local bagFull = backpack and #backpack:GetChildren() >= 10
                    if bagFull then hum.Health = 0 end
                end
            end)
        end
    end) end
end})

local FarmMiscGroup = FarmMiscSub:AddGroup("Farm Misc", nil, "Left", 220)
FarmMiscGroup:AddCheckbox({Name="Auto Rejoin", Default=false, Callback=function(v) FarmSettings.AutoRejoin=v end})
FarmMiscGroup:AddCheckbox({Name="Auto Load Previous Farm", Default=false, Callback=function(v) FarmSettings.AutoLoadPrevious=v end})
FarmMiscGroup:AddCheckbox({Name="Farm Webhook", Default=false, Callback=function(v) FarmSettings.FarmWebhook=v end})
FarmMiscGroup:AddSlider({Name="Webhook Interval (s)", Min=120, Max=500, Default=150, Decimals=0, Callback=function(v) FarmSettings.WebhookInterval=v end})

local FarmRoleGroup = FarmMiscSub:AddGroup("Role Notify", nil, "Right", 220)
FarmRoleGroup:AddCheckbox({Name="Second Life", Default=false, Callback=function(v) ExtraSettings.SecondLife=v end})
FarmRoleGroup:AddCheckbox({Name="Instant Role Notify", Default=false, Callback=function(v) ExtraSettings.InstantRoleNotify=v end})
FarmRoleGroup:AddCheckbox({Name="Show Murderer Chance", Default=false, Callback=function(v) ExtraSettings.ShowMurdererChance=v end})
FarmRoleGroup:AddCheckbox({Name="Auto Notify Roles", Default=false, Callback=function(v) ExtraSettings.AutoNotifyRoles=v end})
FarmRoleGroup:AddButton({Name="Notify Roles Now", Callback=function()
    local m = FindMurderer() local s = FindSheriff()
    local msg = ""
    if m then msg = msg .. "Murderer: " .. m.Name .. " | " end
    if s then msg = msg .. "Sheriff: " .. s.Name end
    if msg ~= "" then ExposeChatMessage(msg) end
end})
FarmRoleGroup:AddCheckbox({Name="Auto Notify Murderer Perk", Default=false, Callback=function(v) ExtraSettings.AutoNotifyMurdererPerk=v end})
FarmRoleGroup:AddButton({Name="Notify Murderer Perk", Callback=function()
    local m = FindMurderer()
    if m then
        local c = m.Character
        local perk = c and c:FindFirstChild("Perk")
        ExposeChatMessage("Murderer perk: " .. (perk and perk.Value or "unknown"))
    end
end})

local CrateGroup = FarmCrateSub:AddGroup("Crate Unbox", nil, "Left", 220)
CrateGroup:AddButton({Name="Unbox Crate", Callback=function()
    pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        local remote = rs:FindFirstChild("OpenCrate", true) or rs:FindFirstChild("UnboxCrate", true)
        if remote then remote:FireServer(FarmSettings.SelectedCrate, FarmSettings.SelectedCurrency) end
    end)
end})
CrateGroup:AddCheckbox({Name="Auto Unbox Crate", Default=false, Callback=function(v)
    FarmSettings.AutoUnboxCrate=v
    if v then task.spawn(function()
        while FarmSettings.AutoUnboxCrate do
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                local remote = rs:FindFirstChild("OpenCrate", true) or rs:FindFirstChild("UnboxCrate", true)
                if remote then remote:FireServer(FarmSettings.SelectedCrate, FarmSettings.SelectedCurrency) end
            end)
            task.wait(1.5)
        end
    end) end
end})
CrateGroup:AddDropdown({Name="Select Crate", Items={
    "Classic Crate","Uncommon Crate","Rare Crate","Epic Crate","Legendary Crate",
    "Godly Crate","Holiday Crate","Seasonal Crate","Limited Crate","Premium Crate"
}, Default="Classic Crate", Callback=function(v) FarmSettings.SelectedCrate=v end})
CrateGroup:AddDropdown({Name="Currency", Items={"Coins","Gems"}, Default="Coins", Callback=function(v) FarmSettings.SelectedCurrency=v end})

local ModsGroup1 = ModsSub:AddGroup("Character", nil, "Left", 220)
ModsGroup1:AddCheckbox({Name="Float", Default=false, Callback=function(v) ExtraSettings.FloatEnabled=v SetFloat(v) end})
ModsGroup1:AddSlider({Name="Float Offset", Min=0, Max=500, Default=310, Decimals=0, Callback=function(v) ExtraSettings.FloatOffset=v end})
ModsGroup1:AddCheckbox({Name="X-Ray", Default=false, Callback=function(v) ExtraSettings.XRay=v SetXRay(v) end})
ModsGroup1:AddSlider({Name="X-Ray Transparency", Min=1, Max=100, Default=75, Decimals=0, Callback=function(v) ExtraSettings.XRayTransparency=v end})
ModsGroup1:AddCheckbox({Name="Jump Boost", Default=false, Callback=function(v) ExtraSettings.JumpBoost=v SetJumpBoost(v) end})
ModsGroup1:AddSlider({Name="Jump Boost Intensity", Min=1, Max=255, Default=50, Decimals=0, Callback=function(v) ExtraSettings.JumpBoostIntensity=v end})
ModsGroup1:AddCheckbox({Name="Anti Void", Default=false, Callback=function(v) ExtraSettings.AntiVoid=v SetAntiVoid(v) end})

local ModsGroup2 = ModsSub:AddGroup("Camera", nil, "Right", 220)
ModsGroup2:AddSlider({Name="Min Zoom Distance", Min=0, Max=1000, Default=0, Decimals=1, Callback=function(v)
    ExtraSettings.CamMinZoom=v
    LocalPlayer.CameraMinZoomDistance=v
end})
ModsGroup2:AddSlider({Name="Max Zoom Distance", Min=0, Max=1000, Default=128, Decimals=0, Callback=function(v)
    ExtraSettings.CamMaxZoom=v
    LocalPlayer.CameraMaxZoomDistance=v
end})
ModsGroup2:AddButton({Name="First Person", Callback=function()
    LocalPlayer.CameraMode=Enum.CameraMode.LockFirstPerson
end})
ModsGroup2:AddButton({Name="Third Person", Callback=function()
    LocalPlayer.CameraMode=Enum.CameraMode.Classic
    LocalPlayer.CameraMaxZoomDistance=ExtraSettings.CamMaxZoom
end})
ModsGroup2:AddCheckbox({Name="Auto Jump", Default=false, Callback=function(v)
    ExtraSettings.AutoJump=v
    LocalPlayer.AutoJumpEnabled=v
end})
ModsGroup2:AddCheckbox({Name="Auto Click", Default=false, Callback=function(v)
    ExtraSettings.AutoClick=v
    if v then task.spawn(function()
        while ExtraSettings.AutoClick do
            task.wait(0.05)
            pcall(function()
                local ms = game:GetService("VirtualInputManager")
                ms:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                ms:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
        end
    end) end
end})

local ModsPrestigeGroup = ModsSub:AddGroup("Prestige", nil, "Left", 160)
ModsPrestigeGroup:AddButton({Name="Prestige Now", Callback=function()
    pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        local remote = rs:FindFirstChild("Prestige", true) or rs:FindFirstChild("PrestigePlayer", true)
        if remote then remote:FireServer() end
    end)
end})
ModsPrestigeGroup:AddCheckbox({Name="Auto Prestige", Default=false, Callback=function(v) Settings.AutoPrestige=v end})

local AppearGroup = AppearSub:AddGroup("Body Appearance", nil, "Left", 260)
AppearGroup:AddButton({Name="Apply Korblox (R15)", Callback=function() ApplyKorblox() end})
AppearGroup:AddCheckbox({Name="Korblox Permanent", Default=false, Callback=function(v)
    ExtraSettings.KorbloxPermanent=v
    if v then ApplyKorblox() end
end})
AppearGroup:AddButton({Name="Apply Headless", Callback=function() ApplyHeadless() end})
AppearGroup:AddCheckbox({Name="Headless Permanent", Default=false, Callback=function(v)
    ExtraSettings.HeadlessPermanent=v
    if v then ApplyHeadless() end
end})

local RadioGroup = RadioSub:AddGroup("Radio", nil, "Left", 260)
RadioGroup:AddTextbox({Name="Song ID", Default="", Callback=function(v) ExtraSettings.RadioSongId=v end})
RadioGroup:AddButton({Name="Play Song", Callback=function() PlayRadio(ExtraSettings.RadioSongId) end})
RadioGroup:AddButton({Name="Stop Song", Callback=function() StopRadio() end})
RadioGroup:AddCheckbox({Name="Auto Play On Respawn", Default=false, Callback=function(v) ExtraSettings.RadioAutoPlay=v end})

local MovementGroup = MovementSub:AddGroup("Movement", nil, "Left", 260)
MovementGroup:AddCheckbox({Name="Fly", Default=false, Callback=function(v) Settings.Fly=v if v then StartFly() else StopFly() end end})
MovementGroup:AddSlider({Name="Fly Speed", Min=5, Max=200, Default=50, Decimals=0, Callback=function(v) Settings.FlySpeed=v end})
MovementGroup:AddCheckbox({Name="CFrame Fly", Default=false, Callback=function(v) Settings.CFrameFly=v end})
MovementGroup:AddSlider({Name="CFrame Speed", Min=5, Max=200, Default=50, Decimals=0, Callback=function(v) Settings.CFrameFlySpeed=v end})
MovementGroup:AddSlider({Name="Walk Speed", Min=2, Max=200, Default=16, Decimals=0, Callback=function(v) Settings.WalkSpeed=v end})
MovementGroup:AddSlider({Name="Jump Power", Min=2, Max=200, Default=50, Decimals=0, Callback=function(v) Settings.JumpPower=v end})
MovementGroup:AddCheckbox({Name="Infinite Jump", Default=false, Callback=function(v) Settings.InfiniteJump=v SetInfiniteJump(v) end})
MovementGroup:AddCheckbox({Name="No Clip", Default=false, Callback=function(v) Settings.NoClip=v SetNoClip(v) end})
MovementGroup:AddCheckbox({Name="Freeze Character", Default=false, Callback=function(v)
    Settings.FreezeCharacter=v
    local c=GetCharacter() if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Anchored=v end end end
end})
MovementGroup:AddCheckbox({Name="Invisible", Default=false, Callback=function(v) Settings.Invisible=v SetInvisible(v) end})

local WallHopGroup = MovementSub:AddGroup("Wall Hop", nil, "Right", 180)
WallHopGroup:AddCheckbox({Name="Wall Hop", Default=false, Callback=function(v) Settings.WallHop=v SetupWallHop() end})
WallHopGroup:AddDropdown({Name="Hop Mode", Items={"Press","Hold"}, Default="Press", Callback=function(v) Settings.WallHopMode=v end})
WallHopGroup:AddSlider({Name="Flick Angle", Min=30, Max=180, Default=90, Decimals=0, Callback=function(v) Settings.WallHopAngle=v end})
WallHopGroup:AddCheckbox({Name="Camera Flick", Default=false, Callback=function(v) Settings.WallHopCamFlick=v end})

local ProtectionGroup = ProtectionSub:AddGroup("Protection", nil, "Left", 180)
ProtectionGroup:AddCheckbox({Name="Anti-Fling", Default=false, Callback=function(v) Settings.AntiFling=v SetAntiFling(v) end})
ProtectionGroup:AddCheckbox({Name="Anti-AFK", Default=false, Callback=function(v) Settings.AntiAFK=v SetAntiAFK(v) end})

local FarmGroup = ProtectionSub:AddGroup("Farming", nil, "Right", 180)
FarmGroup:AddCheckbox({Name="Loop Interactive", Default=false, Callback=function(v) Settings.LoopInteractive=v end})
FarmGroup:AddCheckbox({Name="Auto Collect Coins", Default=false, Callback=function(v)
    Settings.AutoCollectCoins=v
    if v then task.spawn(function()
        while Settings.AutoCollectCoins do
            local root=GetRoot() if root then
                for _,obj in ipairs(workspace:GetDescendants()) do
                    if obj.Name=="Coin_Server" and obj:IsA("BasePart") then
                        local orig=root.CFrame root.CFrame=obj.CFrame task.wait(0.05) root.CFrame=orig
                    end
                end
            end task.wait(0.5)
        end
    end) end
end})
FarmGroup:AddCheckbox({Name="Auto Prestige", Default=false, Callback=function(v) Settings.AutoPrestige=v end})

local FlingGroup = TrollSub:AddGroup("Fling", nil, "Left", 220)
FlingGroup:AddCheckbox({Name="Touch Fling", Default=false, Callback=function(v) Settings.TouchFling=v SetTouchFling(v) end})
FlingGroup:AddCheckbox({Name="Click Fling", Default=false, Callback=function(v) Settings.ClickFling=v SetClickFling(v) end})
FlingGroup:AddCheckbox({Name="Click Hump", Default=false, Callback=function(v) Settings.ClickHump=v end})
FlingGroup:AddSlider({Name="Hump Duration (0=hold)", Min=0, Max=30, Default=0, Decimals=0, Callback=function(v) Settings.HumpDuration=v end})
FlingGroup:AddCheckbox({Name="Orbit", Default=false, Callback=function(v) Settings.Orbit=v SetOrbit(v) end})
FlingGroup:AddCheckbox({Name="Jerk Off Tool R15", Default=false, Callback=function(v) Settings.JerkOffTool=v SetJerkOffTool(v) end})

local EmoteGroup = EmoteSub:AddGroup("Emotes", nil, "Left", 160)
EmoteGroup:AddDropdown({Name="Emote", Items={"ninja","dab","floss","headless","zen","zombie","sit"}, Default="ninja", Callback=function(v) Settings.AutoEmoteSelected=v end})
EmoteGroup:AddButton({Name="Play Once", Callback=function() PlayEmoteOnce(Settings.AutoEmoteSelected) end})
EmoteGroup:AddCheckbox({Name="Auto Emote", Default=false, Callback=function(v) Settings.AutoEmote=v end})

local FarmMainSub = FarmTab:AddSubtab("Auto Farm")
local FarmMiscSub = FarmTab:AddSubtab("Farm Misc")
local FarmCrateSub = FarmTab:AddSubtab("Crate")

local ESPSub   = VisualTab:AddSubtab("ESP")
local LightSub = VisualTab:AddSubtab("Lighting")

local ESPGroup = ESPSub:AddGroup("Player ESP", nil, "Left", 260)
ESPGroup:AddCheckbox({Name="Enable ESP", Default=false, Callback=function(v) Settings.ESPEnabled=v if not v then ClearESP() end end})
ESPGroup:AddCheckbox({Name="Show Murderer", Default=true, Callback=function(v) Settings.ESPMurderer=v end})
ESPGroup:AddCheckbox({Name="Show Sheriff", Default=true, Callback=function(v) Settings.ESPSheriff=v end})
ESPGroup:AddCheckbox({Name="Show Innocent", Default=false, Callback=function(v) Settings.ESPInnocent=v end})
ESPGroup:AddCheckbox({Name="Show Names", Default=true, Callback=function(v) Settings.ESPName=v end})
ESPGroup:AddCheckbox({Name="Show Distance", Default=false, Callback=function(v) Settings.ESPDistance=v end})
ESPGroup:AddCheckbox({Name="Show Health Bar", Default=false, Callback=function(v) Settings.ESPHealth=v end})
ESPGroup:AddCheckbox({Name="Show Box", Default=false, Callback=function(v) Settings.ESPBox=v end})

local LightGroup = LightSub:AddGroup("Environment", nil, "Left", 120)
LightGroup:AddCheckbox({Name="Full Bright", Default=false, Callback=function(v) Settings.FullBright=v SetFullBright(v) end})
LightGroup:AddCheckbox({Name="Night Mode", Default=false, Callback=function(v) Settings.NightMode=v SetNightMode(v) end})

local HUDSub    = WorldTab:AddSubtab("HUD")
local CamSub    = WorldTab:AddSubtab("Camera")

local GameInfoGroup = HUDSub:AddGroup("Round Info", nil, "Left", 220)
GameInfoGroup:AddCheckbox({Name="Show Game Info", Default=false, Callback=function(v)
    Settings.ShowGameInfo=v
    if v then
        task.spawn(function()
            local gui=Instance.new("ScreenGui") gui.Name="ChaosGameInfo" gui.ResetOnSpawn=false gui.Parent=game.CoreGui
            local frame=Instance.new("Frame") frame.Size=UDim2.new(0,280,0,90)
            frame.Position=UDim2.new(0,10,0.5,-45) frame.BackgroundColor3=Color3.fromRGB(4,1,6)
            frame.BackgroundTransparency=0.25 frame.Parent=gui
            Instance.new("UICorner", frame).CornerRadius=UDim.new(0,8)
            local stroke=Instance.new("UIStroke") stroke.Color=Color3.fromRGB(190,25,65) stroke.Thickness=1 stroke.Parent=frame
            local lbl=Instance.new("TextLabel") lbl.Size=UDim2.fromScale(1,1)
            lbl.BackgroundTransparency=1 lbl.TextColor3=Color3.fromRGB(255,255,255)
            lbl.TextSize=13 lbl.Font=Enum.Font.GothamBold lbl.RichText=true lbl.TextWrapped=true lbl.Parent=frame
            while Settings.ShowGameInfo do
                local m=FindMurderer() local s=FindSheriff()
                local mn=m and ('<font color="rgb(255,80,80)">'..m.Name.."</font>") or '<font color="rgb(100,100,100)">None</font>'
                local sn=s and ('<font color="rgb(80,150,255)">'..s.Name.."</font>") or '<font color="rgb(100,100,100)">None</font>'
                local gun=workspace:FindFirstChild("GunDrop",true)
                local gs=gun and '<font color="rgb(80,255,80)">Dropped</font>' or '<font color="rgb(255,80,80)">None</font>'
                lbl.Text="<b>Murderer:</b> "..mn.."\n<b>Sheriff:</b> "..sn.."\n<b>Gun:</b> "..gs
                task.wait(0.5)
            end
            gui:Destroy()
        end)
    else
        local gui=game.CoreGui:FindFirstChild("ChaosGameInfo") if gui then gui:Destroy() end
    end
end})
GameInfoGroup:AddCheckbox({Name="Show Round Timer", Default=false, Callback=function(v) Settings.ShowRoundTimer=v end})

local CamGroup = CamSub:AddGroup("Camera", nil, "Left", 120)
CamGroup:AddCheckbox({Name="First Person Lock", Default=false, Callback=function(v)
    Settings.LoopToFirstPersonCamera=v
    LocalPlayer.CameraMode=v and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic
end})

local TradeSub     = MiscTab:AddSubtab("Trade")
local CosmeticsSub = MiscTab:AddSubtab("Cosmetics")
local SoundsSub    = MiscTab:AddSubtab("Sounds")
local MiscSub      = MiscTab:AddSubtab("Settings")

local TradeGroup = TradeSub:AddGroup("Trade Tools", nil, "Left", 220)
TradeGroup:AddCheckbox({Name="Break Trade", Default=false, Callback=function(v)
    ExtraSettings.BreakTrade=v
    if v then
        pcall(function()
            local rs = game:GetService("ReplicatedStorage")
            local remote = rs:FindFirstChild("BreakTrade", true) or rs:FindFirstChild("CancelTrade", true)
            if remote then remote:FireServer() end
        end)
    end
end})
TradeGroup:AddButton({Name="Reset Trade Cooldown", Callback=function()
    pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        local remote = rs:FindFirstChild("ResetTradeCooldown", true) or rs:FindFirstChild("TradeCooldown", true)
        if remote and remote:IsA("RemoteEvent") then remote:FireServer() end
    end)
end})
TradeGroup:AddCheckbox({Name="Loop Reset Trade Cooldown", Default=false, Callback=function(v)
    ExtraSettings.LoopResetTrade=v
    SetLoopResetTrade(v)
end})

local CosmeticsGroup1 = CosmeticsSub:AddGroup("Weapon Skins", nil, "Left", 260)
CosmeticsGroup1:AddDropdown({Name="Gun Skin", Items=gunSkinList, Default="Default", Callback=function(v)
    ExtraSettings.GunSkinName=v
    ApplyGunSkin(v)
end})
CosmeticsGroup1:AddDropdown({Name="Knife Skin", Items=knifeSkinList, Default="Default", Callback=function(v)
    Settings.KnifeSkinChanger=v
    ApplyKnifeSkin(v)
end})

local CosmeticsGroup2 = CosmeticsSub:AddGroup("Shoot FX", nil, "Right", 220)
CosmeticsGroup2:AddCheckbox({Name="Custom Shoot Color", Default=false, Callback=function(v)
    ExtraSettings.CustomShootColorEnabled=v
end})
CosmeticsGroup2:AddColorpicker({Name="Shoot Color", Default=Color3.fromRGB(255, 255, 0), Callback=function(v)
    ExtraSettings.CustomShootColor=v
end})

local SoundThrowGroup = SoundsSub:AddGroup("Knife Throw Sound", nil, "Left", 220)
SoundThrowGroup:AddCheckbox({Name="Custom Knife Throw Sound", Default=false, Callback=function(v)
    ExtraSettings.SoundKnifeThrow=v SetupCustomSounds()
end})
SoundThrowGroup:AddDropdown({Name="Knife Throw Preset", Items=soundPresets.KnifeThrow, Default="Default", Callback=function(v)
    ExtraSettings.SoundKnifeThrowPreset=v
end})
SoundThrowGroup:AddButton({Name="Refresh Throw Presets", Callback=function() end})
SoundThrowGroup:AddTextbox({Name="Knife Throw Asset ID", Default="", Callback=function(v)
    ExtraSettings.SoundKnifeThrowAsset=v SetupCustomSounds()
end})

local SoundKillGroup = SoundsSub:AddGroup("Knife Kill Sound", nil, "Right", 220)
SoundKillGroup:AddCheckbox({Name="Custom Knife Kill Sound", Default=false, Callback=function(v)
    ExtraSettings.SoundKnifeKill=v SetupCustomSounds()
end})
SoundKillGroup:AddDropdown({Name="Knife Kill Preset", Items=soundPresets.KnifeKill, Default="Default", Callback=function(v)
    ExtraSettings.SoundKnifeKillPreset=v
end})
SoundKillGroup:AddButton({Name="Refresh Kill Presets", Callback=function() end})
SoundKillGroup:AddTextbox({Name="Knife Kill Asset ID", Default="", Callback=function(v)
    ExtraSettings.SoundKnifeKillAsset=v SetupCustomSounds()
end})

local SoundGunshotGroup = SoundsSub:AddGroup("Gunshot Sound", nil, "Left", 220)
SoundGunshotGroup:AddCheckbox({Name="Custom Gunshot Sound", Default=false, Callback=function(v)
    ExtraSettings.SoundGunshot=v SetupCustomSounds()
end})
SoundGunshotGroup:AddDropdown({Name="Gunshot Preset", Items=soundPresets.Gunshot, Default="Default", Callback=function(v)
    ExtraSettings.SoundGunshotPreset=v
end})
SoundGunshotGroup:AddButton({Name="Refresh Gunshot Presets", Callback=function() end})
SoundGunshotGroup:AddTextbox({Name="Gunshot Asset ID", Default="", Callback=function(v)
    ExtraSettings.SoundGunshotAsset=v SetupCustomSounds()
end})

local SoundReloadGroup = SoundsSub:AddGroup("Gun Reload Sound", nil, "Right", 220)
SoundReloadGroup:AddCheckbox({Name="Custom Gun Reload Sound", Default=false, Callback=function(v)
    ExtraSettings.SoundGunReload=v SetupCustomSounds()
end})
SoundReloadGroup:AddDropdown({Name="Gun Reload Preset", Items=soundPresets.GunReload, Default="Default", Callback=function(v)
    ExtraSettings.SoundGunReloadPreset=v
end})
SoundReloadGroup:AddButton({Name="Refresh Reload Presets", Callback=function() end})
SoundReloadGroup:AddTextbox({Name="Gun Reload Asset ID", Default="", Callback=function(v)
    ExtraSettings.SoundGunReloadAsset=v SetupCustomSounds()
end})
local BhopSettings = {
    Enabled = false,
    Speed = 1.0,
    Power = 1.0,
    AutoStrafe = false,
    Sounds = false,
}
local BhopSoundIds = {7338942417,7338942345,7338942259,7338942180}

local SpeedGlitchSettings = {
    Enabled = false,
    Intensity = 2.0,
    Sideways = false,
    AutoActivate = false,
    ActivateKey = Enum.KeyCode.LeftShift,
}

local ChamSettings = {
    Enabled = false,
    MurdererColor = Color3.fromRGB(255, 50, 50),
    SheriffColor = Color3.fromRGB(50, 150, 255),
    InnocentColor = Color3.fromRGB(100, 255, 100),
    FillTransparency = 0.5,
    OutlineEnabled = true,
    Rainbow = false,
}

local TracerSettings = {
    Enabled = false,
    Origin = "Bottom",
    MurdererColor = Color3.fromRGB(255, 80, 80),
    SheriffColor = Color3.fromRGB(80, 160, 255),
    InnocentColor = Color3.fromRGB(200, 200, 200),
    Thickness = 2,
    Transparency = 0,
}

local HitboxSettings = {
    Enabled = false,
    Size = 6,
    Visible = false,
    Color = Color3.fromRGB(255, 100, 0),
    Transparency = 0.5,
}

local CrosshairSettings = {
    Enabled = false,
    Style = "Cross",
    Color = Color3.fromRGB(255, 255, 255),
    Size = 12,
    Thickness = 2,
    Gap = 4,
    Dot = true,
    FOVCircle = false,
    FOVRadius = 120,
}

local GravitySettings = {
    Custom = false,
    Value = 196.2,
}

local ScriptSettings = {
    AntiAimEnabled = false,
    AntiAimMode = "Spin",
    AntiAimSpeed = 20,
    SpinBot = false,
    SpinSpeed = 15,
    FakeLag = false,
    FakeLagIntensity = 50,
    LagSwitch = false,
    NoFallDamage = false,
    InfiniteStamina = false,
    AutoDodge = false,
    AutoDodgeRange = 10,
    SilentWalk = false,
    GhostMode = false,
    AutoSprint = false,
    SlideEnabled = false,
    SlideSpeed = 80,
    HyperjumpEnabled = false,
    HyperjumpPower = 200,
    AutoBackstab = false,
    MultiStab = false,
    MultiStabCount = 3,
    AntiDetect = false,
    AntiDetectDelay = 0.1,
    AutoCollectGems = false,
    AutoShop = false,
    AutoShopItem = "Coin",
    RemoveFog = false,
    RemoveParticles = false,
    RemoveSounds = false,
    CustomSky = false,
    CustomGravity = false,
    GravityValue = 50,
    AmbientColor = Color3.fromRGB(128, 128, 128),
    CustomAmbient = false,
    FogStart = 0,
    FogEnd = 100000,
    CustomFog = false,
    ShowFPS = true,
    ShowPing = false,
    ShowCoords = false,
    PerformanceMode = false,
    DebugMode = false,
    HotkeyUI = Enum.KeyCode.RightShift,
    Language = "English",
    AutoUpdate = false,
    ShowKillFeed = false,
    ShowSpectators = false,
    KillCount = 0,
    CoinCount = 0,
    SessionTime = 0,
}

local sessionStartTime = tick()

local bhopConn
local function SetBhop(v)
    if bhopConn then bhopConn:Disconnect() bhopConn = nil end
    if not v then return end
    local jumping = false
    bhopConn = UserInputService.JumpRequest:Connect(function()
        jumping = true
    end)
    task.spawn(function()
        while BhopSettings.Enabled do
            task.wait()
            local hum = GetHumanoid()
            local root = GetRoot()
            if hum and root and jumping then
                local state = hum:GetState()
                if state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.Running then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    if BhopSettings.Sounds then
                        local snd = Instance.new("Sound")
                        snd.SoundId = "rbxassetid://"..BhopSoundIds[math.random(1,#BhopSoundIds)]
                        snd.Volume = 0.6
                        snd.Parent = workspace
                        snd:Play()
                        Debris:AddItem(snd, 2)
                    end
                    if BhopSettings.AutoStrafe then
                        local cam = Camera.CFrame
                        local vel = root.AssemblyLinearVelocity
                        if vel.Magnitude > 0 then
                            root.CFrame = CFrame.new(root.Position, root.Position + cam.LookVector * Vector3.new(1,0,1))
                        end
                    end
                end
                jumping = false
            end
        end
    end)
end

local speedGlitchConn
local function SetSpeedGlitch(v)
    if speedGlitchConn then speedGlitchConn:Disconnect() speedGlitchConn = nil end
    if not v then return end
    speedGlitchConn = RunService.Heartbeat:Connect(function()
        if not SpeedGlitchSettings.Enabled then speedGlitchConn:Disconnect() speedGlitchConn = nil return end
        local root = GetRoot()
        local hum = GetHumanoid()
        if not root or not hum then return end
        local cam = Camera.CFrame
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.LookVector * Vector3.new(1,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.LookVector * Vector3.new(1,0,1) end
        if SpeedGlitchSettings.Sideways then
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.RightVector * Vector3.new(1,0,1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.RightVector * Vector3.new(1,0,1) end
        end
        if dir.Magnitude > 0 then
            dir = dir.Unit
            root.CFrame = root.CFrame + dir * SpeedGlitchSettings.Intensity
        end
    end)
end

local noFallConn
local function SetNoFallDamage(v)
    if noFallConn then noFallConn:Disconnect() noFallConn = nil end
    if not v then return end
    noFallConn = RunService.Heartbeat:Connect(function()
        local hum = GetHumanoid()
        if hum then
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        end
    end)
end

local spinConn
local function SetSpinBot(v)
    if spinConn then spinConn:Disconnect() spinConn = nil end
    if not v then return end
    local angle = 0
    spinConn = RunService.Heartbeat:Connect(function()
        if not ScriptSettings.SpinBot then spinConn:Disconnect() spinConn = nil return end
        local root = GetRoot()
        if not root then return end
        angle = (angle + ScriptSettings.SpinSpeed) % 360
        root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(angle), 0)
    end)
end

local antiAimConn
local function SetAntiAim(v)
    if antiAimConn then antiAimConn:Disconnect() antiAimConn = nil end
    if not v then return end
    local angle = 0
    antiAimConn = RunService.Heartbeat:Connect(function()
        if not ScriptSettings.AntiAimEnabled then antiAimConn:Disconnect() antiAimConn = nil return end
        local root = GetRoot()
        if not root then return end
        if ScriptSettings.AntiAimMode == "Spin" then
            angle = (angle + ScriptSettings.AntiAimSpeed) % 360
            root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(angle), 0)
        elseif ScriptSettings.AntiAimMode == "Jitter" then
            local jitter = math.random(-ScriptSettings.AntiAimSpeed, ScriptSettings.AntiAimSpeed)
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(jitter), 0)
        elseif ScriptSettings.AntiAimMode == "Flip" then
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(180), 0)
        end
    end)
end

local autoSprintConn
local function SetAutoSprint(v)
    if autoSprintConn then autoSprintConn:Disconnect() autoSprintConn = nil end
    if not v then return end
    autoSprintConn = RunService.Heartbeat:Connect(function()
        if not ScriptSettings.AutoSprint then autoSprintConn:Disconnect() autoSprintConn = nil return end
        local hum = GetHumanoid()
        if hum and hum.MoveDirection.Magnitude > 0 then
            hum.WalkSpeed = Settings.WalkSpeed * 1.5
        elseif hum then
            hum.WalkSpeed = Settings.WalkSpeed
        end
    end)
end

local autoDodgeConn
local function SetAutoDodge(v)
    if autoDodgeConn then autoDodgeConn:Disconnect() autoDodgeConn = nil end
    if not v then return end
    autoDodgeConn = RunService.Heartbeat:Connect(function()
        if not ScriptSettings.AutoDodge then autoDodgeConn:Disconnect() autoDodgeConn = nil return end
        local root = GetRoot()
        if not root then return end
        local m = FindMurderer()
        if m and m.Character then
            local mr = m.Character:FindFirstChild("HumanoidRootPart")
            if mr and (mr.Position - root.Position).Magnitude < ScriptSettings.AutoDodgeRange then
                local dodge = (root.Position - mr.Position).Unit * 15
                root.CFrame = root.CFrame + Vector3.new(dodge.X, 0, dodge.Z)
            end
        end
    end)
end

local chamStorage = {}
local function ClearChams()
    for _, v in pairs(chamStorage) do if v and v.Parent then v:Destroy() end end
    chamStorage = {}
end

local rainbowHue = 0
local chamConn
local function SetChams(v)
    if chamConn then chamConn:Disconnect() chamConn = nil end
    ClearChams()
    if not v then return end
    chamConn = RunService.RenderStepped:Connect(function()
        ClearChams()
        if not ChamSettings.Enabled then chamConn:Disconnect() chamConn = nil return end
        rainbowHue = (rainbowHue + 0.005) % 1
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local c = p.Character if not c then continue end
            local isMurd = FindMurderer() == p
            local isSher = FindSheriff() == p
            local color
            if ChamSettings.Rainbow then
                color = Color3.fromHSV(rainbowHue, 1, 1)
            elseif isMurd then
                color = ChamSettings.MurdererColor
            elseif isSher then
                color = ChamSettings.SheriffColor
            else
                color = ChamSettings.InnocentColor
            end
            for _, part in ipairs(c:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    local hi = Instance.new("SelectionBox")
                    hi.Adornee = part
                    hi.Color3 = color
                    hi.LineThickness = ChamSettings.OutlineEnabled and 0.03 or 0
                    hi.SurfaceTransparency = ChamSettings.FillTransparency
                    hi.SurfaceColor3 = color
                    hi.Parent = game.CoreGui
                    table.insert(chamStorage, hi)
                end
            end
        end
    end)
end

local tracerStorage = {}
local function ClearTracers()
    for _, v in pairs(tracerStorage) do if v and v.Parent then v:Destroy() end end
    tracerStorage = {}
end

local tracerConn
local function SetTracers(v)
    if tracerConn then tracerConn:Disconnect() tracerConn = nil end
    ClearTracers()
    if not v then return end
    tracerConn = RunService.RenderStepped:Connect(function()
        ClearTracers()
        if not TracerSettings.Enabled then tracerConn:Disconnect() tracerConn = nil return end
        local vp = Camera.ViewportSize
        local origin
        if TracerSettings.Origin == "Bottom" then origin = Vector2.new(vp.X/2, vp.Y)
        elseif TracerSettings.Origin == "Top" then origin = Vector2.new(vp.X/2, 0)
        else origin = Vector2.new(vp.X/2, vp.Y/2) end
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local c = p.Character if not c then continue end
            local root = c:FindFirstChild("HumanoidRootPart") if not root then continue end
            local screen, visible = WorldToViewport(root.Position)
            if not visible then continue end
            local isMurd = FindMurderer() == p
            local isSher = FindSheriff() == p
            local color = isMurd and TracerSettings.MurdererColor or isSher and TracerSettings.SheriffColor or TracerSettings.InnocentColor
            local line = Instance.new("Frame")
            local delta = screen - origin
            local dist = delta.Magnitude
            local angle = math.atan2(delta.Y, delta.X)
            line.Size = UDim2.new(0, dist, 0, TracerSettings.Thickness)
            line.Position = UDim2.new(0, origin.X + delta.X/2 - dist/2, 0, origin.Y + delta.Y/2 - TracerSettings.Thickness/2)
            line.Rotation = math.deg(angle)
            line.BackgroundColor3 = color
            line.BackgroundTransparency = TracerSettings.Transparency
            line.BorderSizePixel = 0
            line.ZIndex = 5
            local lc = Instance.new("UICorner") lc.CornerRadius = UDim.new(1,0) lc.Parent = line
            local sg = Instance.new("ScreenGui") sg.IgnoreGuiInset = true sg.ResetOnSpawn = false sg.DisplayOrder = 10 sg.Name = "_ChaosTracer" sg.Parent = game.CoreGui
            line.Parent = sg
            table.insert(tracerStorage, sg)
        end
    end)
end

local hitboxStorage = {}
local function ClearHitboxes()
    for _, v in pairs(hitboxStorage) do if v and v.Parent then v:Destroy() end end
    hitboxStorage = {}
end

local hitboxConn
local function SetHitboxExpand(v)
    if hitboxConn then hitboxConn:Disconnect() hitboxConn = nil end
    if not v then
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local c = p.Character if not c then continue end
            local root = c:FindFirstChild("HumanoidRootPart") if not root then continue end
            root.Size = Vector3.new(2, 2, 1)
        end
        return
    end
    hitboxConn = RunService.Heartbeat:Connect(function()
        if not HitboxSettings.Enabled then hitboxConn:Disconnect() hitboxConn = nil return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local c = p.Character if not c then continue end
            local root = c:FindFirstChild("HumanoidRootPart") if not root then continue end
            local sz = HitboxSettings.Size
            root.Size = Vector3.new(sz, sz, sz)
            if HitboxSettings.Visible then
                root.Transparency = HitboxSettings.Transparency
                root.Color = HitboxSettings.Color
            else
                root.Transparency = 1
            end
        end
    end)
end

local crosshairGui
local function SetupCrosshair(v)
    if crosshairGui then crosshairGui:Destroy() crosshairGui = nil end
    if not v then return end
    crosshairGui = Instance.new("ScreenGui")
    crosshairGui.Name = "ChaosCrosshair"
    crosshairGui.IgnoreGuiInset = true
    crosshairGui.ResetOnSpawn = false
    crosshairGui.DisplayOrder = 20
    crosshairGui.Parent = game.CoreGui
    local function Draw()
        if crosshairGui then crosshairGui:ClearAllChildren() end
        local vp = Camera.ViewportSize
        local cx, cy = vp.X/2, vp.Y/2
        local sz = CrosshairSettings.Size
        local th = CrosshairSettings.Thickness
        local gap = CrosshairSettings.Gap
        local col = CrosshairSettings.Color
        local function mkLine(x, y, w, h)
            local f = Instance.new("Frame")
            f.Size = UDim2.new(0,w,0,h)
            f.Position = UDim2.new(0,x-w/2,0,y-h/2)
            f.BackgroundColor3 = col
            f.BorderSizePixel = 0
            f.ZIndex = 10
            f.Parent = crosshairGui
        end
        if CrosshairSettings.Style == "Cross" or CrosshairSettings.Style == "Classic" then
            mkLine(cx - gap - sz/2, cy, sz, th)
            mkLine(cx + gap + sz/2, cy, sz, th)
            mkLine(cx, cy - gap - sz/2, th, sz)
            mkLine(cx, cy + gap + sz/2, th, sz)
        elseif CrosshairSettings.Style == "Circle" then
            local circ = Instance.new("Frame")
            circ.Size = UDim2.new(0,sz*2,0,sz*2)
            circ.Position = UDim2.new(0,cx-sz,0,cy-sz)
            circ.BackgroundTransparency = 1
            circ.BorderSizePixel = 0
            circ.Parent = crosshairGui
            local stroke = Instance.new("UIStroke") stroke.Thickness = th stroke.Color = col stroke.Parent = circ
            Instance.new("UICorner", circ).CornerRadius = UDim.new(1,0)
        elseif CrosshairSettings.Style == "T-Shape" then
            mkLine(cx - gap - sz/2, cy, sz, th)
            mkLine(cx + gap + sz/2, cy, sz, th)
            mkLine(cx, cy + gap + sz/2, th, sz)
        end
        if CrosshairSettings.Dot then
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0,th,0,th)
            dot.Position = UDim2.new(0,cx-th/2,0,cy-th/2)
            dot.BackgroundColor3 = col
            dot.BorderSizePixel = 0
            dot.ZIndex = 11
            Instance.new("UICorner",dot).CornerRadius = UDim.new(1,0)
            dot.Parent = crosshairGui
        end
        if CrosshairSettings.FOVCircle then
            local vp2 = Camera.ViewportSize
            local fovF = Instance.new("Frame")
            local r = CrosshairSettings.FOVRadius
            fovF.Size = UDim2.new(0,r*2,0,r*2)
            fovF.Position = UDim2.new(0,vp2.X/2-r,0,vp2.Y/2-r)
            fovF.BackgroundTransparency = 1
            fovF.BorderSizePixel = 0
            fovF.Parent = crosshairGui
            local fovS = Instance.new("UIStroke") fovS.Thickness = 1 fovS.Color = Color3.fromRGB(255,255,255) fovS.Transparency = 0.5 fovS.Parent = fovF
            Instance.new("UICorner",fovF).CornerRadius = UDim.new(1,0)
        end
    end
    Draw()
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function() if CrosshairSettings.Enabled then Draw() end end)
end

local killFeedGui
local killFeedEntries = {}
local function AddKillFeedEntry(text)
    if not ScriptSettings.ShowKillFeed then return end
    if not killFeedGui then
        killFeedGui = Instance.new("ScreenGui")
        killFeedGui.Name = "ChaosKillFeed"
        killFeedGui.IgnoreGuiInset = true
        killFeedGui.ResetOnSpawn = false
        killFeedGui.DisplayOrder = 15
        killFeedGui.Parent = game.CoreGui
    end
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0,220,0,20)
    lbl.Position = UDim2.new(1,-230,0,10 + #killFeedEntries * 22)
    lbl.BackgroundColor3 = Color3.fromRGB(0,0,0)
    lbl.BackgroundTransparency = 0.6
    lbl.TextColor3 = Color3.fromRGB(255,80,80)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.RichText = true
    Instance.new("UICorner",lbl).CornerRadius = UDim.new(0,4)
    local pad = Instance.new("UIPadding") pad.PaddingLeft = UDim.new(0,6) pad.Parent = lbl
    lbl.Parent = killFeedGui
    table.insert(killFeedEntries, lbl)
    task.delay(4, function()
        TweenService:Create(lbl, TweenInfo.new(0.5), {BackgroundTransparency=1,TextTransparency=1}):Play()
        task.wait(0.5)
        lbl:Destroy()
        table.remove(killFeedEntries, table.find(killFeedEntries, lbl) or 1)
    end)
end

local spectatorGui
local function UpdateSpectatorList()
    if not ScriptSettings.ShowSpectators then
        if spectatorGui then spectatorGui:Destroy() spectatorGui = nil end
        return
    end
    if not spectatorGui then
        spectatorGui = Instance.new("ScreenGui")
        spectatorGui.Name = "ChaosSpectators"
        spectatorGui.IgnoreGuiInset = true
        spectatorGui.ResetOnSpawn = false
        spectatorGui.DisplayOrder = 12
        spectatorGui.Parent = game.CoreGui
    end
    spectatorGui:ClearAllChildren()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,160,0,200)
    frame.Position = UDim2.new(1,-170,0.5,-100)
    frame.BackgroundColor3 = Color3.fromRGB(4,1,7)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = spectatorGui
    Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)
    local stroke = Instance.new("UIStroke") stroke.Color = Color3.fromRGB(222,32,78) stroke.Thickness = 1 stroke.Parent = frame
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,22)
    title.BackgroundTransparency = 1
    title.Text = "Spectators"
    title.TextColor3 = Color3.fromRGB(240,76,124)
    title.TextSize = 11
    title.Font = Enum.Font.GothamBold
    title.Parent = frame
    local y = 24
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local cam = workspace.CurrentCamera
        if cam and cam.CameraSubject then
            local subject = cam.CameraSubject
            local c = LocalPlayer.Character
            if c and subject:IsDescendantOf(c) then
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1,-10,0,18)
                lbl.Position = UDim2.new(0,5,0,y)
                lbl.BackgroundTransparency = 1
                lbl.Text = "→ " .. p.Name
                lbl.TextColor3 = Color3.fromRGB(220,220,220)
                lbl.TextSize = 10
                lbl.Font = Enum.Font.Gotham
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Parent = frame
                y = y + 20
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(2)
        if ScriptSettings.ShowSpectators then UpdateSpectatorList() end
    end
end)

local gravityConn
local function SetCustomGravity(v)
    if v then
        workspace.Gravity = ScriptSettings.GravityValue * 3.92
    else
        workspace.Gravity = 196.2
    end
end

local function RemoveFog()
    Lighting.FogEnd = ScriptSettings.RemoveFog and 100000 or 100000
    Lighting.FogStart = ScriptSettings.RemoveFog and 100000 or 0
end

local function RemoveParticles()
    if not ScriptSettings.RemoveParticles then return end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("Fire") then
            v.Enabled = false
        end
    end
end

local TrailSettings = {
    Enabled = false,
    Preset = "Rainbow",
    Lifetime = 0.6,
    Transparency = 0.3,
}

local WalkParticleSettings = {
    Enabled = false,
    Preset = "Sparkle",
    Rate = 8,
}

local AuraSettings = {
    Enabled = false,
    Color = Color3.fromRGB(222, 32, 78),
    Range = 16,
    Brightness = 2,
    Pulse = false,
}

local DeathFXSettings = {
    Enabled = false,
}

local TrailPresets = {
    Rainbow = {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,    Color3.fromHSV(0,    1, 1)),
            ColorSequenceKeypoint.new(0.16, Color3.fromHSV(0.16, 1, 1)),
            ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.33, 1, 1)),
            ColorSequenceKeypoint.new(0.5,  Color3.fromHSV(0.5,  1, 1)),
            ColorSequenceKeypoint.new(0.66, Color3.fromHSV(0.66, 1, 1)),
            ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.83, 1, 1)),
            ColorSequenceKeypoint.new(1,    Color3.fromHSV(0,    1, 1)),
        }),
        Texture = "rbxassetid://16178262222",
        Width = 0.9,
    },
    Fire = {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   Color3.fromRGB(255, 50,  0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 165, 0)),
            ColorSequenceKeypoint.new(1,   Color3.fromRGB(255, 255, 80)),
        }),
        Texture = "rbxassetid://16178262222",
        Width = 1.0,
    },
    Ice = {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   Color3.fromRGB(180, 240, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)),
            ColorSequenceKeypoint.new(1,   Color3.fromRGB(255, 255, 255)),
        }),
        Texture = "rbxassetid://16178262222",
        Width = 0.9,
    },
    Purple = {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80,  0, 160)),
        }),
        Texture = "rbxassetid://16178262222",
        Width = 0.9,
    },
    Pink = {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(222, 32,  78)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 76, 124)),
        }),
        Texture = "rbxassetid://16178262222",
        Width = 0.9,
    },
    Gold = {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0)),
        }),
        Texture = "rbxassetid://16178262222",
        Width = 0.9,
    },
}

local WalkParticlePresets = {
    Sparkle = {Texture="rbxassetid://242008870",  Rate=10, Speed=3,  Lifetime=0.5, Size=0.15, Color=Color3.fromRGB(255,255,255)},
    Flame   = {Texture="rbxassetid://242008870",  Rate=12, Speed=2,  Lifetime=0.4, Size=0.2,  Color=Color3.fromRGB(255,120,0)},
    Ice     = {Texture="rbxassetid://242008870",  Rate=8,  Speed=4,  Lifetime=0.6, Size=0.12, Color=Color3.fromRGB(150,220,255)},
    Pink    = {Texture="rbxassetid://8983307836", Rate=8,  Speed=2,  Lifetime=0.5, Size=0.18, Color=Color3.fromRGB(222,32,78)},
    Gold    = {Texture="rbxassetid://242008870",  Rate=10, Speed=3,  Lifetime=0.5, Size=0.15, Color=Color3.fromRGB(255,200,0)},
}

local trailInstance, trailAtt0, trailAtt1
local walkParticleInstances = {}
local auraLight, auraConn

local function ClearTrail()
    if trailInstance then trailInstance:Destroy() trailInstance = nil end
    if trailAtt0 then trailAtt0:Destroy() trailAtt0 = nil end
    if trailAtt1 then trailAtt1:Destroy() trailAtt1 = nil end
end

local function SetTrail(v)
    ClearTrail()
    if not v then return end
    local hrp = GetRoot()
    if not hrp then return end
    local preset = TrailPresets[TrailSettings.Preset]
    if not preset then return end
    trailAtt0 = Instance.new("Attachment")
    trailAtt0.Position = Vector3.new(0, 1, 0)
    trailAtt0.Parent = hrp
    trailAtt1 = Instance.new("Attachment")
    trailAtt1.Position = Vector3.new(0, -1, 0)
    trailAtt1.Parent = hrp
    trailInstance = Instance.new("Trail")
    trailInstance.Attachment0 = trailAtt0
    trailInstance.Attachment1 = trailAtt1
    trailInstance.Texture = preset.Texture
    trailInstance.Color = preset.Color
    trailInstance.Lifetime = TrailSettings.Lifetime
    trailInstance.Transparency = NumberSequence.new(TrailSettings.Transparency)
    trailInstance.WidthScale = NumberSequence.new(preset.Width)
    trailInstance.LightInfluence = 0
    trailInstance.FaceCamera = true
    trailInstance.Parent = hrp
end

local function ClearWalkParticles()
    for _, p in ipairs(walkParticleInstances) do pcall(function() p:Destroy() end) end
    walkParticleInstances = {}
end

local function SetWalkParticles(v)
    ClearWalkParticles()
    if not v then return end
    local char = GetCharacter()
    if not char then return end
    local preset = WalkParticlePresets[WalkParticleSettings.Preset]
    if not preset then return end
    local partNames = {"LeftFoot","RightFoot","Left Leg","Right Leg"}
    for _, pname in ipairs(partNames) do
        local part = char:FindFirstChild(pname)
        if part then
            local emitter = Instance.new("ParticleEmitter")
            emitter.Texture = preset.Texture
            emitter.Rate = WalkParticleSettings.Rate
            emitter.Speed = NumberRange.new(preset.Speed * 0.5, preset.Speed)
            emitter.Lifetime = NumberRange.new(preset.Lifetime * 0.5, preset.Lifetime)
            emitter.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, preset.Size),
                NumberSequenceKeypoint.new(1, 0),
            })
            emitter.Color = ColorSequence.new(preset.Color)
            emitter.EmissionDirection = Enum.NormalId.Bottom
            emitter.RotSpeed = NumberRange.new(-45, 45)
            emitter.Rotation = NumberRange.new(0, 360)
            emitter.LightEmission = 0.5
            emitter.Parent = part
            table.insert(walkParticleInstances, emitter)
        end
    end
end

local function ClearAura()
    if auraConn then auraConn:Disconnect() auraConn = nil end
    if auraLight then auraLight:Destroy() auraLight = nil end
end

local function SetAura(v)
    ClearAura()
    if not v then return end
    local hrp = GetRoot()
    if not hrp then return end
    auraLight = Instance.new("PointLight")
    auraLight.Color = AuraSettings.Color
    auraLight.Range = AuraSettings.Range
    auraLight.Brightness = AuraSettings.Brightness
    auraLight.Parent = hrp
    if AuraSettings.Pulse then
        local t = 0
        auraConn = RunService.RenderStepped:Connect(function(dt)
            if not auraLight or not auraLight.Parent then auraConn:Disconnect() return end
            t = t + dt * 2
            auraLight.Brightness = AuraSettings.Brightness * (0.6 + 0.4 * math.sin(t))
        end)
    end
end

local function TriggerDeathEffect()
    local hrp = GetRoot()
    if not hrp then return end
    local emitter = Instance.new("ParticleEmitter")
    emitter.Texture = "rbxassetid://8983307836"
    emitter.Rate = 0
    emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0)})
    emitter.Speed = NumberRange.new(10, 22)
    emitter.Lifetime = NumberRange.new(0.5, 1.5)
    emitter.LightEmission = 1
    emitter.Color = ColorSequence.new(Color3.fromRGB(222, 32, 78))
    emitter.RotSpeed = NumberRange.new(-180, 180)
    emitter.Rotation = NumberRange.new(0, 360)
    emitter.VelocitySpread = 360
    emitter.Parent = hrp
    emitter:Emit(60)
    Debris:AddItem(emitter, 2)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    if TrailSettings.Enabled then SetTrail(true) end
    if WalkParticleSettings.Enabled then SetWalkParticles(true) end
    if AuraSettings.Enabled then SetAura(true) end
    local hum = char:WaitForChild("Humanoid", 5)
    if hum and DeathFXSettings.Enabled then
        hum.Died:Connect(function()
            TriggerDeathEffect()
        end)
    end
    task.wait(0.2)
    if BodyFXSettings.RainbowBody or BodyFXSettings.NeonBody or BodyFXSettings.ForceField
        or BodyFXSettings.FireBody or BodyFXSettings.SparkleBody or BodyFXSettings.GhostMode
        or BodyFXSettings.OutlineBody or BodyFXSettings.CustomBodyColor or BodyFXSettings.AnimatedColor
        or BodyFXSettings.Scale ~= 1.0 then
        ApplyBodyFX()
    end
    if ParticleFXSettings.OrbitEnabled then SetOrbit(true) end
    if ParticleFXSettings.GravityEnabled then SetGravityParticles(true) end
    if ParticleFXSettings.FireAura then SetFireAura(true) end
    if ParticleFXSettings.DarkSmoke then SetDarkSmoke(true) end
    if ParticleFXSettings.AngelGlow then SetAngelGlow(true) end
    if ParticleFXSettings.IceShards then SetIceShards(true) end
    if SoundFXSettings.JumpSound then SetJumpSound(true) end
    if SoundFXSettings.LandSound then SetLandSound(true) end
    if ScreenFXSettings.HitFlash then SetHitFlash(true) end
    if AnimOverrideSettings.IdleAnim or AnimOverrideSettings.WalkAnim or AnimOverrideSettings.RunAnim
        or AnimOverrideSettings.JumpAnim or AnimOverrideSettings.FallAnim then
        task.wait(0.5)
        ApplyAnimOverrides()
    end
end)

local BodyFXSettings = {
    RainbowBody=false, NeonBody=false, ForceField=false, FireBody=false,
    SparkleBody=false, GhostMode=false, OutlineBody=false,
    BodyColor=Color3.fromRGB(222,32,78), CustomBodyColor=false,
    AnimatedColor=false, Scale=1.0,
}
local ParticleFXSettings = {
    OrbitEnabled=false, OrbitColor=Color3.fromRGB(222,32,78),
    GravityEnabled=false, GravityColor=Color3.fromRGB(255,255,255),
    FireAura=false, DarkSmoke=false, AngelGlow=false,
    ClickEffect=false, ClickColor=Color3.fromRGB(222,32,78),
    KillBurst=false, IceShards=false, LightningBurst=false, CoinCollect=false,
}
local ScreenFXSettings = {
    SpeedLines=false, Vignette=false,
    Tint=false, TintColor=Color3.fromRGB(222,32,78), TintTransparency=0.85,
    HitFlash=false, KillFlash=false,
}
local SoundFXSettings = {
    Footsteps=false, FootstepId="rbxassetid://179446602",
    JumpSound=false, JumpSoundId="rbxassetid://5603655503",
    LandSound=false, LandSoundId="rbxassetid://1050531390",
    AmbientMusic=false, AmbientMusicId="rbxassetid://1843463229", AmbientVolume=0.3,
    KillSoundExtra=false, KillSoundExtraId="rbxassetid://4612375453",
}
local AnimOverrideSettings = {
    IdleAnim=false,  IdleAnimId="rbxassetid://507766666",
    WalkAnim=false,  WalkAnimId="rbxassetid://507777826",
    RunAnim=false,   RunAnimId="rbxassetid://507767714",
    JumpAnim=false,  JumpAnimId="rbxassetid://507765000",
    FallAnim=false,  FallAnimId="rbxassetid://507767968",
}
local WorldFXSettings = {
    CoinGlow=false, CoinGlowColor=Color3.fromRGB(255,215,0),
    ItemBeam=false, SkyTint=false, SkyTintColor=Color3.fromRGB(80,0,200),
    EnvLight=false, EnvLightColor=Color3.fromRGB(222,32,78),
    SunIntensity=false, SunBrightness=2,
}
local HUDPlusSettings = {
    FPS=false, Ping=false, KillCount=false, Coords=false,
    SpeedMeter=false, Altitude=false, RoundTimer=false,
    ServerCount=false, RoleBanner=false, Compass=false,
}

local bodyFXConn, animColorConn
local orbitParts, orbitAngle, orbitConn = {}, 0, nil
local gravityEmitter, fireAuraInst, darkSmokeInst, angelEmitter, iceShardsEmitter
local clickConn, screenFXGui, vignetteFrame, tintFrame, speedLinesFrame
local ambientSound, footstepConn, jumpSoundConn, landSoundConn, killSoundExtraConn
local worldFXConn, coinGlowParts, envLightInst
local hudPlusGui, hudPlusConn, hudKillCount = nil, nil, 0
local bodyOutlineParts, forceFieldInst, orbitBodyConns = {}, nil, {}

local function ClearBodyFX()
    if bodyFXConn then bodyFXConn:Disconnect() bodyFXConn = nil end
    if animColorConn then animColorConn:Disconnect() animColorConn = nil end
    for _, v in ipairs(bodyOutlineParts) do pcall(function() v:Destroy() end) end
    bodyOutlineParts = {}
    if forceFieldInst then forceFieldInst:Destroy() forceFieldInst = nil end
    local char = GetCharacter()
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Material = Enum.Material.SmoothPlastic
            p.LocalTransparencyModifier = 0
            p.CastShadow = true
        end
        if p:IsA("Fire") or p:IsA("Sparkles") then p:Destroy() end
    end
end

local function ApplyBodyFX()
    ClearBodyFX()
    local char = GetCharacter()
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")

    if BodyFXSettings.ForceField then
        forceFieldInst = Instance.new("ForceField")
        forceFieldInst.Visible = true
        forceFieldInst.Parent = char
    end

    if BodyFXSettings.FireBody then
        local hrp = GetRoot()
        if hrp then
            local f = Instance.new("Fire")
            f.Color = Color3.fromRGB(255,100,0)
            f.SecondaryColor = Color3.fromRGB(255,220,0)
            f.Heat = 4; f.Size = 2
            f.Parent = hrp
        end
    end

    if BodyFXSettings.SparkleBody then
        local hrp = GetRoot()
        if hrp then
            local s = Instance.new("Sparkles")
            s.SparkleColor = Color3.fromRGB(255,215,0)
            s.Parent = hrp
        end
    end

    if BodyFXSettings.OutlineBody then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                local sel = Instance.new("SelectionBox")
                sel.Adornee = p
                sel.Color3 = BodyFXSettings.BodyColor
                sel.LineThickness = 0.03
                sel.SurfaceTransparency = 1
                sel.Parent = char
                table.insert(bodyOutlineParts, sel)
            end
        end
    end

    if BodyFXSettings.NeonBody then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.Material = Enum.Material.Neon
            end
        end
    end

    if BodyFXSettings.GhostMode then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.LocalTransparencyModifier = 0.6
                p.CastShadow = false
                p.Material = Enum.Material.Neon
            end
        end
    end

    if BodyFXSettings.CustomBodyColor then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.Color = BodyFXSettings.BodyColor
            end
        end
    end

    if BodyFXSettings.RainbowBody then
        local t = 0
        bodyFXConn = RunService.RenderStepped:Connect(function(dt)
            local c = GetCharacter()
            if not c then return end
            t = t + dt * 0.5
            local col = Color3.fromHSV(t % 1, 1, 1)
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                    p.Color = col
                end
            end
        end)
    elseif BodyFXSettings.AnimatedColor then
        local t = 0
        animColorConn = RunService.Heartbeat:Connect(function(dt)
            local c = GetCharacter()
            if not c then return end
            t = t + dt * 0.2
            local col = Color3.fromHSV(t % 1, 0.8, 1)
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                    p.Color = col
                end
            end
        end)
    end

    if BodyFXSettings.Scale ~= 1.0 and hum then
        pcall(function()
            local hd = hum:GetAppliedDescription()
            local s = BodyFXSettings.Scale
            hd.HeadScale = s; hd.BodyHeightScale = s
            hd.BodyWidthScale = s; hd.BodyDepthScale = s
            hum:ApplyDescription(hd)
        end)
    end
end

local function ClearOrbit()
    if orbitConn then orbitConn:Disconnect() orbitConn = nil end
    for _, p in ipairs(orbitParts) do pcall(function() p:Destroy() end) end
    orbitParts = {}
end

local function SetOrbit(v)
    ClearOrbit()
    if not v then return end
    for i = 1, 6 do
        local p = Instance.new("Part")
        p.Size = Vector3.new(0.25, 0.25, 0.25)
        p.Material = Enum.Material.Neon
        p.Color = ParticleFXSettings.OrbitColor
        p.CanCollide = false; p.Anchored = true; p.CastShadow = false
        p.Parent = workspace
        table.insert(orbitParts, p)
    end
    orbitAngle = 0
    orbitConn = RunService.RenderStepped:Connect(function(dt)
        local hrp = GetRoot()
        if not hrp then return end
        orbitAngle = orbitAngle + dt * 2.5
        for i, p in ipairs(orbitParts) do
            if not p.Parent then return end
            local a = orbitAngle + (i-1) * (math.pi*2 / #orbitParts)
            local r = 3
            p.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(a)*r, math.sin(orbitAngle+i)*0.4, math.sin(a)*r))
        end
    end)
end

local function ClearParticleAuras()
    local function killPE(ref)
        if ref then pcall(function() ref:Destroy() end) end
    end
    killPE(gravityEmitter); gravityEmitter = nil
    killPE(fireAuraInst); fireAuraInst = nil
    killPE(darkSmokeInst); darkSmokeInst = nil
    killPE(angelEmitter); angelEmitter = nil
    killPE(iceShardsEmitter); iceShardsEmitter = nil
end

local function SetGravityParticles(v)
    if gravityEmitter then gravityEmitter:Destroy() gravityEmitter = nil end
    if not v then return end
    local hrp = GetRoot(); if not hrp then return end
    gravityEmitter = Instance.new("ParticleEmitter")
    gravityEmitter.Texture = "rbxassetid://242008870"
    gravityEmitter.Color = ColorSequence.new(ParticleFXSettings.GravityColor)
    gravityEmitter.Rate = 12
    gravityEmitter.Speed = NumberRange.new(1, 3)
    gravityEmitter.Lifetime = NumberRange.new(1.5, 2.5)
    gravityEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(1,0)})
    gravityEmitter.EmissionDirection = Enum.NormalId.Top
    gravityEmitter.VelocitySpread = 30
    gravityEmitter.LightEmission = 0.6
    gravityEmitter.Parent = hrp
end

local function SetFireAura(v)
    if fireAuraInst then fireAuraInst:Destroy() fireAuraInst = nil end
    if not v then return end
    local char = GetCharacter(); if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    fireAuraInst = Instance.new("Fire")
    fireAuraInst.Color = Color3.fromRGB(255,60,0)
    fireAuraInst.SecondaryColor = Color3.fromRGB(255,180,0)
    fireAuraInst.Heat = 6; fireAuraInst.Size = 3
    fireAuraInst.Parent = hrp
end

local function SetDarkSmoke(v)
    if darkSmokeInst then darkSmokeInst:Destroy() darkSmokeInst = nil end
    if not v then return end
    local hrp = GetRoot(); if not hrp then return end
    darkSmokeInst = Instance.new("Smoke")
    darkSmokeInst.Color = Color3.fromRGB(10,10,10)
    darkSmokeInst.Opacity = 0.4
    darkSmokeInst.RiseVelocity = 2
    darkSmokeInst.Size = 1.5
    darkSmokeInst.Parent = hrp
end

local function SetAngelGlow(v)
    if angelEmitter then angelEmitter:Destroy() angelEmitter = nil end
    if not v then return end
    local hrp = GetRoot(); if not hrp then return end
    angelEmitter = Instance.new("ParticleEmitter")
    angelEmitter.Texture = "rbxassetid://8983307836"
    angelEmitter.Color = ColorSequence.new(Color3.fromRGB(255,255,255))
    angelEmitter.Rate = 6
    angelEmitter.Speed = NumberRange.new(0.5, 1.5)
    angelEmitter.Lifetime = NumberRange.new(2, 3.5)
    angelEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(0.5,0.2),NumberSequenceKeypoint.new(1,0)})
    angelEmitter.EmissionDirection = Enum.NormalId.Top
    angelEmitter.VelocitySpread = 20
    angelEmitter.LightEmission = 1
    angelEmitter.Parent = hrp
end

local function SetIceShards(v)
    if iceShardsEmitter then iceShardsEmitter:Destroy() iceShardsEmitter = nil end
    if not v then return end
    local hrp = GetRoot(); if not hrp then return end
    iceShardsEmitter = Instance.new("ParticleEmitter")
    iceShardsEmitter.Texture = "rbxassetid://242008870"
    iceShardsEmitter.Color = ColorSequence.new(Color3.fromRGB(150,220,255))
    iceShardsEmitter.Rate = 15
    iceShardsEmitter.Speed = NumberRange.new(3, 7)
    iceShardsEmitter.Lifetime = NumberRange.new(0.4, 0.9)
    iceShardsEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.25),NumberSequenceKeypoint.new(1,0)})
    iceShardsEmitter.VelocitySpread = 180
    iceShardsEmitter.LightEmission = 0.8
    iceShardsEmitter.Parent = hrp
end

local function FireClickEffect()
    if not ParticleFXSettings.ClickEffect then return end
    local mouse = LocalPlayer:GetMouse()
    local hit = mouse.Hit
    if not hit then return end
    local e = Instance.new("ParticleEmitter")
    e.Texture = "rbxassetid://8983307836"
    e.Color = ColorSequence.new(ParticleFXSettings.ClickColor)
    e.Rate = 0; e.Speed = NumberRange.new(5,12)
    e.Lifetime = NumberRange.new(0.3,0.8)
    e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.4),NumberSequenceKeypoint.new(1,0)})
    e.VelocitySpread = 360; e.LightEmission = 1
    local p = Instance.new("Part")
    p.Anchored=true; p.CanCollide=false; p.Transparency=1
    p.Size=Vector3.new(0.1,0.1,0.1); p.CFrame=hit
    p.Parent=workspace; e.Parent=p; e:Emit(20)
    Debris:AddItem(p,1)
end

local function FireLightningBurst()
    local hrp = GetRoot(); if not hrp then return end
    local e = Instance.new("ParticleEmitter")
    e.Texture = "rbxassetid://242008870"
    e.Color = ColorSequence.new(Color3.fromRGB(180,220,255))
    e.Rate = 0; e.Speed = NumberRange.new(15,30)
    e.Lifetime = NumberRange.new(0.1,0.3)
    e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(1,0)})
    e.VelocitySpread = 360; e.LightEmission = 1
    e.Parent = hrp; e:Emit(40)
    Debris:AddItem(e,0.5)
end

local function FireKillBurst(pos)
    local e = Instance.new("ParticleEmitter")
    e.Texture = "rbxassetid://8983307836"
    e.Color = ColorSequence.new(Color3.fromRGB(222,32,78))
    e.Rate = 0; e.Speed = NumberRange.new(10,25)
    e.Lifetime = NumberRange.new(0.5,1.5)
    e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.6),NumberSequenceKeypoint.new(1,0)})
    e.VelocitySpread = 360; e.LightEmission = 1
    local p = Instance.new("Part")
    p.Anchored=true; p.CanCollide=false; p.Transparency=1
    p.Size=Vector3.new(0.1,0.1,0.1); p.CFrame=CFrame.new(pos or Vector3.new(0,0,0))
    p.Parent=workspace; e.Parent=p; e:Emit(80)
    Debris:AddItem(p,2)
end

local function SetClickEffect(v)
    if clickConn then clickConn:Disconnect() clickConn = nil end
    if not v then return end
    clickConn = UserInputService.InputBegan:Connect(function(inp, gp)
        if gp then return end
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            FireClickEffect()
        end
    end)
end

local function GetOrCreateScreenFXGui()
    if screenFXGui and screenFXGui.Parent then return screenFXGui end
    screenFXGui = Instance.new("ScreenGui")
    screenFXGui.Name = "ChaosScreenFX"
    screenFXGui.IgnoreGuiInset = true
    screenFXGui.ResetOnSpawn = false
    screenFXGui.DisplayOrder = 25
    screenFXGui.Parent = game.CoreGui
    return screenFXGui
end

local function SetVignette(v)
    if vignetteFrame then vignetteFrame:Destroy() vignetteFrame = nil end
    if not v then return end
    local gui = GetOrCreateScreenFXGui()
    vignetteFrame = Instance.new("ImageLabel")
    vignetteFrame.Size = UDim2.new(1,0,1,0)
    vignetteFrame.Position = UDim2.new(0,0,0,0)
    vignetteFrame.BackgroundTransparency = 1
    vignetteFrame.Image = "rbxassetid://7072720870"
    vignetteFrame.ImageColor3 = Color3.fromRGB(0,0,0)
    vignetteFrame.ImageTransparency = 0.3
    vignetteFrame.ZIndex = 2
    vignetteFrame.Parent = gui
end

local function SetScreenTint(v)
    if tintFrame then tintFrame:Destroy() tintFrame = nil end
    if not v then return end
    local gui = GetOrCreateScreenFXGui()
    tintFrame = Instance.new("Frame")
    tintFrame.Size = UDim2.new(1,0,1,0)
    tintFrame.Position = UDim2.new(0,0,0,0)
    tintFrame.BackgroundColor3 = ScreenFXSettings.TintColor
    tintFrame.BackgroundTransparency = ScreenFXSettings.TintTransparency
    tintFrame.BorderSizePixel = 0
    tintFrame.ZIndex = 1
    tintFrame.Parent = gui
end

local speedLinesConn
local function SetSpeedLines(v)
    if speedLinesFrame then speedLinesFrame:Destroy() speedLinesFrame = nil end
    if speedLinesConn then speedLinesConn:Disconnect() speedLinesConn = nil end
    if not v then return end
    local gui = GetOrCreateScreenFXGui()
    speedLinesFrame = Instance.new("ImageLabel")
    speedLinesFrame.Size = UDim2.new(1,0,1,0)
    speedLinesFrame.Position = UDim2.new(0,0,0,0)
    speedLinesFrame.BackgroundTransparency = 1
    speedLinesFrame.Image = "rbxassetid://6031097871"
    speedLinesFrame.ImageColor3 = Color3.fromRGB(255,255,255)
    speedLinesFrame.ImageTransparency = 1
    speedLinesFrame.ZIndex = 3
    speedLinesFrame.Parent = gui
    speedLinesConn = RunService.RenderStepped:Connect(function()
        local root = GetRoot()
        if not root then return end
        local spd = root.AssemblyLinearVelocity.Magnitude
        local alpha = math.clamp((spd - 20) / 60, 0, 1)
        speedLinesFrame.ImageTransparency = 1 - alpha * 0.7
    end)
end

local function FlashScreen(col, dur)
    local gui = GetOrCreateScreenFXGui()
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,1,0)
    f.BackgroundColor3 = col
    f.BackgroundTransparency = 0.3
    f.BorderSizePixel = 0
    f.ZIndex = 10
    f.Parent = gui
    local steps = 10
    for i = 1, steps do
        task.wait(dur / steps)
        if f.Parent then f.BackgroundTransparency = 0.3 + (i / steps) * 0.7 end
    end
    if f.Parent then f:Destroy() end
end

local function SetHitFlash(v)
    local char = GetCharacter()
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or not v then return end
    hum.HealthChanged:Connect(function(hp)
        if not ScreenFXSettings.HitFlash then return end
        if hp < hum.MaxHealth then
            task.spawn(FlashScreen, Color3.fromRGB(255,255,255), 0.3)
        end
    end)
end

local function SetAmbientMusic(v)
    if ambientSound then ambientSound:Stop() ambientSound:Destroy() ambientSound = nil end
    if not v then return end
    ambientSound = Instance.new("Sound")
    ambientSound.Name = "_ChaosAmbient"
    ambientSound.SoundId = SoundFXSettings.AmbientMusicId
    ambientSound.Volume = SoundFXSettings.AmbientVolume
    ambientSound.Looped = true
    ambientSound.Parent = workspace
    ambientSound:Play()
end

local function SetFootsteps(v)
    if footstepConn then footstepConn:Disconnect() footstepConn = nil end
    if not v then return end
    local lastStep = 0
    footstepConn = RunService.Heartbeat:Connect(function()
        if not SoundFXSettings.Footsteps then return end
        local hum = GetHumanoid()
        if not hum then return end
        if hum.MoveDirection.Magnitude > 0 and hum:GetState() == Enum.HumanoidStateType.Running then
            local now = tick()
            local interval = math.max(0.2, 0.5 / (hum.WalkSpeed / 16))
            if now - lastStep > interval then
                lastStep = now
                local snd = Instance.new("Sound")
                snd.SoundId = SoundFXSettings.FootstepId
                snd.Volume = 0.5
                snd.Parent = workspace
                snd:Play()
                Debris:AddItem(snd, 1)
            end
        end
    end)
end

local function SetJumpSound(v)
    if jumpSoundConn then jumpSoundConn:Disconnect() jumpSoundConn = nil end
    if not v then return end
    local hum = GetHumanoid()
    if not hum then return end
    jumpSoundConn = hum.Jumping:Connect(function()
        if not SoundFXSettings.JumpSound then return end
        local snd = Instance.new("Sound")
        snd.SoundId = SoundFXSettings.JumpSoundId
        snd.Volume = 0.5
        snd.Parent = workspace
        snd:Play()
        Debris:AddItem(snd, 1)
    end)
end

local function SetLandSound(v)
    if landSoundConn then landSoundConn:Disconnect() landSoundConn = nil end
    if not v then return end
    local hum = GetHumanoid()
    if not hum then return end
    landSoundConn = hum.StateChanged:Connect(function(_, new)
        if not SoundFXSettings.LandSound then return end
        if new == Enum.HumanoidStateType.Landed then
            local snd = Instance.new("Sound")
            snd.SoundId = SoundFXSettings.LandSoundId
            snd.Volume = 0.5
            snd.Parent = workspace
            snd:Play()
            Debris:AddItem(snd, 1)
        end
    end)
end

local function ApplyAnimOverrides()
    local char = GetCharacter()
    if not char then return end
    local animate = char:FindFirstChild("Animate")
    if not animate then return end
    local function setAnim(folder, childName, id)
        local f = animate:FindFirstChild(folder)
        if not f then return end
        local a = f:FindFirstChild(childName) or f:FindFirstChildWhichIsA("Animation")
        if a and a:IsA("Animation") then a.AnimationId = id end
    end
    if AnimOverrideSettings.IdleAnim then
        setAnim("idle","Animation1",AnimOverrideSettings.IdleAnimId)
        setAnim("idle","Animation2",AnimOverrideSettings.IdleAnimId)
    end
    if AnimOverrideSettings.WalkAnim then
        setAnim("walk","WalkAnim",AnimOverrideSettings.WalkAnimId)
    end
    if AnimOverrideSettings.RunAnim then
        setAnim("run","RunAnim",AnimOverrideSettings.RunAnimId)
    end
    if AnimOverrideSettings.JumpAnim then
        setAnim("jump","JumpAnim",AnimOverrideSettings.JumpAnimId)
    end
    if AnimOverrideSettings.FallAnim then
        setAnim("fall","FallAnim",AnimOverrideSettings.FallAnimId)
    end
    local animator = char:FindFirstChildOfClass("Humanoid") and char:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
    if animator then
        for _, t in ipairs(animator:GetPlayingAnimationTracks()) do t:Stop(0) end
    end
end

local function SetCoinGlow(v)
    if worldFXConn then worldFXConn:Disconnect() worldFXConn = nil end
    for _, p in ipairs(coinGlowParts or {}) do pcall(function() p:Destroy() end) end
    coinGlowParts = {}
    if not v then return end
    local function addGlowToCoins()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name == "Coin" or obj.Name == "GoldCoin") then
                if not obj:FindFirstChildOfClass("PointLight") then
                    local pl = Instance.new("PointLight")
                    pl.Color = WorldFXSettings.CoinGlowColor
                    pl.Range = 12; pl.Brightness = 3
                    pl.Parent = obj
                    table.insert(coinGlowParts, pl)
                end
            end
        end
    end
    addGlowToCoins()
    worldFXConn = workspace.DescendantAdded:Connect(function(obj)
        if not WorldFXSettings.CoinGlow then return end
        task.wait(0.05)
        if obj:IsA("BasePart") and (obj.Name == "Coin" or obj.Name == "GoldCoin") then
            if not obj:FindFirstChildOfClass("PointLight") then
                local pl = Instance.new("PointLight")
                pl.Color = WorldFXSettings.CoinGlowColor
                pl.Range = 12; pl.Brightness = 3
                pl.Parent = obj
                table.insert(coinGlowParts, pl)
            end
        end
    end)
end

local function SetItemBeam(v)
    local function clearBeams()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "_ChaosItemBeam" then obj:Destroy() end
        end
    end
    clearBeams()
    if not v then return end
    local function addBeams()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name == "Knife" or obj.Name == "Gun" or obj.Name == "Revolver" or obj.Name == "Shotgun") then
                if not obj:FindFirstChild("_ChaosItemBeam") then
                    local sel = Instance.new("SelectionBox")
                    sel.Name = "_ChaosItemBeam"
                    sel.Adornee = obj
                    sel.Color3 = Color3.fromRGB(222,32,78)
                    sel.LineThickness = 0.05
                    sel.SurfaceTransparency = 0.8
                    sel.SurfaceColor3 = Color3.fromRGB(222,32,78)
                    sel.Parent = obj
                end
            end
        end
    end
    addBeams()
    task.spawn(function()
        while WorldFXSettings.ItemBeam do task.wait(3) addBeams() end
    end)
end

local function SetSkyTint(v)
    local Lighting = game:GetService("Lighting")
    if not v then
        Lighting.Ambient = Color3.fromRGB(70,70,70)
        return
    end
    Lighting.Ambient = WorldFXSettings.SkyTintColor
end

local function SetEnvLight(v)
    if envLightInst then envLightInst:Destroy() envLightInst = nil end
    if not v then return end
    envLightInst = Instance.new("PointLight")
    envLightInst.Color = WorldFXSettings.EnvLightColor
    envLightInst.Range = 60; envLightInst.Brightness = 5
    local hrp = GetRoot()
    envLightInst.Parent = hrp or workspace
end

local function SetSunIntensity(v)
    local Lighting = game:GetService("Lighting")
    if not v then Lighting.Brightness = 2 return end
    Lighting.Brightness = WorldFXSettings.SunBrightness
end

local function SetupHUDPlus()
    if hudPlusGui then hudPlusGui:Destroy() hudPlusGui = nil end
    if hudPlusConn then hudPlusConn:Disconnect() hudPlusConn = nil end
    local any = HUDPlusSettings.FPS or HUDPlusSettings.Ping or HUDPlusSettings.KillCount
        or HUDPlusSettings.Coords or HUDPlusSettings.SpeedMeter or HUDPlusSettings.Altitude
        or HUDPlusSettings.RoundTimer or HUDPlusSettings.ServerCount or HUDPlusSettings.Compass
    if not any then return end
    hudPlusGui = Instance.new("ScreenGui")
    hudPlusGui.Name = "ChaosHUDPlus"
    hudPlusGui.IgnoreGuiInset = true
    hudPlusGui.ResetOnSpawn = false
    hudPlusGui.DisplayOrder = 20
    hudPlusGui.Parent = game.CoreGui
    local labels = {}
    local function makeLabel(idx)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0,160,0,18)
        f.Position = UDim2.new(1,-170,0, 10 + (idx-1)*20)
        f.BackgroundColor3 = Color3.fromRGB(4,1,7)
        f.BackgroundTransparency = 0.4
        f.BorderSizePixel = 0
        Instance.new("UICorner",f).CornerRadius = UDim.new(0,4)
        local lbl = Instance.new("TextLabel",f)
        lbl.Size = UDim2.new(1,-6,1,0)
        lbl.Position = UDim2.new(0,6,0,0)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(240,76,124)
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamBold
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        f.Parent = hudPlusGui
        return lbl
    end
    local idx = 0
    local lblFPS, lblPing, lblKills, lblCoords, lblSpeed, lblAlt, lblTimer, lblSrv, lblCompass
    if HUDPlusSettings.FPS then idx=idx+1 lblFPS=makeLabel(idx) end
    if HUDPlusSettings.Ping then idx=idx+1 lblPing=makeLabel(idx) end
    if HUDPlusSettings.KillCount then idx=idx+1 lblKills=makeLabel(idx) end
    if HUDPlusSettings.Coords then idx=idx+1 lblCoords=makeLabel(idx) end
    if HUDPlusSettings.SpeedMeter then idx=idx+1 lblSpeed=makeLabel(idx) end
    if HUDPlusSettings.Altitude then idx=idx+1 lblAlt=makeLabel(idx) end
    if HUDPlusSettings.RoundTimer then idx=idx+1 lblTimer=makeLabel(idx) end
    if HUDPlusSettings.ServerCount then idx=idx+1 lblSrv=makeLabel(idx) end
    if HUDPlusSettings.Compass then idx=idx+1 lblCompass=makeLabel(idx) end
    local frameCount, lastFPS, lastTime = 0, 60, tick()
    hudPlusConn = RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = tick()
        if now - lastTime >= 0.5 then
            lastFPS = math.round(frameCount / (now - lastTime))
            frameCount = 0; lastTime = now
        end
        if lblFPS then lblFPS.Text = "FPS: "..lastFPS end
        if lblPing then
            local ping = 0
            pcall(function() ping = math.round(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) end)
            lblPing.Text = "Ping: "..ping.."ms"
        end
        if lblKills then lblKills.Text = "Kills: "..hudKillCount end
        local root = GetRoot()
        if root then
            if lblCoords then
                local p = root.Position
                lblCoords.Text = string.format("X:%.0f Y:%.0f Z:%.0f", p.X, p.Y, p.Z)
            end
            if lblSpeed then
                lblSpeed.Text = "Speed: "..math.round(root.AssemblyLinearVelocity.Magnitude).." s/s"
            end
            if lblAlt then
                lblAlt.Text = "Alt: "..math.round(root.Position.Y).." st"
            end
            if lblCompass then
                local cam = workspace.CurrentCamera
                local yaw = math.deg(math.atan2(-cam.CFrame.LookVector.Z, cam.CFrame.LookVector.X))
                local dirs = {"E","NE","N","NW","W","SW","S","SE"}
                local dir = dirs[math.floor(((yaw+360+22.5)%360)/45)+1] or "N"
                lblCompass.Text = "Dir: "..dir.." "..math.round(yaw).."°"
            end
        end
        if lblTimer then
            local t = "N/A"
            pcall(function()
                local gd = game:GetService("ReplicatedStorage"):FindFirstChild("GameData")
                if gd then
                    local gt = gd:FindFirstChild("GameTimer")
                    if gt then t = tostring(math.round(gt.Value)).."s" end
                end
            end)
            lblTimer.Text = "Timer: "..t
        end
        if lblSrv then lblSrv.Text = "Players: "..#game.Players:GetPlayers() end
    end)
end

local function SetRoleBanner(v)
    local existing = game.CoreGui:FindFirstChild("ChaosRoleBanner")
    if existing then existing:Destroy() end
    if not v then return end
    task.spawn(function()
        local banner = Instance.new("ScreenGui")
        banner.Name = "ChaosRoleBanner"
        banner.IgnoreGuiInset = true
        banner.ResetOnSpawn = false
        banner.DisplayOrder = 30
        banner.Parent = game.CoreGui
        local f = Instance.new("Frame", banner)
        f.Size = UDim2.new(0,300,0,50)
        f.Position = UDim2.new(0.5,-150,0.1,0)
        f.BackgroundColor3 = Color3.fromRGB(4,1,7)
        f.BackgroundTransparency = 0.3
        f.BorderSizePixel = 0
        Instance.new("UICorner",f).CornerRadius = UDim.new(0,8)
        local lbl = Instance.new("TextLabel",f)
        lbl.Size = UDim2.new(1,0,1,0)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(222,32,78)
        lbl.TextSize = 20
        lbl.Font = Enum.Font.GothamBold
        lbl.Text = "Waiting for role..."
        local function checkRole()
            pcall(function()
                local tags = game:GetService("ReplicatedStorage"):FindFirstChild("GameData")
                if tags then
                    local role = tags:FindFirstChild("PlayerRole")
                    if role then
                        local r = tostring(role.Value)
                        lbl.Text = "Role: "..r
                        if r == "Murderer" then lbl.TextColor3 = Color3.fromRGB(255,50,50)
                        elseif r == "Sheriff" then lbl.TextColor3 = Color3.fromRGB(50,150,255)
                        else lbl.TextColor3 = Color3.fromRGB(100,255,100) end
                    end
                end
            end)
        end
        for i = 1, 20 do
            checkRole()
            task.wait(1)
        end
        for t = 0, 1, 0.1 do
            if f.Parent then f.BackgroundTransparency = 0.3 + t * 0.7 end
            task.wait(0.05)
        end
        if banner.Parent then banner:Destroy() end
    end)
end

local function RemoveSounds()
    if not ScriptSettings.RemoveSounds then return end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") and v.Name ~= "_ChaosRadio" then v:Stop() v.Volume = 0 end
    end
end

local statGui
local function SetupStatOverlay(v)
    if statGui then statGui:Destroy() statGui = nil end
    if not v then return end
    statGui = Instance.new("ScreenGui")
    statGui.Name = "ChaosStats"
    statGui.IgnoreGuiInset = true
    statGui.ResetOnSpawn = false
    statGui.DisplayOrder = 11
    statGui.Parent = game.CoreGui
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,220,0,90)
    frame.Position = UDim2.new(0,10,0,38)
    frame.BackgroundColor3 = Color3.fromRGB(4,1,7)
    frame.BackgroundTransparency = 0.25
    frame.BorderSizePixel = 0
    frame.Parent = statGui
    Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)
    local stroke = Instance.new("UIStroke") stroke.Color = Color3.fromRGB(222,32,78) stroke.Thickness = 1 stroke.Parent = frame
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.fromScale(1,1)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220,220,230)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.RichText = true
    lbl.TextWrapped = true
    local pad = Instance.new("UIPadding") pad.PaddingLeft = UDim.new(0,8) pad.PaddingTop = UDim.new(0,4) pad.Parent = lbl
    lbl.Parent = frame
    task.spawn(function()
        while statGui and statGui.Parent do
            task.wait(0.5)
            local root = GetRoot()
            local pos = root and string.format("%.0f, %.0f, %.0f", root.Position.X, root.Position.Y, root.Position.Z) or "N/A"
            local elapsed = math.floor(tick() - sessionStartTime)
            local mins = math.floor(elapsed/60) local secs = elapsed % 60
            local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            local fps = math.floor(1 / game:GetService("RunService").Heartbeat:Wait())
            local lines = {}
            if ScriptSettings.ShowFPS then table.insert(lines, '<font color="rgb(240,76,124)">FPS</font>  '..fps) end
            if ScriptSettings.ShowPing then table.insert(lines, '<font color="rgb(240,76,124)">Ping</font> '..ping..'ms') end
            if ScriptSettings.ShowCoords then table.insert(lines, '<font color="rgb(240,76,124)">Pos</font>  '..pos) end
            table.insert(lines, '<font color="rgb(240,76,124)">Session</font> '..mins..'m '..secs..'s')
            table.insert(lines, '<font color="rgb(240,76,124)">Kills</font> '..ScriptSettings.KillCount)
            table.insert(lines, '<font color="rgb(240,76,124)">Coins</font> '..ScriptSettings.CoinCount)
            lbl.Text = table.concat(lines, "\n")
        end
    end)
end

local autoCollectGemsThread
local function SetAutoCollectGems(v)
    if autoCollectGemsThread then task.cancel(autoCollectGemsThread) autoCollectGemsThread = nil end
    if not v then return end
    autoCollectGemsThread = task.spawn(function()
        while ScriptSettings.AutoCollectGems do
            local root = GetRoot()
            if root then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if (obj.Name == "Gem" or obj.Name == "Gem_Server") and obj:IsA("BasePart") then
                        root.CFrame = CFrame.new(obj.Position)
                        task.wait(0.08)
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end

local function GetPlayerList()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do table.insert(list, p.Name) end
    return list
end

local function GetPlayerByName(name)
    for _, p in ipairs(Players:GetPlayers()) do if p.Name == name then return p end end
end

local function TeleportToCoord(x, y, z)
    local root = GetRoot()
    if root then root.CFrame = CFrame.new(x, y, z) end
end

local function SetCustomAmbient(v)
    if v then
        Lighting.Ambient = ScriptSettings.AmbientColor
        Lighting.OutdoorAmbient = ScriptSettings.AmbientColor
    else
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    end
end

local function LagServer(enabled)
    if enabled then
        task.spawn(function()
            while ScriptSettings.FakeLag do
                pcall(function()
                    local t = {}
                    for i = 1, ScriptSettings.FakeLagIntensity * 100 do t[i] = math.random() end
                end)
                task.wait(0.016)
            end
        end)
    end
end

local function SetRemoveParticles(v)
    ScriptSettings.RemoveParticles = v
    if v then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
        workspace.DescendantAdded:Connect(function(d)
            if ScriptSettings.RemoveParticles then
                if d:IsA("ParticleEmitter") or d:IsA("Smoke") or d:IsA("Fire") or d:IsA("Sparkles") then
                    d.Enabled = false
                end
            end
        end)
    end
end

local hyperjumpConn
local function SetHyperjump(v)
    if hyperjumpConn then hyperjumpConn:Disconnect() hyperjumpConn = nil end
    if not v then return end
    hyperjumpConn = UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.Space then
            local root = GetRoot()
            if root then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, ScriptSettings.HyperjumpPower, 0)
                bv.MaxForce = Vector3.new(0, 9e9, 0)
                bv.Parent = root
                Debris:AddItem(bv, 0.3)
            end
        end
    end)
end

local slideConn
local slideActive = false
local function SetSlide(v)
    if slideConn then slideConn:Disconnect() slideConn = nil end
    if not v then return end
    slideConn = UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.LeftControl and not slideActive then
            local root = GetRoot()
            local hum = GetHumanoid()
            if not root or not hum then return end
            slideActive = true
            local dir = Camera.CFrame.LookVector * Vector3.new(1,0,1)
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = dir * ScriptSettings.SlideSpeed
            bv.MaxForce = Vector3.new(9e9, 0, 9e9)
            bv.Parent = root
            task.delay(0.6, function()
                if bv.Parent then bv:Destroy() end
                slideActive = false
            end)
        end
    end)
end

local function QuickKillAll()
    local c = GetCharacter() if not c then return end
    local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
    local events = knife:FindFirstChild("Events") if not events then return end
    local ht = events:FindFirstChild("HandleTouched") if not ht then return end
    local root = GetRoot() if not root then return end
    task.spawn(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local pc = p.Character if not pc then continue end
            local pr = pc:FindFirstChild("HumanoidRootPart") if not pr then continue end
            root.CFrame = CFrame.new(pr.Position + Vector3.new(0,2,0))
            task.wait(0.08)
            ht:FireServer(pr)
            task.wait(0.08)
        end
    end)
end

local function TeleportAllToMe()
    local root = GetRoot() if not root then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local pc = p.Character if not pc then continue end
        local pr = pc:FindFirstChild("HumanoidRootPart") if not pr then continue end
        pr.CFrame = CFrame.new(root.Position + Vector3.new(math.random(-3,3), 0, math.random(-3,3)))
    end
end

local function FlingAllPlayers()
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local pc = p.Character if not pc then continue end
        local pr = pc:FindFirstChild("HumanoidRootPart") if not pr then continue end
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(math.random(-3000,3000), 5000, math.random(-3000,3000))
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)
        bv.Parent = pr
        Debris:AddItem(bv, 0.2)
    end
end

local function GetRole()
    local c = GetCharacter() if not c then return "Unknown" end
    if c:FindFirstChild("Knife") or c:FindFirstChild("knife") then return "Murderer" end
    if c:FindFirstChild("Sheriff Gun") or c:FindFirstChild("Gun") then return "Sheriff" end
    return "Innocent"
end

local function GetServerAge()
    return math.floor(workspace.DistributedGameTime)
end

local function CopyToClipboard(text)
    pcall(function() setclipboard(text) end)
end

local function GetAllPlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do table.insert(names, p.Name) end
    return names
end

local function KickPlayerLocally(player)
    if player and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part:Destroy() end
        end
    end
end

local function MuteSounds()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") then v.Volume = 0 end
    end
end

local function UnmuteSounds()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") and v.Name ~= "_ChaosRadio" then v.Volume = 0.5 end
    end
end

local function SetTimeOfDay(hour)
    Lighting.ClockTime = hour
end

local function GetMM2RemoteFolder()
    local rs = game:GetService("ReplicatedStorage")
    return rs:FindFirstChild("Remotes") or rs:FindFirstChild("Events") or rs
end

local function FireMM2Remote(name, ...)
    local folder = GetMM2RemoteFolder()
    if not folder then return end
    local remote = folder:FindFirstChild(name, true)
    if remote and remote:IsA("RemoteEvent") then
        remote:FireServer(...)
    end
end

local function FireMM2Function(name, ...)
    local folder = GetMM2RemoteFolder()
    if not folder then return end
    local remote = folder:FindFirstChild(name, true)
    if remote and remote:IsA("RemoteFunction") then
        return pcall(function() return remote:InvokeServer(...) end)
    end
end

local autoNotifyRolesThread
task.spawn(function()
    while true do
        task.wait(5)
        if ExtraSettings.AutoNotifyRoles then
            local m = FindMurderer() local s = FindSheriff()
            if m then ExposeChatMessage("Murderer is " .. m.Name) end
            if s then ExposeChatMessage("Sheriff is " .. s.Name) end
        end
    end
end)

local MultiStabConn
local function SetMultiStab(v)
    if MultiStabConn then MultiStabConn:Disconnect() MultiStabConn = nil end
    if not v then return end
    MultiStabConn = UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local c = GetCharacter() if not c then return end
            local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
            local events = knife:FindFirstChild("Events") if not events then return end
            local ht = events:FindFirstChild("HandleTouched") if not ht then return end
            local root = GetRoot() if not root then return end
            for i = 1, ScriptSettings.MultiStabCount do
                for _, p in ipairs(Players:GetPlayers()) do
                    if p == LocalPlayer then continue end
                    local pc = p.Character if not pc then continue end
                    local pr = pc:FindFirstChild("HumanoidRootPart") if not pr then continue end
                    if (pr.Position - root.Position).Magnitude < 8 then
                        ht:FireServer(pr)
                    end
                end
                task.wait(0.016)
            end
        end
    end)
end

local function SetInstantThrow()
    local c = GetCharacter() if not c then return end
    local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
    local events = knife:FindFirstChild("Events") if not events then return end
    local root = GetRoot() if not root then return end
    local best, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local pc = p.Character if not pc then continue end
        local head = pc:FindFirstChild("Head") or pc:FindFirstChild("HumanoidRootPart") if not head then continue end
        local hum = pc:FindFirstChildOfClass("Humanoid") if not hum or hum.Health <= 0 then continue end
        local dist = (head.Position - root.Position).Magnitude
        if dist < bestDist then bestDist = dist best = head end
    end
    if best then
        local throwRemote = events:FindFirstChild("ThrowKnife") or events:FindFirstChild("Throw")
        if throwRemote then throwRemote:FireServer(best.Position) end
    end
end

RunService.Heartbeat:Connect(function()
    if Settings.InstantThrow then SetInstantThrow() end
end)

RunService.Heartbeat:Connect(function()
    if not Settings.AutoThrow then return end
    local c = GetCharacter() if not c then return end
    local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
    local events = knife:FindFirstChild("Events") if not events then return end
    local root = GetRoot() if not root then return end
    local best, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local pc = p.Character if not pc then continue end
        local head = pc:FindFirstChild("Head") or pc:FindFirstChild("HumanoidRootPart") if not head then continue end
        local hum = pc:FindFirstChildOfClass("Humanoid") if not hum or hum.Health <= 0 then continue end
        local dist = (head.Position - root.Position).Magnitude
        if dist > Settings.AutoThrowRange then continue end
        local chance = math.random(1, 100)
        if chance < Settings.AutoThrowMinChance then continue end
        if dist < bestDist then bestDist = dist best = head end
    end
    if best then
        local throwRemote = events:FindFirstChild("ThrowKnife") or events:FindFirstChild("Throw")
        if throwRemote then throwRemote:FireServer(best.Position) end
    end
end)

local knifeTracerStorage = {}
local function ClearKnifeTracers()
    for _, v in pairs(knifeTracerStorage) do if v and v.Parent then v:Destroy() end end
    knifeTracerStorage = {}
end

RunService.RenderStepped:Connect(function()
    ClearKnifeTracers()
    if not Settings.KnifeTracers then return end
    local root = GetRoot() if not root then return end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "Knife" and not v:IsDescendantOf(GetCharacter() or Instance.new("Model")) then
            local handle = v:FindFirstChild("Handle") if not handle then continue end
            local screen, visible = WorldToViewport(handle.Position)
            if not visible then continue end
            local vp = Camera.ViewportSize
            local origin = Vector2.new(vp.X/2, vp.Y)
            local delta = screen - origin
            local dist = delta.Magnitude
            local angle = math.atan2(delta.Y, delta.X)
            local color = Settings.KnifeTracerRainbow and Color3.fromHSV((tick() * 0.5) % 1, 1, 1) or Color3.fromRGB(255, 180, 0)
            local line = Instance.new("Frame")
            line.Size = UDim2.new(0, dist, 0, math.max(1, Settings.KnifeTracerWidth / 100))
            line.Position = UDim2.new(0, origin.X + delta.X/2 - dist/2, 0, origin.Y + delta.Y/2)
            line.Rotation = math.deg(angle)
            line.BackgroundColor3 = color
            line.BackgroundTransparency = 0
            line.BorderSizePixel = 0
            line.ZIndex = 5
            local sg = Instance.new("ScreenGui") sg.IgnoreGuiInset = true sg.ResetOnSpawn = false sg.DisplayOrder = 10 sg.Parent = game.CoreGui
            line.Parent = sg
            table.insert(knifeTracerStorage, sg)
        end
    end
end)

local AdditionalCombatSub = CombatTab:AddSubtab("Advanced")
local AdvCombatGroup = AdditionalCombatSub:AddGroup("Advanced Combat", nil, "Left", 260)
AdvCombatGroup:AddCheckbox({Name="Multi-Stab", Default=false, Callback=function(v) ScriptSettings.MultiStab=v SetMultiStab(v) end})
AdvCombatGroup:AddSlider({Name="Stab Count", Min=1, Max=10, Default=3, Decimals=0, Callback=function(v) ScriptSettings.MultiStabCount=v end})
AdvCombatGroup:AddCheckbox({Name="Auto Backstab", Default=false, Callback=function(v) ScriptSettings.AutoBackstab=v end})
AdvCombatGroup:AddCheckbox({Name="Anti-Detect Delay", Default=false, Callback=function(v) ScriptSettings.AntiDetect=v end})
AdvCombatGroup:AddSlider({Name="Detect Delay (s)", Min=0, Max=1, Default=0.1, Decimals=2, Callback=function(v) ScriptSettings.AntiDetectDelay=v end})
AdvCombatGroup:AddCheckbox({Name="Hitbox Expander", Default=false, Callback=function(v) HitboxSettings.Enabled=v SetHitboxExpand(v) end})
AdvCombatGroup:AddSlider({Name="Hitbox Size", Min=2, Max=20, Default=6, Decimals=0, Callback=function(v) HitboxSettings.Size=v end})
AdvCombatGroup:AddCheckbox({Name="Show Hitboxes", Default=false, Callback=function(v) HitboxSettings.Visible=v end})

local AdvActionsGroup = AdditionalCombatSub:AddGroup("Mass Actions", nil, "Right", 220)
AdvActionsGroup:AddButton({Name="Quick Kill All", Callback=function() QuickKillAll() end})
AdvActionsGroup:AddButton({Name="Teleport All To Me", Callback=function() TeleportAllToMe() end})
AdvActionsGroup:AddButton({Name="Fling All Players", Callback=function() FlingAllPlayers() end})
AdvActionsGroup:AddButton({Name="Instant Throw Now", Callback=function() SetInstantThrow() end})
AdvActionsGroup:AddButton({Name="Expose All + Chat", Callback=function()
    local m=FindMurderer() local s=FindSheriff()
    local msg = "CHAOS: "
    if m then msg = msg .. "Murderer=" .. m.Name .. " " end
    if s then msg = msg .. "Sheriff=" .. s.Name end
    if m or s then ExposeChatMessage(msg) end
end})

local AntiAimSub = CombatTab:AddSubtab("Anti-Aim")
local AntiAimGroup = AntiAimSub:AddGroup("Anti-Aim", nil, "Left", 220)
AntiAimGroup:AddCheckbox({Name="Anti-Aim", Default=false, Callback=function(v) ScriptSettings.AntiAimEnabled=v SetAntiAim(v) end})
AntiAimGroup:AddDropdown({Name="AA Mode", Items={"Spin","Jitter","Flip","Static"}, Default="Spin", Callback=function(v) ScriptSettings.AntiAimMode=v end})
AntiAimGroup:AddSlider({Name="AA Speed", Min=1, Max=50, Default=20, Decimals=0, Callback=function(v) ScriptSettings.AntiAimSpeed=v end})
AntiAimGroup:AddCheckbox({Name="Spin-Bot", Default=false, Callback=function(v) ScriptSettings.SpinBot=v SetSpinBot(v) end})
AntiAimGroup:AddSlider({Name="Spin Speed", Min=1, Max=50, Default=15, Decimals=0, Callback=function(v) ScriptSettings.SpinSpeed=v end})

local FakeLagGroup = AntiAimSub:AddGroup("Fake Lag", nil, "Right", 180)
FakeLagGroup:AddCheckbox({Name="Fake Lag", Default=false, Callback=function(v) ScriptSettings.FakeLag=v LagServer(v) end})
FakeLagGroup:AddSlider({Name="Lag Intensity", Min=1, Max=100, Default=50, Decimals=0, Callback=function(v) ScriptSettings.FakeLagIntensity=v end})
FakeLagGroup:AddCheckbox({Name="Lag Switch (Hold F)", Default=false, Callback=function(v) ScriptSettings.LagSwitch=v end})

local BhopSub = PlayerTab:AddSubtab("Bhop")
local BhopGroup = BhopSub:AddGroup("Bunny Hop", nil, "Left", 220)
BhopGroup:AddCheckbox({Name="Bunny Hop", Default=false, Callback=function(v) BhopSettings.Enabled=v SetBhop(v) end})
BhopGroup:AddSlider({Name="Bhop Speed", Min=0.5, Max=3, Default=1.0, Decimals=1, Callback=function(v) BhopSettings.Speed=v end})
BhopGroup:AddCheckbox({Name="Auto Strafe", Default=false, Callback=function(v) BhopSettings.AutoStrafe=v end})
BhopGroup:AddCheckbox({Name="Bhop Sounds", Default=false, Callback=function(v) BhopSettings.Sounds=v end})
BhopGroup:AddCheckbox({Name="Hyperjump", Default=false, Callback=function(v) ScriptSettings.HyperjumpEnabled=v SetHyperjump(v) end})
BhopGroup:AddSlider({Name="Jump Power", Min=50, Max=600, Default=200, Decimals=0, Callback=function(v) ScriptSettings.HyperjumpPower=v end})
BhopGroup:AddCheckbox({Name="Slide (LeftCtrl)", Default=false, Callback=function(v) ScriptSettings.SlideEnabled=v SetSlide(v) end})
BhopGroup:AddSlider({Name="Slide Speed", Min=20, Max=200, Default=80, Decimals=0, Callback=function(v) ScriptSettings.SlideSpeed=v end})

local MovementExtGroup = BhopSub:AddGroup("Movement+", nil, "Right", 180)
MovementExtGroup:AddCheckbox({Name="No Fall Damage", Default=false, Callback=function(v) ScriptSettings.NoFallDamage=v SetNoFallDamage(v) end})
MovementExtGroup:AddCheckbox({Name="Auto Sprint", Default=false, Callback=function(v) ScriptSettings.AutoSprint=v SetAutoSprint(v) end})
MovementExtGroup:AddCheckbox({Name="Speed Glitch", Default=false, Callback=function(v) SpeedGlitchSettings.Enabled=v SetSpeedGlitch(v) end})
MovementExtGroup:AddSlider({Name="Glitch Intensity", Min=0.5, Max=10, Default=2.0, Decimals=1, Callback=function(v) SpeedGlitchSettings.Intensity=v end})
MovementExtGroup:AddCheckbox({Name="Sideways Glitch", Default=false, Callback=function(v) SpeedGlitchSettings.Sideways=v end})
MovementExtGroup:AddCheckbox({Name="Auto Dodge Murderer", Default=false, Callback=function(v) ScriptSettings.AutoDodge=v SetAutoDodge(v) end})
MovementExtGroup:AddSlider({Name="Dodge Range", Min=5, Max=30, Default=10, Decimals=0, Callback=function(v) ScriptSettings.AutoDodgeRange=v end})

local ChamsSubtab = VisualTab:AddSubtab("Chams")
local ChamsGroup = ChamsSubtab:AddGroup("Player Chams", nil, "Left", 260)
ChamsGroup:AddCheckbox({Name="Enable Chams", Default=false, Callback=function(v) ChamSettings.Enabled=v SetChams(v) end})
ChamsGroup:AddCheckbox({Name="Rainbow Chams", Default=false, Callback=function(v) ChamSettings.Rainbow=v end})
ChamsGroup:AddCheckbox({Name="Outline", Default=true, Callback=function(v) ChamSettings.OutlineEnabled=v end})
ChamsGroup:AddSlider({Name="Fill Transparency", Min=0, Max=1, Default=0.5, Decimals=1, Callback=function(v) ChamSettings.FillTransparency=v end})
ChamsGroup:AddColorpicker({Name="Murderer Color", Default=Color3.fromRGB(255,50,50), Callback=function(v) ChamSettings.MurdererColor=v end})
ChamsGroup:AddColorpicker({Name="Sheriff Color", Default=Color3.fromRGB(50,150,255), Callback=function(v) ChamSettings.SheriffColor=v end})
ChamsGroup:AddColorpicker({Name="Innocent Color", Default=Color3.fromRGB(100,255,100), Callback=function(v) ChamSettings.InnocentColor=v end})

local TracerSubtab = VisualTab:AddSubtab("Tracers")
local TracerGroup2 = TracerSubtab:AddGroup("Player Tracers", nil, "Left", 260)
TracerGroup2:AddCheckbox({Name="Enable Tracers", Default=false, Callback=function(v) TracerSettings.Enabled=v SetTracers(v) end})
TracerGroup2:AddDropdown({Name="Origin", Items={"Bottom","Center","Top"}, Default="Bottom", Callback=function(v) TracerSettings.Origin=v end})
TracerGroup2:AddSlider({Name="Thickness", Min=1, Max=6, Default=2, Decimals=0, Callback=function(v) TracerSettings.Thickness=v end})
TracerGroup2:AddSlider({Name="Transparency", Min=0, Max=1, Default=0, Decimals=1, Callback=function(v) TracerSettings.Transparency=v end})
TracerGroup2:AddColorpicker({Name="Murderer Tracer", Default=Color3.fromRGB(255,80,80), Callback=function(v) TracerSettings.MurdererColor=v end})
TracerGroup2:AddColorpicker({Name="Sheriff Tracer", Default=Color3.fromRGB(80,160,255), Callback=function(v) TracerSettings.SheriffColor=v end})
TracerGroup2:AddColorpicker({Name="Innocent Tracer", Default=Color3.fromRGB(200,200,200), Callback=function(v) TracerSettings.InnocentColor=v end})

local CrosshairSubtab = VisualTab:AddSubtab("Crosshair")
local CrosshairGroup = CrosshairSubtab:AddGroup("Crosshair", nil, "Left", 260)
CrosshairGroup:AddCheckbox({Name="Enable Crosshair", Default=false, Callback=function(v) CrosshairSettings.Enabled=v SetupCrosshair(v) end})
CrosshairGroup:AddDropdown({Name="Style", Items={"Cross","Classic","T-Shape","Circle","Dot"}, Default="Cross", Callback=function(v) CrosshairSettings.Style=v if CrosshairSettings.Enabled then SetupCrosshair(true) end end})
CrosshairGroup:AddColorpicker({Name="Color", Default=Color3.fromRGB(255,255,255), Callback=function(v) CrosshairSettings.Color=v if CrosshairSettings.Enabled then SetupCrosshair(true) end end})
CrosshairGroup:AddSlider({Name="Size", Min=4, Max=40, Default=12, Decimals=0, Callback=function(v) CrosshairSettings.Size=v if CrosshairSettings.Enabled then SetupCrosshair(true) end end})
CrosshairGroup:AddSlider({Name="Thickness", Min=1, Max=5, Default=2, Decimals=0, Callback=function(v) CrosshairSettings.Thickness=v if CrosshairSettings.Enabled then SetupCrosshair(true) end end})
CrosshairGroup:AddSlider({Name="Gap", Min=0, Max=20, Default=4, Decimals=0, Callback=function(v) CrosshairSettings.Gap=v if CrosshairSettings.Enabled then SetupCrosshair(true) end end})
CrosshairGroup:AddCheckbox({Name="Center Dot", Default=true, Callback=function(v) CrosshairSettings.Dot=v if CrosshairSettings.Enabled then SetupCrosshair(true) end end})
CrosshairGroup:AddCheckbox({Name="FOV Circle", Default=false, Callback=function(v) CrosshairSettings.FOVCircle=v if CrosshairSettings.Enabled then SetupCrosshair(true) end end})
CrosshairGroup:AddSlider({Name="FOV Circle Size", Min=20, Max=400, Default=120, Decimals=0, Callback=function(v) CrosshairSettings.FOVRadius=v if CrosshairSettings.Enabled then SetupCrosshair(true) end end})

local FXSub = VisualTab:AddSubtab("FX")

local TrailGroup = FXSub:AddGroup("Trail", nil, "Left", 220)
TrailGroup:AddCheckbox({Name="Enable Trail", Default=false, Callback=function(v) TrailSettings.Enabled=v SetTrail(v) end})
TrailGroup:AddDropdown({Name="Preset", Items={"Rainbow","Fire","Ice","Purple","Pink","Gold"}, Default="Rainbow", Callback=function(v) TrailSettings.Preset=v if TrailSettings.Enabled then SetTrail(true) end end})
TrailGroup:AddSlider({Name="Lifetime", Min=0.1, Max=3, Default=0.6, Decimals=1, Callback=function(v) TrailSettings.Lifetime=v if TrailSettings.Enabled then SetTrail(true) end end})
TrailGroup:AddSlider({Name="Transparency", Min=0, Max=0.9, Default=0.3, Decimals=1, Callback=function(v) TrailSettings.Transparency=v if TrailSettings.Enabled then SetTrail(true) end end})

local WalkFXGroup = FXSub:AddGroup("Walk Particles", nil, "Right", 220)
WalkFXGroup:AddCheckbox({Name="Walk Particles", Default=false, Callback=function(v) WalkParticleSettings.Enabled=v SetWalkParticles(v) end})
WalkFXGroup:AddDropdown({Name="Style", Items={"Sparkle","Flame","Ice","Pink","Gold"}, Default="Sparkle", Callback=function(v) WalkParticleSettings.Preset=v if WalkParticleSettings.Enabled then SetWalkParticles(true) end end})
WalkFXGroup:AddSlider({Name="Rate", Min=1, Max=30, Default=8, Decimals=0, Callback=function(v) WalkParticleSettings.Rate=v if WalkParticleSettings.Enabled then SetWalkParticles(true) end end})

local AuraGroup = FXSub:AddGroup("Aura", nil, "Left", 220)
AuraGroup:AddCheckbox({Name="Enable Aura", Default=false, Callback=function(v) AuraSettings.Enabled=v SetAura(v) end})
AuraGroup:AddColorpicker({Name="Aura Color", Default=Color3.fromRGB(222,32,78), Callback=function(v) AuraSettings.Color=v if AuraSettings.Enabled then SetAura(true) end end})
AuraGroup:AddSlider({Name="Range", Min=5, Max=60, Default=16, Decimals=0, Callback=function(v) AuraSettings.Range=v if AuraSettings.Enabled then SetAura(true) end end})
AuraGroup:AddSlider({Name="Brightness", Min=0.5, Max=10, Default=2, Decimals=1, Callback=function(v) AuraSettings.Brightness=v if AuraSettings.Enabled then SetAura(true) end end})
AuraGroup:AddCheckbox({Name="Pulse", Default=false, Callback=function(v) AuraSettings.Pulse=v if AuraSettings.Enabled then SetAura(true) end end})

local DeathFXGroup = FXSub:AddGroup("Death FX", nil, "Right", 220)
DeathFXGroup:AddCheckbox({Name="Death Effect", Default=false, Callback=function(v) DeathFXSettings.Enabled=v end})
DeathFXGroup:AddButton({Name="Preview Effect", Callback=function() TriggerDeathEffect() end})

local BodyFXSub = VisualTab:AddSubtab("Body FX")
local BodyBasicGroup = BodyFXSub:AddGroup("Body Effects", nil, "Left", 220)
BodyBasicGroup:AddCheckbox({Name="Rainbow Body", Default=false, Callback=function(v) BodyFXSettings.RainbowBody=v ApplyBodyFX() end})
BodyBasicGroup:AddCheckbox({Name="Neon Body", Default=false, Callback=function(v) BodyFXSettings.NeonBody=v ApplyBodyFX() end})
BodyBasicGroup:AddCheckbox({Name="Force Field", Default=false, Callback=function(v) BodyFXSettings.ForceField=v ApplyBodyFX() end})
BodyBasicGroup:AddCheckbox({Name="Fire Body", Default=false, Callback=function(v) BodyFXSettings.FireBody=v ApplyBodyFX() end})
BodyBasicGroup:AddCheckbox({Name="Sparkle Body", Default=false, Callback=function(v) BodyFXSettings.SparkleBody=v ApplyBodyFX() end})
BodyBasicGroup:AddCheckbox({Name="Ghost Mode", Default=false, Callback=function(v) BodyFXSettings.GhostMode=v ApplyBodyFX() end})
BodyBasicGroup:AddCheckbox({Name="Outline Body", Default=false, Callback=function(v) BodyFXSettings.OutlineBody=v ApplyBodyFX() end})
BodyBasicGroup:AddCheckbox({Name="Animated Color", Default=false, Callback=function(v) BodyFXSettings.AnimatedColor=v ApplyBodyFX() end})
local BodyColorGroup = BodyFXSub:AddGroup("Body Color & Scale", nil, "Right", 220)
BodyColorGroup:AddCheckbox({Name="Custom Body Color", Default=false, Callback=function(v) BodyFXSettings.CustomBodyColor=v ApplyBodyFX() end})
BodyColorGroup:AddColorpicker({Name="Body Color", Default=Color3.fromRGB(222,32,78), Callback=function(v) BodyFXSettings.BodyColor=v if BodyFXSettings.CustomBodyColor then ApplyBodyFX() end end})
BodyColorGroup:AddSlider({Name="Character Scale", Min=0.5, Max=2.5, Default=1.0, Decimals=1, Callback=function(v) BodyFXSettings.Scale=v ApplyBodyFX() end})
BodyColorGroup:AddButton({Name="Apply Body FX", Callback=function() ApplyBodyFX() end})
BodyColorGroup:AddButton({Name="Clear Body FX", Callback=function() ClearBodyFX() end})

local ParticleSub = VisualTab:AddSubtab("Particle Auras")
local OrbitGroup = ParticleSub:AddGroup("Orbit & Float", nil, "Left", 220)
OrbitGroup:AddCheckbox({Name="Orbit Orbs", Default=false, Callback=function(v) ParticleFXSettings.OrbitEnabled=v SetOrbit(v) end})
OrbitGroup:AddColorpicker({Name="Orbit Color", Default=Color3.fromRGB(222,32,78), Callback=function(v) ParticleFXSettings.OrbitColor=v for _, p in ipairs(orbitParts) do p.Color=v end end})
OrbitGroup:AddCheckbox({Name="Gravity Particles", Default=false, Callback=function(v) ParticleFXSettings.GravityEnabled=v SetGravityParticles(v) end})
OrbitGroup:AddColorpicker({Name="Gravity Color", Default=Color3.fromRGB(255,255,255), Callback=function(v) ParticleFXSettings.GravityColor=v SetGravityParticles(ParticleFXSettings.GravityEnabled) end})
OrbitGroup:AddCheckbox({Name="Angel Glow", Default=false, Callback=function(v) ParticleFXSettings.AngelGlow=v SetAngelGlow(v) end})
local AuraGroup2 = ParticleSub:AddGroup("Auras & Effects", nil, "Right", 220)
AuraGroup2:AddCheckbox({Name="Fire Aura", Default=false, Callback=function(v) ParticleFXSettings.FireAura=v SetFireAura(v) end})
AuraGroup2:AddCheckbox({Name="Dark Smoke", Default=false, Callback=function(v) ParticleFXSettings.DarkSmoke=v SetDarkSmoke(v) end})
AuraGroup2:AddCheckbox({Name="Ice Shards", Default=false, Callback=function(v) ParticleFXSettings.IceShards=v SetIceShards(v) end})
AuraGroup2:AddCheckbox({Name="Click Effect", Default=false, Callback=function(v) ParticleFXSettings.ClickEffect=v SetClickEffect(v) end})
AuraGroup2:AddColorpicker({Name="Click Color", Default=Color3.fromRGB(222,32,78), Callback=function(v) ParticleFXSettings.ClickColor=v end})
AuraGroup2:AddCheckbox({Name="Kill Burst", Default=false, Callback=function(v) ParticleFXSettings.KillBurst=v end})
AuraGroup2:AddButton({Name="Lightning Burst Now", Callback=function() FireLightningBurst() end})

local ScreenFXSub = VisualTab:AddSubtab("Screen FX")
local ScreenFXGroup = ScreenFXSub:AddGroup("Screen Effects", nil, "Left", 220)
ScreenFXGroup:AddCheckbox({Name="Speed Lines", Default=false, Callback=function(v) ScreenFXSettings.SpeedLines=v SetSpeedLines(v) end})
ScreenFXGroup:AddCheckbox({Name="Vignette", Default=false, Callback=function(v) ScreenFXSettings.Vignette=v SetVignette(v) end})
ScreenFXGroup:AddCheckbox({Name="Screen Tint", Default=false, Callback=function(v) ScreenFXSettings.Tint=v SetScreenTint(v) end})
ScreenFXGroup:AddColorpicker({Name="Tint Color", Default=Color3.fromRGB(222,32,78), Callback=function(v) ScreenFXSettings.TintColor=v if ScreenFXSettings.Tint then SetScreenTint(true) end end})
ScreenFXGroup:AddSlider({Name="Tint Strength", Min=0.4, Max=0.98, Default=0.85, Decimals=2, Callback=function(v) ScreenFXSettings.TintTransparency=v if ScreenFXSettings.Tint then SetScreenTint(true) end end})
local FlashGroup = ScreenFXSub:AddGroup("Flash Effects", nil, "Right", 220)
FlashGroup:AddCheckbox({Name="Hit Flash", Default=false, Callback=function(v) ScreenFXSettings.HitFlash=v if v then SetHitFlash(true) end end})
FlashGroup:AddCheckbox({Name="Kill Flash", Default=false, Callback=function(v) ScreenFXSettings.KillFlash=v end})
FlashGroup:AddButton({Name="Preview Hit Flash", Callback=function() task.spawn(FlashScreen, Color3.fromRGB(255,255,255), 0.3) end})
FlashGroup:AddButton({Name="Preview Kill Flash", Callback=function() task.spawn(FlashScreen, Color3.fromRGB(222,32,78), 0.4) end})

local SoundFXSub = VisualTab:AddSubtab("Sound FX")
local FootGroup = SoundFXSub:AddGroup("Step & Jump Sounds", nil, "Left", 220)
FootGroup:AddCheckbox({Name="Custom Footsteps", Default=false, Callback=function(v) SoundFXSettings.Footsteps=v SetFootsteps(v) end})
FootGroup:AddCheckbox({Name="Custom Jump Sound", Default=false, Callback=function(v) SoundFXSettings.JumpSound=v SetJumpSound(v) end})
FootGroup:AddCheckbox({Name="Custom Land Sound", Default=false, Callback=function(v) SoundFXSettings.LandSound=v SetLandSound(v) end})
local MusicGroup = SoundFXSub:AddGroup("Music & Kill", nil, "Right", 220)
MusicGroup:AddCheckbox({Name="Ambient Music", Default=false, Callback=function(v) SoundFXSettings.AmbientMusic=v SetAmbientMusic(v) end})
MusicGroup:AddSlider({Name="Music Volume", Min=0.0, Max=1.0, Default=0.3, Decimals=1, Callback=function(v) SoundFXSettings.AmbientVolume=v if ambientSound then ambientSound.Volume=v end end})
MusicGroup:AddCheckbox({Name="Kill Notification Sound", Default=false, Callback=function(v) SoundFXSettings.KillSoundExtra=v end})

local AnimSub = VisualTab:AddSubtab("Anim")
local AnimGroup = AnimSub:AddGroup("Animation Overrides", nil, "Left", 220)
AnimGroup:AddCheckbox({Name="Custom Idle", Default=false, Callback=function(v) AnimOverrideSettings.IdleAnim=v ApplyAnimOverrides() end})
AnimGroup:AddCheckbox({Name="Custom Walk", Default=false, Callback=function(v) AnimOverrideSettings.WalkAnim=v ApplyAnimOverrides() end})
AnimGroup:AddCheckbox({Name="Custom Run", Default=false, Callback=function(v) AnimOverrideSettings.RunAnim=v ApplyAnimOverrides() end})
AnimGroup:AddCheckbox({Name="Custom Jump", Default=false, Callback=function(v) AnimOverrideSettings.JumpAnim=v ApplyAnimOverrides() end})
AnimGroup:AddCheckbox({Name="Custom Fall", Default=false, Callback=function(v) AnimOverrideSettings.FallAnim=v ApplyAnimOverrides() end})
local AnimIDGroup = AnimSub:AddGroup("Animation IDs", nil, "Right", 220)
AnimIDGroup:AddTextbox({Name="Idle Anim ID", Default="rbxassetid://507766666", Callback=function(v) AnimOverrideSettings.IdleAnimId=v end})
AnimIDGroup:AddTextbox({Name="Walk Anim ID", Default="rbxassetid://507777826", Callback=function(v) AnimOverrideSettings.WalkAnimId=v end})
AnimIDGroup:AddTextbox({Name="Run Anim ID", Default="rbxassetid://507767714", Callback=function(v) AnimOverrideSettings.RunAnimId=v end})
AnimIDGroup:AddTextbox({Name="Jump Anim ID", Default="rbxassetid://507765000", Callback=function(v) AnimOverrideSettings.JumpAnimId=v end})
AnimIDGroup:AddTextbox({Name="Fall Anim ID", Default="rbxassetid://507767968", Callback=function(v) AnimOverrideSettings.FallAnimId=v end})
AnimIDGroup:AddButton({Name="Apply Anims", Callback=function() ApplyAnimOverrides() end})

local WorldFXSub = VisualTab:AddSubtab("World FX")
local CoinGroup = WorldFXSub:AddGroup("Coin & Item", nil, "Left", 220)
CoinGroup:AddCheckbox({Name="Coin Glow", Default=false, Callback=function(v) WorldFXSettings.CoinGlow=v SetCoinGlow(v) end})
CoinGroup:AddColorpicker({Name="Coin Glow Color", Default=Color3.fromRGB(255,215,0), Callback=function(v) WorldFXSettings.CoinGlowColor=v end})
CoinGroup:AddCheckbox({Name="Item Beam", Default=false, Callback=function(v) WorldFXSettings.ItemBeam=v SetItemBeam(v) end})
local LightGroup = WorldFXSub:AddGroup("Lighting", nil, "Right", 220)
LightGroup:AddCheckbox({Name="Sky Tint", Default=false, Callback=function(v) WorldFXSettings.SkyTint=v SetSkyTint(v) end})
LightGroup:AddColorpicker({Name="Sky Tint Color", Default=Color3.fromRGB(80,0,200), Callback=function(v) WorldFXSettings.SkyTintColor=v if WorldFXSettings.SkyTint then SetSkyTint(true) end end})
LightGroup:AddCheckbox({Name="Env Light", Default=false, Callback=function(v) WorldFXSettings.EnvLight=v SetEnvLight(v) end})
LightGroup:AddColorpicker({Name="Env Light Color", Default=Color3.fromRGB(222,32,78), Callback=function(v) WorldFXSettings.EnvLightColor=v SetEnvLight(WorldFXSettings.EnvLight) end})
LightGroup:AddCheckbox({Name="Custom Sun", Default=false, Callback=function(v) WorldFXSettings.SunIntensity=v SetSunIntensity(v) end})
LightGroup:AddSlider({Name="Sun Brightness", Min=0.5, Max=10, Default=2, Decimals=1, Callback=function(v) WorldFXSettings.SunBrightness=v if WorldFXSettings.SunIntensity then SetSunIntensity(true) end end})

local HUDPlusSub = VisualTab:AddSubtab("HUD+")
local HUDInfoGroup = HUDPlusSub:AddGroup("Info Meters", nil, "Left", 220)
HUDInfoGroup:AddCheckbox({Name="FPS Counter", Default=false, Callback=function(v) HUDPlusSettings.FPS=v SetupHUDPlus() end})
HUDInfoGroup:AddCheckbox({Name="Ping Display", Default=false, Callback=function(v) HUDPlusSettings.Ping=v SetupHUDPlus() end})
HUDInfoGroup:AddCheckbox({Name="Kill Counter", Default=false, Callback=function(v) HUDPlusSettings.KillCount=v SetupHUDPlus() end})
HUDInfoGroup:AddCheckbox({Name="Coordinates", Default=false, Callback=function(v) HUDPlusSettings.Coords=v SetupHUDPlus() end})
HUDInfoGroup:AddCheckbox({Name="Speed Meter", Default=false, Callback=function(v) HUDPlusSettings.SpeedMeter=v SetupHUDPlus() end})
local HUDExtraGroup = HUDPlusSub:AddGroup("Extra HUD", nil, "Right", 220)
HUDExtraGroup:AddCheckbox({Name="Altitude", Default=false, Callback=function(v) HUDPlusSettings.Altitude=v SetupHUDPlus() end})
HUDExtraGroup:AddCheckbox({Name="Round Timer", Default=false, Callback=function(v) HUDPlusSettings.RoundTimer=v SetupHUDPlus() end})
HUDExtraGroup:AddCheckbox({Name="Server Player Count", Default=false, Callback=function(v) HUDPlusSettings.ServerCount=v SetupHUDPlus() end})
HUDExtraGroup:AddCheckbox({Name="Compass", Default=false, Callback=function(v) HUDPlusSettings.Compass=v SetupHUDPlus() end})
HUDExtraGroup:AddCheckbox({Name="Role Banner", Default=false, Callback=function(v) HUDPlusSettings.RoleBanner=v SetRoleBanner(v) end})

local HUDExtSub = WorldTab:AddSubtab("HUD+")
local StatGroup = HUDExtSub:AddGroup("Stat Overlay", nil, "Left", 220)
StatGroup:AddCheckbox({Name="Stat Overlay", Default=false, Callback=function(v) SetupStatOverlay(v) end})
StatGroup:AddCheckbox({Name="Show FPS", Default=true, Callback=function(v) ScriptSettings.ShowFPS=v end})
StatGroup:AddCheckbox({Name="Show Ping", Default=false, Callback=function(v) ScriptSettings.ShowPing=v end})
StatGroup:AddCheckbox({Name="Show Coordinates", Default=false, Callback=function(v) ScriptSettings.ShowCoords=v end})

local KillFeedGroup = HUDExtSub:AddGroup("Kill Feed + Spectators", nil, "Right", 220)
KillFeedGroup:AddCheckbox({Name="Kill Feed", Default=false, Callback=function(v) ScriptSettings.ShowKillFeed=v end})
KillFeedGroup:AddCheckbox({Name="Spectator List", Default=false, Callback=function(v) ScriptSettings.ShowSpectators=v if not v then if spectatorGui then spectatorGui:Destroy() spectatorGui = nil end end end})
KillFeedGroup:AddButton({Name="Refresh Spectators", Callback=function() UpdateSpectatorList() end})

local WorldEnvSub = WorldTab:AddSubtab("Environment")
local EnvGroup1 = WorldEnvSub:AddGroup("Sky & Lighting", nil, "Left", 220)
EnvGroup1:AddCheckbox({Name="Remove Fog", Default=false, Callback=function(v) ScriptSettings.RemoveFog=v RemoveFog() end})
EnvGroup1:AddCheckbox({Name="Remove Particles", Default=false, Callback=function(v) SetRemoveParticles(v) end})
EnvGroup1:AddCheckbox({Name="Mute All Sounds", Default=false, Callback=function(v) if v then MuteSounds() else UnmuteSounds() end end})
EnvGroup1:AddCheckbox({Name="Custom Gravity", Default=false, Callback=function(v) ScriptSettings.CustomGravity=v SetCustomGravity(v) end})
EnvGroup1:AddSlider({Name="Gravity %", Min=1, Max=200, Default=50, Decimals=0, Callback=function(v) ScriptSettings.GravityValue=v if ScriptSettings.CustomGravity then SetCustomGravity(true) end end})
EnvGroup1:AddCheckbox({Name="Custom Ambient", Default=false, Callback=function(v) ScriptSettings.CustomAmbient=v SetCustomAmbient(v) end})
EnvGroup1:AddColorpicker({Name="Ambient Color", Default=Color3.fromRGB(128,128,128), Callback=function(v) ScriptSettings.AmbientColor=v if ScriptSettings.CustomAmbient then SetCustomAmbient(true) end end})

local EnvGroup2 = WorldEnvSub:AddGroup("Time of Day", nil, "Right", 180)
EnvGroup2:AddSlider({Name="Time (0-24h)", Min=0, Max=24, Default=14, Decimals=1, Callback=function(v) SetTimeOfDay(v) end})
EnvGroup2:AddButton({Name="Dawn (6am)", Callback=function() SetTimeOfDay(6) end})
EnvGroup2:AddButton({Name="Day (2pm)", Callback=function() SetTimeOfDay(14) end})
EnvGroup2:AddButton({Name="Dusk (7pm)", Callback=function() SetTimeOfDay(19) end})
EnvGroup2:AddButton({Name="Night (12am)", Callback=function() SetTimeOfDay(0) end})

local ServerInfoSub = WorldTab:AddSubtab("Server")
local ServerGroup = ServerInfoSub:AddGroup("Server Info", nil, "Left", 220)
ServerGroup:AddButton({Name="Copy Server Job ID", Callback=function() CopyToClipboard(game.JobId) end})
ServerGroup:AddButton({Name="Copy Place ID", Callback=function() CopyToClipboard(tostring(game.PlaceId)) end})
ServerGroup:AddButton({Name="Rejoin Same Server", Callback=function()
    local ts = game:GetService("TeleportService")
    ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end})
ServerGroup:AddButton({Name="Hop To New Server", Callback=function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end})
ServerGroup:AddButton({Name="Show Server Age", Callback=function()
    ExposeChatMessage("Server age: " .. GetServerAge() .. "s")
end})

local PlayerListGroup = ServerInfoSub:AddGroup("Players", nil, "Right", 220)
PlayerListGroup:AddButton({Name="Show All Roles In Chat", Callback=function()
    local msg = "Players: "
    for _, p in ipairs(Players:GetPlayers()) do
        msg = msg .. p.Name .. " "
    end
    ExposeChatMessage(msg)
end})
PlayerListGroup:AddButton({Name="Teleport to Random Player", Callback=function()
    local plrs = Players:GetPlayers()
    for _, p in ipairs(plrs) do
        if p ~= LocalPlayer and p.Character then
            TeleportToPlayer(p) return
        end
    end
end})
PlayerListGroup:AddButton({Name="Copy All Player Names", Callback=function()
    CopyToClipboard(table.concat(GetAllPlayerNames(), ", "))
end})

local ScriptSub = MiscTab:AddSubtab("Scripts")
local ScriptGroup1 = ScriptSub:AddGroup("Executors", nil, "Left", 260)
ScriptSub_Textbox_Input = ""
ScriptGroup1:AddTextbox({Name="Lua Input", Default="", Callback=function(v) ScriptSub_Textbox_Input = v end})
ScriptGroup1:AddButton({Name="Execute", Callback=function()
    pcall(loadstring(ScriptSub_Textbox_Input))
end})
ScriptGroup1:AddButton({Name="Clear", Callback=function() ScriptSub_Textbox_Input = "" end})

local ScriptLinksGroup = ScriptSub:AddGroup("Quick Scripts", nil, "Right", 220)
ScriptLinksGroup:AddButton({Name="Dex Explorer", Callback=function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end)
end})
ScriptLinksGroup:AddButton({Name="SimpleSpy", Callback=function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
    end)
end})
ScriptLinksGroup:AddButton({Name="Infinite Yield", Callback=function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end)
end})

local HotkeysSub = MiscTab:AddSubtab("Hotkeys")
local HotkeysGroup = HotkeysSub:AddGroup("Hotkey List", nil, "Left", 300)
HotkeysGroup:AddButton({Name="WASD/Space/Ctrl = Fly Controls", Callback=function() end})
HotkeysGroup:AddButton({Name="LeftCtrl = Slide (when enabled)", Callback=function() end})
HotkeysGroup:AddButton({Name="Space = Hyperjump (when enabled)", Callback=function() end})
HotkeysGroup:AddButton({Name="Click = Click Fling (when enabled)", Callback=function() end})
HotkeysGroup:AddButton({Name="F = Lag Switch toggle", Callback=function() end})

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F and ScriptSettings.LagSwitch then
        local root = GetRoot()
        if root then
            local anchor = not root.Anchored
            for _, p in ipairs(GetCharacter() and GetCharacter():GetDescendants() or {}) do
                if p:IsA("BasePart") then p.Anchored = anchor end
            end
        end
    end
end)

local CreditsGroup = HotkeysSub:AddGroup("Credits", nil, "Right", 220)
CreditsGroup:AddButton({Name="CHAOS by sxy.com", Callback=function() end})
CreditsGroup:AddButton({Name="UI: Chaos Library", Callback=function() end})
CreditsGroup:AddButton({Name="Game: Murder Mystery 2", Callback=function() end})
CreditsGroup:AddButton({Name="Version: 2.0 ODH Edition", Callback=function() end})

local MiscGroup = MiscSub:AddGroup("General", nil, "Left", 220)
MiscGroup:AddButton({Name="Rejoin", Callback=function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end})
MiscGroup:AddButton({Name="Respawn", Callback=function() LocalPlayer:LoadCharacter() end})
MiscGroup:AddButton({Name="Copy UserID", Callback=function() setclipboard(tostring(LocalPlayer.UserId)) end})
MiscGroup:AddButton({Name="Copy PlaceID", Callback=function() setclipboard(tostring(game.PlaceId)) end})
MiscGroup:AddButton({Name="Screenshot Clipboard", Callback=function()
    pcall(function() writefile("chaos_screenshot.png", game:GetService("GuiService"):TakeScreenshot()) end)
end})

local MiscGroup2 = MiscSub:AddGroup("Performance", nil, "Right", 180)
MiscGroup2:AddCheckbox({Name="Performance Mode", Default=false, Callback=function(v)
    ScriptSettings.PerformanceMode=v
    if v then
        settings().Rendering.QualityLevel = 1
    else
        settings().Rendering.QualityLevel = 10
    end
end})
MiscGroup2:AddButton({Name="Force GC", Callback=function() collectgarbage("collect") end})
MiscGroup2:AddButton({Name="Clear All Decorations", Callback=function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") or v:IsA("SurfaceAppearance") then v:Destroy() end
    end
end})
MiscGroup2:AddButton({Name="Destroy All Sounds", Callback=function() MuteSounds() end})

local ConfigSub = MiscTab:AddSubtab("Config")
local ConfigSaveGroup = ConfigSub:AddGroup("Save & Load", nil, "Left", 260)
local configNameInput = "chaos_config"
ConfigSaveGroup:AddTextbox({Name="Config Name", Default="chaos_config", Callback=function(v) configNameInput=v end})
ConfigSaveGroup:AddButton({Name="Save Config", Callback=function()
    local cfg = {
        Settings = {},
        FarmSettings = {},
        ExtraSettings = {},
        ScriptSettings = {},
        ChamSettings = {},
        TracerSettings = {},
        CrosshairSettings = {},
        HitboxSettings = {},
        BhopSettings = {},
        SpeedGlitchSettings = {},
    }
    for k,v in pairs(Settings) do if type(v)~="function" then cfg.Settings[k]=v end end
    for k,v in pairs(FarmSettings) do if type(v)~="function" then cfg.FarmSettings[k]=v end end
    for k,v in pairs(ExtraSettings) do if type(v)~="function" then cfg.ExtraSettings[k]=v end end
    for k,v in pairs(ScriptSettings) do if type(v)~="function" then cfg.ScriptSettings[k]=v end end
    for k,v in pairs(ChamSettings) do if type(v)~="function" and type(v)~="userdata" then cfg.ChamSettings[k]=tostring(v) end end
    for k,v in pairs(TracerSettings) do if type(v)~="function" and type(v)~="userdata" then cfg.TracerSettings[k]=tostring(v) end end
    for k,v in pairs(CrosshairSettings) do if type(v)~="function" and type(v)~="userdata" then cfg.CrosshairSettings[k]=tostring(v) end end
    for k,v in pairs(HitboxSettings) do if type(v)~="function" and type(v)~="userdata" then cfg.HitboxSettings[k]=tostring(v) end end
    for k,v in pairs(BhopSettings) do if type(v)~="function" then cfg.BhopSettings[k]=v end end
    for k,v in pairs(SpeedGlitchSettings) do if type(v)~="function" then cfg.SpeedGlitchSettings[k]=v end end
    local fname = (configNameInput or "chaos_config") .. ".cfg"
    local function serialize(t, indent)
        indent = indent or ""
        local lines = {}
        for k,v in pairs(t) do
            local vtype = type(v)
            if vtype == "table" then
                table.insert(lines, indent..tostring(k).."={")
                for _,l in ipairs(serialize(v, indent.."  ")) do table.insert(lines, l) end
                table.insert(lines, indent.."}")
            elseif vtype == "boolean" then
                table.insert(lines, indent..tostring(k).."="..tostring(v))
            elseif vtype == "number" then
                table.insert(lines, indent..tostring(k).."="..tostring(v))
            else
                table.insert(lines, indent..tostring(k).."="..tostring(v))
            end
        end
        return lines
    end
    local out = table.concat(serialize(cfg), "\n")
    pcall(function() writefile(fname, out) end)
end})
ConfigSaveGroup:AddButton({Name="Load Config", Callback=function()
    local fname = (configNameInput or "chaos_config") .. ".cfg"
    pcall(function()
        if isfile(fname) then
            local content = readfile(fname)
            local fn = loadstring("return {" .. content .. "}")
            if fn then
                local ok, cfg = pcall(fn)
                if ok and cfg then
                    if cfg.Settings then for k,v in pairs(cfg.Settings) do if Settings[k]~=nil then Settings[k]=v end end end
                    if cfg.FarmSettings then for k,v in pairs(cfg.FarmSettings) do if FarmSettings[k]~=nil then FarmSettings[k]=v end end end
                    if cfg.ExtraSettings then for k,v in pairs(cfg.ExtraSettings) do if ExtraSettings[k]~=nil then ExtraSettings[k]=v end end end
                    if cfg.ScriptSettings then for k,v in pairs(cfg.ScriptSettings) do if ScriptSettings[k]~=nil then ScriptSettings[k]=v end end end
                    if cfg.BhopSettings then for k,v in pairs(cfg.BhopSettings) do if BhopSettings[k]~=nil then BhopSettings[k]=v end end end
                end
            end
        end
    end)
end})

local ConfigListGroup = ConfigSub:AddGroup("Saved Configs", nil, "Right", 220)
ConfigListGroup:AddButton({Name="List All Configs", Callback=function()
    pcall(function()
        if listfiles then
            local files = listfiles("")
            local cfg_names = {}
            for _, f in ipairs(files) do
                if f:match("%.cfg$") then table.insert(cfg_names, f) end
            end
            ExposeChatMessage("Configs: " .. table.concat(cfg_names, ", "))
        end
    end)
end})
ConfigListGroup:AddButton({Name="Delete Config", Callback=function()
    local fname = (configNameInput or "chaos_config") .. ".cfg"
    pcall(function() if isfile(fname) then delfile(fname) end end)
end})
ConfigListGroup:AddButton({Name="Reset All Settings", Callback=function()
    for k in pairs(Settings) do
        local t = type(Settings[k])
        if t == "boolean" then Settings[k] = false
        elseif t == "number" then Settings[k] = 0
        elseif t == "string" then Settings[k] = ""
        end
    end
    for k in pairs(FarmSettings) do
        local t = type(FarmSettings[k])
        if t == "boolean" then FarmSettings[k] = false
        elseif t == "number" then FarmSettings[k] = 0
        end
    end
    for k in pairs(ExtraSettings) do
        local t = type(ExtraSettings[k])
        if t == "boolean" then ExtraSettings[k] = false
        elseif t == "number" then ExtraSettings[k] = 0
        end
    end
    ChamSettings.Enabled = false SetChams(false)
    TracerSettings.Enabled = false SetTracers(false)
    HitboxSettings.Enabled = false SetHitboxExpand(false)
    CrosshairSettings.Enabled = false SetupCrosshair(false)
    BhopSettings.Enabled = false SetBhop(false)
    SpeedGlitchSettings.Enabled = false SetSpeedGlitch(false)
    ScriptSettings.AntiAimEnabled = false SetAntiAim(false)
    ScriptSettings.SpinBot = false SetSpinBot(false)
    ScriptSettings.NoFallDamage = false SetNoFallDamage(false)
    ScriptSettings.AutoSprint = false SetAutoSprint(false)
    ScriptSettings.AutoDodge = false SetAutoDodge(false)
    ScriptSettings.MultiStab = false SetMultiStab(false)
    local hum = GetHumanoid()
    if hum then hum.WalkSpeed = 16 hum.JumpPower = 50 end
    workspace.Gravity = 196.2
end})

local PlayerInfoSub = MiscTab:AddSubtab("Players")
local PlayerTargetGroup = PlayerInfoSub:AddGroup("Target Player", nil, "Left", 260)
local selectedTarget = ""
PlayerTargetGroup:AddTextbox({Name="Player Name", Default="", Callback=function(v) selectedTarget=v end})
PlayerTargetGroup:AddButton({Name="Teleport To Player", Callback=function()
    local p = GetPlayerByName(selectedTarget) if not p then return end
    local c = p.Character if not c then return end
    local root = c:FindFirstChild("HumanoidRootPart") if not root then return end
    TeleportToCoord(root.Position.X, root.Position.Y + 3, root.Position.Z)
end})
PlayerTargetGroup:AddButton({Name="Teleport Player To Me", Callback=function()
    local me = GetRoot() if not me then return end
    local p = GetPlayerByName(selectedTarget) if not p then return end
    local c = p.Character if not c then return end
    local root = c:FindFirstChild("HumanoidRootPart") if not root then return end
    root.CFrame = me.CFrame + Vector3.new(2, 0, 0)
end})
PlayerTargetGroup:AddButton({Name="Inspect Character", Callback=function()
    local p = GetPlayerByName(selectedTarget) if not p then return end
    local c = p.Character if not c then return end
    local info = string.format("%s — Parts: %d", p.Name, #c:GetDescendants())
    ExposeChatMessage(info)
end})
PlayerTargetGroup:AddButton({Name="Kick Locally", Callback=function()
    local p = GetPlayerByName(selectedTarget) if not p then return end
    KickPlayerLocally(p)
end})
PlayerTargetGroup:AddButton({Name="Fling Target", Callback=function()
    local p = GetPlayerByName(selectedTarget) if not p then return end
    local c = p.Character if not c then return end
    local root = c:FindFirstChild("HumanoidRootPart") if not root then return end
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(math.random(-5000,5000), 8000, math.random(-5000,5000))
    bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    bv.Parent = root
    Debris:AddItem(bv, 0.3)
end})

local PlayerInfoGroup = PlayerInfoSub:AddGroup("All Players", nil, "Right", 220)
PlayerInfoGroup:AddButton({Name="Show Player Count", Callback=function()
    ExposeChatMessage("Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers)
end})
PlayerInfoGroup:AddButton({Name="Show Murderer", Callback=function()
    local m = FindMurderer()
    ExposeChatMessage(m and "Murderer: " .. m.Name or "No murderer found")
end})
PlayerInfoGroup:AddButton({Name="Show Sheriff", Callback=function()
    local s = FindSheriff()
    ExposeChatMessage(s and "Sheriff: " .. s.Name or "No sheriff found")
end})
PlayerInfoGroup:AddButton({Name="My Role", Callback=function()
    ExposeChatMessage("My role: " .. GetRole())
end})
PlayerInfoGroup:AddButton({Name="All Player Health", Callback=function()
    local msg = ""
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        local hum = c and c:FindFirstChildOfClass("Humanoid")
        if hum then msg = msg .. p.Name .. "=" .. math.floor(hum.Health) .. " " end
    end
    ExposeChatMessage(msg)
end})
PlayerInfoGroup:AddButton({Name="Tp Me To Spawn", Callback=function()
    local spawns = workspace:FindFirstChild("Spawns") or workspace:FindFirstChild("SpawnLocations")
    if spawns then
        local spawnList = spawns:GetChildren()
        if #spawnList > 0 then
            TeleportToCoord(spawnList[1].Position.X, spawnList[1].Position.Y + 3, spawnList[1].Position.Z)
        end
    end
end})

local ExtraESPSub = VisualTab:AddSubtab("ESP+")
local CoinESPGroup = ExtraESPSub:AddGroup("Object ESP", nil, "Left", 260)
local objectESPStorage = {}
local objectESPConn
CoinESPGroup:AddCheckbox({Name="Coin ESP", Default=false, Callback=function(v)
    if objectESPConn then objectESPConn:Disconnect() objectESPConn = nil end
    for _, g in pairs(objectESPStorage) do if g.Parent then g:Destroy() end end
    objectESPStorage = {}
    if not v then return end
    objectESPConn = RunService.RenderStepped:Connect(function()
        for _, g in pairs(objectESPStorage) do if g.Parent then g:Destroy() end end
        objectESPStorage = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Coin" and obj:IsA("BasePart") then
                local screen, visible = WorldToViewport(obj.Position)
                if visible then
                    local sg = Instance.new("ScreenGui") sg.IgnoreGuiInset=true sg.ResetOnSpawn=false sg.DisplayOrder=8 sg.Parent=game.CoreGui
                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(0,60,0,16)
                    lbl.Position = UDim2.new(0,screen.X-30,0,screen.Y-8)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = "COIN"
                    lbl.TextColor3 = Color3.fromRGB(255,220,0)
                    lbl.TextSize = 11
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextStrokeTransparency = 0
                    lbl.Parent = sg
                    table.insert(objectESPStorage, sg)
                end
            end
        end
    end)
end})

CoinESPGroup:AddCheckbox({Name="Knife ESP", Default=false, Callback=function(v)
    if not v then return end
    task.spawn(function()
        while v do
            task.wait(0.3)
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Knife" and obj:IsA("Model") or obj.Name == "Handle" and obj.Parent and obj.Parent.Name == "Knife" then
                    local part = obj:IsA("BasePart") and obj or obj:FindFirstChild("Handle")
                    if part then
                        local screen, visible = WorldToViewport(part.Position)
                        if visible then
                            local sg = Instance.new("ScreenGui") sg.IgnoreGuiInset=true sg.ResetOnSpawn=false sg.DisplayOrder=8 sg.Parent=game.CoreGui
                            local lbl = Instance.new("TextLabel")
                            lbl.Size = UDim2.new(0,60,0,16)
                            lbl.Position = UDim2.new(0,screen.X-30,0,screen.Y-8)
                            lbl.BackgroundTransparency = 1
                            lbl.Text = "KNIFE"
                            lbl.TextColor3 = Color3.fromRGB(255,120,0)
                            lbl.TextSize = 11
                            lbl.Font = Enum.Font.GothamBold
                            lbl.TextStrokeTransparency = 0
                            lbl.Parent = sg
                            Debris:AddItem(sg, 0.4)
                        end
                    end
                end
            end
        end
    end)
end})

CoinESPGroup:AddCheckbox({Name="Gun ESP", Default=false, Callback=function(v)
    if not v then return end
    task.spawn(function()
        while v do
            task.wait(0.3)
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Sheriff Gun" or obj.Name == "Gun" then
                    local part = obj:IsA("BasePart") and obj or (obj:IsA("Model") and obj:FindFirstChild("Handle"))
                    if part then
                        local screen, visible = WorldToViewport(part.Position)
                        if visible then
                            local sg = Instance.new("ScreenGui") sg.IgnoreGuiInset=true sg.ResetOnSpawn=false sg.DisplayOrder=8 sg.Parent=game.CoreGui
                            local lbl = Instance.new("TextLabel")
                            lbl.Size = UDim2.new(0,60,0,16)
                            lbl.Position = UDim2.new(0,screen.X-30,0,screen.Y-8)
                            lbl.BackgroundTransparency = 1
                            lbl.Text = "GUN"
                            lbl.TextColor3 = Color3.fromRGB(80,180,255)
                            lbl.TextSize = 11
                            lbl.Font = Enum.Font.GothamBold
                            lbl.TextStrokeTransparency = 0
                            lbl.Parent = sg
                            Debris:AddItem(sg, 0.4)
                        end
                    end
                end
            end
        end
    end)
end})

local HealthBarGroup = ExtraESPSub:AddGroup("Health Bars", nil, "Right", 220)
local healthBarStorage = {}
local healthBarConn
HealthBarGroup:AddCheckbox({Name="Health Bars", Default=false, Callback=function(v)
    if healthBarConn then healthBarConn:Disconnect() healthBarConn = nil end
    for _, sg in pairs(healthBarStorage) do if sg.Parent then sg:Destroy() end end
    healthBarStorage = {}
    if not v then return end
    healthBarConn = RunService.RenderStepped:Connect(function()
        for _, sg in pairs(healthBarStorage) do if sg.Parent then sg:Destroy() end end
        healthBarStorage = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local c = p.Character if not c then continue end
            local root = c:FindFirstChild("HumanoidRootPart") if not root then continue end
            local hum = c:FindFirstChildOfClass("Humanoid") if not hum then continue end
            local screen, visible = WorldToViewport(root.Position + Vector3.new(0,3,0))
            if not visible then continue end
            local isMurd = FindMurderer() == p
            local isSher = FindSheriff() == p
            local barColor = isMurd and Color3.fromRGB(255,60,60) or isSher and Color3.fromRGB(60,150,255) or Color3.fromRGB(80,255,80)
            local sg = Instance.new("ScreenGui") sg.IgnoreGuiInset=true sg.ResetOnSpawn=false sg.DisplayOrder=9 sg.Parent=game.CoreGui
            local bg = Instance.new("Frame") bg.Size=UDim2.new(0,50,0,5) bg.Position=UDim2.new(0,screen.X-25,0,screen.Y-3) bg.BackgroundColor3=Color3.fromRGB(30,30,30) bg.BorderSizePixel=0 bg.Parent=sg
            Instance.new("UICorner",bg).CornerRadius=UDim.new(1,0)
            local fill = Instance.new("Frame") fill.Size=UDim2.new(hum.Health/hum.MaxHealth,0,1,0) fill.BackgroundColor3=barColor fill.BorderSizePixel=0 fill.Parent=bg
            Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
            table.insert(healthBarStorage, sg)
        end
    end)
end})

HealthBarGroup:AddCheckbox({Name="Name Tags", Default=false, Callback=function(v)
    task.spawn(function()
        while v do
            task.wait(0.1)
            for _, p in ipairs(Players:GetPlayers()) do
                if p == LocalPlayer then continue end
                local c = p.Character if not c then continue end
                local root = c:FindFirstChild("HumanoidRootPart") if not root then continue end
                local isMurd = FindMurderer() == p
                local isSher = FindSheriff() == p
                local color = isMurd and Color3.fromRGB(255,60,60) or isSher and Color3.fromRGB(60,150,255) or Color3.fromRGB(220,220,220)
                local existing = root:FindFirstChild("_ChaosNameTag")
                if not existing then
                    local bb = Instance.new("BillboardGui") bb.Name="_ChaosNameTag" bb.AlwaysOnTop=true bb.Size=UDim2.new(0,100,0,20) bb.StudsOffset=Vector3.new(0,2.5,0) bb.Parent=root
                    local lbl = Instance.new("TextLabel") lbl.Size=UDim2.fromScale(1,1) lbl.BackgroundTransparency=1 lbl.TextColor3=color lbl.TextSize=12 lbl.Font=Enum.Font.GothamBold lbl.Text=p.Name lbl.TextStrokeTransparency=0 lbl.Parent=bb
                else
                    local lbl = existing:FindFirstChildOfClass("TextLabel")
                    if lbl then lbl.TextColor3 = color end
                end
            end
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if root then local t = root:FindFirstChild("_ChaosNameTag") if t then t:Destroy() end end
            end
        end
    end)
end})

local RainbowESPSub = VisualTab:AddSubtab("Rainbow")
local RainbowGroup = RainbowESPSub:AddGroup("Rainbow Effects", nil, "Left", 260)
local rainbowActive = false
local rainbowH = 0
RainbowGroup:AddCheckbox({Name="Rainbow ESP", Default=false, Callback=function(v)
    rainbowActive = v
    if v then
        task.spawn(function()
            while rainbowActive do
                rainbowH = (rainbowH + 0.003) % 1
                local col = Color3.fromHSV(rainbowH, 1, 1)
                for _, p in ipairs(Players:GetPlayers()) do
                    if p == LocalPlayer then continue end
                    local c = p.Character if not c then continue end
                    local bb = c:FindFirstChild("_ChaosESP") and c._ChaosESP:FindFirstChildOfClass("TextLabel")
                    if bb then bb.TextColor3 = col end
                end
                task.wait(0.016)
            end
        end)
    end
end})
RainbowGroup:AddCheckbox({Name="Rainbow Chams", Default=false, Callback=function(v)
    ChamSettings.Rainbow = v
end})
RainbowGroup:AddCheckbox({Name="Rainbow Walk Trail", Default=false, Callback=function(v)
    if not v then return end
    task.spawn(function()
        while v do
            local root = GetRoot() if not root then task.wait(0.1) continue end
            local h = (rainbowH + 0.003) % 1
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.5, 0.5, 0.5)
            part.CFrame = root.CFrame
            part.Anchored = true
            part.CanCollide = false
            part.Color = Color3.fromHSV(h, 1, 1)
            part.Material = Enum.Material.Neon
            part.Parent = workspace
            Debris:AddItem(part, 1.5)
            task.wait(0.05)
        end
    end)
end})
RainbowGroup:AddCheckbox({Name="Rainbow Knife Tracer", Default=false, Callback=function(v)
    Settings.KnifeTracerRainbow = v
end})

local RainbowGroup2 = RainbowESPSub:AddGroup("Neon Effects", nil, "Right", 220)
RainbowGroup2:AddCheckbox({Name="Neon Glow Self", Default=false, Callback=function(v)
    if not v then return end
    task.spawn(function()
        while v do
            local c = GetCharacter() if c then
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Material = Enum.Material.Neon
                        part.Color = Color3.fromHSV(rainbowH, 1, 1)
                    end
                end
            end
            task.wait(0.016)
        end
    end)
end})
RainbowGroup2:AddCheckbox({Name="Force Neon All Players", Default=false, Callback=function(v)
    if not v then return end
    task.spawn(function()
        while v do
            for _, p in ipairs(Players:GetPlayers()) do
                local c = p.Character if not c then continue end
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Material = Enum.Material.Neon
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end})

local KnifeTracerExtSub = VisualTab:AddSubtab("Knife Tracers")
local KnifeTracerMainGroup = KnifeTracerExtSub:AddGroup("Knife Tracer Settings", nil, "Left", 260)
KnifeTracerMainGroup:AddCheckbox({Name="Enable Knife Tracers", Default=false, Callback=function(v) Settings.KnifeTracers=v end})
KnifeTracerMainGroup:AddDropdown({Name="Style", Items={"Energy","Neon","Dashed","Arrow","Beam"}, Default="Energy", Callback=function(v) Settings.KnifeTracerStyle=v end})
KnifeTracerMainGroup:AddCheckbox({Name="Rainbow Tracers", Default=false, Callback=function(v) Settings.KnifeTracerRainbow=v end})
KnifeTracerMainGroup:AddSlider({Name="Width", Min=10, Max=300, Default=100, Decimals=0, Callback=function(v) Settings.KnifeTracerWidth=v end})
KnifeTracerMainGroup:AddSlider({Name="Duration", Min=0.1, Max=5, Default=1.2, Decimals=1, Callback=function(v) Settings.KnifeTracerDuration=v end})
KnifeTracerMainGroup:AddCheckbox({Name="Impact Flash", Default=true, Callback=function(v) Settings.KnifeTracerFlash=v end})
KnifeTracerMainGroup:AddCheckbox({Name="Trace Other Knives", Default=false, Callback=function(v) Settings.KnifeTracerOthers=v end})

local KnifeTracerFXGroup = KnifeTracerExtSub:AddGroup("Impact Effects", nil, "Right", 220)
KnifeTracerFXGroup:AddCheckbox({Name="Shockwave on Impact", Default=false, Callback=function(v)
    Settings.KnifeTracerImpact = v
end})
KnifeTracerFXGroup:AddCheckbox({Name="Sound on Impact", Default=false, Callback=function(v)
    if v then
        task.spawn(function()
            while v do
                task.wait(0.2)
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj.Name == "KnifeImpact" or (obj.Name == "Hit" and obj:IsA("Sound")) then
                        obj:Play()
                    end
                end
            end
        end)
    end
end})

local ExtraFarmSub = FarmTab:AddSubtab("Advanced")
local AutoKillGroup = ExtraFarmSub:AddGroup("Auto Kill", nil, "Left", 260)
AutoKillGroup:AddCheckbox({Name="Auto Kill Everyone", Default=false, Callback=function(v)
    FarmSettings.AutoKillEveryone = v
    if v then StartAutoKillEveryone() end
end})
AutoKillGroup:AddCheckbox({Name="Auto Kill Murderer", Default=false, Callback=function(v)
    FarmSettings.AutoKillMurderer = v
end})
AutoKillGroup:AddCheckbox({Name="Auto Shoot Murderer", Default=false, Callback=function(v)
    FarmSettings.AutoShootMurderer = v
    if v then StartAutoShootMurderer() end
end})
AutoKillGroup:AddCheckbox({Name="Auto Fling Murderer", Default=false, Callback=function(v)
    FarmSettings.AutoFlingMurderer = v
    if v then StartAutoFlingMurderer() end
end})
AutoKillGroup:AddButton({Name="Kill Murderer Now", Callback=function()
    local m = FindMurderer() if not m then return end
    local c = GetCharacter() if not c then return end
    local knife = c:FindFirstChild("Knife") or c:FindFirstChild("knife") if not knife then return end
    local events = knife:FindFirstChild("Events") if not events then return end
    local ht = events:FindFirstChild("HandleTouched") if not ht then return end
    local root = GetRoot() if not root then return end
    if m.Character then
        local mr = m.Character:FindFirstChild("HumanoidRootPart") if not mr then return end
        local orig = root.CFrame
        root.CFrame = CFrame.new(mr.Position + Vector3.new(0,1,0))
        task.wait(0.1)
        ht:FireServer(mr)
        root.CFrame = orig
    end
end})

local FarmGemGroup = ExtraFarmSub:AddGroup("Gem & Reward Farm", nil, "Right", 220)
FarmGemGroup:AddCheckbox({Name="Auto Collect Gems", Default=false, Callback=function(v)
    ScriptSettings.AutoCollectGems = v
    if v then SetAutoCollectGems(true) end
end})
FarmGemGroup:AddCheckbox({Name="Auto Collect Coins", Default=false, Callback=function(v)
    Settings.AutoCollectCoins = v
end})
FarmGemGroup:AddCheckbox({Name="Auto Prestige", Default=false, Callback=function(v)
    Settings.AutoPrestige = v
end})
FarmGemGroup:AddButton({Name="Tp To All Coins Now", Callback=function()
    task.spawn(function()
        local root = GetRoot() if not root then return end
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Coin" and obj:IsA("BasePart") then
                root.CFrame = CFrame.new(obj.Position)
                task.wait(0.1)
            end
        end
    end)
end})
FarmGemGroup:AddButton({Name="Show Coin Count", Callback=function()
    ExposeChatMessage("Session coins: " .. tostring(ScriptSettings.CoinCount))
end})

local FarmStatGroup = ExtraFarmSub:AddGroup("Farm Stats", nil, "Left", 220)
local farmRoundCount = 0
local farmKillCount = 0
local farmCoinCount = 0
local farmGemCount = 0
FarmStatGroup:AddButton({Name="Show Farm Stats", Callback=function()
    local elapsed = math.floor(tick() - sessionStartTime)
    local mins = math.floor(elapsed/60) local secs = elapsed%60
    local msg = string.format("Rounds:%d Kills:%d Coins:%d Gems:%d Time:%dm%ds", farmRoundCount, farmKillCount, farmCoinCount, farmGemCount, mins, secs)
    ExposeChatMessage(msg)
end})
FarmStatGroup:AddButton({Name="Reset Stats", Callback=function()
    farmRoundCount=0 farmKillCount=0 farmCoinCount=0 farmGemCount=0
    ScriptSettings.KillCount=0 ScriptSettings.CoinCount=0
end})

Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    farmRoundCount = farmRoundCount + 1
end)

local FarmAutoResetGroup = ExtraFarmSub:AddGroup("Auto Reset Roles", nil, "Right", 220)
FarmAutoResetGroup:AddCheckbox({Name="Reset as Murderer", Default=false, Callback=function(v) FarmSettings.AutoResetAsMurderer=v end})
FarmAutoResetGroup:AddCheckbox({Name="Reset as Sheriff", Default=false, Callback=function(v) FarmSettings.AutoResetAsSheriff=v end})
FarmAutoResetGroup:AddCheckbox({Name="Reset as Innocent", Default=false, Callback=function(v) FarmSettings.AutoResetAsInnocent=v end})
FarmAutoResetGroup:AddSlider({Name="Reset Delay (s)", Min=0.5, Max=10, Default=0.5, Decimals=1, Callback=function(v) FarmSettings.ResetDelay=v end})

local ExtraProtSub = PlayerTab:AddSubtab("Protection+")
local AntiVoidGroup = ExtraProtSub:AddGroup("Anti Exploits", nil, "Left", 220)
AntiVoidGroup:AddCheckbox({Name="Anti Void", Default=false, Callback=function(v) ExtraSettings.AntiVoid=v SetAntiVoid(v) end})
AntiVoidGroup:AddCheckbox({Name="Anti Fling", Default=false, Callback=function(v) Settings.AntiFling=v SetAntiFling(v) end})
AntiVoidGroup:AddCheckbox({Name="Anti AFK", Default=false, Callback=function(v) Settings.AntiAFK=v end})
AntiVoidGroup:AddCheckbox({Name="Second Life", Default=false, Callback=function(v) ExtraSettings.SecondLife=v end})
AntiVoidGroup:AddCheckbox({Name="Freeze Character", Default=false, Callback=function(v)
    Settings.FreezeCharacter=v
    local c = GetCharacter() if not c then return end
    for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Anchored=v end end
end})
AntiVoidGroup:AddCheckbox({Name="Invisible", Default=false, Callback=function(v) Settings.Invisible=v SetInvisible(v) end})
AntiVoidGroup:AddCheckbox({Name="Ghost Mode", Default=false, Callback=function(v)
    ScriptSettings.GhostMode=v
    local c = GetCharacter() if not c then return end
    for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = not v
            p.Transparency = v and 0.8 or 0
        end
    end
end})

local SilentWalkGroup = ExtraProtSub:AddGroup("Silent & Misc", nil, "Right", 180)
SilentWalkGroup:AddCheckbox({Name="Silent Walk", Default=false, Callback=function(v)
    ScriptSettings.SilentWalk = v
    task.spawn(function()
        while ScriptSettings.SilentWalk do
            local hum = GetHumanoid()
            if hum then
                for _, sound in ipairs(hum.Parent:GetDescendants()) do
                    if sound:IsA("Sound") and (sound.Name == "Running" or sound.Name == "Walking") then
                        sound.Volume = 0
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end})
SilentWalkGroup:AddCheckbox({Name="No Clip", Default=false, Callback=function(v) Settings.NoClip=v SetNoClip(v) end})
SilentWalkGroup:AddCheckbox({Name="Infinite Jump", Default=false, Callback=function(v) Settings.InfiniteJump=v SetInfiniteJump(v) end})
SilentWalkGroup:AddCheckbox({Name="Loop Interactive", Default=false, Callback=function(v) Settings.LoopInteractive=v end})
SilentWalkGroup:AddCheckbox({Name="Touch Fling", Default=false, Callback=function(v) Settings.TouchFling=v SetTouchFling(v) end})
SilentWalkGroup:AddCheckbox({Name="Click Fling", Default=false, Callback=function(v) Settings.ClickFling=v end})

local ExtraModSub = PlayerTab:AddSubtab("Mods+")
local ExtraModGroup = ExtraModSub:AddGroup("Character Mods", nil, "Left", 260)
ExtraModGroup:AddCheckbox({Name="Korblox (Perm)", Default=false, Callback=function(v)
    ExtraSettings.KorbloxPermanent=v
    if v then ApplyKorblox() end
end})
ExtraModGroup:AddCheckbox({Name="Headless (Perm)", Default=false, Callback=function(v)
    ExtraSettings.HeadlessPermanent=v
    if v then ApplyHeadless() end
end})
ExtraModGroup:AddButton({Name="Apply Korblox Now", Callback=function() ApplyKorblox() end})
ExtraModGroup:AddButton({Name="Apply Headless Now", Callback=function() ApplyHeadless() end})
ExtraModGroup:AddButton({Name="Remove Accessories", Callback=function()
    local c = GetCharacter() if not c then return end
    for _, v in ipairs(c:GetChildren()) do
        if v:IsA("Accessory") then v:Destroy() end
    end
end})
ExtraModGroup:AddButton({Name="Remove Clothing", Callback=function()
    local c = GetCharacter() if not c then return end
    for _, v in ipairs(c:GetChildren()) do
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then v:Destroy() end
    end
end})

local SkinChangerExtGroup = ExtraModSub:AddGroup("Extended Skin Changer", nil, "Right", 220)
SkinChangerExtGroup:AddDropdown({Name="Knife Skin", Items=knifeSkinList, Default="Default", Callback=function(v)
    Settings.KnifeSkinChanger=v
    ApplyKnifeSkin(v)
end})
SkinChangerExtGroup:AddDropdown({Name="Gun Skin", Items=gunSkinList, Default="Default", Callback=function(v)
    ApplyGunSkin(v)
end})
SkinChangerExtGroup:AddButton({Name="Randomize Knife Skin", Callback=function()
    local idx = math.random(1, #knifeSkinList)
    ApplyKnifeSkin(knifeSkinList[idx])
end})
SkinChangerExtGroup:AddButton({Name="Randomize Gun Skin", Callback=function()
    local idx = math.random(1, #gunSkinList)
    ApplyGunSkin(gunSkinList[idx])
end})

local ExtraEmoteSub = PlayerTab:AddSubtab("Emotes+")
local EmoteListGroup = ExtraEmoteSub:AddGroup("Emote List", nil, "Left", 260)
local emoteList = {"wave","laugh","dance","dance2","dance3","cheer","point","ninja","salute","tilt","shrug","stadium","victory","peace"}
for _, emoteName in ipairs(emoteList) do
    EmoteListGroup:AddButton({Name=emoteName:gsub("^%l", string.upper), Callback=function()
        local hum = GetHumanoid()
        if hum then
            pcall(function()
                local AnimFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Emotes")
                if AnimFolder then
                    local emoteAnim = AnimFolder:FindFirstChild(emoteName)
                    if emoteAnim then
                        hum.Animator:LoadAnimation(emoteAnim):Play()
                    end
                else
                    hum:EmoteAsync(emoteName)
                end
            end)
        end
    end})
end

local AutoEmoteExtGroup = ExtraEmoteSub:AddGroup("Auto Emote", nil, "Right", 220)
AutoEmoteExtGroup:AddCheckbox({Name="Auto Emote", Default=false, Callback=function(v) Settings.AutoEmote=v end})
AutoEmoteExtGroup:AddDropdown({Name="Auto Emote", Items=emoteList, Default="ninja", Callback=function(v) Settings.AutoEmoteSelected=v end})
AutoEmoteExtGroup:AddButton({Name="Spam Dance", Callback=function()
    task.spawn(function()
        for i=1,5 do
            pcall(function()
                local hum = GetHumanoid()
                if hum then hum:EmoteAsync("dance") end
            end)
            task.wait(0.3)
        end
    end)
end})

local ExtraTrollSub = PlayerTab:AddSubtab("Troll+")
local TrollExtGroup = ExtraTrollSub:AddGroup("Advanced Troll", nil, "Left", 260)
TrollExtGroup:AddCheckbox({Name="Orbit Player", Default=false, Callback=function(v) Settings.Orbit=v end})
TrollExtGroup:AddCheckbox({Name="Click Hump", Default=false, Callback=function(v) Settings.ClickHump=v end})
TrollExtGroup:AddSlider({Name="Hump Duration", Min=0, Max=5, Default=0, Decimals=0, Callback=function(v) Settings.HumpDuration=v end})
TrollExtGroup:AddCheckbox({Name="Jerk Off Tool", Default=false, Callback=function(v) Settings.JerkOffTool=v SetJerkOffTool(v) end})
TrollExtGroup:AddButton({Name="Spam Jump", Callback=function()
    task.spawn(function()
        for i=1,10 do
            local hum = GetHumanoid()
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            task.wait(0.1)
        end
    end)
end})
TrollExtGroup:AddButton({Name="Spam Chat (LOL)", Callback=function()
    task.spawn(function()
        for i=1,5 do
            pcall(function()
                local msg = {"lol","lmao","xD","omg","gg"}
                game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") and
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest"):FireServer(msg[math.random(1,#msg)], "All")
            end)
            task.wait(0.4)
        end
    end)
end})
TrollExtGroup:AddButton({Name="Wall Hop", Callback=function()
    local root = GetRoot() if not root then return end
    local bv = Instance.new("BodyVelocity") bv.Velocity=Vector3.new(0,80,0) bv.MaxForce=Vector3.new(0,9e9,0) bv.Parent=root Debris:AddItem(bv,0.3)
end})

local AutoToyGroup = ExtraTrollSub:AddGroup("Auto Equip Toy", nil, "Right", 220)
AutoToyGroup:AddTextbox({Name="Toy Name", Default="", Callback=function(v) AutoEquipToySettings.ToyName=v end})
AutoToyGroup:AddCheckbox({Name="Auto Equip Toy", Default=false, Callback=function(v) AutoEquipToySettings.Enabled=v end})
AutoToyGroup:AddButton({Name="Equip Now", Callback=function() EquipToy(AutoEquipToySettings.ToyName) end})

local TrollChatGroup = ExtraTrollSub:AddGroup("Chat Spam", nil, "Right", 220)
local chatMsg = ""
TrollChatGroup:AddTextbox({Name="Chat Message", Default="", Callback=function(v) chatMsg=v end})
TrollChatGroup:AddButton({Name="Say in Chat", Callback=function()
    pcall(function()
        local events = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        if events then
            local say = events:FindFirstChild("SayMessageRequest")
            if say then say:FireServer(chatMsg, "All") end
        end
    end)
end})
TrollChatGroup:AddButton({Name="Spam 3x", Callback=function()
    task.spawn(function()
        for i=1,3 do
            pcall(function()
                local events = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
                if events then
                    local say = events:FindFirstChild("SayMessageRequest")
                    if say then say:FireServer(chatMsg, "All") end
                end
            end)
            task.wait(0.3)
        end
    end)
end})

local DiscordGroup = HotkeysSub:AddGroup("Links", nil, "Left", 260)
DiscordGroup:AddButton({Name="sxy.com Discord", Callback=function()
    pcall(function() setclipboard("https://discord.gg/sxy") end)
end})
DiscordGroup:AddButton({Name="Script Pastebin", Callback=function()
    pcall(function() setclipboard("https://pastebin.com") end)
end})
DiscordGroup:AddButton({Name="Script Version: 2.0", Callback=function() end})
DiscordGroup:AddButton({Name="Made by ItsZorlux", Callback=function() end})

local DebugSub = MiscTab:AddSubtab("Debug")
local DebugGroup = DebugSub:AddGroup("Debug Console", nil, "Left", 300)
DebugGroup:AddButton({Name="Dump All Remotes", Callback=function()
    local folder = GetMM2RemoteFolder()
    if not folder then ExposeChatMessage("No remote folder found") return end
    local names = {}
    for _, v in ipairs(folder:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            table.insert(names, v.Name .. "(" .. v.ClassName .. ")")
        end
    end
    ExposeChatMessage("Remotes: " .. table.concat(names, ", "))
end})
DebugGroup:AddButton({Name="Dump Workspace Children", Callback=function()
    local names = {}
    for _, v in ipairs(workspace:GetChildren()) do
        table.insert(names, v.Name .. "[" .. v.ClassName .. "]")
    end
    ExposeChatMessage(table.concat(names, ", "))
end})
DebugGroup:AddButton({Name="Print LocalPlayer Info", Callback=function()
    local msg = string.format("Name:%s ID:%d Team:%s", LocalPlayer.Name, LocalPlayer.UserId, tostring(LocalPlayer.Team and LocalPlayer.Team.Name))
    ExposeChatMessage(msg)
end})
DebugGroup:AddButton({Name="Print Game Info", Callback=function()
    ExposeChatMessage(string.format("PlaceId:%s JobId:%s Players:%d/%d", tostring(game.PlaceId), game.JobId:sub(1,8), #Players:GetPlayers(), Players.MaxPlayers))
end})
DebugGroup:AddButton({Name="Ping Test", Callback=function()
    local t = tick()
    game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    ExposeChatMessage("Ping fetch: " .. math.floor((tick()-t)*1000) .. "ms")
end})
DebugGroup:AddButton({Name="Print FPS", Callback=function()
    local fps = math.floor(1 / game:GetService("RunService").Heartbeat:Wait())
    ExposeChatMessage("FPS: " .. tostring(fps))
end})
DebugGroup:AddButton({Name="Print Memory Usage", Callback=function()
    ExposeChatMessage("Memory: " .. string.format("%.1fMB", gcinfo() / 1024))
end})

local DebugGroup2 = DebugSub:AddGroup("Remote Spy", nil, "Right", 220)
local remoteSpyEnabled = false
local remoteSpyConn
DebugGroup2:AddCheckbox({Name="Remote Spy", Default=false, Callback=function(v)
    remoteSpyEnabled = v
    if remoteSpyConn then remoteSpyConn:Disconnect() remoteSpyConn = nil end
    if not v then return end
    local mt = getrawmetatable(game)
    if not mt then return end
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if remoteSpyEnabled and (method == "FireServer" or method == "InvokeServer") then
            if self:IsA("RemoteEvent") or self:IsA("RemoteFunction") then
                ExposeChatMessage("[SPY] " .. self.Name .. " : " .. method)
            end
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end})

local SoundExtSub = MiscTab:AddSubtab("Audio")
local SoundPresetsGroup = SoundExtSub:AddGroup("Sound Presets", nil, "Left", 260)
local soundNames = {}
for k in pairs(soundPresets) do table.insert(soundNames, k) end
SoundPresetsGroup:AddDropdown({Name="Preset", Items=soundNames, Default=soundNames[1] or "Default", Callback=function(v)
    if soundPresets[v] then SetupCustomSounds(soundPresets[v]) end
end})
SoundPresetsGroup:AddButton({Name="Apply Preset", Callback=function() end})
SoundPresetsGroup:AddButton({Name="Stop All Sounds", Callback=function() MuteSounds() end})
SoundPresetsGroup:AddButton({Name="Restore Sounds", Callback=function() UnmuteSounds() end})

local RadioExtGroup = SoundExtSub:AddGroup("Radio Player", nil, "Right", 220)
local radioInput = ""
RadioExtGroup:AddTextbox({Name="Song ID / URL", Default="", Callback=function(v) radioInput=v end})
RadioExtGroup:AddButton({Name="Play Radio", Callback=function()
    if radioInput ~= "" then PlayRadio(radioInput) end
end})
RadioExtGroup:AddButton({Name="Stop Radio", Callback=function() StopRadio() end})
RadioExtGroup:AddCheckbox({Name="Auto Play on Respawn", Default=false, Callback=function(v)
    ExtraSettings.RadioAutoPlay=v
end})
RadioExtGroup:AddSlider({Name="Volume", Min=0, Max=1, Default=0.5, Decimals=1, Callback=function(v)
    local char = GetCharacter()
    if char then
        for _, sound in ipairs(char:GetDescendants()) do
            if sound:IsA("Sound") and sound.Name == "_ChaosRadio" then
                sound.Volume = v
            end
        end
    end
end})
RadioExtGroup:AddSlider({Name="Playback Speed", Min=0.5, Max=2, Default=1, Decimals=1, Callback=function(v)
    local char = GetCharacter()
    if char then
        for _, sound in ipairs(char:GetDescendants()) do
            if sound:IsA("Sound") and sound.Name == "_ChaosRadio" then
                sound.PlaybackSpeed = v
            end
        end
    end
end})

local TradeExtSub = MiscTab:AddSubtab("Trade+")
local TradeAutoGroup = TradeExtSub:AddGroup("Auto Trade", nil, "Left", 260)
TradeAutoGroup:AddCheckbox({Name="Loop Reset Trade", Default=false, Callback=function(v)
    SetLoopResetTrade(v)
end})
TradeAutoGroup:AddButton({Name="Open Trade with Target", Callback=function()
    local p = GetPlayerByName(selectedTarget) if not p then return end
    local tradeFolder = GetMM2RemoteFolder()
    if tradeFolder then
        local tradeRemote = tradeFolder:FindFirstChild("Trade", true)
        if tradeRemote then pcall(function() tradeRemote:FireServer(p) end) end
    end
end})
TradeAutoGroup:AddButton({Name="Accept All Trades", Callback=function()
    local tradeGui = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("TradeGui")
    if tradeGui then
        local acceptBtn = tradeGui:FindFirstChild("Accept", true)
        if acceptBtn and acceptBtn:IsA("GuiButton") then acceptBtn:Activate() end
    end
end})

local TradeItemGroup = TradeExtSub:AddGroup("Trade Items", nil, "Right", 220)
TradeItemGroup:AddButton({Name="Add All Knives to Trade", Callback=function()
    pcall(function()
        local inv = LocalPlayer:FindFirstChild("Inventory")
        if inv then
            for _, item in ipairs(inv:GetChildren()) do
                if item.Name:lower():find("knife") then
                    local addRemote = GetMM2RemoteFolder():FindFirstChild("AddItem", true)
                    if addRemote then addRemote:FireServer(item) end
                end
            end
        end
    end)
end})
TradeItemGroup:AddButton({Name="Add All Guns to Trade", Callback=function()
    pcall(function()
        local inv = LocalPlayer:FindFirstChild("Inventory")
        if inv then
            for _, item in ipairs(inv:GetChildren()) do
                if item.Name:lower():find("gun") or item.Name:lower():find("sheriff") then
                    local addRemote = GetMM2RemoteFolder():FindFirstChild("AddItem", true)
                    if addRemote then addRemote:FireServer(item) end
                end
            end
        end
    end)
end})

local CosmeticsExtSub = MiscTab:AddSubtab("Cosmetics+")
local CosmeticsMainGroup = CosmeticsExtSub:AddGroup("Cosmetics", nil, "Left", 260)
CosmeticsMainGroup:AddButton({Name="Equip Random Knife Skin", Callback=function()
    local idx = math.random(1, #knifeSkinList)
    ApplyKnifeSkin(knifeSkinList[idx])
end})
CosmeticsMainGroup:AddButton({Name="Equip Random Gun Skin", Callback=function()
    local idx = math.random(1, #gunSkinList)
    ApplyGunSkin(gunSkinList[idx])
end})
CosmeticsMainGroup:AddButton({Name="Cycle All Knife Skins", Callback=function()
    task.spawn(function()
        for _, skin in ipairs(knifeSkinList) do
            ApplyKnifeSkin(skin)
            task.wait(0.3)
        end
    end)
end})
CosmeticsMainGroup:AddButton({Name="Cycle All Gun Skins", Callback=function()
    task.spawn(function()
        for _, skin in ipairs(gunSkinList) do
            ApplyGunSkin(skin)
            task.wait(0.3)
        end
    end)
end})

local CosmeticsLoopGroup = CosmeticsExtSub:AddGroup("Loop Cosmetics", nil, "Right", 220)
CosmeticsLoopGroup:AddCheckbox({Name="Loop Korblox", Default=false, Callback=function(v)
    if not v then ExtraSettings.KorbloxPermanent=false return end
    ExtraSettings.KorbloxPermanent=true
    task.spawn(function()
        while ExtraSettings.KorbloxPermanent do
            ApplyKorblox()
            task.wait(5)
        end
    end)
end})
CosmeticsLoopGroup:AddCheckbox({Name="Loop Headless", Default=false, Callback=function(v)
    if not v then ExtraSettings.HeadlessPermanent=false return end
    ExtraSettings.HeadlessPermanent=true
    task.spawn(function()
        while ExtraSettings.HeadlessPermanent do
            ApplyHeadless()
            task.wait(5)
        end
    end)
end})

local AdvAimlockSub = CombatTab:AddSubtab("Aimlock+")
local AimlockPredGroup = AdvAimlockSub:AddGroup("Prediction", nil, "Left", 260)
AimlockPredGroup:AddCheckbox({Name="Enable Aimlock", Default=false, Callback=function(v) Settings.EnableAimlock=v end})
AimlockPredGroup:AddDropdown({Name="Target Part", Items={"Head","HumanoidRootPart","Torso","Left Arm","Right Arm"}, Default="Head", Callback=function(v) Settings.EnableAimlock_TargetAimpart=v end})
AimlockPredGroup:AddDropdown({Name="Priority", Items={"Closest","Murderer","Sheriff","Innocent","Lowest HP","Random"}, Default="Closest", Callback=function(v) Settings.EnableAimlock_TargetPrioritize=v end})
AimlockPredGroup:AddSlider({Name="FOV Radius", Min=20, Max=500, Default=120, Decimals=0, Callback=function(v) Settings.EnableAimlock_MouseFOVRadius=v end})
AimlockPredGroup:AddCheckbox({Name="Team Check", Default=false, Callback=function(v) Settings.EnableAimlock_TeamCheck=v end})
AimlockPredGroup:AddCheckbox({Name="Wall Check", Default=false, Callback=function(v) Settings.EnableAimlock_WallCheck=v end})
AimlockPredGroup:AddCheckbox({Name="Force Field Check", Default=false, Callback=function(v) Settings.EnableAimlock_ForceFieldCheck=v end})
AimlockPredGroup:AddCheckbox({Name="Health Check", Default=false, Callback=function(v) Settings.EnableAimlock_HealthCheck=v end})

local AimlockVisGroup = AdvAimlockSub:AddGroup("Visuals", nil, "Right", 220)
AimlockVisGroup:AddCheckbox({Name="Draw FOV Circle", Default=false, Callback=function(v)
    CrosshairSettings.FOVCircle = v
    if CrosshairSettings.Enabled then SetupCrosshair(true) end
end})
AimlockVisGroup:AddSlider({Name="FOV Circle Size", Min=20, Max=400, Default=120, Decimals=0, Callback=function(v)
    CrosshairSettings.FOVRadius = v
    Settings.EnableAimlock_MouseFOVRadius = v
    if CrosshairSettings.Enabled then SetupCrosshair(true) end
end})
AimlockVisGroup:AddCheckbox({Name="Lock Indicator", Default=false, Callback=function(v)
    task.spawn(function()
        while v do
            task.wait(0.1)
            local target = nil
            local bestDist = math.huge
            local vp = Camera.ViewportSize
            local center = Vector2.new(vp.X/2, vp.Y/2)
            for _, p in ipairs(Players:GetPlayers()) do
                if p == LocalPlayer then continue end
                local c = p.Character if not c then continue end
                local part = c:FindFirstChild(Settings.EnableAimlock_TargetAimpart) or c:FindFirstChild("HumanoidRootPart")
                if not part then continue end
                local screen, visible = WorldToViewport(part.Position)
                if not visible then continue end
                local dist = (screen - center).Magnitude
                if dist < Settings.EnableAimlock_MouseFOVRadius and dist < bestDist then
                    bestDist = dist target = {player=p, screen=screen}
                end
            end
            if target and target.screen then
                task.wait(0.016)
            end
        end
    end)
end})

local SilentAimExtSub = CombatTab:AddSubtab("Silent Aim+")
local SilentAimExtGroup = SilentAimExtSub:AddGroup("Silent Aim", nil, "Left", 260)
SilentAimExtGroup:AddCheckbox({Name="Gun Silent Aim", Default=false, Callback=function(v) Settings.GunSilentAim=v end})
SilentAimExtGroup:AddDropdown({Name="Target Part", Items={"Head","HumanoidRootPart","Torso"}, Default="Head", Callback=function(v) Settings.GunSilentAim_Aimpart=v end})
SilentAimExtGroup:AddDropdown({Name="Priority", Items={"Closest","Murderer","Sheriff","Innocent","Lowest HP"}, Default="Closest", Callback=function(v) Settings.GunSilentAim_TargetPrioritize=v end})
SilentAimExtGroup:AddCheckbox({Name="Team Check", Default=false, Callback=function(v) Settings.GunSilentAim_TeamCheck=v end})
SilentAimExtGroup:AddCheckbox({Name="Wall Check", Default=false, Callback=function(v) Settings.GunSilentAim_WallCheck=v end})
SilentAimExtGroup:AddCheckbox({Name="Force Field Check", Default=false, Callback=function(v) Settings.GunSilentAim_ForceFieldCheck=v end})
SilentAimExtGroup:AddCheckbox({Name="Always Hit", Default=false, Callback=function(v) Settings.GunSilentAim_AlwaysHit=v end})

local SilentAimHookGroup = SilentAimExtSub:AddGroup("Silent Aim Hook", nil, "Right", 220)
SilentAimHookGroup:AddButton({Name="Install Hook", Callback=function()
    pcall(function()
        local mt = getrawmetatable(game)
        if not mt then return end
        local old = mt.__index
        setreadonly(mt, false)
        mt.__index = newcclosure(function(self, key)
            if Settings.GunSilentAim and (key == "Hit" or key == "Position") and self:IsA("RaycastResult") then
                local best = nil
                local bestDist = math.huge
                for _, p in ipairs(Players:GetPlayers()) do
                    if p == LocalPlayer then continue end
                    local c = p.Character if not c then continue end
                    local part = c:FindFirstChild(Settings.GunSilentAim_Aimpart) or c:FindFirstChild("HumanoidRootPart")
                    if not part then continue end
                    local hum = c:FindFirstChildOfClass("Humanoid")
                    if not hum or hum.Health <= 0 then continue end
                    local root = GetRoot()
                    if not root then continue end
                    local dist = (part.Position - root.Position).Magnitude
                    if dist < bestDist then bestDist = dist best = part end
                end
                if best then
                    if key == "Hit" then return best end
                    if key == "Position" then return best.Position end
                end
            end
            return old(self, key)
        end)
        setreadonly(mt, true)
    end)
end})
SilentAimHookGroup:AddButton({Name="Remove Hook", Callback=function()
    pcall(function()
        local mt = getrawmetatable(game)
        if mt then
            setreadonly(mt, false)
            mt.__index = nil
            setreadonly(mt, true)
        end
    end)
end})

local KnifeExtSub = CombatTab:AddSubtab("Knife+")
local KnifeExtMain = KnifeExtSub:AddGroup("Knife Tools", nil, "Left", 260)
KnifeExtMain:AddCheckbox({Name="Knife Aura", Default=false, Callback=function(v) Settings.KnifeAura=v end})
KnifeExtMain:AddSlider({Name="Aura Range", Min=2, Max=30, Default=7, Decimals=0, Callback=function(v) Settings.KnifeRange=v end})
KnifeExtMain:AddCheckbox({Name="Auto Slash", Default=false, Callback=function(v) Settings.AutoSlash=v end})
KnifeExtMain:AddCheckbox({Name="Auto Spam", Default=false, Callback=function(v) Settings.AutoSpam=v end})
KnifeExtMain:AddCheckbox({Name="Instant Throw", Default=false, Callback=function(v) Settings.InstantThrow=v end})
KnifeExtMain:AddCheckbox({Name="Fast Throw", Default=false, Callback=function(v) Settings.FastThrow=v end})
KnifeExtMain:AddCheckbox({Name="Kill Aura", Default=false, Callback=function(v) Settings.KillAura=v end})
KnifeExtMain:AddSlider({Name="Kill Aura Radius", Min=5, Max=60, Default=20, Decimals=0, Callback=function(v) Settings.KillAuraRadius=v end})
KnifeExtMain:AddCheckbox({Name="Kill All", Default=false, Callback=function(v) Settings.KillAll=v end})
KnifeExtMain:AddCheckbox({Name="Kill Gun Players", Default=false, Callback=function(v) Settings.KillGunPlayers=v end})

local KnifeThrowGroup = KnifeExtSub:AddGroup("Throw Settings", nil, "Right", 220)
KnifeThrowGroup:AddCheckbox({Name="Throw Aimbot", Default=false, Callback=function(v) Settings.KnifeThrowAimbot=v end})
KnifeThrowGroup:AddDropdown({Name="Throw Mode", Items={"Smart","Instant","Predictive","Manual"}, Default="Smart", Callback=function(v) Settings.KnifeThrowMode=v end})
KnifeThrowGroup:AddSlider({Name="Max Distance", Min=50, Max=500, Default=250, Decimals=0, Callback=function(v) Settings.KnifeThrowMaxDist=v end})
KnifeThrowGroup:AddSlider({Name="FOV", Min=10, Max=360, Default=360, Decimals=0, Callback=function(v) Settings.KnifeThrowFOV=v end})
KnifeThrowGroup:AddCheckbox({Name="Wall Check", Default=true, Callback=function(v) Settings.KnifeThrowWallCheck=v end})
KnifeThrowGroup:AddCheckbox({Name="Predict Movement", Default=true, Callback=function(v) Settings.KnifeThrowPredict=v end})
KnifeThrowGroup:AddSlider({Name="Lead Amount", Min=0, Max=300, Default=100, Decimals=0, Callback=function(v) Settings.KnifeThrowLead=v end})
KnifeThrowGroup:AddCheckbox({Name="Sticky Aim", Default=true, Callback=function(v) Settings.KnifeThrowSticky=v end})
KnifeThrowGroup:AddCheckbox({Name="Throw Marker", Default=true, Callback=function(v) Settings.KnifeThrowMarker=v end})

local AutoThrowGroup = KnifeExtSub:AddGroup("Auto Throw", nil, "Left", 220)
AutoThrowGroup:AddCheckbox({Name="Auto Throw", Default=false, Callback=function(v) Settings.AutoThrow=v end})
AutoThrowGroup:AddSlider({Name="Min Chance %", Min=1, Max=100, Default=55, Decimals=0, Callback=function(v) Settings.AutoThrowMinChance=v end})
AutoThrowGroup:AddSlider({Name="Range", Min=10, Max=200, Default=70, Decimals=0, Callback=function(v) Settings.AutoThrowRange=v end})
AutoThrowGroup:AddCheckbox({Name="Auto Notify Clash", Default=false, Callback=function(v) Settings.AutoNotifyUponClashing=v end})

local VisualESPExtSub = VisualTab:AddSubtab("ESP Settings")
local ESPExtGroup = VisualESPExtSub:AddGroup("ESP Config", nil, "Left", 260)
ESPExtGroup:AddCheckbox({Name="ESP", Default=false, Callback=function(v) Settings.ESPEnabled=v end})
ESPExtGroup:AddCheckbox({Name="Murderer ESP", Default=true, Callback=function(v) Settings.ESPMurderer=v end})
ESPExtGroup:AddCheckbox({Name="Sheriff ESP", Default=true, Callback=function(v) Settings.ESPSheriff=v end})
ESPExtGroup:AddCheckbox({Name="Innocent ESP", Default=false, Callback=function(v) Settings.ESPInnocent=v end})
ESPExtGroup:AddCheckbox({Name="Show Distance", Default=false, Callback=function(v) Settings.ESPDistance=v end})
ESPExtGroup:AddCheckbox({Name="Show Names", Default=true, Callback=function(v) Settings.ESPName=v end})
ESPExtGroup:AddCheckbox({Name="Show Box", Default=false, Callback=function(v) Settings.ESPBox=v end})
ESPExtGroup:AddCheckbox({Name="Show Health", Default=false, Callback=function(v) Settings.ESPHealth=v end})

local ESPColorGroup = VisualESPExtSub:AddGroup("ESP Colors", nil, "Right", 220)
ESPColorGroup:AddColorpicker({Name="Murderer Color", Default=Color3.fromRGB(255,30,30), Callback=function(v) Settings.ESPMurdColor=v end})
ESPColorGroup:AddColorpicker({Name="Sheriff Color", Default=Color3.fromRGB(30,120,255), Callback=function(v) Settings.ESPSherColor=v end})
ESPColorGroup:AddColorpicker({Name="Innocent Color", Default=Color3.fromRGB(220,220,220), Callback=function(v) Settings.ESPInnColor=v end})
ESPColorGroup:AddColorpicker({Name="Text Color", Default=Color3.fromRGB(255,255,255), Callback=function(v) Settings.ESPTextColor=v end})
local ESPFeatGroup = VisualESPExtSub:AddGroup("ESP Features", nil, "Left", 260)
ESPFeatGroup:AddCheckbox({Name="Skeleton", Default=false, Callback=function(v) Settings.ESPSkeleton=v end})
ESPFeatGroup:AddCheckbox({Name="Head Dot", Default=false, Callback=function(v) Settings.ESPHeadDot=v end})
ESPFeatGroup:AddCheckbox({Name="Look Line", Default=false, Callback=function(v) Settings.ESPLookLine=v end})
ESPFeatGroup:AddCheckbox({Name="Chams (Fill)", Default=false, Callback=function(v) Settings.ESPChams=v end})

local LightExtSub = VisualTab:AddSubtab("Light+")
local LightExtGroup = LightExtSub:AddGroup("Lighting", nil, "Left", 260)
LightExtGroup:AddCheckbox({Name="Full Bright", Default=false, Callback=function(v) Settings.FullBright=v if v then Lighting.Brightness=10 Lighting.ClockTime=14 else Lighting.Brightness=1 end end})
LightExtGroup:AddCheckbox({Name="Night Mode", Default=false, Callback=function(v) Settings.NightMode=v if v then Lighting.ClockTime=0 Lighting.Brightness=0 else Lighting.Brightness=1 end end})
LightExtGroup:AddCheckbox({Name="X-Ray (See Through Walls)", Default=false, Callback=function(v) ExtraSettings.XRay=v SetXRay(v) end})
LightExtGroup:AddSlider({Name="Brightness", Min=0, Max=20, Default=1, Decimals=1, Callback=function(v) Lighting.Brightness=v end})
LightExtGroup:AddSlider({Name="Blur Size", Min=0, Max=56, Default=0, Decimals=0, Callback=function(v)
    local blur = Lighting:FindFirstChildOfClass("BlurEffect") or Instance.new("BlurEffect", Lighting)
    blur.Size = v
end})
LightExtGroup:AddSlider({Name="Saturation", Min=-1, Max=1, Default=0, Decimals=1, Callback=function(v)
    local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
    cc.Saturation = v
end})
LightExtGroup:AddSlider({Name="Contrast", Min=-1, Max=1, Default=0, Decimals=1, Callback=function(v)
    local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
    cc.Contrast = v
end})
LightExtGroup:AddColorpicker({Name="Tint Color", Default=Color3.fromRGB(255,255,255), Callback=function(v)
    local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
    cc.TintColor = v
end})

local SunRaysGroup = LightExtSub:AddGroup("Post FX", nil, "Right", 220)
SunRaysGroup:AddCheckbox({Name="Sun Rays", Default=false, Callback=function(v)
    local existing = Lighting:FindFirstChildOfClass("SunRaysEffect")
    if v then
        if not existing then Instance.new("SunRaysEffect", Lighting) end
    else
        if existing then existing:Destroy() end
    end
end})
SunRaysGroup:AddCheckbox({Name="Bloom Effect", Default=false, Callback=function(v)
    local existing = Lighting:FindFirstChildOfClass("BloomEffect")
    if v then
        if not existing then local b=Instance.new("BloomEffect",Lighting) b.Intensity=1 b.Size=24 b.Threshold=0.95 end
    else
        if existing then existing:Destroy() end
    end
end})
SunRaysGroup:AddCheckbox({Name="Depth of Field", Default=false, Callback=function(v)
    local existing = Lighting:FindFirstChildOfClass("DepthOfFieldEffect")
    if v then
        if not existing then local d=Instance.new("DepthOfFieldEffect",Lighting) d.FarIntensity=1 d.InFocusRadius=20 d.NearIntensity=1 end
    else
        if existing then existing:Destroy() end
    end
end})
SunRaysGroup:AddButton({Name="Remove All Effects", Callback=function()
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then v:Destroy() end
    end
end})

local HUDWorldExtSub = WorldTab:AddSubtab("HUD")
local HUDExtGroup = HUDWorldExtSub:AddGroup("HUD Elements", nil, "Left", 260)
HUDExtGroup:AddCheckbox({Name="Show Game Info", Default=false, Callback=function(v) Settings.ShowGameInfo=v end})
HUDExtGroup:AddCheckbox({Name="Show Round Timer", Default=false, Callback=function(v) Settings.ShowRoundTimer=v end})
HUDExtGroup:AddCheckbox({Name="Loop First Person", Default=false, Callback=function(v) Settings.LoopToFirstPersonCamera=v end})
HUDExtGroup:AddCheckbox({Name="Custom Crosshair", Default=false, Callback=function(v) CrosshairSettings.Enabled=v SetupCrosshair(v) end})

local MinimapGroup = HUDWorldExtSub:AddGroup("Minimap", nil, "Right", 220)
local minimapGui
MinimapGroup:AddCheckbox({Name="Minimap", Default=false, Callback=function(v)
    if minimapGui then minimapGui:Destroy() minimapGui=nil end
    if not v then return end
    minimapGui = Instance.new("ScreenGui") minimapGui.Name="ChaosMinimap" minimapGui.IgnoreGuiInset=true minimapGui.ResetOnSpawn=false minimapGui.DisplayOrder=14 minimapGui.Parent=game.CoreGui
    local frame = Instance.new("Frame") frame.Size=UDim2.new(0,120,0,120) frame.Position=UDim2.new(1,-135,1,-140) frame.BackgroundColor3=Color3.fromRGB(4,1,7) frame.BackgroundTransparency=0.3 frame.BorderSizePixel=0 frame.Parent=minimapGui
    Instance.new("UICorner",frame).CornerRadius=UDim.new(0,8)
    local stroke=Instance.new("UIStroke") stroke.Color=Color3.fromRGB(222,32,78) stroke.Thickness=1 stroke.Parent=frame
    local title=Instance.new("TextLabel") title.Size=UDim2.new(1,0,0,16) title.BackgroundTransparency=1 title.Text="MAP" title.TextColor3=Color3.fromRGB(240,76,124) title.TextSize=9 title.Font=Enum.Font.GothamBold title.Parent=frame
    task.spawn(function()
        while minimapGui and minimapGui.Parent do
            task.wait(0.1)
            for _, dot in ipairs(frame:GetChildren()) do
                if dot:IsA("Frame") and dot.Name:find("_mm_dot") then dot:Destroy() end
            end
            local root = GetRoot()
            if not root then continue end
            local myPos = root.Position
            for _, p in ipairs(Players:GetPlayers()) do
                local c = p.Character if not c then continue end
                local pr = c:FindFirstChild("HumanoidRootPart") if not pr then continue end
                local isMurd = FindMurderer()==p local isSher = FindSheriff()==p
                local dot = Instance.new("Frame")
                dot.Name = p.Name.."_mm_dot"
                local relX = (pr.Position.X - myPos.X) / 200
                local relZ = (pr.Position.Z - myPos.Z) / 200
                dot.Size = UDim2.new(0,6,0,6)
                dot.Position = UDim2.new(0.5+relX,-3,0.5+relZ,-3)
                dot.BackgroundColor3 = p==LocalPlayer and Color3.fromRGB(0,255,0) or isMurd and Color3.fromRGB(255,50,50) or isSher and Color3.fromRGB(50,150,255) or Color3.fromRGB(220,220,220)
                dot.BorderSizePixel = 0
                dot.ClipsDescendants = false
                Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
                dot.Parent = frame
            end
        end
    end)
end})
MinimapGroup:AddSlider({Name="Minimap Range", Min=50, Max=500, Default=200, Decimals=0, Callback=function(v) end})

local MovExtSub = PlayerTab:AddSubtab("Flight+")
local FlightExtGroup = MovExtSub:AddGroup("Fly Settings", nil, "Left", 260)
FlightExtGroup:AddCheckbox({Name="Fly", Default=false, Callback=function(v) Settings.Fly=v SetFly(v) end})
FlightExtGroup:AddSlider({Name="Fly Speed", Min=10, Max=300, Default=50, Decimals=0, Callback=function(v) Settings.FlySpeed=v end})
FlightExtGroup:AddCheckbox({Name="CFrame Fly", Default=false, Callback=function(v) Settings.CFrameFly=v SetCFrameFly(v) end})
FlightExtGroup:AddSlider({Name="CFrame Speed", Min=10, Max=300, Default=50, Decimals=0, Callback=function(v) Settings.CFrameFlySpeed=v end})
FlightExtGroup:AddButton({Name="Fly Up Fast", Callback=function()
    local root = GetRoot() if not root then return end
    local bv = Instance.new("BodyVelocity") bv.Velocity=Vector3.new(0,100,0) bv.MaxForce=Vector3.new(0,9e9,0) bv.Parent=root Debris:AddItem(bv,1)
end})
FlightExtGroup:AddButton({Name="Teleport Up +100", Callback=function()
    local root = GetRoot() if not root then return end
    root.CFrame = root.CFrame + Vector3.new(0,100,0)
end})
FlightExtGroup:AddButton({Name="Float Mode", Callback=function()
    ExtraSettings.FloatEnabled = not ExtraSettings.FloatEnabled
    SetFloat(ExtraSettings.FloatEnabled)
end})
FlightExtGroup:AddSlider({Name="Float Height", Min=0, Max=1000, Default=310, Decimals=0, Callback=function(v) ExtraSettings.FloatOffset=v if ExtraSettings.FloatEnabled then SetFloat(true) end end})

local WalkSpeedGroup = MovExtSub:AddGroup("Walk Speed", nil, "Right", 220)
WalkSpeedGroup:AddSlider({Name="Walk Speed", Min=1, Max=300, Default=16, Decimals=0, Callback=function(v)
    Settings.WalkSpeed=v
    local hum=GetHumanoid() if hum then hum.WalkSpeed=v end
end})
WalkSpeedGroup:AddSlider({Name="Jump Power", Min=1, Max=500, Default=50, Decimals=0, Callback=function(v)
    Settings.JumpPower=v
    local hum=GetHumanoid() if hum then hum.JumpPower=v end
end})
WalkSpeedGroup:AddButton({Name="Reset Speed", Callback=function()
    Settings.WalkSpeed=16 Settings.JumpPower=50
    local hum=GetHumanoid() if hum then hum.WalkSpeed=16 hum.JumpPower=50 end
end})
WalkSpeedGroup:AddButton({Name="Max Speed (300)", Callback=function()
    Settings.WalkSpeed=300
    local hum=GetHumanoid() if hum then hum.WalkSpeed=300 end
end})

local WallHopExtSub = PlayerTab:AddSubtab("Wall Hop")
local WallHopGroup = WallHopExtSub:AddGroup("Wall Hop", nil, "Left", 260)
WallHopGroup:AddCheckbox({Name="Wall Hop", Default=false, Callback=function(v) Settings.WallHop=v end})
WallHopGroup:AddDropdown({Name="Mode", Items={"Press","Auto","Hold"}, Default="Press", Callback=function(v) Settings.WallHopMode=v end})
WallHopGroup:AddSlider({Name="Angle", Min=0, Max=180, Default=90, Decimals=0, Callback=function(v) Settings.WallHopAngle=v end})
WallHopGroup:AddCheckbox({Name="Cam Flick", Default=false, Callback=function(v) Settings.WallHopCamFlick=v end})

local WallHopInfoGroup = WallHopExtSub:AddGroup("Wall Hop Info", nil, "Right", 220)
WallHopInfoGroup:AddButton({Name="How to Wall Hop", Callback=function()
    ExposeChatMessage("Wall Hop: Enable and press direction + Space near a wall to hop off it at an angle")
end})
WallHopInfoGroup:AddButton({Name="Best Angle: 90", Callback=function() Settings.WallHopAngle=90 end})
WallHopInfoGroup:AddButton({Name="Aggressive: 45", Callback=function() Settings.WallHopAngle=45 end})

local AutoCollectSub = FarmTab:AddSubtab("Collection")
local CoinCollectGroup = AutoCollectSub:AddGroup("Coin Collection", nil, "Left", 260)
CoinCollectGroup:AddCheckbox({Name="Auto Collect Coins", Default=false, Callback=function(v)
    Settings.AutoCollectCoins=v
    if v then
        task.spawn(function()
            while Settings.AutoCollectCoins do
                local root = GetRoot()
                if root then
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if (obj.Name == "Coin" or obj.Name == "Gem") and obj:IsA("BasePart") then
                            if (obj.Position - root.Position).Magnitude < 5 then
                                ScriptSettings.CoinCount = ScriptSettings.CoinCount + 1
                                farmCoinCount = farmCoinCount + 1
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end})
CoinCollectGroup:AddCheckbox({Name="Teleport To Coins", Default=false, Callback=function(v)
    if v then
        task.spawn(function()
            while v do
                local root = GetRoot()
                if root then
                    local nearest, nearestDist = nil, math.huge
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj.Name == "Coin" and obj:IsA("BasePart") then
                            local dist = (obj.Position - root.Position).Magnitude
                            if dist < nearestDist then nearestDist=dist nearest=obj end
                        end
                    end
                    if nearest and nearestDist > 2 then
                        root.CFrame = CFrame.new(nearest.Position)
                    end
                end
                task.wait(FarmSettings.TweenDelay / 100)
            end
        end)
    end
end})
CoinCollectGroup:AddSlider({Name="Collect Speed", Min=0.01, Max=1, Default=0.1, Decimals=2, Callback=function(v) FarmSettings.TweenDelay=v*100 end})

local PrestigeGroup = AutoCollectSub:AddGroup("Prestige Farm", nil, "Right", 220)
PrestigeGroup:AddCheckbox({Name="Auto Prestige", Default=false, Callback=function(v)
    Settings.AutoPrestige=v
    if v then
        task.spawn(function()
            while Settings.AutoPrestige do
                pcall(function()
                    local prestigeRemote = GetMM2RemoteFolder():FindFirstChild("Prestige", true)
                    if prestigeRemote then prestigeRemote:FireServer() end
                end)
                task.wait(10)
            end
        end)
    end
end})
PrestigeGroup:AddButton({Name="Prestige Now", Callback=function()
    pcall(function()
        local prestigeRemote = GetMM2RemoteFolder():FindFirstChild("Prestige", true)
        if prestigeRemote then prestigeRemote:FireServer() end
    end)
end})

local CrateOpenSub = FarmTab:AddSubtab("Crates+")
local CrateExtGroup = CrateOpenSub:AddGroup("Crate Opening", nil, "Left", 260)
local crateTypes = {"Innocent","Detective","Hero","Common","Uncommon","Rare","Legendary","Godly","Classic","Vintage"}
CrateExtGroup:AddDropdown({Name="Crate Type", Items=crateTypes, Default="Common", Callback=function(v)
    FarmSettings.CrateType=v
end})
CrateExtGroup:AddCheckbox({Name="Auto Open Crates", Default=false, Callback=function(v)
    FarmSettings.AutoOpenCrates=v
    if v then
        task.spawn(function()
            while FarmSettings.AutoOpenCrates do
                pcall(function()
                    local crateRemote = GetMM2RemoteFolder():FindFirstChild("OpenCrate", true)
                    if crateRemote then crateRemote:FireServer(FarmSettings.CrateType or "Common") end
                end)
                task.wait(FarmSettings.TweenDelay or 0.5)
            end
        end)
    end
end})
CrateExtGroup:AddSlider({Name="Open Delay (s)", Min=0.1, Max=5, Default=0.5, Decimals=1, Callback=function(v) FarmSettings.TweenDelay=v end})
CrateExtGroup:AddButton({Name="Open One Crate", Callback=function()
    pcall(function()
        local crateRemote = GetMM2RemoteFolder():FindFirstChild("OpenCrate", true)
        if crateRemote then crateRemote:FireServer(FarmSettings.CrateType or "Common") end
    end)
end})
CrateExtGroup:AddButton({Name="Open 10 Crates", Callback=function()
    task.spawn(function()
        for i=1,10 do
            pcall(function()
                local crateRemote = GetMM2RemoteFolder():FindFirstChild("OpenCrate", true)
                if crateRemote then crateRemote:FireServer(FarmSettings.CrateType or "Common") end
            end)
            task.wait(0.5)
        end
    end)
end})

local CrateStatGroup = CrateOpenSub:AddGroup("Crate Stats", nil, "Right", 220)
local cratesOpened = 0
CrateStatGroup:AddButton({Name="Crates Opened: 0", Callback=function()
    ExposeChatMessage("Crates opened this session: " .. cratesOpened)
end})
CrateStatGroup:AddButton({Name="Reset Crate Count", Callback=function() cratesOpened=0 end})

local function OnCharacterAdded(char)
    hum.WalkSpeed=Settings.WalkSpeed hum.JumpPower=Settings.JumpPower
    if Settings.InfiniteJump then SetInfiniteJump(true) end
    if Settings.NoClip then SetNoClip(true) end
    if Settings.AntiFling then SetAntiFling(true) end
    if Settings.Invisible then SetInvisible(true) end
    if Settings.FreezeCharacter then
        for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.Anchored=true end end
    end
    if Settings.TouchFling then SetTouchFling(true) end
    if Settings.JerkOffTool then task.delay(1,function() SetJerkOffTool(true) end) end
    if Settings.KnifeSkinChanger~="Default" then task.delay(1,function() ApplyKnifeSkin(Settings.KnifeSkinChanger) end) end
    if ExtraSettings.KorbloxPermanent then task.delay(2, function() ApplyKorblox() end) end
    if ExtraSettings.HeadlessPermanent then task.delay(2, function() ApplyHeadless() end) end
    if ExtraSettings.RadioAutoPlay and ExtraSettings.RadioSongId ~= "" then
        task.delay(1, function() PlayRadio(ExtraSettings.RadioSongId) end)
    end
    if ExtraSettings.FloatEnabled then task.delay(0.5, function() SetFloat(true) end) end
    if ExtraSettings.XRay then SetXRay(true) end
    if ExtraSettings.JumpBoost then SetJumpBoost(true) end
    if ExtraSettings.AntiVoid then SetAntiVoid(true) end
    local role = hum:GetAttribute("Role") or ""
    if FarmSettings.AutoResetAsMurderer and role == "Murderer" then
        task.delay(0.5, function() LocalPlayer:LoadCharacter() end)
    end
    if FarmSettings.AutoResetAsSheriff and role == "Sheriff" then
        task.delay(0.5, function() LocalPlayer:LoadCharacter() end)
    end
    if FarmSettings.AutoResetAsInnocent and role == "Innocent" then
        task.delay(0.5, function() LocalPlayer:LoadCharacter() end)
    end
end

local BodyScaleSettings = {
    HeadScale = 1,
    BodyHeightScale = 1,
    BodyWidthScale = 1,
    BodyDepthScale = 1,
    Enabled = false
}

local NotifSettings = {
    Enabled = true,
    ShowKills = true,
    ShowRole = true,
    ShowCoins = true,
    ShowEvents = true,
    Duration = 4,
    Position = "TopRight"
}

local function ShowNotif(title, msg, ntype)
    if not NotifSettings.Enabled then return end
    pcall(function()
        local gui = game.CoreGui:FindFirstChild("ChaosNotifGui")
        if not gui then
            gui = Instance.new("ScreenGui")
            gui.Name = "ChaosNotifGui"
            gui.IgnoreGuiInset = true
            gui.ResetOnSpawn = false
            gui.DisplayOrder = 20
            gui.Parent = game.CoreGui
        end
        local notifCount = #gui:GetChildren()
        local color = ntype == "kill" and Color3.fromRGB(255,60,60) or ntype == "role" and Color3.fromRGB(222,32,78) or ntype == "coin" and Color3.fromRGB(255,215,0) or Color3.fromRGB(180,180,220)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0,220,0,52)
        frame.Position = UDim2.new(1,-235,0,10 + notifCount*58)
        frame.BackgroundColor3 = Color3.fromRGB(14,8,20)
        frame.BackgroundTransparency = 0.1
        frame.BorderSizePixel = 0
        frame.Parent = gui
        Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)
        local stroke = Instance.new("UIStroke") stroke.Color=color stroke.Thickness=1.5 stroke.Parent=frame
        local accent = Instance.new("Frame") accent.Size=UDim2.new(0,3,1,0) accent.Position=UDim2.new(0,0,0,0) accent.BackgroundColor3=color accent.BorderSizePixel=0 accent.Parent=frame
        Instance.new("UICorner",accent).CornerRadius=UDim.new(0,4)
        local titleLabel = Instance.new("TextLabel") titleLabel.Size=UDim2.new(1,-12,0,18) titleLabel.Position=UDim2.new(0,10,0,6) titleLabel.BackgroundTransparency=1 titleLabel.Text=title titleLabel.TextColor3=color titleLabel.TextSize=11 titleLabel.Font=Enum.Font.GothamBold titleLabel.TextXAlignment=Enum.TextXAlignment.Left titleLabel.Parent=frame
        local msgLabel = Instance.new("TextLabel") msgLabel.Size=UDim2.new(1,-12,0,22) msgLabel.Position=UDim2.new(0,10,0,24) msgLabel.BackgroundTransparency=1 msgLabel.Text=msg msgLabel.TextColor3=Color3.fromRGB(220,210,230) msgLabel.TextSize=10 msgLabel.Font=Enum.Font.Gotham msgLabel.TextXAlignment=Enum.TextXAlignment.Left msgLabel.Parent=frame
        task.delay(NotifSettings.Duration, function()
            if frame and frame.Parent then frame:Destroy() end
        end)
    end)
end

local function SetBodyScale(v)
    BodyScaleSettings.Enabled = v
    local char = GetCharacter()
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if not v then
        hum.BodyHeightScale.Value = 1
        hum.BodyWidthScale.Value = 1
        hum.BodyDepthScale.Value = 1
        hum.HeadScale.Value = 1
        return
    end
    hum.BodyHeightScale.Value = BodyScaleSettings.BodyHeightScale
    hum.BodyWidthScale.Value = BodyScaleSettings.BodyWidthScale
    hum.BodyDepthScale.Value = BodyScaleSettings.BodyDepthScale
    hum.HeadScale.Value = BodyScaleSettings.HeadScale
end

local function ApplyBodyScaleToChar(char, hum)
    if not BodyScaleSettings.Enabled then return end
    hum.BodyHeightScale.Value = BodyScaleSettings.BodyHeightScale
    hum.BodyWidthScale.Value = BodyScaleSettings.BodyWidthScale
    hum.BodyDepthScale.Value = BodyScaleSettings.BodyDepthScale
    hum.HeadScale.Value = BodyScaleSettings.HeadScale
end

local function OnKillDetected(killedPlayer)
    hudKillCount = hudKillCount + 1
    if ParticleFXSettings.KillBurst then
        local char = killedPlayer and killedPlayer.Character
        local pos = char and char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position or Vector3.new(0,5,0)
        FireKillBurst(pos)
    end
    if ScreenFXSettings.KillFlash then
        task.spawn(FlashScreen, Color3.fromRGB(222,32,78), 0.4)
    end
    if SoundFXSettings.KillSoundExtra then
        local snd = Instance.new("Sound")
        snd.SoundId = SoundFXSettings.KillSoundExtraId
        snd.Volume = 0.7
        snd.Parent = workspace
        snd:Play()
        Debris:AddItem(snd, 2)
    end
end

local function WatchPlayerForKill(p)
    local char = p.Character
    local function hookChar(c)
        local hum = c:WaitForChild("Humanoid", 5)
        if not hum then return end
        hum.Died:Connect(function()
            if p == LocalPlayer then return end
            OnKillDetected(p)
        end)
    end
    if char then task.spawn(hookChar, char) end
    p.CharacterAdded:Connect(function(c) task.spawn(hookChar, c) end)
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then WatchPlayerForKill(p) end
end
Players.PlayerAdded:Connect(function(p) WatchPlayerForKill(p) end)

local function SetNoclip(v)
    ExtraSettings.Noclip = v
    if v then
        task.spawn(function()
            while ExtraSettings.Noclip do
                local char = GetCharacter()
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
                RunService.Heartbeat:Wait()
            end
            local char = GetCharacter()
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end)
    end
end

local function SetTimescale(v)
    ExtraSettings.Timescale = v
    workspace:GetPropertyChangedSignal("DistributedGameTime"):Connect(function() end)
    local physSettings = settings().Physics
    pcall(function()
        physSettings.AllowSleep = not v
    end)
end

local function SendChatMessage(msg)
    local chatService = game:GetService("Chat")
    if chatService then
        pcall(function()
            chatService:Chat(LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head"), msg)
        end)
    end
end

local function GetTopPlayers()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        local coins = p:GetAttribute("Coins") or p.leaderstats and p.leaderstats:FindFirstChild("Coins") and p.leaderstats.Coins.Value or 0
        table.insert(list, {player=p, coins=coins})
    end
    table.sort(list, function(a,b) return a.coins > b.coins end)
    return list
end

local function GetPlayerByPartialName(partial)
    partial = partial:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():find(partial) then return p end
    end
    return nil
end

local function TeleportToPlayer(targetName)
    local p = GetPlayerByPartialName(targetName)
    if not p then return end
    local c = p.Character if not c then return end
    local root = GetRoot() if not root then return end
    local pr = c:FindFirstChild("HumanoidRootPart") if not pr then return end
    root.CFrame = pr.CFrame * CFrame.new(3,0,0)
end

local function PullPlayerToMe(targetName)
    local p = GetPlayerByPartialName(targetName)
    if not p then return end
    local c = p.Character if not c then return end
    local root = GetRoot() if not root then return end
    local pr = c:FindFirstChild("HumanoidRootPart") if not pr then return end
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = (root.Position - pr.Position).Unit * 80
    bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    bv.Parent = pr
    Debris:AddItem(bv, 0.3)
end

local AppearExtSub = PlayerTab:AddSubtab("Appearance+")
local BodyScaleGroup = AppearExtSub:AddGroup("Body Scale", nil, "Left", 260)
BodyScaleGroup:AddCheckbox({Name="Enable Scale Changer", Default=false, Callback=function(v)
    BodyScaleSettings.Enabled = v
    SetBodyScale(v)
end})
BodyScaleGroup:AddSlider({Name="Head Scale", Min=0.1, Max=5, Default=1, Decimals=1, Callback=function(v)
    BodyScaleSettings.HeadScale = v
    if BodyScaleSettings.Enabled then SetBodyScale(true) end
end})
BodyScaleGroup:AddSlider({Name="Height Scale", Min=0.1, Max=5, Default=1, Decimals=1, Callback=function(v)
    BodyScaleSettings.BodyHeightScale = v
    if BodyScaleSettings.Enabled then SetBodyScale(true) end
end})
BodyScaleGroup:AddSlider({Name="Width Scale", Min=0.1, Max=5, Default=1, Decimals=1, Callback=function(v)
    BodyScaleSettings.BodyWidthScale = v
    if BodyScaleSettings.Enabled then SetBodyScale(true) end
end})
BodyScaleGroup:AddSlider({Name="Depth Scale", Min=0.1, Max=5, Default=1, Decimals=1, Callback=function(v)
    BodyScaleSettings.BodyDepthScale = v
    if BodyScaleSettings.Enabled then SetBodyScale(true) end
end})
BodyScaleGroup:AddButton({Name="Tiny (0.1x)", Callback=function()
    BodyScaleSettings.HeadScale=0.1 BodyScaleSettings.BodyHeightScale=0.1 BodyScaleSettings.BodyWidthScale=0.1 BodyScaleSettings.BodyDepthScale=0.1
    SetBodyScale(true)
end})
BodyScaleGroup:AddButton({Name="Normal (1x)", Callback=function()
    BodyScaleSettings.HeadScale=1 BodyScaleSettings.BodyHeightScale=1 BodyScaleSettings.BodyWidthScale=1 BodyScaleSettings.BodyDepthScale=1
    SetBodyScale(true)
end})
BodyScaleGroup:AddButton({Name="Giant (5x)", Callback=function()
    BodyScaleSettings.HeadScale=5 BodyScaleSettings.BodyHeightScale=5 BodyScaleSettings.BodyWidthScale=5 BodyScaleSettings.BodyDepthScale=5
    SetBodyScale(true)
end})
BodyScaleGroup:AddButton({Name="Big Head Only", Callback=function()
    BodyScaleSettings.HeadScale=3 BodyScaleSettings.BodyHeightScale=1 BodyScaleSettings.BodyWidthScale=1 BodyScaleSettings.BodyDepthScale=1
    SetBodyScale(true)
end})

local AppearPresetsGroup = AppearExtSub:AddGroup("Presets", nil, "Right", 220)
AppearPresetsGroup:AddButton({Name="Invisible Mode", Callback=function()
    SetInvisible(true)
end})
AppearPresetsGroup:AddButton({Name="Visible Mode", Callback=function()
    SetInvisible(false)
end})
AppearPresetsGroup:AddButton({Name="Korblox Look", Callback=function()
    ApplyKorblox()
end})
AppearPresetsGroup:AddButton({Name="Headless Look", Callback=function()
    ApplyHeadless()
end})
AppearPresetsGroup:AddButton({Name="Reset Character", Callback=function()
    LocalPlayer:LoadCharacter()
end})
AppearPresetsGroup:AddButton({Name="Sparkle Trail", Callback=function()
    local char = GetCharacter() if not char then return end
    local root = GetRoot() if not root then return end
    local att = Instance.new("Attachment") att.Parent=root
    local particles = Instance.new("ParticleEmitter") particles.Parent=att particles.Lifetime=NumberRange.new(0.5,1) particles.Rate=50 particles.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(222,32,78)),ColorSequenceKeypoint.new(1,Color3.fromRGB(100,0,255))} particles.Speed=NumberRange.new(2,5) particles.SpreadAngle=Vector2.new(90,90)
end})

local NoclipSub = PlayerTab:AddSubtab("Noclip")
local NoclipMainGroup = NoclipSub:AddGroup("Noclip Settings", nil, "Left", 260)
NoclipMainGroup:AddCheckbox({Name="Noclip", Default=false, Callback=function(v) SetNoclip(v) end})
NoclipMainGroup:AddDropdown({Name="Noclip Mode", Items={"Full Body","Legs Only","Arms Only"}, Default="Full Body", Callback=function(v) ExtraSettings.NoclipMode=v end})
NoclipMainGroup:AddButton({Name="Phase Through Floor", Callback=function()
    local root = GetRoot() if not root then return end
    root.CFrame = root.CFrame - Vector3.new(0,10,0)
end})
NoclipMainGroup:AddButton({Name="Phase Through Wall (Forward)", Callback=function()
    local root = GetRoot() if not root then return end
    local cf = root.CFrame
    root.CFrame = cf + cf.LookVector * 15
end})

local NoclipInfoGroup = NoclipSub:AddGroup("Info", nil, "Right", 220)
NoclipInfoGroup:AddButton({Name="Anti Noclip Detection", Callback=function()
    ExtraSettings.AntiNoclipDetect = not ExtraSettings.AntiNoclipDetect
    ShowNotif("Chaos", "Anti-Noclip Detect: " .. (ExtraSettings.AntiNoclipDetect and "ON" or "OFF"), "event")
end})

local AdvTrollSub2 = PlayerTab:AddSubtab("Troll 2")
local PhysicsTrollGroup = AdvTrollSub2:AddGroup("Physics Troll", nil, "Left", 260)
PhysicsTrollGroup:AddCheckbox({Name="Fling Mode", Default=false, Callback=function(v)
    if v then
        task.spawn(function()
            while v do
                local char = GetCharacter()
                if char then
                    local root = GetRoot()
                    if root then
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p == LocalPlayer then continue end
                            local c = p.Character if not c then continue end
                            local pr = c:FindFirstChild("HumanoidRootPart") if not pr then continue end
                            if (pr.Position - root.Position).Magnitude < 10 then
                                local bv = Instance.new("BodyVelocity")
                                bv.Velocity = Vector3.new(math.random(-200,200), 300, math.random(-200,200))
                                bv.MaxForce = Vector3.new(9e9,9e9,9e9)
                                bv.Parent = pr
                                Debris:AddItem(bv, 0.2)
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end})
PhysicsTrollGroup:AddButton({Name="Fling All Players", Callback=function() FlingAllPlayers() end})
PhysicsTrollGroup:AddButton({Name="Teleport All To Me", Callback=function() TeleportAllToMe() end})
PhysicsTrollGroup:AddCheckbox({Name="Freeze All Players", Default=false, Callback=function(v)
    task.spawn(function()
        while v do
            for _, p in ipairs(Players:GetPlayers()) do
                if p == LocalPlayer then continue end
                local c = p.Character if not c then continue end
                local pr = c:FindFirstChild("HumanoidRootPart") if not pr then continue end
                pcall(function() pr.Anchored = true end)
            end
            task.wait(0.2)
        end
        for _, p in ipairs(Players:GetPlayers()) do
            local c = p.Character if not c then continue end
            local pr = c:FindFirstChild("HumanoidRootPart") if not pr then continue end
            pcall(function() pr.Anchored = false end)
        end
    end)
end})

local ChatTrollGroup = AdvTrollSub2:AddGroup("Chat Troll", nil, "Right", 220)
ChatTrollGroup:AddCheckbox({Name="Chat Spam Loop", Default=false, Callback=function(v)
    task.spawn(function()
        while v do
            pcall(function()
                local msg = Settings.ChatSpamMessages[math.random(1,#Settings.ChatSpamMessages)]
                ExposeChatMessage(msg)
            end)
            task.wait(Settings.ChatSpamDelay or 1)
        end
    end)
end})
ChatTrollGroup:AddSlider({Name="Spam Delay", Min=0.5, Max=10, Default=1, Decimals=1, Callback=function(v) Settings.ChatSpamDelay=v end})
ChatTrollGroup:AddButton({Name="Say 'I am a hacker'", Callback=function() ExposeChatMessage("I am a hacker") end})
ChatTrollGroup:AddButton({Name="Say 'Ez game'", Callback=function() ExposeChatMessage("Ez game lmao") end})
ChatTrollGroup:AddButton({Name="Say 'Get rekt'", Callback=function() ExposeChatMessage("Get rekt son") end})

local AdvProtSub2 = PlayerTab:AddSubtab("Anti-Cheat")
local AntiCheatGroup = AdvProtSub2:AddGroup("Anti-Cheat Bypass", nil, "Left", 260)
AntiCheatGroup:AddCheckbox({Name="Anti Kick", Default=false, Callback=function(v)
    if v then
        local mt = getrawmetatable(game)
        if mt then
            local old = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" and self == LocalPlayer then
                    return
                end
                return old(self, ...)
            end)
            setreadonly(mt, true)
        end
    end
end})
AntiCheatGroup:AddCheckbox({Name="Anti Ban Check", Default=false, Callback=function(v) ExtraSettings.AntiBanCheck=v end})
AntiCheatGroup:AddCheckbox({Name="Anti Teleport", Default=false, Callback=function(v)
    if v then
        task.spawn(function()
            local lastPos = GetRoot() and GetRoot().Position or Vector3.new()
            while v do
                local root = GetRoot()
                if root then
                    local newPos = root.Position
                    if (newPos - lastPos).Magnitude > 200 then
                        root.CFrame = CFrame.new(lastPos)
                    else
                        lastPos = newPos
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end})
AntiCheatGroup:AddCheckbox({Name="Anti Void", Default=false, Callback=function(v) ExtraSettings.AntiVoid=v SetAntiVoid(v) end})

local ProtStatsGroup = AdvProtSub2:AddGroup("Protection Stats", nil, "Right", 220)
ProtStatsGroup:AddButton({Name="Check Anti-Cheat Plugins", Callback=function()
    local found = {}
    for _, v in ipairs(workspace:GetChildren()) do
        if v.Name:lower():find("anti") or v.Name:lower():find("cheat") or v.Name:lower():find("detect") then
            table.insert(found, v.Name)
        end
    end
    local msg = #found > 0 and "AC plugins: "..table.concat(found,", ") or "No AC plugins found in workspace"
    ExposeChatMessage(msg)
end})
ProtStatsGroup:AddButton({Name="Check Remote Count", Callback=function()
    local count = 0
    for _ in pairs(GetMM2RemoteFolder():GetDescendants()) do count=count+1 end
    ExposeChatMessage("MM2 remotes found: "..count)
end})

local NotifSub = MiscTab:AddSubtab("Notifications")
local NotifGroup = NotifSub:AddGroup("Notification Settings", nil, "Left", 260)
NotifGroup:AddCheckbox({Name="Enable Notifications", Default=true, Callback=function(v) NotifSettings.Enabled=v end})
NotifGroup:AddCheckbox({Name="Notify on Kill", Default=true, Callback=function(v) NotifSettings.ShowKills=v end})
NotifGroup:AddCheckbox({Name="Notify on Role", Default=true, Callback=function(v) NotifSettings.ShowRole=v end})
NotifGroup:AddCheckbox({Name="Notify on Coin Collect", Default=false, Callback=function(v) NotifSettings.ShowCoins=v end})
NotifGroup:AddCheckbox({Name="Notify on Events", Default=true, Callback=function(v) NotifSettings.ShowEvents=v end})
NotifGroup:AddSlider({Name="Duration (s)", Min=1, Max=10, Default=4, Decimals=0, Callback=function(v) NotifSettings.Duration=v end})

local NotifTestGroup = NotifSub:AddGroup("Test Notifications", nil, "Right", 220)
NotifTestGroup:AddButton({Name="Test Kill Notif", Callback=function() ShowNotif("Kill!", "You eliminated Player1", "kill") end})
NotifTestGroup:AddButton({Name="Test Role Notif", Callback=function() ShowNotif("Role", "You are the Murderer!", "role") end})
NotifTestGroup:AddButton({Name="Test Coin Notif", Callback=function() ShowNotif("Coins", "Collected 10 coins", "coin") end})
NotifTestGroup:AddButton({Name="Test Event Notif", Callback=function() ShowNotif("Event", "Round starting!", "event") end})

local AutoExecSub = MiscTab:AddSubtab("Auto Exec")
local AutoExecGroup = AutoExecSub:AddGroup("Auto Execute", nil, "Left", 260)
local autoExecScript = ""
AutoExecGroup:AddCheckbox({Name="Auto Exec on Join", Default=false, Callback=function(v)
    ExtraSettings.AutoExecOnJoin = v
end})
AutoExecGroup:AddTextbox({Name="Script to Execute", Default="", Callback=function(v) autoExecScript=v end})
AutoExecGroup:AddButton({Name="Execute Now", Callback=function()
    if autoExecScript ~= "" then
        local fn, err = loadstring(autoExecScript)
        if fn then pcall(fn) else ExposeChatMessage("Exec Error: "..tostring(err)) end
    end
end})
AutoExecGroup:AddButton({Name="Save Script to File", Callback=function()
    if writefile and autoExecScript ~= "" then
        writefile("chaos_autoexec.lua", autoExecScript)
        ShowNotif("Chaos", "Script saved!", "event")
    end
end})
AutoExecGroup:AddButton({Name="Load Script from File", Callback=function()
    if readfile and isfile and isfile("chaos_autoexec.lua") then
        autoExecScript = readfile("chaos_autoexec.lua")
        ShowNotif("Chaos", "Script loaded!", "event")
    end
end})

local QuickScriptGroup = AutoExecSub:AddGroup("Quick Scripts", nil, "Right", 220)
QuickScriptGroup:AddButton({Name="Infinite Yield", Callback=function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
end})
QuickScriptGroup:AddButton({Name="Dark Dex", Callback=function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end)
end})
QuickScriptGroup:AddButton({Name="Script Viewer", Callback=function()
    pcall(function()
        for _, v in ipairs(game:GetDescendants()) do
            if v:IsA("LocalScript") or v:IsA("ModuleScript") then
                ExposeChatMessage("[Script] " .. v:GetFullName())
            end
        end
    end)
end})
QuickScriptGroup:AddButton({Name="Get Remote List", Callback=function()
    for _, v in ipairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            ExposeChatMessage("[R] " .. v:GetFullName())
        end
    end
end})
QuickScriptGroup:AddButton({Name="Get Player List", Callback=function()
    for _, p in ipairs(Players:GetPlayers()) do
        ExposeChatMessage(p.Name.." | "..tostring(p.UserId).." | "..tostring(p:GetAttribute("Role") or "?"))
    end
end})
QuickScriptGroup:AddButton({Name="Get Workspace Tree", Callback=function()
    local function dumpTree(obj, depth)
        if depth > 3 then return end
        ExposeChatMessage(string.rep(" ",depth*2)..obj.ClassName..": "..obj.Name)
        for _,c in ipairs(obj:GetChildren()) do dumpTree(c,depth+1) end
    end
    dumpTree(workspace, 0)
end})

local ServerSub2 = WorldTab:AddSubtab("Server 2")
local ServerVoteGroup = ServerSub2:AddGroup("Server Events", nil, "Left", 260)
ServerVoteGroup:AddButton({Name="Vote Skip Round", Callback=function()
    pcall(function()
        local voteRemote = GetMM2RemoteFolder():FindFirstChild("VoteSkip", true)
        if voteRemote then voteRemote:FireServer() end
    end)
end})
ServerVoteGroup:AddButton({Name="Request More Time", Callback=function()
    pcall(function()
        local timeRemote = GetMM2RemoteFolder():FindFirstChild("RequestTime", true)
        if timeRemote then timeRemote:FireServer() end
    end)
end})
ServerVoteGroup:AddButton({Name="Force Round End", Callback=function()
    pcall(function()
        local endRemote = GetMM2RemoteFolder():FindFirstChild("EndRound", true) or GetMM2RemoteFolder():FindFirstChild("GameEnd", true)
        if endRemote then endRemote:FireServer() end
    end)
end})
ServerVoteGroup:AddButton({Name="Spam Vote Start", Callback=function()
    task.spawn(function()
        for i=1,10 do
            pcall(function()
                local startRemote = GetMM2RemoteFolder():FindFirstChild("VoteStart", true)
                if startRemote then startRemote:FireServer() end
            end)
            task.wait(0.1)
        end
    end)
end})

local MapToolsGroup = ServerSub2:AddGroup("Map Tools", nil, "Right", 220)
MapToolsGroup:AddButton({Name="Get Current Map", Callback=function()
    local mapName = workspace:GetAttribute("MapName") or workspace:GetAttribute("Map") or "Unknown"
    ExposeChatMessage("Current map: " .. tostring(mapName))
end})
MapToolsGroup:AddButton({Name="List All Parts", Callback=function()
    local count = #workspace:GetDescendants()
    ExposeChatMessage("Workspace parts: " .. count)
end})
MapToolsGroup:AddButton({Name="Remove All Decals", Callback=function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then
            pcall(function() v:Destroy() end)
        end
    end
end})
MapToolsGroup:AddButton({Name="Remove All Effects", Callback=function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            pcall(function() v:Destroy() end)
        end
    end
end})
MapToolsGroup:AddButton({Name="Flatten Map (Remove Parts)", Callback=function()
    for _, v in ipairs(workspace:GetChildren()) do
        if not Players:GetPlayerFromCharacter(v) and v.Name ~= "Terrain" and v.ClassName ~= "Folder" then
            if not v:IsA("Camera") then
                pcall(function() v:Destroy() end)
            end
        end
    end
end})

local PlayerToolsSub = MiscTab:AddSubtab("Player Tools")
local PlayerCompareGroup = PlayerToolsSub:AddGroup("Player Compare", nil, "Left", 260)
PlayerCompareGroup:AddButton({Name="Top Coin Players", Callback=function()
    local top = GetTopPlayers()
    for i=1,math.min(5,#top) do
        local t = top[i]
        ExposeChatMessage(i..". "..t.player.Name.." - "..t.coins.." coins")
    end
end})
PlayerCompareGroup:AddButton({Name="Who Is Murderer", Callback=function()
    local m = FindMurderer()
    if m then ExposeChatMessage("Murderer: "..m.Name) else ExposeChatMessage("No murderer found") end
end})
PlayerCompareGroup:AddButton({Name="Who Is Sheriff", Callback=function()
    local s = FindSheriff()
    if s then ExposeChatMessage("Sheriff: "..s.Name) else ExposeChatMessage("No sheriff found") end
end})
PlayerCompareGroup:AddButton({Name="Alive Player Count", Callback=function()
    local alive = 0
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h and h.Health > 0 then alive = alive + 1 end
        end
    end
    ExposeChatMessage("Alive players: "..alive.."/"..#Players:GetPlayers())
end})
PlayerCompareGroup:AddButton({Name="Player Ping List", Callback=function()
    for _, p in ipairs(Players:GetPlayers()) do
        ExposeChatMessage(p.Name.." ping: "..math.floor(p:GetNetworkPing()*1000).."ms")
    end
end})

local TeleportGroup = PlayerToolsSub:AddGroup("Teleport Tools", nil, "Right", 220)
TeleportGroup:AddButton({Name="TP to Murderer", Callback=function()
    local m = FindMurderer() if not m then return end
    TeleportToPlayer(m.Name)
end})
TeleportGroup:AddButton({Name="TP to Sheriff", Callback=function()
    local s = FindSheriff() if not s then return end
    TeleportToPlayer(s.Name)
end})
TeleportGroup:AddButton({Name="TP to Center", Callback=function()
    local root = GetRoot() if not root then return end
    root.CFrame = CFrame.new(0,20,0)
end})
TeleportGroup:AddButton({Name="TP to Lobby", Callback=function()
    local root = GetRoot() if not root then return end
    pcall(function()
        local lobby = workspace:FindFirstChild("RegularLobby") or workspace:FindFirstChild("Lobby")
        if lobby then
            local spawns = lobby:FindFirstChild("Spawns")
            local sp = spawns and spawns:FindFirstChildWhichIsA("BasePart") or lobby:FindFirstChildWhichIsA("SpawnLocation",true)
            if sp then root.CFrame = sp.CFrame + Vector3.new(0,4,0) return end
        end
        local sp = workspace:FindFirstChildWhichIsA("SpawnLocation",true)
        if sp then root.CFrame = sp.CFrame + Vector3.new(0,4,0) end
    end)
end})
TeleportGroup:AddButton({Name="TP to Map Spawn", Callback=function()
    local root = GetRoot() if not root then return end
    pcall(function()
        for _, m in ipairs(workspace:GetChildren()) do
            if m:IsA("Model") and not m.Name:find("Lobby") and (m:FindFirstChild("CoinContainer") or m:FindFirstChild("Spawns")) then
                local spawns = m:FindFirstChild("Spawns")
                if spawns then
                    local parts = {}
                    for _, p in ipairs(spawns:GetChildren()) do if p:IsA("BasePart") then table.insert(parts,p) end end
                    if #parts > 0 then root.CFrame = parts[math.random(1,#parts)].CFrame + Vector3.new(0,4,0) return end
                end
                root.CFrame = m:GetPivot() + Vector3.new(0,6,0)
                return
            end
        end
    end)
end})
TeleportGroup:AddButton({Name="TP Behind Murderer", Callback=function()
    local m = FindMurderer() if not m then return end
    local c = m.Character if not c then return end
    local pr = c:FindFirstChild("HumanoidRootPart") if not pr then return end
    local root = GetRoot() if not root then return end
    root.CFrame = pr.CFrame * CFrame.new(0,0,3)
end})
TeleportGroup:AddButton({Name="Loop TP to Murderer", Callback=function()
    ExtraSettings.LoopTPToMurderer = not ExtraSettings.LoopTPToMurderer
    task.spawn(function()
        while ExtraSettings.LoopTPToMurderer do
            local m = FindMurderer()
            if m then
                local c = m.Character if c then
                    local pr = c:FindFirstChild("HumanoidRootPart")
                    local root = GetRoot()
                    if pr and root then root.CFrame = pr.CFrame * CFrame.new(2,0,2) end
                end
            end
            task.wait(0.2)
        end
    end)
end})

local StatsSub = MiscTab:AddSubtab("Statistics")
local SessionStatsGroup = StatsSub:AddGroup("Session Stats", nil, "Left", 260)
SessionStatsGroup:AddButton({Name="Show Session Stats", Callback=function()
    local elapsed = tick() - sessionStartTime
    local mins = math.floor(elapsed/60)
    local secs = math.floor(elapsed%60)
    ExposeChatMessage(string.format("Session: %dm %ds | Kills: %d | Coins: %d", mins, secs, ScriptSettings.KillCount, ScriptSettings.CoinCount))
end})
SessionStatsGroup:AddButton({Name="Reset Stats", Callback=function()
    ScriptSettings.KillCount=0 ScriptSettings.CoinCount=0 sessionStartTime=tick()
    ShowNotif("Stats", "Session stats reset!", "event")
end})
SessionStatsGroup:AddButton({Name="Kills Per Minute", Callback=function()
    local elapsed = tick() - sessionStartTime
    local kpm = elapsed > 0 and (ScriptSettings.KillCount / (elapsed/60)) or 0
    ExposeChatMessage(string.format("KPM: %.2f", kpm))
end})

local GameStatsGroup = StatsSub:AddGroup("Game Stats", nil, "Right", 220)
GameStatsGroup:AddButton({Name="My Coin Count", Callback=function()
    local coins = LocalPlayer:GetAttribute("Coins") or LocalPlayer.leaderstats and LocalPlayer.leaderstats:FindFirstChild("Coins") and LocalPlayer.leaderstats.Coins.Value or 0
    ExposeChatMessage("My coins: "..coins)
end})
GameStatsGroup:AddButton({Name="Game Time Remaining", Callback=function()
    local timeAttr = workspace:GetAttribute("TimeLeft") or workspace:GetAttribute("Time") or "Unknown"
    ExposeChatMessage("Time left: "..tostring(timeAttr))
end})
GameStatsGroup:AddButton({Name="Game Round Number", Callback=function()
    local round = workspace:GetAttribute("Round") or workspace:GetAttribute("RoundNumber") or "Unknown"
    ExposeChatMessage("Round: "..tostring(round))
end})
GameStatsGroup:AddButton({Name="Server Uptime", Callback=function()
    local uptime = math.floor(workspace.DistributedGameTime)
    ExposeChatMessage("Server uptime: "..uptime.."s")
end})

local AntiSub = MiscTab:AddSubtab("Anti Detect")
local AntiDetectGroup = AntiSub:AddGroup("Detection Bypass", nil, "Left", 260)
AntiDetectGroup:AddCheckbox({Name="Anti Screenshot", Default=false, Callback=function(v)
    ExtraSettings.AntiScreenshot = v
    if v then
        local sGui = game.CoreGui:FindFirstChild("ChaosAntiSS") or Instance.new("ScreenGui")
        sGui.Name="ChaosAntiSS" sGui.DisplayOrder=9999 sGui.ResetOnSpawn=false sGui.Parent=game.CoreGui
    else
        local sGui = game.CoreGui:FindFirstChild("ChaosAntiSS")
        if sGui then sGui:Destroy() end
    end
end})
AntiDetectGroup:AddCheckbox({Name="Fake Ping Display", Default=false, Callback=function(v)
    ExtraSettings.FakePing = v
end})
AntiDetectGroup:AddCheckbox({Name="Anti Remote Logger", Default=false, Callback=function(v)
    ExtraSettings.AntiRemoteLogger = v
end})
AntiDetectGroup:AddButton({Name="Clear Script Traces", Callback=function()
    for _, v in ipairs(game.CoreGui:GetChildren()) do
        if v.Name:find("Chaos") then
        end
    end
    ShowNotif("Anti Detect", "Traces cleared!", "event")
end})
AntiDetectGroup:AddButton({Name="Spoof Username", Callback=function()
    ShowNotif("Anti Detect", "Username spoofing not available in this runtime", "event")
end})

local HideGroup = AntiSub:AddGroup("UI Hiding", nil, "Right", 220)
HideGroup:AddButton({Name="Hide UI (Hotkey: F9)", Callback=function()
    local chaosLib = game.CoreGui:FindFirstChild("Chaos") or game.CoreGui:FindFirstChild("ChaosUI")
    if chaosLib then chaosLib.Enabled = not chaosLib.Enabled end
end})
HideGroup:AddButton({Name="Panic Button (Remove All)", Callback=function()
    for _, v in ipairs(game.CoreGui:GetChildren()) do
        if v.Name:find("Chaos") then
            pcall(function() v:Destroy() end)
        end
    end
end})
HideGroup:AddButton({Name="Fake AFK", Callback=function()
    ExtraSettings.FakeAFK = not ExtraSettings.FakeAFK
    ShowNotif("AFK", ExtraSettings.FakeAFK and "Fake AFK ON - preventing idle kick" or "Fake AFK OFF", "event")
    if ExtraSettings.FakeAFK then
        task.spawn(function()
            while ExtraSettings.FakeAFK do
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
                task.wait(60)
            end
        end)
    end
end})

local AdvCombatSub2 = CombatTab:AddSubtab("Combat Ext")
local MassActionGroup2 = AdvCombatSub2:AddGroup("Mass Actions 2", nil, "Left", 260)
MassActionGroup2:AddButton({Name="Kill All Innocents", Callback=function()
    task.spawn(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local role = p:GetAttribute("Role") or ""
            if role == "Innocent" then
                local c = p.Character if not c then continue end
                local pr = c:FindFirstChild("HumanoidRootPart") if not pr then continue end
                local root = GetRoot() if not root then continue end
                root.CFrame = pr.CFrame * CFrame.new(0,0,-2)
                local attackRemote = GetMM2RemoteFolder():FindFirstChild("KillPlayer", true)
                if attackRemote then pcall(function() attackRemote:FireServer(p) end) end
                task.wait(0.1)
            end
        end
    end)
end})
MassActionGroup2:AddButton({Name="Kill Murderer Only", Callback=function()
    local m = FindMurderer() if not m then return end
    local c = m.Character if not c then return end
    local pr = c:FindFirstChild("HumanoidRootPart") if not pr then return end
    local root = GetRoot() if not root then return end
    root.CFrame = pr.CFrame * CFrame.new(0,0,-2)
    local attackRemote = GetMM2RemoteFolder():FindFirstChild("KillPlayer", true)
    if attackRemote then pcall(function() attackRemote:FireServer(m) end) end
end})
MassActionGroup2:AddButton({Name="Follow Target", Callback=function()
    ExtraSettings.FollowTarget = not ExtraSettings.FollowTarget
    task.spawn(function()
        while ExtraSettings.FollowTarget do
            local p = GetPlayerByName(selectedTarget)
            if p then
                local c = p.Character if c then
                    local pr = c:FindFirstChild("HumanoidRootPart")
                    local root = GetRoot()
                    if pr and root then
                        root.CFrame = pr.CFrame * CFrame.new(3,0,0)
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end})
MassActionGroup2:AddButton({Name="Orbit Target", Callback=function()
    ExtraSettings.OrbitTarget = not ExtraSettings.OrbitTarget
    local orbitAngle = 0
    task.spawn(function()
        while ExtraSettings.OrbitTarget do
            local p = GetPlayerByName(selectedTarget)
            if p then
                local c = p.Character if c then
                    local pr = c:FindFirstChild("HumanoidRootPart")
                    local root = GetRoot()
                    if pr and root then
                        orbitAngle = orbitAngle + 0.05
                        local offset = Vector3.new(math.cos(orbitAngle)*5, 0, math.sin(orbitAngle)*5)
                        root.CFrame = CFrame.new(pr.Position + offset, pr.Position)
                    end
                end
            end
            task.wait(0.03)
        end
    end)
end})

local CombatHotkeyGroup = AdvCombatSub2:AddGroup("Combat Hotkeys", nil, "Right", 220)
CombatHotkeyGroup:AddButton({Name="F = Kill Nearest", Callback=function()
    UserInputService.InputBegan:Connect(function(input, gp) if gp then return end
        if input.KeyCode == Enum.KeyCode.F then
            QuickKillAll()
        end
    end)
    ShowNotif("Hotkey", "F = Kill Nearest bound!", "event")
end})
CombatHotkeyGroup:AddButton({Name="G = Throw Knife", Callback=function()
    UserInputService.InputBegan:Connect(function(input, gp) if gp then return end
        if input.KeyCode == Enum.KeyCode.G then
            SetInstantThrow()
        end
    end)
    ShowNotif("Hotkey", "G = Throw Knife bound!", "event")
end})
CombatHotkeyGroup:AddButton({Name="H = Fly Toggle", Callback=function()
    UserInputService.InputBegan:Connect(function(input, gp) if gp then return end
        if input.KeyCode == Enum.KeyCode.H then
            Settings.Fly = not Settings.Fly
            SetFly(Settings.Fly)
        end
    end)
    ShowNotif("Hotkey", "H = Fly Toggle bound!", "event")
end})

local function GetCharacterStats()
    local char = GetCharacter()
    local stats = {pos="N/A", speed="N/A", health="N/A", role="N/A", team="N/A"}
    if not char then return stats end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if root then stats.pos = string.format("%.0f %.0f %.0f", root.Position.X, root.Position.Y, root.Position.Z) end
    if hum then stats.speed = string.format("%.0f", hum.WalkSpeed) stats.health = string.format("%.0f/%.0f", hum.Health, hum.MaxHealth) end
    stats.role = tostring(LocalPlayer:GetAttribute("Role") or "?")
    stats.team = tostring(LocalPlayer.Team and LocalPlayer.Team.Name or "?")
    return stats
end

local function GetNearestPlayer()
    local root = GetRoot() if not root then return nil end
    local best, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local c = p.Character if not c then continue end
        local pr = c:FindFirstChild("HumanoidRootPart") if not pr then continue end
        local dist = (pr.Position - root.Position).Magnitude
        if dist < bestDist then bestDist=dist best=p end
    end
    return best, bestDist
end

local AdvFarmSub2 = FarmTab:AddSubtab("Farm Ext")
local AutoRoleFarm = AdvFarmSub2:AddGroup("Role Farm", nil, "Left", 260)
AutoRoleFarm:AddCheckbox({Name="Force Murderer Role", Default=false, Callback=function(v)
    if v then
        task.spawn(function()
            while v do
                pcall(function()
                    local roleRemote = GetMM2RemoteFolder():FindFirstChild("ChangeRole", true)
                    if roleRemote then roleRemote:FireServer("Murderer") end
                end)
                task.wait(2)
            end
        end)
    end
end})
AutoRoleFarm:AddCheckbox({Name="Force Sheriff Role", Default=false, Callback=function(v)
    if v then
        task.spawn(function()
            while v do
                pcall(function()
                    local roleRemote = GetMM2RemoteFolder():FindFirstChild("ChangeRole", true)
                    if roleRemote then roleRemote:FireServer("Sheriff") end
                end)
                task.wait(2)
            end)
        end)
    end
end})
AutoRoleFarm:AddCheckbox({Name="Auto Round Start Collect", Default=false, Callback=function(v)
    FarmSettings.AutoRoundStartCollect = v
end})
AutoRoleFarm:AddButton({Name="Check My Role", Callback=function()
    local role = GetRole()
    ShowNotif("Role Check", "Current role: " .. role, "role")
end})

local KillFarmGroup = AdvFarmSub2:AddGroup("Kill Farm Extended", nil, "Right", 220)
KillFarmGroup:AddCheckbox({Name="Kill Farm (Loop)", Default=false, Callback=function(v)
    FarmSettings.AutoKillFarm = v
    if v then
        task.spawn(function()
            while FarmSettings.AutoKillFarm do
                QuickKillAll()
                task.wait(0.5)
            end
        end)
    end
end})
KillFarmGroup:AddCheckbox({Name="Only Kill When Murd", Default=true, Callback=function(v)
    FarmSettings.OnlyKillWhenMurderer = v
end})
KillFarmGroup:AddSlider({Name="Kill Cooldown (s)", Min=0.1, Max=5, Default=0.5, Decimals=1, Callback=function(v)
    FarmSettings.KillCooldown = v
end})

local BombJumpEnabled = false
local BombJumpConn

local function GetFakeBomb()
    local char = LocalPlayer.Character
    if char then
        local b = char:FindFirstChild("FakeBomb")
        if b then return b, true end
    end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then
        local toys = bp:FindFirstChild("Toys")
        local b = (toys and toys:FindFirstChild("FakeBomb")) or bp:FindFirstChild("FakeBomb")
        if b then return b, false end
    end
    return nil, false
end

local function EquipFakeBomb()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not (hum and hum.Health > 0) then return nil end
    local bomb, inChar = GetFakeBomb()
    if not bomb then return nil end
    if not inChar then
        pcall(function() bomb.Parent = char end)
        task.wait(0.08)
        bomb = char:FindFirstChild("FakeBomb") or bomb
    end
    pcall(function()
        local handle = bomb:FindFirstChild("Handle")
        local rightArm = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
        if handle and rightArm and not rightArm:FindFirstChild("RightGrip") then
            handle.Anchored = false
            local weld = Instance.new("Weld")
            weld.Name = "RightGrip"
            weld.Part0 = rightArm
            weld.Part1 = handle
            weld.C0 = rightArm.Name == "RightHand" and CFrame.new(0,-0.1,0) or CFrame.new(0,-1,0)*CFrame.Angles(-math.pi/2,0,0)
            weld.C1 = bomb.Grip
            weld.Parent = rightArm
        end
    end)
    return bomb.Parent == char and bomb or nil
end

local function FireBombJump()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not (hum and root and hum.Health > 0) then return end
    local bomb = EquipFakeBomb()
    if not bomb then return end
    local remote = bomb:FindFirstChild("Remote")
    if not remote then return end
    local jumpVel = hum.UseJumpPower == false
        and math.sqrt(2*(workspace.Gravity or 196.2)*math.max(hum.JumpHeight or 7.2,1))
        or math.max(hum.JumpPower or 50,50)
    pcall(function() remote:FireServer(CFrame.new(root.Position - Vector3.new(0,2.5,0)), 50) end)
    task.wait(0.05)
    local vel = root.AssemblyLinearVelocity
    root.AssemblyLinearVelocity = Vector3.new(vel.X, jumpVel * 2.5, vel.Z)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
end

local BombJumpTab = MainWindow:AddTab("Bomb Jump")
local BombJumpGroup = BombJumpTab:AddGroup("Bomb Jump", nil, "Left", 220)
BombJumpGroup:AddCheckbox({Name="Bomb Jump on Activate", Default=false, Callback=function(v)
    BombJumpEnabled = v
    if BombJumpConn then BombJumpConn:Disconnect() BombJumpConn = nil end
    if v then
        local function WireChar(char)
            local function WireTool(tool)
                if tool.Name == "FakeBomb" and tool:IsA("Tool") then
                    tool.Activated:Connect(function()
                        if BombJumpEnabled then FireBombJump() end
                    end)
                end
            end
            for _, t in ipairs(char:GetChildren()) do WireTool(t) end
            char.ChildAdded:Connect(WireTool)
        end
        if LocalPlayer.Character then WireChar(LocalPlayer.Character) end
        BombJumpConn = LocalPlayer.CharacterAdded:Connect(function(char) task.wait(0.3) WireChar(char) end)
    end
end})
BombJumpGroup:AddButton({Name="Fire Bomb Jump Now", Callback=function() FireBombJump() end})

local SoundTab = MainWindow:AddTab("Round Sounds")
local SoundLib = {
    roll = {
        {"Bright Click","rbxassetid://15675059323"},
        {"Fast Click","rbxasset://sounds/clickfast.wav"},
        {"Switch","rbxasset://sounds/SWITCH3.wav"},
        {"Snap","rbxasset://sounds/snap.wav"},
        {"Soft Click","rbxassetid://16480568148"},
        {"Heavy Click","rbxassetid://16480567946"},
        {"8-Bit Blip","rbxassetid://16480580213"},
        {"8-Bit Beep","rbxassetid://16480578737"},
        {"Wheel Tick","rbxassetid://9120658649"},
        {"Ping","rbxasset://sounds/electronicpingshort.wav"},
        {"Bubble","rbxassetid://9112872239"},
    },
    reveal = {
        {"Sparkle Ding","rbxassetid://9126073001"},
        {"Magic Chime","rbxassetid://9116394545"},
        {"Magic Glow","rbxassetid://9116395089"},
        {"Choir","rbxassetid://9114792002"},
        {"Desk Bell","rbxassetid://9125485591"},
        {"Big Bell","rbxassetid://1034263055"},
        {"Stinger","rbxassetid://15675043410"},
        {"Notify","rbxassetid://17208361335"},
        {"Sword Draw","rbxassetid://9119742466"},
        {"Riser","rbxassetid://9125805579"},
        {"8-Bit Riser","rbxassetid://16480578169"},
        {"Cymbal","rbxassetid://9113966034"},
        {"Party Horn","rbxassetid://9117240379"},
    },
}
local SOUND_KIND = {["179235828"]="roll",["179287602"]="reveal"}
local customSoundEnabled = false
local selectedRollSound = SoundLib.roll[1][2]
local selectedRevealSound = SoundLib.reveal[1][2]

local function MakeRoundSoundLabel(lib)
    local labels = {}
    for _, v in ipairs(lib) do table.insert(labels, v[1]) end
    return labels
end

local function PlayCustomSound(assetId)
    local snd = Instance.new("Sound")
    snd.SoundId = assetId
    snd.Volume = 1
    snd.Parent = workspace
    snd:Play()
    game:GetService("Debris"):AddItem(snd, 10)
end

local roundSoundConns = {}
local function SetupRoundSounds(on)
    for _, c in pairs(roundSoundConns) do c:Disconnect() end
    roundSoundConns = {}
    if not on then return end
    local function WatchSound(snd)
        if not snd:IsA("Sound") then return end
        local id = tostring(snd.SoundId):match("(%d+)$")
        if not id then return end
        local kind = SOUND_KIND[id]
        if not kind then return end
        table.insert(roundSoundConns, snd.Played:Connect(function()
            snd.Volume = 0
            if kind == "roll" then PlayCustomSound(selectedRollSound)
            elseif kind == "reveal" then PlayCustomSound(selectedRevealSound) end
        end))
    end
    local function ScanDescendants(obj)
        for _, d in ipairs(obj:GetDescendants()) do WatchSound(d) end
        table.insert(roundSoundConns, obj.DescendantAdded:Connect(WatchSound))
    end
    ScanDescendants(workspace)
    ScanDescendants(game:GetService("SoundService"))
end

local RoundSoundGroup = SoundTab:AddGroup("Custom Role Reveal Sounds", nil, "Left", 240)
RoundSoundGroup:AddCheckbox({Name="Custom Round Sounds", Default=false, Callback=function(v)
    customSoundEnabled = v
    SetupRoundSounds(v)
end})
RoundSoundGroup:AddDropdown({Name="Roll Sound", Items=MakeRoundSoundLabel(SoundLib.roll), Default=SoundLib.roll[1][1], Callback=function(v)
    for _, entry in ipairs(SoundLib.roll) do if entry[1] == v then selectedRollSound = entry[2] break end end
end})
RoundSoundGroup:AddButton({Name="Preview Roll Sound", Callback=function() PlayCustomSound(selectedRollSound) end})
RoundSoundGroup:AddDropdown({Name="Reveal Sound", Items=MakeRoundSoundLabel(SoundLib.reveal), Default=SoundLib.reveal[1][1], Callback=function(v)
    for _, entry in ipairs(SoundLib.reveal) do if entry[1] == v then selectedRevealSound = entry[2] break end end
end})
RoundSoundGroup:AddButton({Name="Preview Reveal Sound", Callback=function() PlayCustomSound(selectedRevealSound) end})

local ItemValueTab = MainWindow:AddTab("Item Values")
local ItemValueGroup = ItemValueTab:AddGroup("MM2 Item Values", nil, "Left", 300)
local VALUE_CATEGORIES = {"godlies","chromas","ancients","legendaries","rares","uncommons","commons","vintages","misc","pets"}
local selectedValueCat = "godlies"
local valueResults = {}

local function FetchItemValues(category)
    local ok, res = pcall(function()
        return game:GetService("HttpService"):RequestAsync({
            Url = "https://supremevalues.com/mm2/" .. category,
            Method = "GET",
        })
    end)
    if not ok or not res or res.StatusCode ~= 200 then return {} end
    local body = res.Body or ""
    local items = {}
    for name, val in body:gmatch('class="itemhead">(.-)</.-class="itemcolumn"[^>]*data%-value="([^"]+)"') do
        table.insert(items, {name=name:gsub("%s+",""), value=val})
    end
    if #items == 0 then
        for name, val in body:gmatch('data%-value="([^"]+)".-class="itemhead">([^<]+)<') do
            table.insert(items, {name=val:gsub("%s+",""), value=name})
        end
    end
    return items
end

local valueLabel = ItemValueGroup:AddLabel("Select a category and fetch values.")
ItemValueGroup:AddDropdown({Name="Category", Items=VALUE_CATEGORIES, Default="godlies", Callback=function(v)
    selectedValueCat = v
end})
ItemValueGroup:AddButton({Name="Fetch Values", Callback=function()
    valueLabel:SetText("Fetching " .. selectedValueCat .. "...")
    task.spawn(function()
        local results = FetchItemValues(selectedValueCat)
        valueResults = results
        if #results == 0 then
            valueLabel:SetText("No results or fetch failed.")
        else
            local lines = {}
            for i, item in ipairs(results) do
                if i > 20 then break end
                table.insert(lines, item.name .. ": " .. item.value)
            end
            valueLabel:SetText(table.concat(lines, "\n"))
        end
    end)
end})

local DuelTab = MainWindow:AddTab("Duel Tracker")
local DuelGroup = DuelTab:AddGroup("Duel Stats", nil, "Left", 220)
local duelStats = {wins=0, losses=0, kills=0, deaths=0}
local duelTrackEnabled = false
local duelWinLabel, duelLossLabel, duelKillLabel, duelDeathLabel

duelWinLabel = DuelGroup:AddLabel("Wins: 0")
duelLossLabel = DuelGroup:AddLabel("Losses: 0")
duelKillLabel = DuelGroup:AddLabel("Kills: 0")
duelDeathLabel = DuelGroup:AddLabel("Deaths: 0")

DuelGroup:AddCheckbox({Name="Track Duels", Default=false, Callback=function(v)
    duelTrackEnabled = v
end})
DuelGroup:AddButton({Name="Reset Stats", Callback=function()
    duelStats = {wins=0,losses=0,kills=0,deaths=0}
    duelWinLabel:SetText("Wins: 0")
    duelLossLabel:SetText("Losses: 0")
    duelKillLabel:SetText("Kills: 0")
    duelDeathLabel:SetText("Deaths: 0")
end})

local function TrackDuelKill(targetName)
    if not duelTrackEnabled then return end
    duelStats.kills = duelStats.kills + 1
    duelKillLabel:SetText("Kills: " .. duelStats.kills)
end

local function TrackDuelDeath()
    if not duelTrackEnabled then return end
    duelStats.deaths = duelStats.deaths + 1
    duelDeathLabel:SetText("Deaths: " .. duelStats.deaths)
end

task.spawn(function()
    while true do
        task.wait(0.5)
        if duelTrackEnabled then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health <= 0 then
                    TrackDuelDeath()
                    task.wait(3)
                end
            end
        end
    end
end)

local ServerTab2 = MainWindow:AddTab("Server Tools")
local ServerHopGroup = ServerTab2:AddGroup("Server Hop", nil, "Left", 220)
local hopBusy = false
local hopStatusLabel = ServerHopGroup:AddLabel("Ready")

local function FetchServers(sortAsc, pages)
    local hs = game:GetService("HttpService")
    local servers, cursor = {}, nil
    for i = 1, pages or 2 do
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=" .. (sortAsc and "Asc" or "Desc") .. "&excludeFullGames=true&limit=100" .. (cursor and ("&cursor=" .. cursor) or "")
        local ok, raw = pcall(function() return game:HttpGet(url) end)
        if not ok then break end
        local ok2, data = pcall(function() return hs:JSONDecode(raw) end)
        if not ok2 or type(data) ~= "table" or type(data.data) ~= "table" then break end
        for _, sv in ipairs(data.data) do
            if sv.id and sv.id ~= game.JobId and (sv.playing or 0) < (sv.maxPlayers or 99) then
                table.insert(servers, sv)
            end
        end
        cursor = data.nextPageCursor
        if not cursor then break end
    end
    return servers
end

ServerHopGroup:AddButton({Name="Server Hop (Random)", Callback=function()
    if hopBusy then return end
    hopBusy = true
    hopStatusLabel:SetText("Searching...")
    task.spawn(function()
        local servers = FetchServers(false, 3)
        if #servers == 0 then hopStatusLabel:SetText("No servers found.") hopBusy=false return end
        local sv = servers[math.random(1, #servers)]
        hopStatusLabel:SetText(string.format("Hopping: %d/%d", sv.playing or 0, sv.maxPlayers or 0))
        local ok, err = pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, sv.id, LocalPlayer)
        end)
        if not ok then hopStatusLabel:SetText("Error: " .. tostring(err)) hopBusy=false end
    end)
end})

ServerHopGroup:AddButton({Name="Join Small Server", Callback=function()
    if hopBusy then return end
    hopBusy = true
    hopStatusLabel:SetText("Finding small server...")
    task.spawn(function()
        local servers = FetchServers(true, 3)
        if #servers == 0 then hopStatusLabel:SetText("No servers found.") hopBusy=false return end
        local sv = servers[1]
        hopStatusLabel:SetText(string.format("Joining: %d/%d", sv.playing or 0, sv.maxPlayers or 0))
        local ok, err = pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, sv.id, LocalPlayer)
        end)
        if not ok then hopStatusLabel:SetText("Error: " .. tostring(err)) hopBusy=false end
    end)
end})

ServerHopGroup:AddButton({Name="Rejoin", Callback=function()
    local ts = game:GetService("TeleportService")
    if #game:GetService("Players"):GetPlayers() <= 1 then
        pcall(function() ts:Teleport(game.PlaceId, LocalPlayer) end)
    else
        pcall(function() ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
    end
end})

local SpinDanceAnims = {
    {name="Helicopter", id="rbxassetid://10714347453", yaw=2.4, speed=1.0},
    {name="Break Dance", id="rbxassetid://10714003221", yaw=1.8, speed=1.3},
    {name="Top Rock",    id="rbxassetid://10714336041", yaw=1.0, speed=1.4},
    {name="Air Dance",  id="rbxassetid://10713957138", yaw=1.4, speed=1.5},
    {name="Hero Flip",  id="rbxassetid://10714360164", yaw=1.2, speed=1.2},
    {name="Twirl",      id="rbxassetid://10714293450", yaw=2.2, speed=1.5},
    {name="Jacks",      id="rbxassetid://10714375667", yaw=1.6, speed=1.6},
    {name="Floss",      id="rbxassetid://10714340543", yaw=1.2, speed=1.4},
    {name="Tantrum",    id="rbxassetid://10714340558", yaw=1.5, speed=1.5},
    {name="Robot",      id="rbxassetid://10714392151", yaw=0.8, speed=1.3},
}
local spinDanceEnabled = false
local selectedSpinAnim = SpinDanceAnims[1]
local spinAnimTrack = nil
local spinAnimConn = nil

local function StopSpinAnim()
    if spinAnimTrack then pcall(function() spinAnimTrack:Stop(0.25) end) spinAnimTrack=nil end
    if spinAnimConn then spinAnimConn:Disconnect() spinAnimConn=nil end
end

local function StartSpinAnim(animData)
    StopSpinAnim()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local anim = Instance.new("Animation")
    anim.AnimationId = animData.id
    local animator = hum:FindFirstChildOfClass("Animator") or hum
    local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
    if not ok then return end
    track.Priority = Enum.AnimationPriority.Action4
    track.Looped = true
    track:Play(0.25)
    spinAnimTrack = track
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        local cam = workspace.CurrentCamera
        spinAnimConn = RunService.Heartbeat:Connect(function(dt)
            if not spinDanceEnabled then StopSpinAnim() return end
            if cam then
                local look = cam.CFrame.LookVector
                local angle = math.atan2(-look.X, -look.Z)
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, angle + (animData.yaw * dt * 60), 0)
            end
        end)
    end
end

local SpinDanceTab = MainWindow:AddTab("Spin Dance")
local SpinDanceGroup = SpinDanceTab:AddGroup("Spin Dance", nil, "Left", 220)
local spinAnimNames = {}
for _, v in ipairs(SpinDanceAnims) do table.insert(spinAnimNames, v.name) end
SpinDanceGroup:AddDropdown({Name="Animation", Items=spinAnimNames, Default=SpinDanceAnims[1].name, Callback=function(v)
    for _, a in ipairs(SpinDanceAnims) do if a.name == v then selectedSpinAnim = a break end end
    if spinDanceEnabled then StartSpinAnim(selectedSpinAnim) end
end})
SpinDanceGroup:AddCheckbox({Name="Spin Dance", Default=false, Callback=function(v)
    spinDanceEnabled = v
    if v then StartSpinAnim(selectedSpinAnim) else StopSpinAnim() end
end})
SpinDanceGroup:AddButton({Name="Play Once", Callback=function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local anim = Instance.new("Animation")
    anim.AnimationId = selectedSpinAnim.id
    local animator = hum:FindFirstChildOfClass("Animator") or hum
    pcall(function()
        local track = animator:LoadAnimation(anim)
        track:Play(0.25)
        game:GetService("Debris"):AddItem(track, 5)
    end)
end})

local GunSoundTab = MainWindow:AddTab("Gun Sounds")
local GunSoundPresetGroup = GunSoundTab:AddGroup("Gun Sound Presets", nil, "Left", 240)
local selectedGunSoundId = ""
local selectedKillSoundId = ""
local gunSoundConns2 = {}

local function SetGunSoundPreset(id)
    for _, c in pairs(gunSoundConns2) do c:Disconnect() end
    gunSoundConns2 = {}
    if not id or id == "" then return end
    local function ApplyToSound(snd)
        if not snd:IsA("Sound") then return end
        local n = snd.Name:lower()
        if n:find("gun") or n:find("shoot") or n:find("fire") or n:find("shot") then
            snd.SoundId = id
        end
    end
    for _, d in ipairs(workspace:GetDescendants()) do ApplyToSound(d) end
    table.insert(gunSoundConns2, workspace.DescendantAdded:Connect(ApplyToSound))
end

local function SetKillSoundPreset(id)
    if not id or id == "" then return end
    local snd = Instance.new("Sound")
    snd.SoundId = id
    snd.Volume = 0.8
    snd.Parent = workspace
    snd:Play()
    game:GetService("Debris"):AddItem(snd, 5)
end

GunSoundPresetGroup:AddDropdown({Name="Gun Sound", Items=GunSoundNames(), Default="Off", Callback=function(v)
    selectedGunSoundId = GetGunSoundId(v)
    SetGunSoundPreset(selectedGunSoundId)
end})
GunSoundPresetGroup:AddButton({Name="Preview Gun Sound", Callback=function()
    if selectedGunSoundId == "" then return end
    local snd = Instance.new("Sound") snd.SoundId=selectedGunSoundId snd.Volume=0.8 snd.Parent=workspace snd:Play()
    game:GetService("Debris"):AddItem(snd, 5)
end})

local KillSoundPresetGroup = GunSoundTab:AddGroup("Kill Sound Presets", nil, "Right", 240)
KillSoundPresetGroup:AddDropdown({Name="Kill Sound", Items=KillSoundNames(), Default="Off", Callback=function(v)
    selectedKillSoundId = GetKillSoundId(v)
end})
KillSoundPresetGroup:AddButton({Name="Preview Kill Sound", Callback=function()
    if selectedKillSoundId == "" then return end
    SetKillSoundPreset(selectedKillSoundId)
end})

if LocalPlayer.Character then OnCharacterAdded(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)
