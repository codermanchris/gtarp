-- Class Functions

function Jobs.Initialize()
    Jobs[1] = Clerk
    Jobs[2] = Doctor
end

-- Character wants to start a job
function Jobs.StartJob(playerId, jobId)
    -- make sure some hacker isn't being a cuck
    if (not Core.IsPlayerIdValid(source, playerId)) then
        return
    end

    -- get the job information
    local job = Jobs[jobId]
    if (job == nil) then
        return
    end

    -- get character
    local character = Characters.Get(playerId)
    if (character == nil) then
        return
    end

    -- if this character is already on a job, fail
    if (character.JobId > 0) then
        Core.Respond(playerId, '^2You are already working for someone else. Come back when you have no job.')
        return
    end

    -- get this player's rep for this job
    local rep = Jobs.GetReputation(playerId)
    if (rep == nil) then
        return
    end

    -- get character salary/job level
    character.Salary, character.JobLevel = Jobs.GetSalaryAndLevel(rep)
    character.JobId = jobId
    character.NextPayAt = os.time() + (60*5)

    -- start the job for this player
    job.StartShift(playerId, rep)

    -- notify the character that he/she has went on duty
    Core.Respond(playerId, '^1You have went on duty at ' .. job.Name .. ' as a ' .. character.JobLevel .. ' employee. You will be paid $' .. tostring(character.Salary) .. ' per pay period.')
end

-- Character wants to quit a job
function Jobs.QuitJob(playerId, jobId)
    -- make sure some hacker isn't being a cuck
    if (not Core.IsPlayerIdValid(source, playerId)) then
        return
    end

    -- get the job information
    local job = Jobs[jobId]
    if (job == nil) then
        return
    end

    -- get character
    local character = Characters.Get(playerId)
    if (character == nil) then
        return
    end

    -- if we're not on a job, do nothing
    if (character.JobId == 0) then
        return
    end

    -- end the job for this player
    job.EndShift(playerId)

    -- update character
    character.Salary = nil
    character.JobLevel = nil
    character.JobId = nil
    character.NextPayAt = nil

    -- notify character that he/she clocked out
    Core.Respond(playerId, '^1You have clocked out.')
end

-- Character is requesting pay for their job
-- note: the actual timer for request is on the client
--       server only validates timespan.
function Jobs.RequestPay(playerId)
    -- make sure some hacker isn't being a cuck
    if (not Core.IsPlayerIdValid(source, playerId)) then
        return
    end

    -- get character
    local character = Characters.Get(playerId)
    if (character == nil) then
        return
    end

    -- give 2 second leeway for lag
    if (character.NextPayAt ~= nil and character.NextPayAt < os.time() - 2) then
        character.NextPayAt = os.time() + (60*5)

        -- give character cash
        character:AddCash(character.Salary)
        
        -- notify client of payment
        Core.Event(playerId, 'gtarp:ReceivedSalary', character.Salary, character.JobLevel)
    end
end
