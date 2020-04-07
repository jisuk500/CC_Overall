--Inherit from UIElement
local UIElement = dofile("UILib/UIElement.lua")
--get TextBox libs
local VisualLine = dofile("UILib/TextBoxLib/LinesClass.lua")

--make TextBox class Definition
local TextBox = {}
TextBox.__index = TextBox

local mt = {
  __call = function(cls,x_,y_,w_,h_,T)
    local inst = setmetatable({},cls)
    inst:_init(x_,y_,w_,h_,T)
    return inst
  end
}

setmetatable(TextBox,mt)

--TextBox initialization Method
function TextBox:_init(x_,y_,w_,h_,T)
  mt.__index = UIElement(x_,y_,w_,h_)

  self.text = T or ""
  self.bg = "red"
  self.fg = "blue"
  self.vertiMode = "t"
  self.horiMode = "l"
  self.revisable = false
  self.lines = {}
  self.linesSpace = 0
end

--split original lines to visualizing lines
function TextBox:_splitToLines()

  self.lines = {}
  local tempstr = self.text
  local currentPos = 1
  local LinesIndex = 1
  local isLastReturn = false
  local isVirtualReturn = false
  local maxWidth = self.w

  while true do
    local returnIndex = string.find(tempstr,"\n")
    if(returnIndex == nil) then
      if(tempstr:len() >= 1) then
        --vitrual returnIndex to cope with texts not end with return
        returnIndex = tempstr:len()+1
        isVirtualReturn = true     
      elseif(isLastReturn == true)and(isVirtualReturn == false)then
        self.lines[LinesIndex] = VisualLine(currentPos-1,"",0,true)
       break
      else
        break
      end
      
    end

    --if next return is larger than maxWidth
    if ((maxWidth+1)<returnIndex) then
      self.lines[LinesIndex] = VisualLine(currentPos,tempstr:sub(1,maxWidth),0,false)
      currentPos = currentPos + maxWidth
      tempstr = tempstr:sub(maxWidth+1,tempstr:len())
      isLastReturn = false
    --if next return is smaller than maxWidth
    elseif ((maxWidth+1)>=returnIndex) then
      local includeReturn = true
      --check if isVirtualReturn is true then no end returns
      if (isVirtualReturn == true) then
        includeReturn = false
      end
      --if returnIndex is 1
      if returnIndex == 1 then
        self.lines[LinesIndex] = VisualLine(currentPos,"",0,includeReturn)
      else
        self.lines[LinesIndex] = VisualLine(currentPos,tempstr:sub(1,returnIndex-1), 0,includeReturn)
      end

      currentPos = currentPos + returnIndex
      tempstr = tempstr:sub(returnIndex+1,tempstr:len())
      isLastReturn = true
    end

    self:_getHoriSpace(self.lines[LinesIndex],maxWidth,self.horiMode)
    LinesIndex = LinesIndex+1
  end
end

--get each lines horizintal space values
function TextBox:_getHoriSpace(visualLine_,maxWidth_,horiMode_)
  local len = visualLine_.text:len()

  if(horiMode_ == "l") then
    visualLine_.space = 0
  elseif(horiMode_ == "r") then
    visualLine_.space = maxWidth_ - len
  elseif(horiMode_ == "c") then
    visualLine_.space = ((maxWidth_ - len)-((maxWidth_-len)%2))/2
  else
   visualLine_.space = 0 
  end

end

--Textbox render function
function TextBox:render(x_,y_)
  print("rendering textbox")
end

--Textbox clickEvent
function TextBox:clickEvent(rel_x,rel_y,mouse_action)
  print("clickEvent textbox")
  print(rel_x,rel_y,mouse_action)
  local pos,relpos = self.lines[rel_y]:getRealPos(rel_x)
  print(pos)
  print(self.text:sub(pos,pos))
  print(rel_y,relpos)
end

return TextBox