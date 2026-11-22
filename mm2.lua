local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local lp = Players.LocalPlayer
local cam = Workspace.CurrentCamera

local ACCENT      = Color3.fromRGB(210, 35, 35)
local ACCENT2     = Color3.fromRGB(170, 20, 20)
local WIN_BG      = Color3.fromRGB(8, 8, 10)
local SIDE_BG     = Color3.fromRGB(5, 5, 7)
local TOP_H       = 44
local SIDE_W      = 165
local WIN_W       = 720
local WIN_H       = 510
local GUN_ICON    = "http://www.roblox.com/asset/?id=197518111"
local KNIFE_ICON  = "rbxassetid://584555920"
local PLACE_ID    = game.PlaceId
local JOB_ID      = game.JobId

local SFX_IDS = {
    toggle = 136108770017536,
    click  = 139800881181209,
    error  = 131039887376992,
    gun    = 131390520971848,
}
local sfxFolder = SoundService:FindFirstChild("ChaosSFX") or Instance.new("Folder")
sfxFolder.Name = "ChaosSFX"
sfxFolder.Parent = SoundService
local sfxSounds = {}
for name, id in pairs(SFX_IDS) do
    local s = sfxFolder:FindFirstChild(name) or Instance.new("Sound")
    s.Name = name
    s.SoundId = "rbxassetid://" .. id
    s.Volume = 0.4
    s.RollOffMaxDistance = 0
    s.Parent = sfxFolder
    sfxSounds[name] = s
end

local function playSfx(name)
    if not ChaosFlags or ChaosFlags["Toggle_SFX"] == false then return end
    local s = sfxSounds[name]
    if s then pcall(function() s:Play() end) end
end

local ChaosFlags = {
    Toggle_SilentAim      = false,
    Toggle_SilentThrow    = false,
    Toggle_HitboxExp      = false,
    Toggle_KillAura       = false,
    Toggle_ESP            = false,
    Toggle_ESPNames       = false,
    Toggle_Tracers        = false,
    Toggle_TracerDist     = false,
    Toggle_Arrows         = false,
    Toggle_GunESP         = false,
    Toggle_TrapESP        = false,
    Toggle_CoinESP        = false,
    Toggle_RoleBoxHide    = false,
    Toggle_AutoFarm       = false,
    Toggle_KillWhenFull   = false,
    Toggle_FlingWhenDone  = false,
    Toggle_FarmHop        = false,
    Toggle_SpamFling      = false,
    Toggle_FlingAll       = false,
    Toggle_Noclip         = false,
    Toggle_Fly            = false,
    Toggle_GodMode        = false,
    Toggle_BunnyHop       = false,
    Toggle_InfJump        = false,
    Toggle_AntiAFK        = false,
    Toggle_NoFog          = false,
    Toggle_Fullbright     = false,
    Toggle_NoBlood        = false,
    Toggle_Crosshair      = false,
    Toggle_SFX            = true,
    Toggle_Shells         = false,
    Slider_HitboxSize     = 8,
    Slider_LeadTime       = 0.14,
    Slider_KnifeReach     = 6,
    Slider_FOV            = 70,
    Slider_FlySpeed       = 50,
    Slider_WalkSpeed      = 16,
    Slider_JumpPower      = 50,
    Slider_FarmHopMin     = 2,
    Slider_CrosshairSize  = 8,
    espColors = {
        murderer = Color3.fromRGB(255, 50, 50),
        sheriff  = Color3.fromRGB(50, 150, 255),
        innocent = Color3.fromRGB(100, 220, 100),
        gun      = Color3.fromRGB(255, 200, 50),
        coin     = Color3.fromRGB(255, 215, 0),
        trap     = Color3.fromRGB(255, 140, 0),
    },
    SpamFlingTarget = nil,
    FlingAllRunning = false,
    SkinChanger_Knife = "Default",
    SkinChanger_Gun   = "Default",

    Toggle_Chams             = false,
    Toggle_MurderAura        = false,
    Toggle_SheriffAura       = false,
    Toggle_CoinMagnet        = false,
    Toggle_ClickTP           = false,
    Toggle_HeadHitbox        = false,
    Toggle_RainbowESP        = false,
    Toggle_FPSBoost          = false,
    Toggle_ShowESPHealth     = false,
    Toggle_ShowESPDist       = false,
    Toggle_GravityMod        = false,
    Toggle_AimLock           = false,
    Toggle_CustomFOV         = false,
    Toggle_NoclipPlus        = false,
    Slider_MurderAuraRange   = 20,
    Slider_SheriffAuraRange  = 50,
    Slider_CoinMagnetForce   = 80,
    Slider_Gravity           = 196,
    Slider_CustomFOV         = 70,
    LockOn_Target            = "(none)",
    Toggle_AntiVoid        = false,
    Toggle_AntiFling       = false,
    Toggle_Spin            = false,
    Toggle_Invisible       = false,
    Toggle_ExposeRoles     = false,
    Toggle_RoleNotify      = false,
    Toggle_AutoShoot       = false,
    Toggle_AutoShootWall   = false,
    Toggle_AutoGrabGun     = false,
    Toggle_TouchFling      = false,
    Toggle_FlingMurderer   = false,
    Toggle_FlingSheriff    = false,
    Toggle_OptCoins        = false,
    Toggle_RemoveTraps     = false,
    Toggle_RemoveChroma    = false,
    Toggle_RemovePets      = false,
    Toggle_AutoReset       = false,
    Toggle_SpeedGlitch     = false,
    Toggle_JumpBoost       = false,
    Toggle_AutoRejoin      = false,
    Toggle_NoGunCD         = false,
    Toggle_BGBlur          = false,
    Toggle_AutoBox         = false,
    Toggle_AutoHopWatch    = false,
    Toggle_SkinWatcher     = false,
    Slider_SpinSpeed       = 5,
    Slider_SpeedGlitch     = 60,
    Slider_JumpBoost       = 150,
    Slider_BlurSize        = 24,
    Slider_AimRange        = 150,
    Slider_ESPRange        = 500,
    Fling_Target           = "(all)",
    Toggle_BodyHitbox      = false,
    Slider_BodyHitboxSize  = 6,
    Toggle_GhostMode       = false,
    Slider_GhostTransp     = 60,
    Toggle_SnapLines       = false,
    Toggle_SkeletonESP     = false,
    Toggle_RoleColorESP    = false,
    Toggle_NameTags        = false,
    Toggle_SpeedESP        = false,
    Toggle_WaypointESP     = false,
    Toggle_KnifeTrail      = false,
    Toggle_KillCounter     = false,
    Toggle_SoundRemove     = false,
    Toggle_RapidFire       = false,
    Toggle_AutoCollect     = false,
    Toggle_AutoStrafe      = false,
    Toggle_NoFog           = false,
    Toggle_Overlay         = false,
    Toggle_ClockOverlay    = false,
    Toggle_RoleOverlay     = false,
    Slider_CollectRange    = 60,
    ESPBoxes_key           = "Toggle_ESPBoxes",
    Toggle_ESPBoxes        = false,
    Toggle_ESPTracers      = false,
    Toggle_ESPArrows       = false,
    Toggle_ShowESPHealth   = false,
    Toggle_ShowESPDist     = false,
    Toggle_CrosshairSize   = false,
    Slider_CrosshairSize   = 8,
}

local ChaosConns = {}
local ChaosDrawings = {}
local roleData = {}
local velTrack = {}
local lastGunNotify = 0

local function addConn(c) table.insert(ChaosConns, c) end

local KNIFE_SKINS = {
    Default = nil,
    Sakura = { MeshId="rbxassetid://12307707430", TextureId="http://www.roblox.com/asset/?id=12382320383", MeshTextureId="rbxassetid://12307707797", Scale=Vector3.new(0.0731,0.0740,0.0765), Grip=CFrame.new(0,-1.38018155,0.0264663696,1,0,0,0,1,0,0,0,1) },
    Corrupt = { MeshId="http://www.roblox.com/asset/?id=121944778", TextureId="http://www.roblox.com/asset/?id=601019226", MeshTextureId="http://www.roblox.com/asset/?id=162016526", Scale=Vector3.new(1,1,1), Grip=CFrame.new(0,-1.08903813,0.0264663696,1,0,0,0,1,0,0,0,1) },
    ["Ice Crusher Hammer"] = { MeshId="rbxassetid://11848711686", TextureId="http://www.roblox.com/asset/?id=11999012748", MeshTextureId="rbxassetid://11850483027", Scale=Vector3.new(0.0639,0.0563,0.0601), Grip=CFrame.new(0,-1.08903813,0.0264663696,1,0,0,0,1,0,0,0,1) },
    Candy = { MeshId="http://www.roblox.com/asset/?id=19040337", TextureId="http://www.roblox.com/asset/?id=8441578414", MeshTextureId="http://www.roblox.com/asset/?id=19040326", Scale=Vector3.new(1,1.189,1.135), Grip=CFrame.new(-0.00000762939453,0.863931298,0.0641334131,-0.0000658035278,0.00000266730785,1,-0.0809930265,-0.996714592,-0.00000266730785,0.996714711,-0.0809930265,0.0000658035278) },
    Phantom = { MeshId="rbxassetid://11158775938", TextureId="http://www.roblox.com/asset/?id=11300743271", MeshTextureId="rbxassetid://11158776140", Scale=Vector3.new(0.0796,0.0815,0.0854), Grip=CFrame.new(0,-1.40598226,0.0264663696,1,0,0,0,1,0,0,0,1) },
    Bat = { MeshId="rbxassetid://11182796403", TextureId="http://www.roblox.com/asset/?id=11300746586", MeshTextureId="rbxassetid://11192090515", Scale=Vector3.new(0.0731,0.0740,0.0765), Grip=CFrame.new(0,-1.26708531,0.0264663696,1,0,0,0,1,0,0,0,1) },
    ["Swirl Axe"] = { MeshId="rbxassetid://8293463844", TextureId="http://www.roblox.com/asset/?id=9819801549", MeshTextureId="rbxassetid://8293464070", Scale=Vector3.new(0.0639,0.0563,0.0601), Grip=CFrame.new(0,-1.08903813,0.0264663696,1,0,0,0,1,0,0,0,1) },
    ["Sword Of Light"] = { MeshId="http://www.roblox.com/asset/?id=54383785", TextureId="http://www.roblox.com/asset/?id=54383861", MeshTextureId="http://www.roblox.com/asset/?id=54383840", Scale=Vector3.new(2,2,2), Grip=CFrame.new(0,0,-2.5,0,0,-1,-1,0,0,0,1,0) },
    ["8Bit"] = { MeshId="http://www.roblox.com/asset/?id=361629844", TextureId="http://www.roblox.com/asset/?id=380257985", MeshTextureId="http://www.roblox.com/asset/?id=380257575", Scale=Vector3.new(4.5,4.5,4.5), Grip=CFrame.new(0,0.05,1.5,1,0,0,0,0,1,0,-1,0) },
    Celestial = { MeshId="http://www.roblox.com/asset/?id=12221720", TextureId="http://www.roblox.com/asset/?id=16620737", MeshTextureId="", Scale=Vector3.new(1,1,1), Grip=CFrame.new(0,0,-1.5,0,0,1,1,0,0,0,1,0) },
    ["Neon Katana"] = { MeshId="rbxassetid://535069545", TextureId="rbxassetid://535069363", MeshTextureId="rbxassetid://535069453", Scale=Vector3.new(0.85,0.85,0.85), Grip=CFrame.new(0,-1.75,0.1,1,0,0,0,1,0,0,0,1) },
    ["Heart Wand"] = { MeshId="rbxassetid://77738838473091", TextureId="rbxthumb://type=Asset&w=150&h=150&id=118334707962654", MeshTextureId="rbxassetid://76246633927299", Scale=Vector3.new(0.4327,3.3587,1.9187), Grip=CFrame.new(0,-0.839714766,0,1,0,0,0,1,0,0,0,1) },
    Xenoknife = { MeshId="rbxassetid://136619680236977", TextureId="rbxthumb://type=Asset&w=150&h=150&id=115021756767182", MeshTextureId="rbxassetid://113651973865393", Scale=Vector3.new(0.2041,3.9191,0.7431), Grip=CFrame.new(0,-1.10000062,0,1,0,0,0,1,0,0,0,1) },
}

local GUN_SKINS = {
    Default = nil,
    Harvester = { MeshId="rbxassetid://7775027413", TextureId="http://www.roblox.com/asset/?id=9804007978", MeshTextureId="http://www.roblox.com/asset/?id=7775245551", Scale=Vector3.new(0.06,0.05,0.05), Grip=CFrame.new(0.0292243715,-0.507249594,0.310436904,1,0,0,0,0.999958932,-0.00906371977,0,0.00906371977,0.999958932) },
    ["Blue Harvester"] = { MeshId="rbxassetid://7775027413", TextureId="http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=8194219645", MeshTextureId="http://www.roblox.com/asset/?id=8266618476", Scale=Vector3.new(0.06,0.05,0.05), Grip=CFrame.new(0.0292243715,-0.507249594,0.310436904,1,0,0,0,0.999958932,-0.00906371977,0,0.00906371977,0.999958932) },
    Gingerscope = { MeshId="rbxassetid://16433710373", TextureId="rbxassetid://15762111158", MeshTextureId="rbxassetid://15374605641", Scale=Vector3.new(0.8,0.8,0.8), Grip=CFrame.new(0.821904778,-0.442081273,-0.0410000011,-0.0246282816,0,0.999696672,0,1,0,-0.999696672,0,-0.0246282816) },
    Icepiercer = { MeshId="rbxassetid://11868991644", TextureId="http://www.roblox.com/asset/?id=11906129752", MeshTextureId="rbxassetid://11869075814", Scale=Vector3.new(0.06,0.05,0.05), Grip=CFrame.new(0.0292243715,-0.507249594,0.310436904,1,0,0,0,0.999958932,-0.00906371977,0,0.00906371977,0.999958932) },
    Luger = { MeshId="http://www.roblox.com/asset/?id=95356090", TextureId="http://www.roblox.com/asset/?id=6708655509", MeshTextureId="http://www.roblox.com/asset/?id=126534866", Scale=Vector3.new(1.8,1.8,1.8), Grip=CFrame.new(0.0292243715,-0.507249594,0.310436904,1,0,0,0,0.999958932,-0.00906371977,0,0.00906371977,0.999958932) },
    Sugar = { MeshId="http://www.roblox.com/asset/?id=101086719", TextureId="rbxassetid://6662873651", MeshTextureId="http://www.roblox.com/asset/?id=101086650", Scale=Vector3.new(0.6,0.6,0.533), Grip=CFrame.new(0.0292243715,-0.507249594,0.310436904,1,0,0,0,0.999958932,-0.00906371977,0,0.00906371977,0.999958932) },
    Laser = { MeshId="http://www.roblox.com/asset/?id=130099641", TextureId="http://www.roblox.com/asset/?id=7186872887", MeshTextureId="rbxassetid://209727730", Scale=Vector3.new(0.65,0.65,0.65), Grip=CFrame.new(0.0292243715,-0.507249594,0.310436904,1,0,0,0,0.999958932,-0.00906371977,0,0.00906371977,0.999958932) },
    Blossom = { MeshId="rbxassetid://12322809632", TextureId="http://www.roblox.com/asset/?id=12382024612", MeshTextureId="rbxassetid://12322809917", Scale=Vector3.new(0.04,0.04,0.04), Grip=CFrame.new(0.0292243715,-0.507249594,0.310436904,1,0,0,0,0.999958932,-0.00906371977,0,0.00906371977,0.999958932) },
    Darkbringer = { MeshId="rbxassetid://4730813852", TextureId="http://www.roblox.com/asset/?id=6484450324", MeshTextureId="rbxassetid://4728494788", Scale=Vector3.new(0.043,0.035,0.035), Grip=CFrame.new(0.0292243715,-0.507249594,0.310436904,1,0,0,0,0.999958932,-0.00906371977,0,0.00906371977,0.999958932) },
    Lightbringer = { MeshId="rbxassetid://4730813852", TextureId="http://www.roblox.com/asset/?id=6229048362", MeshTextureId="rbxassetid://4728487789", Scale=Vector3.new(0.043,0.035,0.035), Grip=CFrame.new(0.0292243715,-0.507249594,0.310436904,1,0,0,0,0.999958932,-0.00906371977,0,0.00906371977,0.999958932) },
    Shotgun = { MeshId="http://www.roblox.com/asset/?id=94219391", TextureId="http://www.roblox.com/asset/?id=94252022", MeshTextureId="http://www.roblox.com/asset/?id=94219470", Scale=Vector3.new(0.75,0.75,0.75), Grip=CFrame.new(0.132808685,0.00749024749,0.526850462,0.925214171,0.000458391383,0.379444987,0.00858831592,0.999717772,-0.0221489165,-0.379348069,0.0237512868,0.924949169) },
    Flintlock = { MeshId="http://www.roblox.com/asset/?id=13508017", TextureId="http://www.roblox.com/asset/?id=16973563", MeshTextureId="http://www.roblox.com/asset/?id=16971396", Scale=Vector3.new(1.5,1.5,1.5), Grip=CFrame.new(0,-0.699999988,-0.200000003,1,0,0,0,0,-1,0,1,0) },
    ["Ultra Violet Laser Rifle"] = { MeshId="http://www.roblox.com/asset/?id=280037291", TextureId="http://www.roblox.com/asset/?id=280037478", MeshTextureId="http://www.roblox.com/asset/?id=280037426", Scale=Vector3.new(0.85,0.85,0.85), Grip=CFrame.new(0.100000001,-0.400000006,1.25,0.850807786,0,0.525476992,0,1,0,-0.525476992,0,0.850807786) },
}

