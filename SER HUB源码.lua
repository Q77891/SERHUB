local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Window = WindUI:CreateWindow({
  Title = "SER HUB",
  Icon = "crown",
  Author = "作者 Q7",
  Size = UDim2.fromOffset(600, 480),
  Transparent = true,
  Theme = "Dark",
  HideSearchBar = true,
  ScrollBarEnabled = true,
  Resizable = true,
  User = {
    Enabled = true,
    Callback = function() end,
    Anonymous = false
  }
})

local TimeTag = Window:Tag({
  Title = "00:00",
  Color = Color3.fromRGB(255, 255, 255)
})

local hue = 0
task.spawn(function()
  while true do
    local now = os.date("*t")
    local hours = string.format("%02d", now.hour)
    local minutes = string.format("%02d", now.min)
    
    hue = (hue + 0.01) % 1
    local rainbowColor = Color3.fromHSV(hue, 1, 1)
    
    TimeTag:SetTitle(hours .. ":" .. minutes)
    TimeTag:SetColor(rainbowColor) 

    task.wait(0.06)
  end
end)

Window:Tag({
  Title = "诞生于2026.12.20",
  Color = Color3.fromHex("#7FDBFF")
})

Window:EditOpenButton({
  Title = "SER HUB",
  Icon = "monitor",
  CornerRadius = UDim.new(0, 16),
  StrokeThickness = 2,
  Color = ColorSequence.new(Color3.fromHex("FF6B6B")),
  Draggable = true,
})

local HomeTab = Window:Tab({ Title = "主页", Icon = "house" })

local TimeLabel = HomeTab:Paragraph({
  Title = "游戏时长",
  Desc = "00:00:00",
})

local FpsLabel = HomeTab:Paragraph({
  Title = "当前帧数",
  Desc = "0 FPS",
})

local PingLabel = HomeTab:Paragraph({
  Title = "当前延迟",
  Desc = "0 ms",
})

local NoticeTab = Window:Tab({ Title = "公告", Icon = "megaphone" })

NoticeTab:Paragraph({
  Title = "欢迎使用",
  Desc = "欢迎使用SER HUB！"
})

NoticeTab:Paragraph({
  Title = "脚本说明",
  Desc = "有时更新很快，有时更新很慢"
})

NoticeTab:Button({
  Title = "复制交流群 932584465",
  Callback = function()
    setclipboard("932584465")
    WindUI:Notify({ Title = "已复制", Content = "群号已复制到剪贴板", Duration = 3 })
  end
})

local GeneralTab = Window:Tab({ Title = "通用", Icon = "sliders-horizontal" })
local ToolsTab = Window:Tab({ Title = "功能", Icon = "settings" })
local FlingTab = Window:Tab({ Title = "甩飞", Icon = "wind" })

local Scripts = {
  PlayerNotify = "https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua",
  FakeLag = "https://rawscripts.net/raw/Universal-Script-roblox-egor-script-53041",
  MasturbateR6 = "https://pastefy.app/wa3v2Vgm/raw",
  MasturbateR15 = "https://pastefy.app/YZoglOyJ/raw",
  InvincibleFly = "https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414",
  AntiAfkV2 = "https://pastebin.com/raw/9fFu43FF",
  DeathNote = "https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt",
  WallHop = "https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20WallHop%20V4%20script",
  FlingFenny = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/fe-flinger-gui-works-anywhere_1756291955889_SwfaGHMWsT.txt",
  AntiFling = "https://raw.githubusercontent.com/ChinaQY/Scripts/Main/AntiFling.lua",
  FlingAll = "https://pastebin.com/raw/zqyDSUWX",
  FlingHub = "https://raw.githubusercontent.com/3LD4D0/OP-FLING-GUI/c1fd15bf3114e6c9e4b76951b7d516c123836efe/OP%20FLING%20GUI%20R6%20AND%20R15",
  MobileKeyboard = "https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt",
  FPSBoost = "https://raw.githubusercontent.com/gclich/FPS-X-GUI/main/FPS_X.lua",
  FPSDisplay = "https://pastefy.app/d9j82YJr/raw",
  UnlockFPS = "https://scriptblox.com/raw/Universal-Script-FpsBoost-9260",
}

