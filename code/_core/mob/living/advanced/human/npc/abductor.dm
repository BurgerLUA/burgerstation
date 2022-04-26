/mob/living/advanced/npc/abductor
	name = "abductor"
	desc = "Ayy lmao. The most annoying thing in the known universe."
	ai = /ai/advanced

	var/list/possible_outfits = list(
		/loadout/abductor = 40,
		/loadout/abductor/tourist = 1,
		/loadout/abductor/scientist = 80,
		/loadout/abductor/soldier = 80
	)

	var/loadout_to_level = list(
		/loadout/abductor = 1,
		/loadout/abductor/tourist = 1,
		/loadout/abductor/scientist = 2,
		/loadout/abductor/soldier = 4
	)

	level = 20

	species = "abductor"

	sex = NEUTER
	gender = NEUTER

	loyalty_tag = "Abductor"
	iff_tag = "Abductor"

/mob/living/advanced/npc/abductor/Initialize()

	var/loadout_to_use = pickweight(possible_outfits)
	level *= loadout_to_level[loadout_to_use]

	. = ..()

	update_all_blends()

	equip_loadout(loadout_to_use)

/mob/living/advanced/npc/abductor/proc/fuck_off()
	if(qdeleting || dead || has_status_effects(ZOMBIE,STUN,SLEEP,PARALYZE))
		return FALSE
	src.visible_message(span("danger","\The [src.name] teleports to safety!"))
	qdel(src)
	return TRUE


/mob/living/advanced/npc/abductor/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(!CALLBACK_EXISTS("\ref[src]_fuckoff") && health && !dead && !qdeleting && !stealthy && health.health_current/health.health_max <= 0.25 && !has_status_effects(ZOMBIE,STUN,SLEEP,PARALYZE))
		var/obj/hud/inventory/I = inventories_by_id[BODY_HAND_LEFT]
		if(istype(I) && istype(I.get_top_object(),/obj/item/clothing/hands/gloves/recall))
			src.visible_message(span("warning","\The [src.name] quickly presses a series of buttons on their left arm..."))
			CALLBACK("\ref[src]_fuckoff",SECONDS_TO_DECISECONDS(rand(1,3)),src,.proc/fuck_off)


