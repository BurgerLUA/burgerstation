/obj/item/clothing/mask/daddy
	name = "true mask"
	icon = 'obj/items/clothing/masks/daddy.dmi'
	rarity = RARITY_MYTHICAL
	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD
	desc = "Well, what is it?"
	desc_extended = "A giant mask depicting some sort of father figure. Has a negative weight value, and decreases equip load when worn."
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_C
	)

	size = SIZE_3
	weight = -15

	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER


/atom/get_examine_text(var/mob/examiner)

	var/obj/faketype = type
	world.log << "IT IS TIME FOR [initial(faketype.name)]."
	world.log << "Hi, my name is [name]."
	world.log << "Hi, my initial name is [initial(name)]."

	return ..()