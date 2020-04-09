--make lines struct definition
local Lines = {}
Lines.__index = Lines

local mt = {
    __call = function(cls,pos_,text_,space_,includeReturn_)
      local inst = setmetatable({},cls)
      inst:_init(pos_,text_,space_,includeReturn_)
      return inst
    end
}

setmetatable(Lines,mt)

--initializer
function Lines:_init(pos_,text_,space_,includeReturn_)
  self.headPos = pos_ or 1
  self.text = text_ or ""
  self.space = space_ or 0
  self.includeReturn = includeReturn_ or false
end

--get real line string rendering
function Lines:getLineText()
  local str = ""

  for i=1,self.space do
    str = str.." "
  end
  return str..self.text
end

--get realPos and realcursorPos from data
function Lines:getRealPos(relPos)
  local cursorPos
  local len = self.text:len()
  if(self.includeReturn == true) then
    len = len + 1
  end

  if relPos <= self.space then
    cursorPos = self.space+1
    return self.headPos, cursorPos
  elseif self.space+len < relPos then
    cursorPos = self.space + len
    return self.headPos+len-1, cursorPos
  else
    cursorPos = relPos
    return relPos - self.space + self.headPos - 1, cursorPos
  end
end

return Lines