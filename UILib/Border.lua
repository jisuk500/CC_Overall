--Inheritance from UIElement
local UIElement = dofile("UILib/UIElement.lua")

--Border class Definition
local Border = {}
Border.__index = Border

local mt = {
  __call = function(cls,x_,y_,w_,h_,borderT_,borderC_)
    local inst = setmetatable({},cls)
    inst:_init(x_,y_,w_,h_,borderT_,borderC_)
    return inst
  end
}
setmetatable(Border,mt)

--Border Class initialization
function Border:_init(x_,y_,w_,h_,borderT_,borderC_)
  mt.__index = UIElement(x_,y_,w_,h_)

  self.borderT = borderT_ or 1
  self.borderC = borderC_ or "blue"
  self.children = nil
end

--Border Rendering
function Border:render(x_,y_)
  local x_rel = self.x + x_ - 1
  local y_rel = self.y + y_ - 1

  print("rendering Border")
  --render the children of border
  for i,v in ipairs(self.children) do
    v:render(x_,y_)
  end
  return true
end

function Border:clickEvent(mouse_x,mouse_y,mouse_action)
  return true
end


return Border
