/obj/item/weapon/ranged/bullet/revolver/tribarrel
	name = "\improper 23x75mmR Tri-Barrel Shotgun"
	desc = "Best against demons."
	desc_extended = "An absolutely ridiculous 3 barreled shotgun that holds giant 23x75mmR rounds."
	icon = 'icons/obj/item/weapons/ranged/shotgun/power.dmi'
	icon_state = "inventory"

	shoot_delay = 1.25

	automatic = TRUE

	bullet_count_max = 3

	insert_limit = 3

	view_punch = TILE_SIZE - 1

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN

	size = SIZE_3


	bullet_length_min = 73
	bullet_length_best = 75
	bullet_length_max = 78

	bullet_diameter_min = 21
	bullet_diameter_best = 23
	bullet_diameter_max = 25

	heat_per_shot = 0.09
	heat_max = 0.18

	value = 600

	open = TRUE

	inaccuracy_modifer = 1

/obj/item/weapon/ranged/bullet/revolver/tribarrel/get_base_spread()
	return 0.05

/obj/item/weapon/ranged/bullet/revolver/tribarrel/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/revolver/tribarrel/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.03 - (0.12 * L.get_skill_power(SKILL_RANGED)))