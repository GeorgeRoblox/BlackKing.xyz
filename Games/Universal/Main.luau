local LoadStart = tick()
-- yes
local Library = BlacKing.Interface.Library
local SaveManager = BlacKing.Interface.SaveManager
local ThemeManager = BlacKing.Interface.ThemeManager

local function CloneReference(Object)
	if BlacKing and BlacKing.Environment.cloneref then
		return BlacKing.Environment.cloneref(Object)
	end
	return Object
end

		local Functions = {}
		local Connections = {}
		local Globals = {}

		local Services = setmetatable({}, {
		__index = function(self, Key)
			return game:GetService(Key)
		end
	})

	local Player = Services.Players.LocalPlayer

	local Character = Player.Character
	while Character == nil do
		task.wait()
		Character = Player.Character
	end

    local notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/GeorgeRoblox/Rhyans-notification/refs/heads/main/Notification20%25yes.lua"))()

George = "https://raw.githubusercontent.com/GeorgeRoblox/Notification/refs/heads/main/Images/George.jpg"
Upio = "https://raw.githubusercontent.com/GeorgeRoblox/Notification/refs/heads/main/Images/Upio.png"
FireBacon = "https://raw.githubusercontent.com/GeorgeRoblox/Notification/refs/heads/main/FireBacon.jpg"

notify("BlackKing", {
	Title = "Upio",
	Description = "MSPAINT MSPAINT MSPAINT MSPAINT MSPAINT MSPAINT",
	Image = Upio,
	Color = Color3.fromRGB(255, 222, 189),
	Time = 5
})

	local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/ESPLibrary/refs/heads/main/Library.lua"))()
	ESPLibrary:SetRainbow(false)
	ESPLibrary:SetShowDistance(false)
	ESPLibrary:SetFillTransparency(0.75)
	ESPLibrary:SetOutlineTransparency(0)
	ESPLibrary:SetFadeTime(0.25)
	ESPLibrary:SetTextSize(18)
	ESPLibrary:SetFont(Enum.Font.RobotoCondensed)
	ESPLibrary:SetTracers(false)
	ESPLibrary:SetTracerSize(0.75)
	ESPLibrary:SetTracerOrigin("Bottom")
	ESPLibrary:SetArrows(false)
	ESPLibrary:SetArrowRadius(250)
	ESPLibrary:SetDistanceSizeRatio(0.8)
	
	local Options = Library.Options
	local Toggles = Library.Toggles

	local Window = Library:CreateWindow({
		Title = "BlackKing | Universal",
		Center = true,
		AutoShow = true,
		Resizable = true,
		ShowCustomCursor = true,
		UnlockMouseWhileOpen = true,
		NotifySide = "Right",
		TabPadding = 8,
		MenuFadeTime = 0.2
	})

	local Tabs = {
		Info = Window:AddTab("Info", "info"),
		Main = Window:AddTab("General", "globe"),
		Visual = Window:AddTab("Visuals", "eye"),
        Addons = Window:AddTab("Addons", "puzzle"),
		["UI Settings"] = Window:AddTab("UI Settings", "settings"),
	}

	getgenv().Bk = true

local AddonsGroup = Tabs.Addons:AddLeftGroupbox("Create Addon")

local addonsFolder = "BlackKing/Addons"
local addonstxtfile = addonsFolder .. "/AddonsBlackKing.txt"

if not isfolder(addonsFolder) then
	makefolder(addonsFolder)
end

local addonLoaded = false
local loadedElements = {}

AddonsGroup:AddButton("Create Addon", function()
	if not isfile(addonstxtfile) then
		writefile(addonstxtfile, [[local Tabs, Library, Options, Toggles, notify, George = ...
]])
	end
end)

