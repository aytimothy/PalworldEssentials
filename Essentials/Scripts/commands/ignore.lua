local ignore = {
    adminOnly = false,
    run = function(sender, rawMessage, commandArgs)
        -- skip because this is a system command.
    end
}

return ignore