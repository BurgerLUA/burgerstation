/obj/item/weapon/ranged/bullet/magazine/pistol
	name = "10mm Stechkin Pistol"
	desc = "The traitor's second best friend."
	desc_extended = "The standard Syndicate pistol. The compactness of the gun makes it useful in assassinations as well as a holdout weapon."
	icon = 'icons/obj/items/weapons/ranged/pistol/10mm.dmi'
	icon_state = "inventory"
	value = 50

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "10mm_auto"

	shoot_sounds = list('sounds/weapons/pistol/shoot.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 8

	cock_sound = 'sounds/weapons/gun_slide1.ogg'

	slowdown_mul_held = HELD_SLOWDOWN_PISTOL

	size = SIZE_1
	weight = WEIGHT_2

	heat_per_shot = 0.05
	heat_current = 0
	heat_max = 0.2

/obj/item/weapon/ranged/bullet/magazine/pistol/update_icon()

	icon_state = initial(icon_state)

	if(!chambered_bullet)
		icon_state = "[icon_state]_unloaded"

	if(!stored_magazine)
		icon_state = "[icon_state]_open"

	return ..()

/obj/item/weapon/ranged/bullet/magazine/pistol/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/pistol/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle
	name = ".50 Silver Eagle"
	desc = "Shiny!"
	desc_extended = "A proudly American made and designed<sup>\[citation needed\]</sup> 50 calibre pistol for the most elite of commanders. This one is silver plated."
	icon = 'icons/obj/items/weapons/ranged/pistol/50.dmi'
	value = 170
	projectile_speed = 28
	shoot_delay = 4
	bullet_type = ".50"
	shoot_sounds = list('sounds/weapons/deagle/shoot.ogg')

	view_punch = 12

	size = SIZE_2
	weight = WEIGHT_3

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/gold
	name = ".50 Gold Eagle"
	desc = "Now in gold!"
	desc_extended = "A proudly American made and designed<sup>\[citation needed\]</sup> 50 calibre pistol for the most elite of commanders. This one is gold plated."
	icon = 'icons/obj/items/weapons/ranged/pistol/50_gold.dmi'
	value = 240
	view_punch = 4
	size = SIZE_2
	weight = WEIGHT_4

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical
	name = ".45 Tactical Pistol"
	desc = "No rubber rounds here; it's all lethal."
	desc_extended = "A common pistol used by moderern police forces as well as some private military corporations."
	value = 30

	icon = 'icons/obj/items/weapons/ranged/pistol/45.dmi'
	shoot_delay = 2
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


/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/military
	name = ".45 Military Pistol"
	desc = "Even more tactical than the tactical pistol."
	desc_extended = "A military grade pistol amazingly chambered in .45. It shoots significantly faster than its tactical counterpart."
	value = 70
	icon = 'icons/obj/items/weapons/ranged/pistol/357.dmi'
	shoot_delay = 1
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 7

	automatic = FALSE

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/military/mod
	name = ".45 Military Pistol MOD"
	icon = 'icons/obj/items/weapons/ranged/pistol/357_2.dmi'
	desc_extended = "A modified variant of the .45 Military Pistol. The slider has been shortened, the frame replaced with lighter materials, and a recoil compensator was added for extra accuracy."
	value = 110
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 5

	automatic = TRUE

	size = SIZE_2
	weight = WEIGHT_1

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/military/mod/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/military/mod/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/military/mod/get_heat_spread()
	return ..() * 0.5

/obj/item/weapon/ranged/bullet/magazine/pistol/silenced
	name = "8mm Stealth Pistol"
	desc = "Does not come with traq rounds."
	desc_extended = "The ultimate Syndicate Assassin pistol. While chambered in 8mm, it can still pack a decent punch to unarmored targets."
	icon = 'icons/obj/items/weapons/ranged/pistol/8mm.dmi'
	value = 90
	shoot_delay = 4
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/silenced/fire.ogg')

	view_punch = 8

	automatic = FALSE

	size = SIZE_2
	weight = WEIGHT_2