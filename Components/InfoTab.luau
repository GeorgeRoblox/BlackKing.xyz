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
	local Changelog = InfoTab:AddRightGroupbox("Changelog", "pen-line")
	for Index, Change in pairs(LCH) do
		Changelog:AddLabel(Change, true)
	end

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

	local Expiry = BlackKing.Expiry or "N/A"
	local ExpiryStr = tostring(Expiry):gsub("^%s+", ""):gsub("%s+$", "")
	local ExpiryLower = ExpiryStr:lower()
	local SubscriptionText

	if ExpiryLower == "Lifetime" or ExpiryLower == "true" then
		SubscriptionText = "<font color='rgb(0, 255, 0)'>Active (Lifetime)</font>"
	elseif ExpiryLower == "n/a" or ExpiryLower == "nil" or ExpiryLower == "unknown" then
		SubscriptionText = "<font color='rgb(255, 0, 0)'>Unknown</font>"
	else
		local year, month, day, hour, minute = ExpiryStr:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+)")
		if year then
			local expiryUnix = os.time({
				year = tonumber(year),
				month = tonumber(month),
				day = tonumber(day),
				hour = tonumber(hour),
				min = tonumber(minute),
				sec = 0
			})
			local now = os.time() + (2 * 3600)
			if expiryUnix > now then
				local DaysLeft = math.floor((expiryUnix - now) / 86400)
				SubscriptionText = "<font color='rgb(0, 255, 0)'>Active (" .. DaysLeft .. "d left)</font>"
			else
				SubscriptionText = "<font color='rgb(255, 0, 0)'>Expired</font>"
			end
		else
			SubscriptionText = "<font color='rgb(255, 0, 0)'>Unknown</font>"
		end
	end

	local InfoStuff = InfoTab:AddRightTabbox("idk how to call this :content:")
	local SupportInfo = InfoStuff:AddTab("", "folder")
	local HwidInfo = InfoStuff:AddTab("", "settings")

	SupportInfo:AddLabel("Game: " .. CurrentGame, true)
	HwidInfo:AddLabel("HWID: " .. MyHWID, true)
	HwidInfo:AddLabel("Subscription: " .. SubscriptionText, true)
end