local skinOriginals = { knife = nil, gun = nil }

local function applyKnifeSkin(skinName)
    ChaosFlags.SkinChanger_Knife = skinName
    local char = lp.Character
    if not char then return end
    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Tool") and (obj.Name:lower():find("knife") or obj.Name == "MM2_Knife") then
            local handle = obj:FindFirstChild("Handle")
            if not handle then break end
            local mesh = handle:FindFirstChildOfClass("SpecialMesh")
            if not mesh then break end
            if not skinOriginals.knife then
                skinOriginals.knife = {
                    MeshId = mesh.MeshId,
                    MeshTextureId = mesh.TextureId,
                    Scale = mesh.Scale,
                }
            end
            if skinName == "Default" then
                if skinOriginals.knife then
                    mesh.MeshId   = skinOriginals.knife.MeshId
                    mesh.TextureId = skinOriginals.knife.MeshTextureId
                    mesh.Scale    = skinOriginals.knife.Scale
                end
            else
                local skin = KNIFE_SKINS[skinName]
                if skin then
                    mesh.MeshId   = skin.MeshId
                    mesh.TextureId = skin.MeshTextureId
                    mesh.Scale    = skin.Scale
                end
            end
            break
        end
    end
end

local function applyGunSkin(skinName)
    ChaosFlags.SkinChanger_Gun = skinName
    local char = lp.Character
    if not char then return end
    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Tool") and (obj.Name:lower():find("gun") or obj.Name:lower():find("sheriff") or obj.Name == "MM2_Gun") then
            local handle = obj:FindFirstChild("Handle")
            if not handle then break end
            local mesh = handle:FindFirstChildOfClass("SpecialMesh")
            if not mesh then break end
            if not skinOriginals.gun then
                skinOriginals.gun = {
                    MeshId        = mesh.MeshId,
                    MeshTextureId = mesh.TextureId,
                    Scale         = mesh.Scale,
                    ToolTexture   = obj.TextureId,
                    Grip          = obj.Grip,
                    HandleSize    = handle.Size,
                }
            end
            if skinName == "Default" then
                if skinOriginals.gun then
                    mesh.MeshId    = skinOriginals.gun.MeshId
                    mesh.TextureId = skinOriginals.gun.MeshTextureId
                    mesh.Scale     = skinOriginals.gun.Scale
                    obj.TextureId  = skinOriginals.gun.ToolTexture
                    obj.Grip       = skinOriginals.gun.Grip
                    handle.Size    = skinOriginals.gun.HandleSize
                end
            else
                local skin = GUN_SKINS[skinName]
                if skin then
                    mesh.MeshId    = skin.MeshId
                    mesh.TextureId = skin.MeshTextureId
                    mesh.Scale     = skin.Scale
                    obj.TextureId  = skin.TextureId
                    obj.Grip       = skin.Grip
                end
            end
            break
        end
    end
end

local skinWatchConn = nil
local function startSkinWatcher()
    if skinWatchConn then skinWatchConn:Disconnect() skinWatchConn = nil end
    local char = lp.Character
    if not char then return end
    skinWatchConn = char.ChildAdded:Connect(function(child)
        task.wait(0.05)
        if child:IsA("Tool") then
            local kn = ChaosFlags.SkinChanger_Knife
            if kn and kn ~= "Default" and child.Name:lower():find("knife") then
                applyKnifeSkin(kn)
            end
            local gn = ChaosFlags.SkinChanger_Gun
            if gn and gn ~= "Default" and (child.Name:lower():find("gun") or child.Name:lower():find("sheriff")) then
                applyGunSkin(gn)
            end
        end
    end)
end

addConn(lp.CharacterAdded:Connect(function()
    skinOriginals.knife = nil
    skinOriginals.gun   = nil
    task.wait(1)
    startSkinWatcher()
end))
startSkinWatcher()

local function newDrawing(class, props)
    local d = Drawing.new(class)
    for k, v in pairs(props) do d[k] = v end
    table.insert(ChaosDrawings, d)
    return d
end

local function getRoleOf(player)
    if roleData[player.Name] then
        return roleData[player.Name].Role or "Innocent"
    end
    local char = player.Character
    if not char then return "Innocent" end
    local bp = player:FindFirstChildOfClass("Backpack")
    if char:FindFirstChild("Knife") or (bp and bp:FindFirstChild("Knife")) then return "Murderer" end
    if char:FindFirstChild("Gun") or (bp and bp:FindFirstChild("Gun")) then return "Sheriff" end
    return "Innocent"
end

local function getMurderer()
    for _, pl in ipairs(Players:GetPlayers()) do
        if getRoleOf(pl) == "Murderer" then return pl end
    end
end

local function getSheriff()
    for _, pl in ipairs(Players:GetPlayers()) do
        if getRoleOf(pl) == "Sheriff" then return pl end
    end
end

local function myRole()
    return getRoleOf(lp)
end

local function getHRP(player)
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local function getHum(player)
    return player.Character and player.Character:FindFirstChildOfClass("Humanoid")
end

local function isAlive(player)
    local h = getHum(player)
    return h and h.Health > 0
end

local function espColorFor(player)
    local ec = ChaosFlags.espColors
    local r = getRoleOf(player)
    if r == "Murderer" then return ec.murderer end
    if r == "Sheriff" then return ec.sheriff end
    return ec.innocent
end

pcall(function()
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local gameplay = remotes and remotes:FindFirstChild("Gameplay")
    local pdc = gameplay and gameplay:FindFirstChild("PlayerDataChanged")
    if pdc and pdc:IsA("RemoteEvent") then
        addConn(pdc.OnClientEvent:Connect(function(data)
            if type(data) == "table" then
                for name, info in pairs(data) do
                    roleData[name] = info
                end
            end
        end))
    end
end)

local ROLEBOX = { conns = {} }
ROLEBOX.hideBox = function(obj)
    if not obj:IsA("BoxHandleAdornment") then return end
    obj.Visible = false
    table.insert(ROLEBOX.conns, obj:GetPropertyChangedSignal("Visible"):Connect(function()
        if obj.Visible and ChaosFlags["Toggle_RoleBoxHide"] then obj.Visible = false end
    end))
end
ROLEBOX.watchChar = function(char)
    for _, d in ipairs(char:GetDescendants()) do ROLEBOX.hideBox(d) end
    table.insert(ROLEBOX.conns, char.DescendantAdded:Connect(ROLEBOX.hideBox))
end
ROLEBOX.start = function()
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl.Character then ROLEBOX.watchChar(pl.Character) end
        table.insert(ROLEBOX.conns, pl.CharacterAdded:Connect(ROLEBOX.watchChar))
    end
    table.insert(ROLEBOX.conns, Players.PlayerAdded:Connect(function(pl)
        table.insert(ROLEBOX.conns, pl.CharacterAdded:Connect(ROLEBOX.watchChar))
    end))
end
ROLEBOX.stop = function()
    for _, c in ipairs(ROLEBOX.conns) do pcall(function() c:Disconnect() end) end
    ROLEBOX.conns = {}
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl.Character then
            for _, d in ipairs(pl.Character:GetDescendants()) do
                if d:IsA("BoxHandleAdornment") then d.Visible = true end
            end
        end
    end
end

local espBoxes = {}
local function espBoxFor(player)
    if not espBoxes[player] then
        espBoxes[player] = {
            box   = newDrawing("Square", {Visible=false, Thickness=1.5, Filled=false}),
            name  = newDrawing("Text", {Visible=false, Size=13, Center=true, Outline=true, OutlineColor=Color3.new()}),
        }
    end
    return espBoxes[player]
end

local tracerFrames = {}
local function tracerSlotFor(player)
    if not tracerFrames[player] then
        tracerFrames[player] = {
            line = newDrawing("Line", {Visible=false, Thickness=1.2}),
            dist = newDrawing("Text", {Visible=false, Size=12, Center=true, Outline=true, OutlineColor=Color3.new()}),
            arw  = newDrawing("Text", {Visible=false, Size=24, Center=true, Outline=true, OutlineColor=Color3.new(), Text="▲"}),
        }
    end
    return tracerFrames[player]
end

local coinESP = {}
local trapESP = {}

addConn(RunService.RenderStepped:Connect(function()
    local vp = cam.ViewportSize
    local w, h = vp.X, vp.Y
    local cx, cy = w * 0.5, h * 0.5
    local radius = math.min(w, h) * 0.33

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl == lp then
            local slot = tracerFrames[pl]
            if slot then
                slot.line.Visible = false
                slot.dist.Visible = false
                slot.arw.Visible  = false
            end
            local b = espBoxes[pl]
            if b then
                b.box.Visible  = false
                b.name.Visible = false
            end
        end
    end

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl == lp then continue end
        local hrp = getHRP(pl)
        local hum = getHum(pl)
        local alive = hrp and hum and hum.Health > 0

        local b = espBoxes[pl]
        if b then
            if alive and ChaosFlags["Toggle_ESP"] then
                local topPos, topVis = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.8, 0))
                local botPos = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 2.8, 0))
                local col = espColorFor(pl)
                local bh = math.abs(topPos.Y - botPos.Y)
                local bw = bh * 0.5
                b.box.Color    = col
                b.box.Size     = Vector2.new(bw, bh)
                b.box.Position = Vector2.new(topPos.X - bw * 0.5, topPos.Y)
                b.box.Visible  = topVis and topPos.Z > 0
            else
                b.box.Visible = false
            end
            if alive and ChaosFlags["Toggle_ESPNames"] then
                local hp, hv = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3.5, 0))
                b.name.Color    = espColorFor(pl)
                b.name.Text     = pl.DisplayName
                b.name.Position = Vector2.new(hp.X, hp.Y)
                b.name.Visible  = hv and hp.Z > 0
            else
                b.name.Visible = false
            end
        end

        local slot = tracerFrames[pl]
        if slot then
            local anyTracer = ChaosFlags["Toggle_Tracers"] or ChaosFlags["Toggle_TracerDist"] or ChaosFlags["Toggle_Arrows"]
            if alive and anyTracer then
                local sp, sv = cam:WorldToViewportPoint(hrp.Position)
                local behindCam = sp.Z <= 0
                local onScreen  = sv and not behindCam
                local col = espColorFor(pl)
                local myHRP = getHRP(lp)

                if ChaosFlags["Toggle_Tracers"] and onScreen then
                    slot.line.From    = Vector2.new(cx, h)
                    slot.line.To      = Vector2.new(sp.X, sp.Y)
                    slot.line.Color   = col
                    slot.line.Visible = true
                else
                    slot.line.Visible = false
                end

                if ChaosFlags["Toggle_TracerDist"] and onScreen then
                    local dist = myHRP and math.floor((myHRP.Position - hrp.Position).Magnitude + 0.5) or 0
                    local dp, _ = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.2, 0))
                    slot.dist.Text     = dist .. "m"
                    slot.dist.Color    = col
                    slot.dist.Position = Vector2.new(dp.X, dp.Y)
                    slot.dist.Visible  = true
                else
                    slot.dist.Visible = false
                end

                if ChaosFlags["Toggle_Arrows"] and not onScreen then
                    local dx = sp.X - cx
                    local dy = sp.Y - cy
                    if behindCam then dx = -dx dy = -dy end
                    local mag = math.sqrt(dx*dx + dy*dy)
                    if mag < 1 then dx = 0 dy = -1 mag = 1 end
                    slot.arw.Color    = col
                    slot.arw.Position = Vector2.new(cx + dx/mag * radius, cy + dy/mag * radius)
                    slot.arw.Rotation = math.deg(math.atan2(dy, dx)) + 90
                    slot.arw.Visible  = true
                else
                    slot.arw.Visible = false
                end
            else
                if slot then
                    slot.line.Visible = false
                    slot.dist.Visible = false
                    slot.arw.Visible  = false
                end
            end
        end
    end

    for obj, drawing in pairs(coinESP) do
        if not ChaosFlags["Toggle_CoinESP"] or not obj or not obj.Parent or obj:GetAttribute("Collected") then
            drawing.Visible = false
        else
            local p, vis = cam:WorldToViewportPoint(obj.Position)
            drawing.Color    = ChaosFlags.espColors.coin
            drawing.Text     = "● C"
            drawing.Position = Vector2.new(p.X, p.Y)
            drawing.Visible  = vis and p.Z > 0
        end
    end

    for obj, drawing in pairs(trapESP) do
        if not ChaosFlags["Toggle_TrapESP"] or not obj or not obj.Parent then
            drawing.Visible = false
        else
            local p, vis = cam:WorldToViewportPoint(obj.Position)
            drawing.Color    = ChaosFlags.espColors.trap
            drawing.Text     = "⚠ TRAP"
            drawing.Position = Vector2.new(p.X, p.Y)
            drawing.Visible  = vis and p.Z > 0
        end
    end

    if ChaosFlags["Toggle_GunESP"] then
        for _, desc in ipairs(Workspace:GetDescendants()) do
            if desc.Name == "GunDrop" and (desc:IsA("BasePart") or desc:IsA("Model")) then
                local part = desc:IsA("BasePart") and desc or desc.PrimaryPart
                if part then
                    local p, vis = cam:WorldToViewportPoint(part.Position)
                    if vis and p.Z > 0 then end
                end
            end
        end
    end

    if ChaosFlags["Toggle_Crosshair"] then
        local sz = ChaosFlags["Slider_CrosshairSize"] or 8
        if not _G.ChaosCrosshair then
            _G.ChaosCrosshair = newDrawing("Square", {Filled=false, Thickness=1.5, Color=ACCENT})
        end
        _G.ChaosCrosshair.Size     = Vector2.new(sz * 2, sz * 2)
        _G.ChaosCrosshair.Position = Vector2.new(cx - sz, cy - sz)
        _G.ChaosCrosshair.Visible  = true
    elseif _G.ChaosCrosshair then
        _G.ChaosCrosshair.Visible = false
    end
end))

addConn(Workspace.DescendantAdded:Connect(function(d)
    if ChaosFlags["Toggle_CoinESP"] and (d.Name == "Coin" or d.Name == "Coin_Server") and d:IsA("BasePart") then
        if not coinESP[d] then
            coinESP[d] = newDrawing("Text", {Visible=false, Size=13, Center=true, Outline=true, OutlineColor=Color3.new()})
        end
    end
    if ChaosFlags["Toggle_TrapESP"] and d.Name == "Trap" and d:IsA("BasePart") then
        if not trapESP[d] then
            trapESP[d] = newDrawing("Text", {Visible=false, Size=13, Center=true, Outline=true, OutlineColor=Color3.new()})
        end
    end
    if d.Name == "GunDrop" and tick() - lastGunNotify > 3 then
        lastGunNotify = tick()
        playSfx("gun")
    end
end))

local function scanCoins()
    for _, d in ipairs(Workspace:GetDescendants()) do
        if (d.Name == "Coin" or d.Name == "Coin_Server") and d:IsA("BasePart") and not coinESP[d] then
            coinESP[d] = newDrawing("Text", {Visible=false, Size=13, Center=true, Outline=true, OutlineColor=Color3.new()})
        end
        if d.Name == "Trap" and d:IsA("BasePart") and not trapESP[d] then
            trapESP[d] = newDrawing("Text", {Visible=false, Size=13, Center=true, Outline=true, OutlineColor=Color3.new()})
        end
    end