local ScriptNames = {
  { "PlayerNotify", "玩家通知" },
  { "FakeLag", "假延迟" },
  { "MasturbateR6", "R6 动作" },
  { "MasturbateR15", "R15 动作" },
  { "InvincibleFly", "无敌飞行 R15" },
  { "AntiAfkV2", "防挂机 V2" },
  { "DeathNote", "死亡笔记" },
  { "WallHop", "爬墙" },
  { "FlingFenny", "甩飞" },
  { "AntiFling", "防甩飞" },
  { "FlingAll", "全屏甩飞" },
  { "FlingHub", "甩飞菜单" },
  { "MobileKeyboard", "手机键盘" },
  { "FPSBoost", "帧数提升" },
  { "FPSDisplay", "帧数显示" },
  { "UnlockFPS", "解锁帧率" },
}
local function runScript(url)
  local ok, err = pcall(function()
    loadstring(game:HttpGet(url))()
  end)
  if ok then
    WindUI:Notify({ Title = "已执行", Content = "脚本加载完成", Duration = 3 })
  else
    WindUI:Notify({ Title = "执行失败", Content = tostring(err), Duration = 4 })
  end
end

local function resetCharacter()
  if LocalPlayer.Character then
    LocalPlayer.Character.Humanoid.Health = 0
  end
end

local function rejoinServer()
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end

local function leaveServer()
  game:Shutdown()
end

local function giveTeleportTool()
  local tool = Instance.new("Tool")
  tool.RequiresHandle = false
  tool.Name = "点击传送"
  tool.Activated:Connect(function()
    local mouse = LocalPlayer:GetMouse()
    if LocalPlayer.Character then
      LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 2.5, 0))
    end
  end)
  tool.Parent = LocalPlayer.Backpack
end

local function antiKick()
  local vu = game:GetService("VirtualUser")
  LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
  end)
end

local function showTime()
  local LBLG = Instance.new("ScreenGui")
  local LBL = Instance.new("TextLabel")
  LBLG.Name = "LBLG"
  LBLG.Parent = game.CoreGui
  LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  LBLG.Enabled = true

  LBL.Name = "LBL"
  LBL.Parent = LBLG
  LBL.BackgroundTransparency = 1
  LBL.Position = UDim2.new(0.75,0,0.010,0)
  LBL.Size = UDim2.new(0, 133, 0, 30)
  LBL.Font = Enum.Font.GothamSemibold
  LBL.TextColor3 = Color3.new(1, 1, 1)
  LBL.TextScaled = true
  LBL.TextSize = 14
  LBL.TextWrapped = true
  LBL.Visible = true

  game:GetService("RunService").Heartbeat:Connect(function()
    LBL.Text = "当前时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S")
  end)
end

GeneralTab:Slider({
  Title = "移动速度",
  Desc = "修改角色移动速度",
  Value = { Min = 16, Max = 300, Default = 16 },
  Step = 1,
  Callback = function(value)
    local char = LocalPlayer.Character
    if char then
      local hum = char:FindFirstChildOfClass("Humanoid")
      if hum then hum.WalkSpeed = value end
    end
  end,
})

GeneralTab:Slider({
  Title = "跳跃高度",
  Desc = "修改角色跳跃力度",
  Value = { Min = 50, Max = 200, Default = 50 },
  Step = 1,
  Callback = function(value)
    local char = LocalPlayer.Character
    if char then
      local hum = char:FindFirstChildOfClass("Humanoid")
      if hum then
        hum.JumpPower = value
        hum.UseJumpPower = true
      end
    end
  end,
})

GeneralTab:Slider({
  Title = "重力设置",
  Desc = "修改世界重力",
  Value = { Min = 1, Max = 500, Default = Workspace.Gravity },
  Step = 1,
  Callback = function(value)
    Workspace.Gravity = value
  end,
})

getgenv().InfJ = false

