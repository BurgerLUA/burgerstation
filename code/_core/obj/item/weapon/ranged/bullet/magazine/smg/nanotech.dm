/obj/item/weapon/ranged/bullet/magazine/smg/nanotech
	name = "9x19mm NanoTech SMG"
	desc = "For when you can't aim."
	desc_extended = "Nanotrasen's answer to the fearsome C-20r, this one has a higher firerate at the cost of a smaller round."
	icon = 'icons/obj/item/weapons/ranged/smg/9mm_2.dmi'
	icon_state = "inventory"

	shoot_delay = 1.25

	automatic = TRUE

	shoot_sounds = list('sound/weapons/40/shoot_smg.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 6

	slowdown_mul_held = HELD_SLOWDOWN_SMG

	size = SIZE_3

	heat_per_shot = 0.02
	heat_max = 0.05

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	value = 200

	ai_heat_sensitivity = 0.5

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/bullet_num = FLOOR((length(M.stored_bullets)/M.bullet_count_max)*9,1)
		icon_state = "[initial(icon_state)]_[bullet_num]"
	else
		icon_state = initial(icon_state)

	world.log << "Icon state: [icon_state]."


	return ..()

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/get_static_spread() //Base spread
	return 0.02

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/get_skill_spread(var/mob/living/L) //Base spread
	return 0.03 - (0.03 * L.get_skill_power(SKILL_RANGED))