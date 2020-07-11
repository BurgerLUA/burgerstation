/obj/item/clothing/head/hat/cat
	name = "\improper cursed cat ears"
	icon = 'icons/obj/item/clothing/hats/cat.dmi'
	desc = "Pwease gimme huggie wuggies! uwu!"
	desc_extended = "Dude what the fuck are you doing? Why did you buy this, why the fuck would you wanna even wear this? What the fuck, dude?"
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		HOLY = -100,
		DARK = 100,
		BLADE = -25,
		BLUNT = -25,
		PIERCE = -25
	)

	protected_limbs = TARGETABLE_LIMBS

	size = SIZE_2

	no_initial_blend = TRUE

	dyeable = TRUE

	polymorphs = list(
		"outer" = "#FFFFFF",
		"inner" = "#FF8888"
	)

	worn_layer = LAYER_MOB_HAIR_HEAD + 0.01

	value = 200