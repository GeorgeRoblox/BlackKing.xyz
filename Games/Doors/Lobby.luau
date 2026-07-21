local LoadStart = tick()
BlackKing.SavePath = "Doors/Lobby"

local Library = BlackKing.Interface.Library
local SaveManager = BlackKing.Interface.SaveManager
local ThemeManager = BlackKing.Interface.ThemeManager

local Toggles = Library.Toggles
local Options = Library.Options

local function CloneReference(Object)
    if BlackKing and BlackKing.Environment.cloneref then
        return BlackKing.Environment.cloneref(Object)
    else
        return Object
    end
end

local Services = setmetatable({}, {
    __index = function(self, Name)
        return CloneReference(game:GetService(Name))
    end
})

local Global = {}
local Connections = {}
local Fs = {}

local LocalPlayer = Services.Players.LocalPlayer
local RemotesFolder = Services.ReplicatedStorage:WaitForChild("RemotesFolder")

while not LocalPlayer.Character do
    task.wait()
end
task.wait(1)

local Window = Library:CreateWindow({
    Title = "BlackKing",
    Footer = "dsc.gg/BlackKing",
    NotifySide = "Right",
    ShowCustomCursor = false,
    AutoShow = true,
    Center = true,
	TabPadding = 3,
	MenuFadeTime = 0,
    CornerRadius = 2,
})

BlackKing.Interface.ApplyInfoTab(Window)
local Tabs = {
    General = Window:AddTab("General", "house"),
}

Fs.CheckCompatability = function(Array)
    local Valid = true
    for Index, Name in pairs(Array) do
        if not BlackKing.Environment[Name] then
            Valid = false
        end
    end
    return Valid
end

local function GetHiddenContainer()
	if Fs.CheckCompatability({"gethui"}) then
		return BlackKing.Environment.gethui()
	else
		return Services.CoreGui
	end
end

local NotificationLibrary = {
	LiveNotifications = 0,
    Notifications = 1
}

local Container = Instance.new("ScreenGui")
Container.Name = BlackKing.ESPLibrary:GenerateRandomString()
Container.Parent = GetHiddenContainer()
Container.DisplayOrder = 32767
Container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if not Library.Scheme then
    Library.Scheme = setmetatable({}, {
        __index = function(self, Name)
            return Library[Name]
        end
    })
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

Fs.CheckElevators = function()
    local TargetFound = false
	if not Toggles.AutoJoinElevator.Value then
		return
	end
	local TargetCharacter
	if typeof(Options.AutoJoinElevatorTarget.Value) == "Instance" then
		TargetCharacter = Options.AutoJoinElevatorTarget.Value.Character
	elseif typeof(Options.AutoJoinElevatorTarget.Value) == "string" then
		TargetCharacter = Services.Players:FindFirstChild(Options.AutoJoinElevatorTarget.Value).Character
	end

	for Index, Elevator in pairs(Services.Workspace.Lobby.LobbyElevators:GetChildren()) do
		if TargetCharacter and Elevator and TargetCharacter:GetAttribute("InGameElevator") and Elevator:GetAttribute("ID") and Elevator:GetAttribute("ID") == TargetCharacter:GetAttribute("InGameElevator") then
			TargetFound = true
			RemotesFolder.ElevatorJoin:FireServer(Elevator)
        end
    end
	if TargetFound == false then
		RemotesFolder.ElevatorExit:FireServer()
	end
end

Global.RedeemingCodes = false
Global.CodesList = {
    "67",
	"54",
	"41",
	"CHEDDAR BALLS",
	"XQC",
	"PENGUINZ0",
	"KREEKCRAFT",
	"ISHOWSPEED",
	"DANTDM",
	"KUBZ SCOUTS",
	"FIND THE TROLLFACES",
	"THINKNOODLES",
	"W",
	"RAGDOLL UNIVERSE",
	"RAGDOLL MAYHEM",
	"BIJUU MIKE",
	"8BITRYAN",
	"SCREECHSUCKS",
	"LORE",
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ",
	"FIND THE TROLLFACES",
	"3rd",
	"LAZYDEVS",
	"RAGDOLL COMBAT",
	"VOCAB HAVOC",
	"PATHSWAP",
	"JUMP OVER THE BRICK"
}
Global.UnlockedBadges = {}

General_Self = Tabs.General:AddLeftGroupbox("Self")

General_Self:AddToggle("AutoJoinElevator", {
    Text = "Auto Join Elevator",
    Default = false,
    Tooltip = "Automatically joins the selected player's elevator."
})

General_Self:AddDropdown("AutoJoinElevatorTarget", {
    Text = "Target",
    SpecialType = "Player",
    ExcludeLocalPlayer = true,
    Searchable = true
})

General_Automation = Tabs.General:AddLeftGroupbox("Automation")

General_Automation:AddToggle("CycleAchievements", {
    Text = "Cycle Achievements",
    Default = false,
    Tooltip = "Rapidly equips a random badge."
})

