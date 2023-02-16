/obj/item/weapon/ranged/bullet/magazine/pistol/syndie
	name = "10mm Stecharov pistol"
	desc = "The traitor's second best friend."
	desc_extended = "The standard Syndicate pistol. Cheap. Reliable. The compactness of the gun makes it useful in assassinations as well as a holdout weapon."
	icon = 'icons/obj/item/weapons/ranged/pistol/10mm.dmi'
	icon_state = "inventory"
	value = 250

	company_type = "Syndicate"

	tier = 1

	shoot_delay = 2.2

	automatic = FALSE

	movement_spread_base = 0.01
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	shoot_sounds = list('sound/weapons/ranged/pistol/stetchkin/shoot.ogg')

	can_wield = FALSE

	size = SIZE_2
	weight = 3

	heat_max = 0.12

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 24 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 14 - 16

	rarity = RARITY_COMMON



/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/mod
	name = "10mm Stecharov pistol MOD"
	icon = 'icons/obj/item/weapons/ranged/pistol/10mm_2.dmi'
	desc = "The traitor's second best friend."
	desc_extended = "A standard Syndicate pistol modified with better materials. This variant is much more compac, concealable, and fires much faster."

	size = SIZE_1

	attachment_barrel_offset_x = 25 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 24 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 14 - 16

	rarity = RARITY_RARE

	shoot_delay = 1.8



/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/slavic
	name = "9x19mm Mackintosh pistol"
	desc = "Putting the \"Sir, can I have something better.\" in surplus!"
	desc_extended = "A surplus Slavic pistol designed to be a cheap replica of the Stecharov pistol, which was also a cheap replica of a Slavic pistol. It has many layers to its shitness."
	icon = 'icons/obj/item/weapons/ranged/pistol/10mm_3.dmi'

	company_type = "Slavic"

	size = SIZE_2

	attachment_barrel_offset_x = 26 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	heat_max = 0.1

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/slavic/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/slavic/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.03 * L.get_skill_power(SKILL_RANGED)))
