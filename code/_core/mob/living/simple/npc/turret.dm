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
		log_error("[src.get_debug_name()] didn't have a stored weapon! Deleting!")
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


/mob/living/simple/npc/turret/deployable
	name = "deployed sentry"
	icon = 'icons/mob/living/simple/turret_deployable_2.dmi'
	icon_state = "living"

	stored_weapon = /obj/item/weapon/ranged/bullet/magazine/misc/sentry

	var/obj/item/powercell/stored_battery
	var/obj/item/magazine/stored_magazine

	ai = /ai/turret/deployable

/mob/living/simple/npc/turret/deployable/get_examine_list(var/mob/examiner)

	. = ..()

	var/obj/item/powercell/B = get_battery()
	if(B)
		. += div("notice","It has a battery installed. It has ([B.charge_current]/[B.charge_max]) charge.")
	else
		. += div("warning","It is missing a battery.")

	if(stored_magazine)
		. += div("notice","It has a magazine installed. It has [length(stored_magazine.stored_bullets)]/[stored_magazine.bullet_count_max] bullets.")
	else
		. += div("warning","It is missing a magazine.")

	return .



/mob/living/simple/npc/turret/deployable/proc/get_battery()
	return stored_battery

/mob/living/simple/npc/turret/deployable/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/powercell/))
		INTERACT_CHECK
		var/obj/item/powercell/PC = object

		if(stored_battery)
			caller.to_chat(span("notice","You swap out the battery of \the [src.name]."))
			stored_battery.drop_item(get_turf(src))
			stored_battery = null
		else
			caller.to_chat(span("notice","You insert a new battery into \the [src.name]."))

		PC.drop_item(src)
		stored_battery = PC

		return TRUE

	if(istype(object,/obj/item/magazine/))
		INTERACT_CHECK
		var/obj/item/magazine/M = object
		if(!istype(stored_weapon,/obj/item/weapon/ranged/bullet/magazine))
			caller.to_chat(span("warning","This turret doesn't accept magazines!"))
			return FALSE

		var/obj/item/weapon/ranged/bullet/magazine/R = stored_weapon
		if(!M.weapon_whitelist[R.type])
			caller.to_chat(span("warning","This turret doesn't accept this type of magazine!"))
			return FALSE

		if(stored_magazine)
			caller.to_chat(span("notice","You swap out the magazine of \the [src.name]."))
			stored_magazine.drop_item(get_turf(src))
			stored_magazine = null
		else
			caller.to_chat(span("notice","You insert a new magazine into \the [src.name]."))

		M.drop_item(src)
		stored_magazine = M

		return TRUE

	return ..()



/mob/living/simple/npc/turret/deployable/Destroy()
	QDEL_NULL(stored_battery)
	QDEL_NULL(stored_magazine)
	return ..()

/mob/living/simple/npc/turret/deployable/post_death()
	icon_state = "dead"
	return ..()

/mob/living/simple/npc/turret/deployable/proc/can_pack_up(var/mob/caller)

	if(get_dist(caller,src) > 1)
		caller.to_chat(span("warning","You're too far away to pack up \the [src.name]!"))
		return FALSE

	if(qdeleting || !isturf(src.loc))
		caller.to_chat(span("warning","You can't pack up \the [src.name] here!"))
		return FALSE

	return TRUE

/mob/living/simple/npc/turret/deployable/proc/pack_up(var/mob/caller)

	caller.visible_message("\The [caller.name] packs up \the [src.name].")

	var/obj/item/deployable/mob/sentry/S = new(get_turf(src))
	INITIALIZE(S)
	FINALIZE(S)
	if(stored_battery)
		S.stored_battery = stored_battery
		stored_battery.force_move(S)
		stored_battery = null
	if(stored_magazine)
		S.stored_magazine = stored_magazine
		stored_magazine.force_move(S)
		stored_magazine = null

	qdel(src)

	return TRUE

/mob/living/simple/npc/turret/deployable/drop_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(caller != object)
		return ..()

	INTERACT_CHECK_OTHER(src)

	if(can_pack_up(caller))
		caller.visible_message("\The [caller.name] starts to pack up \the [src.name]...")
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(5),.proc/pack_up,caller)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_pack_up,caller)

	return TRUE