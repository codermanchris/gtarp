local Queries = {
    DoesAccountExist = 'select Id from `account` where SteamId=@SteamId;',
    CreateAccount = 'insert into `account` (SteamId, SteamName, DiscordId) values (@SteamId, @SteamName, @DiscordId)',
    UpdateAccount = 'update `account` set SteamName=@SteamName, DiscordId=@DiscordId, LastLoginDate=current_timestamp where SteamId=@SteamId',
    GetAccount = 'select Id, PermissionLevel, CityAccess from `account` where SteamId=@SteamId',
    IsBanned = 'select * from accountban where (SteamId=@SteamId or IPAddress=@IPAddress) and ExpireDate > CURRENT_TIMESTAMP order by CreateDate desc;',
    GetCharacters = 'select * from `character` where SteamId=@SteamId',
    SetPermissions = 'update `account` set PermissionLevel=@PermissionLevel where SteamId=@SteamId',
    SetCityAccess = 'update `account` set CityAccess=@CityAccess where SteamId=@SteamId',
    HasRequiredCityAccess = 'select CityAccess from `account` where SteamId=@SteamId and CityAccess >= @CityAccess'
}

-- Load an account from the database, create if required
function Accounts.Load(playerId, steamId)
    -- get identifiers
    local steamName = GetPlayerName(playerId)
    local discordId = Accounts.GetDiscordId(playerId)

    -- check to see if this account is banned
    if (Accounts.IsBanned(source, steamId)) then
		return nil
    end

    -- fetch account data
    local accountData = Accounts.GetOrCreate(steamId, steamName, discordId)
    if (accountData == nil) then
        return nil
    end

    -- define account container
    local account = {
        -- from database
        Id = accountData.Id,
        PermissionLevel = accountData.PermissionLevel,
        CityAccess = accountData.CityAccess,
        
        -- extended
        PlayerId = playerId,
        SteamId = steamId,
        DiscordId = discordId,
        SteamName = steamName,
    }

    -- add to core accounts list for later use
    Core.AddAccount(playerId, account)
    
    -- log to database
    --Logs.Write(account.Id, -1, account.PermissionLevel, 'connect')

    -- log in console
    print('> Loaded account (' .. tostring(playerId) .. ' ' .. steamName .. ': ' .. steamId)

    --
    return account
end

-- Check to see if an accounts exists
-- Note: this is a blocking call.
function Accounts.Exists(steamId)
    local params = { ['@SteamId'] = steamId }
	local data = MySQL.Sync.fetchAll(Queries.DoesAccountExist, params)
	return data ~= nil and data[1] ~= nil
end

-- Check if an account is banned or not
-- note: this is a blocking call.
function Accounts.IsBanned(playerId, steamId)
	local endPoint = GetPlayerEP(playerId)	
	local params = {
		['@SteamId'] = steamId,
		['@IPAddress'] = tostring(endPoint)
	}
	
	local results = MySQL.Sync.fetchAll(Queries.IsBanned, params, true)	
	if (results[1] ~= nil) then
		Accounts.LastError = string.format('You have been banned for: ' .. results[1].Reason)
		return true
	end
	
	return false
end


-- Get or create an account for a player
-- note: this is a blocking call.
function Accounts.GetOrCreate(steamId, steamName, discordId)
    local params = {
        ['@SteamId'] = steamId,
        ['@SteamName'] = steamName,
        ['@DiscordId'] = discordId
    }

    if (not Accounts.Exists(steamId)) then
        Accounts.Create(steamId, steamName, discordId)
    else
        Accounts.Update(steamId, steamName, discordId)
    end
    
    -- fetch account data
    local data = MySQL.Sync.fetchAll(Queries.GetAccount, { ['@SteamId'] = steamId })
    if (data == nil or data[1] == nil) then
        return nil
    end

    return data
end

-- Create a new account
-- note: this is a blocking call.
function Accounts.Create(steamId, steamName, discordId)
    local params = {
        ['@SteamId'] = steamId,
        ['@SteamName'] = steamName,
        ['@DiscordId'] = discordId
    }

    MySQL.Sync.execute(Queries.CreateAccount, params)
end

-- Update last login time, discord id, steam name for an account
function Accounts.Update(steamId, steamName, discordId)
    local params = {
        ['@SteamId'] = steamId,
        ['@SteamName'] = steamName,
        ['@DiscordId'] = discordId
    }

    MySQL.Async.execute(Queries.UpdateAccount, params)
end

-- Get Discord account associated to this account
function Accounts.GetDiscordId(playerId)
	local identifiers = GetPlayerIdentifiers(playerId)
	for i=1, #identifiers do
		if (string.match(identifiers[i], "discord")) then
			return identifiers[i]
		end
    end    
    return nil
