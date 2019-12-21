-- Class Functions

function Characters.Get(playerId)
	-- get and validate account
	local account = Core.GetAccount(playerId)
	if (account == nil) then
		return nil
	end
	-- return account's selected character
	return account:GetCharacter()
end

function Characters.RequestCreate(playerId, characterData)
    -- get player's account
	local account = Core.GetAccount(playerId)
	if (account == nil) then
		DropPlayer(playerId, 'No account was found. ' .. playerId)
		return
	end
    
    -- is this character data valid?
    local canCreate, error = Characters.CanCreate(characterData)
    if (not canCreate) then		
        Core.Event(playerId, 'gtarp:CharacterCreateFailed', error)
		return
	end
    
    -- try and create the character
    local created, error = Characters.Create(playerId, account.Id, characterData)
    if (not created) then
        Core.Respond(playerId, '^1There was a problem creating that character.')
        return
    end
        
    -- load the new character into account
	Characters.Load(playerId, account.Id)
    
    -- notify client set characters list
    Core.Event(playerId, 'gtarp:SetCharacters', account.Characters)    
end

function Characters.Create(playerId, accountId, characterData)

end

function Characters.SetCoords(playerId, coords)
	-- validate account
	local account = Core.GetAccount(playerId)
	if (account == nil) then
		return
	end
	
	-- validate this player has an active character
	local character = account:GetCharacter()
	if (character == nil) then
		DropPlayer(source, 'No character is selected.')
		return
	end
	
	-- update this characters coords
	character:SetCoords(coords)
end

function Characters.Creator(playerId)
    local profile = Characters.GetEmptySkinProfile()
	profile.ModelName = 'a_m_y_hipster_01'
	profile.SkinType = 0

    Core.Event(playerId, 'gtarp:CharacterCreatorOpen', true, profile)
end

function Characters.Select(playerId, characterId, spawnId)
	-- get and validate account, drop if no account!
	local account = Core.GetAccount(playerId)
	if (account == nil) then
		DropPlayer(playerId, 'No account was found.')
		return
	end

	-- reset player client for new character if needed
	if (account:GetCharacter() ~= nil) then	
		print('GTARP: ' .. account.SteamName .. ' (' .. playerId .. ') is hot swaping characters. Last characterId was ' .. account:GetCharacter().Id .. ', next is ' .. characterId .. '.\n')
		account:GetCharacter():ClearDatas()
	end

	-- find the selected character 
	local character = nil
	local count = 0
	for _, c in pairs(account.Characters) do
		count = count + 1
		if (c.Id == characterId) then
			character = c
			break
		end
	end

	-- no character found
	if (character == nil) then
		Core.Event(playerId, 'gtarp:SelectedCharacter', false)
		return
	end
	
	-- load character data	
	account:LoadCharacter(count)

	-- build simple list of owned vehicles
	local ownedPlates = {}
	for k, v in pairs(character.Vehicles) do
		table.insert(ownedPlates, { Id = v.Id, LicensePlate = v.LicensePlate })
	end	

	Core.Event(playerId, 'gtarp:CharacterInit', character:GetClientInfo(), character:GetSkin(0), character.Items, character.Weapons, ownedPlates, character.Food, character.Thirst)
	Core.Event(-1, 'gtarp:CharacterAdd', playerId, account.SteamName, character:GetName(), account.PermissionLevel, false)
		
	-- send map info to this player
	Core.SendMapDataToPlayer(playerId)

    -- send gameplay datas to this player
    Apartment.GetStatuses(playerId)
    Bank.GetStatuses(playerId)
    House.GetStatuses(playerId)
	Store.GetStatuses(playerId)	
	
	if (character.GangId ~= 0) then
		GangLands.JoinGang(playerId, character.GangId, character.GangRank)
		GangLands.SendInfo(playerId, character.GangId)
	else
		GangLands.JoinGang(playerId, 0, 0)
	end
	
	-- notify player of other characters
	local accounts = GTARP.GetAllAccounts()
	for _, a in pairs(accounts) do
		local c = a:GetCharacter()
		if (c ~= nil) then
			if (a.Source ~= playerId) then
				Core.Event(playerId, 'gtarp:CharacterAdd', a.Source, a.SteamName, c:GetName(), a.PermissionLevel, c.IsAdmin)

				if (a.PermissionLevel >= 3) then
					Core.Respond(a.Source, string.format('^5** ^0%s ^5is playing as ^0%s^5.', account.SteamName, character:GetName()))
				end
			end
		end
	end
		
	-- check if there they were incap'd during disconnect and put the right back where they were.
	if (character.IsDead) then
		if (character.LastCoords.x == 0 and 
			character.LastCoords.y == 0 and 
			character.LastCoords.z == 0) then
			return
		end
		Core.Event(playerId, 'gtarp:TeleportPlayer', character.LastCoords.x, character.LastCoords.y, character.LastCoords.z)
		Core.Event(playerId, 'gtarp:KillPlayer')
		return
	end

	-- if this character is not in jail, figure out where to spawn him
	if (not character.IsInJail) then
		spawnId = tonumber(spawnId)
		if (spawnId < 0 or spawnId > 2) then
			spawnId = 0
		end
		
		if (spawnId == 0) then -- random spawn point
			--local spawnPoint = Core.GetRandomSpawnPoint() --.SpawnPoints[math.random(#Core.SpawnPoints)]
			Core.TeleportPlayer(playerId, Core.GetRandomSpawnPoint())
		elseif (spawnId == 1) then -- last coords
			if (character.LastCoords.x == 0 and 
				character.LastCoords.y == 0 and 
				character.LastCoords.z == 0) then
				return
			end
			Core.TeleportPlayer(playerId, character.LastCoords)
		elseif (spawnId == 2) then -- home
			local houses = House.GetCharacterHouses(character.Id)
			if (houses == nil or #houses == 0) then
				return
			end

			local home = House.Locations[houses[1].ZoneName][houses[1].HouseId]
			if (character.HouseZoneName ~= nil and character.HouseId ~= nil) then
				home = Home.Locations[character.HouseZoneName][character.HouseId]
			end
			if (home == nil) then
				return
			end
			Core.TeleportPlayer(playerId, home.Coords)
		end 
	else 
		-- if this person still has jail time, send them to jail	
		Jail.ForceToJail(character)
	end

	-- 
	if (Core.IsPurging) then
		if (Core.HasPurgeStarted) then
			Core.EmergencyBroadcast(playerId, 'There is currently a purge going on. Be safe out there.')
			Core.Event(playerId, 'gtarp:JoinPurge')
		end
	end    
end

function Characters.WeaponCheck(playerId, officerId)
	local character = Characters.Get(playerId)
	if (character == nil) then
		return
	end

	local itemsList = ''
	for k, v in pairs(weapons) do
		if (itemsList == '') then
			itemsList = string.sub(v, 8, string.len(v))
		else 
			itemsList = itemsList .. ', ' .. string.sub(v, 8, string.len(v))
		end
	end
	if (itemsList == '') then
		itemsList = 'no items'
	end

	Commands:Response(officerId, 'POLICE', {0,0,255}, itemsList)	
end