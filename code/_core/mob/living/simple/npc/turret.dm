/mob/living/simple/npc/turret
	name = "turret"

	anchored = TRUE

	health_base = 200

	var/obj/item/weapon/ranged/stored_weapon

	ai = /ai/turret

	blood_type = /reagent/blood/robot

	pixel_x = 0
	pixel_y = 0
	pixel_z = 0

/mob/living/simple/npc/turret/face_atom(var/atom/A)
	return set_dir(get_dir(src,A))

/mob/living/simple/npc/turret/Finalize()

	if(stored_weapon)
		stored_weapon = new stored_weapon(src)
		INITIALIZE(stored_weapon)
		GENERATE(stored_weapon)
		FINALIZE(stored_weapon)

/mob/living/simple/npc/turret/attack(var/atom/attacker,var/atom/victim,var/list/params,var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE) //The src attacks the victim, with the blamed taking responsibility

	if(!stored_weapon)
		log_error("[src.get_debug_name()] didn't have a stored weapon!")
		qdel(src)
		return FALSE

	return stored_weapon.shoot(attacker,victim,null,params,1)

/mob/living/simple/npc/turret/syndicate/
	name = "syndicate turret"
	icon = 'icons/mob/living/simple/turret_syndie.dmi'
	icon_state = "active"

	iff_tag = "Syndicate"
	loyalty_tag = "Syndicate"

	stored_weapon = /obj/item/weapon/ranged/energy/syndicate_turret

/mob/living/simple/npc/turret/syndicate/post_death()
	icon_state = "dead"
	return ..()


/mob/living/simple/npc/turret/nanotrasen/
	name = "nanotrasen turret"
	icon = 'icons/mob/living/simple/turret_simple.dmi'
	icon_state = "active"

	iff_tag = "NanoTrasen"
	loyalty_tag = "NanoTrasen"

	stored_weapon = /obj/item/weapon/ranged/energy/nanotrasen_turret

/mob/living/simple/npc/turret/nanotrasen/post_death()
	icon_state = "dead"
	return ..()


/mob/living/simple/npc/turret/nanotrasen_deployable/
	name = "Depolyed sentry"
	icon = 'icons/mob/living/simple/turret_deployable.dmi'
	icon_state = "active"

	iff_tag = "NanoTrasen"
	loyalty_tag = "NanoTrasen"

	stored_weapon = /obj/item/weapon/ranged/energy/sentry_turret

/mob/living/simple/npc/turret/nanotrasen_deployable/post_death()
	icon_state = "dead"
	return ..()