GeneralTab:Toggle({
  Title = "无限跳",
  Callback = function(state)
    getgenv().InfJ = state
    if state then
      WindUI:Notify({ Title = "成功", Content = "无限跳已开启", Duration = 3 })
    end
  end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
  if getgenv().InfJ then
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
  end
end)

local Clipon = false
local SteppedConnection = nil

local function ToggleNoclip(enabled)
  Clipon = enabled
  if enabled then
    if not SteppedConnection then
      SteppedConnection = RunService.Stepped:Connect(function()
        if Clipon then
          local char = LocalPlayer.Character
          if char then
            for _, part in pairs(char:GetDescendants()) do
              if part:IsA("BasePart") then
                part.CanCollide = false
              end
            end
          end
        end
      end)
    end
  else
    if SteppedConnection then
      SteppedConnection:Disconnect()
      SteppedConnection = nil
    end
    local char = LocalPlayer.Character
    if char then
      for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
          part.CanCollide = true
        end
      end
    end
  end
end

GeneralTab:Toggle({
  Title = "穿墙",
  Callback = function(state)
    ToggleNoclip(state)
  end,
})

GeneralTab:Button({
  Title = "飞行",
  Callback = function()
    runScript("https://raw.githubusercontent.com/Q77891/SERHUB/refs/heads/main/raw.txt")
  end,
})

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- 绕过飞行
local BypassFly = {
  Speed = 100,
  Enabled = false,
  HRP = nil,
  Humanoid = nil,
  TargetPos = nil,
  LastTime = 0,
  MicroThread = nil,
  HealthThread = nil,
  DiedConnection = nil,
  AnchorActive = false,
  Control = nil,
  RayLength = 3.5,
  RayCount = 12,
  VerticalLayers = 3,
}

pcall(function()
  local playerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule")
  if playerModule then
    BypassFly.Control = require(playerModule):GetControls()
  end
end)

function BypassFly:Refresh()
  local character = LocalPlayer.Character
  self.HRP = character and character:FindFirstChild("HumanoidRootPart")
  self.Humanoid = character and character:FindFirstChildOfClass("Humanoid")
end

function BypassFly:DetectWall()
  local hrp = self.HRP
  if not hrp then return false end
  local params = RaycastParams.new()
  params.FilterType = Enum.RaycastFilterType.Exclude
  params.FilterDescendantsInstances = { LocalPlayer.Character }
  for i = 1, self.RayCount do
    local angle = i / self.RayCount * math.pi * 2
    local x, z = math.cos(angle), math.sin(angle)
    for layer = -1, 1 do
      local direction = Vector3.new(x, layer * 0.5, z).Unit * self.RayLength
      local hit = Workspace:Raycast(hrp.Position, direction, params)
      if hit and hit.Instance and hit.Instance.CanCollide and hit.Instance.Transparency < 0.9 then
        return true
      end
    end
  end
  return false
end

function BypassFly:SetAnchor(enabled)
  if enabled == self.AnchorActive then return end
  local character = LocalPlayer.Character
  local head = character and character:FindFirstChild("Head")
  if enabled then
    if head and self.Humanoid then
      head.Anchored = true
      self.Humanoid.PlatformStand = true
      self.AnchorActive = true
    end
  else
    if head then head.Anchored = false end
    if self.Humanoid then self.Humanoid.PlatformStand = false end
    self.AnchorActive = false
  end
end

function BypassFly:Stop()
  self.Enabled = false
  self:SetAnchor(false)
  for _, key in ipairs({"MicroThread", "HealthThread"}) do
    if self[key] then
      pcall(task.cancel, self[key])
      self[key] = nil
    end
  end
  if self.DiedConnection then
    self.DiedConnection:Disconnect()
    self.DiedConnection = nil
  end
  if self.Humanoid then
    self.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
  end
end

function BypassFly:Start()
  if self.Enabled then return end
  self:Refresh()
  if not self.HRP or not self.Humanoid then
    WindUI:Notify({Title = "绕过飞行", Content = "角色尚未加载", Duration = 3})
    return
  end
  self.Enabled = true
  self.Humanoid:ChangeState(Enum.HumanoidStateType.Climbing)
  self.TargetPos = self.HRP.Position
  self.LastTime = tick()
  self.MicroThread = task.spawn(function()
    while self.Enabled do
      local now = tick()
      local dt = now - self.LastTime
      self.LastTime = now
      if not self.HRP or not self.HRP.Parent then break end
      self:SetAnchor(self:DetectWall())
      local moveDirection
      if self.Control then
        local move = self.Control:GetMoveVector()
        local camera = Workspace.CurrentCamera.CFrame
        moveDirection = camera.LookVector * -move.Z + camera.RightVector * move.X
      else
        moveDirection = self.Humanoid and self.Humanoid.MoveDirection or Vector3.zero
      end
      local vertical = 0
      if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        vertical = 1
      elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        vertical = -1
      end
      self.TargetPos += (moveDirection + Vector3.new(0, vertical, 0)) * self.Speed * dt
      local offset = self.TargetPos - self.HRP.Position
      local steps = math.max(1, math.ceil(offset.Magnitude / 10))
      local step = offset / steps
      for _ = 1, steps do
        if not self.Enabled then break end
        local nextPosition = self.HRP.Position + step
        self.HRP.CFrame = CFrame.new(nextPosition) * self.HRP.CFrame.Rotation
        self.HRP.AssemblyLinearVelocity = Vector3.zero
      end
      if self.Humanoid then
        self.Humanoid:ChangeState(Enum.HumanoidStateType.Climbing)
      end
      task.wait(0.001)
    end
  end)
  self.HealthThread = task.spawn(function()
    while self.Enabled do
      if self.Humanoid and self.Humanoid.Health <= 0 then
        self.Humanoid.Health = self.Humanoid.MaxHealth
      end
      task.wait(0.1)
    end
  end)
  self.DiedConnection = self.Humanoid.Died:Connect(function()
    if self.Enabled and self.Humanoid then
      self.Humanoid.Health = self.Humanoid.MaxHealth
      self.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
    end
  end)
end

GeneralTab:Toggle({
  Title = "绕过飞行",
  Desc = "使用角色移动控制进行飞行",
  Callback = function(state)
    if state then
      BypassFly:Start()
    else
      BypassFly:Stop()
    end
    WindUI:Notify({Title = "绕过飞行", Content = state and "已开启" or "已关闭", Duration = 3})
  end,
})

GeneralTab:Slider({
  Title = "绕过飞行速度",
  Desc = "调整绕过飞行移动速度",
  Value = {Min = 10, Max = 500, Default = 100},
  Step = 1,
  Callback = function(value)
    BypassFly.Speed = value
  end,
})

LocalPlayer.CharacterAdded:Connect(function()
  if BypassFly.Enabled then
    BypassFly:Stop()
    task.wait(0.25)
    BypassFly:Start()
  end
end)

-- 飞车
local FlyingCar = {
  Enabled = false,
  Speed = 50,
  Velocity = nil,
  Gyro = nil,
  Connection = nil,
}

function FlyingCar:Stop()
  self.Enabled = false
  if self.Connection then
    self.Connection:Disconnect()
    self.Connection = nil
  end
  if self.Velocity then
    self.Velocity:Destroy()
    self.Velocity = nil
  end
  if self.Gyro then
    self.Gyro:Destroy()
    self.Gyro = nil
  end
end

function FlyingCar:Start()
  self:Stop()
  local character = LocalPlayer.Character
  local hrp = character and character:FindFirstChild("HumanoidRootPart")
  if not hrp then
    WindUI:Notify({Title = "飞车", Content = "角色尚未加载", Duration = 3})
    return
  end
  self.Enabled = true
  self.Velocity = Instance.new("BodyVelocity")
  self.Velocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
  self.Velocity.Velocity = Vector3.zero
  self.Velocity.Parent = hrp
  self.Gyro = Instance.new("BodyGyro")
  self.Gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
  self.Gyro.P = 100000
  self.Gyro.D = 5000
  self.Gyro.Parent = hrp
  self.Connection = RunService.RenderStepped:Connect(function()
    if not self.Enabled or not self.Velocity or not self.Velocity.Parent or not self.Gyro or not self.Gyro.Parent then
      return
    end
    local camera = Workspace.CurrentCamera
    if camera then
      self.Velocity.Velocity = camera.CFrame.LookVector * self.Speed
      self.Gyro.CFrame = camera.CFrame
    end
  end)
end

GeneralTab:Toggle({
  Title = "飞车",
  Desc = "沿摄像机朝向持续移动",
  Callback = function(state)
    if state then FlyingCar:Start() else FlyingCar:Stop() end
    WindUI:Notify({Title = "飞车", Content = state and "已开启" or "已关闭", Duration = 3})
  end,
})

GeneralTab:Slider({
  Title = "飞车速度",
  Value = {Min = 10, Max = 500, Default = 50},
  Step = 1,
  Callback = function(value)
    FlyingCar.Speed = value
  end,
})

LocalPlayer.CharacterAdded:Connect(function()
  if FlyingCar.Enabled then
    task.wait(0.3)
    FlyingCar:Start()
  end
end)

-- 解锁跳跃：屏幕上的可拖动跳跃按钮
local JumpUnlock = {
  Enabled = false,
  Power = 60,
  Gui = nil,
}

function JumpUnlock:Stop()
  self.Enabled = false
  if self.Gui then
    self.Gui:Destroy()
    self.Gui = nil
  end
end

function JumpUnlock:Start()
  self:Stop()
  self.Enabled = true
  local gui = Instance.new("ScreenGui")
  gui.Name = "SERHubJumpUnlock"
  gui.ResetOnSpawn = false
  gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  gui.Parent = CoreGui
  self.Gui = gui

  local jumpButton = Instance.new("TextButton")
  jumpButton.Size = UDim2.fromOffset(60, 60)
  jumpButton.Position = UDim2.new(1, -80, 1, -80)
  jumpButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
  jumpButton.Text = "↑"
  jumpButton.TextColor3 = Color3.new(1, 1, 1)
  jumpButton.TextSize = 40
  jumpButton.Font = Enum.Font.SourceSansBold
  jumpButton.Active = true
  jumpButton.Draggable = true
  jumpButton.Parent = gui
  Instance.new("UICorner", jumpButton).CornerRadius = UDim.new(1, 0)

  local settingsButton = Instance.new("TextButton")
  settingsButton.Size = UDim2.fromOffset(28, 28)
  settingsButton.Position = UDim2.new(1, -92, 1, -112)
  settingsButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
  settingsButton.Text = "⚙"
  settingsButton.TextColor3 = Color3.new(1, 1, 1)
  settingsButton.TextSize = 18
  settingsButton.Active = true
  settingsButton.Draggable = true
  settingsButton.Parent = gui
  Instance.new("UICorner", settingsButton).CornerRadius = UDim.new(1, 0)

  local panel = Instance.new("Frame")
  panel.Size = UDim2.fromOffset(220, 140)
  panel.Position = UDim2.new(1, -240, 1, -160)
  panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  panel.Visible = false
  panel.Parent = gui
  Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 8)

  local close = Instance.new("TextButton")
  close.Size = UDim2.fromOffset(22, 22)
  close.Position = UDim2.new(1, -27, 0, 5)
  close.Text = "X"
  close.Parent = panel
  close.MouseButton1Click:Connect(function() panel.Visible = false end)

  local label = Instance.new("TextLabel")
  label.Size = UDim2.new(1, -35, 0, 30)
  label.Position = UDim2.fromOffset(10, 5)
  label.BackgroundTransparency = 1
  label.Text = "跳跃力度：" .. self.Power
  label.TextColor3 = Color3.new(1, 1, 1)
  label.Font = Enum.Font.SourceSansBold
  label.Parent = panel

  local input = Instance.new("TextBox")
  input.Size = UDim2.new(0.6, 0, 0, 30)
  input.Position = UDim2.new(0.2, 0, 0, 50)
  input.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
  input.Text = tostring(self.Power)
  input.TextColor3 = Color3.new(1, 1, 1)
  input.Parent = panel
  Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

  local confirm = Instance.new("TextButton")
  confirm.Size = UDim2.new(0.4, 0, 0, 30)
  confirm.Position = UDim2.new(0.1, 0, 0, 90)
  confirm.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
  confirm.Text = "确认"
  confirm.TextColor3 = Color3.new(1, 1, 1)
  confirm.Parent = panel
  confirm.MouseButton1Click:Connect(function()
    local number = tonumber(input.Text)
    if number and number >= 16 and number <= 100 then
      self.Power = number
      label.Text = "跳跃力度：" .. self.Power
    end
  end)

  local reset = Instance.new("TextButton")
  reset.Size = UDim2.new(0.4, 0, 0, 30)
  reset.Position = UDim2.new(0.5, 0, 0, 90)
  reset.BackgroundColor3 = Color3.fromRGB(190, 90, 0)
  reset.Text = "默认"
  reset.TextColor3 = Color3.new(1, 1, 1)
  reset.Parent = panel
  reset.MouseButton1Click:Connect(function()
    self.Power = 60
    input.Text = "60"
    label.Text = "跳跃力度：60"
  end)

  settingsButton.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
  end)
  jumpButton.MouseButton1Click:Connect(function()
    if not self.Enabled then return end
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if hrp and humanoid and humanoid.Health > 0 and humanoid.FloorMaterial ~= Enum.Material.Air then
      hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, self.Power, hrp.AssemblyLinearVelocity.Z)
    end
  end)
