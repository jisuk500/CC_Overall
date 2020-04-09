--make str2hH class

local strHex = {}
strHex.__index = strHex

local mt = {
  __call=function (cls)
    local inst = setmetatable({},cls)
    return inst
  end
}

function strHex:str2hex(str)
  local an = ""
  local tempstr = ''
  for i=1,#str do
    tempstr = string.format("%x",str:byte(i))
    if #tempstr == 1 then
      tempstr = "0"..tempstr
    end
    an = an..tempstr
  end
  return an,tonumber(an,16)
end

function strHex:hex2str(hexstr)
  local orig = ""
  for i=1,#hexstr/2 do

    orig = orig..string.char(tonumber(hexstr:sub(2*i-1,2*i),16))
  end
  return orig
end

return strHex