end

addConn(RunService.Stepped:Connect(function()
    if ChaosFlags["Toggle_Noclip"] then
        local char = lp.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end
    if ChaosFlags["Toggle_BunnyHop"] then
        local char = lp.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            if hum:GetState() == Enum.HumanoidStateType.Landed then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
    if ChaosFlags["Toggle_KnifeReach"] then
        local char = lp.Character
        if char then
            local knife = char:FindFirstChild("Knife") or (lp:FindFirstChildOfClass("Backpack") and lp:FindFirstChildOfClass("Backpack"):FindFirstChild("Knife"))
            if knife then
                local blade = knife:FindFirstChild("Blade")
                if blade and blade:IsA("BasePart") then
                    local sz = ChaosFlags["Slider_KnifeReach"] or 6
                    blade.Size = Vector3.new(blade.Size.X, blade.Size.Y, sz)
                end
            end
        end
    end
    if ChaosFlags["Toggle_HitboxExp"] then
        local sz = ChaosFlags["Slider_HitboxSize"] or 8
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= lp then
                local hrp = getHRP(pl)
                if hrp then hrp.Size = Vector3.new(sz, sz, sz) end
            end
        end
    end
end))

addConn(RunService.Heartbeat:Connect(function()
    if ChaosFlags["Toggle_GodMode"] then
        local char = lp.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = hum.MaxHealth end
    end
    if ChaosFlags["Toggle_AntiAFK"] then
        if tick() % 60 < 0.05 then
            pcall(function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game) end)
        end
    end
end))

addConn(UserInputService.JumpRequest:Connect(function()
    if not ChaosFlags["Toggle_InfJump"] then return end
    local hum = getHum(lp)
    if hum and hum:GetState() ~= Enum.HumanoidStateType.Jumping then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end))

local flyBV, flyBG
local function startFly()
    local char = lp.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    if flyBV then flyBV:Destroy() end
    if flyBG then flyBG:Destroy() end
    flyBV = Instance.new("BodyVelocity")
    flyBV.Name       = "ChaosFlySV"
    flyBV.Velocity   = Vector3.zero
    flyBV.MaxForce   = Vector3.new(math.huge, math.huge, math.huge)
    flyBV.Parent     = hrp
    flyBG = Instance.new("BodyGyro")
    flyBG.Name       = "ChaosFlyBG"
    flyBG.P          = 90000
    flyBG.MaxTorque  = Vector3.new(9e9, 9e9, 9e9)
    flyBG.CFrame     = hrp.CFrame
    flyBG.Parent     = hrp
    hum.PlatformStand = true
end
local function stopFly()
    if flyBV then pcall(function() flyBV:Destroy() end) flyBV = nil end
    if flyBG then pcall(function() flyBG:Destroy() end) flyBG = nil end
    local hum = getHum(lp)
    if hum then hum.PlatformStand = false end
end
addConn(RunService.Heartbeat:Connect(function()
    if not ChaosFlags["Toggle_Fly"] then return end
    if not flyBV or not flyBG then return end
    local spd = ChaosFlags["Slider_FlySpeed"] or 50
    flyBG.CFrame = cam.CFrame
    local dir = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space)      then dir = dir + Vector3.new(0,1,0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)  then dir = dir - Vector3.new(0,1,0) end
    flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * spd or Vector3.zero
end))

addConn(lp.CharacterAdded:Connect(function()
    if ChaosFlags["Toggle_Fly"] then
        task.wait(0.2)
        pcall(startFly)
    end
    local hum = getHum(lp)
    if hum then
        if ChaosFlags["Slider_WalkSpeed"] ~= 16 then
            hum.WalkSpeed = ChaosFlags["Slider_WalkSpeed"] or 16
        end
        if ChaosFlags["Slider_JumpPower"] ~= 50 then
            hum.JumpPower    = ChaosFlags["Slider_JumpPower"] or 50
            hum.UseJumpPower = true
        end
    end
end))

local velConn
addConn(RunService.Heartbeat:Connect(function()
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp then
            local hrp = getHRP(pl)
            if hrp then
                local prev = velTrack[pl]
                if prev then
                    velTrack[pl] = { v = hrp.Velocity, pos = hrp.Position }
                else
                    velTrack[pl] = { v = Vector3.zero, pos = hrp.Position }
                end
            end
        end
    end
end))

local function AimAt(target, thrp)
    local hum2 = getHum(target)
    local vel  = Vector3.zero
    if hum2 and hum2.MoveDirection.Magnitude > 0.1 then
        vel = hum2.MoveDirection.Unit * hum2.WalkSpeed
    else
        local vd = velTrack[target]
        if vd and vd.v.Magnitude >= 0.5 then vel = vd.v end
    end
    if vel.Magnitude < 0.5 then return thrp.Position end
    local lt        = ChaosFlags["Slider_LeadTime"] or 0.14
    local predicted = thrp.Position + Vector3.new(vel.X, 0, vel.Z) * lt
    local delta     = predicted - thrp.Position
    if delta.Magnitude > 8 then predicted = thrp.Position + delta.Unit * 8 end
    return predicted
end

local function wallCheck(from, to)
    local dir    = (to - from)
    local result = Workspace:Raycast(from, dir, RaycastParams.new())
    if not result then return true end
    local hit = result.Instance
    if hit and hit.Parent and Players:GetPlayerFromCharacter(hit.Parent) then return true end
    return false
end

local function fireSilentGun(aimPos)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local gameplay = remotes and remotes:FindFirstChild("Gameplay")
    local shoot    = gameplay and gameplay:FindFirstChild("Shoot")
    if not shoot then return end
    local hrp = getHRP(lp)
    if not hrp then return end
    local attachCF = CFrame.new(hrp.Position) * CFrame.Angles(0, math.atan2(-(aimPos.X - hrp.Position.X), -(aimPos.Z - hrp.Position.Z)), 0)
    shoot:FireServer(attachCF, CFrame.new(aimPos))
end

local function fireSilentKnife(aimPos)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local gameplay = remotes and remotes:FindFirstChild("Gameplay")
    local throw    = gameplay and gameplay:FindFirstChild("Throw")
    if not throw then return end
    local hrp = getHRP(lp)
    if not hrp then return end
    throw:FireServer(CFrame.new(hrp.Position), CFrame.new(aimPos))
end

addConn(UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    local role = myRole()
    if ChaosFlags["Toggle_SilentAim"] and role == "Sheriff" then
        local best, bestDist = nil, math.huge
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= lp and isAlive(pl) then
                local hrp = getHRP(pl)
                if hrp then
                    local sp, vis = cam:WorldToViewportPoint(hrp.Position)
                    if vis and sp.Z > 0 then
                        local vp = cam.ViewportSize
                        local dx, dy = sp.X - vp.X*0.5, sp.Y - vp.Y*0.5
                        local d2 = dx*dx + dy*dy
                        if d2 < bestDist then
                            bestDist = d2
                            best = pl
                        end
                    end
                end
            end
        end
        if best then
            local thrp = getHRP(best)
            if thrp then
                local aimPos = AimAt(best, thrp)
                if wallCheck(getHRP(lp).Position, aimPos) then
                    fireSilentGun(aimPos)
                end
            end
        end
    end
    if ChaosFlags["Toggle_SilentThrow"] and role == "Murderer" then
        local best, bestDist = nil, math.huge
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= lp and isAlive(pl) then
                local hrp = getHRP(pl)
                if hrp then
                    local sp, vis = cam:WorldToViewportPoint(hrp.Position)
                    if vis and sp.Z > 0 then
                        local vp = cam.ViewportSize
                        local dx, dy = sp.X - vp.X*0.5, sp.Y - vp.Y*0.5
                        local d2 = dx*dx + dy*dy
                        if d2 < bestDist then
                            bestDist = d2
                            best = pl
                        end
                    end
                end
            end
        end
        if best then
            local thrp = getHRP(best)
            if thrp then
                local aimPos = AimAt(best, thrp)
                fireSilentKnife(aimPos)
            end
        end
    end
end))

local function killAll()
    local remotes  = ReplicatedStorage:FindFirstChild("Remotes")
    local gameplay = remotes and remotes:FindFirstChild("Gameplay")
    local shoot    = gameplay and gameplay:FindFirstChild("Shoot")
    if not shoot then return end
    local myHRP = getHRP(lp)
    if not myHRP then return end
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp and isAlive(pl) then
            local hrp = getHRP(pl)
            if hrp then
                local attachCF = CFrame.new(myHRP.Position) * CFrame.Angles(0, math.atan2(-(hrp.Position.X - myHRP.Position.X), -(hrp.Position.Z - myHRP.Position.Z)), 0)
                shoot:FireServer(attachCF, CFrame.new(hrp.Position))
                task.wait(0.1)
            end
        end
    end
end

local function SkidFling(target)
    if not target or not target.Character then return end
    local char  = lp.Character
    if not char then return end
    local hum   = char:FindFirstChildOfClass("Humanoid")
    local hrp   = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end
    local char2  = target.Character
    local hum2   = char2:FindFirstChildOfClass("Humanoid")
    local hrp2   = hum2 and hum2.RootPart
    local head2  = char2:FindFirstChild("Head")
    if not hum2 then return end
    local saveCF = hrp.CFrame
    local origFPDH = Workspace.FallenPartsDestroyHeight
    local origHP   = hum.Health
    cam.CameraSubject = head2 or hum2
    local bv = Instance.new("BodyVelocity")
    bv.Name      = "ChaosSkidFlingBV"
    bv.Velocity  = Vector3.zero
    bv.MaxForce  = Vector3.new(math.huge, math.huge, math.huge)
    bv.Parent    = hrp
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    Workspace.FallenPartsDestroyHeight = 0/0
    local n       = 0
    local now     = tick()
    local flingPart = hrp2 or head2
    if flingPart then
        while tick() - now < 2 do
            if not flingPart.Parent or not char.Parent then break end
            if hum2.Sit then break end
            n = n + 100
            hrp.CFrame = CFrame.new(flingPart.Position) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(n), 0, 0)
            hrp.Velocity    = Vector3.new(90000000, 900000000, 90000000)
            hrp.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
            task.wait()
            if flingPart.Velocity.Magnitude > 500 then break end
        end
    end
    bv:Destroy()
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    Workspace.FallenPartsDestroyHeight = origFPDH
    cam.CameraSubject = hum
    for i = 1, 30 do
        hrp.CFrame = saveCF * CFrame.new(0, 0.5, 0)
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        task.wait()
        if (hrp.Position - saveCF.p).Magnitude < 20 then break end
    end
end

local spamFlingConn
local function startSpamFling(target)
    if spamFlingConn then spamFlingConn:Disconnect() spamFlingConn = nil end
    spamFlingConn = RunService.Heartbeat:Connect(function()
        if not ChaosFlags["Toggle_SpamFling"] then
            if spamFlingConn then spamFlingConn:Disconnect() spamFlingConn = nil end
            return
        end
        if target and target.Character then
            local hrp = getHRP(lp)
            local thrp = getHRP(target)
            if hrp and thrp then
                hrp.CFrame    = thrp.CFrame * CFrame.new(0, 0, 0.5)
                hrp.Velocity  = Vector3.new(math.random(-500,500), math.random(500,2000), math.random(-500,500))
                thrp.Velocity = Vector3.new(math.random(-500,500), math.random(500,2000), math.random(-500,500))
            end
        end
    end)
    addConn(spamFlingConn)
end

local flingAllConn
local function startFlingAll()
    if flingAllConn then flingAllConn:Disconnect() flingAllConn = nil end
    ChaosFlags.FlingAllRunning = true
    task.spawn(function()
        while ChaosFlags["Toggle_FlingAll"] do
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= lp and isAlive(pl) then
                    pcall(SkidFling, pl)
                    task.wait(0.3)
                end
            end
            task.wait(0.5)
        end
        ChaosFlags.FlingAllRunning = false
    end)
end

local farmData = {
    active        = false,
    map           = nil,
    lastMap       = nil,
    alive         = false,
    sawCoins      = false,
    flingDoneFired= false,
    killFired     = false,
    activeCoin    = nil,
    activeTween   = nil,
    stuckCoin     = nil,
    stuckTime     = 0,
    bodyGyro      = nil,
    bodyVelo      = nil,
    farmClipWas   = {},
}

local function getPlayerData()
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local extras  = remotes and remotes:FindFirstChild("Extras")
    local gpd     = extras and extras:FindFirstChild("GetPlayerData")
    if not gpd then return nil end
    local ok, r = pcall(function() return gpd:InvokeServer() end)
    return ok and r or nil
end

local function getFarmMap()
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:FindFirstChild("CoinAreas") or v:FindFirstChild("CoinContainer") then
            return v
        end
    end
end

local function getFarmCoinCount()
    local ok, v = pcall(function()
        local container
        local mg = lp:FindFirstChild("PlayerGui")
        mg = mg and mg:FindFirstChild("MainGUI")
        local game_ = mg and mg:FindFirstChild("Game")
        if game_ then
            container = game_:FindFirstChild("CoinBags") and game_.CoinBags:FindFirstChild("Container")
        end
        if not container then return 0 end
        for _, cb in ipairs(container:GetChildren()) do
            if cb:IsA("GuiObject") and cb:FindFirstChild("CurrencyFrame") and cb.Visible then
                local full = cb:FindFirstChild("Full")
                if full and full.Visible then return 999 end
                local cf = cb:FindFirstChild("CurrencyFrame")
                cf = cf and cf:FindFirstChild("Icon")
                cf = cf and cf:FindFirstChild("Coins")
                cf = cf and cf.Text
                if cf and (string.lower(cf):find("full") or string.lower(cf):find("max")) then return 999 end
                return tonumber(cf) or 0
            end
        end
        return 0
    end)
    return ok and v or 0
end

local function getFarmRoundTime()
    local rtp = Workspace:FindFirstChild("RoundTimerPart")
    if rtp then return tonumber(rtp:GetAttribute("Time")) or 0 end
    return 0
end

local function getNearestCoin(map, hrpPos)
    local cc = map:FindFirstChild("CoinContainer")
    if not cc then return nil end
    local best, bestDist = nil, math.huge
    for _, c in ipairs(cc:GetChildren()) do
        if (c.Name == "Coin" or c.Name == "Coin_Server") and c:IsA("BasePart") and not c:GetAttribute("Collected") then
            local d = (hrpPos - c.Position).Magnitude
            if d < bestDist then
                bestDist = d
                best = c
            end
        end
    end
    return best
end

local function farmGetSpawnCF(map)
    local spawns = map:FindFirstChild("Spawns")
    if not spawns then return nil end
    for _, v in ipairs(spawns:GetChildren()) do
        if v:IsA("BasePart") then return v.CFrame end
    end
end

local function FarmAttachGyro(enable)
    local char = lp.Character
    if not char then return end
    local ut = char:FindFirstChild("UpperTorso")
    if not ut then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    if enable then
        if ut:FindFirstChild("ODH Auto Farm BodyGyro") then return end
        local cf = hrp.CFrame
        local targetCF = CFrame.new(cf.X, cf.Y, cf.Z) * CFrame.Angles(math.pi/2, 0, math.pi/2)
        local bg = Instance.new("BodyGyro")
        bg.Name       = "ODH Auto Farm BodyGyro"
        bg.P          = 90000
        bg.MaxTorque  = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame     = targetCF
        bg.Parent     = ut
        local bv = Instance.new("BodyVelocity")
        bv.Name      = "ODH Auto Farm BodyVelocity"
        bv.Velocity  = Vector3.zero
        bv.MaxForce  = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent    = ut
        hrp.CFrame   = targetCF
        hum.PlatformStand = true
        farmData.bodyGyro = bg
        farmData.bodyVelo = bv
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                farmData.farmClipWas[p] = p.CanCollide
                p.CanCollide = false
            end
        end
    else
        local bg = ut:FindFirstChild("ODH Auto Farm BodyGyro")
        local bv = ut:FindFirstChild("ODH Auto Farm BodyVelocity")
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
        if hum then
            hum.PlatformStand = false
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
        for p, was in pairs(farmData.farmClipWas) do
            pcall(function() if p and p.Parent then p.CanCollide = was end end)
        end
        farmData.farmClipWas = {}
        farmData.bodyGyro = nil
        farmData.bodyVelo = nil
    end
end

