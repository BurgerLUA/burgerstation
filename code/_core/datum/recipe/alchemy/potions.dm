/recipe/alchemy/health_potion
	name = "health potion"

	required_items = list("/obj/item/crafting/ingredient/part/gunpowder" = 1,
	"/obj/item/crafting/alchemy_plant/forest_berry" = 1,
	"/obj/item/crafting/ingredient/part/alchemy_bottle" = 1)

	product = list("/obj/item/container/simple/beaker/bottle" = 100)

	reagents_to_add = list("/reagent/medicine/health_potion" = 30)

/recipe/alchemy/mana_potion
	name = "mana potion"

	required_items = list("/obj/item/crafting/ingredient/part/gunpowder" = 1,
	"/obj/item/crafting/alchemy_plant/snow_daisy" = 1,
	"/obj/item/crafting/ingredient/part/alchemy_bottle" = 1)

	product = list("/obj/item/container/simple/beaker/bottle" = 100)

	reagents_to_add = list("/reagent/medicine/mana_potion" = 30)
