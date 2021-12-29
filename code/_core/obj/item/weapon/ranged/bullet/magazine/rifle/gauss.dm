/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun
	name = "\improper 2.54x12mm Experimental Gauss Rifle"
	desc = "We thank you, oh Monolith, for revealing the cunning plans of your enemies to us. May your light shine down on the souls of the brave soldiers who gave their lives in service to your will."
	desc_extended = "A super-accurate hi-tech weapon known as the Gauss rifle, this weapon was developed in secret laboratories located inside the russian facilities. The weapon operates by accelerating bullets to extremely high speeds using a system of electromagnets, which provides incredible stopping power with virtually no recoil."
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/gauss.dmi'
	icon_state = "inventory"
	value = 12000

	tier = 3

	shoot_delay = 25

	damage_mod = 2

	automatic = FALSE

	shoot_sounds = list('sound/weapons/russia/gauss.ogg')

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_5
	weight = 13.37*2

	heat_max = 0.04
	view_punch_mod = 0

	bullet_length_min = 11
	bullet_length_best = 12
	bullet_length_max = 14

	bullet_diameter_min = 1
	bullet_diameter_best = 2.54
	bullet_diameter_max = 3

	ai_heat_sensitivity = 2

	zoom_mul = 3

	attachment_whitelist = list()

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 25 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 15 - 16

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 2
	movement_spread_base = 0.15

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/get_skill_spread(var/mob/living/L)
	return max(0.001 - (0.001 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/auto
	name = "\improper 2x12mm Gauss Carbine"
	desc = "STOP POSTING ABOUT MONOLITH! I'M TIRED OF SEEING IT!"
	desc_extended = "The finalized design of the Gauss Gun. Further research and improvements in materials have given it the durability and power efficiency it needs to fire automatically. However, creating even one of this is such an expense that only the Space Russian Military are seen using these. You have to be seriously lucky to get your hands on this." //mucho texto
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/gauss_carbine.dmi'
	icon_state = "inventory"
	rarity = RARITY_MYTHICAL
	value = 15000

	tier = 3

	shoot_delay = 6

	damage_mod = 1.2

	automatic = TRUE

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_5
	weight = 13.37

	heat_max = 0.1

	ai_heat_sensitivity = 2

	zoom_mul = 1

	attachment_whitelist = list()

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 25 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 15 - 16

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 2
	movement_spread_base = 0.075

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/auto/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/auto/get_skill_spread(var/mob/living/L)
	return max(0.01 - (0.01 * L.get_skill_power(SKILL_RANGED)))
