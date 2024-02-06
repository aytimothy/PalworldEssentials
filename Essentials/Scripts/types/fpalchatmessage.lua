-- Define the FPalChatMessage class
local FPalChatMessage = {
    __index = FPalChatMessage
}

-- Constructor for the FPalChatMessage class
function FPalChatMessage.new(Category, Sender, SenderPlayerUId, Message, ReceiverPlayerUId)
    local self = setmetatable({}, FPalChatMessage)
    self.Category = Category or 0
    self.Sender = FText(Sender):ToString() or FText("Default"):ToString()
    self.SenderPlayerUId = SenderPlayerUId or FGuid.new(0, 0, 0, 0)
    self.Message = FText(Message):ToString() or FText("Default"):ToString()
    self.ReceiverPlayerUId = ReceiverPlayerUId or FGuid.new(0, 0, 0, 0)
    return self
end

return FPalChatMessage