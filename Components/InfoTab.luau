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

	local TabLeft = InfoTab.Sides[1]
	local TabRight = InfoTab.Sides[2]
	local TabContainer = TabLeft.Parent

	local ChangelogHolder = Instance.new("Frame")
	ChangelogHolder.Name = "ChangelogFullWidth"
	ChangelogHolder.AutomaticSize = Enum.AutomaticSize.Y
	ChangelogHolder.BackgroundColor3 = Library.Scheme.MainColor
	ChangelogHolder.Size = UDim2.new(1, 0, 0, 0)
	ChangelogHolder.ZIndex = 5
	ChangelogHolder.Parent = TabContainer

	Instance.new("UICorner", ChangelogHolder).CornerRadius = UDim.new(0, Library.CornerRadius)
	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Library.Scheme.OutlineColor
	Stroke.Thickness = 1
	Stroke.ZIndex = 5
	Stroke.Parent = ChangelogHolder

	local Inner = Instance.new("Frame")
	Inner.Name = "Inner"
	Inner.AutomaticSize = Enum.AutomaticSize.Y
	Inner.BackgroundTransparency = 1
	Inner.Size = UDim2.new(1, -16, 0, 0)
	Inner.Position = UDim2.new(0, 8, 0, 8)
	Inner.ZIndex = 5
	Inner.Parent = ChangelogHolder

	local Layout = Instance.new("UIListLayout")
	Layout.Padding = UDim.new(0, 4)
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Layout.Parent = Inner

	local TitleIcon = Library:GetCustomIcon("pen-line")
	if TitleIcon then
		local Icon = Instance.new("ImageLabel")
		Icon.Name = "ChangelogIcon"
		Icon.BackgroundTransparency = 1
		Icon.Size = UDim2.fromOffset(14, 14)
		Icon.Image = TitleIcon.Url
		Icon.ImageRectOffset = TitleIcon.ImageRectOffset
		Icon.ImageRectSize = TitleIcon.ImageRectSize
		Icon.ImageColor3 = Library.Scheme.AccentColor
		Icon.ZIndex = 5
		Icon.Parent = Inner
	end

	local Title = Instance.new("TextLabel")
	Title.Name = "ChangelogTitle"
	Title.AutomaticSize = Enum.AutomaticSize.XY
	Title.BackgroundTransparency = 1
	Title.FontFace = Library.Scheme.Font
	Title.RichText = true
	Title.Text = "Changelog"
	Title.TextColor3 = Library.Scheme.FontColor
	Title.TextSize = 14
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 5
	Title.Parent = Inner

	local Divider = Instance.new("Frame")
	Divider.Name = "Divider"
	Divider.BackgroundColor3 = Library.Scheme.OutlineColor
	Divider.Size = UDim2.new(1, 0, 0, 1)
	Divider.LayoutOrder = 1
	Divider.ZIndex = 5
	Divider.Parent = Inner

	for Index, Change in ipairs(LCH) do
		local Label = Instance.new("TextLabel")
		Label.Name = "Change" .. Index
		Label.AutomaticSize = Enum.AutomaticSize.XY
		Label.BackgroundTransparency = 1
		Label.FontFace = Library.Scheme.Font
		Label.RichText = true
		Label.Text = Change
		Label.TextColor3 = Library.Scheme.FontColor
		Label.TextSize = 14
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.LayoutOrder = Index + 1
		Label.ZIndex = 5
		Label.Parent = Inner
	end

	local PadBottom = Instance.new("Frame")
	PadBottom.Name = "PadBottom"
	PadBottom.AutomaticSize = Enum.AutomaticSize.Y
	PadBottom.BackgroundTransparency = 1
	PadBottom.Size = UDim2.new(0, 0, 0, 4)
	PadBottom.LayoutOrder = 999
	PadBottom.ZIndex = 5
	PadBottom.Parent = Inner

	ChangelogHolder:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		local Offset = ChangelogHolder.AbsoluteSize.Y + 8
		TabLeft.Position = UDim2.new(0, 0, 0, Offset)
		TabLeft.Size = UDim2.new(0.5, -3, 1, -Offset)
		TabRight.Position = UDim2.new(1, 0, 0, Offset)
		TabRight.Size = UDim2.new(0.5, -3, 1, -Offset)
	end)

	task.defer(function()
		local Offset = ChangelogHolder.AbsoluteSize.Y + 8
		TabLeft.Position = UDim2.new(0, 0, 0, Offset)
		TabLeft.Size = UDim2.new(0.5, -3, 1, -Offset)
		TabRight.Position = UDim2.new(1, 0, 0, Offset)
		TabRight.Size = UDim2.new(0.5, -3, 1, -Offset)
	end)

	local User = InfoTab:AddLeftGroupbox("User", "user")

	local ImageSize = Enum.ThumbnailSize.Size420x420
	local ImageType = Enum.ThumbnailType.HeadShot

	local Content = Services.Players:GetUserThumbnailAsync(LocalPlayer.UserId, ImageType, ImageSize)

	User:AddImage("UserIcon", {
		Image = Content
	})

	User:AddLabel("User: " .. LocalPlayer.Name, true)
	User:AddLabel("Total Executions: " .. (BlackKing.TotalExecutions and BlackKing.TotalExecutions or "N/A"), true)

	local Community = InfoTab:AddLeftGroupbox("Community")
	Community:AddButton("Copy Discord Invite", function()
		toclipboard("https://dsc.gg/BlackKing")
		Library:Notify("Discord invite copied.")
	end)
end
