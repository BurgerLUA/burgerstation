/obj/item/weapon/ranged/bullet/magazine/misc/
	movement_spread_base = 0

	inaccuracy_modifier = 1

/obj/item/weapon/ranged/bullet/magazine/misc/sentry

	name = "\improper Sentry Gun"
	desc = ""
	desc_extended = ""
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/minigun.dmi'
	icon_state = "inventory"

	shoot_delay = 3

	automatic = TRUE

	shoot_sounds = list('sound/weapons/ranged/misc/sentry.ogg')

	can_wield = TRUE
	wield_only = TRUE

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

	value = 0

	anchored = TRUE

	tier = 1

/obj/item/weapon/ranged/bullet/magazine/misc/sentry/handle_empty(mob/caller)
	next_shoot_time = max(next_shoot_time,world.time + 20)
	return ..()

/obj/item/weapon/ranged/bullet/magazine/misc/sentry/handle_ammo(mob/caller)
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

/obj/item/weapon/ranged/bullet/magazine/misc/sentry/get_skill_spread(mob/living/L)
	return 0

/obj/item/weapon/ranged/bullet/magazine/misc/sentry/can_owner_shoot(mob/caller,atom/object,location,params)
	if(caller.is_player_controlled())
		return FALSE
	return ..()