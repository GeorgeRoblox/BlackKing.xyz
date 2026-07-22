local Services = setmetatable({}, {
    __index = function(self, Name)
        if BlackKing.Environment.cloneref then
            return BlackKing.Environment.cloneref(game:GetService(Name))
        else
            return game:GetService(Name)
        end
    end
})

local Bindable = Instance.new("BindableFunction")
Bindable.OnInvoke = function(Response)
    local Success, Result = pcall(function()
        toclipboard("https://dsc.gg/BlackKing")
    end)
    if not Success then
        Services.LocalPlayer:Kick("Failed to copy invite. Please Join\nhttps://dsc.gg/BlackKing")
    end
end

Services.StarterGui:SetCore("SendNotification", {
    Title = "BlackKing",
    Text = "Only DOORS support for now. Universal got delayed D:",
    Duration = 10,
    Button1 = "Copy Discord Link",
    Callback = Bindable,
})