local function FarmHideUnderMap()
    local char = lp.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local map = farmData.map or getFarmMap()
    if not map then return end
    local spawnCF = farmGetSpawnCF(map)
    if not spawnCF then return end
    FarmAttachGyro(true)
    hrp.CFrame = CFrame.new(spawnCF.X, spawnCF.Y - 15, spawnCF.Z)
end

local function FarmFinish()
    if farmData.flingDoneFired then return end
    farmData.flingDoneFired = true
    FarmAttachGyro(false)
    if ChaosFlags["Toggle_FlingWhenDone"] then
        local murd = getMurderer()
        if murd then
            task.spawn(function() pcall(SkidFling, murd) end)
        end
    end
    if ChaosFlags["Toggle_KillWhenFull"] and not farmData.killFired then
        farmData.killFired = true
        local role = myRole()
        if role == "Sheriff" then
            task.spawn(killAll)
        end
    end
end

local function TeleportToSpawn()
    local map = farmData.map or getFarmMap()
    if not map then return end
    local spawnCF = farmGetSpawnCF(map)
    if not spawnCF then return end
    local hrp = getHRP(lp)
    if not hrp then return end
    FarmAttachGyro(false)
    hrp.Velocity   = Vector3.zero
    hrp.RotVelocity= Vector3.zero
    hrp.CFrame     = CFrame.new(spawnCF.X, spawnCF.Y + 5, spawnCF.Z)
    local hum = getHum(lp)
    if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
end

local farmHeartbeat
local function StartFarm()
    if farmHeartbeat then farmHeartbeat:Disconnect() farmHeartbeat = nil end
    farmData.active = true
    farmData.sawCoins = false
    farmData.flingDoneFired = false
    farmData.killFired = false
    farmData.activeCoin = nil
    farmData.lastMap = nil
    farmHeartbeat = RunService.Heartbeat:Connect(function()
        if not ChaosFlags["Toggle_AutoFarm"] then
            if farmHeartbeat then farmHeartbeat:Disconnect() farmHeartbeat = nil end
            FarmAttachGyro(false)
            return
        end
        pcall(function()
            local pd = getPlayerData()
            if pd then
                local me = pd[lp.Name]
                farmData.alive = me and not me.Dead and not me.Killed
            else
                local hum = getHum(lp)
                farmData.alive = hum and hum.Health > 0
            end

            local map = getFarmMap()
            if map ~= farmData.lastMap then
                farmData.lastMap      = map
                farmData.map          = map
                farmData.sawCoins     = false
                farmData.flingDoneFired = false
                farmData.killFired    = false
                farmData.activeCoin   = nil
                if farmData.activeTween then farmData.activeTween:Cancel() farmData.activeTween = nil end
            end

            local hrp = getHRP(lp)
            if not hrp then return end

            if not farmData.alive or not map then
                if farmData.activeTween then farmData.activeTween:Cancel() farmData.activeTween = nil end
                FarmAttachGyro(false)
                return
            end

            local coinCount = getFarmCoinCount()
            local elite = lp:GetAttribute("Elite")
            local threshold = elite and 50 or 40

            if getFarmRoundTime() > 0 then
                if coinCount >= threshold then
                    FarmFinish()
                    return
                end
                local coin = getNearestCoin(map, hrp.Position)
                if coin then
                    farmData.sawCoins = true
                    if coin ~= farmData.activeCoin or (farmData.activeCoin and farmData.activeCoin:GetAttribute("Collected")) then
                        farmData.activeCoin = coin
                        if farmData.activeTween then farmData.activeTween:Cancel() farmData.activeTween = nil end
                        FarmAttachGyro(true)
                        local dist     = (hrp.Position - coin.Position).Magnitude
                        local duration = math.clamp(dist / 23, 0.05, 15)
                        hrp.Velocity   = Vector3.zero
                        farmData.activeTween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
                            CFrame = CFrame.new(coin.Position.X, coin.Position.Y - 3.5, coin.Position.Z) * CFrame.Angles(math.pi/2, 0, math.pi/2)
                        })
                        farmData.activeTween:Play()
                    else
                        local dist = (hrp.Position - coin.Position).Magnitude
                        if dist <= 6 and not coin:GetAttribute("Collected") then
                            coin.CFrame = CFrame.new(hrp.Position + Vector3.new(math.random(-80,80)/100, math.random(-50,300)/100, math.random(-80,80)/100))
                        end
                    end
                elseif farmData.sawCoins then
                    FarmFinish()
                end
            else
                if farmData.activeTween then farmData.activeTween:Cancel() farmData.activeTween = nil end
                FarmAttachGyro(false)
                if not farmData.sawCoins and farmData.alive and map then
                    FarmHideUnderMap()
                end
            end
        end)
    end)
    addConn(farmHeartbeat)
end

local function StopFarm()
    ChaosFlags["Toggle_AutoFarm"] = false
    farmData.active = false
    if farmHeartbeat then farmHeartbeat:Disconnect() farmHeartbeat = nil end
    if farmData.activeTween then farmData.activeTween:Cancel() farmData.activeTween = nil end
    pcall(FarmAttachGyro, false)
end

local hopThread
local function StopFarmHopWatch()
    if hopThread then pcall(task.cancel, hopThread) hopThread = nil end
end
local function StartFarmHopWatch()
    StopFarmHopWatch()
    hopThread = task.spawn(function()
        local n = 0
        while true do
            task.wait(3)
            if not ChaosFlags["Toggle_FarmHop"] then n = 0 continue end
            local minP = ChaosFlags["Slider_FarmHopMin"] or 2
            if #Players:GetPlayers() >= minP then n = 0 continue end
            n = n + 3
            if n < 15 then continue end
            pcall(function() TeleportService:Teleport(PLACE_ID) end)
            task.wait(60)
            n = 0
        end
    end)
end

local function ServerHop()
    pcall(function() TeleportService:Teleport(PLACE_ID) end)
end

local function SmallestServerHop()
    task.spawn(function()
        local servers = {}
        local cursor  = ""
        local pages   = 0
        while pages < 5 do
            pages = pages + 1
            local url = "https://games.roblox.com/v1/games/" .. PLACE_ID .. "/servers/Public?sortOrder=Asc&limit=100"
            if cursor ~= "" then url = url .. "&cursor=" .. cursor end
            local ok, result = pcall(function()
                local body
                if syn and syn.request then
                    body = HttpService:JSONDecode(syn.request({Url=url,Method="GET"}).Body)
                elseif http and http.request then
                    body = HttpService:JSONDecode(http.request({Url=url,Method="GET"}).Body)
                elseif request then
                    body = HttpService:JSONDecode(request({Url=url,Method="GET"}).Body)
                elseif game.HttpGet then
                    body = HttpService:JSONDecode(game:HttpGet(url))
                end
                return body
            end)
            if not ok or not result or not result.data then break end
            for _, sv in ipairs(result.data) do
                if sv.id ~= JOB_ID and sv.playing and sv.maxPlayers and sv.playing < sv.maxPlayers then
                    table.insert(servers, sv)
                end
            end
            cursor = result.nextPageCursor or ""
            if cursor == "" then break end
        end
        if #servers == 0 then
            pcall(function() TeleportService:Teleport(PLACE_ID) end)
            return
        end
        table.sort(servers, function(a, b) return a.playing < b.playing end)
        pcall(function() TeleportService:TeleportToPlaceInstance(PLACE_ID, servers[1].id) end)
    end)
end

local shellsRunning = false
local function claimRewardPopup()
    local pg = lp:FindFirstChild("PlayerGui")
    if not pg then return false end
    local claim = nil
    local med   = nil
    local cp    = pg:FindFirstChild("CrossPlatform")
    local ni    = cp and cp:FindFirstChild("NewItem") and cp.NewItem:FindFirstChild("Medium")
    if ni and ni.Visible then
        claim = ni:FindFirstChild("Container") and ni.Container:FindFirstChild("Claim")
        med   = ni
    else
        local mg = pg:FindFirstChild("MainGUI")
        local gm = mg and mg:FindFirstChild("Game")
        ni = gm and gm:FindFirstChild("NewItem")
        if ni and ni.Visible then
            claim = ni:FindFirstChild("Container") and ni.Container:FindFirstChild("Claim")
            med = ni
        end
    end
    if not med or not claim then return false end
    if getconnections then
        for _, ev in ipairs({"Activated","MouseButton1Click"}) do
            local ok2, conns = pcall(getconnections, claim[ev])
            if ok2 and conns and #conns > 0 then
                for _, c in ipairs(conns) do pcall(function() c:Fire() end) end
                return true
            end
        end
    end
    local abs = claim.AbsolutePosition
    local sz  = claim.AbsoluteSize
    local mx  = abs.X + sz.X * 0.5
    local my  = abs.Y + sz.Y * 0.5 + 36
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(mx, my, 0, true, game, 1)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(mx, my, 0, false, game, 1)
    end)
    return true
end

local function StartShells()
    if shellsRunning then return end
    shellsRunning = true
    task.spawn(function()
        while ChaosFlags["Toggle_Shells"] do
            task.wait(0.5)
            pcall(claimRewardPopup)
        end
        shellsRunning = false
    end)
end

local BOXES = {
    {"Summer2026Box","Summer Box '26"},
    {"MysteryBox1","Mystery Box #1"},
    {"MysteryBox2","Mystery Box #2"},
    {"KnifeBox1","Knife Box #1"},
    {"KnifeBox2","Knife Box #2"},
    {"KnifeBox3","Knife Box #3"},
    {"KnifeBox4","Knife Box #4"},
    {"KnifeBox5","Knife Box #5"},
    {"GunBox1","Gun Box #1"},
    {"GunBox2","Gun Box #2"},
    {"GunBox3","Gun Box #3"},
    {"MLG Box","Rainbow Box"},
}
local BOX_CURRENCY = {Summer2026Box = "SummerKey2026"}
local boxOn = {}
local boxRunning = {}

local function openBox(boxId)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    remotes = remotes and remotes:FindFirstChild("Shop")
    remotes = remotes and remotes:FindFirstChild("OpenCrate")
    if not remotes then return nil, "remote gone" end
    local currency = BOX_CURRENCY[boxId] or "Coins"
    local ok, r = pcall(function() return remotes:InvokeServer(boxId, "MysteryBox", currency) end)
    return ok and r or nil, ok and nil or tostring(r)
end

local function startBox(boxId)
    if boxRunning[boxId] then return end
    boxRunning[boxId] = true
    task.spawn(function()
        while boxOn[boxId] do
            local result, err = openBox(boxId)
            if not result then
                boxOn[boxId] = false
                break
            end
            task.wait(1)
        end
        boxRunning[boxId] = false
    end)
end

local cfgPath = "chaos_mm2_config.json"
local function saveConfig()
    if not writefile then return end
    local data = {}
    for k, v in pairs(ChaosFlags) do
        if type(v) ~= "table" and type(v) ~= "function" then
            data[k] = v
        end
    end
    for role, col in pairs(ChaosFlags.espColors) do
        data["espColor_"..role] = {col.R, col.G, col.B}
    end
    pcall(function() writefile(cfgPath, HttpService:JSONEncode(data)) end)
end

local function loadConfig()
    if not readfile then return end
    local ok, raw = pcall(readfile, cfgPath)
    if not ok or not raw or raw == "" then return end
    local ok2, data = pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok2 or type(data) ~= "table" then return end
    for k, v in pairs(data) do
        if k:sub(1,9) == "espColor_" then
            local role = k:sub(10)
            if type(v) == "table" and #v == 3 then
                ChaosFlags.espColors[role] = Color3.fromRGB(v[1]*255, v[2]*255, v[3]*255)
            end
        elseif ChaosFlags[k] ~= nil then
            ChaosFlags[k] = v
        end
    end
end

loadConfig()

local fbOriginals = {}
local function setFullbright(on)
    if on then
        fbOriginals.Brightness    = Lighting.Brightness
        fbOriginals.ClockTime     = Lighting.ClockTime
        fbOriginals.FogEnd        = Lighting.FogEnd
        fbOriginals.GlobalShadows = Lighting.GlobalShadows
        Lighting.Brightness    = 2
        Lighting.ClockTime     = 14
        Lighting.FogEnd        = 100000
        Lighting.GlobalShadows = false
    else
        if fbOriginals.Brightness ~= nil then
            Lighting.Brightness    = fbOriginals.Brightness
            Lighting.ClockTime     = fbOriginals.ClockTime
            Lighting.FogEnd        = fbOriginals.FogEnd
            Lighting.GlobalShadows = fbOriginals.GlobalShadows
        end
    end
end

local function setInvisible(on)
    local char = lp.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.LocalTransparencyModifier = on and 1 or 0
        end
    end
end

local function grabGun()
    local myHRP = getHRP(lp)
    if not myHRP then return end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Tool") and (obj.Name == "Sheriff_Gun" or obj.Name == "GunDrop") then
            local handle = obj:FindFirstChild("Handle")
            if handle then
                myHRP.CFrame = handle.CFrame + Vector3.new(0, 2, 0)
                local cd = handle:FindFirstChildWhichIsA("ClickDetector")
                if cd then pcall(function() fireClickDetector(cd) end) end
                return
            end
        end
    end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" and (obj:IsA("BasePart") or obj:IsA("Model")) then
            local part = obj:IsA("BasePart") and obj or obj.PrimaryPart
            if part then
                myHRP.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                local cd = part:FindFirstChildWhichIsA("ClickDetector")
                if cd then pcall(function() fireClickDetector(cd) end) end
                return
            end
        end
    end
end

local function flingMurderer()
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp and getRoleOf(pl) == "Murderer" then
            pcall(SkidFling, pl)
            return
        end
    end
end

local function flingSheriff()
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp and getRoleOf(pl) == "Sheriff" then
            pcall(SkidFling, pl)
            return
        end
    end
end

local function stealGun()
    flingSheriff()
    task.wait(0.4)
    grabGun()
end

local touchFlingConn = nil
local function setupTouchFling()
    if touchFlingConn then touchFlingConn:Disconnect() touchFlingConn = nil end
    local myHRP = getHRP(lp)
    if not myHRP then return end
    touchFlingConn = myHRP.Touched:Connect(function(hit)
        if not ChaosFlags["Toggle_TouchFling"] then
            if touchFlingConn then touchFlingConn:Disconnect() touchFlingConn = nil end
            return
        end
        local char = hit.Parent
        local pl = Players:GetPlayerFromCharacter(char)
        if pl and pl ~= lp then pcall(SkidFling, pl) end
    end)
end

local function optimizeCoins()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "Coin" or obj.Name == "Coin_Server" then
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("ParticleEmitter") or child:IsA("PointLight") or child:IsA("BillboardGui") or child:IsA("SelectionSphere") then
                    child:Destroy()
                end
            end
        end
    end
end

local function removeTraps()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("trap") or obj.Name == "Bear") then
            pcall(function() obj:Destroy() end)
        end
    end
end

local function removeChroma()
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("ColorCorrectionEffect") or obj:IsA("BloomEffect") then
            pcall(function() obj:Destroy() end)
        end
    end
end

local function removePets()
    for _, pl in ipairs(Players:GetPlayers()) do
        local char = pl.Character
        if char then
            for _, obj in ipairs(char:GetChildren()) do
                if obj:IsA("Model") and not obj:FindFirstChildWhichIsA("Humanoid") then
                    pcall(function() obj:Destroy() end)
                end
            end
        end
    end
end

local function tpToMurderer()
    local myHRP = getHRP(lp)
    if not myHRP then return end
    local m = getMurderer()
    if m then
        local hrp = getHRP(m)
        if hrp then myHRP.CFrame = hrp.CFrame + Vector3.new(0, 3, 0) end
    end
end

local function tpToSheriff()
    local myHRP = getHRP(lp)
    if not myHRP then return end
    local s = getSheriff()
    if s then
        local hrp = getHRP(s)
        if hrp then myHRP.CFrame = hrp.CFrame + Vector3.new(0, 3, 0) end
    end
end

local function tpToGun()
    local myHRP = getHRP(lp)
    if not myHRP then return end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "Sheriff_Gun" or obj.Name == "GunDrop" then
            local part = obj:IsA("BasePart") and obj or obj:FindFirstChildOfClass("BasePart")
            if part then
                myHRP.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                return
            end
        end
    end
end

local function dropKnife()
    local char = lp.Character
    if not char then return end
    local hum = getHum(lp)
    if hum then
        hum:UnequipTools()
    end
