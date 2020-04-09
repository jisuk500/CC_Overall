
--UIElement class definition
local UIElement = {}
UIElement.__index = UIElement

local mt = {
  __call = function(cls,x_,y_,w_,h_,term_)
    local inst = setmetatable({},cls)
    inst:_init(x_,y_,w_,h_,term_)
    return inst
  end
}

setmetatable(UIElement,mt)

--UIElement initializer
function UIElement:_init(x_,y_,w_,h_,term_)
  -- relative pos
  self.x = x_ or 1
  self.y = y_ or 1
  -- absolute pos
  self.xabs = self.x
  self.yabs = self.y

  self.w = w_ or 1
  self.h = h_ or 1
  self.children = {}
  self.parent = nil

  self.term = term_  or term.current()
end

--add child UIElement to this UIElement
function UIElement:addChild(UI_child)
  table.insert(self.children,UI_child)
  UI_child.parent = self
end

--remove child UIElement at this UIElement
function UIElement:removeChild(UI_child)
  table.remove(self.children, UI_child)
  UI_child.parent = nil
end

--set Parent UIElement of this UIElement
function UIElement:setParent(UI_parent)
  self.parent = UI_parent
  table.insert(UI_parent.children, self)
end

--remove Parent UIElement of this UIElement
function UIElement:removeParent()
  if(self.parent ~= nil) then
    table.remove(self.parent.children,self)
    self.parent = nil
  end
end

--Check whether the mouse point is over it
function UIElement:checkMouseOver(mouse_x,mouse_y)

  local max_x = self.x + self.w - 1
  local max_y = self.y + self.h - 1
  
  local asdf = false
  
  if (self.x<=mouse_x) and (mouse_x<=max_x) then
    if (self.y<=mouse_y) and (mouse_y<=max_y) then
      self:mouseOverEvent(mouse_x-self.x+1,mouse_y-self.y+1,mouse_action)
	  return true
    end
  end
  
  return false
  
end

--MouserOverEvent mustOverride
function UIElement:mouseOverEvent(rel_x,rel_y,mouse_action)

end

--triggering click event with absolute positions
function UIElement:click(mouse_x,mouse_y,mouse_action)
  self:clickEvent(mouse_x-self.x+1,mouse_y-self.y+1,mouse_action)
end


--Basic ClickEvent function with relative position parameters
--must override
function UIElement:clickEvent(rel_x,rel_y,mouse_action)
  return -1
end

--triggering mouse wheel event with absolute positions
function UIElement:wheel(mouse_x,mouse_y,mouse_wheel)
  self:wheelEvent(mouse_x-self.x+1,mouse_y-self.y+1,mouse_wheel)
end

--Basic mouseWheel event function with relative position parameters
-- must override
function UIElement:wheelEvent(rel_x,rel_y,mouse_wheel)
  return -1
end 

--Basic render function with relative position parameters
--must override
function UIElement:render(x_,y_)
  local x_rel = x_ or 1
  local y_rel = y_ or 1
  self.xabs = self.x + x_rel - 1
  self.yabs = self.y + y_rel - 1
  self:renderContent()

  -- render the childrens
  if self.children ~= nil then
    for i=1,#self.children do
      self.children[i]:render(self.xabs,self.yabs)
    end
  end
  return nil
end

-- Basic render function on each UI Elements
-- must overrided
function UIElement:renderContent()
  print("UIElement rendered!")
end

return UIElement
