/obj/item/weapon/ranged/bullet/magazine/rifle/ak12
	name = "\improper 5.45x39mm AK-12"
	desc = "A nuu cheeki breeki i v damkee!"
	desc_extended = "AK-12 is a 5.45x39mm fully automatic rifle renowned for its precision and the ability to shoot at faster rates than the more widespread AK-13. Smaller caliber allows it to have less recoil, yet it doesn't make it any weaker - rifle is fine, as always. Currently in use by the Space Russia's special forces (they don't really like to change equipment if it works finely) and elite revolutionaries, seemingly receiving batches of this weapon by black markets and deals with the government. Cheap as hell, effective and easy to maintain - a dream weapon for anyone, but rare to come by."
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/545_rifle_2.dmi'
	icon_state = "inventory"
	value = 2000

	tier = 2

	shoot_delay = 1.1

	shoot_sounds = list('sound/weapons/russia/abakan.ogg')

	firemodes = list("automatic","semi-automatic")

	can_wield = TRUE

	automatic = TRUE

	size = SIZE_4
	weight = 15

	heat_max = 0.1

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 5.4
	bullet_diameter_best = 5.45
	bullet_diameter_max = 5.46  //Just so people wouldn't load this gun with 5.56, would be really-really weird to do so - Stalkeros

	ai_heat_sensitivity = 1.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
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

	dan_mode = TRUE

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/ak12/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/magazine/rifle/ak12/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))