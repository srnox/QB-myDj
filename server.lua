local QBCore = exports['qb-core']:GetCoreObject()
local xSound = exports.xsound

-- Helper function to validate and process URLs (both YouTube and Spotify)
local function processURL(url)
    -- Process YouTube URLs
    if string.match(url, "youtube") or string.match(url, "youtu.be") then
        return url
    -- Process Spotify URLs
    elseif string.match(url, "spotify") then
        -- Extract Spotify track ID
        local spotifyID = string.match(url, "track/([^?]+)")
        if spotifyID then
            -- Convert Spotify URL to YouTube URL format that xSound can handle
            -- Note: In a real implementation, you would need to use a service or API to convert
            -- Spotify tracks to playable URLs. For the purposes of this script, we're assuming
            -- xSound has been modified to handle Spotify URLs directly.
            return url
        end
    end
    return url
end

RegisterNetEvent('dj_baspel:playMusic', function (musicURL)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    local processedURL = processURL(musicURL)
    
    for k, v in pairs(Config.Locations) do
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - v.coords)
        
        if dist < 3 then
            local defaultVolume = Config.DefaultVolume
            xSound:PlayUrlPos(-1, v.name, processedURL, defaultVolume, coords)
            xSound:Distance(-1, v.name, v.radius)
            v.isPlaying = true
            
            if Config.Debug then
                print('DEBUG dj_baspel | The music started playing at the coordinates: '..coords..' in radius: '..v.radius)
            end
        end
    end
end)

RegisterNetEvent('dj_baspel:stopMusic', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    for k, v in pairs(Config.Locations) do
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - v.coords)
        
        if dist < 3 then
            if v.isPlaying then
                v.isPlaying = false
                xSound:Destroy(-1, v.name)
                
                if Config.Debug then
                    print('DEBUG dj_baspel | Music turned off at coordinates: '..coords)
                end
            end
        end
    end
end)

RegisterNetEvent('dj_baspel:pauseMusic', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    for k, v in pairs(Config.Locations) do
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - v.coords)
        
        if dist < 3 then
            if v.isPlaying then
                v.isPlaying = false
                xSound:Pause(-1, v.name)
                
                if Config.Debug then
                    print('DEBUG dj_baspel | The music paused at the coordinates: '..coords)
                end
            end
        end
    end
end)

RegisterNetEvent('dj_baspel:resumeMusic', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    for k, v in pairs(Config.Locations) do
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - v.coords)
        
        if dist < 3 then
            if not v.isPlaying then
                v.isPlaying = true
                xSound:Resume(-1, v.name)
                
                if Config.Debug then
                    print('DEBUG dj_baspel | Music resumed at coordinates: '..coords)
                end
            end
        end
    end
end)

RegisterNetEvent('dj_baspel:changeVolume', function(volume)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    for k, v in pairs(Config.Locations) do
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local dist = #(coords - v.coords)
        
        if dist < 3 then
            if not tonumber(volume) then return end
            
            if v.isPlaying then 
                xSound:setVolume(-1, v.name, volume)
                
                if Config.Debug then
                    print('DEBUG dj_baspel | Music volume changed to: '..volume)
                end
            end
        end
    end
end)