/obj/item/weapon/ranged/bullet/magazine/misc/
	movement_spread_base = 0
	movement_spread_mul = 0

/obj/item/weapon/ranged/bullet/magazine/misc/sentry

	name = "\improper Sentry Gun"
	desc = ""
	desc_extended = ""
	icon = 'icons/obj/item/weapons/ranged/rifle/minigun.dmi'
	icon_state = "inventory"

	shoot_delay = 3

	automatic = TRUE

	shoot_sounds = list('sound/weapons/223/shoot_mini.ogg') //Need a fire sound that only lasts 0.5 seconds.

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 16

	heat_per_shot = 0.002
	heat_max = 0.01

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = 0
	weight = 0

	ai_heat_sensitivity = 0

	attachment_whitelist = list()

	firing_pin = /obj/item/firing_pin/electronic

	value = -1

	anchored = TRUE

/obj/item/weapon/ranged/bullet/magazine/misc/sentry/handle_empty(var/mob/caller)
	next_shoot_time = world.time + 20
	return ..()

/obj/item/weapon/ranged/bullet/magazine/misc/sentry/handle_ammo(var/mob/caller)
	if(!chambered_bullet) load_new_bullet_from_magazine(caller)
	return ..()

/obj/item/weapon/ranged/bullet/magazine/misc/sentry/get_magazine()

	if(istype(loc,/mob/living/simple/turret/deployable))
		var/mob/living/simple/turret/deployable/D = loc
		if(D.stored_magazine)
			return D.stored_magazine

	return null


/obj/item/weapon/ranged/bullet/magazine/misc/sentry/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/misc/sentry/get_skill_spread(var/mob/living/L)
	return 0

/obj/item/weapon/ranged/bullet/magazine/misc/sentry/can_owner_shoot(var/mob/caller,var/atom/object,location,params)
	if(caller.is_player_controlled())
		return FALSE
	return ..()