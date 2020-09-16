/obj/item/weapon/melee/shield
	name = "buckler"
	desc = "Carry two of these and be the ultimate asshole."
	desc_extended = "Good for blocking melee attacks. This buckler doubles your chance of blocking or parrying melee attacks. Can block ranged and melee attacks."
	icon = 'icons/obj/item/weapons/melee/shield.dmi'
	damage_type = /damagetype/melee/club/shield

	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE


	attack_delay = 10
	attack_delay_max = 15

	value = 35

	block_defense_rating = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75
	)

/obj/item/weapon/melee/shield/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/weapon/melee/shield/glass
	name = "glass shield"
	icon = 'icons/obj/item/weapons/melee/glass_shield.dmi'

	block_defense_rating = list(
		BLADE = 75,
		BLUNT = 25,
		PIERCE = 25,
		ARCANE = 200,
		DARK = 100,
		HOLY = 100
	)