end

GeneralTab:Toggle({
  Title = "解锁跳跃",
  Desc = "显示可拖动的额外跳跃按钮",
  Callback = function(state)
    if state then JumpUnlock:Start() else JumpUnlock:Stop() end
    WindUI:Notify({Title = "解锁跳跃", Content = state and "跳跃按钮已显示" or "跳跃按钮已隐藏", Duration = 3})
  end,
})

-- 灵魂出窍
local Soul = {
  Enabled = false,
  NoReturn = false,
  Origin = nil,
  OriginalCharacter = nil,
  CloneCharacter = nil,
  OldDestroyHeight = nil,
  RespawnConnection = nil,
  OriginalTransparency = {},
}

function Soul:RestoreTransparency()
  for part, transparency in pairs(self.OriginalTransparency) do
    pcall(function()
      if part and part.Parent then part.Transparency = transparency end
    end)
  end
  table.clear(self.OriginalTransparency)
end

function Soul:ApplyTransparency(character, transparency)
  if not character then return end
  for _, item in ipairs(character:GetDescendants()) do
    if item:IsA("BasePart") or item:IsA("Decal") then
      if self.OriginalTransparency[item] == nil then
        self.OriginalTransparency[item] = item.Transparency
      end
      item.Transparency = transparency
    end
  end
