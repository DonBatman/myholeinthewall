function myholeinthewall.register_all(mat, desc, image, mygroups, craft, drawtype)

core.register_node("myholeinthewall:diamond_"..mat,{
	description = desc.." Diamond",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_diamond_full.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0.5},
		}	
	},
	on_place = core.rotate_node,
})
core.register_node("myholeinthewall:diamond_rough_"..mat,{
	description = desc.." Rough Diamond",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_rough_diamond_full.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),

	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0.5},
		}	
	},
	on_place = core.rotate_node,
})
core.register_node("myholeinthewall:cross_"..mat,{
	description = desc.." Cross",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_plus_full2.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0.5},
		}	
	},
	on_place = core.rotate_node,
})

core.register_node("myholeinthewall:cross_iron_"..mat,{
	description = desc.." Iron Cross",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_iron_cross_full.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0.5},
		}	
	},
	on_place = core.rotate_node,
})
core.register_node("myholeinthewall:o_"..mat,{
	description = desc.." O",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_o_full.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0.5},
		}	
	},
	on_place = core.rotate_node,
})core.register_node("myholeinthewall:x_"..mat,{
	description = desc.." X",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_x_full.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0.5},
		}	
	},
	on_place = core.rotate_node,
})

--------------------------------------------------------------------------------------------
--Half
core.register_node("myholeinthewall:diamond_half_"..mat,{
	description = desc.." Diamond",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_diamond.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0},
		}	
	},
	on_place = core.rotate_node,
})
core.register_node("myholeinthewall:diamond_rough_half_"..mat,{
	description = desc.." Rough Diamond",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_rough_diamond.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0},
		}	
	},
	on_place = core.rotate_node,
})
core.register_node("myholeinthewall:cross_half_"..mat,{
	description = desc.." Cross",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_plus2.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0},
		}	
	},
	on_place = core.rotate_node,
})

core.register_node("myholeinthewall:cross_iron_half_"..mat,{
	description = desc.." Iron Cross",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_iron_cross.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0},
		}	
	},
	on_place = core.rotate_node,
})
core.register_node("myholeinthewall:o_half_"..mat,{
	description = desc.." O",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_o.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0},
		}	
	},
	on_place = core.rotate_node,
})core.register_node("myholeinthewall:x_half_"..mat,{
	description = desc.." X",
	tiles = {image},
	drawtype = "mesh",
	mesh = "myholeinthewall_x.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 1, cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0},
		}	
	},
	on_place = core.rotate_node,
})
end





		
