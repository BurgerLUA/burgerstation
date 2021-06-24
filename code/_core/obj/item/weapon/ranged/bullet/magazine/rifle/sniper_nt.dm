/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_nt
	name = "\improper 7.62mm Bushshot Sniper Rifle"
	desc = "For when you want to be an asshole at an extended range."
	desc_extended = "Placeholder"
	icon = 'icons/obj/item/weapons/ranged/rifle/762_sniper_2.dmi'
	icon_state = "inventory"
	value = 3000

	requires_cock_each_shot = TRUE

	shoot_delay = 3

	automatic = FALSE

	damage_mod = 1.5

	shoot_sounds = list('sound/weapons/rifle_heavy/shoot.ogg')

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_5
	weight = 20

	heat_max = 0.05

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_4

	ai_heat_sensitivity = 2

	zoom_mul = 3

	dan_mode = TRUE

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 0
	attachment_sight_offset_y = 0

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 18 - 16

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 1.25
	movement_spread_base = 0.1

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_nt/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_nt/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))