/obj/item/weapon/ranged/bullet/magazine/rifle/carbine
	name = "\improper .223 Carbine"
	icon = 'icons/obj/items/weapons/ranged/rifle/223.dmi'
	icon_state = "inventory"
	shoot_delay = 2
	view_punch = 4
	shoot_sounds = list('sounds/weapons/223/shoot.ogg')

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	automatic = TRUE

	override_icon_state = TRUE

	size = SIZE_3
	weight = WEIGHT_3

	heat_per_shot = 0.03
	heat_max = 0.09

	value = 100

	ai_heat_sensitivity = 0.75

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/update_icon()

	icon_state = initial(icon_state)

	if(!stored_magazine)
		icon_state = "[icon_state]_open"
	else
		icon_state = "[icon_state]_[CEILING((length(stored_magazine.stored_bullets)/stored_magazine.bullet_count_max)*7, 1)]"

	return ..()


/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_static_spread() //Base spread
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.02 - (0.05 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_cock_sound(var/direction="both")
	return 'sounds/weapons/gun/smg/smg_rack.ogg'

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/mod
	name = ".223 Carbine MOD"
	icon = 'icons/obj/items/weapons/ranged/rifle/223_mod.dmi'
	heat_per_shot = 0.03
	heat_max = 0.12

	size = SIZE_2
	weight = WEIGHT_2

	value = 120

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/mod/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/mod/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.03 - (0.04 * L.get_skill_power(SKILL_RANGED)))