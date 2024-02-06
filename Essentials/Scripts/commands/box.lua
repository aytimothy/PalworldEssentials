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

-- Swaps your Palbox with another container so that (hopefully) infinite Pal space
local box = {
    adminOnly = false,
    run = function(sender, rawMessage, commandArgs)
        print("Not Implemented Yet...")
    end
}

function box.getPalboxes(player)

end

function box.switchToPalbox(player, palboxId)

end

return box