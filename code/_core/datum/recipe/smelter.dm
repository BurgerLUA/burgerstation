/recipe/smelter/
	name = "smelting recipe"
	id = null
	desc = "A smelting recipe"
	desc_extended = "Smelting recipe information."

	required_item_grid = list()
	required_items = list()

	recipe_type = "smelter"

/recipe/smelter/iron
	name = "smelt iron ore"
	id = "smelt_iron"
	desc = "Smelt iron into iron ingots."
	required_items = list("ore_iron")
	product = /obj/item/ingot/iron

/recipe/smelter/steel
	name = "smelt steel"
	id = "smelt_steel"
	desc = "Smelt steel and coal into iron ingots."
	required_items = list("ingot_iron","ore_carbon")
	product = /obj/item/ingot/steel

/recipe/smelter/bread
	name = "cook bread"
	id = "cook_bread"
	desc = "Cook bread with this."
	required_items = list("dough")
	product = /obj/item/container/food/bread

	transfer_reagents = TRUE