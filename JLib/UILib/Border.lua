--Inheritance from UIElement
local UIElement = dofile("JLib/UILib/UIElement.lua")

--Border class Definition
local Border = {}
Border.__index = Border

local mt = {
  __call = function(cls,x_,y_,w_,h_,term_,borderC_)
    local inst = setmetatable({},cls)
    inst:_init(x_,y_,w_,h_,term_,borderC_)
    return inst
  end
}
setmetatable(Border,mt)

--Border Class initialization
function Border:_init(x_,y_,w_,h_,term_,borderC_)
  mt.__index = UIElement(x_,y_,w_,h_,term_)

  self.borderT = 1
  self.borderC = borderC_ or "blue"
  self.children = nil
end

--Border Rendering
function Border:render(x_,y_)
  local x_rel = x_ or 0
  local y_rel = y_ or 0
  self.xabs = self.x + x_rel - 1
  self.yabs = self.y + y_rel - 1

  print("rendering Border")
  --render the children of border
  for i,v in ipairs(self.children) do
    v:render(self.xabs,self.yabs)
  end
  return true
end

function Border:clickEvent(mouse_x,mouse_y,mouse_action)
  return true
end


return Border
