/obj/item/analyzer/armor
	name = "armor analyzer"
	desc = "Minmaxxing setups since 2520."
	desc_extended = "An incredible complex sensor that sends (mostly) harmless radiation waves to calculate the physical protection of an object."

	icon = 'icons/obj/item/analyzers/armor.dmi'
	icon_state = "inventory"
	value = 250

	var/scan_all = FALSE

/obj/item/analyzer/armor/can_be_scanned(var/mob/activator,var/atom/target)
	return is_living(target)

/obj/item/analyzer/armor/on_scan(var/mob/activator,var/atom/target,location,control,params)

	if(!target || !target.health)
		activator.to_chat(span("warning","No valid target detected!"))

	if(is_player(activator))
		var/mob/living/advanced/player/P = activator
		var/list/attack_coords = P.get_current_target_cords(params)
		params[PARAM_ICON_X] = attack_coords[1]
		params[PARAM_ICON_Y] = attack_coords[2]

	var/atom/object_to_analyze = target.get_object_to_damage(activator,activator,null,params,TRUE,TRUE,0)
	var/list/armor_list
	if(!scan_all)
		if(target == object_to_analyze)
			activator.to_chat(span("notice bold","Printing armor protection for \the [target.name]..."))
		else
			activator.to_chat(span("notice bold","Printing armor protection for \the [target.name]'s [object_to_analyze.name]..."))

		armor_list = target.health.get_defense(activator,object_to_analyze,TRUE)
	else if(is_advanced(target))
		var/mob/living/advanced/A = target
		armor_list = A.overall_clothing_defense_rating
	else
		activator.to_chat(span("notice","The armor scanner can only scan the total armor of advanced beings!"))
		return TRUE

	for(var/k in armor_list)
		if(k == "items")
			continue
		activator.to_chat(span("debug","[uppertext(k)]: [armor_list[k]]."))
	activator.to_chat(span("notice bold","End of message."))

	next_scan = world.time + SECONDS_TO_DECISECONDS(4)

	return TRUE
/obj/item/analyzer/armor/click_self(mob/activator, location, control, params)
	if(scan_all)
		scan_all = FALSE
		activator.to_chat(span("notice","You configure the [src.name] to scan an organ's defense value."))
	else
		scan_all = TRUE
		activator.to_chat(span("notice","You configure the [src.name] to scan total armor from clothing."))
	. = ..()
