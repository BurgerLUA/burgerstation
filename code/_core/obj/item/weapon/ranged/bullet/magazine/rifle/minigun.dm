/obj/item/weapon/ranged/bullet/magazine/rifle/minigun
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

	view_punch = 10

	heat_per_shot = 0.01
	heat_max = 0.15

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = SIZE_5
	weight = 60

	ai_heat_sensitivity = 0

	attachment_whitelist = list()

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 11 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 13 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

	dan_mode = TRUE

/obj/item/weapon/ranged/bullet/magazine/rifle/minigun/get_static_spread()
	if(!wielded)
		return 0.5
	return 0.1

/obj/item/weapon/ranged/bullet/magazine/rifle/minigun/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.075 - (0.1 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/minigun/get_shoot_delay(var/mob/caller,var/atom/target,location,params)
	. = ..()
	. += (heat_max - heat_current)*10
	return .