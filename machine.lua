local material = {}
local shape = {}
local make_ok = {}
local anzahl = {}
function minetest.get_mydrillpress_formspec(pos)
    local spos = pos.x .. "," .. pos.y .. "," ..pos.z
    local formspec =
        "size[9,8]"..
		"background[-0.15,-0.25;9.5,8;myholeinthewall_background.png]"..
        "list[nodemeta:".. spos .. ";main;1.5,0.5;6,2;]"..
        "list[current_player;main;0.5,3;8,4;]"
    return formspec
end

local function has_mydrillpress_privilege(meta, player)
    if player:get_player_name() ~= meta:get_string("owner") then
        return false
    end
    return true
end
minetest.register_node("myholeinthewall:machine", {
	description = "Hole Machine",
	inventory_image = "myholeinthewall_inventory_image.png",
	tiles = {
		"myholeinthewall_machine_top.png",
		"myholeinthewall_machine_bottom.png",
		"myholeinthewall_machine_side.png",
		"myholeinthewall_machine_side.png",
		"myholeinthewall_machine_side.png",
		"myholeinthewall_machine_front.png"
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.375, -0.375, 0.375, 0.375, 0.375}, 
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5}, 
			{0.1875, -0.5, -0.375, 0.375, -0.375, -0.1875}, 
			{0.1875, -0.5, 0.1875, 0.375, -0.375, 0.375}, 
			{-0.375, -0.5, -0.375, -0.1875, -0.375, -0.1875},
			{-0.375, -0.5, 0.1875, -0.1875, -0.375, 0.375}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
		}
	},
    on_place = function(itemstack, placer, pointed_thing)
        local pos = pointed_thing.above
        if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
            minetest.chat_send_player( placer:get_player_name(), "Not enough space to place this!" )
            return
        end
        return minetest.item_place(itemstack, placer, pointed_thing)
    end,

	after_destruct = function(pos, oldnode)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "air"})
	end,

	after_place_node = function(pos, placer)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "myholeinthewall:machine_top", param2=minetest.dir_to_facedir(placer:get_look_dir())});
	

        local meta = minetest.get_meta(pos)
        meta:set_string("owner", placer:get_player_name() or "")
        meta:set_string("infotext", "Drill Press (owned by "..
                meta:get_string("owner")..")")
    end,
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", "Drill Press")
        meta:set_string("owner", "")
        local inv = meta:get_inventory()
        inv:set_size("main", 9*6)
    end,

    can_dig = function(pos,player)

	local meta = minetest.env:get_meta({x=pos.x,y=pos.y+1,z=pos.z});
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") then
		return false
	elseif not inv:is_empty("res") then
		return false
	end
	


        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()

        return inv:is_empty("main") and has_mydrillpress_privilege(meta, player)
	


    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        local meta = minetest.get_meta(pos)
        if not has_mydrillpress_privilege(meta, player) then
            minetest.log("action", player:get_player_name()..
                    " tried to access a drill press belonging to "..
                    meta:get_string("owner").." at "..
                    minetest.pos_to_string(pos))
            return 0
        end
        return count
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta = minetest.get_meta(pos)
        if not has_mydrillpress_privilege(meta, player) then
            minetest.log("action", player:get_player_name()..
                    " tried to access a drill press belonging to "..
                    meta:get_string("owner").." at "..
                    minetest.pos_to_string(pos))
            return 0
        end
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta = minetest.get_meta(pos)
        if not has_mydrillpress_privilege(meta, player) then
            minetest.log("action", player:get_player_name()..
                    " tried to access a drill press belonging to "..
                    meta:get_string("owner").." at "..
                    minetest.pos_to_string(pos))
            return 0
        end
        return stack:get_count()
    end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        minetest.log("action", player:get_player_name()..
                " moves stuff into drill press at "..minetest.pos_to_string(pos))
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        minetest.log("action", player:get_player_name()..
                " moves stuff into drill press at "..minetest.pos_to_string(pos))
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        minetest.log("action", player:get_player_name()..
                " takes stuff from drill press at "..minetest.pos_to_string(pos))
    end,
    on_rightclick = function(pos, node, clicker)
        local meta = minetest.get_meta(pos)
        if has_mydrillpress_privilege(meta, clicker) then
            minetest.show_formspec(
                clicker:get_player_name(),
                "myholeinthewall:machine",
                minetest.get_mydrillpress_formspec(pos)
            )
        end
    end,







})