end

function Soul:Reset()
  self.Enabled = false
  self.Origin = nil
  if self.RespawnConnection then
    self.RespawnConnection:Disconnect()
    self.RespawnConnection = nil
  end
  self:RestoreTransparency()
  if self.CloneCharacter then
    pcall(function() self.CloneCharacter:Destroy() end)
  end
  self.CloneCharacter = nil
  self.OriginalCharacter = nil
  if self.OldDestroyHeight ~= nil then
    pcall(function() Workspace.FallenPartsDestroyHeight = self.OldDestroyHeight end)
    self.OldDestroyHeight = nil
  end
end

function Soul:Start()
  if self.Enabled then return end
  local original = LocalPlayer.Character
  if not original or not original:FindFirstChild("HumanoidRootPart") then
    WindUI:Notify({Title = "灵魂出窍", Content = "角色尚未加载", Duration = 3})
    return
  end
  pcall(function() original.Archivable = true end)
  local ok, clone = pcall(function() return original:Clone() end)
  if not ok or not clone then
    WindUI:Notify({Title = "灵魂出窍", Content = "角色克隆失败", Duration = 3})
    return
  end

  self.Enabled = true
  self.OriginalCharacter = original
  self.CloneCharacter = clone
  self.Origin = original.HumanoidRootPart.CFrame
  self.OldDestroyHeight = Workspace.FallenPartsDestroyHeight
  Workspace.FallenPartsDestroyHeight = -50000
  clone.Parent = Workspace
  LocalPlayer.Character = clone

  for _, item in ipairs(clone:GetDescendants()) do
    if item:IsA("BasePart") or item:IsA("Decal") then
      item.Transparency = 0.5
    end
  end
  local cloneHumanoid = clone:FindFirstChildOfClass("Humanoid")
  if cloneHumanoid and Workspace.CurrentCamera then
    Workspace.CurrentCamera.CameraSubject = cloneHumanoid
  end
  local originalRoot = original:FindFirstChild("HumanoidRootPart")
  if originalRoot then originalRoot.Anchored = true end

  self.RespawnConnection = LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    self:Reset()
    task.defer(function()
      local humanoid = newCharacter and newCharacter:FindFirstChildOfClass("Humanoid")
      if humanoid and Workspace.CurrentCamera then
        Workspace.CurrentCamera.CameraSubject = humanoid
      end
    end)
  end)
  WindUI:Notify({Title = "灵魂出窍", Content = "已开启", Duration = 3})
