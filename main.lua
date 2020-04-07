local md5 = dofile("CommonLib/MD5.lua")
local strhex = dofile("CommonLib/strHex.lua")
local AES = dofile("CommonLib/AES.lua")


local st = "1107dd"
print("original pass",st)

local key_str = md5.sum(st)
local key_hex,key = strhex:str2hex(key_str)
print("md5 hashed pass to keys",key_str,key_hex,key)

local plaintext = 'this is AES snc'
print("original msg",plaintext)

local cyphertext = AES.ECB_256(AES.encrypt, key, plaintext)
print("AES256 encrypted",cyphertext)

local cypherHex = strhex:str2hex(cyphertext)
print("to Hex String",cypherHex)

local cyphertextOrig = strhex:hex2str(cypherHex)
print("to original cyphertext",cyphertextOrig)

local newtext = AES.ECB_256(AES.decrypt, key, cyphertextOrig)
print("decrypted original msg",newtext)