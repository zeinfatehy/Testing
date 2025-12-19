-- Client-Sided Script (LocalScript)
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local http = game:GetService("HttpRbxApiService") -- For making HTTP requests

-- Function to fetch the script from GitHub
local function fetchScript()
    local success, response = pcall(function()
        return http:GetAsync("https://raw.githubusercontent.com/zeinfatehy/Testing/main/Script.lua")
    end)
    if success then
        return response
    else
        warn("Failed to fetch script:", response)
        return nil
    end
end
-- Function to search for the game and join a server
local function joinBrainrotServer()
    local gameName = "Steal a Brainrot"
    local apiUrl = "https://games.roblox.com/v1/games?keyword=" .. gameName:gsub(" ", "+")

    local success, response = pcall(function()
        return http:GetAsync(apiUrl)
    end)

    if success then
        local data = game:GetService("HttpService"):JSONDecode(response)
        if data.data and #data.data > 0 then
            local placeId = data.data[1].rootPlaceId
            searchAndJoinServer(placeId)
        else
            warn("Game not found:", gameName)
        end
    else
        warn("Failed to search for game:", response)
    end
end
-- Function to search for servers and teleport
local function searchAndJoinServer(placeId)
    local searchUrl = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"

    local success, serversResponse = pcall(function()
        return http:GetAsync(searchUrl)
    end)

    if success then
        local serversData = game:GetService("HttpService"):JSONDecode(serversResponse)
        for _, server in ipairs(serversData.data) do
            if server.name:lower():find("brainrot") then
                local teleportSuccess, teleportErr = pcall(function()
                    TeleportService:TeleportToServerInstance(placeId, server.id, player)
                end)
                if not teleportSuccess then
                    warn("Teleport failed:", teleportErr)
                end
                return -- Exit after joining the first matching server
            end
        end
        warn("No servers with 'brainrot' found.")
    else
        warn("Failed to fetch servers:", serversResponse)
    end
end
-- Fetch and execute the script
local scriptContent = fetchScript()
if scriptContent then
    -- Load the fetched script (optional, depending on its purpose)
    -- Alternatively, proceed directly to joining the server
    joinBrainrotServer()
else
    warn("Script fetch failed. Cannot proceed.")
end
```

---

### **Notes:**
1. **HTTP Requests**: The script uses `HttpRbxApiService` for client-side HTTP requests, which is allowed in LocalScripts.
2. **Error Handling**: Added `pcall` for error handling to prevent the script from crashing.
3. **Teleportation**: The script teleports to the first server with "brainrot" in its name.

Let me know if you need further adjustments!
