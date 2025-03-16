-----------------------------------------------------------------------------------
local QBCore = exports['qb-core']:GetCoreObject()
local LastZone, CurrentAction, hasAlreadyEnteredMarker, job = nil, nil, false, nil
local xSound = exports.xsound
-----------------------------------------------------------------------------------

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('dj_baspel:createMusicMenu', function()
    local MusicMenu = {
        {
            header = Config.Language['titleMenu'],
            isMenuHeader = true
        },
        {
            header = Config.Language['playSong'],
            txt = Config.Language['playSongDesc'],
            params = {
                event = 'dj_baspel:playMusicMenu'
            }
        },
        {
            header = Config.Language['playlistMenu'],
            txt = Config.Language['playlistDesc'],
            params = {
                event = 'dj_baspel:openPlaylistMenu'
            }
        },
        {
            header = Config.Language['pauseMusic'],
            txt = Config.Language['pauseMusicDesc'],
            params = {
                isServer = true,
                event = 'dj_baspel:pauseMusic'
            }
        },
        {
            header = Config.Language['resumeMusic'],
            txt = Config.Language['resumeMusicDesc'],
            params = {
                isServer = true,
                event = 'dj_baspel:resumeMusic'
            }
        },
        {
            header = Config.Language['changeVolume'],
            txt = Config.Language['changeVolumeDesc'],
            params = {
                event = 'dj_baspel:changeVolumeMenu'
            }
        },
        {
            header = Config.Language['stopMusic'],
            txt = Config.Language['stopMusicDesc'],
            params = {
                isServer = true,
                event = 'dj_baspel:stopMusic'
            }
        }
    }
    exports['qb-menu']:openMenu(MusicMenu)
end)

RegisterNetEvent('dj_baspel:openPlaylistMenu', function()
    local PlaylistMenu = {
        {
            header = Config.Language['playlistMenuTitle'],
            isMenuHeader = true
        },
        {
            header = Config.Playlist['first'],
            txt = Config.Playlist['desc_first'],
            params = {
                event = 'dj_baspel:playMusicFromPlaylist',
                args = {
                    music = Config.Playlist['music_first_id']
                }
            }
        },
        {
            header = Config.Playlist['second'],
            txt = Config.Playlist['desc_second'],
            params = {
                event = 'dj_baspel:playMusicFromPlaylist',
                args = {
                    music = Config.Playlist['music_second_id']
                }
            }
        },
        {
            header = Config.Playlist['third'],
            txt = Config.Playlist['desc_third'],
            params = {
                event = 'dj_baspel:playMusicFromPlaylist',
                args = {
                    music = Config.Playlist['music_third_id']
                }
            }
        },
        {
            header = Config.Playlist['fourth'],
            txt = Config.Playlist['desc_fourth'],
            params = {
                event = 'dj_baspel:playMusicFromPlaylist',
                args = {
                    music = Config.Playlist['music_fourth_id']
                }
            }
        },
        {
            header = Config.Playlist['fifth'],
            txt = Config.Playlist['desc_fifth'],
            params = {
                event = 'dj_baspel:playMusicFromPlaylist',
                args = {
                    music = Config.Playlist['music_fifth_id']
                }
            }
        },
        {
            header = "⬅ Go Back",
            params = {
                event = 'dj_baspel:createMusicMenu'
            }
        }
    }
    exports['qb-menu']:openMenu(PlaylistMenu)
end)

RegisterNetEvent('dj_baspel:playMusicFromPlaylist', function(data)
    local input = data.music
    if input then
        TriggerServerEvent('dj_baspel:playMusic', input)
    end
end)

RegisterNetEvent('dj_baspel:playMusicMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = Config.Language['songSel'],
        submitText = "Submit",
        inputs = {
            {
                text = Config.Language['url'],
                name = "url",
                type = "text",
                isRequired = true
            }
        }
    })
    
    if dialog then
        if dialog.url then
            TriggerServerEvent('dj_baspel:playMusic', dialog.url)
        end
    end
end)

RegisterNetEvent('dj_baspel:changeVolumeMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = Config.Language['musicVolume'],
        submitText = "Submit",
        inputs = {
            {
                text = Config.Language['musicVolumeNm'],
                name = "volume",
                type = "text",
                isRequired = true
            }
        }
    })
    
    if dialog then
        if dialog.volume then
            TriggerServerEvent('dj_baspel:changeVolume', dialog.volume)
        end
    end
end)

CreateThread(function()
    if not Config.UseTarget then
        while true do
            local sleep = 1500
            local playerCoords, inLocation, currentZone = GetEntityCoords(PlayerPedId()), false, false
            local PlayerData = QBCore.Functions.GetPlayerData()

            for i=1, #Config.Locations do
                local dist = #(playerCoords - Config.Locations[i].coords)
                if dist <= Config.Distance then
                    sleep = 0
                    if dist <= Config.Locations[i].distance and Config.Locations[i].onlyJob then
                        inLocation, currentZone, job = true, i, Config.Locations[i].job
                    elseif dist <= Config.Locations[i].distance and not Config.Locations[i].onlyJob then
                        inLocation, currentZone, job = true, i, nil
                    end
                end
            end

            if (inLocation and not hasAlreadyEnteredMarker and PlayerData.job.name == job) or (inLocation and LastZone ~= currentZone and PlayerData.job.name == job) then
                hasAlreadyEnteredMarker, LastZone = true, currentZone
                CurrentAction = 'musicMenu'
                exports['qb-core']:DrawText(Config.Language['openMenu'])
            elseif (inLocation and not hasAlreadyEnteredMarker and job == nil) or (inLocation and LastZone ~= currentZone and job == nil) then
                hasAlreadyEnteredMarker, LastZone = true, currentZone
                CurrentAction = 'musicMenu'
                exports['qb-core']:DrawText(Config.Language['openMenu'])
            end

            if not inLocation and hasAlreadyEnteredMarker then
                hasAlreadyEnteredMarker = false
                sleep = 1000
                CurrentAction = nil
                exports['qb-core']:HideText()
            end
            Wait(sleep)
        end
    else
        for k, v in pairs(Config.Locations) do
            if v.onlyJob then
                exports['qb-target']:AddCircleZone('dj_zone_'..k, v.coords, 1.0, {
                    name = 'dj_zone_'..k,
                    debugPoly = Config.Debug,
                }, {
                    options = {
                        {
                            type = "client",
                            event = "dj_baspel:createMusicMenu",
                            icon = "fas fa-music",
                            label = "DJ Console",
                            job = v.job,
                        },
                    },
                    distance = 2.5
                })
            else
                exports['qb-target']:AddCircleZone('dj_zone_'..k, v.coords, 1.0, {
                    name = 'dj_zone_'..k,
                    debugPoly = Config.Debug,
                }, {
                    options = {
                        {
                            type = "client",
                            event = "dj_baspel:createMusicMenu",
                            icon = "fas fa-music",
                            label = "DJ Console",
                        },
                    },
                    distance = 2.5
                })
            end
        end
    end
end)

if not Config.UseTarget then
    CreateThread(function()
        while true do
            local sleep = 1500
            if CurrentAction ~= nil then
                sleep = 0
                if IsControlPressed(1, 38) then
                    Wait(500)
                    if CurrentAction == 'musicMenu' then
                        TriggerEvent('dj_baspel:createMusicMenu')
                    end
                end
            end
            Wait(sleep)
        end
    end)
end