/obj/item/clothing/overwear/hardsuit/spacesuit
	name = "\improper Solarian spacesuit"
	item_slot = SLOT_TORSO_ARMOR

	icon = 'icons/obj/item/clothing/suit/space.dmi'

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT


	drop_sound = 'sound/items/drop/metalboots.ogg'

	item_slot_layer = 2

	hidden_organs = list(
		BODY_TORSO = TRUE,
		BODY_GROIN = TRUE,
		BODY_ARM_RIGHT = TRUE,
		BODY_ARM_LEFT = TRUE,
		BODY_LEG_RIGHT = TRUE,
		BODY_LEG_LEFT = TRUE,
	)

	rarity = RARITY_UNCOMMON

	armor = /armor/bio

	size = SIZE_6

	value = 1