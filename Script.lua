
-- Find and Join "Steal a Brainrot" Public Servers
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Replace with the actual PlaceID of "Steal a Brainrot" (or search for it dynamically)
local placeId = 16466213388 -- Example PlaceID (verify this!)

-- Fetch public servers for the game
local apiUrl = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
local response = game:HttpGetAsync(apiUrl)
local servers = HttpService:JSONDecode(response)

-- Find and join a server with "brainrot" in the name
for _, server in ipairs(servers.data) do
    if server.name:lower():find("brainrot") then
        print("Joining Brainrot Server:", server.name, "ID:", server.id)
        TeleportService:TeleportToServerInstance(placeId, server.id, player)
        return
    end
end
warn("No Brainrot servers found.")
