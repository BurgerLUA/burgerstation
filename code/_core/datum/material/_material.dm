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
	var/value_per_unit = 1

/material/glass/
	name = "glass"
	id = "glass"
	color = COLOR_GLASS

	icon_state_sheet = "glass"

	icon_state_ore = "ore_sand"

	value_per_unit = 1

/material/steel
	name = "steel"
	id = "steel"
	color = COLOR_STEEL

	value_per_unit = 2

/material/aluminum
	name = "aluminum"
	id = "aluminum"
	color = COLOR_ALUMINUM
	value_per_unit = 3

/material/iron
	name = "iron"
	id = "iron"
	color = COLOR_IRON
	icon_state_ore = "ore_iron"

	value_per_unit = 0.5

/material/phoron
	name = "phoron"
	id = "phoron"
	color = COLOR_PHORON
	icon_state_ore = "ore_phoron"

	value_per_unit = 10

/material/carbon
	name = "carbon"
	id = "carbon"
	color = COLOR_CARBON
	icon_state_ore = "ore_coal"

	value_per_unit = 0.5

/material/gold
	name = "gold"
	id = "gold"
	color = COLOR_GOLD
	icon_state_ore = "ore_gold"

	value_per_unit = 3

/material/diamond
	name = "diamond"
	id = "diamond"
	color = COLOR_DIAMOND
	icon_state_ore = "ore_diamond"

	value_per_unit = 50

/material/silver
	name = "silver"
	id = "silver"
	color = COLOR_SILVER
	icon_state_ore = "ore_silver"

	value_per_unit = 30

/material/uranium
	name = "uranium"
	id = "uranium"
	color = COLOR_URANIUM
	icon_state_ore = "ore_uranium"

	value_per_unit = 20

/material/titanium
	name = "titanium"
	id = "titanium"
	color = COLOR_TITANIUM
	icon_state_ore = "ore_titanium"

	value_per_unit = 30

/material/plaststeel
	name = "plaststeel"
	id = "plaststeel"
	color = COLOR_PLASTEEL

	value_per_unit = 30