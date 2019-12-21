Chat = {}
Core = {}

LocalPlayer = {
    Id = GetPlayerServerId(PlayerId()), 
    CharacterName = nil,
    Ped = nil,
    Coords = nil,
    PermissionLevel = 0,
    CityAccess = 0,
    Food = 100.0,
    Thirst = 100.0,    
    IsRagdolling = false,
    IsCuffed = false,
    
    DrugsInSystem = {},
}

Characters = {}
Vehicles = {}
Jobs = {}
Threads = {}

UI = {
    HasOpenMenu = false,
    CurrentMenu = nil
}

Vehicle = {}

Weather = {
    IsInitiailized = false,
    CurrentWeather = 'clear',
    LastWeather = '',
    UpdateWeather = false,
    TimeBuffer = 0,
    CurrentTime = {
        Hour = 0,
        Minute = 0,
        Seconds = 0
    }
}
