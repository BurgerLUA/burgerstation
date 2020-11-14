/obj/item/weapon/ranged/bullet/magazine/misc/
	movement_spread_base = 0
	movement_spread_mul = 0



/obj/item/weapon/ranged/bullet/magazine/misc/sentry

	name = "\improper 5.56mm Gatling Gun"
	desc = "It costs 10,000 credits to fire this weapon for 12 seconds."
	desc_extended = ""
	icon = 'icons/obj/item/weapons/ranged/rifle/minigun.dmi'
	icon_state = "inventory"
	value = 3000

	shoot_delay = 1 //Oh god oh fuck

	automatic = TRUE

	shoot_sounds = list('sound/weapons/223/shoot_mini.ogg') //Need a fire sound that only lasts 0.5 seconds.

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 16

	heat_per_shot = 0.02
	heat_max = 0.2

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = 0
	weight = 0

	value = -1

	ai_heat_sensitivity = 0

	attachment_whitelist = list()

	firing_pin = /obj/item/firing_pin/electronic