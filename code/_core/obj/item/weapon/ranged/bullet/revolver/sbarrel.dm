/obj/item/weapon/ranged/bullet/revolver/sbarrel
	name = "\improper 12g single barrel shotgun"
	desc = ""
	desc_extended = ""
	icon = 'icons/obj/item/weapons/ranged/dbarrel.dmi'
	icon_state = "inventory"
	value = 0

	company_type = "Solarian"

	tier_type = "shotgun"

	tier = 1

	damage_mod = 0.6
	shoot_delay = 3

	automatic = FALSE

	bullet_count_max = 1

	insert_limit = 1

	shoot_sounds = list('sound/weapons/ranged/shotgun/weak/shoot.ogg')

	size = SIZE_2
	weight = 8

	bullet_length_min = 76
	bullet_length_best = 76.2
	bullet_length_max = 76.4

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	heat_max = 0.1

	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 0
	movement_spread_base = 0.02

	value_burgerbux = 1

/obj/item/weapon/ranged/bullet/revolver/sbarrel/get_base_spread()
	return 0.2

/obj/item/weapon/ranged/bullet/revolver/sbarrel/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/revolver/sbarrel/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.08 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/revolver/sbarrel/undermount
	attachment_whitelist = list() //no
	value = 0
	open = TRUE
	can_shoot_while_open = TRUE