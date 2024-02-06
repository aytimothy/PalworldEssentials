-- Private message /msg <target> <msg>...
local message = {
    adminOnly = false,
    run = function(sender, rawMessage, commandArgs)
        local utilities = require("./../utilities")
        
        local recipient = utilities.GetPlayer(commandArgs[1])
        if recipient == nil then
            utilities.SendMessage(sender, string.format("Unknown player '%s'", commandArgs[1]))
            return
        end

        local actualMessage = rawMessage.message:ToString()
        actualMessage = string.sub(string.len(commandArgs[0]) + string.len(commandArgs[1]) + 3)
        
        -- Create message payload
        local Pal = FindFirstOf("Pal")
        local CoreUObject = FindFirstOf("CoreUObject")
        local FPalChatMessage = Pal.FPalChatMessage
        local chatMessage = StaticConstructObject(FPalChatMessage, WorldContext, 0, 0, 0, nil, false, false, nil)
        local playerName = sender.Sender:ToString()
        local playerId = sender.SenderPlayerUId
        local recipientId = recipient.PlayerUId
        chatMessage.Sender = playerName
        chatMessage.SenderPlayerUId = playerId
        chatMessage.RecipientPlayerUId = recipientId
        chatMessage.Category = 0
        chatMessage.message = actualMessage

        -- Send message payload
        PalUtility = utilities.GetPalUtility()
        InGameState = utilities.GetPalGameStateInGame2()
        InGameState:BroadcastChatMessage(chatMessage)
    end
}

return message