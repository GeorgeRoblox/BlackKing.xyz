if BlackKing then -- a
    return 
end
getgenv().BlackKing = {
    Legit = true
}

local GameList = {
  [2440500124] = "Doors"
}

local BaseUrl = "https://raw.githubusercontent.com/GeorgeRoblox/BlackKing.xyz/refs/heads/main/"
getgenv().BlackKing = {
    Environment = loadstring(game:HttpGet(BaseUrl .. "Components/Environment.luau"))(),
    ESPLibrary = loadstring(game:HttpGet(BaseUrl .. "Components/ESPLibrary.luau"))(),

    Legit = true,
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

if BlackKing.Environment.writefile and BlackKing.Environment.readfile then
    if not BlackKing.Environment.isfile("BlackKing/UserData.json") then
        local Data = {
            TotalExecutions = 0,
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

    BlackKing.Environment.writefile("BlackKing/UserData.json", Services.HttpService:JSONEncode(Decoded))
end

BlackKing.Interface = loadstring(game:HttpGet(BaseUrl .. "Components/Interface.luau"))()

local CurrentGame = GameList[game.GameId]
if CurrentGame then
    loadstring(game:HttpGet(BaseUrl .. "Games/" .. CurrentGame .. "/Loader.luau"))()
else
    loadstring(game:HttpGet(BaseUrl .. "Games/Universal/Loader.luau"))()
end
