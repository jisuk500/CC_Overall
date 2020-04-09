local SB = dofile("JLib/UILib/SimpleButton.lua")
local UI = dofile("JLib/UILib/UIElement.lua")

local m = peripheral.wrap("left")

local sb1 = SB(5,8,15,4,m)
sb1.text = {"123123","  hey mvikdk"," good jisuk"}
sb1.bg = colors.blue

print(m)
print(sb1.term)

function clc()
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1,1)
end

local UIs = {}
UIs[1] = sb1

while true do 
    --clc()
    sb1:render()
    local a,b,c,d,e = os.pullEvent()
    print(a,b,c,d,e)
    if a == "mouse_click" then
        for i,v in ipairs(UIs) do
            local re = v:checkMouseOver(c,d)
            if re == true then
                v:click(1,1)
            end
        end
    end
end
