 
-- Find and Join "Steal a Brainrot" Public Servers
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Step 1: Search for the game "Steal a Brainrot"
local searchKeyword = "Steal a Brainrot"
local searchUrl = "https://games.roblox.com/v1/games?keyword=" .. searchKeyword:gsub(" ", "%20") .. "&limit=1"
local searchResponse = game:HttpGetAsync(searchUrl)
local searchData = HttpService:JSONDecode(searchResponse)

-- Check if the game exists
if #searchData.data > 0 then
    local placeId = searchData.data[1].rootPlaceId
    print("Found '" .. searchKeyword .. "' with PlaceID:", placeId)

    -- Step 2: Fetch public servers for the game
    local apiUrl = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    local serverResponse = game:HttpGetAsync(apiUrl)
    local servers = HttpService:JSONDecode(serverResponse)

    -- Step 3: Find and join a server with "brainrot" in the name
    for _, server in ipairs(servers.data) do
        if server.playing and server.name:lower():find("brainrot") then
            print("Joining Brainrot Server:", server.name, "ID:", server.id)
            TeleportService:TeleportToServerInstance(placeId, server.id, player)
            return
        end
    end
    warn("No Brainrot servers found.")
else
    warn("Game '" .. searchKeyword .. "' not found.")
end
```

---
