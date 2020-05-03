/obj/item/weapon/ranged/bullet/magazine/pistol/deagle
	name = ".50 Silver Eagle"
	desc = "Shiny!"
	desc_extended = "A proudly American made and designed<sup>\[citation needed\]</sup> 50 calibre pistol for the most elite of commanders. This one is silver plated."
	icon = 'icons/obj/items/weapons/ranged/pistol/50.dmi'
	value = 170
	shoot_delay = 4
	shoot_sounds = list('sounds/weapons/50/shoot.ogg')

	view_punch = 20

	size = SIZE_2
	weight = WEIGHT_3

	heat_per_shot = 0.06
	heat_max = 0.3

	bullet_length_min = 30
	bullet_length_best = 33
	bullet_length_max = 36

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/get_static_spread() //Base spread
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.02 - (0.03 * L.get_skill_power(SKILL_RANGED)) )

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/mod
	name = ".50 Gold Eagle"
	desc = "Now in gold!"
	desc_extended = "A proudly American made and designed<sup>\[citation needed\]</sup> 50 calibre pistol for the most elite of commanders. This one is gold plated, and provides no tactical advantage whatsoever."
	icon = 'icons/obj/items/weapons/ranged/pistol/50_gold.dmi'
	value = 240
	weight = WEIGHT_5