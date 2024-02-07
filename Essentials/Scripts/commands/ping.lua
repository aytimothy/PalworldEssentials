-- Pong!
local ping = {
    adminOnly = false,
    run = function(sender, rawMessage, commandArgs)
        local utilities = require("./../utilities")
        utilities.SendMessage(sender, "Pong!", sender)
    end
}

return ping