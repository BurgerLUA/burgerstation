/obj/item/analyzer/health
	name = "health analyzer"
	desc = "HOLD STILL AND LET ME TREAT YOU!"
	desc_extended = "A handheld portable health analyzer that prints the target's total received damage in an arbitary measurement. It also broadcasts the results of the scan for those who can't bother to read."
	rarity = RARITY_COMMON
	icon = 'icons/obj/item/analyzers/health.dmi'
	icon_state = "inventory"
	value = 150
	var/advanced = FALSE

/obj/item/analyzer/health/click_self(var/mob/caller)
	INTERACT_CHECK
	INTERACT_DELAY(1)
	advanced = !advanced
	caller.to_chat(span("notice","Advanced diagnostics is [advanced ? "enabled" : "disabled"]."))
	return TRUE

/obj/item/analyzer/health/can_be_scanned(var/mob/caller,var/atom/target)

	if(get_dist(caller,target) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	return is_living(target)

/obj/item/analyzer/health/on_scan(var/mob/caller,var/atom/target,location,control,params)

	next_scan = world.time + SECONDS_TO_DECISECONDS(4)

	. = "<b>Scan:</b> <font color='red'>[CEILING(target.health.get_loss(BRUTE),1)]</font>|<font color='yellow'>[CEILING(target.health.get_loss(BURN),1)]</font>|<font color='green'>[CEILING(target.health.get_loss(TOX),1)]</font>|<font color='blue'>[CEILING(target.health.get_loss(OXY),1)]</font>"
	new/obj/effect/chat_text(target,.,TRUE)

	if(advanced)
		var/species = "N/A"
		var/blood_type = "N/A"
		var/blood_volume = "N/A"
		var/blood_oxygen = "N/A"
		var/reagent_printout = "N/A"
		if(is_living(target))
			var/mob/living/L = target
			if(is_advanced(target))
				var/mob/living/advanced/A = target
				var/species/S = SPECIES(A.species)
				species = S.name
			else
				species = initial(L.name)
			if(L.blood_type)
				var/reagent/BT = REAGENT(L.blood_type)
				blood_type = BT.name
				blood_volume = "[L.blood_volume] ([FLOOR(L.blood_volume/L.blood_volume_max,0.01)*100]%)"
				blood_oxygen = "[FLOOR((L.blood_volume/L.blood_volume_max) + L.blood_oxygen,0.01)*100]%"

		if(target.reagents && length(target.reagents.stored_reagents))
			reagent_printout = ""
			for(var/r_id in target.reagents.stored_reagents)
				var/reagent/R = REAGENT(r_id)
				var/volume = target.reagents.stored_reagents[r_id]
				reagent_printout += "[R.name]: [volume]u<br>"
		. = "Name: [target.name]<br>Species: [species]<br>Blood Type: [blood_type]<br>Blood Volume: [blood_volume]<br>Blood Oxygen: [blood_oxygen]<br>Reagents (Blood):<br>[reagent_printout]"
		caller.to_chat(.)
		if(is_living(target))
			var/mob/living/L = target
			for(var/k in L.get_damage_description(caller,TRUE))
				caller.to_chat(k)

	return TRUE