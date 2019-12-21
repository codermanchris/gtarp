Vehicle = {}
Vehicle.__index = Vehicle

setmetatable(Vehicle, {
	__call = function(self, playerId, data)
	
		local vehicle = {}
		vehicle.PlayerId = playerId
		vehicle.Id = data.Id
		vehicle.CharacterId = data.CharacterId
		vehicle.ModelName = data.ModelName
		vehicle.DisplayName = data.DisplayName
		vehicle.LicensePlate = data.LicensePlate
		vehicle.Fuel = data.Fuel

		-- 
		vehicle.IsLost = data.IsLost
		vehicle.LostFee = data.LostFee

		vehicle.IsImpounded = data.IsImpounded
		vehicle.ImpoundCost = data.ImpoundCost
		vehicle.ImpoundDate = data.ImpoundDate
		vehicle.ImpoundReason = data.ImpoundReason
		vehicle.ImpoundOfficer = data.ImpoundOfficer
		
		vehicle.BodyHealth = data.BodyHealth
		vehicle.EngineHealth = data.EngineHealth

		vehicle.IsSpawned = data.IsSpawned
		vehicle.IsForSale = data.IsForSale
		vehicle.SalePrice = data.SalePrice
		
		-- mods
		vehicle.Spoiler = data.Spoiler
		vehicle.FrontBumper = data.FrontBumper
		vehicle.BackBumper = data.BackBumper
		vehicle.Skirt = data.Skirt
		vehicle.Exhaust = data.Exhaust
		vehicle.Rollcage = data.Rollcage
		vehicle.Grille = data.Grille
		vehicle.Hood = data.Hood
		vehicle.FrontFender = data.FrontFender
		vehicle.RearFender = data.RearFender
		vehicle.Roof = data.Roof
		vehicle.Engine = data.Engine
		vehicle.Brakes = data.Brakes
		vehicle.Transmission = data.Transmission
		vehicle.Horn = data.Horn
		vehicle.Suspension = data.Suspension
		vehicle.Armor = data.Armor
		vehicle.PlateHolder = data.PlateHolder
		vehicle.VanityPlate = data.VanityPlate
		vehicle.Trim1 = data.Trim1
		vehicle.Ornament = data.Ornament
		vehicle.Dashboard = data.Dashboard
		vehicle.Dial = data.Dial
		vehicle.DoorSpeaker = data.DoorSpeaker
		vehicle.Seat = data.Seat
		vehicle.SteeringWheel =	data.SteeringWheel
		vehicle.Shifter = data.Shifter
		vehicle.Plaque = data.Plaque
		vehicle.Speaker = data.Speaker
		vehicle.Trunk = data.Trunk
		vehicle.Hydraulic = data.Hydraulic
		vehicle.EngineBlock = data.EngineBlock
		vehicle.AirFilter = data.AirFilter
		vehicle.Strut = data.Strut
		vehicle.ArchCover = data.ArchCover
		vehicle.Aerial = data.Aerial
		vehicle.Trim2 = data.Trim2
		vehicle.Tank = data.Tank
		vehicle.Window = data.Window
		vehicle.Livery = data.Livery
		vehicle.WindowTint = data.WindowTint
		vehicle.PrimaryColorType = data.PrimaryColorType
		vehicle.PrimaryColor = data.PrimaryColor
		vehicle.SecondaryColorType = data.SecondaryColorType
		vehicle.SecondaryColor = data.SecondaryColor
		vehicle.WheelType = data.WheelType
		vehicle.WheelColor = data.WheelColor
		vehicle.FrontWheels = data.FrontWheels
		vehicle.RearWheels = data.RearWheels
		vehicle.PlateIndex = data.PlateIndex
		vehicle.Headlight = data.Headlight
		vehicle.Turbo = data.Turbo
		vehicle.NeonR = data.NeonR
		vehicle.NeonG = data.NeonG
		vehicle.NeonB = data.NeonB
		vehicle.NeonLayoutId = tonumber(data.NeonLayoutId)

        -- storage
        vehicle.GloveBox = {}
        vehicle.CenterConsole = {}
		vehicle.Trunk = {}

		return setmetatable(vehicle, Vehicle)
	end
})