end

-- Get an account's characters
-- note: this is a blocking call.
function Accounts.LoadCharacters(steamId)    
	return MySQL.Sync.fetchAll(Queries.GetCharacters, { ['@SteamId'] = steamId })
end

-- Set an account's permission level
-- note: this is a non-blocking call.
function Accounts.SetPermissions(steamId, permissionLevel)
	local params = {
		['@SteamId'] = steamId,
		['@PermissionLevel'] = permissionLevel,
	}
	MySQL.Async.execute(Queries.SetPermissions, params,
		function(rowsChanged)
		end)
end

-- Set an account's city access level
-- note: this is a non-blocking call.
function Accounts.SetCityAccess(steamId, cityAccess)
	local params = {
		['@SteamId'] = steamId,
		['@CityAccess'] = cityAccess
	}
	MySQL.Async.execute(Queries.SetCityAccess, params, 
		function(rowsChanged)
		end)
end

-- Check to see if this account meets the current city access requirement
-- note: this is a blocking call.
function Accounts.HasCityAccess(steamId)
	local params = {
 		['@SteamId'] = steamId,
 		['@CityAccess'] = Core.RequiredCityAccess
	}

	local result = MySQL.Sync.fetchAll(Queries.HasRequiredCityAccess, params)	
	if (result[1] ~= nil) then
		return true
    end
    	
	Accounts.LastError = string.format('You do not have the required City Access to join. Current CA Level: %d', Core.RequiredCityAccess)
	return false
end

function Accounts.CanConnect(playerId, steamName)
    -- deny if the server is still booting up.
    if (Core.IsBootingUp) then
       return false, 'Server is initializing. Please try again in a few minutes.'
    end

    -- if the server is set to block connections
    if (not Core.IsAllowingConnections) then
        return false, 'This server is not accepting any connections.'
    end

    -- validate steam identifier
    local steamId = GetPlayerIdentifiers(playerId)[1]
	if (steamId == nil) then
		return false, 'Invalid steam id.'
    end
    
    -- vaidate license is a steam id
    if (not Helpers.StringStartsWith(steamId, 'steam')) then
		return false, 'You must be logged in to steam.'
    end
    
    -- don't let this person connect if his ping is too high
	if (GetPlayerPing(playerId) > Core.MaxPing) then
		return false, 'Your ping is too high for this server.'
    end
    
	if (not Accounts.HasCityAccess(steamId)) then
		return false
	else	
		return true
	end	

    return false, 'This is a private server.'
end

-- Ban an account
function Accounts.Ban(banner, playerId, expireDate, reason)
    local account = Core.GetAccount(playerId)
	if (account == nil) then
		return false
	end
	
    if (banner.PermissionLevel <= account.PermissionLevel) then
        Core.Respond(bannerId, '^1You cannot ban that person.')
        return false
	end
	
	local params = {
		['@ExpireDate'] = expireDate,
		['@Reason'] = reason,
		['@CreatorSteamId'] = banner.SteamId,
		['@SteamId'] = account.SteamId
	}
	
	MySQL.Async.execute(Queries.BanAccount, params, function(rowsChanged) 
        print('> SteamId ' .. account.SteamId .. ' has been banned until ' .. expireDate .. '.')        
	end)
	
	return true
end

--
function Accounts.BanIP(ip, expireDate, reason, bannerId)
	local query = 'insert into accountban (ExpireDate, Reason, CreatorSteamId, IPAddress) values (@ExpireDate, @Reason, @CreatorSteamId, @IPAddress)'
	local params = {
		['@ExpireDate'] = expireDate,
		['@Reason'] = reason,
		['@CreatorSteamId'] = bannerId,
		['@IPAddress'] = ip
	}
	
	MySQL.Async.execute(query, params, function(rowsChanged) 
		print('> IP ' .. ip .. ' has been banned until ' .. expireDate .. '.')
	end)
end

function Accounts.Request(playerId)
	-- validate requesters steam id
	local steamId = GetPlayerIdentifiers(source)[1]
	if (steamId == nil or string.len(steamId) == 0) then
		DropPlayer(source, 'Invalid Steam id.')
		return
	end
	
	-- load this account
	local account = Accounts.Load(playerId, steamId)
	if (account == nil) then
		return
	end
		
	-- sync player weather with server
	Weather.SyncPlayer(source)

	-- send account data and character list to player
	Core.Event(playerId, 'gtarp:SetAccountData', account.PermissionLevel, account.CityAccess, account:GetCharacters())

	-- debug
	print('debug: received request account data. ' .. tostring(playerId))    
end