end

local origGravity = Workspace.Gravity
local function setGravity(val)
    Workspace.Gravity = val
end

local function setFOV(val)
    cam.FieldOfView = val
end

local chamBoxes = {}
local function clearChams()
    for k, sb in pairs(chamBoxes) do
        pcall(function() sb:Destroy() end)
        chamBoxes[k] = nil
    end
end

local function updateChams()
    clearChams()
    if not ChaosFlags["Toggle_Chams"] then return end
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp and pl.Character then
            local sb = Instance.new("SelectionBox")
            sb.Adornee             = pl.Character
            sb.Color3              = espColorFor(pl)
            sb.LineThickness       = 0.07
            sb.SurfaceTransparency = 0.75
            sb.SurfaceColor3       = espColorFor(pl)
            sb.Parent              = Workspace
            chamBoxes[pl]          = sb
        end
    end
end

local fpsOriginals = {}
local function setFPSBoost(on)
    if on then
        pcall(function()
            fpsOriginals.quality = settings().Rendering.QualityLevel
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then
                obj.Enabled = false
            end
        end
        for _, obj in ipairs(Lighting:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then
                obj.Enabled = false
            end
        end
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            end
        end
    else
        pcall(function()
            if fpsOriginals.quality then
                settings().Rendering.QualityLevel = fpsOriginals.quality
            end
        end)
    end
end

local clickTPConn = nil
local function setupClickTP(on)
    if clickTPConn then clickTPConn:Disconnect() clickTPConn = nil end
    if not on then return end
    local mouse = lp:GetMouse()
    clickTPConn = mouse.Button1Down:Connect(function()
        if not ChaosFlags["Toggle_ClickTP"] then
            if clickTPConn then clickTPConn:Disconnect() clickTPConn = nil end
            return
        end
        local myHRP = getHRP(lp)
        if myHRP and mouse.Hit then
            myHRP.CFrame = mouse.Hit + Vector3.new(0, 3, 0)
        end
    end)
end

local function setHeadHitbox(on)
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp and pl.Character then
            local head = pl.Character:FindFirstChild("Head")
            if head and head:IsA("BasePart") then
                if on then
                    local sz = ChaosFlags["Slider_HitboxSize"] or 8
                    head.Size = Vector3.new(sz, sz, sz)
                end
            end
        end
    end
end

local rainbowHue = 0
local function updateRainbowESP()
    if not ChaosFlags["Toggle_RainbowESP"] then return end
    rainbowHue = (rainbowHue + 0.004) % 1
    local col = Color3.fromHSV(rainbowHue, 1, 1)
    ChaosFlags.espColors.innocent = col
    ChaosFlags.espColors.sheriff  = Color3.fromHSV((rainbowHue + 0.33) % 1, 1, 1)
    ChaosFlags.espColors.murderer = Color3.fromHSV((rainbowHue + 0.66) % 1, 1, 1)
end

local aimLockTarget = nil
local function murderAura()
    local myHRP = getHRP(lp)
    if not myHRP then return end
    local range = ChaosFlags["Slider_MurderAuraRange"] or 20
    local nearest, nearDist = nil, math.huge
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp then
            local hrp = getHRP(pl)
            if hrp then
                local d = (hrp.Position - myHRP.Position).Magnitude
                if d < range and d < nearDist then
                    nearDist = d
                    nearest  = pl
                end
            end
        end
    end
    if not nearest then return end
    local char = lp.Character
    if not char then return end
    local knife = char:FindFirstChild("Knife")
    if knife then
        local throwRemote = knife:FindFirstChildOfClass("RemoteEvent")
        if throwRemote then
            local hrp = getHRP(nearest)
            if hrp then
                pcall(function() throwRemote:FireServer(CFrame.new(hrp.Position)) end)
            end
        end
    end
end

local function sheriffAura()
    local myHRP = getHRP(lp)
    if not myHRP then return end
    local range = ChaosFlags["Slider_SheriffAuraRange"] or 80
    local char  = lp.Character
    if not char then return end
    local gun = char:FindFirstChild("Sheriff_Gun")
    if not gun then return end
    local shootRemote = gun:FindFirstChildOfClass("RemoteEvent")
    if not shootRemote then return end
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp and getRoleOf(pl) == "Murderer" then
            local hrp = getHRP(pl)
            if hrp then
                local d = (hrp.Position - myHRP.Position).Magnitude
                if d < range then
                    local cf = CFrame.new(myHRP.Position, hrp.Position)
                    pcall(function() shootRemote:FireServer(cf, CFrame.new(hrp.Position)) end)
                    return
                end
            end
        end
    end
end

local function freezePlayer(pl)
    local hrp = getHRP(pl)
    if not hrp then return end
    local bv = Instance.new("BodyVelocity")
    bv.Velocity        = Vector3.zero
    bv.MaxForce        = Vector3.new(1e9, 1e9, 1e9)
    bv.P               = 1e9
    bv.Parent          = hrp
    addConn(RunService.Heartbeat:Connect(function()
        if not ChaosFlags["Toggle_Freeze"] then
            pcall(function() bv:Destroy() end)
        end
    end))
end

local function copyLook(pl)
    local char = lp.Character
    local tchar = pl.Character
    if not char or not tchar then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local thum = tchar:FindFirstChildOfClass("Humanoid")
    if not hum or not thum then return end
    pcall(function()
        hum.BodyDepthScale.Value  = thum.BodyDepthScale.Value
        hum.BodyHeightScale.Value = thum.BodyHeightScale.Value
        hum.BodyWidthScale.Value  = thum.BodyWidthScale.Value
        hum.HeadScale.Value       = thum.HeadScale.Value
    end)
    local descReq = ReplicatedStorage:FindFirstChild("Remotes")
    descReq = descReq and descReq:FindFirstChild("Gameplay")
    descReq = descReq and descReq:FindFirstChild("GetDescription")
    if descReq and descReq:IsA("RemoteFunction") then
        pcall(function()
            local desc = descReq:InvokeServer(pl)
            if desc then
                game:GetService("Players"):LocalPlayer:LoadCharacterWithHumanoidDescription(desc)
            end
        end)
    end
end

local nitroConn = nil
local function setupNoclipPlus(on)
    if nitroConn then nitroConn:Disconnect() nitroConn = nil end
    if not on then return end
    nitroConn = RunService.Stepped:Connect(function()
        if not ChaosFlags["Toggle_NoclipPlus"] then
            nitroConn:Disconnect() nitroConn = nil
            return
        end
        local char = lp.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

addConn(RunService.Heartbeat:Connect(function()
    local myHRP = getHRP(lp)
    if not myHRP then return end

    if ChaosFlags["Toggle_AntiVoid"] then
        if myHRP.Position.Y < -100 then
            myHRP.CFrame = CFrame.new(myHRP.Position.X, 50, myHRP.Position.Z)
        end
    end

    if ChaosFlags["Toggle_AntiFling"] then
        local vel = myHRP.AssemblyLinearVelocity
        if vel and vel.Magnitude > 180 then
            myHRP.AssemblyLinearVelocity = Vector3.zero
        end
    end

    if ChaosFlags["Toggle_Spin"] then
        myHRP.CFrame = myHRP.CFrame * CFrame.Angles(0, math.rad(ChaosFlags["Slider_SpinSpeed"] or 5), 0)
    end

    if ChaosFlags["Toggle_SpeedGlitch"] then
        local hum = getHum(lp)
        if hum then
            local g = ChaosFlags["Slider_SpeedGlitch"] or 60
            hum.WalkSpeed = hum.WalkSpeed == g and 16 or g
        end
    end

    if ChaosFlags["Toggle_JumpBoost"] then
        local hum = getHum(lp)
        if hum then
            hum.JumpPower    = ChaosFlags["Slider_JumpBoost"] or 150
            hum.UseJumpPower = true
        end
    end

    if ChaosFlags["Toggle_AutoGrabGun"] then
        local char = lp.Character
        if char and not char:FindFirstChild("Sheriff_Gun") then
            pcall(grabGun)
        end
    end

    if ChaosFlags["Toggle_AutoShoot"] then
        local char = lp.Character
        if not char then return end
        local gun = char:FindFirstChild("Sheriff_Gun")
        if not gun then return end
        local shootRemote = gun:FindFirstChildOfClass("RemoteEvent")
        if not shootRemote then return end
        local myPos = myHRP.Position
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= lp and getRoleOf(pl) == "Murderer" then
                local hrp = getHRP(pl)
                if hrp then
                    if ChaosFlags["Toggle_AutoShootWall"] then
                        local dir    = hrp.Position - myPos
                        local params = RaycastParams.new()
                        params.FilterDescendantsInstances = {lp.Character, pl.Character}
                        params.FilterType = Enum.RaycastFilterType.Exclude
                        local hit = Workspace:Raycast(myPos, dir, params)
                        if hit then return end
                    end
                    local cf = CFrame.new(myPos) * CFrame.Angles(0, math.atan2(-(hrp.Position.X - myPos.X), -(hrp.Position.Z - myPos.Z)), 0)
                    pcall(function() shootRemote:FireServer(cf, CFrame.new(hrp.Position)) end)
                end
            end
        end
    end

    if ChaosFlags["Toggle_NoGunCD"] then
        local char = lp.Character
        if char then
            local gun = char:FindFirstChild("Sheriff_Gun")
            if gun then
                for _, v in ipairs(gun:GetDescendants()) do
                    if v:IsA("NumberValue") and (v.Name:lower():find("cooldown") or v.Name:lower():find("delay") or v.Name:lower():find("cool")) then
                        if v.Value > 0 then v.Value = 0 end
                    end
                end
            end
        end
    end

    if ChaosFlags["Toggle_Chams"] then
        for pl, sb in pairs(chamBoxes) do
            if pl.Character then
                local col = espColorFor(pl)
                sb.Color3        = col
                sb.SurfaceColor3 = col
            else
                pcall(function() sb:Destroy() end)
                chamBoxes[pl] = nil
            end
        end
    end

    updateRainbowESP()

    if ChaosFlags["Toggle_GravityMod"] then
        Workspace.Gravity = ChaosFlags["Slider_Gravity"] or 196
    end

    if ChaosFlags["Toggle_CustomFOV"] then
        cam.FieldOfView = ChaosFlags["Slider_CustomFOV"] or 70
    end

    if ChaosFlags["Toggle_AimLock"] and aimLockTarget then
        local hrp = getHRP(aimLockTarget)
        if hrp then
            cam.CFrame = CFrame.new(cam.CFrame.Position, hrp.Position)
        end
    end

    if ChaosFlags["Toggle_MurderAura"] then
        murderAura()
    end

    if ChaosFlags["Toggle_SheriffAura"] then
        sheriffAura()
    end

    if ChaosFlags["Toggle_CoinMagnet"] then
        local force = ChaosFlags["Slider_CoinMagnetForce"] or 80
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name == "Coin" or obj.Name == "Coin_Server" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildOfClass("BasePart")
                if part then
                    local dir = (myHRP.Position - part.Position).Unit
                    part.AssemblyLinearVelocity = dir * force
                end
            end
        end
    end

    if ChaosFlags["Toggle_HeadHitbox"] then
        setHeadHitbox(true)
    end
end))

addConn(RunService.Heartbeat:Connect(function()
    local hum = getHum(lp)
    if hum then
        if not ChaosFlags["Toggle_SpeedGlitch"] then
            if ChaosFlags["Slider_WalkSpeed"] then
                hum.WalkSpeed = ChaosFlags["Slider_WalkSpeed"]
            end
        end
        if not ChaosFlags["Toggle_JumpBoost"] then
            if ChaosFlags["Slider_JumpPower"] then
                hum.JumpPower = ChaosFlags["Slider_JumpPower"]
            end
        end
    end

    if ChaosFlags["Toggle_Fullbright"] then
        setFullbright(true)
    end

    if ChaosFlags["Toggle_TouchFling"] and not touchFlingConn then
        setupTouchFling()
    end

    if ChaosFlags["Toggle_FlingMurderer"] then
        flingMurderer()
    end

    if ChaosFlags["Toggle_FlingSheriff"] then
        flingSheriff()
    end

    if ChaosFlags["Toggle_RemoveTraps"] then
        removeTraps()
    end

    if ChaosFlags["Toggle_RemoveChroma"] then
        removeChroma()
    end

    if ChaosFlags["Toggle_RemovePets"] then
        removePets()
    end

    if ChaosFlags["Toggle_AutoReset"] and myRole() == "Innocent" then
        local h = getHum(lp)
        if h and h.Health > 0 then h.Health = 0 end
    end

    if ChaosFlags["Toggle_AutoRejoin"] then
        local h = getHum(lp)
        if h and h.Health <= 0 then
            pcall(function() TeleportService:Teleport(PLACE_ID) end)
        end
    end
end))

addConn(lp.CharacterAdded:Connect(function(char)
    if ChaosFlags["Toggle_Invisible"] then
        task.wait(0.1)
        setInvisible(true)
    end
    if ChaosFlags["Toggle_TouchFling"] then
        task.wait(0.2)
        setupTouchFling()
    end
    if ChaosFlags["Toggle_Chams"] then
        task.wait(0.5)
        updateChams()
    end
end))

addConn(Players.PlayerAdded:Connect(function(pl)
    pl.CharacterAdded:Connect(function()
        if ChaosFlags["Toggle_Chams"] then
            task.wait(0.5)
            updateChams()
        end
    end)
end))

addConn(Players.PlayerRemoving:Connect(function(pl)
    if chamBoxes[pl] then
        pcall(function() chamBoxes[pl]:Destroy() end)
        chamBoxes[pl] = nil
    end
end))

local knifeTrailObj = nil

local function setGhostMode(on)
    local char = lp.Character
    if not char then return end
    local alpha = on and (ChaosFlags["Slider_GhostTransp"] or 0.6) or 0
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            p.LocalTransparencyModifier = alpha
        end
    end
end

local function setBodyHitbox(on)
    local char = lp.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if on then
        root.Size = Vector3.new(
            ChaosFlags["Slider_BodyHitboxSize"] or 6,
            ChaosFlags["Slider_BodyHitboxSize"] or 6,
            ChaosFlags["Slider_BodyHitboxSize"] or 6
        )
    else
        root.Size = Vector3.new(2, 2, 1)
    end
end

local function setSoundRemove(on)
    for _, s in ipairs(Workspace:GetDescendants()) do
        if s:IsA("Sound") then s.Volume = on and 0 or 0.5 end
    end
    SoundService.AmbientReverb = on and Enum.ReverbType.NoReverb or Enum.ReverbType.SoundStage
end

local function setupKnifeTrail()
    if knifeTrailObj then knifeTrailObj:Destroy() knifeTrailObj = nil end
    if not ChaosFlags["Toggle_KnifeTrail"] then return end
    local char = lp.Character
    if not char then return end
    local knife = char:FindFirstChild("Knife") or char:FindFirstChildWhichIsA("Tool")
    if not knife then return end
    local handle = knife:FindFirstChild("Handle")
    if not handle then return end
    local a0 = Instance.new("Attachment") a0.Position = Vector3.new(0, 0.5, 0) a0.Parent = handle
    local a1 = Instance.new("Attachment") a1.Position = Vector3.new(0, -0.5, 0) a1.Parent = handle
    local trail = Instance.new("Trail")
    trail.Attachment0  = a0
    trail.Attachment1  = a1
    trail.Lifetime     = 0.4
    trail.WidthScale   = NumberSequence.new({NumberSequenceKeypoint.new(0,1), NumberSequenceKeypoint.new(1,0)})
    trail.Color        = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(220,50,50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(80,0,0))})
    trail.Parent       = handle
    knifeTrailObj      = trail
end

local function getRoleColor(pl)
    local role = roleData[pl] and roleData[pl].role or "Innocent"
    if role == "Murderer" then return Color3.fromRGB(220,50,50)
    elseif role == "Sheriff" then return Color3.fromRGB(50,120,220)
    else return Color3.fromRGB(80,200,80) end
end

local drawSnap = {}
local drawSkel = {}
local drawNames = {}
local drawSpeed = {}

local function clearExtraDrawings()
    for _, t in ipairs({drawSnap, drawSkel, drawNames, drawSpeed}) do
        for _, d in ipairs(t) do pcall(function() d:Remove() end) end
    end
    drawSnap = {} drawSkel = {} drawNames = {} drawSpeed = {}
end

local function updateExtraESP()
    clearExtraDrawings()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    local vp = cam.ViewportSize
    local cx, cy = vp.X/2, vp.Y

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp and pl.Character then
            local root = pl.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local pos3, vis = cam:WorldToViewportPoint(root.Position)
                if vis then
                    local px, py = pos3.X, pos3.Y
                    local rc = getRoleColor(pl)

                    if ChaosFlags["Toggle_SnapLines"] then
                        local line = Drawing.new("Line")
                        line.From    = Vector2.new(cx, cy)
                        line.To      = Vector2.new(px, py)
                        line.Color   = rc
                        line.Thickness = 1
                        line.Transparency = 0.6
                        line.Visible = true
                        table.insert(drawSnap, line)
                        table.insert(ChaosDrawings, line)
                    end

                    if ChaosFlags["Toggle_NameTags"] then
                        local lbl = Drawing.new("Text")
                        lbl.Text     = pl.DisplayName .. (ChaosFlags["Toggle_ExposeRoles"] and (" [" .. (roleData[pl] and roleData[pl].role or "?") .. "]") or "")
                        lbl.Position = Vector2.new(px, py - 30)
                        lbl.Size     = 13
                        lbl.Center   = true
                        lbl.Color    = rc
                        lbl.Outline  = true
                        lbl.Visible  = true
                        table.insert(drawNames, lbl)
                        table.insert(ChaosDrawings, lbl)
                    end

                    if ChaosFlags["Toggle_SpeedESP"] then
                        local hum = pl.Character:FindFirstChildOfClass("Humanoid")
                        local spd = hum and math.floor(hum.WalkSpeed) or 0
                        local stxt = Drawing.new("Text")
                        stxt.Text     = spd .. " st/s"
                        stxt.Position = Vector2.new(px, py + 14)
                        stxt.Size     = 11
                        stxt.Center   = true
                        stxt.Color    = Color3.fromRGB(200,200,200)
                        stxt.Outline  = true
                        stxt.Visible  = true
                        table.insert(drawSpeed, stxt)
                        table.insert(ChaosDrawings, stxt)
                    end

                    if ChaosFlags["Toggle_SkeletonESP"] then
                        local joints = {
                            {"Head","HumanoidRootPart"},
                            {"HumanoidRootPart","LeftUpperArm"},
                            {"HumanoidRootPart","RightUpperArm"},
                            {"LeftUpperArm","LeftLowerArm"},
                            {"RightUpperArm","RightLowerArm"},
                            {"HumanoidRootPart","LeftUpperLeg"},
                            {"HumanoidRootPart","RightUpperLeg"},
                            {"LeftUpperLeg","LeftLowerLeg"},
                            {"RightUpperLeg","RightLowerLeg"},
                        }
                        for _, pair in ipairs(joints) do
                            local a = pl.Character:FindFirstChild(pair[1])
                            local b = pl.Character:FindFirstChild(pair[2])
                            if a and b then
                                local ap, av = cam:WorldToViewportPoint(a.Position)
                                local bp, bv = cam:WorldToViewportPoint(b.Position)
                                if av and bv then
                                    local sk = Drawing.new("Line")
                                    sk.From  = Vector2.new(ap.X, ap.Y)
                                    sk.To    = Vector2.new(bp.X, bp.Y)
                                    sk.Color = rc
                                    sk.Thickness = 1
                                    sk.Visible = true
                                    table.insert(drawSkel, sk)
                                    table.insert(ChaosDrawings, sk)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local killCount  = 0
local deathCount = 0

local function setupKillCounter()
    if not lp.Character then return end
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        addConn(hum.Died:Connect(function() deathCount = deathCount + 1 end))
    end
end

local overlayGui = nil
local overlayFrame = nil
local overlayLines = {}

local function buildOverlay()
    if overlayGui then overlayGui:Destroy() end
    overlayGui = Instance.new("ScreenGui")
    overlayGui.Name = "ChaosOverlay"
    overlayGui.ResetOnSpawn = false
    overlayGui.DisplayOrder = 998
    pcall(function() overlayGui.Parent = game:GetService("CoreGui") end)
    if not overlayGui.Parent then overlayGui.Parent = lp.PlayerGui end

    overlayFrame = Instance.new("Frame")
    overlayFrame.Size = UDim2.new(0, 160, 0, 80)
    overlayFrame.Position = UDim2.new(0, 6, 0, 36)
    overlayFrame.BackgroundColor3 = Color3.fromRGB(2,1,2)
    overlayFrame.BackgroundTransparency = 0.3
    overlayFrame.BorderSizePixel = 0
    overlayFrame.Parent = overlayGui
    local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0,4) corner.Parent = overlayFrame
    local stroke = Instance.new("UIStroke") stroke.Color = Color3.fromRGB(220,50,50) stroke.Thickness = 1 stroke.Parent = overlayFrame

    local function mkLine(y)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1,0,0,14)
        lbl.Position = UDim2.new(0,4,0,y)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(220,220,220)
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Text = ""
        lbl.Parent = overlayFrame
        return lbl
    end
    overlayLines[1] = mkLine(4)
    overlayLines[2] = mkLine(20)
    overlayLines[3] = mkLine(36)
    overlayLines[4] = mkLine(52)
