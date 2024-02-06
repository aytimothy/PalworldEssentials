-- Ping
local pong = {
    adminOnly = false,
    run = function(sender, rawMessage, commandArgs)
        local utilities = require("./../utilities")
        utilities.SendBroadcast(sender, "Pong!")
    end
}

return pong