--[[
    Inventory Container data is:
    <Player ID>.sav > SaveData.inventoryInfo.CommonContainerId or SaveData.inventoryInfo.EssentialContainerId
    Container Type: UPalWorldPlayerSaveGame, FPalWorldPlayerSaveData
    Type: FPalWorldPlayerSaveData.FPalPlayerDataInventoryInfo.CommonContainerId or FPalWorldPlayerSaveData.FPalPlayerDataInventoryInfo.EssentialContainerId
    Reference: ???.SaveData.inventoryInfo.CommonContainerId.ID or ???.SaveData.inventoryInfo.EssentialContainerId.ID

    The actual inventory (container) data is:
    level.sav > WorldSaveData.CharacterContainerSaveData[<Container ID>]
    Container Type: UPalWorldSaveGame, FPalWorldSaveData
    Type: FPalCharacterContainerSaveData
    Reference: UPalSaveGameManager.LoadedWorldSaveData.worldSaveData.CharacterContainerSaveData[<Container ID>]

]]

-- Adds an item to the user's inventory.
local giveitem = {
    adminOnly = true,
    run = function(sender, rawMessage, commandArgs)
        print("Not Implemented Yet...")
    end
}

function giveitem.getPlayerInventoryId(user)

end

function giveitem.getPlayerInventory(inventoryId)

end

function giveitem.addToInventory(inventory, amount, itemId)

end

return giveitem