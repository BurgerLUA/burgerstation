/obj/item/weapon/ranged/bullet/magazine/smg/nanotech
	name = ".40 NanoTech submachine gun"
	icon = 'icons/obj/items/weapons/ranged/smg/40.dmi'
	icon_state = "inventory"

	shoot_delay = 1.25

	automatic = TRUE

	shoot_sounds = list('sound/weapons/40/shoot_smg.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 6

	slowdown_mul_held = HELD_SLOWDOWN_SMG

	size = SIZE_3
	weight = WEIGHT_3

	heat_per_shot = 0.01
	heat_max = 0.05

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

	value = 300

	ai_heat_sensitivity = 0.5

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/bullet_num = FLOOR((length(M.stored_bullets)/M.bullet_count_max)*17,1)
		icon_state = "[initial(icon_state)]_[bullet_num]"
	else
		icon_state = initial(icon_state)

	..()

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/get_static_spread() //Base spread
	return 0.02

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/get_skill_spread(var/mob/living/L) //Base spread
	return 0.03 - (0.03 * L.get_skill_power(SKILL_RANGED))