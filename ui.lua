local Icons = {
    crosshairs = "rbxassetid://96677288280405",
    ghost      = "rbxassetid://95400397758754",
    mouse      = "rbxassetid://74350468513068",
    user       = "rbxassetid://97066657594742",
    pallet     = "rbxassetid://83365140694071",
    hammer     = "rbxassetid://118512898552101",
    code       = "rbxassetid://100793810819046",
    save       = "rbxassetid://136566823798983",
    feather    = "rbxassetid://130188814728078",
    crown      = "rbxassetid://73317911385704",
    dagger     = "rbxassetid://133081986539088",
    baby       = "rbxassetid://127135446273067",
    ad         = "rbxassetid://134916447199398",
    axe_battle = "rbxassetid://91285868461583",
    avatar     = "rbxassetid://0",
}

local FontURLs = {
    FontAwesome = "https://raw.githubusercontent.com/B5RLAS/Neverlose/main/Font/FontAwesome.ttf",
    Museo500    = "https://raw.githubusercontent.com/B5RLAS/Neverlose/main/Font/Museo500.ttf",
    Museo900    = "https://raw.githubusercontent.com/B5RLAS/Neverlose/main/Font/Museo900.ttf",
}

local function LoadFont(name)
    local ok, result = pcall(function()
        local folder = "ChaosUI"
        if isfolder and not isfolder(folder) then makefolder(folder) end
        local ttf = folder .. "/" .. name .. ".ttf"
        if not (isfile and isfile(ttf)) then
            writefile(ttf, game:HttpGet(FontURLs[name]))
        end
        local json = folder .. "/" .. name .. ".json"
        writefile(json, game:GetService("HttpService"):JSONEncode({
            name = name,
            faces = { { name = "Regular", weight = 400, style = "normal", assetId = getcustomasset(ttf) } },
        }))
        return Font.new(getcustomasset(json), Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    end)
    if ok then return result end
    return nil
end

local Fonts = {
    Museo500    = LoadFont("Museo500"),
    Museo900    = LoadFont("Museo900"),
    FontAwesome = LoadFont("FontAwesome"),
}

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting         = game:GetService("Lighting")
local LocalPlayer      = Players.LocalPlayer

local Theme = {
    Accent           = Color3.fromRGB(220, 40, 75),
    Text             = Color3.fromRGB(255, 255, 255),
    TextDisabled     = Color3.fromRGB(122, 125, 135),
    Border           = Color3.fromRGB(255, 255, 255),
    BorderTransparency = 0.93,
    FrameInactive    = Color3.fromRGB(8, 5, 11),
    FrameActive      = Color3.fromRGB(20, 11, 25),
    Button           = Color3.fromRGB(11, 7, 15),
    ButtonHovered    = Color3.fromRGB(24, 15, 30),
    ButtonActive     = Color3.fromRGB(38, 22, 46),
    GroupBoxBg       = Color3.fromRGB(6, 4, 9),
    WindowBg         = Color3.fromRGB(5, 2, 7),
    Font             = Fonts.Museo500 or Enum.Font.GothamMedium,
    FontBold         = Fonts.Museo900 or Enum.Font.GothamBlack,
    TextSize         = 13,
}

local function New(class, props, children)
    local o = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k == "Font" and typeof(v) == "Font" then
            o.FontFace = v
        elseif k ~= "Parent" then
            o[k] = v
        end
    end
    for _, c in ipairs(children or {}) do
        if c then c.Parent = o end
    end
    if props and props.Parent then o.Parent = props.Parent end
    return o
end

local function Corner(r)
    return New("UICorner", { CornerRadius = UDim.new(0, r) })
end

local function Stroke(color, trans)
    return New("UIStroke", {
        Color = color or Theme.Border,
        Transparency = trans or Theme.BorderTransparency,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })
end

local function Tween(obj, t, props, style)
    local info = TweenInfo.new(t, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tw = TweenService:Create(obj, info, props)
    tw:Play()
    return tw
end

local function Label(p)
    return New("TextLabel", {
        BackgroundTransparency = 1,
        Font = p.Font or Theme.Font,
        TextSize = p.TextSize or Theme.TextSize,
        TextColor3 = p.TextColor3 or Theme.Text,
        TextXAlignment = p.TextXAlignment or Enum.TextXAlignment.Left,
        TextYAlignment = p.TextYAlignment or Enum.TextYAlignment.Center,
        Text = p.Text or "",
        Size = p.Size or UDim2.new(1, 0, 1, 0),
        Position = p.Position or UDim2.new(),
        TextTransparency = p.TextTransparency or 0,
        LayoutOrder = p.LayoutOrder,
        Parent = p.Parent,
    })
end

local function Icon(img, size, color, props)
    local sz = size or 14
    if not img or img == "" then
        return New("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(sz, sz),
            Position = props and props.Position or UDim2.new(),
            Parent = props and props.Parent,
        })
    end
    return New("ImageLabel", {
        BackgroundTransparency = 1,
        Image = img,
        Size = UDim2.fromOffset(sz, sz),
        ImageColor3 = color or Theme.Text,
        Position = props and props.Position or UDim2.new(),
        ImageTransparency = props and props.ImageTransparency or 0,
        Parent = props and props.Parent,
    })
end

local function GetParentGui()
    if gethui then return gethui() end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg then return cg end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local Library = {
    Flags     = {},
    Icons     = Icons,
    Theme     = Theme,
    ToggleKey = Enum.KeyCode.Insert,
    Game      = "default",
}
Library.__index = Library

function Library:SetTheme(overrides)
    for k, v in pairs(overrides or {}) do
        Theme[k] = v
    end
end

function Library:CreateWindow(cfg)
    cfg = cfg or {}
    if cfg.Theme then Library:SetTheme(cfg.Theme) end
    Library.Game = cfg.Game or Library.Game

    local Window = { Tabs = {}, CurrentTab = nil }

    local parent = GetParentGui()
    local existing = parent:FindFirstChild("ChaosUI")
    if existing then existing:Destroy() end

    local gui = New("ScreenGui", {
        Name            = "ChaosUI",
        ResetOnSpawn    = false,
        ZIndexBehavior  = Enum.ZIndexBehavior.Global,
        IgnoreGuiInset  = true,
        Parent          = parent,
    })
    Window.Gui = gui

    local blur = New("BlurEffect", { Size = 0, Name = "ChaosBlur", Parent = Lighting })
    Tween(blur, 0.5, { Size = cfg.Blur or 12 })

    local main = New("CanvasGroup", {
        Name               = "Main",
        Size               = UDim2.fromOffset(690, 500),
        Position           = UDim2.new(0.5, -345, 0.5, -260),
        BackgroundTransparency = 1,
        GroupTransparency  = 1,
        Parent             = gui,
    })
    Window.Main = main

    local function Panel(x, y, w, h, ox, oy, ew, eh, alpha)
        local clip = New("Frame", {
            Size = UDim2.fromOffset(w, h), Position = UDim2.fromOffset(x, y),
            BackgroundTransparency = 1, ClipsDescendants = true,
            BorderSizePixel = 0, Parent = main,
        })
        local inner = New("Frame", {
            Size = UDim2.fromOffset(w + ew, h + eh), Position = UDim2.fromOffset(ox, oy),
            BackgroundColor3 = Theme.WindowBg, BackgroundTransparency = alpha,
            BorderSizePixel = 0, Parent = clip,
        }, { Corner(8) })
        return clip, inner
    end

    local sidebar, _ = Panel(0, 0, 170, 500, 0, 0, 10, 0, 0.07)
    local topbar, _  = Panel(170, 0, 520, 60, -10, 0, 10, 10, 0.03)
    New("Frame", {
        Size = UDim2.fromOffset(520, 1), Position = UDim2.fromOffset(170, 60),
        BackgroundColor3 = Theme.WindowBg, BackgroundTransparency = 0.07,
        BorderSizePixel = 0, Parent = main,
    })
    local contentBg, contentInner = Panel(170, 61, 520, 439, -10, -10, 10, 10, 0)

    New("ImageLabel", {
        Size               = UDim2.fromOffset(530, 449),
        Position           = UDim2.fromOffset(0, 0),
        BackgroundTransparency = 1,
        Image              = cfg.Background or "rbxassetid://7127924463",
        ImageTransparency  = 0.73,
        ScaleType          = Enum.ScaleType.Crop,
        Parent             = contentInner,
    })

    local titleText = cfg.Title or "CHAOS"
    Label({
        Text = titleText, Font = Theme.FontBold, TextSize = 26, TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.fromOffset(170, 30), Position = UDim2.fromOffset(16, 17), Parent = main,
    })
    Label({
        Text = titleText, Font = Theme.FontBold, TextSize = 26, TextColor3 = Theme.Accent,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.fromOffset(170, 30), Position = UDim2.fromOffset(15, 16), Parent = main,
    })

    New("Frame", {
        Size = UDim2.fromOffset(170, 1), Position = UDim2.fromOffset(0, 450),
        BackgroundColor3 = Theme.WindowBg, BackgroundTransparency = 0.5,
        BorderSizePixel = 0, Parent = main,
    })

    local av = New("ImageLabel", {
        Size = UDim2.fromOffset(30, 30), Position = UDim2.fromOffset(15, 460),
        BackgroundColor3 = Theme.FrameActive,
        Image = cfg.Avatar or Icons.avatar, Parent = main,
    }, { Corner(100) })
    if (cfg.Avatar or Icons.avatar) == "rbxassetid://0" then
        pcall(function()
            av.Image = Players:GetUserThumbnailAsync(
                LocalPlayer.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size48x48
            )
        end)
    end

    Label({
        Text = cfg.User or "made by sxy.com",
        Size = UDim2.fromOffset(115, 14), Position = UDim2.fromOffset(50, 460), Parent = main,
    })
    Label({
        Text = Library.Game ~= "default" and Library.Game or (cfg.Till or "CHAOS"),
        TextColor3 = Theme.Accent,
        Size = UDim2.fromOffset(115, 14), Position = UDim2.fromOffset(50, 475), Parent = main,
    })

    local tabList = New("Frame", {
        Size = UDim2.fromOffset(150, 380), Position = UDim2.fromOffset(10, 70),
        BackgroundTransparency = 1, Parent = main,
    }, { New("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }) })
    local order = 0
    local function nextOrder() order += 1 return order end

    local saveBtn = New("TextButton", {
        Size = UDim2.fromOffset(100, 25), Position = UDim2.fromOffset(190, 20),
        BackgroundColor3 = Theme.Button, AutoButtonColor = false, Text = "", Parent = main,
    }, { Corner(4), Stroke() })
    local saveIcon = Icon(Icons.save, 12, Theme.TextDisabled, { Position = UDim2.fromOffset(24, 6), Parent = saveBtn })
    local saveTxt  = Label({ Text = "Save", TextColor3 = Theme.TextDisabled, Size = UDim2.fromOffset(50, 25), Position = UDim2.fromOffset(42, 0), Parent = saveBtn })
    saveBtn.MouseEnter:Connect(function()
        Tween(saveBtn, .15, { BackgroundColor3 = Theme.ButtonHovered })
        saveTxt.TextColor3 = Theme.Text
        saveIcon.ImageColor3 = Theme.Text
    end)
    saveBtn.MouseLeave:Connect(function()
        Tween(saveBtn, .15, { BackgroundColor3 = Theme.Button })
        saveTxt.TextColor3 = Theme.TextDisabled
        saveIcon.ImageColor3 = Theme.TextDisabled
    end)
    saveBtn.MouseButton1Down:Connect(function() Tween(saveBtn, .08, { BackgroundColor3 = Theme.Accent }) end)
    saveBtn.MouseButton1Up:Connect(function() Tween(saveBtn, .12, { BackgroundColor3 = Theme.ButtonHovered }) end)
    saveBtn.MouseButton1Click:Connect(function() if cfg.OnSave then cfg.OnSave(Library.Flags) end end)

    local subHolder = New("Frame", {
        Size = UDim2.fromOffset(240, 25), Position = UDim2.fromOffset(300, 20),
        BackgroundTransparency = 1, Parent = main,
    })

    local pageHolder = New("Frame", {
        Size = UDim2.fromOffset(490, 404), Position = UDim2.fromOffset(185, 81),
        BackgroundTransparency = 1, ClipsDescendants = true, Parent = main,
    })
    local fade = New("CanvasGroup", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Parent = pageHolder })

    local function animatePage()
        fade.GroupTransparency = 1
        pageHolder.Position = UDim2.fromOffset(185, 88)
        Tween(fade, 0.26, { GroupTransparency = 0 }, Enum.EasingStyle.Quint)
        Tween(pageHolder, 0.26, { Position = UDim2.fromOffset(185, 81) }, Enum.EasingStyle.Quint)
    end
    Window.Animate = animatePage

    do
        local dragging, dragStart, startPos
        local dragArea = New("Frame", { Size = UDim2.fromOffset(170, 60), BackgroundTransparency = 1, Parent = main })
        local function beginDrag(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging, dragStart, startPos = true, input.Position, main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end
        dragArea.InputBegan:Connect(beginDrag)
        topbar.InputBegan:Connect(beginDrag)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            ) then
                local d = input.Position - dragStart
                main.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + d.X,
                    startPos.Y.Scale, startPos.Y.Offset + d.Y
                )
            end
        end)
    end

    local shown = true
    local function toggleWindow()
        shown = not shown
        if shown then
            main.Visible = true
            Tween(main, 0.3, { GroupTransparency = 0 }, Enum.EasingStyle.Quint)
            Tween(blur, 0.3, { Size = cfg.Blur or 12 })
        else
            Tween(main, 0.24, { GroupTransparency = 1 }, Enum.EasingStyle.Quint)
            Tween(blur, 0.3, { Size = 0 })
            task.delay(0.26, function() if not shown then main.Visible = false end end)
        end
    end
    Window.Toggle = toggleWindow

    UserInputService.InputBegan:Connect(function(input, gp)
        if not gp and input.KeyCode == Library.ToggleKey then toggleWindow() end
    end)

    task.defer(function()
        Tween(main, 0.5, {
            GroupTransparency = 0,
            Position = UDim2.new(0.5, -345, 0.5, -250),
        }, Enum.EasingStyle.Quint)
    end)

    function Window:AddCategory(name)
        if order > 0 then
            New("Frame", {
                Size = UDim2.fromOffset(150, 8), BackgroundTransparency = 1,
                LayoutOrder = nextOrder(), Parent = tabList,
            })
        end
        local t = Label({
            Text = name, TextTransparency = 0.5,
            Size = UDim2.fromOffset(150, 16), LayoutOrder = nextOrder(), Parent = tabList,
        })
        New("UIPadding", { PaddingLeft = UDim.new(0, 10), Parent = t })
    end

    function Window:AddTab(name, icon)
        local Tab = { Subtabs = {}, Current = nil }

        local btn = New("TextButton", {
            Size = UDim2.fromOffset(150, 30),
            BackgroundColor3 = Theme.FrameActive, BackgroundTransparency = 1,
            AutoButtonColor = false, Text = "", LayoutOrder = nextOrder(), Parent = tabList,
        }, { Corner(5) })

        local activeBar = New("Frame", {
            Size = UDim2.fromOffset(3, 20),
            Position = UDim2.new(0, 2, 0.5, -10),
            BackgroundColor3 = Theme.Accent, BackgroundTransparency = 1,
            BorderSizePixel = 0, Parent = btn,
        }, { Corner(2) })

        Icon(icon or "", 14, Theme.Accent, { Position = UDim2.fromOffset(14, 8), Parent = btn })
        Label({ Text = name, Size = UDim2.fromOffset(108, 30), Position = UDim2.fromOffset(37, 0), Parent = btn })

        local subBar = New("Frame", {
            Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.Button, Visible = false, Parent = subHolder,
        }, {
            Corner(4), Stroke(),
            New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder }),
        })

        Tab.Button, Tab.SubBar, Tab.ActiveBar = btn, subBar, activeBar

        local function layoutSubs()
            local n = #Tab.Subtabs
            subBar.Visible = n > 0 and Window.CurrentTab == Tab
            for _, s in ipairs(Tab.Subtabs) do
                s.Button.Size = UDim2.new(1 / math.max(n, 1), 0, 1, 0)
            end
        end

        function Tab:Select()
            if Window.CurrentTab == Tab then return end
            for _, t in ipairs(Window.Tabs) do
                Tween(t.Button, .22, { BackgroundTransparency = 1 })
                Tween(t.ActiveBar, .22, { BackgroundTransparency = 1 })
                t.SubBar.Visible = false
                for _, s in ipairs(t.Subtabs) do s.Page.Visible = false end
            end
            Window.CurrentTab = Tab
            Tween(btn, .22, { BackgroundTransparency = 0.44 })
            Tween(activeBar, .22, { BackgroundTransparency = 0 })
            layoutSubs()
            if Tab.Current then
                Tab.Current.Page.Visible = true
            elseif Tab.Subtabs[1] then
                Tab.Subtabs[1]:Select()
            end
            animatePage()
        end

        btn.MouseButton1Click:Connect(function() Tab:Select() end)
        btn.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                Tween(btn, .15, { BackgroundTransparency = 0.72 })
            end
        end)
        btn.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                Tween(btn, .15, { BackgroundTransparency = 1 })
            end
        end)

        function Tab:AddSubtab(sname)
            local Sub = {}

            local sb = New("TextButton", {
                BackgroundColor3 = Theme.FrameActive, BackgroundTransparency = 1,
                AutoButtonColor = false, Text = sname,
                Font = Theme.Font, TextSize = Theme.TextSize, TextColor3 = Theme.TextDisabled,
                LayoutOrder = #Tab.Subtabs + 1, Parent = subBar,
            }, { Corner(4) })

            local page = New("Frame", {
                Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, Parent = fade,
            })

            local function column(x)
                return New("ScrollingFrame", {
                    Size = UDim2.fromOffset(241, 404), Position = UDim2.fromOffset(x, 0),
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Accent,
                    CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    Parent = page,
                }, { New("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }) })
            end

            Sub.Left, Sub.Right = column(0), column(249)
            Sub.Button, Sub.Page = sb, page

            function Sub:Select()
                for _, s in ipairs(Tab.Subtabs) do
                    s.Page.Visible = false
                    Tween(s.Button, .22, { BackgroundTransparency = 1 })
                    s.Button.TextColor3 = Theme.TextDisabled
                end
                Tab.Current = Sub
                page.Visible = true
                Tween(sb, .22, { BackgroundTransparency = 0.14 })
                sb.TextColor3 = Theme.Text
                animatePage()
            end
            sb.MouseButton1Click:Connect(function() Sub:Select() end)

            function Sub:AddGroup(gname, gicon, side, height)
                local col = (side == "Right") and Sub.Right or Sub.Left
                local G = {}

                local holder = New("Frame", {
                    Size = UDim2.fromOffset(241, height or 404), BackgroundTransparency = 1,
                    LayoutOrder = #col:GetChildren(), Parent = col,
                })

                local tx = 12
                if gicon then
                    Icon(gicon, 12, Theme.Text, {
                        Position = UDim2.fromOffset(12, 2), ImageTransparency = 0.5, Parent = holder,
                    })
                    tx = 28
                end
                Label({
                    Text = gname, TextTransparency = 0.5,
                    Size = UDim2.fromOffset(200, 16), Position = UDim2.fromOffset(tx, 0), Parent = holder,
                })

                local box = New("Frame", {
                    Size = UDim2.new(1, 0, 1, -20), Position = UDim2.fromOffset(0, 20),
                    BackgroundColor3 = Theme.GroupBoxBg, BorderSizePixel = 0, Parent = holder,
                }, { Corner(6), Stroke() })

                local list = New("ScrollingFrame", {
                    Size = UDim2.new(1, -24, 1, -1), Position = UDim2.fromOffset(12, 1),
                    BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
                    CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = box,
                }, {
                    New("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }),
                    New("UIPadding", { PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10) }),
                })

                local n = 0
                local function row(h)
                    n += 1
                    return New("Frame", {
                        Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1,
                        LayoutOrder = n, Parent = list,
                    })
                end
                local function flag(f, v) if f then Library.Flags[f] = v end end

                function G:AddCheckbox(o)
                    o = type(o) == "string" and { Name = o } or o
                    local state = o.Default or false
                    local r = row(17)
                    local lbl = Label({
                        Text = o.Name, Size = UDim2.new(1, -40, 1, 0),
                        TextColor3 = state and Theme.Text or Theme.TextDisabled, Parent = r,
                    })
                    if o.Icon then
                        Icon(o.Icon, 12, lbl.TextColor3, {
                            Position = UDim2.fromOffset(lbl.TextBounds.X + 4, 2), Parent = r,
                        })
                    end
                    local sw = New("TextButton", {
                        Size = UDim2.fromOffset(30, 17), Position = UDim2.new(1, -30, 0, 0),
                        BackgroundColor3 = Theme.FrameInactive, AutoButtonColor = false, Text = "", Parent = r,
                    }, { Corner(10), Stroke() })
                    local knob = New("Frame", {
                        Size = UDim2.fromOffset(14, 14), AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0, 8, 0.5, 0), BackgroundColor3 = Theme.TextDisabled, Parent = sw,
                    }, { Corner(7) })
                    local obj = {}
                    function obj:Set(v)
                        state = v
                        Tween(sw, .2, { BackgroundColor3 = v and Theme.FrameActive or Theme.FrameInactive }, Enum.EasingStyle.Quint)
                        Tween(knob, .2, { Position = UDim2.new(0, v and 22 or 8, 0.5, 0), BackgroundColor3 = v and Theme.Accent or Theme.TextDisabled }, Enum.EasingStyle.Quint)
                        lbl.TextColor3 = v and Theme.Text or Theme.TextDisabled
                        flag(o.Flag, v)
                        if o.Callback then task.spawn(o.Callback, v) end
                    end
                    function obj:Get() return state end
                    sw.MouseButton1Click:Connect(function() obj:Set(not state) end)
                    if state then
                        sw.BackgroundColor3 = Theme.FrameActive
                        knob.Position = UDim2.new(0, 22, 0.5, 0)
                        knob.BackgroundColor3 = Theme.Accent
                    end
                    flag(o.Flag, state)
                    return obj
                end

                function G:AddSlider(o)
                    local val = math.clamp(o.Default or o.Min, o.Min, o.Max)
                    local r = row(38)
                    Label({ Text = o.Name, TextColor3 = Theme.TextDisabled, Size = UDim2.new(1, -50, 0, 16), Parent = r })
                    local valBox = New("TextButton", {
                        Size = UDim2.fromOffset(44, 16), Position = UDim2.new(1, -44, 0, 0),
                        BackgroundColor3 = Theme.Button, AutoButtonColor = false, Text = "", Parent = r,
                    }, { Corner(4), Stroke() })
                    local valLbl = Label({
                        Text = tostring(val) .. (o.Suffix or ""),
                        TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Center,
                        Size = UDim2.fromScale(1, 1), Parent = valBox,
                    })
                    local bar = New("Frame", {
                        Size = UDim2.new(1, 0, 0, 6), Position = UDim2.fromOffset(0, 24),
                        BackgroundColor3 = Theme.FrameInactive, BorderSizePixel = 0, Parent = r,
                    }, { Corner(3), Stroke() })
                    local fill = New("Frame", {
                        Size = UDim2.new((val - o.Min) / (o.Max - o.Min), 0, 1, 0),
                        BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = bar,
                    }, { Corner(3) })
                    local grab = New("Frame", {
                        Size = UDim2.fromOffset(12, 12), AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(fill.Size.X.Scale, 0, 0.5, 0),
                        BackgroundColor3 = Theme.Text, BorderSizePixel = 0, Parent = bar,
                    }, { Corner(6), Stroke(Theme.Accent, 0.4) })
                    local obj = {}
                    function obj:Set(v)
                        local d = o.Decimals or 0
                        v = math.clamp(math.round(v * 10 ^ d) / 10 ^ d, o.Min, o.Max)
                        val = v
                        local t = (v - o.Min) / (o.Max - o.Min)
                        Tween(fill, .1, { Size = UDim2.new(t, 0, 1, 0) }, Enum.EasingStyle.Linear)
                        Tween(grab, .1, { Position = UDim2.new(t, 0, 0.5, 0) }, Enum.EasingStyle.Linear)
                        valLbl.Text = tostring(v) .. (o.Suffix or "")
                        flag(o.Flag, v)
                        if o.Callback then task.spawn(o.Callback, v) end
                    end
                    function obj:Get() return val end
                    local dragging = false
                    local function update(input)
                        local bx = bar.AbsolutePosition.X
                        local bw = bar.AbsoluteSize.X
                        local t = math.clamp((input.Position.X - bx) / bw, 0, 1)
                        obj:Set(o.Min + (o.Max - o.Min) * t)
                    end
                    bar.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            update(input)
                        end
                    end)
                    UserInputService.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            update(input)
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                    end)
                    obj:Set(val)
                    return obj
                end

                function G:AddDropdown(o)
                    local items = o.Items or {}
                    local sel   = o.Default or items[1] or ""
                    local r     = row(38)
                    Label({ Text = o.Name, TextColor3 = Theme.TextDisabled, Size = UDim2.new(1, 0, 0, 16), Parent = r })
                    local dropBtn = New("TextButton", {
                        Size = UDim2.new(1, 0, 0, 20), Position = UDim2.fromOffset(0, 18),
                        BackgroundColor3 = Theme.Button, AutoButtonColor = false, Text = "", Parent = r,
                    }, { Corner(4), Stroke() })
                    local selLbl = Label({
                        Text = sel, Size = UDim2.new(1, -24, 1, 0), Position = UDim2.fromOffset(8, 0), Parent = dropBtn,
                    })
                    local arrow = Label({
                        Text = "▾", TextColor3 = Theme.TextDisabled, TextXAlignment = Enum.TextXAlignment.Right,
                        Size = UDim2.new(0, 20, 1, 0), Position = UDim2.new(1, -20, 0, 0), Parent = dropBtn,
                    })
                    local open = false
                    local popup = New("Frame", {
                        Size = UDim2.new(1, 0, 0, 0), Position = UDim2.fromOffset(0, 40),
                        BackgroundColor3 = Theme.Button, ClipsDescendants = true,
                        Visible = false, BorderSizePixel = 0, ZIndex = 10, Parent = r,
                    }, { Corner(4), Stroke() })
                    local popupList = New("Frame", {
                        Size = UDim2.new(1, 0, 0, #items * 22),
                        BackgroundTransparency = 1, Parent = popup,
                    }, { New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }) })
                    local obj = {}
                    function obj:Set(v)
                        sel = v
                        selLbl.Text = v
                        flag(o.Flag, v)
                        if o.Callback then task.spawn(o.Callback, v) end
                    end
                    function obj:Get() return sel end
                    local function closePopup()
                        open = false
                        Tween(popup, .18, { Size = UDim2.new(1, 0, 0, 0) }, Enum.EasingStyle.Quint)
                        task.delay(0.2, function() popup.Visible = false end)
                        Tween(arrow, .18, { Rotation = 0 })
                    end
                    for _, item in ipairs(items) do
                        local ib = New("TextButton", {
                            Size = UDim2.new(1, 0, 0, 22), BackgroundColor3 = Theme.Button,
                            AutoButtonColor = false, Text = item,
                            Font = Theme.Font, TextSize = Theme.TextSize,
                            TextColor3 = item == sel and Theme.Accent or Theme.TextDisabled,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            ZIndex = 11, Parent = popupList,
                        }, { New("UIPadding", { PaddingLeft = UDim.new(0, 8) }) })
                        ib.MouseEnter:Connect(function()
                            if item ~= sel then ib.TextColor3 = Theme.Text end
                        end)
                        ib.MouseLeave:Connect(function()
                            ib.TextColor3 = item == sel and Theme.Accent or Theme.TextDisabled
                        end)
                        ib.MouseButton1Click:Connect(function()
                            for _, c in ipairs(popupList:GetChildren()) do
                                if c:IsA("TextButton") then c.TextColor3 = Theme.TextDisabled end
                            end
                            ib.TextColor3 = Theme.Accent
                            obj:Set(item)
                            closePopup()
                        end)
                    end
                    dropBtn.MouseButton1Click:Connect(function()
                        open = not open
                        if open then
                            popup.Visible = true
                            popup.Size = UDim2.new(1, 0, 0, 0)
                            Tween(popup, .2, { Size = UDim2.new(1, 0, 0, math.min(#items * 22, 110)) }, Enum.EasingStyle.Quint)
                            Tween(arrow, .2, { Rotation = 180 })
                        else
                            closePopup()
                        end
                    end)
                    obj:Set(sel)
                    return obj
                end
                G.AddCombo = G.AddDropdown

                function G:AddTextbox(o)
                    local r = row(38)
                    Label({ Text = o.Name, TextColor3 = Theme.TextDisabled, Size = UDim2.new(1, 0, 0, 16), Parent = r })
                    local box = New("TextBox", {
                        Size = UDim2.new(1, 0, 0, 20), Position = UDim2.fromOffset(0, 18),
                        BackgroundColor3 = Theme.Button, BorderSizePixel = 0,
                        Font = Theme.Font, TextSize = Theme.TextSize, TextColor3 = Theme.Text,
                        PlaceholderText = o.Placeholder or "", PlaceholderColor3 = Theme.TextDisabled,
                        Text = o.Default or "", TextXAlignment = Enum.TextXAlignment.Left,
                        ClearTextOnFocus = false, Parent = r,
                    }, {
                        Corner(4), Stroke(),
                        New("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }),
                    })
                    box.Focused:Connect(function()
                        Tween(box, .15, { BackgroundColor3 = Theme.ButtonHovered })
                    end)
                    box.FocusLost:Connect(function(enter)
                        Tween(box, .15, { BackgroundColor3 = Theme.Button })
                        if enter then
                            flag(o.Flag, box.Text)
                            if o.Callback then task.spawn(o.Callback, box.Text) end
                        end
                    end)
                    return box
                end
                G.AddInput = G.AddTextbox

                function G:AddColorPicker(o)
                    local col   = o.Default or Color3.fromRGB(255, 255, 255)
                    local alpha = o.Alpha or 1
                    local h, s, v = col:ToHSV()
                    local r = row(17)

                    Label({ Text = o.Name, Size = UDim2.new(1, -26, 1, 0), TextColor3 = Theme.TextDisabled, Parent = r })
                    local preview = New("TextButton", {
                        Size = UDim2.fromOffset(20, 16), Position = UDim2.new(1, -20, 0, 0),
                        BackgroundColor3 = col, AutoButtonColor = false, Text = "", Parent = r,
                    }, { Corner(4), Stroke() })

                    local pop = New("Frame", {
                        Size = UDim2.fromOffset(200, 220), Position = UDim2.fromOffset(0, 20),
                        BackgroundColor3 = Theme.Button, BorderSizePixel = 0,
                        Visible = false, ZIndex = 15, Parent = r,
                    }, { Corner(6), Stroke() })

                    local function applyColor()
                        col = Color3.fromHSV(h, s, v)
                        preview.BackgroundColor3 = col
                        flag(o.Flag, col)
                        if o.Callback then task.spawn(o.Callback, col, alpha) end
                    end

                    local svBox = New("Frame", {
                        Size = UDim2.fromOffset(180, 140), Position = UDim2.fromOffset(10, 10),
                        BackgroundColor3 = Color3.fromHSV(h, 1, 1),
                        BorderSizePixel = 0, ZIndex = 16, Parent = pop,
                    }, { Corner(4) })
                    New("UIGradient", {
                        Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
                        Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0),
                            NumberSequenceKeypoint.new(1, 1),
                        }),
                        Rotation = 0, Parent = svBox,
                    })
                    local svDark = New("Frame", {
                        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 17, Parent = svBox,
                    })
                    New("UIGradient", {
                        Color = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
                        Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 1),
                            NumberSequenceKeypoint.new(1, 0),
                        }),
                        Rotation = 90, Parent = svDark,
                    })
                    local svGrab = New("Frame", {
                        Size = UDim2.fromOffset(10, 10), AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(s, 0, 1 - v, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0, ZIndex = 19, Parent = svBox,
                    }, { Corner(5) })

                    local hBar = New("Frame", {
                        Size = UDim2.fromOffset(180, 12), Position = UDim2.fromOffset(10, 158),
                        BorderSizePixel = 0, ZIndex = 16, Parent = pop,
                    }, {
                        Corner(6),
                        New("UIGradient", { Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0,     Color3.fromHSV(0,     1, 1)),
                            ColorSequenceKeypoint.new(1/6,   Color3.fromHSV(1/6,   1, 1)),
                            ColorSequenceKeypoint.new(2/6,   Color3.fromHSV(2/6,   1, 1)),
                            ColorSequenceKeypoint.new(3/6,   Color3.fromHSV(3/6,   1, 1)),
                            ColorSequenceKeypoint.new(4/6,   Color3.fromHSV(4/6,   1, 1)),
                            ColorSequenceKeypoint.new(5/6,   Color3.fromHSV(5/6,   1, 1)),
                            ColorSequenceKeypoint.new(1,     Color3.fromHSV(1,     1, 1)),
                        }) }),
                    })
                    local hGrab = New("Frame", {
                        Size = UDim2.fromOffset(6, 12), AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(h, 0, 0.5, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0, ZIndex = 17, Parent = hBar,
                    }, { Corner(3) })

                    local aBar = New("Frame", {
                        Size = UDim2.fromOffset(180, 12), Position = UDim2.fromOffset(10, 178),
                        BorderSizePixel = 0, ZIndex = 16, Parent = pop,
                    }, {
                        Corner(6),
                        New("UIGradient", { Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
                        }) }),
                    })
                    local aGrab = New("Frame", {
                        Size = UDim2.fromOffset(6, 12), AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(alpha, 0, 0.5, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0, ZIndex = 17, Parent = aBar,
                    }, { Corner(3) })

                    local hexBox = New("TextBox", {
                        Size = UDim2.fromOffset(180, 20), Position = UDim2.fromOffset(10, 196),
                        BackgroundColor3 = Theme.FrameInactive, BorderSizePixel = 0,
                        Font = Theme.Font, TextSize = Theme.TextSize, TextColor3 = Theme.Text,
                        Text = string.format("#%02X%02X%02X",
                            math.round(col.R * 255), math.round(col.G * 255), math.round(col.B * 255)),
                        TextXAlignment = Enum.TextXAlignment.Center,
                        ZIndex = 16, Parent = pop,
                    }, { Corner(4), Stroke() })

                    local function refreshGrabs()
                        svGrab.Position = UDim2.new(s, 0, 1 - v, 0)
                        hGrab.Position  = UDim2.new(h, 0, 0.5, 0)
                        aGrab.Position  = UDim2.new(alpha, 0, 0.5, 0)
                        svBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                        hexBox.Text = string.format("#%02X%02X%02X",
                            math.round(col.R * 255), math.round(col.G * 255), math.round(col.B * 255))
                    end

                    local function dragOn(frame, fn)
                        local d = false
                        frame.InputBegan:Connect(function(inp)
                            if inp.UserInputType == Enum.UserInputType.MouseButton1 then d = true; fn(inp) end
                        end)
                        UserInputService.InputChanged:Connect(function(inp)
                            if d and inp.UserInputType == Enum.UserInputType.MouseMovement then fn(inp) end
                        end)
                        UserInputService.InputEnded:Connect(function(inp)
                            if inp.UserInputType == Enum.UserInputType.MouseButton1 then d = false end
                        end)
                    end

                    dragOn(svBox, function(inp)
                        local ap, as = svBox.AbsolutePosition, svBox.AbsoluteSize
                        s = math.clamp((inp.Position.X - ap.X) / as.X, 0, 1)
                        v = 1 - math.clamp((inp.Position.Y - ap.Y) / as.Y, 0, 1)
                        applyColor(); refreshGrabs()
                    end)
                    dragOn(hBar, function(inp)
                        h = math.clamp((inp.Position.X - hBar.AbsolutePosition.X) / hBar.AbsoluteSize.X, 0, 1)
                        applyColor(); refreshGrabs()
                    end)
                    dragOn(aBar, function(inp)
                        alpha = math.clamp((inp.Position.X - aBar.AbsolutePosition.X) / aBar.AbsoluteSize.X, 0, 1)
                        applyColor(); refreshGrabs()
                    end)

                    hexBox.FocusLost:Connect(function(enter)
                        if not enter then return end
                        local hex = hexBox.Text:gsub("#", "")
                        if #hex == 6 then
                            local r2 = tonumber(hex:sub(1, 2), 16)
                            local g2 = tonumber(hex:sub(3, 4), 16)
                            local b2 = tonumber(hex:sub(5, 6), 16)
                            if r2 and g2 and b2 then
                                col = Color3.fromRGB(r2, g2, b2)
                                h, s, v = col:ToHSV()
                                applyColor(); refreshGrabs()
                            end
                        end
                    end)

                    local popOpen = false
                    preview.MouseButton1Click:Connect(function()
                        popOpen = not popOpen
                        pop.Visible = popOpen
                    end)

                    local obj = {}
                    function obj:Set(c, a)
                        col = c; alpha = a or alpha
                        h, s, v = col:ToHSV()
                        applyColor(); refreshGrabs()
                    end
                    function obj:Get() return col, alpha end
                    return obj
                end

                function G:AddButton(o)
                    o = type(o) == "string" and { Name = o } or o
                    local r = row(24)
                    local btn2 = New("TextButton", {
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundColor3 = Theme.Button, AutoButtonColor = false,
                        Text = o.Name, Font = Theme.Font, TextSize = Theme.TextSize,
                        TextColor3 = Theme.TextDisabled, Parent = r,
                    }, { Corner(5), Stroke() })
                    btn2.MouseEnter:Connect(function()
                        Tween(btn2, .15, { BackgroundColor3 = Theme.ButtonHovered })
                        btn2.TextColor3 = Theme.Text
                    end)
                    btn2.MouseLeave:Connect(function()
                        Tween(btn2, .15, { BackgroundColor3 = Theme.Button })
                        btn2.TextColor3 = Theme.TextDisabled
                    end)
                    btn2.MouseButton1Down:Connect(function()
                        Tween(btn2, .07, { BackgroundColor3 = Theme.Accent })
                        btn2.TextColor3 = Theme.Text
                    end)
                    btn2.MouseButton1Up:Connect(function()
                        Tween(btn2, .15, { BackgroundColor3 = Theme.ButtonHovered })
                    end)
                    btn2.MouseButton1Click:Connect(function()
                        if o.Callback then task.spawn(o.Callback) end
                    end)
                    return btn2
                end

                function G:AddKeybind(o)
                    local key      = o.Default or Enum.KeyCode.Unknown
                    local listening = false
                    local r        = row(17)
                    Label({ Text = o.Name, Size = UDim2.new(1, -70, 1, 0), TextColor3 = Theme.TextDisabled, Parent = r })
                    local kb = New("TextButton", {
                        Size = UDim2.fromOffset(64, 17), Position = UDim2.new(1, -64, 0, 0),
                        BackgroundColor3 = Theme.Button, AutoButtonColor = false,
                        Text = key == Enum.KeyCode.Unknown and "None" or key.Name,
                        Font = Theme.Font, TextSize = 11, TextColor3 = Theme.TextDisabled, Parent = r,
                    }, { Corner(4), Stroke() })
                    local obj = {}
                    function obj:Set(k)
                        key = k
                        kb.Text = k == Enum.KeyCode.Unknown and "None" or k.Name
                        flag(o.Flag, k)
                        if o.Callback then task.spawn(o.Callback, k) end
                    end
                    kb.MouseButton1Click:Connect(function()
                        listening = true
                        kb.Text = "..."
                        kb.TextColor3 = Theme.Accent
                    end)
                    UserInputService.InputBegan:Connect(function(input, gp)
                        if not listening then return end
                        listening = false
                        kb.TextColor3 = Theme.TextDisabled
                        if input.KeyCode == Enum.KeyCode.Escape then
                            obj:Set(Enum.KeyCode.Unknown)
                        else
                            obj:Set(input.KeyCode)
                        end
                    end)
                    obj:Set(key)
                    return obj
                end

                function G:AddSeparator()
                    local r = row(1)
                    r.BackgroundColor3 = Theme.Border
                    r.BackgroundTransparency = 0.94
                    r.BorderSizePixel = 0
                end

                function G:AddLabel(text)
                    local r = row(14)
                    return Label({ Text = text, TextColor3 = Theme.TextDisabled, Size = UDim2.fromScale(1, 1), Parent = r })
                end

                return G
            end

            table.insert(Tab.Subtabs, Sub)
            layoutSubs()
            if Window.CurrentTab == Tab and not Tab.Current then Sub:Select() end
            return Sub
        end

        function Tab:AddGroup(...)
            Tab._default = Tab._default or Tab:AddSubtab("General")
            return Tab._default:AddGroup(...)
        end

        table.insert(Window.Tabs, Tab)
        if not Window.CurrentTab then Tab:Select() end
        return Tab
    end

    function Window:Destroy()
        blur:Destroy()
        gui:Destroy()
    end

    return Window
end

return Library
