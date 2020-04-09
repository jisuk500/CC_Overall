local md5 = require 'md5'

local md5_as_data  = md5.sum(message)       -- returns raw bytes
local md5_as_hex   = md5.sumhexa(message)   -- returns a hex string
local md5_as_hex2  = md5.tohex(md5_as_data) -- returns the same string as md5_as_hex