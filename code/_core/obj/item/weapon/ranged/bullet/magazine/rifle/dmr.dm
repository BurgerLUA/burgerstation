/obj/item/weapon/ranged/bullet/magazine/rifle/dmr
	name = "\improper 7.62mm SOL-5 DMR"
	desc = "For your designated marksman."
	desc_extended = "The 7.62mm SOL-5 DMR is the ultimate marksman rifle for Solarian infantry units. The bullpup design allows the most barrel length length out of any other rifles of its caliber."
	icon = 'icons/obj/item/weapons/ranged/rifle/sol/dmr.dmi'
	icon_state = "inventory"
	value = 4000

	company_type = "Solarian"

	tier_type = "marksman rifle"

	tier = 3

	firemodes = list("semi-automatic")

	shoot_delay = 4

	damage_mod = 1.4

	automatic = FALSE

	shoot_sounds = list('sound/weapons/ranged/rifle/dmr/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 18

	heat_max = 0.12

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 1.5

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
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE,
		/obj/item/attachment/undermount/gun/grenade_launcher = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 14 - 16

	inaccuracy_modifier = 0.35
	movement_inaccuracy_modifier = 1.5
	movement_spread_base = 0.025

	rarity = RARITY_UNCOMMON


/obj/item/weapon/ranged/bullet/magazine/rifle/dmr/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/dmr/get_skill_spread(var/mob/living/L)
	return max(0,0.003 - (0.003 * L.get_skill_power(SKILL_RANGED)))



/obj/item/weapon/ranged/bullet/magazine/rifle/dmr/Generate()
	. = ..()
	attachment_sight = new /obj/item/attachment/sight/scope/medium(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)

/obj/item/weapon/ranged/bullet/magazine/rifle/dmr/specop
	value_burgerbux = 1


/obj/item/weapon/ranged/bullet/magazine/rifle/dmr/specop/Generate()

	. = ..()

	attachment_barrel = new /obj/item/attachment/barrel/suppressor(src)
	INITIALIZE(attachment_barrel)
	GENERATE(attachment_barrel)
	FINALIZE(attachment_barrel)

	attachment_sight = new /obj/item/attachment/sight/laser_sight(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)

	attachment_undermount = new /obj/item/attachment/undermount/angled_grip(src)
	INITIALIZE(attachment_undermount)
	GENERATE(attachment_undermount)
	FINALIZE(attachment_undermount)