General_Automation:AddSlider("CycleAchievementsDelay", {
    Text = "Cycle Delay",
    Min = 0,
    Max = 1,
    Default = 0.1,
    Rounding = 2,
    Compact = true
})

General_Automation:AddDivider()

General_Automation:AddButton("Redeem All Codes", function()
    if Global.RedeemingCodes then
        return
    end

	notify("BlackKing", {
	Title = "George",
	Description = "Redeeming " .. #Global.CodesList .. " codes."
	Color = Color3.fromRGB(255, 222, 189),
	Time = 5
})
    Global.RedeemingCodes = true
    for Index, Code in pairs(Global.CodesList) do
        RemotesFolder.ShopCode:FireServer(Code)
        task.wait(5.1)
    end
end)

for Index, Frame in pairs(LocalPlayer.PlayerGui.MainUI.LobbyFrame.Achievements.List:GetChildren()) do
	if Frame:IsA("ImageButton") and Frame.ImageTransparency == 0 then
		table.insert(Global.UnlockedBadges, Frame.Name)
	end
end

Connections.BadgeAddedConnection = LocalPlayer.PlayerGui.MainUI.LobbyFrame.Achievements.List.ChildAdded:Connect(function(Frame)
	Services.RunService.Heartbeat:Wait()
	if Frame:IsA("ImageButton") and Frame.ImageTransparency == 0 then
		table.insert(Global.UnlockedBadges, Frame.Name)
	end
end)

Global.LastBadgeChange = tick()
Global.LastElevatorCheck = tick()
Connections.MainConnection = Services.RunService.Heartbeat:Connect(function()
	if tick() - Global.LastElevatorCheck > 0.25 then
    	Fs.CheckElevators()
		Global.LastElevatorCheck = tick()
	end

    if Toggles.CycleAchievements.Value and tick() - Global.LastBadgeChange > Options.CycleAchievementsDelay.Value then
        local Badge = Global.UnlockedBadges[math.random(1, #Global.UnlockedBadges)]
        if Badge == PreviousBadge then
            while task.wait() do
				local NewBadge = Global.UnlockedBadges[math.random(1, #Global.UnlockedBadges)]
				if NewBadge ~= PreviousBadge then
					Badge = NewBadge
					break
				end
			end
		end
		for Index, Frame in pairs(LocalPlayer.PlayerGui.MainUI.LobbyFrame.Achievements.List:GetChildren()) do
			if Frame:IsA("ImageButton") and Frame.ImageTransparency == 0 then
				LocalPlayer.PlayerGui.MainUI.LobbyFrame.Achievements.List:FindFirstChild(Frame.Name).Icons.Star.Visible = false
			end
		end
		RemotesFolder:WaitForChild("FlexAchievement"):FireServer(Badge)
		PreviousBadge = Badge
		LocalPlayer.PlayerGui.MainUI.LobbyFrame.Achievements.List:FindFirstChild(Badge).Icons.Star.Visible = true

        Global.LastBadgeChange = tick()
	end
end)

General_QuickPlay = Tabs.General:AddRightGroupbox("Quick Play")

General_QuickPlay:AddButton({
	Text = "The Hotel",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "Hotel",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddButton({
	Text = "The Mines",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "Mines",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddButton({
	Text = "The Backdoor",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "Backdoor",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddButton({
	Text = "The Rooms",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "Rooms",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddButton({
	Text = "The Outdoors",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "Garden",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddDivider()

General_QuickPlay:AddButton({
	Text = "Battle Mode",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "Party",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddButton({
	Text = "Retro Mode",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "Retro",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddButton({
	Text = "Rush Mode",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "Fools26",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddDivider()

General_QuickPlay:AddButton({
	Text = "Halloween",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "Halloween25",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddButton({
	Text = "Hotel-",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "BeforePlus",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddButton({
	Text = "Super Hard Mode",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {},
        	Settings = {},
        	Destination = "SuperHardMode",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddDivider()

General_QuickPlay:AddButton({
	Text = "The Rooms [Free No Progress]",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {
				"AdminPanel"
			},
        	Settings = {},
        	Destination = "Rooms",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

General_QuickPlay:AddButton({
	Text = "The Outdoors [Free No Progress]",
	DoubleClick = false,
	Func = function()
		RemotesFolder.CreateElevator:FireServer({
        	Mods = {
				"AdminPanel"
			},
        	Settings = {},
        	Destination = "Garden",
        	FriendsOnly = false,
        	MaxPlayers = "1"
    	})
	end
})

Library:OnUnload(function()
    Connections.MainConnection:Disconnect()
	getgenv().BlackKing = nil
end)

BlackKing.Interface.ApplySettingsTab(Window)
notify("BlackKing", {
	Title = "George",
	Description = "Successfully loaded in " .. math.floor((tick() - LoadStart) * 1000) / 1000 .. " seconds. Press '" .. tostring(Options.MenuKeybind.Value) .. "' to toggle the UI.",
	Image = George,
	Color = Color3.fromRGB(255, 222, 189),
	Time = 5
})
