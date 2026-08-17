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

	local Changelog = InfoTab:AddRightGroupbox("Changelog", "pen-line")
	for Index, Change in pairs(LCH) do
		Changelog:AddLabel(Change, true)
	end

    local InfoStuff = InfoTab:AddRightTabbox("idk how to call this :content:")
    local SupportInfo = InfoStuff:AddTab("", "folder")
    local HwidInfo = InfoStuff:AddTab("", "settings")

    SupportInfo:AddLabel("Lol")
    HwidInfo:AddLabel("Hi")

	local Community = InfoTab:AddLeftGroupbox("Community")
	Community:AddButton("Copy Discord Invite", function()
		toclipboard("https://dsc.gg/BlackKing")
		Library:Notify("Discord invite copied.")
	end)
end
