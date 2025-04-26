local block_table = {
	{"black",      "Black",      "#000000"},
	{"blue",       "Blue",       "#2000c9"},
	{"brown",      "Brown",      "#954c05"},
	{"cyan",       "Cyan",       "#01ffd8"},
	{"darkgreen", "Dark Green",  "#005b07"},
	{"darkgrey",  "Dark Grey",   "#303030"},
	{"green",      "Green",      "#61ff01"},
	{"grey",       "Grey",       "#5b5b5b"},
	{"magenta",    "Magenta",    "#ff05bb"},
	{"orange",     "Orange",     "#ff8401"},
	{"pink",       "Pink",       "#ff65b5"},
	{"red",        "Red",        "#ff0000"},
	{"violet",     "Violet",     "#ab23b0"},
	{"white",      "White",      "#ffffff"},
	{"yellow",     "Yellow",     "#e3ff00"},
}

for i in ipairs(block_table) do
	local mat = block_table[i][1]
	local des = block_table[i][2]
	local col = block_table[i][3]

--mat, desc, image, mygroups, craft, drawtype

myholeinthewall.register_all(
	"block_"..mat, 
	des.." Block", 
	"mywhiteblock_white.png^[colorize:"..col,
	{cracky = 1, oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
	"mywhiteblock:block_"..mat,
	"normal"
	)
end
myholeinthewall.register_all(
	"block", 
	"White Block", 
	"mywhiteblock_white.png",
	{cracky = 1, oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
	"mywhiteblock:block",
	"normal"
	)