AddonsGroup:AddButton("Load Addon", function()
	if addonLoaded then
		warn("Addon is already loaded.")
		return
	end

	if isfile(addonstxtfile) then
		local content = readfile(addonstxtfile)
		local addonFunc, err = loadstring(content)
		if addonFunc then

			local trackedAddons = setmetatable({}, {
				__index = Tabs.Addons,
				__newindex = Tabs.Addons
			})

			local originalAddLeft = Tabs.Addons.AddLeftGroupbox
			local originalAddRight = Tabs.Addons.AddRightGroupbox

			Tabs.Addons.AddLeftGroupbox = function(self, ...)
				local box = originalAddLeft(self, ...)
				table.insert(loadedElements, box)
				return box
			end
			Tabs.Addons.AddRightGroupbox = function(self, ...)
				local box = originalAddRight(self, ...)
				table.insert(loadedElements, box)
				return box
			end

			addonFunc(Tabs, Library, Options, Toggles, notify)

			Tabs.Addons.AddLeftGroupbox = originalAddLeft
			Tabs.Addons.AddRightGroupbox = originalAddRight

			addonLoaded = true
		else
			warn("Failed to load addon file: " .. tostring(err))
		end
	else
		warn("Addon file does not exist yet.")
	end
end)

AddonsGroup:AddButton("Clear Addon", function()
	for _, element in loadedElements do
		if element and element.Container then
			element.Container:Destroy()
		elseif element and element.Destroy then
			element:Destroy()
		end
	end
	loadedElements = {}
	addonLoaded = false
end)