end

local function updateOverlay()
    if not ChaosFlags["Toggle_Overlay"] then
        if overlayGui then overlayGui.Enabled = false end
        return
    end
    if not overlayGui then buildOverlay() end
    overlayGui.Enabled = true

    local role = myRole()
    local roleColor = role == "Murderer" and Color3.fromRGB(220,50,50) or (role == "Sheriff" and Color3.fromRGB(50,120,220) or Color3.fromRGB(80,200,80))
    if overlayLines[1] then
        overlayLines[1].Text = "CHAOS  v6"
        overlayLines[1].TextColor3 = Color3.fromRGB(220,50,50)
    end
    if overlayLines[2] then
        overlayLines[2].Text = "Role: " .. role
        overlayLines[2].TextColor3 = roleColor
    end
    if overlayLines[3] then
        overlayLines[3].Text = "K " .. killCount .. "  /  D " .. deathCount
        overlayLines[3].TextColor3 = Color3.fromRGB(200,200,200)
    end
    if overlayLines[4] and ChaosFlags["Toggle_ClockOverlay"] then
        local t = os.date("*t")
        overlayLines[4].Text = string.format("%02d:%02d", t.hour, t.min)
        overlayLines[4].TextColor3 = Color3.fromRGB(160,160,160)
    elseif overlayLines[4] then
        overlayLines[4].Text = ""
    end
end

local function setRapidFire(on)
    local char = lp.Character
    if not char then return end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            local gun = tool:FindFirstChild("GunScript") or tool:FindFirstChild("LocalGunScript")
            if gun then
                pcall(function()
                    local env = getfenv and getfenv(gun) or {}
                    if env.FireRate then env.FireRate = on and 0.01 or 0.5 end
                end)
            end
            local cfg = tool:FindFirstChild("Configuration") or tool:FindFirstChild("Settings")
            if cfg then
                local cd = cfg:FindFirstChild("Cooldown") or cfg:FindFirstChild("FireRate")
                if cd then cd.Value = on and 0.01 or 0.5 end
            end
        end
    end
end

local function autoCollectItems()
    local char = lp.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local best, bestDist = nil, math.huge
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "Coin" or obj.Name == "GunPickup" or obj.Name == "KnifePickup") then
            local d = (obj.Position - root.Position).Magnitude
            if d < (ChaosFlags["Slider_CollectRange"] or 60) and d < bestDist then
                best = obj bestDist = d
            end
        end
    end
    if best then
        root.CFrame = CFrame.new(best.Position + Vector3.new(0,2,0))
    end
end

local waypointDrawings = {}

local function clearWaypoints()
    for _, d in ipairs(waypointDrawings) do pcall(function() d:Remove() end) end
    waypointDrawings = {}
end

local function updateWaypoints()
    clearWaypoints()
    if not ChaosFlags["Toggle_WaypointESP"] then return end
    local cam = Workspace.CurrentCamera
    if not cam then return end
    local vp = cam.ViewportSize
    local targets = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "GunPickup" or obj.Name == "Coin") then
            table.insert(targets, {obj = obj, name = obj.Name == "GunPickup" and "GUN" or "¢"})
        end
    end
    for _, t in ipairs(targets) do
        local pos3, vis = cam:WorldToViewportPoint(t.obj.Position)
        local col = t.name == "GUN" and Color3.fromRGB(50,180,255) or Color3.fromRGB(255,215,0)
        local px = math.clamp(pos3.X, 10, vp.X-10)
        local py = math.clamp(pos3.Y, 10, vp.Y-10)
        local dot = Drawing.new("Circle")
        dot.Position = Vector2.new(px, py)
        dot.Radius   = vis and 5 or 3
        dot.Color    = col
        dot.Filled   = true
        dot.Visible  = true
        table.insert(waypointDrawings, dot)
        table.insert(ChaosDrawings, dot)
        local lbl = Drawing.new("Text")
        lbl.Text     = t.name
        lbl.Position = Vector2.new(px, py - 12)
        lbl.Size     = 10
        lbl.Center   = true
        lbl.Color    = col
        lbl.Outline  = true
        lbl.Visible  = true
        table.insert(waypointDrawings, lbl)
        table.insert(ChaosDrawings, lbl)
    end
end

local origBodySizes = {}

local function saveBodySizes()
    local char = lp.Character
    if not char then return end
    origBodySizes = {}
    for _, p in ipairs(char:GetChildren()) do
        if p:IsA("BasePart") then origBodySizes[p.Name] = p.Size end
    end
end

local function expandBodyHitbox(on)
    local char = lp.Character
    if not char then return end
    if on then
        if not next(origBodySizes) then saveBodySizes() end
        local sz = ChaosFlags["Slider_BodyHitboxSize"] or 6
        for _, p in ipairs(char:GetChildren()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.Size = Vector3.new(sz, sz, sz)
            end
        end
    else
        for name, size in pairs(origBodySizes) do
            local p = char:FindFirstChild(name)
            if p and p:IsA("BasePart") then p.Size = size end
        end
        origBodySizes = {}
    end
end

local NL_URL = "https://raw.githubusercontent.com/B5RLAS/Neverlose/main/NeverLose.lua"
local Library = loadstring(game:HttpGet(NL_URL))()

Library.Theme.Accent        = Color3.fromRGB(220, 50, 50)
Library.Theme.FrameInactive = Color3.fromRGB(8, 3, 4)
Library.Theme.FrameActive   = Color3.fromRGB(14, 6, 8)
Library.Theme.GroupBoxBg    = Color3.fromRGB(5, 2, 3)
Library.Theme.WindowBg      = Color3.fromRGB(2, 1, 2)
Library.Theme.Button        = Color3.fromRGB(12, 5, 7)
Library.Theme.ButtonHovered = Color3.fromRGB(22, 9, 13)
Library.Theme.ButtonActive  = Color3.fromRGB(32, 14, 19)

local Window = Library:CreateWindow({
    Title = "CHAOS HUB",
    User  = lp.DisplayName,
    Till  = "MM2  ·  v6",
    Blur  = 14,
})

Library.ToggleKey = Enum.KeyCode.Insert

local function ch(k)   return { Flag=k, Default=ChaosFlags[k], Callback=function(v) ChaosFlags[k]=v end } end
local function sl(k,mn,mx,suf) return { Flag=k, Default=ChaosFlags[k], Min=mn, Max=mx, Suffix=suf or "", Decimals=0, Callback=function(v) ChaosFlags[k]=v end } end
local function dd(k,opts) return { Flag=k, Default=ChaosFlags[k], Options=opts, Callback=function(v) ChaosFlags[k]=v end } end
local function bt(cb) return { Callback=cb } end

Window:AddCategory("COMBAT")

local aimTab = Window:AddTab("Aimbot", "rbxassetid://10734950309")

do
    local sub = aimTab:AddSubtab("Silent")
    local L = sub:AddGroup("Silent Aim", nil, "Left", 230)
    L:AddCheckbox("Silent Throw",        ch("Toggle_SilentThrow"))
    L:AddCheckbox("Silent Aim (Gun)",    ch("Toggle_SilentAim"))
    L:AddCheckbox("Kill Aura",           ch("Toggle_KillAura"))
    L:AddCheckbox("Wall Check",          ch("Toggle_WallCheck"))
    L:AddSlider("Aura Radius",           sl("Slider_KnifeReach", 5, 120, " st"))
    L:AddSlider("Lead Time",             sl("Slider_LeadTime", 1, 30, " ms"))

    local R = sub:AddGroup("Auras", nil, "Right", 230)
    R:AddCheckbox("Murder Aura",         ch("Toggle_MurderAura"))
    R:AddSlider("Murd. Radius",          sl("Slider_MurderAuraRange", 5, 80, " st"))
    R:AddCheckbox("Sheriff Aura",        ch("Toggle_SheriffAura"))
    R:AddSlider("Sher. Radius",          sl("Slider_SheriffAuraRange", 10, 150, " st"))
    R:AddCheckbox("Auto Strafe",         ch("Toggle_AutoStrafe"))
end

do
    local sub = aimTab:AddSubtab("Aim Lock")
    local L = sub:AddGroup("Aim Lock", nil, "Left", 180)
    L:AddCheckbox("Aim Lock",            { Flag="Toggle_AimLock", Default=ChaosFlags["Toggle_AimLock"], Callback=function(v) ChaosFlags["Toggle_AimLock"]=v if not v then aimLockTarget=nil end end })
    local plNames = {"(none)"}
    for _, pl in ipairs(Players:GetPlayers()) do if pl ~= lp then table.insert(plNames, pl.Name) end end
    L:AddDropdown("Lock Target",         dd("LockOn_Target", plNames))
    L:AddSlider("Aim Range",             sl("Slider_AimRange", 10, 500, " st"))

    local R = sub:AddGroup("Hitbox", nil, "Right", 180)
    R:AddCheckbox("Head Hitbox",         ch("Toggle_HeadHitbox"))
    R:AddSlider("Head Size",             sl("Slider_HitboxSize", 2, 24, ""))
    R:AddCheckbox("Body Hitbox",         { Flag="Toggle_BodyHitbox", Default=ChaosFlags["Toggle_BodyHitbox"], Callback=function(v) ChaosFlags["Toggle_BodyHitbox"]=v expandBodyHitbox(v) end })
    R:AddSlider("Body Size",             sl("Slider_BodyHitboxSize", 2, 20, ""))
end

local gunTab = Window:AddTab("Gun & Role", "rbxassetid://10734947200")

do
    local sub = gunTab:AddSubtab("Gun")
    local L = sub:AddGroup("Gun", nil, "Left", 240)
    L:AddCheckbox("Auto Shoot",          ch("Toggle_AutoShoot"))
    L:AddCheckbox("Auto Shoot WallChk",  ch("Toggle_AutoShootWall"))
    L:AddCheckbox("No Gun Cooldown",     ch("Toggle_NoGunCD"))
    L:AddCheckbox("Rapid Fire",          { Flag="Toggle_RapidFire", Default=ChaosFlags["Toggle_RapidFire"], Callback=function(v) ChaosFlags["Toggle_RapidFire"]=v setRapidFire(v) end })
    L:AddCheckbox("Auto Grab Gun",       ch("Toggle_AutoGrabGun"))
    L:AddButton("Grab Gun",              bt(grabGun))
    L:AddButton("Steal Gun",             bt(stealGun))
    L:AddButton("TP → Gun",              bt(tpToGun))

    local R = sub:AddGroup("Teleport", nil, "Right", 180)
    R:AddButton("TP → Murderer",         bt(tpToMurderer))
    R:AddButton("TP → Sheriff",          bt(tpToSheriff))
    R:AddButton("Drop Knife",            bt(dropKnife))
    R:AddCheckbox("Knife Trail",         { Flag="Toggle_KnifeTrail", Default=ChaosFlags["Toggle_KnifeTrail"], Callback=function(v) ChaosFlags["Toggle_KnifeTrail"]=v setupKnifeTrail() end })
end

do
    local sub = gunTab:AddSubtab("Role")
    local L = sub:AddGroup("Role Info", nil, "Left", 160)
    L:AddCheckbox("Expose Roles",        ch("Toggle_ExposeRoles"))
    L:AddCheckbox("Role Notify",         ch("Toggle_RoleNotify"))
    L:AddCheckbox("Role Color ESP",      ch("Toggle_RoleColorESP"))
    L:AddCheckbox("Kill Counter",        ch("Toggle_KillCounter"))

    local R = sub:AddGroup("Actions", nil, "Right", 100)
    R:AddButton("Log Roles",             bt(function()
        for pl, data in pairs(roleData) do
            if pl and data.role then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = pl.Name, Text = data.role, Duration = 4,
                })
            end
        end
    end))