end

function Soul:Stop()
  if not self.Enabled then return end
  self.Enabled = false
  local clone = self.CloneCharacter
  local original = self.OriginalCharacter
  local destination = nil
  if clone and clone.Parent then
    local root = clone:FindFirstChild("HumanoidRootPart")
    if root then destination = root.CFrame end
  end
  if original then
    local root = original:FindFirstChild("HumanoidRootPart")
    if root then root.Anchored = false end
  end
  self:RestoreTransparency()
  if self.RespawnConnection then
    self.RespawnConnection:Disconnect()
    self.RespawnConnection = nil
  end
  if clone then pcall(function() clone:Destroy() end) end
  self.CloneCharacter = nil
  if original and original.Parent then
    LocalPlayer.Character = original
    if not self.NoReturn and self.Origin then
      pcall(function() original:MoveTo(self.Origin.Position) end)
    elseif destination then
      pcall(function() original:MoveTo(destination.Position) end)
    end
    local humanoid = original:FindFirstChildOfClass("Humanoid")
    if humanoid and Workspace.CurrentCamera then
      Workspace.CurrentCamera.CameraSubject = humanoid
    end
  end
  self.OriginalCharacter = nil
  self.Origin = nil
  if self.OldDestroyHeight ~= nil then
    pcall(function() Workspace.FallenPartsDestroyHeight = self.OldDestroyHeight end)
    self.OldDestroyHeight = nil
  end
  WindUI:Notify({Title = "灵魂出窍", Content = "已关闭", Duration = 3})
end

GeneralTab:Toggle({
  Title = "灵魂出窍",
  Desc = "原角色留在原地，控制半透明分身",
  Callback = function(state)
    if state then Soul:Start() else Soul:Stop() end
  end,
})

