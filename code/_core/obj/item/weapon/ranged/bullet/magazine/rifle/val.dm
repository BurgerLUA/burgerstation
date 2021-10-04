/obj/item/weapon/ranged/bullet/magazine/rifle/val
	name = "\improper 9x39mm AS Val"
	desc = "The last thing you'll never hear."
	desc_extended = "A modified version of the silent Vintorez sniper rifle, the assault rifle was designed as a special forces weapon."
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/939_rifle.dmi'
	icon_state = "inventory"
	value = 2000

	tier = 2

	shoot_delay = 1.1

	firemodes = list("automatic","semi-automatic")

	automatic = TRUE

	damage_mod = 1.1

	shoot_sounds = list('sound/weapons/russia/val.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 12

	heat_max = 0.1

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

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

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 18 - 16

	dan_mode = TRUE

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.75
	movement_spread_base = 0.03

/obj/item/weapon/ranged/bullet/magazine/rifle/val/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/val/get_skill_spread(var/mob/living/L)
	return max(0,0.002 - (0.004 * L.get_skill_power(SKILL_RANGED)))