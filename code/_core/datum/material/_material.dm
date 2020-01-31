/material/
	var/name = "material"
	var/id
	var/desc = "Pun."
	var/desc_extended = "Information about this material."

	var/color = "#FFFFFF"

	var/icon_state_sheet = "sheet"
	var/icon_state_rod = "rod"
	var/icon_state_ingot = "ingot"
	var/icon_state_ore = "ore"

	var/weight_per_unit = 0.1

/material/glass/
	name = "steel"
	id = "glass"
	color = COLOR_GLASS

	icon_state_sheet = "glass"

	icon_state_ore = "ore_sand"

/material/steel
	name = "steel"
	id = "steel"
	color = COLOR_STEEL

/material/iron
	name = "iron"
	id = "iron"
	color = COLOR_IRON
	icon_state_ore = "ore_iron"

/material/phoron
	name = "phoron"
	id = "phoron"
	color = COLOR_PHORON
	icon_state_ore = "ore_phoron"

/material/carbon
	name = "carbon"
	id = "carbon"
	color = COLOR_CARBON
	icon_state_ore = "ore_coal"

/material/gold
	name = "gold"
	id = "gold"
	color = COLOR_GOLD
	icon_state_ore = "ore_gold"

/material/diamond
	name = "diamond"
	id = "diamond"
	color = COLOR_DIAMOND
	icon_state_ore = "ore_diamond"

/material/silver
	name = "silver"
	id = "silver"
	color = COLOR_SILVER
	icon_state_ore = "ore_silver"

/material/uranium
	name = "uranium"
	id = "uranium"
	color = COLOR_URANIUM
	icon_state_ore = "ore_uranium"

/material/titanium
	name = "titanium"
	id = "titanium"
	color = COLOR_TITANIUM
	icon_state_ore = "ore_titanium"

/material/plaststeel
	name = "plaststeel"
	id = "plaststeel"
	color = COLOR_PLASTEEL