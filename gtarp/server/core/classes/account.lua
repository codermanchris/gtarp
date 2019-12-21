-- Class Definition
Account = {}
Account.__index = Account

setmetatable(Account, {
	__call = function(self, playerId, data)	
		local account = {}
		account.PlayerId = playerId
		account.Id = data.Id
		account.SteamId = data.SteamId
		account.SteamName = data.SteamName
		account.PermissionLevel = data.PermissionLevel
		account.CityAccess = data.CityAccess
		account.IsLoggedIn = true
		account.SelectedCharacterIndex = -1
		account.Characters = {}
		return setmetatable(account, Account)
	end
})

-- Class Functions
function Account:GetCharacter()
	return self.Characters[self.SelectedCharacterIndex]
end

function Account:GetCharacters()
	return self.Characters
end