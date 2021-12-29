/obj/item/weapon/ranged/bullet/magazine/rifle/honey
	name = "\improper .300 Mead Squirrel"
	desc = "MP5SD, but cooler."
	desc_extended = "An integrally supressed PDW, firing .300 CCA subsonic ammo. Designed for covert operations."
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/honey.dmi'
	icon_state = "inventory"
	value = 2300

	tier = 3

	shoot_delay = 1.5

	firemodes = list("burst","automatic","semi-automatic")

	automatic = TRUE

	damage_mod = 1.1

	shoot_sounds = list('sound/weapons/russia/val.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 12

	heat_max = 0.1

	bullet_length_min = 34
	bullet_length_best = 35
	bullet_length_max = 36

	bullet_diameter_min = 7.61
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.63

	ai_heat_sensitivity = 1.5

	shoot_alert = ALERT_LEVEL_NONE

	attachment_whitelist = list(
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 18 - 16



	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.75
	movement_spread_base = 0.03

/obj/item/weapon/ranged/bullet/magazine/rifle/honey/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/honey/get_skill_spread(var/mob/living/L)
	return max(0,0.002 - (0.004 * L.get_skill_power(SKILL_RANGED)))