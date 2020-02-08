/obj/item/weapon/ranged/bullet/magazine/pistol/tactical
	name = ".45 Tactical Pistol"
	desc = "No rubber rounds here; it's all lethal."
	desc_extended = "A common pistol used by moderern police forces as well as some private military corporations."
	value = 30

	icon = 'icons/obj/items/weapons/ranged/pistol/45.dmi'
	shoot_delay = 3
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 6

	automatic = FALSE

	size = SIZE_1
	weight = WEIGHT_2

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod
	name = ".45 Tactical Pistol MOD"
	desc = "It's like a Silver Eagle except not."
	desc_extended = "A heavier variant of the .45 Tactical Pistol. This one contains much more materials to reduce spread and recoil, however it has a slower cycle rate."
	value = 50
	icon = 'icons/obj/items/weapons/ranged/pistol/45_2.dmi'
	shoot_delay = 3
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 3

	size = SIZE_2
	weight = WEIGHT_3