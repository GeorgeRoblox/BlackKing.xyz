return function(Window)
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
	local HwidInfo = InfoStuff:AddTab("", "settings")

InfoTab:UpdateWarningBox({
    Title = "Latest Changelog",
    Text = "<font color='rgb(0, 255, 0)'>+ Added FireBacon Support.</font><br><b><font color='rgb(0, 255, 0)'>+ Abysall Hub V2.</font></b>",
    IsNormal = true,
    Visible = true,
    LockSize = true,
})
	local Games = {
		"🟢 DOORS",
		"🔴 Universal",
	}

	for Index, GameStatuses in pairs(Games) do
		SupportInfo:AddLabel(GameStatuses, true)
	end
	SupportInfo:AddDivider()
	SupportInfo:AddLabel("Game: " .. CurrentGame, true)

	end
