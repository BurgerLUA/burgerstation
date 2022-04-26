/ai/advanced/abductor

/ai/advanced/abductor/handle_attacking()

	. = ..()

	var/mob/living/advanced/A = owner

	if(!CALLBACK_EXISTS("\ref[src]_fuckoff") && objective_attack && objective_attack.has_status_effects(STAMCRIT,PAINCRIT))
		var/obj/hud/inventory/I = A.inventories_by_id[BODY_HAND_LEFT]
		if(istype(I) && istype(I.get_top_object(),/obj/item/clothing/hands/gloves/recall))
			A.do_say("Ayy lmao")
			A.visible_message(span("warning","\The [A.name] quickly presses a series of buttons on their left arm..."))
			CALLBACK("\ref[src]_fuckoff",SECONDS_TO_DECISECONDS(rand(1,2)),src,.proc/fuckoff)

/ai/advanced/abductor/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	var/mob/living/advanced/A = owner

	if(!CALLBACK_EXISTS("\ref[src]_fuckoff") && A.health && !A.dead && !qdeleting && !stealthy && A.health.health_current/A.health.health_max <= 0.5 && !A.has_status_effects(ZOMBIE,STUN,SLEEP,PARALYZE))
		var/obj/hud/inventory/I = A.inventories_by_id[BODY_HAND_LEFT]
		if(istype(I) && istype(I.get_top_object(),/obj/item/clothing/hands/gloves/recall))
			A.visible_message(span("warning","\The [A.name] quickly presses a series of buttons on their left arm..."))
			CALLBACK("\ref[src]_fuckoff",SECONDS_TO_DECISECONDS(rand(1,2)),src,.proc/fuckoff)


/ai/advanced/abductor/proc/fuckoff()
	var/mob/living/advanced/A = owner
	if(qdeleting || A.dead || A.has_status_effects(ZOMBIE,STUN,SLEEP,PARALYZE))
		return FALSE
	var/turf/T = get_turf(A)
	play_sound('sound/effects/space_phase.ogg',T)
	new /obj/effect/temp/phase/out(T)
	A.visible_message(span("danger","\The [A.name] teleports to safety!"))
	qdel(A)
	return TRUE