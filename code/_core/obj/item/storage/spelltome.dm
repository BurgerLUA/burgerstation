/obj/item/storage/spelltome/
	name = "spelltome"
	desc_extended = "A spelltome that lets you create custom spells. Can hold more spell pages than what is required for easy storage. Point at a turf to cast."


	icon = 'icons/obj/items/weapons/ranged/magic/spellcraft/books.dmi'
	icon_state = "debug"

	size = 2

	is_container = TRUE
	container_max_size = 1

	dynamic_inventory_count = 8

/obj/item/storage/spelltome/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!isturf(object))
		return ..()

	if(get_dist(caller,object) > 1)
		return FALSE

	var/turf/T = object

	var/obj/item/weapon/ranged/magic/rune/S = make_spell(caller,inventory_to_list(),T)
	if(S)
		caller.to_chat(span("notice","You cast a rune on \the [T]."))
	else
		caller.to_chat(span("warning","You fail to cast anything!"))

	return TRUE


/obj/item/storage/spelltome/proc/make_spell(var/mob/caller,var/list/inventory_contents,var/turf/chosen_turf)

	var/list/buff_list = list()
	var/list/buff_color_list = list()

	var/list/effect_list = list()
	var/list/effect_color_list = list()

	var/list/modifier_list = list()
	var/list/modifier_color_list = list()

	for(var/A in inventory_contents)
		if(istype(A,/obj/item/spellpaper/))
			var/obj/item/spellpaper/P = A
			if(P.stored_effect)
				effect_list += P.stored_effect
				effect_color_list[P.stored_effect] = P.stored_effect_color
			if(P.stored_modifier)
				modifier_list += P.stored_modifier
				modifier_color_list[P.stored_modifier] = P.stored_modifier_color
			if(P.stored_buff)
				buff_list += P.stored_buff
				buff_color_list[P.stored_buff] = P.stored_buff_color

	if(!length(effect_list))
		return FALSE

	if(!length(modifier_list))
		modifier_list += "modifier_none"
		modifier_color_list["modifier_none"] = "#888888"

	if(!length(buff_list))
		buff_list += "buff_none"
		buff_color_list["buff_none"] = "#888888"

	var/final_effect = pick(effect_list)
	var/final_modifier = pick(modifier_list)
	var/final_buff = pick(buff_list)

	var/final_effect_color = effect_color_list[final_effect]
	var/final_modifier_color = modifier_color_list[final_modifier]
	var/final_buff_color = buff_color_list[final_buff]

	return new/obj/item/weapon/ranged/magic/rune(chosen_turf,caller,final_effect,final_modifier,final_buff,final_effect_color,final_modifier_color,final_buff_color)