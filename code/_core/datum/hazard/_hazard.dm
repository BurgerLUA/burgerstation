/hazard/
	var/id = null

/hazard/proc/process_player_tick(var/mob/living/advanced/player/P)
	return TRUE

/hazard/cold
	id = "cold"

	var/base_damage = 0.5 // PER TARGETABLE LIMB. REMEMBER, THERE ARE 11 TARGETABLE LIMBS.
	var/list/threat_text = list(
		"You feel cold...",
		"You shiver as the cold surrounds you...",
		"The cold air hurts you..."
	)

/* rewrite
/hazard/cold/process_player_tick(var/mob/living/advanced/player/P)

	var/total_damage = 0
	var/list/all_damaged_organs = list()

	var/list/targetable_limbs = TARGETABLE_LIMBS

	for(var/k in P.labeled_organs)

		if(!(k in targetable_limbs) || !P.labeled_organs[k])
			continue

		var/obj/item/organ/O = P.labeled_organs[k]

		if(!O.health)
			continue

		var/damage_amount = base_damage - P.protection_cold[k]
		if(damage_amount > 0)
			all_damaged_organs += O.name

	if(total_damage)
		P.to_chat(span("warning",pick(threat_text)))
		P.to_chat(span("warning","You took [total_damage] burn damage from the cold! (Affected limbs: [english_list(all_damaged_organs)])"),CHAT_TYPE_COMBAT)

	return TRUE
*/
