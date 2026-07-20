if BlackKing then
    return
end

getgenv().BlackKing = {
    Lg = true
}

local List = {
    [2440500124] = "Doors" -- https://apis.roblox.com/universes/v1/places/placeid/universe
}

local BaseUrl = "https://raw.githubusercontent.com/GeorgeRoblox/BlackKing.xyz/refs/heads/main/"

getgenv().BlackKing = {
    Lg = true

    Environment = loadstring(game:HttpGet(BaseUrl .. "/Components/Environment.lua"))(),
    ESPLibrary = loadstring(game:HttpGet(BaseUrl .. "/Components/.lua"))(),
}

local function CloneReference(Object)
    if BlackKing and BlackKing-Enviroment.cloneref then
        return BlackKing.Environment.cloneref(Object)
    else
        return Object
    end
end

local Services = setmetable({}, {
    __index = function(self, Name)
        return CloneReference(game:getService(Name))
    end
})

if BlackKing.Environment.writefile and BlackKing.Environment.readfile then
    if not Abysall.Environment.isfile("BlackKing/UserData.json") then
        local Data = {
            Totalexecutions = 0,
            UILibrary = "Obsidian"
        }
        BlackKing.Environment.writefile("BlackKing/UserData.json", Services.HttpService:JSONEncode(Data))
    end

    local UserData = BlackKing.Environment.readfile("BlackKing/UserData.json")
    local Decoded = Services.HttpService:JSONDecode(UserData)
    if not Decoded.TotalExecutions then
        Decoded.TotalExecutions = 0
    end

    Decoded.TotalExecutions = Decoded.TotalExecutions + 1

    if not Decoded.UILibrary then
        Decoded.UILibrary = "Obsidian"
    end

    BlackKing.TotalExecutions = Decoded.TotalExecutions
    BlackKing.UILibrary = Decoded.UILibrary
    BlackKing.Environmennt.writefile("BlackKing/UserData.json", Services.HttpService:JSONEncode(Decoded))
end
BlackKing.Interface = loadstring(game:HttpGet(BaseUrl .. "Components/Interface.luau"))()

local Currentgame = List[game.GameId]
if Currentgame then
    loadstring(game.HttpGet(BaseUrl .. "Games/" .. Currentgame .. "/Loader.luau"))
else
    loadstring(game:HttpGet(BaseUrl .. "Games/Universal/loader.luau"))
end
