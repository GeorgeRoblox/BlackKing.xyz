return function(Window)
local LCH = {
	"[DOORS]",
	"<font color='rgb(0, 255, 0)'>+ Added Anti Scribbles.</font>",
	"<font color='rgb(0, 255, 0)'>+ Added Stall Stampede of Drones.</font>",
	"<font color='rgb(0, 255, 0)'>+ Added Anti Alma.</font>",
	"<font color='rgb(0, 255, 0)'>+ Added Remove Ransom.</font>",
	"<font color='rgb(255, 0, 0)'>- Removed No A-90 Damage.</font>",
}

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

	local Library = BlackKing.Interface.Library
	local SaveManager = BlackKing.Interface.SaveManager
	local ThemeManager = BlackKing.Interface.ThemeManager

	local Toggles = Library.Toggles
	local Options = Library.Options

	local LocalPlayer = Services.Players.LocalPlayer
	local InfoTab = Window:AddTab("Info", "user")

	local User = InfoTab:AddLeftGroupbox("User", "user")

	local ImageSize = Enum.ThumbnailSize.Size420x420
	local ImageType = Enum.ThumbnailType.HeadShot

	local Content = Services.Players:GetUserThumbnailAsync(LocalPlayer.UserId, ImageType, ImageSize)

	User:AddImage("UserIcon", {
		Image = Content
	})

	local Hour = os.date("*t").hour
	local Greeting
	if Hour >= 5 and Hour < 12 then
		Greeting = "Good Morning"
	elseif Hour >= 12 and Hour < 17 then
		Greeting = "Good Afternoon"
	elseif Hour >= 17 and Hour < 21 then
		Greeting = "Good Evening"
	else
		Greeting = "Good Night"
	end
	User:AddLabel(Greeting .. ", " .. LocalPlayer.Name .. ", ty for using this script you executed: " .. (BlackKing.TotalExecutions and tostring(BlackKing.TotalExecutions) or "N/A") .. " times.", true)
	User:AddDivider()
	User:AddButton("Copy Discord Invite", function()
		toclipboard("https://dsc.gg/BlackKing")
		Library:Notify("Discord invite copied.")
	end)

	local GameList = {
		[2440500124] = "Doors",
	}
	local CurrentGame = GameList[game.GameId] or "Unknown (" .. game.GameId .. ")"

	local InfoStuff = InfoTab:AddRightTabbox("idk how to call this :content:")
	local SupportInfo = InfoStuff:AddTab("", "folder")
	local Info = InfoStuff:AddTab("", "settings")

	local function AddScrollingChangelog(Tab, Title, Entries)
		local Container = Tab.Container

		local Box = Instance.new("Frame")
		Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Box.Position = UDim2.fromOffset(0, 7)
		Box.Size = UDim2.new(1, 0, 0, 180)
		Box.Parent = Container

		local Scroll = Instance.new("ScrollingFrame")
		Scroll.BackgroundTransparency = 1
		Scroll.Size = UDim2.fromScale(1, 1)
		Scroll.ScrollBarThickness = 3
		Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
		Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		Scroll.Parent = Box

		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Size = UDim2.new(1, -8, 0, 20)
		TitleLabel.Text = Title
		TitleLabel.TextSize = 14
		TitleLabel.Font = Enum.Font.GothamBold
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		TitleLabel.Parent = Scroll

		local Content = Instance.new("TextLabel")
		Content.BackgroundTransparency = 1
		Content.Position = UDim2.new(0, 0, 0, 20)
		Content.Size = UDim2.new(1, -8, 0, 0)
		Content.AutomaticSize = Enum.AutomaticSize.Y
		Content.RichText = true
		Content.TextWrapped = true
		Content.TextSize = 14
		Content.TextXAlignment = Enum.TextXAlignment.Left
		Content.Text = table.concat(Entries, "<br>")
		Content.Parent = Scroll
	end

	AddScrollingChangelog(InfoTab, "Latest Changelog", LCH)

		local Games = {
		"🟢 DOORS",
		"🔴 Universal",
	}

	for Index, GameStatuses in pairs(Games) do
		SupportInfo:AddLabel(GameStatuses, true)
	end
	SupportInfo:AddDivider()
	SupportInfo:AddLabel("Game: " .. CurrentGame, true)

	Info:AddLabel("FireBacon, Seikoso, Upio, Mstudio\n and Java for emotional support <3")
end
