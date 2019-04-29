/obj/item/weapon/melee/shield
	name = "buckler"
	desc = "Carry two of these and be the ultimate asshole."
	desc_extended = "Good for blocking melee attacks. This buckler doubles your chance of blocking or parrying melee attacks. Can block ranged and melee attacks."
	icon = 'icons/obj/items/weapons/melee/shield.dmi'
	damage_type = "shield_wood"

	block_mul = list(
		ATTACK_TYPE_MELEE = 2,
		ATTACK_TYPE_RANGED = 0.25,
		ATTACK_TYPE_MAGIC = 0.25
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 2,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

/obj/item/weapon/melee/can_be_worn()
	return TRUE