end

Window:AddCategory("VISUALS")

local espTab = Window:AddTab("ESP", "rbxassetid://10734947508")

do
    local sub = espTab:AddSubtab("Players")
    local L = sub:AddGroup("Boxes & Tracers", nil, "Left", 250)
    L:AddCheckbox("ESP Boxes",           ch("Toggle_ESPBoxes"))
    L:AddCheckbox("ESP Tracers",         ch("Toggle_ESPTracers"))
    L:AddCheckbox("ESP Arrows",          ch("Toggle_ESPArrows"))
    L:AddCheckbox("Show Health",         ch("Toggle_ShowESPHealth"))
    L:AddCheckbox("Show Distance",       ch("Toggle_ShowESPDist"))
    L:AddCheckbox("Name Tags",           ch("Toggle_NameTags"))
    L:AddCheckbox("Speed ESP",           ch("Toggle_SpeedESP"))
    L:AddCheckbox("Snap Lines",          ch("Toggle_SnapLines"))
    L:AddSlider("ESP Range",             sl("Slider_ESPRange", 50, 2000, " st"))

    local R = sub:AddGroup("Skeleton & FX", nil, "Right", 250)
    R:AddCheckbox("Skeleton ESP",        ch("Toggle_SkeletonESP"))
    R:AddCheckbox("Chams",               { Flag="Toggle_Chams", Default=ChaosFlags["Toggle_Chams"], Callback=function(v) ChaosFlags["Toggle_Chams"]=v updateChams() end })
    R:AddCheckbox("Rainbow ESP",         ch("Toggle_RainbowESP"))
    R:AddCheckbox("Role Colors",         ch("Toggle_RoleColorESP"))
    R:AddCheckbox("Crosshair",           ch("Toggle_Crosshair"))
    R:AddSlider("Crosshair Size",        sl("Slider_CrosshairSize", 4, 48, " px"))
end

do
    local sub = espTab:AddSubtab("World")
    local L = sub:AddGroup("Objects", nil, "Left", 160)
    L:AddCheckbox("Coin ESP",            ch("Toggle_CoinESP"))
    L:AddCheckbox("Trap ESP",            ch("Toggle_TrapESP"))
    L:AddCheckbox("Waypoints",           ch("Toggle_WaypointESP"))
    L:AddSlider("Waypoint Range",        sl("Slider_CollectRange", 20, 200, " st"))
end

local sceneTab = Window:AddTab("Scene", "rbxassetid://10734947098")

do
    local sub = sceneTab:AddSubtab("Render")
    local L = sub:AddGroup("Scene", nil, "Left", 270)
    L:AddCheckbox("Fullbright",          { Flag="Toggle_Fullbright",    Default=ChaosFlags["Toggle_Fullbright"],    Callback=function(v) ChaosFlags["Toggle_Fullbright"]=v    setFullbright(v) end })
    L:AddCheckbox("Remove Chroma",       ch("Toggle_RemoveChroma"))
    L:AddCheckbox("Remove Pets",         ch("Toggle_RemovePets"))
    L:AddCheckbox("Remove Traps",        ch("Toggle_RemoveTraps"))
    L:AddCheckbox("Remove Sounds",       { Flag="Toggle_SoundRemove",   Default=ChaosFlags["Toggle_SoundRemove"],   Callback=function(v) ChaosFlags["Toggle_SoundRemove"]=v   setSoundRemove(v) end })
    L:AddCheckbox("No Fog",              ch("Toggle_NoFog"))
    L:AddCheckbox("BG Blur",             ch("Toggle_BGBlur"))
    L:AddSlider("Blur Size",             sl("Slider_BlurSize", 0, 56, ""))

    local R = sub:AddGroup("FX", nil, "Right", 180)
    R:AddCheckbox("Invisible",           { Flag="Toggle_Invisible",     Default=ChaosFlags["Toggle_Invisible"],     Callback=function(v) ChaosFlags["Toggle_Invisible"]=v     setInvisible(v) end })
    R:AddCheckbox("Ghost Mode",          { Flag="Toggle_GhostMode",     Default=ChaosFlags["Toggle_GhostMode"],     Callback=function(v) ChaosFlags["Toggle_GhostMode"]=v     setGhostMode(v) end })
    R:AddSlider("Ghost Alpha",           sl("Slider_GhostTransp", 10, 90, "%"))
    R:AddCheckbox("FPS Boost",           { Flag="Toggle_FPSBoost",      Default=ChaosFlags["Toggle_FPSBoost"],      Callback=function(v) ChaosFlags["Toggle_FPSBoost"]=v      setFPSBoost(v) end })
    R:AddButton("Apply FPS Boost",       bt(function() setFPSBoost(ChaosFlags["Toggle_FPSBoost"]) end))
end

do
    local sub = sceneTab:AddSubtab("Overlay")
    local L = sub:AddGroup("HUD Overlay", nil, "Left", 160)
    L:AddCheckbox("Enable Overlay",      ch("Toggle_Overlay"))
    L:AddCheckbox("Show Clock",          ch("Toggle_ClockOverlay"))
    L:AddCheckbox("Show Role",           ch("Toggle_RoleOverlay"))
    L:AddCheckbox("Show Kills",          ch("Toggle_KillCounter"))
end

Window:AddCategory("UTILITY")

local flingTab = Window:AddTab("Fling", "rbxassetid://10734946380")

do
    local sub = flingTab:AddSubtab("General")
    local L = sub:AddGroup("Fling", nil, "Left", 230)
    L:AddCheckbox("Spam Fling",          ch("Toggle_SpamFling"))
    L:AddCheckbox("Touch Fling",         ch("Toggle_TouchFling"))
    L:AddCheckbox("Fling Murderer",      ch("Toggle_FlingMurderer"))
    L:AddCheckbox("Fling Sheriff",       ch("Toggle_FlingSheriff"))
    L:AddCheckbox("Anti Fling",          ch("Toggle_AntiFling"))
    L:AddCheckbox("Anti Void",           ch("Toggle_AntiVoid"))

    local R = sub:AddGroup("Target", nil, "Right", 180)
    local flingTargets = {"(all)", "(murderer)", "(sheriff)"}
    for _, pl in ipairs(Players:GetPlayers()) do if pl ~= lp then table.insert(flingTargets, pl.Name) end end
    R:AddDropdown("Target",              dd("Fling_Target", flingTargets))
    R:AddButton("Fling Selected",        bt(function()
        local name = ChaosFlags["Fling_Target"]
        if not name or name == "(all)" then startFlingAll() return end
        if name == "(murderer)" then flingMurderer() return end
        if name == "(sheriff)"  then flingSheriff()  return end
        local pl = Players:FindFirstChild(name)
        if pl then pcall(SkidFling, pl) end
    end))
    R:AddButton("Fling All",             bt(startFlingAll))
    R:AddButton("Fling Murderer",        bt(flingMurderer))
    R:AddButton("Fling Sheriff",         bt(flingSheriff))
end

local farmTab = Window:AddTab("Farm", "rbxassetid://10734948760")

do
    local sub = farmTab:AddSubtab("Auto")
    local L = sub:AddGroup("Auto Farm", nil, "Left", 210)
    L:AddCheckbox("Auto Farm",           { Flag="Toggle_AutoFarm", Default=ChaosFlags["Toggle_AutoFarm"], Callback=function(v) ChaosFlags["Toggle_AutoFarm"]=v if v then StartFarm() else StopFarm() end end })
    L:AddCheckbox("Auto Hop Watch",      ch("Toggle_AutoHopWatch"))
    L:AddCheckbox("Auto Collect",        ch("Toggle_AutoCollect"))
    L:AddSlider("Collect Range",         sl("Slider_CollectRange", 10, 200, " st"))
    L:AddButton("Start Farm",            bt(StartFarm))
    L:AddButton("Stop Farm",             bt(StopFarm))

    local R = sub:AddGroup("Magnet", nil, "Right", 160)
    R:AddCheckbox("Coin Magnet",         ch("Toggle_CoinMagnet"))
    R:AddSlider("Magnet Force",          sl("Slider_CoinMagnetForce", 10, 400, ""))
    R:AddCheckbox("Auto Box",            ch("Toggle_AutoBox"))
    R:AddButton("Open Box",              bt(openBox))
    R:AddButton("Optimise Coins",        bt(optimizeCoins))
end

do
    local sub = farmTab:AddSubtab("Server")
    local L = sub:AddGroup("Server Hop", nil, "Left", 100)
    L:AddButton("Server Hop",            bt(ServerHop))
    L:AddButton("Smallest Server",       bt(SmallestServerHop))
    L:AddSlider("Min Players",           sl("Slider_FarmHopMin", 1, 10, ""))
end

local playerTab = Window:AddTab("Player", "rbxassetid://10734949561")

do
    local sub = playerTab:AddSubtab("Movement")
    local L = sub:AddGroup("Speed", nil, "Left", 310)
    L:AddCheckbox("Fly",                 { Flag="Toggle_Fly",  Default=ChaosFlags["Toggle_Fly"],  Callback=function(v) ChaosFlags["Toggle_Fly"]=v  if v then startFly() else stopFly() end end })
    L:AddCheckbox("Noclip",              ch("Toggle_Noclip"))
    L:AddCheckbox("Bunny Hop",           ch("Toggle_BunnyHop"))
    L:AddCheckbox("Inf Jump",            ch("Toggle_InfJump"))
    L:AddCheckbox("Speed Glitch",        ch("Toggle_SpeedGlitch"))
    L:AddCheckbox("Jump Boost",          ch("Toggle_JumpBoost"))
    L:AddCheckbox("Spin",                ch("Toggle_Spin"))
    L:AddSlider("Walk Speed",            sl("Slider_WalkSpeed", 8, 150, ""))
    L:AddSlider("Jump Power",            sl("Slider_JumpPower", 8, 400, ""))
    L:AddSlider("Spin Speed",            sl("Slider_SpinSpeed", 1, 50, ""))
    L:AddSlider("Fly Speed",             sl("Slider_FlySpeed", 10, 200, ""))

    local R = sub:AddGroup("World", nil, "Right", 310)
    R:AddCheckbox("Click TP",            { Flag="Toggle_ClickTP",  Default=ChaosFlags["Toggle_ClickTP"],  Callback=function(v) ChaosFlags["Toggle_ClickTP"]=v  setupClickTP(v) end })
    R:AddCheckbox("Gravity Mod",         ch("Toggle_GravityMod"))
    R:AddSlider("Gravity",               sl("Slider_Gravity", 5, 400, ""))
    R:AddCheckbox("Custom FOV",          ch("Toggle_CustomFOV"))
    R:AddSlider("FOV",                   sl("Slider_CustomFOV", 20, 140, "°"))
    R:AddCheckbox("Knife Reach",         ch("Toggle_HitboxExp"))
    R:AddSlider("Reach",                 sl("Slider_KnifeReach", 5, 120, " st"))
end

do
    local sub = playerTab:AddSubtab("Safety")
    local L = sub:AddGroup("Protection", nil, "Left", 200)
    L:AddCheckbox("God Mode",            ch("Toggle_GodMode"))
    L:AddCheckbox("Anti AFK",            ch("Toggle_AntiAFK"))
    L:AddCheckbox("Auto Reset",          ch("Toggle_AutoReset"))
    L:AddCheckbox("Auto Rejoin",         ch("Toggle_AutoRejoin"))
    L:AddCheckbox("Anti Fling",          ch("Toggle_AntiFling"))
    L:AddCheckbox("Anti Void",           ch("Toggle_AntiVoid"))

    local R = sub:AddGroup("Status", nil, "Right", 100)
    R:AddLabel("K: 0  D: 0")
    R:AddLabel("INSERT  = toggle")
    R:AddLabel("DELETE  = unload")
end

local skinsTab = Window:AddTab("Skins", "rbxassetid://10734950987")

do
    local sub = skinsTab:AddSubtab("Skins")
    local knifeNames, gunNames = {}, {}
    for k in pairs(KNIFE_SKINS) do table.insert(knifeNames, k) end
    for k in pairs(GUN_SKINS)   do table.insert(gunNames,   k) end
    table.sort(knifeNames) table.sort(gunNames)

    local L = sub:AddGroup("Knife", nil, "Left", 160)
    L:AddDropdown("Knife Skin",          dd("SkinChanger_Knife", knifeNames))
    L:AddButton("Apply Knife",           bt(function() applyKnifeSkin(ChaosFlags["SkinChanger_Knife"]) end))
    L:AddCheckbox("Skin Watcher",        { Flag="Toggle_SkinWatcher", Default=ChaosFlags["Toggle_SkinWatcher"], Callback=function(v) ChaosFlags["Toggle_SkinWatcher"]=v if v then startSkinWatcher() elseif skinWatchConn then skinWatchConn:Disconnect() skinWatchConn=nil end end })

    local R = sub:AddGroup("Gun", nil, "Right", 120)
    R:AddDropdown("Gun Skin",            dd("SkinChanger_Gun", gunNames))
    R:AddButton("Apply Gun",             bt(function() applyGunSkin(ChaosFlags["SkinChanger_Gun"]) end))
end

local settingsTab = Window:AddTab("Settings", "rbxassetid://10734948312")

do
    local sub = settingsTab:AddSubtab("Config")
    local L = sub:AddGroup("Config", nil, "Left", 130)
    L:AddButton("Save Config",           bt(saveConfig))
    L:AddButton("Reload Config",         bt(loadConfig))

    local R = sub:AddGroup("About", nil, "Right", 130)
    R:AddLabel("CHAOS HUB  v6.0")
    R:AddLabel("MM2  ·  Godfather")
    R:AddLabel("discord.gg/ojailbreaks")
end

local ChaosBlur = Instance.new("BlurEffect")
ChaosBlur.Name   = "ChaosBlur"
ChaosBlur.Size   = 0
ChaosBlur.Parent = Lighting

addConn(RunService.Heartbeat:Connect(function()
    ChaosBlur.Size = ChaosFlags["Toggle_BGBlur"] and (ChaosFlags["Slider_BlurSize"] or 24) or 0

    local hum = getHum(lp)
    if hum then
        if not ChaosFlags["Toggle_SpeedGlitch"] and ChaosFlags["Slider_WalkSpeed"] then hum.WalkSpeed = ChaosFlags["Slider_WalkSpeed"] end
        if not ChaosFlags["Toggle_JumpBoost"]   and ChaosFlags["Slider_JumpPower"] then hum.JumpPower  = ChaosFlags["Slider_JumpPower"]  end
    end

    if ChaosFlags["Toggle_AimLock"] then
        local name = ChaosFlags["LockOn_Target"]
        aimLockTarget = (name and name ~= "(none)") and Players:FindFirstChild(name) or nil
    end

    if ChaosFlags["Toggle_GravityMod"] then
        Workspace.Gravity = ChaosFlags["Slider_Gravity"] or 196
    end

    if ChaosFlags["Toggle_CustomFOV"] then
        cam.FieldOfView = ChaosFlags["Slider_CustomFOV"] or 70
    end

    if ChaosFlags["Toggle_NoFog"] then
        Lighting.FogEnd   = 1e9
        Lighting.FogStart = 1e9
    end

    if ChaosFlags["Toggle_Fullbright"]    then setFullbright(true)    end
    if ChaosFlags["Toggle_TouchFling"] and not touchFlingConn then setupTouchFling() end
    if ChaosFlags["Toggle_FlingMurderer"] then flingMurderer()         end
    if ChaosFlags["Toggle_FlingSheriff"]  then flingSheriff()          end
    if ChaosFlags["Toggle_RemoveTraps"]   then removeTraps()           end
    if ChaosFlags["Toggle_RemoveChroma"]  then removeChroma()          end
    if ChaosFlags["Toggle_RemovePets"]    then removePets()            end
    if ChaosFlags["Toggle_AutoCollect"]   then autoCollectItems()      end

    if ChaosFlags["Toggle_AutoReset"] and myRole()=="Innocent" then
        local h=getHum(lp) if h and h.Health>0 then h.Health=0 end
    end
    if ChaosFlags["Toggle_AutoRejoin"] then
        local h=getHum(lp) if h and h.Health<=0 then pcall(function() TeleportService:Teleport(PLACE_ID) end) end
    end
    if ChaosFlags["Toggle_AntiAFK"] then
        pcall(function()
            local vim=game:GetService("VirtualInputManager")
            vim:SendKeyEvent(true,Enum.KeyCode.W,false,game)
            vim:SendKeyEvent(false,Enum.KeyCode.W,false,game)
        end)
    end
end))

