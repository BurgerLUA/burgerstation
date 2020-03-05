/obj/item/weapon/ranged/bullet/magazine/pistol/syndie
	name = "10mm Stechkin"
	desc = "The traitor's second best friend."
	desc_extended = "The standard Syndicate pistol. The compactness of the gun makes it useful in assassinations as well as a holdout weapon."
	icon = 'icons/obj/items/weapons/ranged/pistol/10mm.dmi'
	icon_state = "inventory"
	value = 40

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 1 //One in the chamber

	shoot_sounds = list('sounds/weapons/10/shoot.ogg')

	can_wield = FALSE

	view_punch = 8

	slowdown_mul_held = HELD_SLOWDOWN_PISTOL * 0.5

	size = SIZE_1
	weight = WEIGHT_2

	heat_per_shot = 0.05
	heat_max = 0.2

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11


/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/mod
	name = "10mm Stechkin MOD"
	icon = 'icons/obj/items/weapons/ranged/pistol/10mm_2.dmi'
	desc = "The traitor's second best friend."
	desc_extended = "A standard Syndicate pistol modified with better materials. This variant is less compact, it comes with a suppressor."

	size = SIZE_2

	shoot_sounds = list('sounds/weapons/10/shoot_mod.ogg')