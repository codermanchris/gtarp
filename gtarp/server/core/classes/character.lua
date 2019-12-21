-- Class Definition
Character = {}
Character.__index = Character

setmetatable(Character, {
	__call = function(self, playerId, data)
		local character = {}
		
		character.PlayerId = playerId
		character.Id = data.Id
		character.PermissionLevel = data.PermissionLevel
		character.SteamId = data.SteamId
        character.IsAdmin = false
        character.ServerId = data.ServerId
        
        -- gang information
		character.GangId = data.GangId
        character.GangRank = data.GangRank
        character.GangReputation = data.GangReputation

		-- arrays
		character.SkinProfiles = {}
		character.Inventory = {}
		character.Weapons = {}
		character.Vehicles = {}		
		character.Arrests = {}
		character.Citations = {}

		-- admin infomation
		character.AdminShowIds = false
		character.IsSpectating = false
		character.LastTeleportLocation = nil
		
		-- personal information
		character.TwitterName = data.TwitterName
		character.FirstName = data.FirstName
		character.LastName = data.LastName
		character.DateOfBirth = data.DateOfBirth
        character.MobileNumber = data.MobileNumber

        -- permits/licenses
		character.HasWeaponPermit = data.HasWeaponPermit
        character.HasConcealedPermit = data.HasConcealedPermit
        character.HasHuntingPermit = data.HasHuntingPermit		
        character.HasRealtorLicense = data.HasRealtorLicense
        
        -- house information
		character.HouseZoneName = data.HouseZoneName
		character.HouseId = data.HouseId
        
        -- insurance information
		character.HasInsurance = data.HasInsurance
		character.HasMoeJack = data.HasMoeJack
		character.InsuranceCost = data.InsuranceCost
		character.NextInsurancePaymentAt = data.NextInsurancePaymentAt
		character.NextMoeJackPaymentAt = data.NextMoeJackPaymentAt
		
		-- officer/ems information
		character.IsOfficer = data.IsOfficer
		character.IsEms = data.IsEms
		character.PoliceDepartment = data.PoliceDepartment
		character.EmsDepartment = data.EmsDepartment
		character.PoliceTag = data.PoliceTag
		character.EmsTag = data.EmsTag
		character.OfficerRank = data.OfficerRank
		character.EmsRank = data.EmsRank
		character.Status = data.Status
		character.PoliceRadarSpeed = data.PoliceRadarSpeed
        
        -- officer certifications
		character.AirCertified = data.AirCertified
		character.K9Certified = data.K9Certified
		character.M4Certified = data.M4Certified
		character.SwatCertified = data.SwatCertified

		-- job
		character.LastJobId = data.JobId
				
		-- jail
		character.IsInJail = data.IsInJail
		character.JailReleaseDate = data.JailReleaseDate
		character.JailTime = data.JailTime
		character.JailReason = data.JailReason
		character.TotalJailedTime = data.TotalJailedTime
		character.SentToJailOn = data.SentToJailOn

		-- stats
		character.KilledCount = data.KilledCount
		character.KnockedOutCount = data.KnockedOutCount
		character.KickCount = data.KickCount
		character.BanCount = data.BanCount
		character.WarningCount = data.WarningCount

		-- robberies
		character.IsStealing = false
		character.RobberyIndex = -1
				
		-- money information
		character.Cash = tonumber(data.Cash)
        character.Bank = tonumber(data.Bank)
        character.BitCoin = tonumber(data.BitCoin)
        character.StateFines = tonumber(data.StateFines)
        character.MedicalFines = tonumber(data.MedicalFines)
		
		-- police information
		character.CautionCodes = data.CautionCodes
		character.IsWanted = data.IsWanted
		character.WantedReason = data.WantedReason
		character.WarrantAuthor = data.WarrantAuthor

		-- health information
		character.IsDead = data.IsDead
		
		-- position/chat
		character.Coords = { x = data.X, y = data.Y, z = data.Z }
		character.LastCoords = { x = data.X, y = data.Y, z = data.Z }
		
        -- license information
        character.LicensePoints = data.LicensePoints
		character.PassedDMVWritten = data.PassedDMVWritten
		character.PassedDMVDriven = data.PassedDMVDriven
		
		character.LicenseA = data.LicenseA
		character.LicenseB = data.LicenseB
		character.LicenseC = data.LicenseC
		character.LicenseM = data.LicenseM
		character.LicenseP = data.LicenseP		

		-- other
		character.IsUsingLockpick = false

		character.Tattoos = nil

        -- phone
		character.PhoneContacts = {}
		character.PhoneMessages = {}

		return setmetatable(character, Character)
	end
})
