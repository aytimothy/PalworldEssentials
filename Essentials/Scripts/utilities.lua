-- Copied from Okaetsu's utilities.lua

local utilities = {}

function utilities.GuidToString(Guid)
    local a = string.format("%016x", Guid.A)
    local b = string.format("%016x", Guid.B)
    local c = string.format("%016x", Guid.C)
    local d = string.format("%016x", Guid.D)
    return a .. b .. c .. d
end

function utilities.GuidToString2(Guid)
    local a = string.format("%016x", Guid["A"])
    local b = string.format("%016x", Guid["B"])
    local c = string.format("%016x", Guid["C"])
    local d = string.format("%016x", Guid["D"])
    return a .. b .. c .. d
end

function utilities.GetPalUtility() 
    return StaticFindObject("/Script/Pal.Default__PalUtility")
end

local PalUtility = utilities.GetPalUtility()

-- function utilities.GetPalGameStateInGame()
function utilities.GetPalGameStateInGame(WorldContext)
	-- return StaticFindObject("/Script/Pal.Default__PalGameStateInGame")
    -- return FindFirstOf("APalGameStateInGame")
    if PalUtility == nil or not PalUtility:IsValid() then
        PalUtility = utilities.GetPalUtility()
    end
    return PalUtility:GetPalGameWorldSettings(WorldContext)
end

function utilities.GetPalGameStateInGame2()
    -- return FindFirstOf("APalGameStateInGame")
	return StaticFindObject("/Script/Pal.Default__PalGameStateInGame")
end

local PalGameSetting = nil

function utilities.GetPalGameSetting()
    if PalGameSetting == nil or not PalGameSetting:IsValid() then
        PalGameSetting = FindFirstOf("PalGameSetting")
    end

    return PalGameSetting
end

local GameplayStatics = StaticFindObject("/Script/Engine.Default__GameplayStatics")

function utilities.GetAllActorsOfClass(WorldContextObject, Class, OutArray)
    GameplayStatics:GetAllActorsOfClass(WorldContextObject, Class, OutArray)
end

function utilities.SendBroadcast(WorldContext, Message)
    if PalUtility == nil or not PalUtility:IsValid() then
        PalUtility = utilities.GetPalUtility()
    end

    PalUtility:SendSystemAnnounce(WorldContext, Message)
end

local InGameState = nil

local printChatMessage = function(message)
    local sender = message.Sender
    local senderGuid = message.SenderPlayerUId
    local recipientGuid = message.ReceiverPlayerUId
    local messageType = message.Category
    local message = message.Message
    if messageType == 0 then
        messageType = "0: None"
    elseif messageType == 1 then
        messageType = "1: Global"
    elseif messageType == 2 then
        messageType = "2: Guild"
    elseif messageType == 3 then
        messageType = "3: Say"
    else
        messageType = string.format("{0}: Unknown", messageType)
    end
    print(string.format("[%s] %s (%s > %s): %s\n", messageType, sender, senderGuid, recipientGuid, message))
end

function utilities.SendMessage(WorldContext, Message)
    local _message = Message
    if PalUtility == nil or not PalUtility:IsValid() then
        PalUtility = utilities.GetPalUtility()
    end
    if InGameState == nil or not InGameState:IsValid() then
        -- InGameState = utilities.GetPalGameStateInGame(WorldContext)
        InGameState = utilities.GetPalGameStateInGame2()
    end

    local Pal = FindFirstOf("Pal")
    local CoreUObject = FindFirstOf("CoreUObject")
    local FGuid = require("./types/fguid")
    local FPalChatMessage = require("./types/fpalchatmessage")
    local chatMessage = FPalChatMessage.new(0, "SYSTEM", 1, Message, WorldContext.PlayerId)
    printChatMessage(chatMessage)
    InGameState:BroadcastChatMessage(chatMessage)
end

function utilities.GetPlayer(Id)
    local Players = FindAllOf("PalPlayerController")

    for index, player in pairs(Players) do
        local playerState = player:GetPalPlayerState()
        if playerState ~= nil and playerState:IsValid() then
            local playerId = tostring(playerState.PlayerId)
            local playerUId = string.lower(utilities.GuidToString(playerState.PlayerUId))
            local username = string.lower(playerState.PlayerNamePrivate:ToString())
            local inputId = string.lower(Id)
            if playerId == inputId or playerUId == inputId or username == inputId then
                return player
            end
        end
    end
    return nil
end

function utilities.IsPlayerAdmin(PlayerState)
    return PlayerState:GetPlayerController().bAdmin
end

function utilities.SplitCommandIntoArgs(Command)
    local Args = {}
    local Index = 0
    for match in Command:gmatch("%S+") do
        Args[Index] = match
        Index = Index + 1
    end
    return Args
end

return utilities