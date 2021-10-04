/obj/item/weapon/ranged/bullet/magazine/rifle/minigun
	name = "\improper 4.6mm Gatling Gun"
	desc = "It costs 10,000 credits to fire this weapon for 12 seconds."
	desc_extended = "A behemoth of a weapon, handle with care."
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/minigun.dmi'
	icon_state = "inventory"
	value = 10000

	tier = 4

	shoot_delay = 0.5 //Oh god oh fuck

	damage_mod = 1

	automatic = TRUE

	shoot_sounds = list('sound/weapons/223/shoot_mini.ogg')

	can_wield = TRUE
	wield_only = TRUE

	heat_max = 0.2

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = SIZE_5
	weight = 40

	ai_heat_sensitivity = 0

	attachment_whitelist = list()

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 11 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 13 - 16



	dan_mode = TRUE
	inaccuracy_modifier = 2
	movement_inaccuracy_modifier = 0.75
	movement_spread_base = 0.3

/obj/item/weapon/ranged/bullet/magazine/rifle/minigun/get_static_spread()
	return 0.03

/obj/item/weapon/ranged/bullet/magazine/rifle/minigun/get_skill_spread(var/mob/living/L)
	return max(0,0.1 - (0.1 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/minigun/get_shoot_delay(var/mob/caller,var/atom/target,location,params)
	. = ..()
	. += (heat_max - heat_current)*5
