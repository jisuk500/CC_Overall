local SB = dofile("JLib/UILib/SimpleButton.lua")
local UI = dofile("JLib/UILib/UIElement.lua")


local sb1 = SB(1,2,3,4)
local sb2 = SB(5,6,7,8)

for k,v in pairs(sb1) do
  print(k,v)
end

for k,v in pairs(sb2) do
  print(k,v)
end


sb1:addChild(sb2)

sb1:render()