myholeinthewall = {}
dofile(minetest.get_modpath("myholeinthewall").."/nodes.lua")
dofile(minetest.get_modpath("myholeinthewall").."/machine.lua")
dofile(minetest.get_modpath("myholeinthewall").."/register.lua")





if minetest.get_modpath("myores") then
	dofile(minetest.get_modpath("myholeinthewall").."/myores.lua")
end

if minetest.get_modpath("mywhiteblock") then
	dofile(minetest.get_modpath("myholeinthewall").."/mywhiteblock.lua")
end

