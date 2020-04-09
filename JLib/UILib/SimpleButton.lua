--inherit from UIElement
local UIElement = dofile("JLib/UILib/UIElement.lua")
local TableCopy = dofile("JLib/CommonLib/TableCopy.lua")

--make SimpleButton Class
local SimpleButton = {}
SimpleButton.__index = SimpleButton

local mt = {
  __call = function(cls,x_,y_,w_,h_,term_)
    local inst = setmetatable({},cls)
    inst:_init(x_,y_,w_,h_,term_)
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
  self.bg = colors.red
  self.fg = colors.cyan
  self.isMouseOver = false
  self.bg_over = self.bg
  self.fg_over = self.fg
  self.isTogglable = false
  self.Toggled = false
  self.bg_toggle = colors.yellow
  self.fg_toggle = colors.black
  
end

--simpletextbox rendering function
function SimpleButton:renderContent()
  local bg = self.bg
  local fg = self.fg
  
  if self.isMouseOver == true then
      bg = self.bg_over
      fg = self.fg_over
  elseif self.Toggled == true then
      bg = self.bg_toggle
      fg = self.fg_toggle
  end
  
  term.redirect(self.term)
  self.term.setBackgroundColor(bg)
  self.term.setTextColor(fg)
  
  paintutils.drawFilledBox(self.xabs, self.yabs, self.xabs+self.w-1, self.yabs+self.h-1,bg)
  
  if #(self.text) >= 1 then
      for i=1,#(self.text) do
          self.term.setCursorPos(self.xabs, self.yabs+i-1)
          self.term.write(self.text[i])
      end
  end
  
end

function SimpleButton:mouseOverEvent(rel_x,rel_y,mouse_action)
	
end

--simpletextbox click event function
function SimpleButton:clickEvent(rel_x,rel_y,mouse_action)
  self.Toggled = not self.Toggled
end

return SimpleButton
