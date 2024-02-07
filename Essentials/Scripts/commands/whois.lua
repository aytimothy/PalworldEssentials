local whois = {
    adminOnly = true,
    run = function(sender, rawMessage, commandArgs)
        local utilities = require("./../utilities")
        if commandArgs[1] == nil then
            utilities.SendMessage(sender, "/whois <id/username>")
        else
            local player = utilities.GetPlayer(commandArgs[1])
            if player == nil then
                utilities.SendMessage(sender, string.format("Unknown player '%s'...", commandArgs[1]))
            else
                utilities.SendMessage(sender, "Found person, todo.")
            end
        end
    end
}

return whois