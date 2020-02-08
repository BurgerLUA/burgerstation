/obj/item/weapon/ranged/bullet/magazine/pistol/
	override_icon_state = TRUE


/obj/item/weapon/ranged/bullet/magazine/pistol/update_icon()

	icon_state = initial(icon_state)

	if(!chambered_bullet)
		icon_state = "[icon_state]_unloaded"

	if(!stored_magazine)
		icon_state = "[icon_state]_open"

	world.log << "First Icon state: [icon_state]."

	. = ..()

	world.log << "Second Icon state: [icon_state]."

	return .

/obj/item/weapon/ranged/bullet/magazine/pistol/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/pistol/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))