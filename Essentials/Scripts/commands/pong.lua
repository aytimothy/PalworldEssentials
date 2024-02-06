-- Ping
local pong = {
    adminOnly = false,
    run = function(sender, rawMessage, commandArgs)
        local utilities = require("./../utilities")
        utilities.SendMessage(sender, "Ping!")
    end
}

return pong