B.Interface.ApplyInfoTab(Window)

		local mntab = Tabs.Main:AddLeftTabbox()
		local mainft = mntab:AddTab('localplayer')

	WSConnection = {}
	CurrentWS = 16
	WS_Enabled = false

	local function ApplyWalkSpeed()
		if not Character or not Humanoid then return end
		Humanoid.WalkSpeed = WS_Enabled and CurrentWS or 16
	end

	local function HookCharacter(char)
		Character = char
		Humanoid = char:WaitForChild("Humanoid")
		ApplyWalkSpeed()
	end

	if Player.Character then
		HookCharacter(Player.Character)
	end

	Player.CharacterAdded:Connect(HookCharacter)

	mainft:AddSlider("WSSLIDER", {
		Text = "Walk Speed",
		Default = 16,
		Min = 16,
		Max = 85,
		Rounding = 0,
		Compact = true,
		Callback = function(v)
			CurrentWS = v
			ApplyWalkSpeed()
		end
	})

	mainft:AddToggle("EnableWS", {
		Text = "Enable Walk Speed",
		Default = false,
		Callback = function(state)
			WS_Enabled = state
			ApplyWalkSpeed()
		end
	})


		local Visualtab = Tabs.Visual:AddLeftTabbox()
		local vslt = Visualtab:AddTab('Aimbot')
			local Visualtab2 = Tabs.Visual:AddRightTabbox()
		local vsrt = Visualtab2:AddTab('Esp')

	vsrt:AddToggle("PlayerEsp", {
		Text = "Players",
		Default = false,
	})

	vsrt:AddDivider()

	vsrt:AddSlider('SetFadeTime', {
		Text = 'FadeTime ',
		Default = 0.5,
		Min = 0,
		Max = 2,
		Rounding = 1,
		Compact = true,
		Callback = function(Value)
			ESPLibrary:SetFadeTime(Value) 
		end
	})

	vsrt:AddSlider('TracerSizer', {
		Text = 'Tracer Size ',
		Default = 1,
		Min = 1,
		Max = 3,
		Rounding = 1,
		Compact = true,
		Callback = function(Value)
			ESPLibrary:SetTracerSize(Value)
		end
	})

    	vsrt:AddSlider('FillTransparency', {
		Text = 'Fill Transparency',
		Default = 0.75,
		Min = 0,
		Max = 1,
		Rounding = 2,
		Compact = true,
		Callback = function(Value)
			ESPLibrary:SetFillTransparency(Value)
		end
	})

    	vsrt:AddSlider('TextSizer', {
		Text = 'Text Size ',
		Default = 18,
		Min = 12,
		Max = 24,
		Rounding = 0,
		Compact = true,
		Callback = function(Value)
			ESPLibrary:SetTextSize(Value)
		end
	})

	vsrt:AddDivider()

	vsrt:AddToggle("DistancesEsp", {
		Text = "Distances",
		Default = false,
		Tooltip = nil,
		Callback = function(Value)
			ESPLibrary:SetShowDistance(Value)
		end,
	})

	vsrt:AddToggle("TracersEsp", {
		Text = "Tracers",
		Default = false,
		Tooltip = nil,
		Callback = function(Value)
			ESPLibrary:SetTracers(Value)
		end,
	})

	vsrt:AddToggle("ArrowsEsp", {
		Text = "Arrows",
		Default = false,
		Tooltip = nil,
		Callback = function(Value)
			ESPLibrary:SetArrows(Value)
		end,
	})

	vsrt:AddToggle("RainbowEsp", {
		Text = "Rainbow Esp",
		Default = false,
		Tooltip = nil,
		Callback = function(Value)
			ESPLibrary:SetRainbow(Value)
		end,
	})

	vsrt:AddDivider()

	vsrt:AddDropdown("ESPTextFont", {
    Text = "Text Font",
    Values = {
        "Legacy",
        "Arial",
        "ArialBold",
        "SourceSans",
        "SourceSansBold",
        "SourceSansLight",
        "SourceSansItalic",
        "Bodoni",
        "Garamond",
        "Cartoon",
        "Code",
        "Highway",
        "SciFi",
        "Arcade",
        "Fantasy",
        "Antique",
        "SourceSansSemibold",
        "Gotham",
        "GothamMedium",
        "GothamBold",
        "GothamBlack",
        "AmaticSC",
        "Bangers",
        "Creepster",
        "DenkOne",
        "Fondamento",
        "FredokaOne",
        "GrenzeGotisch",
        "IndieFlower",
        "JosefinSans",
        "Jura",
        "Kalam",
        "LuckiestGuy",
        "Merriweather",
        "Michroma",
        "Nunito",
        "Oswald",
        "PatrickHand",
        "PermanentMarker",
        "Roboto",
        "RobotoCondensed",
        "RobotoMono",
        "Sarpanch",
        "SpecialElite",
        "TitilliumWeb",
        "Ubuntu",
        "BuilderSans",
        "BuilderSansMedium",
        "BuilderSansBold",
        "BuilderSansExtraBold",
        "Arimo",
        "ArimoBold",
        },
    Default = 41
})

	local PlayerESPObjects = {}

	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer

	local function ClearPlayerESP()
		for plr, espObj in pairs(PlayerESPObjects) do
			if espObj then
				ESPLibrary:RemoveESP(espObj)
			end
		end
		table.clear(PlayerESPObjects)
	end

	local function GetPlayerColor(plr)
		if plr.Team ~= nil then
			return plr.TeamColor.Color
		end
		return Color3.fromRGB(255, 255, 255)
	end

	local function CreatePlayerESP(plr)
		if not Toggles.PlayerEsp.Value then return end
		if plr == LocalPlayer then return end
		if PlayerESPObjects[plr] then return end

		local char = plr.Character
		if not char then return end

		local color = GetPlayerColor(plr)

		ESPLibrary:AddESP({
			Object = char,
			Text   = plr.Name,
			Color  = color
		})

		PlayerESPObjects[plr] = char
	end

	local function HookCharacter(plr)
		plr.CharacterAdded:Connect(function(char)
			task.wait(0.1)
			CreatePlayerESP(plr)
		end)
	end

	local function HookTeamChange(plr)
		if plr:GetAttribute("TeamColor") then return end

		plr:GetPropertyChangedSignal("Team"):Connect(function()
			if PlayerESPObjects[plr] then
				local newColor = GetPlayerColor(plr)
				ESPLibrary:UpdateObjectColor(PlayerESPObjects[plr], newColor)
			end
		end)
	end

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			HookCharacter(plr)
			HookTeamChange(plr)
			if plr.Character then
				CreatePlayerESP(plr)
			end
		end
	end

	Players.PlayerAdded:Connect(function(plr)
		HookCharacter(plr)
		HookTeamChange(plr)
		task.wait(0.1)
		CreatePlayerESP(plr)
	end)

	Players.PlayerRemoving:Connect(function(plr)
		if PlayerESPObjects[plr] then
			ESPLibrary:RemoveESP(PlayerESPObjects[plr])
			PlayerESPObjects[plr] = nil
		end
	end)

	Toggles.PlayerEsp:OnChanged(function(v)
		if not v then
			ClearPlayerESP()
		else
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer then
					CreatePlayerESP(plr)
				end
			end
		end
	end)

	vslt:AddSlider("FOVSIRCLE", {
		Text = "Circle",
		Default = 30,
		Min = 30,
		Max = 100,
		Rounding = 0,
		Compact = true,
	})

	vslt:AddToggle("EnableCircle", {
		Text = "Enable Circle",
		Default = false,
	})

	vslt:AddToggle("EnableCAB", {
		Text = "Enable Aimbot",
		Default = false,
	})


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ToggleOn = false
local Original = {}

