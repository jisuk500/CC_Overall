--inherit from UIElement
local UIElement = dofile("JLib/UILib/UIElement.lua")
local TableCopy = dofile("JLib/CommonLib/TableCopy.lua")

--make SimpleButton Class
local SimpleButton = {}
SimpleButton.__index = SimpleButton

local mt = {
  __call = function(cls,x_,y_,w_,h_,term_)
    local inst = setmetatable({},cls)
    inst:_init(x_,y_,w_,h_)
    return inst
  end
}
setmetatable(SimpleButton,mt)

--SimpleButton Initialize method
function SimpleButton:_init(x_,y_,w_,h_,term_)
  local base = UIElement(x_,y_,w_,h_,term_)
  mt.__index = getmetatable(base)
  TableCopy:TableCopy(base,self)

  self.text = T or ""
  self.bg = "red"
  self.fg = "blue"
  self.isMouseOver = false
  self.bg_over = self.bg
  self.fg_over = self.fg
  self.isTogglable = false
  self.Toggled = false
  self.bg_toggle = "yellow"
  self.fg_toggle = "black"
  
end

--simpletextbox rendering function
function SimpleButton:renderContent()
  print("rendering simpletextbox")
end

function SimpleButton:mouseOverEvent(rel_x,rel_y,mouse_action)

end

--simpletextbox click event function
function SimpleButton:clickEvent(rel_x,rel_y,mouse_action)
  print("ClickEvent simpletextbox")
end

return SimpleButton