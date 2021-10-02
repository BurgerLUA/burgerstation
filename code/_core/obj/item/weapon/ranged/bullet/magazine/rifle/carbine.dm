/obj/item/weapon/ranged/bullet/magazine/rifle/carbine
	name = "\improper .223 Raider Carbine"
	desc = "A favorite by pirates."
	desc_extended = "Leftover surplus guns left by the good ol days of syndicate raiding parties. While old and outdated, it still sees some uses by old and new syndicate forces."
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/223.dmi'
	icon_state = "inventory"
	value = 900

	tier = 1

	shoot_delay = 2

	automatic = TRUE

	firemodes = list("burst","automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/223/shoot.ogg')

	can_wield = FALSE

	size = SIZE_3
	weight = 8

	heat_max = 0.1

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.75

	override_icon_state = TRUE

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 17 - 16



	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.25
	movement_spread_base = 0.005

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/update_icon()

	icon_state = initial(icon_state)

	if(!stored_magazine)
		icon_state = "[icon_state]_open"
	else
		icon_state = "[icon_state]_[CEILING((length(stored_magazine.stored_bullets)/stored_magazine.bullet_count_max)*7, 1)]"

	return ..()


/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_static_spread()
	return 0.007

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_cock_sound(var/direction="both")
	return 'sound/weapons/gun/smg/smg_rack.ogg'

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/mod
	name = "\improper .223 SYN-Carbine MOD"
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/223_mod.dmi'

	heat_max = 0.12

	size = SIZE_2
	weight = 4

	value = 800

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/mod/get_static_spread()
	return 0.03

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/mod/get_skill_spread(var/mob/living/L)
	return max(0,0.04 - (0.04 * L.get_skill_power(SKILL_RANGED)))