GeneralTab:Toggle({
  Title = "灵魂出窍关闭时不回原点",
  Desc = "关闭后留在分身所在位置",
  Callback = function(state)
    Soul.NoReturn = state
  end,
})

GeneralTab:Button({
  Title = "爬墙",
  Callback = function()
    runScript("https://pastebin.com/raw/zXk4Rq2r")
  end,
})

ToolsTab:Divider()

ToolsTab:Paragraph({
  Title = "基础功能",
  Desc = "",
  ImageSize = 0
})

ToolsTab:Button({
  Title = "重置人物",
  Callback = function() resetCharacter() end,
})

ToolsTab:Button({
  Title = "重进服务器",
  Callback = function() rejoinServer() end,
})

ToolsTab:Button({
  Title = "离开服务器",
  Callback = function() leaveServer() end,
})

ToolsTab:Button({
  Title = "点击传送工具",
  Callback = function() giveTeleportTool() end,
})
ToolsTab:Button({
  Title = "防踢出/防挂机",
  Callback = function() antiKick() end,
})

ToolsTab:Button({
  Title = "显示北京时间",
  Callback = function() showTime() end,
})

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
  prompt.HoldDuration = 0
end)

ToolsTab:Divider()

ToolsTab:Paragraph({
  Title = "聊天与社交",
  Desc = "",
  ImageSize = 0
})

ToolsTab:Button({
  Title = "聊天框画画脚本",
  Callback = function() runScript(Scripts.PlayerNotify) end,
})

ToolsTab:Button({
  Title = "忍者键盘",
  Callback = function() runScript(Scripts.MobileKeyboard) end,
})

ToolsTab:Divider()

ToolsTab:Paragraph({
  Title = "系统与辅助",
  Desc = "",
  ImageSize = 0
})

ToolsTab:Button({
  Title = "防挂机 V2",
  Callback = function() runScript(Scripts.AntiAfkV2) end,
})

ToolsTab:Button({
  Title = "帧数显示",
  Callback = function() runScript(Scripts.FPSDisplay) end,
})

ToolsTab:Button({
  Title = "解锁帧率",
  Callback = function() runScript(Scripts.UnlockFPS) end,
})

ToolsTab:Button({
  Title = "帧数提升",
  Callback = function() runScript(Scripts.FPSBoost) end,
})

ToolsTab:Divider()

ToolsTab:Paragraph({
  Title = "其他脚本",
  Desc = "",
  ImageSize = 0
})

for _, item in ipairs(ScriptNames) do
  local key = item[1]
  local label = item[2]

  if key ~= "PlayerNotify" and key ~= "MobileKeyboard" and key ~= "AntiAfkV2" and key ~= "FPSDisplay" and key ~= "UnlockFPS" and key ~= "FPSBoost" then
    ToolsTab:Button({
      Title = label,
      Callback = function() runScript(Scripts[key]) end,
    })
  end
end

local TargetPlayerName = ""
local LoopTPEnabled = false
local LoopTPAllEnabled = false
local FlingLoopEnabled = false
local FlingAllLoopEnabled = false
local AntiFlingEnabled = false
local TPThread = nil
local TPAllThread = nil
local FlingThread = nil
local FlingAllThread = nil
local AntiFlingConn = nil

local function GetPlayerList()
  local list = {}
  for _, v in ipairs(Players:GetPlayers()) do
    if v ~= LocalPlayer then
      table.insert(list, v.Name)
    end
  end
  return list
end

local PlayerDropdown = FlingTab:Dropdown({
  Title = "选择目标玩家",
  Values = GetPlayerList(),
  Value = "",
  Callback = function(selected)
    TargetPlayerName = selected
  end,
})

task.spawn(function()
  while true do
    task.wait(2)
    pcall(function()
      if PlayerDropdown and PlayerDropdown.SetOptions then
        PlayerDropdown:SetOptions(GetPlayerList())
      end
    end)
  end
end)

local function TeleportToSelected()
  local Target = Players:FindFirstChild(TargetPlayerName)
  local MyHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") and MyHRP then
    MyHRP.CFrame = Target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
  end
end

FlingTab:Divider()

FlingTab:Button({
  Title = "传送到选中玩家",
  Callback = function()
    TeleportToSelected()
  end,
})

