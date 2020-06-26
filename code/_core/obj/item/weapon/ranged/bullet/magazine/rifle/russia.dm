//                                              Stockpile of slavic weapons.
/obj/item/weapon/ranged/bullet/magazine/rifle/russian //pls change the name of it to something else thank you - Stalkeros
	name = "\improper 7.62x39mm AK-13"  //not this one
	desc = "Ancient, but still powerful. Maybe."
	desc_extended = "The 7.62x39 is THE rifle for shady Eastern European uprisings. Reliable, inaccurate, and comes only in automatic to train those recruits to at least hit the target."
	icon = 'icons/obj/items/weapons/ranged/rifle/762_russia.dmi'
	icon_state = "inventory"
	value = 100

	shoot_delay = 2

	automatic = TRUE

	shoot_sounds = list('sounds/weapons/russian/abakan.oga') //Shooting sounds for both AK and Abakan were similar so uuh yes

	can_wield = TRUE

	view_punch = 12

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_3

	heat_per_shot = 0.02
	heat_max = 0.3

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 1.5

/obj/item/weapon/ranged/bullet/magazine/rifle/russian/get_static_spread() //Base spread
	if(!wielded)
		return 0.15
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/rifle/russian/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/abakan
	name = "\improper 5.45x39mm AN-94"
	desc = "A nuu cheeki breeki i v damkee!"
	desc_extended = "Weapon of the elite troops of the Russian army. It was developed as a replacement for the outdated AK-74. In the 'Abakan' not only the internal mechanisms are mobile, but the entire receiver along with the barrel, which allows you to reduce the recoil, therefore significantly increasing the accuracy."
	icon = 'icons/obj/items/weapons/ranged/rifle/rifle_545.dmi'
	icon_state = "inventory"
	value = 175

	shoot_delay = 0.75
	max_bursts = 2
	view_punch = 5

	shoot_sounds = list('sounds/weapons/russian/abakan.oga')

	can_wield = TRUE

	automatic = TRUE

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_3

	heat_per_shot = 0.01
	heat_max = 0.2

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 5.4
	bullet_diameter_best = 5.45
	bullet_diameter_max = 5.46  //Just so people wouldn't load this gun with 5.56, would be really-really weird to do so - Stalkeros

	ai_heat_sensitivity = 1.5

/obj/item/weapon/ranged/bullet/magazine/rifle/abakan/get_static_spread() //Base spread
	if(!wielded)
		return 0.08
	return 0.003

/obj/item/weapon/ranged/bullet/magazine/rifle/abakan/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/groza
	name = "\improper 9x39mm OTs-14 Groza"
	desc = "No need to pull the pin now."
	desc_extended = "This assault rifle combined with a grenade launcher, which is similar to the AKM series, was specifically developed for rapid response units. The main differences are its 9x39 caliber ammunition, bullpup layout and extensive configuration options."
	icon = 'icons/obj/items/weapons/ranged/rifle/939_groza.dmi'
	icon_state = "inventory"
	value = 175

	shoot_delay = 1.5

	automatic = TRUE

	shoot_sounds = list('sounds/weapons/russian/groza.oga')
	can_wield = TRUE

	view_punch = 4

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_3

	heat_per_shot = 0.02
	heat_max = 0.3

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	ai_heat_sensitivity = 1.5

/obj/item/weapon/ranged/bullet/magazine/rifle/groza/get_static_spread() //Base spread
	if(!wielded)
		return 0.06
	return 0.03

/obj/item/weapon/ranged/bullet/magazine/rifle/groza/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.008 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/val
	name = "\improper 9x39mm AS Val"
	desc = "The last thing you never hear."
	desc_extended = "A modified version of the silent Vintorez sniper rifle, the assault rifle was designed as a special forces weapon."
	icon = 'icons/obj/items/weapons/ranged/rifle/939_val.dmi'
	icon_state = "inventory"
	value = 200

	shoot_delay = 2

	automatic = TRUE

	shoot_sounds = list('sounds/weapons/russian/val.oga')

	can_wield = TRUE

	view_punch = 2.5

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_3

	heat_per_shot = 0.02
	heat_max = 0.3

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	ai_heat_sensitivity = 1.5

/obj/item/weapon/ranged/bullet/magazine/rifle/val/get_static_spread() //Base spread
	if(!wielded)
		return 0.04
	return 0.002

/obj/item/weapon/ranged/bullet/magazine/rifle/val/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.014 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez
	name = "\improper 9x39mm VSS Vintorez"
	desc = "The last thing you never see."
	desc_extended = "A special military sniper rifle purpose-built for silent, flashless sniping during special operations where early detection of the shooter may be critical."
	icon = 'icons/obj/items/weapons/ranged/rifle/939_vintar.dmi'
	icon_state = "inventory"

	shoot_delay = 3.5

	automatic = TRUE

	shoot_sounds = list('sounds/weapons/russian/val.oga') // similar shooting sounds so yes

	can_wield = TRUE
	wield_only = FALSE

	view_punch = 3.5

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_4

	heat_per_shot = 0.07
	heat_max = 0.49

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	size = SIZE_4
	weight = WEIGHT_5

	value = 250

	ai_heat_sensitivity = 2

	inaccuracy_modifer = 0.09

/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez/get_static_spread() //Base spread
	if(!wielded)
		return 0.02
	return 0.0005

/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.02 - (0.004 * L.get_skill_power(SKILL_RANGED)))