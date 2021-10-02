/obj/item/weapon/ranged/bullet/magazine/misc/browning
	name = "\improper Browning Gun"
	desc = ""
	desc_extended = ""
	icon = 'icons/obj/item/weapons/ranged/mech.dmi'
	icon_state = "mech_ballistic"

	var/obj/structure/interactive/mountable/browning/linked_gun

	shoot_delay = 3

	automatic = TRUE

	shoot_sounds = list('sound/weapons/rifle_heavy/shoot.ogg')

	can_wield = TRUE
	wield_only = TRUE

	heat_max = 0.08

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	size = SIZE_4
	weight = 30

	ai_heat_sensitivity = 0.5

	attachment_whitelist = list()

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

	value_burgerbux = 1

	anchored = TRUE

	tier = 3

/obj/item/weapon/ranged/bullet/magazine/misc/browning/Destroy()
	QDEL_NULL(linked_gun)
	return ..()

/obj/item/weapon/ranged/bullet/magazine/misc/browning/handle_empty(var/obj/caller)
	next_shoot_time = world.time + 20
	return ..()

/obj/item/weapon/ranged/bullet/magazine/misc/browning/handle_ammo(var/obj/caller)
	if(!chambered_bullet) load_new_bullet_from_magazine(caller)
	linked_gun.mag_check()
	return ..()

/obj/item/weapon/ranged/bullet/magazine/misc/browning/get_magazine()

	if(istype(loc,/obj/structure/interactive/mountable/browning))
		var/obj/structure/interactive/mountable/browning/B = loc
		if(B.stored_magazine)
			return B.stored_magazine

	return null


/obj/item/weapon/ranged/bullet/magazine/misc/browning/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/misc/browning/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.075 - (0.1 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/misc/browning/can_owner_shoot(var/mob/caller,var/atom/object,location,params)
	if(angle2dir_cardinal(get_angle(caller,object)+90)==linked_gun.dir)
		return TRUE
	else
		caller.to_chat(span("warning","Your finger slips!"))
	return FALSE
