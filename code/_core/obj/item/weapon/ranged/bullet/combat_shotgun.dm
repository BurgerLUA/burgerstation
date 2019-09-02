/obj/item/weapon/ranged/bullet/pump/combat_shotgun
	name = "12 gauge combat shotgun"
	desc = "A very robust combat shotgun."
	icon = 'icons/obj/items/weapons/ranged/combat_shotgun.dmi'
	icon_state = "inventory"

	shoot_delay = 1

	automatic = FALSE

	bullet_capacity = 6

	bullet_type = "shotgun"

	shoot_sounds = list('sounds/weapons/combat_shotgun/shoot.ogg')

	can_wield = TRUE

	icon_state_worn = "worn"
	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

	view_punch = 12

/obj/item/weapon/ranged/bullet/pump/combat_shotgun/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/weapon/ranged/bullet/pump/combat_shotgun/get_static_spread() //Base spread
	if(!wielded)
		return 0.1
	return 0.025

/obj/item/weapon/ranged/bullet/pump/combat_shotgun/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED,0,100))