minetest.register_node("myholeinthewall:machine_top", {
	description = "Hole Machine",
	tiles = {
		"myholeinthewall_machinetop_top.png",
		"myholeinthewall_machinetop_bottom.png^[transformR180",
		"myholeinthewall_machinetop_rside.png",
		"myholeinthewall_machinetop_lside.png",
		"myholeinthewall_machinetop_back.png",
		"myholeinthewall_machinetop_front.png"
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "myholeinthewall:machine",
	groups = {cracky=2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, 0.0625, -0.125, 0.1875, 0.5, 0.3125}, 
			{-0.1875, 0.125, -0.1875, 0.1875, 0.4375, 0.375}, 
			{-0.1875, -0.5, 0.375, -0.0625, 0.3125, 0.5}, 
			{0.0625, -0.5, 0.375, 0.1875, 0.3125, 0.5}, 
			{-0.0625, -0.25, -0.0625, 0, 0.5, 0}, 
			{-0.1875, 0.3125, 0.375, 0.1875, 0.375, 0.4375}, 
			{0.1875, 0.1875, -0.0625, 0.25, 0.375, 0.125}, 
			{0.1875, 0.25, -0.5, 0.25, 0.3125, 0}, 
		}
	},

	after_destruct = function(pos, oldnode)
		minetest.set_node({x = pos.x, y = pos.y - 1, z = pos.z},{name = "air"})
	end,


can_dig = function(pos,player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") then
		return false
	elseif not inv:is_empty("res") then
		return false
	end
    
        local meta = minetest.get_meta({x=pos.x,y=pos.y-1,z=pos.z});
        local inv = meta:get_inventory()
        return inv:is_empty("main") and has_mydrillpress_privilege(meta, player)
    
end,

on_construct = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", "invsize[8,9;]"..
		"background[-0.15,-0.25;8.40,9.75;myholeinthewall_background.png]"..
		"list[current_name;ingot;5.5,1;1,1;]"..
		"list[current_name;res;5.5,3;1,1;]"..
		"label[5.5,0.5;Input:]"..
		"label[5.5,2.5;Output:]"..
		"label[0,0;Choose Hole:]"..
--		Column 1
		"image_button[0.5,1;1,1;myholeinthewall_mach1.png;diamond; ]"..
		"image_button[0.5,2;1,1;myholeinthewall_mach2.png;diamondr; ]"..
		"image_button[0.5,3;1,1;myholeinthewall_mach3.png;x; ]"..
--		Column 2
		"image_button[1.5,1;1,1;myholeinthewall_mach7.png;diamondh; ]"..
		"image_button[1.5,2;1,1;myholeinthewall_mach8.png;diamondrh; ]"..
		"image_button[1.5,3;1,1;myholeinthewall_mach9.png;xh; ]"..
--      Column 3
		"image_button[2.5,1;1,1;myholeinthewall_mach4.png;cross; ]"..
		"image_button[2.5,2;1,1;myholeinthewall_mach5.png;crossi; ]"..
		"image_button[2.5,3;1,1;myholeinthewall_mach6.png;o; ]"..
--		Column 4
		"image_button[3.5,1;1,1;myholeinthewall_mach10.png;crossh; ]"..
		"image_button[3.5,2;1,1;myholeinthewall_mach11.png;crossih; ]"..
		"image_button[3.5,3;1,1;myholeinthewall_mach12.png;oh; ]"..
		"list[current_player;main;0,5;8,4;]")
	meta:set_string("infotext", "Drill Press")
	local inv = meta:get_inventory()
	inv:set_size("ingot", 1)
	inv:set_size("res", 1)
end,

on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

if fields["diamond"] 
or fields["diamondr"] 
or fields["x"] 
or fields["cross"]
or fields["crossi"]
or fields["o"]
or fields["diamondh"] 
or fields["diamondrh"] 
or fields["xh"] 
or fields["crossh"]
or fields["crossih"]
or fields["oh"]
then

	if fields["diamond"] then
		make_ok = "0"
		anzahl = "1"
		shape = "myholeinthewall:diamond_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["diamondr"] then
		make_ok = "0"
		anzahl = "1"
		shape = "myholeinthewall:diamond_rough_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["x"] then
		make_ok = "0"
		anzahl = "1"
		shape = "myholeinthewall:x_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["cross"] then
		make_ok = "0"
		anzahl = "1"
		shape = "myholeinthewall:cross_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["crossi"] then
		make_ok = "0"
		anzahl = "1"
		shape = "myholeinthewall:cross_iron_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["o"] then
		make_ok = "0"
		anzahl = "1"
		shape = "myholeinthewall:o_"
		if inv:is_empty("ingot") then
			return
		end
	end

----------------------------------------------------------
if fields["diamondh"] then
		make_ok = "0"
		anzahl = "2"
		shape = "myholeinthewall:diamond_half_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["diamondrh"] then
		make_ok = "0"
		anzahl = "2"
		shape = "myholeinthewall:diamond_rough_half_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["xh"] then
		make_ok = "0"
		anzahl = "1"
		shape = "myholeinthewall:x_half_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["crossh"] then
		make_ok = "0"
		anzahl = "2"
		shape = "myholeinthewall:cross_half_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["crossih"] then
		make_ok = "0"
		anzahl = "2"
		shape = "myholeinthewall:cross_iron_half_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["oh"] then
		make_ok = "0"
		anzahl = "2"
		shape = "myholeinthewall:o_half_"
		if inv:is_empty("ingot") then
			return
		end
	end

		local ingotstack = inv:get_stack("ingot", 1)
		local resstack = inv:get_stack("res", 1)
----------------------------------------------------------------------------------
--register nodes
----------------------------------------------------------------------------------
		local mat_table = {
							{"default:sandstone",		"default_sandstone"},
							{"default:desert_sand",		"default_desert_sand"},
							{"default:clay",			"default_clay"},
							{"default:desert_stone",	"default_desert_stone"},
							{"default:cobble",			"default_cobble"},
							{"default:stone",			"default_stone"},
							{"default:cactus",			"default_cactus"},
							{"default:sand",			"default_sand"},
							{"default:wood",			"default_wood"},
							{"default:pine_wood",		"default_pine_wood"},
							{"default:dirt",			"default_dirt"},
							{"default:brick",			"default_brick"},
							{"default:bronzeblock",		"default_bronze_block"},
							{"default:coalblock",		"default_coal_block"},
							{"default:copperblock",		"default_copper_block"},
							{"default:desert_cobble",	"default_desert_cobble"},
							{"default:diamondblock",	"default_diamond_block"},
							{"default:glass",			"default_glass"},
							{"default:goldblock",		"default_gold_block"},
							{"default:gravel",			"default_gravel"},
							{"default:ice",				"default_ice"},
							{"default:jungletree",		"default_jungletree"},
							{"default:junglewood",		"default_junglewood"},
							{"default:aspen_wood",		"default_aspen_wood"},
							{"default:acacia_wood",		"default_acacia_wood"},
							{"default:mossycobble",		"default_mossycobble"},
							{"default:obsidian",		"default_obsidian"},
							{"default:obsidian_glass",	"default_obsidian_glass"},
							{"default:sanddstone_brick","default_sandstone_brick"},
							{"default:pinetree",		"default_pinetree"},
							{"default:steelblock",		"default_steel_block"},
							{"default:stonebrick",		"default_stone_brick"},
							{"default:tree",			"default_tree"},
							{"farming:straw",			"farming_straw"},
							--Wool
							{"wool:white",		"wool_white"},
							{"wool:black",		"wool_black"},
							{"wool:blue",		"wool_blue"},
							{"wool:brown",		"wool_brown"},
							{"wool:cyan",		"wool_brown"},
							{"wool:dark_green",	"wool_dark_green"},
							{"wool:dark_grey",	"wool_dark_grey"},
							{"wool:green",		"wool_green"},
							{"wool:grey",		"wool_grey"},
							{"wool:magenta",	"wool_magenta"},
							{"wool:orange",		"wool_orange"},
							{"wool:pink",		"wool_pink"},
							{"wool:red",		"wool_red"},
							{"wool:violet",		"wool_violet"},
							{"wool:yellow",		"wool_yellow"},
							--batmod
							{"bat_blocks:bat_cobble",		"bat_cobble"},
							{"bat_blocks:bat_cobble_white",	"bat_cobble_white"},
							{"bat_blocks:bat_cobble_tan",	"bat_cobble_tan"},
							{"bat_blocks:bat_pavers",		"bat_pavers"},
							{"bat_blocks:bat_block",		"bat_block"},
							{"bat_blocks:bat_tile",			"bat_tile"},
							{"bat_blocks:bat_diag",			"bat_diag"},
							{"bat_blocks:bat_x",			"bat_x_block"},
							{"bat_blocks:bat_brick",		"bat_brick"},
							{"bat_blocks:bat_smbrick",		"bat_smbrick"},
							--castle
							{"castle:dungeon_stone",		"dungeon_stone"},
							{"castle:pavement",				"pavement_brick"},
							{"castle:rubble",				"rubble"},
							{"castle:roofslate",			"slate"},
							{"castle:stonewall",			"stonewall"},
							--moreblocks
							{"moreblocks:cactus_brick",			"cactus_brick"},
							{"moreblocks:cactus_checker",		"cactus_checker"},
							{"moreblocks:coal_stone_bricks",	"coal_stone_bricks"},
							{"moreblocks:circle_stone_bricks",	"circle_stone_bricks"},
							{"moreblocks:iron_checker",			"iron_checker"},
							{"moreblocks:iron_stone_bricks",	"iron_stone_bricks"},
							{"moreblocks:plankstone",			"plankstone"},
							{"moreblocks:stone_tile",			"stone_tile"},
							{"moreblocks:wood_tile_center",		"wood_tile_center"},
							{"moreblocks:wood_tile_full",		"wood_tile_full"},
							--moretrees
							{"moretrees:apple_planks",			"apple_tree"},
							{"moretrees:beech_planks",			"beech"},
							{"moretrees:oak_planks",			"oak"},
							{"moretrees:sequoia_planks",		"sequoia"},
							{"moretrees:birch_planks",			"birch"},
							{"moretrees:palm_planks",			"palm"},
							{"moretrees:spruce_planks",			"spruce"},
							{"moretrees:willow_planks",			"willow"},
							{"moretrees:rubber_tree_planks",	"rubber_tree"},
							{"moretrees:fir_planks",			"fir"},
							--myores
							{"myores:slate",			"slate"},
							{"myores:shale",			"shale"},
							{"myores:schist",			"schist"},
							{"myores:gneiss",			"gneiss"},
							{"myores:basalt",			"basalt"},
							{"myores:granite",			"granite"},
							{"myores:marble",			"marble"},
							{"myores:chromium",			"chromium"},
							{"myores:manganese",		"manganese"},
							{"myores:quartz",			"quartz"},
							{"myores:chalcopyrite",		"chalcopyrite"},
							{"myores:cobalt",			"cobalt"},
							{"myores:uvarovite",		"uvarovite"},
							{"myores:selenite",			"selenite"},
							{"myores:miserite",			"miserite"},
							{"myores:limonite",			"limonite"},
							{"myores:sulfur",			"sulfur"},
							{"myores:lapis_lazuli",		"lapis_lazuli"},
							{"myores:emerald",			"emerald"},
							{"myores:amethyst",			"amethyst"},
					
							{"mywhiteblock:block_black",    "block_black"},
							{"mywhiteblock:block_blue",     "block_blue"},
							{"mywhiteblock:block_brown",    "block_brown"},
							{"mywhiteblock:block_cyan",     "block_cyan"},
							{"mywhiteblock:block_darkgreen","block_darkgreen"},
							{"mywhiteblock:block_darkgrey", "block_darkgrey"},
							{"mywhiteblock:block_green",    "block_green"},
							{"mywhiteblock:block_grey",     "block_grey"},
							{"mywhiteblock:block_magenta",  "block_magenta"},
							{"mywhiteblock:block_orange",   "block_orange"},
							{"mywhiteblock:block_pink",     "block_pink"},
							{"mywhiteblock:block_red",      "block_red"},
							{"mywhiteblock:block_violet",   "block_violet"},
							{"mywhiteblock:block_white",    "block_white"},
							{"mywhiteblock:block_yellow",   "block_yellow"},
							{"mywhiteblock:block",			"block"},
							}

		for i in ipairs(mat_table) do
			local items = mat_table[i][1]
			local mater = mat_table[i][2]

			if ingotstack:get_name()== items then
				material = mater
				make_ok = "1"
			end
		end

----------------------------------------------------------------------
		if make_ok == "1" then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("res",shape..material)
			end
			ingotstack:take_item()
			inv:set_stack("ingot",1,ingotstack)
		end            	
end
end


})

--Craft

minetest.register_craft({
		output = 'myholeinthewall:machine',
		recipe = {
			{'default:coalblock', 'default:coalblock', 'default:coalblock'},
			{'default:coalblock', 'default:diamond', 'default:coalblock'},
			{'default:coalblock', "default:coalblock", 'default:coalblock'},		
		},
})