local function SaveOriginal(plr, part)
    if not Original[plr] then
        Original[plr] = {}
    end
    if not Original[plr][part.Name] then
        Original[plr][part.Name] = part.Size
    end
end

local function ApplyHitboxes(plr)
    if plr == LocalPlayer then return end
    if plr.Team == LocalPlayer.Team then return end

    local char = plr.Character
    if not char then return end

    local parts = {
        Head = Vector3.new(20,20,20),
      --  RightUpperLeg = Vector3.new(13,13,13),
       -- LeftUpperLeg = Vector3.new(13,13,13),
      --  HeadHB = Vector3.new(20,20,20),
        HumanoidRootPart = Vector3.new(13,13,13)
    }

    for name, newSize in pairs(parts) do
        local part = char:FindFirstChild(name)
        if part then
            SaveOriginal(plr, part)

            part.Size = newSize
            part.Transparency = 10

            part.CanCollide = false
            part.Massless = false  -- <<<<<<<<<<<<<< HERE
            part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        end
    end
end

local function RestoreOriginal(plr)
    if not Original[plr] then return end
    local char = plr.Character
    if not char then return end

    for name, oldSize in pairs(Original[plr]) do
        local part = char:FindFirstChild(name)
        if part then
            part.Size = oldSize
            part.Transparency = 0
            part.CanCollide = true
            part.Massless = false
            part.CustomPhysicalProperties = PhysicalProperties.new(1, 0.5, 0.5)
        end
    end
end

local function UpdatePlayer(plr)
    if ToggleOn then
        ApplyHitboxes(plr)
    else
        RestoreOriginal(plr)
    end
end

local function HookCharacter(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.1)
        UpdatePlayer(plr)
    end)
end

local function HookTeam(plr)
    plr:GetPropertyChangedSignal("Team"):Connect(function()
        UpdatePlayer(plr)
    end)
end

Players.PlayerAdded:Connect(function(plr)
    HookCharacter(plr)
    HookTeam(plr)
    task.wait(0.1)
    UpdatePlayer(plr)
end)

for _, plr in ipairs(Players:GetPlayers()) do
    HookCharacter(plr)
    HookTeam(plr)
end

