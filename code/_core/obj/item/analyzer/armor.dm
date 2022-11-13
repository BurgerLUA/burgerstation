/obj/item/analyzer/armor
	name = "armor analyzer"
	desc = "Minmaxxing setups since 2520."
	desc_extended = "An incredible complex sensor that sends (mostly) harmless radiation waves to calculate the physical protection of an object."

	icon = 'icons/obj/item/analyzers/armor.dmi'
	icon_state = "inventory"
	value = 250

	var/scan_all = FALSE

/obj/item/analyzer/armor/can_be_scanned(var/mob/caller,var/atom/target)
	return is_living(target)

/obj/item/analyzer/armor/on_scan(var/mob/caller,var/atom/target,location,control,params)

	if(!target || !target.health)
		caller.to_chat(span("warning","No valid target detected!"))

	if(is_player(caller))
		var/mob/living/advanced/player/P = caller
		var/list/attack_coords = P.get_current_target_cords(params)
		params[PARAM_ICON_X] = attack_coords[1]
		params[PARAM_ICON_Y] = attack_coords[2]

	var/atom/object_to_analyze = target.get_object_to_damage(caller,caller,null,params,TRUE,TRUE,0)
	var/list/armor_list
	if(!scan_all)
		if(target == object_to_analyze)
			caller.to_chat(span("notice bold","Printing armor protection for \the [target.name]..."))
		else
			caller.to_chat(span("notice bold","Printing armor protection for \the [target.name]'s [object_to_analyze.name]..."))

		armor_list = target.health.get_defense(caller,object_to_analyze,TRUE)
	else if(is_advanced(target))
		var/health/mob/living/advanced/target_health = target.health
		armor_list = target_health.get_total_mob_defense(FALSE,TRUE)
	else
		caller.to_chat(span("notice","The armor scanner can only scan the total armor of advanced beings!"))
		return TRUE

	for(var/k in armor_list)
		if(k == "items")
			continue
		caller.to_chat(span("debug","[uppertext(k)]: [armor_list[k]]."))
	caller.to_chat(span("notice bold","End of message."))

	next_scan = world.time + SECONDS_TO_DECISECONDS(4)

	return TRUE
/obj/item/analyzer/armor/click_self(mob/caller, location, control, params)
	if(scan_all)
		scan_all = FALSE
		caller.to_chat(span("notice","You configure the [src.name] to scan body part armor."))
	else
		scan_all = TRUE
		caller.to_chat(span("notice","You configure the [src.name] to scan total armor."))
	. = ..()
