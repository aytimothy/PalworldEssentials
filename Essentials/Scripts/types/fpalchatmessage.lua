-- Define the FPalChatMessage class
local FPalChatMessage = {
    __index = FPalChatMessage
}

-- Constructor for the FPalChatMessage class
function FPalChatMessage.new(Category, Sender, SenderPlayerUId, Message, ReceiverPlayerUId)
    local self = setmetatable({}, FPalChatMessage)
    self.Category = Category or 0
    self.Sender = tostring(Sender) or "Default"
    self.SenderPlayerUId = SenderPlayerUId or FGuid.new(0, 0, 0, 0)
    self.Message = tostring(Message) or "Default"
    self.ReceiverPlayerUId = ReceiverPlayerUId or FGuid.new(0, 0, 0, 0)
    return self
end

return FPalChatMessage