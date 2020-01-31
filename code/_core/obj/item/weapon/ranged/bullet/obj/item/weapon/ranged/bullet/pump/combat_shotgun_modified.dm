/obj/item/weapon/ranged/bullet/pump/combat_shotgun_modified
	name = "12 gauge modified combat shotgun"
	desc = "A very robust combat shotgun. This one has been modified to be have a pistol grip and be shorter."
	icon = 'icons/obj/items/weapons/ranged/combat_shotgun_mod.dmi'
	icon_state = "inventory"

	shoot_delay = 4

	automatic = FALSE

	bullet_count_max = 6

	bullet_type = "shotgun"

	shoot_sounds = list('sounds/weapons/combat_shotgun/shoot.ogg')

	can_wield = FALSE

	view_punch = 16

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN

	size = SIZE_3
	weight = WEIGHT_2

/obj/item/weapon/ranged/bullet/pump/combat_shotgun/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/pump/combat_shotgun/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))