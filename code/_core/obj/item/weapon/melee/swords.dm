/obj/item/weapon/melee/sword
	name = "sabre"
	desc = "A curved sword. Curved. Sword."

	icon = 'icons/obj/items/weapons/melee/swords/sabre.dmi'

	icon_state_worn = "worn"

	damage_type = /damagetype/sword/sabre

	item_slot = SLOT_GROIN_O
	worn_layer = LAYER_MOB_CLOTHING_BACK

	slot_icons = TRUE

/obj/item/weapon/melee/sword/can_be_worn()
	return TRUE

/obj/item/weapon/melee/sword/claymore
	name = "steel claymore sword"
	desc = "Looking at this really makes you want to go on a crusade."

	icon = 'icons/obj/items/weapons/melee/swords/claymore.dmi'
	damage_type = /damagetype/sword/claymore

	icon_state_worn = "worn"
	item_slot = SLOT_GROIN_O | SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE