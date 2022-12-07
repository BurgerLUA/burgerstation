/obj/item/weapon/ranged/bullet/magazine/rifle/ooc
	name = "\improper 5.56mm IC-OOC rifle system"
	desc = "For mass (controlled) destruction of objects."
	desc_extended = "The InterChangable Object Obliterator Combat rifle system is a NanoTrasen made weapon based on the (stolen) prototype of an advanced Solarian tactical assault rifle (now known as the 5.56mm MOAR). Has a built in shotgun meant to fire fragmentation rounds, however I guess you could use regular shotgun rounds too."
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/556_7.dmi'
	icon_state = "inventory"
	value = 3000

	company_type = "NanoTrasen"

	tier = 3

	shoot_delay = 2
	burst_delay = 7
	max_bursts = 3

	damage_mod = 1.2

	automatic = TRUE

	firemodes = list("automatic","burst","semi-automatic")

	shoot_sounds = list('sound/weapons/223/burst.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 20

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.75

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

		/obj/item/attachment/undermount/gun/built_in_shotgun = TRUE,
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 28 - 16
	attachment_undermount_offset_y = 16 - 16

	dan_mode = TRUE

	heat_max = 0.05

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/ooc/get_static_spread()
	return 0.0075

/obj/item/weapon/ranged/bullet/magazine/rifle/ooc/get_skill_spread(var/mob/living/L)
	return max(0,0.04 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/ooc/Generate()
	. = ..()
	attachment_undermount = new /obj/item/attachment/undermount/gun/built_in_shotgun(src)
	INITIALIZE(attachment_undermount)
	GENERATE(attachment_undermount)
	FINALIZE(attachment_undermount)