/obj/item/weapon/ranged/bullet/revolver/tribarrel
	name = "\improper 23x75mmR Tri-Barrel Shotgun"
	desc = "Best against demons."
	desc_extended = "An absolutely ridiculous 3 barreled shotgun that holds giant 23x75mmR rounds."
	icon = 'icons/obj/item/weapons/ranged/shotgun/power.dmi'
	icon_state = "inventory"

	shoot_delay = 2

	automatic = TRUE

	bullet_count_max = 3

	insert_limit = 3

	view_punch = TILE_SIZE - 1

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	size = SIZE_3
	weight = 14

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

	attachment_whitelist = list(
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 0 - 16
	attachment_barrel_offset_y = 0 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 0 - 16
	attachment_undermount_offset_y = 0 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/revolver/tribarrel/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bullet/revolver/tribarrel/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/revolver/tribarrel/get_skill_spread(var/mob/living/L)
	return max(0,0.03 - (0.12 * L.get_skill_power(SKILL_RANGED)))