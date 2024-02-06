-- Teleports a player to another, or you to said player
local tp = {
    adminOnly = true,
    run = function(sender, rawMessage, commandArgs)
        local utilities = require("./../utilities")
        local target = nil
        local destination = nil
        if commandArgs[1] == nil then
            utilities.SendMessage(sender, "/tp <dest> or /tp <target> <dest>")
            return
        elseif commandArgs[2] ~= nil then
            target = utilities.GetPlayer(commandArgs[1])
            destination = utilities.GetPlayer(commandArgs[2])
            if target == nil then
                utilities.SendMessage(sender, string.format("ERROR: Target player '%s' does not exist...", commandArgs[1]))
                return
            end
            if destination == nil then
                utilities.SendMessage(sender, string.format("ERROR: Destination player '%s' does not exist...", commandArgs[2]))
                return
            end
        else
            target = sender
            destination = utilities.GetPlayer(commandArgs[1])
            if destination == nil then
                utilities.SendMessage(sender, string.format("ERROR: Destination player '%s' does not exist...", commandArgs[1]))
                return
            end
        end

        local PalUtility = utilities.GetPalUtility()
        PalUtility:Teleport(target, destination:K2_GetActorLocation(), destination:K2_GetActorRotation(), true, false)
    end
}

return tp