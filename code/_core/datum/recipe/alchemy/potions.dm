/recipe/alchemy/health_potion
	name = "health potion"

	required_items = list("/obj/item/crafting/ingredient/part/gunpowder" = 1,
	"/obj/item/crafting/alchemy_plant/forest_berry" = 1,
	"/obj/item/crafting/ingredient/part/alchemy_bottle" = 1)

	product = /obj/item/container/simple/beaker/bottle

	reagents_to_add = list("/reagent/medicine/health_potion" = 30)