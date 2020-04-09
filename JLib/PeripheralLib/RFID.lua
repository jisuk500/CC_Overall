--make RFID class
local RFID = {}
RFID.__index = RFID

local mt = {
  __call = function(cls,side)
    --get periphral at side
    local inst = setmetatable({},cls)
    inst:_init(side)
    return inst
  end
}
setmetatable(RFID,mt)

--RFID _initialize method
function RFID:_init(side)
  --get periphral from side
  self.reader = {}
  self.UUID = {}
end

function RFID:UUID2Str(UUID_)
  local UUID = UUID_ or self.UUID
  local str = UUID[1]
  for i=2,7 do
    str = str*4
    str = str + UUID[i]
  end

  return str
end

return RFID