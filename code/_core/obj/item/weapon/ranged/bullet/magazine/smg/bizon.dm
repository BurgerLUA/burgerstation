/obj/item/weapon/ranged/bullet/magazine/smg/bizon
	name = "\improper 9x19mm PP-19"
	desc = "Gruz dvesti."
	desc_extended = "PP-19, also known as 'Bizon', is a 9x19 chambered submachine gun with an incredibly high ammo capacity."
	icon = 'icons/obj/item/weapons/ranged/smg/bison.dmi'
	icon_state = "inventory"
	value = 2000

	tier = 2

	shoot_delay = 1.1

	shoot_sounds = list('sound/weapons/russia/abakan.ogg')

	firemodes = list("burst","automatic","semi-automatic")

	can_wield = TRUE

	automatic = TRUE

	size = SIZE_3
	weight = 9

	heat_max = 0.2

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	ai_heat_sensitivity = 1.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/undermount/bipod = FALSE, //This is just straight up perversion - putting bipod on the SMG.
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 22 - 15
	attachment_undermount_offset_y = 18 - 16



	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0
	movement_spread_base = 0.005

/obj/item/weapon/ranged/bullet/magazine/smg/bizon/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/smg/bizon/get_skill_spread(var/mob/living/L)
	return max(0,0.1 - (0.2 * L.get_skill_power(SKILL_RANGED)))