vslt:AddToggle("sa", {
    Text = "sa",
    Default = false,
    Callback = function(state)
        ToggleOn = state

        if not state then
            for plr in pairs(Original) do
                RestoreOriginal(plr)
            end
        end

        for _, plr in ipairs(Players:GetPlayers()) do
            UpdatePlayer(plr)
        end
    end
})

	vslt:AddToggle("EnableTeamCheck", {
		Text = "Enable Team Check",
		Default = false,
	})

	vslt:AddToggle("RainbowCircle", {
		Text = "Rainbow Circle",
		Default = false,
	})

	Aimbot = {
		Enabled = false,
		CircleEnabled = false,
		TeamCheck = false,
		Rainbow = false,
		FOV = 30,
	}

	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local Camera = workspace.CurrentCamera
	local UIS = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")

	local Circle = Drawing.new("Circle")
	Circle.Color = Color3.fromRGB(255, 255, 255)
	Circle.Thickness = 1
	Circle.Filled = false
	Circle.NumSides = 64
	Circle.Visible = false
	Circle.Radius = Aimbot.FOV

	local function UpdateFOV(v)
		Aimbot.FOV = v
		Circle.Radius = v
	end

	local function UpdateCircle(v)
		Aimbot.CircleEnabled = v
		Circle.Visible = v
	end

	local function UpdateAimbot(v)
		Aimbot.Enabled = v
	end

	local function UpdateTeamCheck(v)
		Aimbot.TeamCheck = v
	end

	local function UpdateRainbow(v)
		Aimbot.Rainbow = v
	end

	Options.FOVSIRCLE:OnChanged(UpdateFOV)
	Toggles.EnableCircle:OnChanged(UpdateCircle)
	Toggles.EnableCAB:OnChanged(UpdateAimbot)
	Toggles.EnableTeamCheck:OnChanged(UpdateTeamCheck)
	Toggles.RainbowCircle:OnChanged(UpdateRainbow)

	UpdateFOV(Options.FOVSIRCLE.Value)
	UpdateCircle(Toggles.EnableCircle.Value)
	UpdateAimbot(Toggles.EnableCAB.Value)
	UpdateTeamCheck(Toggles.EnableTeamCheck.Value)
	UpdateRainbow(Toggles.RainbowCircle.Value)

	local function IsValidTarget(plr)
		if plr == LocalPlayer then return false end
		if not plr.Character then return false end

		local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
		local hum = plr.Character:FindFirstChild("Humanoid")
		if not hrp or not hum or hum.Health <= 0 then return false end

		if Aimbot.TeamCheck and plr.Team == LocalPlayer.Team then
			return false
		end

		return true
	end

	local function GetClosest()
		local closestPart = nil
		local closestDist = Aimbot.FOV

		for _, plr in ipairs(Players:GetPlayers()) do
			if IsValidTarget(plr) then
				local hrp = plr.Character.HumanoidRootPart
				local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

				if onScreen then
					local mousePos = UIS:GetMouseLocation()
					local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude

					if dist <= closestDist then
						closestDist = dist
						closestPart = hrp
					end
				end
			end
		end

		return closestPart
	end

	local function AimAt(part)
		if not part then return end
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position)
	end

	local hue = 0
	local rainbowDelay = 0.02 
	local lastTick = tick()

	RunService.RenderStepped:Connect(function()
		if Aimbot.CircleEnabled then
			local pos = UIS:GetMouseLocation()
			Circle.Position = Vector2.new(pos.X, pos.Y)

			if Aimbot.Rainbow then
				if tick() - lastTick >= rainbowDelay then
					hue = hue + 0.01
					if hue >= 1 then hue = 0 end
					Circle.Color = Color3.fromHSV(hue, 1, 1)
					lastTick = tick()
				end
			else
				Circle.Color = Color3.fromRGB(255, 255, 255)
			end
		end
	end)

	task.spawn(function()
		while task.wait() do
			if Aimbot.Enabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
				local target = GetClosest()
				if target then
					AimAt(target)
				end
			end
		end
	end)
Library:OnUnload(function()
	print("unloaded...???")
end)

BlackKing.Interface.ApplySettingsTab(Window)
