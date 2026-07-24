local BaseUrl = "https://raw.githubusercontent.com/GeorgeRoblox/BlackKing.xyz/refs/heads/main/"
local player = game.Players.LocalPlayer

if game.PlaceId ~= 6516141723 and player.Name ~= "BlackKingfarm_1" then
    loadstring(game:HttpGet(BaseUrl .. "Games/Doors/Main.luau"))()
elseif game.PlaceId ~= 6516141723 and player.Name == "BlackKingfarm_1" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GeorgeRoblox/BlackKing-Dev-Team-/refs/heads/main/DevMain.luau?token=GHSAT0AAAAAAEDTC7UHXPGC6FUW3B3V56DU2TDZKUQ"))()
else
    loadstring(game:HttpGet(BaseUrl .. "Games/Doors/Lobby.luau"))()
end
