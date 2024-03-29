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

    RegisterHook("/Script/Pal.PalGameModeLogin:OnLoginCompleted", function(Context, UserInfo, bSuccess, ErrorStr)
        print("/Script/Pal.PalGameModeLogin:OnLoginCompleted")
        print(string.format("UserInfo: %s", UserInfo:get():GetFullName():ToString()))
        print(string.format("bSuccess: %s, ErrorStr: %s", tostring(bSuccess), ErrorStr:get():ToString()))
    end)

    RegisterHook("/Script/Engine.GameModeBase:K2_PostLogin", function(Context, NewPlayer)
        print("/Script/Engine.GameModeBase:K2_PostLogin")
        print(string.format("NewPlayer: %s", NewPlayer:get().GetFullName()))
    end)

    RegisterHook("/Script/Engine.GameModeBase:K2_OnLogout", function(Context, ExitingController)
        print("/Script/Pal.PalGamemode:K2_OnLogout")
        print(string.format("ExitingController: %s", ExitingController:get():GetFullName()))
    end)

    -- death is probably APalPlayerCharacter:OnPlayerDeathAction__DelegateSignature()

    RegisterHook("/Script/Pal.PalGameMode:RespawnPlayer", function(Context, PlayerIndex)
        print("/Script/Pal.PalGameMode:RespawnPlayer")
        print(string.format("PlayerIndex = %i", PlayerIndex))
    end)
end

return traces