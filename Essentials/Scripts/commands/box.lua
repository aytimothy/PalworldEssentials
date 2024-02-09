--[[
    Pal Box Container data is:
    <Player ID>.sav > SaveData.PalStorageContainerId.ID
    Container: UPalWorldPlayerSaveGame, FPalWorldPlayerSaveData
    Type: FPalBaseCampItemContainerInfo.FPalContainerid
    Reference: ???.SaveData.PalStorageContainerId.ID

    The actual Pal Box contents (container) data is:
    level.sav > 
    Container: UPalWorldSaveGame, FPalWorldSaveData
    Type: FPalPlayerDataPalStorageSlotSaveData
    Reference: UPalSaveGameManager.LoadedWorldSaveData.worldSaveData.???
    // Incomplete type? Doesn't have all of what we need...
    // FPalIndividualCharacterSaveParameter is all character save data (Pals, NPCs and players alike)
    // There might actually be one more step after; the player contains a container ID. Each container has a bunch of slots. Then the slots are saved elsewhere.
]]

--[[
    BP_PalPlayerState_C (PalPlayerState) sender
    sender.OtomoData.OtomoCharacterContainerId.ID is the ID of the container containing the player's Party members

    My Direhowl: 
    a7666392-408c-c65c-1df9-a9904f9a5af3 = SlotId
    f218effe-4880-eadc-2eb3-32a653410f0e = Guild (probably player's guid; irrelevant)
    1fd5ebb4-40d4-3c6e-87b2-eeb8f61f6330 = ContainerID
    9cf2403e-0000-0000-0000-000000000000 = PlayerID
]]

--[[
    Maybe UPalCharacterContainerManager:TryGetContainer(ContainerId, Container)
]]

function printUserInfo(sender)
    local utilities = require("./../utilities")
    local playerName = sender.PlayerNamePrivate:ToString()
    local palboxGuid = sender.PalStorage.TargetContainer.ID.ID
    utilities.SendBroadcast(sender, string.format("%s's PalStorage Container ID is: %s", playerName, utilities.GuidToString(palboxGuid)))
end

function doBoxSwap(sender, newContainerId)
    local utilities = require("./../utilities")
    local PalUtility = utilities.GetPalUtility()
    local PalCharacterContainerManager = PalUtility:GetCharacterContainerManager(sender)
end

-- Swaps your Palbox with another container so that (hopefully) infinite Pal space
local box = {
    adminOnly = false,
    run = function(sender, rawMessage, commandArgs)
        if commandArgs[1] == nil then
            printUserInfo(sender)
        else
            doBoxSwap(sender, commandArgs[1])
        end
    end
}

return box