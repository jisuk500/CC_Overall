--inherit from UIElement
local UIElement = dofile("UILib/UIElement.lua")

--make SimpleButton Class
local SimpleButton = {}
SimpleButton.__index = SimpleButton

local mt = {
  __call = function(cls,x_,y_,w_,h_)
    local inst = setmetatable({},cls)
    inst:_init(x_,y_,w_,h_)
    return inst
  end
}
setmetatable(SimpleButton,mt)

--SimpleButton Initialize method
function SimpleButton:_init(x_,y_,w_,h_)
  mt.__index = UIElement(x_,y_,w_,h_)

  self.text = T or ""
  self.bg = "red"
  self.fg = "blue"
  self.isToggle = false
  self.Toggled = false
end

--simpletextbox rendering function
function SimpleButton:render(x_,y_)
  print("rendering simpletextbox")
end

--simpletextbox click event function
function SimpleButton:clickEvent(rel_x,rel_y,mouse_action)
  print("ClickEvent simpletextbox")
end

return SimpleButton