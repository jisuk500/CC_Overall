--Inherit from UIElement
local UIElement = dofile("UILib/UIElement.lua")
--make ScrollViewer class
local ScrollViewer = {}
ScrollViewer.__index = ScrollViewer

local mt = {
  __call = function (cls,x_,y_,w_,h_)
    local inst = setmetatable({},cls)
    inst:_init(x_,y_,w_,h_)
    return inst
  end
}
setmetatable(ScrollViewer,mt)

function ScrollViewer:_init(x_,y_,w_,h_)
  mt.__index = UIElement(x_,y_,w_,h_)

  self.scrollBarheight = w_
  self.scrollBarPos = 1
  self.scrollPos = 0
end

function ScrollViewer:wheelEvent(rel_x,rel_y,mouse_wheel)
  --set the scroll position based on them
  self.scrollPos = self.scrollPos + 0
end

function ScrollViewer:render(x_,y_)
  local x_rel = self.x + x_ - 1
  local y_rel = self.y + y_ - 1
  local y_rel_end = y_rel + self.h - 1

  for k,v in pairs(ScrollViewer.children)
    local child_y = v.y - self.scrollPos
    local child_y_end = v.y + v.h - 1 - self.scrollPos
    if (y_rel<=v.y) and (v.y<=y_rel_end) then
      v:render(x_rel,y_rel-self.scrollPos)
    elseif (y_rel<=child_y_end) and (child_y_end<=y_rel_end)
      v:render(x_rel,y_rel-self.scrollPos)
    end
  end

end

return ScrollViewer


