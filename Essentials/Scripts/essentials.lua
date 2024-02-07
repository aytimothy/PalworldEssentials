local essentials = {}

local utilities = require("./utilities")
local config = require("./config")

local printChatMessage = function(message)
    local sender = message.Sender:ToString()
    local senderGuid = utilities.GuidToString(message.SenderPlayerUId)
    local recipientGuid = utilities.GuidToString(message.ReceiverPlayerUId)
    local messageType = message.Category
    local message = message.Message:ToString()
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

local commands = {
    list = {
        adminOnly = false,
        run = function(sender, commandArgs)
            local utils = require("./utilities")
            local response = string.format("There are %i players online: ", PlayerCount)
            local first = true
            for k, v in pairs(PlayerList) do
                if first then
                    first = false
                else
                    response = response .. ", "
                end
                response = response .. v
            end
            utils.SendMessage(sender, response)
        end
    },
    msg = require("./commands/message"),
    message = require("./commands/message"),
    tell = require("./commands/message"),
    whisper = require("./commands/message"),
    admin = require("./commands/giveadmin"),
    giveadmin = require("./commands/giveadmin"),
    kick = require("./commands/kick"),
    givepal = require("./commands/givepal"),
    giveitem = require("./commands/giveitem"),
    give = require("./commands/giveitem"),
    kick = require("./commands/kick"),
    tp = require("./commands/tp"),
    give = require("./commands/giveitem"),
    box = require("./commands/box"),
    ping = require("./commands/ping"),
    pong = require("./commands/pong"),
    whois = require("./commands/whois"),
    help = {
        adminOnly = false,
        run = function(sender, message, commandArgs)
            local utils = require("./utilities")
            utils.SendMessage(sender, "Avilable commands: /help")
        end
    },
    default = {
        adminOnly = false,
        run = function(sender, message, commandArgs)
            local utils = require("./utilities")
            print(string.format("Unknown command '%s'", commandArgs[0]))
            utils.SendMessage(sender, string.format("Unknown command '%s'. Type /help for help.", commandArgs[0]))
        end
    },
    -- Don't do anything on a built-in command
    Shutdown = require("./commands/ignore"),
    DoExit = require("./commands/ignore"),
    Broadcast = require("./command/ignore"),
    TeleportToPlayer = require("./command/ignore"),
    TeleportToMe = require("./command/ignore"),
    ShowPlayers = require("./command/ignore"),
    Info = require("./command/ignore"),
    Save = require("./command/ignore")
}

local handleChatMessage = function(sender, message)
    local senderId = sender.PlayerId
    local messageText = message.Message:ToString()
    local utilities = require("./utilities")

    -- Handle commands
    if string.match(messageText, "^/") then
        local commandString = string.sub(messageText, 2)
        local commandArgs = utilities.SplitCommandIntoArgs(commandString)
        local mainCommand = string.lower(commandArgs[0])
        if commands[mainCommand] then
            local isUserAdmin = utilities.IsPlayerAdmin(sender)
            if isUserAdmin or not commands[mainCommand].adminOnly then
                commands[mainCommand].run(sender, message, commandArgs)
            else
                local userName = message.Sender:ToString()
                local userId = utilities.GuidToString(message.SenderPlayerUId)
                utilities.SendMessage(sender, "You do not have access to this command.")
                print(string.format("Denied access to command '%s' to %s (%s)", mainCommand, userName, userId))
            end
        else
            commands["default"].run(sender, message, commandArgs)
        end
    end
end

PlayerList = {}
PlayerCount = 0

function essentials.Main()
    local utilities = require("./utilities")

    -- Event on message received
    RegisterHook("/Script/Pal.PalPlayerState:EnterChat_Receive", function(Context, ChatMessage)
        -- printChatMessage(ChatMessage:get())
        handleChatMessage(Context:get(), ChatMessage:get())
    end)

    -- Event on player object initialized
    RegisterHook("/Script/Pal.PalPlayerCharacter:OnCompleteInitializeParameter", function(Context, Character)
        local player = Context:get()
        local playerState = player.PlayerState
        local playerId = playerState.PlayerId
        local playerName = playerState.PlayerNamePrivate:ToString()

        if config.BroadcastUserConnection == true then
            local playerJoinMessage = string.format("%s has joined the game.", playerName)
            utilities.SendBroadcast(Context:get(), playerJoinMessage)
        end

        PlayerList[playerId] = playerName
        PlayerCount = PlayerCount + 1
    end)

    -- Event on player object destroyed
    RegisterHook("/Script/Pal.PalPlayerController:OnDestroyPawn", function(Context, Actor)
        local player = Context:get()
        local playerState = player.PlayerState
        local playerId = playerState.PlayerId
        local playerName = playerState.PlayerNamePrivate:ToString()

        if config.BroadcastUserConnection == true then 
            local playerLeaveMessage = string.format("%s has left the game.", playerName)
            utilities.SendBroadcast(Context:get(), playerLeaveMessage)
        end

        PlayerList[playerId] = nil
        PlayerCount = PlayerCount - 1
    end)
end

return essentials