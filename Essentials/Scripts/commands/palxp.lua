local palxp = {
    adminOnly = true,
    run = function(sender, rawMessage, commandArgs)
        local utilities = require("./../utilities")
        local palPlayerController = utilities.GetPlayer(sender.PlayerId)
        palPlayerController:Debug_AddPartyExp_ToServer(10000)
    end
}

return palxp