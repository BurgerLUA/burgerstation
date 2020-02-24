/obj/item/weapon/ranged/bullet/magazine/pistol/tactical
	name = ".45 Tac Pistol"
	desc = "No rubber rounds here; it's all lethal."
	desc_extended = "A common pistol used by moderern police forces as well as some private military corporations."
	value = 30

	icon = 'icons/obj/items/weapons/ranged/pistol/45.dmi'
	shoot_delay = 3
	shoot_sounds = list('sounds/weapons/45/shoot.ogg')

	view_punch = 6

	automatic = FALSE

	size = SIZE_1
	weight = WEIGHT_2

	heat_per_shot = 0.04
	heat_max = 0.2

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod
	name = ".45 Tac Pistol MOD"
	desc = "It's like a Silver Eagle except not."
	desc_extended = "The feeding ramp is polished to a mirror sheen. The slide's been reinforced. And the interlock with the frame is tightened for added precision. \
	The sight system is original, too. The thumb safety is extended to make it easier on the finger. A long-type trigger with non-slip grooves. A ring hammer... \
	The base of the trigger guard's been filed down for a higher grip. And not only that, nearly every part of this gun has been expertly crafted and customized. \
	Where'd you get something like this?"
	value = 50
	icon = 'icons/obj/items/weapons/ranged/pistol/45_2.dmi'
	shoot_delay = 3
	shoot_sounds = list('sounds/weapons/45/shoot_mod.ogg')

	view_punch = 3

	size = SIZE_2
	weight = WEIGHT_3

	heat_per_shot = 0.03
	heat_max = 0.15

