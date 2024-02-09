-- Copied from Okaetsu's utilities.lua

local utilities = {}

function utilities.GuidToString(Guid)
    local a = string.sub(string.format("%016x", Guid.A), -8)
    local b = string.sub(string.format("%016x", Guid.B), -8)
    local c = string.sub(string.format("%016x", Guid.C), -8)
    local d = string.sub(string.format("%016x", Guid.D), -8)
    return a .. b .. c .. d
end

function utilities.GuidToString2(Guid)
    local a = string.sub(string.format("%016x", Guid["A"]), -8)
    local b = string.sub(string.format("%016x", Guid["B"]), -8)
    local c = string.sub(string.format("%016x", Guid["C"]), -8)
    local d = string.sub(string.format("%016x", Guid["D"]), -8)
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
    local messageType = "?: Unknown"
    if message.Category == 0 then
        messageType = "0: None"
    elseif message.Category == 1 then
        messageType = "1: Global"
    elseif message.Category == 2 then
        messageType = "2: Guild"
    elseif message.Category == 3 then
        messageType = "3: Say"
    else
        messageType = string.format("%s: Unknown", message.Category)
    end
    print(string.format("[%s] %s (%s > %s): %s\n", message.Category, message.Sender, message.SenderPlayerUId, message.ReceiverPlayerUId, message.Message))
end

-- if in doubt, UObject:GetFullName() to figure out what the heck you are working with.

function utilities.SendMessage(WorldContext, Message, Recipient)
    if PalUtility == nil or not PalUtility:IsValid() then
        PalUtility = utilities.GetPalUtility()
    end

    if type(Recipient) == "string" then
        local recipient = utilities.GetPlayer(Recipient)
        local recipientPlayerState = recipient:GetPalPlayerState()
        if recipient ~= nil then
            PalUtility:SendSystemToPlayerChat(WorldContext, Message, recipient.playerState.PlayerUId)
        else
            print(string.format("Could not send message '%s' to unknown user '%s'", Message, Recipient))
        end
    else
        PalUtility:SendSystemToPlayerChat(WorldContext, Message, Recipient.PlayerUId)
    end
end

function utilities.GetPlayer(Id)
    local Players = FindAllOf("PalPlayerController")

    for index, player in pairs(Players) do
        local playerState = player:GetPalPlayerState()
        if playerState ~= nil and playerState:IsValid() then
            -- Numerical, ie. 257
            if tostring(Id) == tostring(playerState.PlayerId) then
                return player
            end
            -- SteamId, ie. 76561198085564783
            if tostring(Id) == tostring(playerState.UniqueId) then
                return player
            end
            -- Unique Id, ie. 9CF2403E -> 2633121854
            if string.lower(Id) == string.lower(string.sub(string.format("%016x", playerState.PlayerUId.A), -8)) or Id == tostring(playerState.PlayerUId.A) then
                return player
            end
            -- Name ie. aytimothy
            if string.lower(Id) == string.lower(playerState.PlayerNamePrivate:ToString()) then
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