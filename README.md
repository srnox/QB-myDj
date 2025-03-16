# 🎵 DJ System for QBCore

A comprehensive DJ system for QBCore servers that allows players to play music from YouTube and Spotify at designated locations.

## 📋 Features

- Play music from YouTube or Spotify URLs
- Control music playback (play, pause, resume)
- Adjust volume levels
- Predefined playlist with easy song selection
- Multiple DJ booth locations
- Job-specific access (optional)
- Compatible with qb-target

## 📸 Preview

[Insert screenshots or GIFs here]

## ⚙️ Dependencies

- [QBCore Framework](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target) (optional)
- [xSound](https://github.com/Xogy/xsound)
- [qb-menu](https://github.com/qbcore-framework/qb-menu)
- [qb-input](https://github.com/qbcore-framework/qb-input)

## 📥 Installation

1. Download the latest release
2. Extract the folder to your resources directory
3. Add `ensure dj-system` to your server.cfg
4. Restart your server

## ⚙️ Configuration

The script is designed to be easily configurable through the `config.lua` file:

### General Settings
```lua
Config.Debug = false -- Enable debug messages in console
Config.DefaultVolume = 0.1 -- Default music volume (0.01 - 1)
Config.Distance = 5.0 -- Distance for interaction
Config.UseTarget = false -- Set to true to use qb-target
```

### DJ Locations
You can add as many DJ locations as you want:

```lua
Config.Locations = {
    {
        onlyJob = false, -- Set to true to restrict to specific job
        job = 'nil', -- Job name if onlyJob is true
        name = 'Hookah', -- Location name
        coords = vec3(-433.1052, 30.9085, 46.2948), -- Coordinates
        radius = 30, -- Sound radius
        distance = 2.5, -- Interaction distance
        isPlaying = false -- Initial state
    },
    -- Add more locations as needed
}
```

### Playlist
Customize the predefined playlist:

```lua
Config.Playlist = {
    ['first'] = '💿 | Song Name',
    ['desc_first'] = 'Description of the song',
    ['music_first_id'] = 'https://www.youtube.com/watch?v=example',
    
    -- Add more songs as needed
}
```

## 🔧 Usage

### For Players
1. Approach a DJ booth
2. Press [E] or use Target interaction
3. Select from the menu options:
   - Play a song (enter YouTube/Spotify URL)
   - Select from playlist
   - Pause/Resume music
   - Adjust volume
   - Stop music

### For Developers
- You can add more songs to the playlist in `config.lua`
- Add new DJ locations in the `Config.Locations` table
- Customize interaction text in the `Config.Language` table