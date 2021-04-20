/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun
	name = "\improper 2x12mm Experimental Gauss Gun"
	desc = "We thank you, oh Monolith, for revealing the cunning plans of your enemies to us. May your light shine down on the souls of the brave soldiers who gave their lives in service to your will."
	desc_extended = "A super-accurate hi-tech weapon known as the Gauss rifle, this weapon was developed in secret laboratories located inside the russian facilities. The weapon operates by accelerating bullets to extremely high speeds using a system of electromagnets, which provides incredible stopping power with virtually no recoil."
	icon = 'icons/obj/item/weapons/ranged/rifle/gauss_gun.dmi'
	icon_state = "inventory"
	value = 1200

	shoot_delay = 20

	damage_mod = 1.3

	automatic = FALSE

	shoot_sounds = list('sound/weapons/russia/gauss.ogg')

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_4
	weight = 30

	heat_max = 0.06

	bullet_length_min = 11
	bullet_length_best = 12
	bullet_length_max = 13

	bullet_diameter_min = 1.75
	bullet_diameter_best = 2
	bullet_diameter_max = 2.25

	ai_heat_sensitivity = 2

	zoom_mul = 2

	attachment_whitelist = list()

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 25 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 15 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/revolutionary

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 2
	movement_spread_base = 0.15


/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0.001 - (0.002 * L.get_skill_power(SKILL_RANGED)))