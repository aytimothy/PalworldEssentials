-- Define the FPalChatMessage class
local FPalChatMessage = {
    __index = FPalChatMessage
}

-- Constructor for the FPalChatMessage class
function FPalChatMessage.new(Category, Sender, SenderPlayerUId, Message, ReceiverPlayerUId)
    local self = setmetatable({}, FPalChatMessage)
    self.Category = Category or 0
    self.Sender = tostring(Sender) or "SYSTEM"
    self.SenderPlayerUId = SenderPlayerUId or 1
    self.Message = tostring(Message) or "Default"
    self.ReceiverPlayerUId = ReceiverPlayerUId or 0
    return self
end

return FPalChatMessage