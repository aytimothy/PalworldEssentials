-- Define the FGuid class
local FGuid = {
    __index = FGuid
}

-- Constructor for the FGuid class
function FGuid.new(A, B, C, D)
    local self = setmetatable({}, FGuid)
    self.A = A or 0
    self.B = B or 0
    self.C = C or 0
    self.D = D or 0
    return self
end

return FGuid