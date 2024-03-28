/obj/item/weapon/ranged/bullet/magazine/pistol/cof_handgun
	name = ".45 COF-5150 Pistol"
	desc = "You're so dead, you're so fucking dead!"
	desc_extended = "A large framed handgun chambering standard .45 magazines and ammunition. Known to be remarkably accurate, but with a high level of recoil and lower effective fire rate. Has found use by some Solarian police forces and small enforcer unions for the high degree of accuracy and larger then average calibre round."
	value = 500

	tier = 2

	company_type = "Solarian"

	icon = 'icons/obj/item/weapons/ranged/pistol/cof_handgun.dmi'
	shoot_delay = 3
	shoot_sounds = list('sound/weapons/ranged/pistol/1984/shoot.ogg')

	movement_spread_base = 0.007
	inaccuracy_modifier = 0.3
	movement_inaccuracy_modifier = 0

	automatic = FALSE

	size = SIZE_2
	weight = 7

	heat_max = 0.07

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 16 - 16

	rarity = RARITY_COMMON


/obj/item/weapon/ranged/bullet/magazine/pistol/cof_handgun/get_static_spread()
	return 0.003

/obj/item/weapon/ranged/bullet/magazine/pistol/cof_handgun/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/cof_handgun/mod
	name = ".45 COF-5150 Pistol MOD"
	desc_extended = "A large framed handgun chambering standard .45 magazines and ammunition. This model used the COF-5150 as a base and was modified extensively with an extended black steel slide, improved night sights, stainless steel safety lever, chamber, and barrel. \ 
	A custom aluminum frame replaces the old polymer frame of the original model, and a set of black plastic grips holds a badge depicting a special operations unit logo with green text reading 'MHU'. \
	The accuracy, and stopping power of this pistol could make some revolvers jealous at the cost of being cumbersome to handle."
	value = 1200
	icon = 'icons/obj/item/weapons/ranged/pistol/cof_handgun_2.dmi'
	shoot_delay = 4

	damage_mod = 1.35

	tier = 3

	movement_spread_base = 0.005
	inaccuracy_modifier = 0.2
	movement_inaccuracy_modifier = 0

	size = SIZE_2
	weight = 8

	heat_max = 0.11

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod/get_skill_spread(var/mob/living/L)
	return max(0,0.03 - (0.03 * L.get_skill_power(SKILL_RANGED)))