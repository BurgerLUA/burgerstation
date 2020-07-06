/obj/item/analyzer/armor
	name = "armor analyzer"
	desc = "Minmaxxing setups since 2520."
	desc_extended = "An incredible complex sensor that sends (mostly) harmless radiation waves to calculate the physical protection of an object."
	icon = 'icons/obj/item/analyzers/armor.dmi'
	icon_state = "inventory"
	value = 250

/obj/item/analyzer/armor/can_be_scanned(var/mob/caller,var/atom/target)
	return is_living(target)

/obj/item/analyzer/armor/on_scan(var/mob/caller,var/atom/target,location,control,params)

	if(!target || !target.health)
		caller.to_chat(span("warning","No valid target detected!"))

	if(is_player(caller))
		var/mob/living/advanced/player/P = caller
		var/list/attack_coords = P.get_current_target_cords(params)
		params[PARAM_ICON_X] = num2text(attack_coords[1])
		params[PARAM_ICON_Y] = num2text(attack_coords[2])

	var/atom/object_to_analyze = target.get_object_to_damage(caller,caller,params,TRUE,TRUE,0)

	if(target == object_to_analyze)
		caller.to_chat(span("notice bold","Printing armor protection for \the [target.name]..."))
	else
		caller.to_chat(span("notice bold","Printing armor protection for \the [target.name]'s [object_to_analyze.name]..."))

	var/list/armor_list = target.health.get_defense(caller,object_to_analyze)

	for(var/k in armor_list)
		caller.to_chat("[uppertext(k)]: [armor_list[k]].")
	caller.to_chat(span("notice bold","End of message."))

	next_scan = world.time + SECONDS_TO_DECISECONDS(4)

	return TRUE