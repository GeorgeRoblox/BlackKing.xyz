return function(Window)
	local LCH = {
		"7/8/2026",
		"<font color='rgb(0, 255, 0)'>+ Anti Mandrake.</font>",
		"<font color='rgb(0, 255, 0)'>+ Auto Complete Maze (Outdoors).</font>",
		"<font color='rgb(0, 255, 0)'>+ Lobby Support.</font>",
		"<font color='rgb(0, 255, 0)'>+ Fixed Bugs.</font>",
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

	local function advancedHash(str)
		local hash = 0
		for i = 1, #str do
			hash = (hash * 31 + str:byte(i)) % 4294967296
		end
		local out = {}
		for i = 1, 16 do
			hash = (hash * 1664525 + 1013904223) % 4294967296
			out[i] = string.char((hash % 26) + 65)
		end
		return table.concat(out)
	end

	local function generateHashedId()
		local id = game:GetService("RbxAnalyticsService"):GetClientId()
		local h = advancedHash(id)
		return string.format("%s-%s-%s-%s", h:sub(1,4), h:sub(5,8), h:sub(9,12), h:sub(13,16))
	end

	local MyHWID = generateHashedId()

	local InfoStuff = InfoTab:AddRightTabbox("idk how to call this :content:")
	local SupportInfo = InfoStuff:AddTab("", "folder")
	local HwidInfo = InfoStuff:AddTab("", "settings")

	local changelogText = table.concat(LCH, "\n")
	InfoTab:UpdateWarningBox({
	Title = "Latest Changelog",
	Text = changelogText,
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
