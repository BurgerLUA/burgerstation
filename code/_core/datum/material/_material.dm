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

/material/metal

/material/metal/steel
	name = "steel"
	id = "steel"
	color = COLOR_STEEL

/material/metal/iron
	name = "iron"
	id = "iron"
	color = COLOR_IRON
	icon_state_ore = "ore_iron"

/material/metal/plaststeel
	name = "plaststeel"
	id = "plaststeel"
	color = COLOR_PLASTEEL