/obj/item/weapon/ranged/bullet/pump/shotgun/nt
	name = "12g Masterstroke Shotgun"
	desc = "Reliable, cheap, and strong."
	desc_extended = "A very robust pump action shotgun for Private Military Corporations."
	icon = 'icons/obj/item/weapons/ranged/shotgun/nt.dmi'
	icon_state = "inventory"
	value = 120

	shoot_delay = 4

	automatic = FALSE

	bullet_count_max = 6

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	can_wield = TRUE

	view_punch = 12

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN

	size = SIZE_4

	value = 130

	heat_per_shot = 0.02
	heat_max = 0.08

/obj/item/weapon/ranged/bullet/pump/shotgun/nt/get_base_spread() //For multiple bullets
	return 0.05

/obj/item/weapon/ranged/bullet/pump/shotgun/nt/get_static_spread() //Base spread
	if(!wielded)
		return 0.1
	return 0.001

/obj/item/weapon/ranged/bullet/pump/shotgun/nt/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))