FlingTab:Toggle({
  Title = "循环传送选中玩家",
  Callback = function(state)
    LoopTPEnabled = state
    if TPThread then task.cancel(TPThread); TPThread = nil end
    if state then
      TPThread = task.spawn(function()
        while LoopTPEnabled do
          task.wait(0.01)
          TeleportToSelected()
        end
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "循环传送所有人",
  Callback = function(state)
    LoopTPAllEnabled = state
    if TPAllThread then task.cancel(TPAllThread); TPAllThread = nil end
    if state then
      TPAllThread = task.spawn(function()
        while LoopTPAllEnabled do
          for _, Target in ipairs(Players:GetPlayers()) do
            if not LoopTPAllEnabled then break end
            if Target ~= LocalPlayer and Target.Character then
              local TargetHRP = Target.Character:FindFirstChild("HumanoidRootPart")
              local MyHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
              if TargetHRP and MyHRP then
                for i = 1, 3 do
                  if not LoopTPAllEnabled then break end
                  MyHRP.CFrame = TargetHRP.CFrame * CFrame.new(0, 0, -1.5)
                  task.wait(0.05)
                  MyHRP.CFrame = TargetHRP.CFrame + Vector3.new(0, 0, 1.5)
                  task.wait(0.05)
                end
                task.wait(0.2)
              end
            end
          end
          task.wait(0.1)
        end
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "查看选中玩家",
  Callback = function(state)
    if state then
      local Target = Players:FindFirstChild(TargetPlayerName)
      if Target and Target.Character and Target.Character:FindFirstChild("Humanoid") then
        Workspace.CurrentCamera.CameraSubject = Target.Character.Humanoid
      end
    else
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
      end
    end
  end,
})

FlingTab:Divider()

FlingTab:Button({
  Title = "甩飞选中玩家",
  Callback = function()
    pcall(function()
      loadstring(game:HttpGet("https://pastefy.app/od3cnFl6/raw"))()
    end)
  end,
})

FlingTab:Toggle({
  Title = "循环甩飞选中玩家",
  Callback = function(state)
    FlingLoopEnabled = state
    if FlingThread then task.cancel(FlingThread); FlingThread = nil end
    if state then
      FlingThread = task.spawn(function()
        while FlingLoopEnabled do
          TeleportToSelected()
          if FlingLoopEnabled then
            pcall(function()
              loadstring(game:HttpGet("https://pastefy.app/od3cnFl6/raw"))()
            end)
          end
          task.wait(0.1)
        end
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "循环甩飞所有人",
  Callback = function(state)
    FlingAllLoopEnabled = state
    if FlingAllThread then task.cancel(FlingAllThread); FlingAllThread = nil end
    if state then
      FlingAllThread = task.spawn(function()
        while FlingAllLoopEnabled do
          task.wait(0.5)
          pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
          end)
        end
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "防甩飞",
  Callback = function(state)
    AntiFlingEnabled = state
    if state then
      if not AntiFlingConn then
        AntiFlingConn = RunService.Heartbeat:Connect(function()
          if not AntiFlingEnabled then return end
          local char = LocalPlayer.Character
          if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp and (hrp.AssemblyAngularVelocity.Magnitude > 50 or hrp.AssemblyLinearVelocity.Magnitude > 100) then
              for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                  v.CanCollide = false
                  v.AssemblyAngularVelocity = Vector3.zero
                  v.AssemblyLinearVelocity = Vector3.zero
                end
              end
            end
          end
        end)
      end
    else
      if AntiFlingConn then
        AntiFlingConn:Disconnect()
        AntiFlingConn = nil
      end
    end
  end,
})

do
  local startTime = os.clock()
  local frameCount = 0
  local lastFps = 0

  local function setDesc(obj, text)
    if obj and obj.SetDesc then
      obj:SetDesc(text)
    elseif obj and obj.Desc and obj.Desc.SetText then
      obj.Desc:SetText(text)
    end
  end

  local function fmtTime(sec)
    local h = math.floor(sec / 3600)
    local m = math.floor((sec % 3600) / 60)
    local s = math.floor(sec % 60)
    return string.format("%02d:%02d:%02d", h, m, s)
  end

  local function getPing()
    local ok, ping = pcall(function()
      return math.floor(LocalPlayer:GetNetworkPing() * 1000)
    end)
    if ok and ping then return ping end
    return 0
  end

  game:GetService("RunService").RenderStepped:Connect(function()
    frameCount = frameCount + 1
  end)

  task.spawn(function()
    while true do
      task.wait(1)
      lastFps = frameCount
      frameCount = 0
      setDesc(FpsLabel, lastFps .. " FPS")
      setDesc(PingLabel, getPing() .. " ms")
      setDesc(TimeLabel, fmtTime(os.clock() - startTime))
    end
  end)
end