/obj/item/weapon/ranged/bullet/revolver/rocket
	name = "70mm NT Personnel Anti Armor Weapon System" // this shouldve been unreloadable, couldnt find out how to
	desc = "I'm a Rocket Man."
	desc_extended = "NT's answer to the Syndicate Mechs and Borgs: NT PAWS. Single-shot portable anti-tank weapon, though you could use it on the freaks you see around the station."
	icon = 'icons/obj/item/weapons/ranged/misc/rocket.dmi'
	icon_state = "inventory"
	value = 10000

	automatic = FALSE

	bullet_count_max = 1

	shoot_sounds = list('sound/weapons/rocket/shoot.ogg')

	can_wield = TRUE

	size = SIZE_5
	weight = 16

	zoom_mul = 2

	bullet_length_min = 750
	bullet_length_best = 800
	bullet_length_max = 850

	bullet_diameter_min = 65
	bullet_diameter_best = 70
	bullet_diameter_max = 75

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 1

/obj/item/weapon/ranged/bullet/revolver/rocket/get_base_spread()
	return 0.2

/obj/item/weapon/ranged/bullet/revolver/rocket/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/revolver/rocket/get_skill_spread(var/mob/living/L)
	return max(0,0.03 - (0.12 * L.get_skill_power(SKILL_RANGED)))