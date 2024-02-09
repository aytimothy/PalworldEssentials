local expall = {
    adminOnly = false,
    run = function(sender, rawMessage, commandArgs)
        print("expall.lua:4")
        local utilities = require("./../utilities")
        local PalUtility = utilities.GetPalUtility()
        local cheatManager = PalUtility:GetPalCheatManager(sender)
        if cheatManager ~= nil then
            cheatManager:AddExpForALLPlayer(100000)
            utilities.SendBroadcast("Gave everyone 100,000 EXP...")
        else
            utilities.SendBroadcast("Failed to get a CheatManager...")
        end

        --[[
        local palPlayerController = utilities.GetPlayer(sender.PlayerId)
        palPlayerController:Debug_AddExpForALLPlayer_ToServer(10000)
        ]]

        --[[ 
        local Players = FindAllOf("PalPlayerController")
        for index, player in pairs(Players) do
            local playerState = player:GetPalPlayerState()
            if playerState ~= nil and playerState:IsValid() then
                player:Debug_AddPlayerExp_ToServer(10000)
                player:Debug_AddPartyExp_ToServer(10000)
            end
        end 
        ]]
    end
}

return expall