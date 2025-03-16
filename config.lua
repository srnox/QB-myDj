Config = {}

--- Common settings ---
Config.Debug = false -- If you want debug in console
Config.DefaultVolume = 0.1 -- Accepted values are 0.01 - 1
Config.Distance = 5.0 -- Don't touch this

--- Target system ---
Config.UseTarget = false -- Set to true to use qb-target, false to use text UI

--- Locations ---
Config.Locations = {
    {
        onlyJob = false,
        job = 'nil',
        name = 'Hookah',
        coords = vec3(-433.1052, 30.9085, 46.2948),
        radius = 30,
        distance = 2.5,
        isPlaying = false
    },
    {
        onlyJob = false,
        job = 'nil',
        name = 'Galaxy',
        coords = vec3(-410.8970, 47.2771, 53.2504),
        radius = 30,
        distance = 2.5,
        isPlaying = false
    }
}

Config.Language = {
    ['openMenu'] = '[E] - Open DJ Menu',
    ['titleMenu'] = '💿 | DJ Console',
    ['playSong'] = '🎶 | Play a song',
    ['playSongDesc'] = 'Enter a YouTube URL',
    ['pauseMusic'] = '⏸️ | Pause Music',
    ['pauseMusicDesc'] = 'Pause a currently playing music',
    ['resumeMusic'] = '▶️ | Resume Music',
    ['resumeMusicDesc'] = 'Resume playing paused music',
    ['changeVolume'] = '🔈 | Change Volume',
    ['changeVolumeDesc'] = 'Change volume of song',
    ['stopMusic'] = '❌ | Turn off music',
    ['stopMusicDesc'] = 'Stop the music & choose a new song',
    ['songSel'] = 'Song Selection',
    ['url'] = 'YouTube URL',
    ['musicVolume'] = 'Music Volume',
    ['musicVolumeNm'] = 'Min: 0.01 - Max: 1', -- Pls dont change numbers (0.01 - 1)

    --- Playlist ---
    ['playlistMenu'] = '🎶 | DJ Playlist',
    ['playlistDesc'] = 'Play a song from playlist',
    ['playlistMenuTitle'] = '🎶 | Select a song'
}

Config.Playlist = {
    --- First Song
    ['first'] = '💿 | Mess', -- Name of first song
    ['desc_first'] = 'Description of the song', -- Description of the song
    ['music_first_id'] = 'https://www.youtube.com/watch?v=-Kjrf-pxQc4', -- URL from YT or Spotify

    --- Second Song ---
    ['second'] = '💿 | Shiver',
    ['desc_second'] = 'Description of the song',
    ['music_second_id'] = 'https://www.youtube.com/watch?v=NdUNtHqY5r8',

    --- Third Song ---
    ['third'] = '💿 | Good With It',
    ['desc_third'] = 'Description of the song',
    ['music_third_id'] = 'https://www.youtube.com/watch?v=RInypZYiiDM',

    --- Fourth Song ---
    ['fourth'] = '💿 | Back To You',
    ['desc_fourth'] = 'Description of the song',
    ['music_fourth_id'] = 'https://www.youtube.com/watch?v=rrzHAoA-oRI',

    --- Fifth Song ---
    ['fifth'] = '💿 | Curse',
    ['desc_fifth'] = 'Description of the song',
    ['music_fifth_id'] = 'https://www.youtube.com/watch?v=XsmuiDRKbDk',

    --- Spotify Examples (add your own) ---
    ['sixth'] = '💿 | Spotify Example 1',
    ['desc_sixth'] = 'Example Spotify track',
    ['music_sixth_id'] = 'https://open.spotify.com/track/4cOdK2wGLETKBW3PvgPWqT',

    ['seventh'] = '💿 | Spotify Example 2',
    ['desc_seventh'] = 'Another Spotify example',
    ['music_seventh_id'] = 'https://open.spotify.com/track/5PjdY0CKGZdEuoNab3yDmX'
}