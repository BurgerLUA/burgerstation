/recipe/smelter/
	name = "smelting recipe"
	desc = "A smelting recipe"
	desc_extended = "Smelting recipe information."

	required_item_grid = list()
	required_items = list()

	recipe_type = "smelter"

/recipe/smelter/iron
	name = "smelt iron ore"
	desc = "Smelt iron into iron ingots."
	required_items = list("ore_iron")
	product = /obj/item/material/ingot/iron

/recipe/smelter/steel
	name = "smelt steel"
	desc = "Smelt steel and coal into iron ingots."
	required_items = list("ingot_iron","ore_carbon")
	product = /obj/item/material/ingot/steel