addConn(RunService.RenderStepped:Connect(function()
    if ChaosFlags["Toggle_SnapLines"]  or ChaosFlags["Toggle_NameTags"]   or
       ChaosFlags["Toggle_SpeedESP"]   or ChaosFlags["Toggle_SkeletonESP"] then
        updateExtraESP()
    else
        clearExtraDrawings()
    end
    updateWaypoints()
    updateOverlay()
end))

addConn(game:GetService("UserInputService").InputBegan:Connect(function(inp, gpe)
    if gpe then return end
    if inp.KeyCode == Enum.KeyCode.Delete then
        if _G.ChaosCleanup then pcall(_G.ChaosCleanup) end
    end
end))

setupKillCounter()

_G.ChaosCleanup = function()
    for _, c in ipairs(ChaosConns) do pcall(function() c:Disconnect() end) end
    ChaosConns = {}
    for _, d in ipairs(ChaosDrawings) do pcall(function() d:Remove() end) end
    ChaosDrawings = {}
    clearExtraDrawings()
    clearWaypoints()
    pcall(stopFly)
    pcall(StopFarm)
    pcall(StopFarmHopWatch)
    if spamFlingConn  then spamFlingConn:Disconnect()  spamFlingConn  = nil end
    if skinWatchConn  then skinWatchConn:Disconnect()  skinWatchConn  = nil end
    if touchFlingConn then touchFlingConn:Disconnect() touchFlingConn = nil end
    if clickTPConn    then clickTPConn:Disconnect()    clickTPConn    = nil end
    if nitroConn      then nitroConn:Disconnect()      nitroConn      = nil end
    if knifeTrailObj  then pcall(function() knifeTrailObj:Destroy() end) knifeTrailObj = nil end
    ROLEBOX.stop()
    clearChams()
    setFullbright(false)
    setFPSBoost(false)
    setInvisible(false)
    setGhostMode(false)
    setSoundRemove(false)
    expandBodyHitbox(false)
    setHeadHitbox(false)
    if ChaosFlags["Toggle_GravityMod"] then Workspace.Gravity = origGravity end
    if ChaosFlags["Toggle_CustomFOV"]  then cam.FieldOfView   = 70         end
    pcall(function() ChaosBlur:Destroy()  end)
    pcall(function() overlayGui:Destroy() end)
    pcall(function() Library:Destroy()    end)
    ChaosFlags    = {}
    chamBoxes     = {}
    origBodySizes = {}
    aimLockTarget = nil
end

scanCoins()
StartFarmHopWatch()

local MOB_ICONS = {
    SHOOT     = "rbxassetid://10734947200",
    THROW     = "rbxassetid://10734948450",
    FLING     = "rbxassetid://10734946380",
    TP_MURD   = "rbxassetid://10734950309",
    TP_GUN    = "rbxassetid://10734947300",
    GRAB_GUN  = "rbxassetid://10734947200",
    STEAL     = "rbxassetid://10734948150",
    FLY       = "rbxassetid://10734949561",
    FARM      = "rbxassetid://10734948760",
    HOP       = "rbxassetid://10734946600",
    RESET     = "rbxassetid://10734946220",
    BOX       = "rbxassetid://10734950100",
    MENU      = "rbxassetid://10734948312",
}

local MA = Color3.fromRGB(220, 50, 50)
local MA2= Color3.fromRGB(80, 20, 20)
local MB = Color3.fromRGB(10, 10, 14)
local MB2= Color3.fromRGB(18, 18, 24)
local MB3= Color3.fromRGB(26, 26, 36)
local MT = Color3.fromRGB(240, 240, 245)
local MD = Color3.fromRGB(90, 90, 110)
local MG = Color3.fromRGB(50, 210, 100)
local TS = game:GetService("TweenService")
local UIS= game:GetService("UserInputService")

local function mTw(obj, props, t)
    TS:Create(obj, TweenInfo.new(t or 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local MobGui = Instance.new("ScreenGui")
MobGui.Name           = "ChaosMobile"
MobGui.ResetOnSpawn   = false
MobGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MobGui.DisplayOrder   = 1001
pcall(function() MobGui.Parent = game:GetService("CoreGui") end)
if not MobGui.Parent then MobGui.Parent = lp.PlayerGui end

local BW, GS, GP, PAD = 56, 56, 7, 10
local COLS = 2
local PW   = COLS * GS + (COLS - 1) * GP + PAD * 2

local panel = Instance.new("Frame")
panel.Name             = "MobPanel"
panel.Size             = UDim2.new(0, PW, 0, 44)
panel.Position         = UDim2.new(1, -(PW + 10), 0.5, -160)
panel.BackgroundColor3 = MB
panel.BorderSizePixel  = 0
panel.ClipsDescendants = false
panel.Parent           = MobGui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)

local pStroke = Instance.new("UIStroke", panel)
pStroke.Color     = MA
pStroke.Thickness = 1.5

local shad = Instance.new("ImageLabel", panel)
shad.Size               = UDim2.new(1, 32, 1, 32)
shad.Position           = UDim2.new(0, -16, 0, -16)
shad.BackgroundTransparency = 1
shad.Image              = "rbxassetid://6014261993"
shad.ImageColor3        = Color3.fromRGB(0, 0, 0)
shad.ImageTransparency  = 0.5
shad.ScaleType          = Enum.ScaleType.Slice
shad.SliceCenter        = Rect.new(49, 49, 450, 450)
shad.ZIndex             = 0

local hdr = Instance.new("Frame", panel)
hdr.Size             = UDim2.new(1, 0, 0, 44)
hdr.BackgroundColor3 = Color3.fromRGB(14, 8, 8)
hdr.BorderSizePixel  = 0
Instance.new("UICorner", hdr).CornerRadius = UDim.new(0, 14)

local hGrad = Instance.new("UIGradient", hdr)
hGrad.Color    = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 10, 10)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 18)),
}
hGrad.Rotation = 90

local logoI = Instance.new("ImageLabel", hdr)
logoI.Size               = UDim2.new(0, 20, 0, 20)
logoI.Position           = UDim2.new(0, 10, 0.5, -10)
logoI.BackgroundTransparency = 1
logoI.Image              = "rbxassetid://10734946059"
logoI.ImageColor3        = MA

local titleL = Instance.new("TextLabel", hdr)
titleL.Size               = UDim2.new(1, -68, 1, 0)
titleL.Position           = UDim2.new(0, 34, 0, 0)
titleL.BackgroundTransparency = 1
titleL.Text               = "CHAOS"
titleL.TextColor3         = MT
titleL.TextSize            = 13
titleL.Font               = Enum.Font.GothamBold
titleL.TextXAlignment     = Enum.TextXAlignment.Left

local menuBtn = Instance.new("ImageButton", hdr)
menuBtn.Size             = UDim2.new(0, 28, 0, 28)
menuBtn.Position         = UDim2.new(1, -36, 0.5, -14)
menuBtn.BackgroundColor3 = MB2
menuBtn.BorderSizePixel  = 0
menuBtn.Image            = MOB_ICONS.MENU
menuBtn.ImageColor3      = MA
Instance.new("UICorner", menuBtn).CornerRadius = UDim.new(1, 0)

local grid = Instance.new("Frame", panel)
grid.Name             = "Grid"
grid.Size             = UDim2.new(1, -PAD*2, 0, 0)
grid.Position         = UDim2.new(0, PAD, 0, 50)
grid.BackgroundTransparency = 1
grid.AutomaticSize    = Enum.AutomaticSize.Y
grid.Visible          = false
grid.ClipsDescendants = false

local gl = Instance.new("UIGridLayout", grid)
gl.CellSize      = UDim2.new(0, GS, 0, GS + 20)
gl.CellPadding   = UDim2.new(0, GP, 0, GP)
gl.SortOrder     = Enum.SortOrder.LayoutOrder
gl.FillDirection = Enum.FillDirection.Horizontal
gl.HorizontalAlignment = Enum.HorizontalAlignment.Center

local mobOpen = false

local function setOpen(on)
    mobOpen = on
    if on then
        grid.Visible = true
        task.wait()
        local cH = grid.AbsoluteSize.Y
        mTw(panel, {Size = UDim2.new(0, PW, 0, 50 + cH + PAD)}, 0.22)
        mTw(menuBtn, {Rotation = 90}, 0.2)
    else
        mTw(panel, {Size = UDim2.new(0, PW, 0, 44)}, 0.18)
        mTw(menuBtn, {Rotation = 0}, 0.2)
        task.delay(0.2, function() grid.Visible = false end)
    end
end

local function mkBtn(icon, label, order, action, flagKey)
    local cell = Instance.new("Frame", grid)
    cell.BackgroundTransparency = 1
    cell.LayoutOrder = order

    local circ = Instance.new("TextButton", cell)
    circ.Size               = UDim2.new(0, BW, 0, BW)
    circ.Position           = UDim2.new(0.5, -BW/2, 0, 0)
    circ.BackgroundColor3   = MB3
    circ.BorderSizePixel    = 0
    circ.Text               = ""
    circ.AutoButtonColor    = false
    Instance.new("UICorner", circ).CornerRadius = UDim.new(1, 0)

    local cStr = Instance.new("UIStroke", circ)
    cStr.Color     = Color3.fromRGB(38, 38, 55)
    cStr.Thickness = 1.5

    local ico = Instance.new("ImageLabel", circ)
    ico.Size               = UDim2.new(0, 26, 0, 26)
    ico.Position           = UDim2.new(0.5, -13, 0.5, -13)
    ico.BackgroundTransparency = 1
    ico.Image              = icon
    ico.ImageColor3        = MD

    local dot
    if flagKey then
        dot = Instance.new("Frame", circ)
        dot.Size             = UDim2.new(0, 8, 0, 8)
        dot.Position         = UDim2.new(1, -9, 0, 1)
        dot.BackgroundColor3 = MD
        dot.BorderSizePixel  = 0
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    end

    local lbl = Instance.new("TextLabel", cell)
    lbl.Size               = UDim2.new(1, 0, 0, 16)
    lbl.Position           = UDim2.new(0, 0, 0, BW + 3)
    lbl.BackgroundTransparency = 1
    lbl.Text               = label
    lbl.TextColor3         = MD
    lbl.TextSize           = 9
    lbl.Font               = Enum.Font.GothamBold
    lbl.TextXAlignment     = Enum.TextXAlignment.Center
    lbl.TextTruncate       = Enum.TextTruncate.AtEnd

    local function refreshState()
        if not flagKey then return end
        local on = ChaosFlags[flagKey]
        if on then
            mTw(circ, {BackgroundColor3 = MA2}, 0.1)
            mTw(cStr, {Color = MA}, 0.1)
            mTw(ico,  {ImageColor3 = MA}, 0.1)
            mTw(lbl,  {TextColor3 = MA}, 0.1)
            if dot then mTw(dot, {BackgroundColor3 = MG}, 0.1) end
        else
            mTw(circ, {BackgroundColor3 = MB3}, 0.1)
            mTw(cStr, {Color = Color3.fromRGB(38, 38, 55)}, 0.1)
            mTw(ico,  {ImageColor3 = MD}, 0.1)
            mTw(lbl,  {TextColor3 = MD}, 0.1)
            if dot then mTw(dot, {BackgroundColor3 = MD}, 0.1) end
        end
    end
    refreshState()

    if flagKey then
        addConn(RunService.Heartbeat:Connect(refreshState))
    end

    circ.MouseButton1Click:Connect(function()
        mTw(circ, {Size = UDim2.new(0, BW-6, 0, BW-6), Position = UDim2.new(0.5, -(BW-6)/2, 0, 3)}, 0.07)
        task.delay(0.13, function()
            mTw(circ, {Size = UDim2.new(0, BW, 0, BW), Position = UDim2.new(0.5, -BW/2, 0, 0)}, 0.1)
        end)
        mTw(circ, {BackgroundColor3 = MA}, 0.07)
        task.delay(0.14, function()
            mTw(circ, {BackgroundColor3 = flagKey and (ChaosFlags[flagKey] and MA2 or MB3) or MB3}, 0.1)
        end)
        if flagKey then
            ChaosFlags[flagKey] = not ChaosFlags[flagKey]
            refreshState()
        end
        if action then pcall(action) end
    end)
end

local function quickShoot()
    local char = lp.Character
    if not char then return end
    local gun = char:FindFirstChild("Sheriff_Gun")
    if not gun then return end
    local remote = gun:FindFirstChildOfClass("RemoteEvent")
    if not remote then return end
    local myHRP = getHRP(lp)
    if not myHRP then return end
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp and getRoleOf(pl) == "Murderer" then
            local hrp = getHRP(pl)
            if hrp then
                local cf = CFrame.new(myHRP.Position, hrp.Position)
                pcall(function() remote:FireServer(cf, CFrame.new(hrp.Position)) end)
                return
            end
        end
    end
end

local function quickThrow()
    local char = lp.Character
    if not char then return end
    local knife = char:FindFirstChild("Knife")
    if not knife then return end
    local remote = knife:FindFirstChildOfClass("RemoteEvent")
    if not remote then return end
    local myHRP = getHRP(lp)
    if not myHRP then return end
    local nearest, nd = nil, math.huge
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp then
            local hrp = getHRP(pl)
            if hrp then
                local d = (hrp.Position - myHRP.Position).Magnitude
                if d < nd then nd = d nearest = pl end
            end
        end
    end
    if nearest then
        local hrp = getHRP(nearest)
        if hrp then
            pcall(function() remote:FireServer(CFrame.new(hrp.Position)) end)
        end
    end
end

local function quickReset()
    local hum = getHum(lp)
    if hum and hum.Health > 0 then hum.Health = 0 end
end

mkBtn(MOB_ICONS.SHOOT,   "Shoot",    1,  quickShoot,   nil)
mkBtn(MOB_ICONS.THROW,   "Throw",    2,  quickThrow,   nil)
mkBtn(MOB_ICONS.FLING,   "Fling",    3,  function()
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp then pcall(SkidFling, pl) return end
    end
end, nil)
mkBtn(MOB_ICONS.TP_MURD, "TP Murd",  4,  tpToMurderer, nil)
mkBtn(MOB_ICONS.TP_GUN,  "TP Gun",   5,  tpToGun,      nil)
mkBtn(MOB_ICONS.GRAB_GUN,"Grab Gun", 6,  grabGun,      nil)
mkBtn(MOB_ICONS.STEAL,   "Steal Gun",7,  stealGun,     nil)
mkBtn(MOB_ICONS.FLY,     "Fly",      8,  function()
    ChaosFlags["Toggle_Fly"] = not ChaosFlags["Toggle_Fly"]
    if ChaosFlags["Toggle_Fly"] then startFly() else stopFly() end
end, "Toggle_Fly")
mkBtn(MOB_ICONS.FARM,    "Farm",     9,  function()
    ChaosFlags["Toggle_AutoFarm"] = not ChaosFlags["Toggle_AutoFarm"]
    if ChaosFlags["Toggle_AutoFarm"] then StartFarm() else StopFarm() end
end, "Toggle_AutoFarm")
mkBtn(MOB_ICONS.BOX,     "Open Box", 10, openBox,       nil)
mkBtn(MOB_ICONS.HOP,     "Hop",      11, ServerHop,     nil)
mkBtn(MOB_ICONS.RESET,   "Reset",    12, quickReset,    nil)

menuBtn.MouseButton1Click:Connect(function() setOpen(not mobOpen) end)

local mDrag, mDrStart, mDrPos = false, nil, nil
hdr.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        mDrag   = true
        mDrStart = inp.Position
        mDrPos  = panel.Position
    end
end)
hdr.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        mDrag = false
    end
end)
UIS.InputChanged:Connect(function(inp)
    if mDrag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local d = inp.Position - mDrStart
        panel.Position = UDim2.new(mDrPos.X.Scale, mDrPos.X.Offset + d.X, mDrPos.Y.Scale, mDrPos.Y.Offset + d.Y)
    end
end)

local origClean = _G.ChaosCleanup
_G.ChaosCleanup = function()
    if origClean then pcall(origClean) end
    pcall(function() MobGui:Destroy() end)
end
