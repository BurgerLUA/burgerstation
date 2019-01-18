/obj/item/weapon/melee/sword
	name = "sabre"
	desc = "A curved sword. Curved. Sword."

	icon = 'icons/obj/items/weapons/melee/swords/sabre.dmi'

	icon_state_worn = "worn"

	damage_type = /damagetype/sword/sabre

	item_slot = SLOT_GROIN_O
	worn_layer = LAYER_MOB_CLOTHING_BACK

/obj/item/weapon/melee/sword/can_be_worn()
	return TRUE