local t = {}

function t:TableCopy(t,t2_)
  local t2 = t2_ or {}
  for k,v in pairs(t) do 
    if type(v) == "table" then 
      t2[k] = self:TableCopy(v) 
    else 
      t2[k] = v 
    end 
  end 
  return t2 
end

return t
