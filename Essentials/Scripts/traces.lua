local traces = {}

local utilities = require("./utilities")

function traces.RegisterDebugHooks()
    print("Registering Debug Hooks...")

    RegisterHook("/Script/Pal.PalPlayerState:EnterChat_Receive", function(Context, ChatMessage) 
        print("/Script/Pal.PalPlayerState:EnterChat_Receive")
        local chatMessage = ChatMessage:get()
        local sender = chatMessage.Sender:ToString()
        local senderGuid = utilities.GuidToString(chatMessage.SenderPlayerUId)
        local recipientGuid = utilities.GuidToString(chatMessage.ReceiverPlayerUId)
        local messageType = chatMessage.Category
        local message = chatMessage.Message:ToString()
        print(string.format("ChatMessage: {\"sender\": \"%s\", \"senderGuid\": \"%s\", \"recipientGuid\": \"%s\", \"messageType\": %i, \"message\": \"%s\"}", sender, senderGuid, recipientGuid, messageType, message))
    end)

    RegisterHook("/Script/Pal.PalPlayerState:EnterChat", function(Context, Category, Message)
        print("/Script/Pal.PalPlayerState:EnterChat")
    end)

    RegisterHook("/Script/Pal.PalGameStateInGame:BroadcastChatMessage", function(Context, ChatMessage)
        print("/Script/Pal.PalGameStateInGame:BroadcastChatMessage")
        local chatMessage = ChatMessage:get()
        local sender = chatMessage.Sender:ToString()
        local senderGuid = utilities.GuidToString(chatMessage.SenderPlayerUId)
        local recipientGuid = utilities.GuidToString(chatMessage.ReceiverPlayerUId)
        local messageType = chatMessage.Category
        local message = chatMessage.Message:ToString()
        print(string.format("ChatMessage: {\"sender\": \"%s\", \"senderGuid\": \"%s\", \"recipientGuid\": \"%s\", \"messageType\": %i, \"message\": \"%s\"}", sender, senderGuid, recipientGuid, messageType, message))
    end)
end

return traces