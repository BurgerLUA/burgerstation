/obj/item/weapon/ranged/bullet/pump/shotgun/combat
	name = "12g Combat Shotgun"
	desc = "Reliable, cheap, and strong."
	desc_extended = "A very robust pump action shotgun for Private Military Corporations."
	icon = 'icons/obj/items/weapons/ranged/shotgun/combat.dmi'
	icon_state = "inventory"
	value = 70

	shoot_delay = 4

	automatic = FALSE

	bullet_count_max = 8



	shoot_sounds = list('sounds/weapons/combat_shotgun/shoot.ogg')

	can_wield = TRUE

	icon_state_worn = "worn"
	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

	view_punch = 12

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN

	size = SIZE_4
	weight = WEIGHT_3

	value = 130

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/get_static_spread() //Base spread
	if(!wielded)
		return 0.1
	return 0.025

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))


/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod
	name = "12 gauge modified combat shotgun"
	desc = "A very robust combat shotgun. This one has been modified to be have a pistol grip and be shorter."
	icon = 'icons/obj/items/weapons/ranged/shotgun/combat_mod.dmi'
	icon_state = "inventory"

	shoot_delay = 4

	automatic = FALSE

	bullet_count_max = 6


	shoot_sounds = list('sounds/weapons/combat_shotgun/shoot.ogg')

	can_wield = FALSE

	view_punch = 16

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN

	size = SIZE_3
	weight = WEIGHT_2

	value = 150

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))