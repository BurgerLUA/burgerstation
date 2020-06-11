/recipe/alchemy/
	name = "smelting recipe"
	desc = "A smelting recipe"
	desc_extended = "Smelting recipe information."

	required_item_grid = list()
	required_items = list()

	recipe_type = "alchemy"

	var/product_reagent = null


/recipe/alchemy/carbon_powder
	name = "carbon to carbon powder"
	desc = "Turn carbon into carbon powder."

	required_item_grid = list("c2" = "beaker")
	required_items = list("ore_carbon")

	recipe_type = "alchemy"

	product_reagent = "carbon"