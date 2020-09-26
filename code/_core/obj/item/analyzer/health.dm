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
	advanced = !advanced
	caller.to_chat(span("notice","Advanced diagnostics is [advanced ? "enabled" : "disabled"]."))
	return TRUE

/obj/item/analyzer/health/can_be_scanned(var/mob/caller,var/atom/target)

	if(get_dist(caller,target) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	return is_living(target)

/obj/item/analyzer/health/on_scan(var/mob/caller,var/atom/target,location,control,params)

	. = "<b>Scan:</b> <font color='red'>[CEILING(target.health.get_brute_loss(),1)]</font>|<font color='yellow'>[CEILING(target.health.get_burn_loss(),1)]</font>|<font color='green'>[CEILING(target.health.get_tox_loss(),1)]</font>|<font color='blue'>[CEILING(target.health.get_oxy_loss(),1)]</font>"
	new/obj/effect/chat_text(target,.,TRUE)

	if(advanced)
		var/species = "N/A"
		var/blood_type = "N/A"
		if(is_living(target))
			var/mob/living/L = target
			if(is_advanced(target))
				var/mob/living/advanced/A = target
				species = all_species[A.species].name
			else
				species = initial(L.name)
			var/reagent/BT = REAGENT(L.blood_type)
			blood_type = BT.name

		var/reagent_printout = ""
		if(target.reagents)
			if(length(target.reagents))
				for(var/r_id in target.reagents)
					var/reagent/R = REAGENT(r_id)
					var/volume = target.reagents[r_id]
					. += "[R.name]: [volume]u<br>"
			else
				reagent_printout = "None."
		else
			reagent_printout = "N/A"

		. = "Name: [target.name]<br>Species: [species]<br>Blood Type: [blood_type]<br>[.]<br>Reagents (Blood):[reagent_printout]"


	caller.to_chat(.)
	next_scan = world.time + SECONDS_TO_DECISECONDS(4)
	return TRUE