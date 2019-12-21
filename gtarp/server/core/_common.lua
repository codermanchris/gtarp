-- 
Core = {
    Accounts = {},
    IsBootingUp = true,
    IsPurging = false,
    IsAllowingConnections = false,
    MaxPing = 200,
    RequiredCityAccess = 0, 
    SpawnPoints = {
        { x = 260.10614013672, y = -1204.5545654297, z = 29.289054870605 },
        { x = 117.43503570557, y = -1730.1306152344, z = 30.110050201416 },
        { x = -213.87982177734, y = -1029.7891845703, z = 30.140361785889 },
        { x = -512.63525390625, y = -668.36431884766, z = 11.808960914612 },
        { x = -1347.0295410156, y = -464.91146850586, z = 15.045372962952 },
        { x = -807.85357666016, y = -138.04573059082, z = 19.95029258728 },
        { x = -298.07986450195, y = -357.47406005859, z = 10.063076019287 },
        { x = 248.33613586426, y = -1203.8864746094, z = 38.924839019775 },
        { x = -538.69183349609, y = -1283.0510253906, z = 26.901605606079 },
        { x = -887.59796142578, y = -2320.7209472656, z = -11.732743263245 },
        { x = -1092.6558837891, y = -2720.22265625, z = -7.4101371765137 }
    }
}

--
Accounts = {
    Whitelist = {},
    BanList = {},
    Staff = {}    
}

-- 
Logs = {
    IsEnabled = true
}

--
Commands = {}

--
Characters = {
    FiredWeapons = {},
    PhoneCalls = {},
    RadioFrequencies = {}
}

Helpers = {}

-- 
Vehicles = {
    PlayerVehicles = {},
    WorkVehicles = {}    
}

--
WeatherTypes = {
    Clear = 'clear',
}

--
Weather = {
    IsInitialized = false,
    CurrentWeather = WeatherTypes.Clear,
    QuickWeather = nil,
    CurrentTime = {
        Hour = 6,
        Minute = 0,
        Seconds = 0
    }
}

--
Jobs = {}

