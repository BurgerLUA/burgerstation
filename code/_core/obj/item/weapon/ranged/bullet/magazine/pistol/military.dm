/obj/item/weapon/ranged/bullet/magazine/pistol/military
	name = "9mm Auto 18"
	desc = "An old relic from an oppressive police force."
	desc_extended = "An automatic pistol chambered in 9mm. Good for self defense."
	value = 70
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm.dmi'
	shoot_delay = 1.5
	shoot_sounds = list('sound/weapons/40/shoot.ogg')

	view_punch = 7

	automatic = TRUE

	size = SIZE_2
	weight = 3

	heat_per_shot = 0.03
	heat_max = 0.12

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 11 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 23 - 16
	attachment_undermount_offset_y = 16 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad


/obj/item/weapon/ranged/bullet/magazine/pistol/military/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/pistol/military/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)) )

/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod
	name = ".40 Auto-18 MOD"
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm_2.dmi'
	desc_extended = "A modified variant of the 9mm Auto Pistol. The barrel width was increased to support .40 The slider has been shortened, the frame replaced with lighter materials, and a recoil compensator was added for extra accuracy."
	value = 110
	shoot_sounds = list('sound/weapons/40/shoot_mod.ogg')
	shoot_delay = 1.5

	view_punch = 5

	automatic = FALSE

	size = SIZE_2


	heat_per_shot = 0.02
	heat_max = 0.10

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

	attachment_whitelist = list()

	firing_pin = /obj/item/firing_pin/electronic/iff/space_cop

/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.03 * L.get_skill_power(SKILL_RANGED)))



/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen
	name = "9mm Auto-18 NT"
	desc = "An old relic from an oppressive police force."
	desc_extended = "A security grade pistol chambered in 9mm. This one has been modifed with a new lighrweight frame and paintjob."
	value = 90
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm_nt.dmi'
	shoot_delay = 1.5
	shoot_sounds = list('sound/weapons/40/shoot.ogg')

	view_punch = 6

	automatic = FALSE

	size = SIZE_2


	heat_per_shot = 0.025
	heat_max = 0.1

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)) )