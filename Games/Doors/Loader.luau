local BaseUrl = "https://raw.githubusercontent.com/GeorgeRoblox/BlackKing.xyz/refs/heads/main/"
if game.PlaceId ~= 6516141723 then
    loadstring(game:HttpGet(BaseUrl .. "Games/Doors/Main.luau"))()
elseif  game.PlaceId ~= 6516141723 and game.Players.LocalPlayer.Name == "BlackKingfarm_1" then
    print("a")
else
    loadstring(game:HttpGet(BaseUrl .. "Games/Doors/Lobby.luau"))()
end
