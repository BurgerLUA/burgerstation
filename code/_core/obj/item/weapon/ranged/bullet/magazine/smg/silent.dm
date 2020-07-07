/obj/item/weapon/ranged/bullet/magazine/smg/tactical
	name = ".45 silent syndicate submachine gun"
	desc = "get that fukken disk...quietly."
	desc_extended = "A silent version of the C-20r used by Syndicate Stealth Ops."
	icon = 'icons/obj/items/weapons/ranged/smg/45.dmi'
	icon_state = "inventory"
	shoot_delay = 3
	view_punch = 4
	shoot_sounds = list('sounds/weapons/silenced/fire.ogg')

	heat_per_shot = 0.005
	heat_max = 0.05

/obj/item/weapon/ranged/bullet/magazine/smg/tactical/get_static_spread() //Base spread
	return 0.02

/obj/item/weapon/ranged/bullet/magazine/smg/tactical/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))