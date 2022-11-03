/obj/structure/interactive/localmachine/ore_deposit
	name = "ore deposit"
	desc = "MINECRAFT."
	icon = 'icons/obj/structure/ore.dmi'
	icon_state = "deposit"
	var/obj/item/material/ore/stored_ore //We don't need to spawn this yet.
	var/chance_delete = 0
	alpha = 200

/obj/structure/interactive/localmachine/ore_deposit/New(var/desired_loc)
	if(chance_delete && prob(chance_delete))
		qdel(src)
		return FALSE

	return ..()

/obj/structure/interactive/localmachine/ore_deposit/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller

		object = object.defer_click_on_object()

		if(!is_item(object))
			A.to_chat(span("notice","You need a mining tool in order to mine \the [src.name]."))
			return TRUE

		var/obj/item/I = object

		if(!(I.flags_tool & FLAG_TOOL_PICKAXE))
			A.to_chat(span("notice","You need a mining tool in order to mine \the [src.name]."))
			return TRUE

		if(A in disallowed_mobs)
			return TRUE
		var/list/callback_list = list()
		callback_list["deposit"] = src
		callback_list["ore"] = stored_ore
		callback_list["start_turf"] = get_turf(A)
		add_progress_bar(A,"mine_ore",I.tool_speed,callback_list)

	return TRUE


/obj/structure/interactive/localmachine/ore_deposit/iron
	name = "iron deposit"
	icon_state = "deposit_iron"
	stored_ore = /obj/item/material/ore/iron

/obj/structure/interactive/localmachine/ore_deposit/copper
	name = "copper deposit"
	color = "#E28446"
	stored_ore = /obj/item/material/ore/copper


/obj/structure/interactive/localmachine/ore_deposit/tin
	name = "tin deposit"
	color = "#E2E2E2"
	stored_ore = /obj/item/material/ore/tin


/obj/structure/interactive/localmachine/ore_deposit/zinc
	name = "zinc deposit"
	color = "#E8E8EF"
	stored_ore = /obj/item/material/ore/zinc


/obj/structure/interactive/localmachine/ore_deposit/gold
	name = "gold deposit"
	icon_state = "deposit_gold"
	stored_ore = /obj/item/material/ore/gold

/obj/structure/interactive/localmachine/ore_deposit/silver
	name = "silver deposit"
	icon_state = "deposit_silver"
	stored_ore = /obj/item/material/ore/silver

/obj/structure/interactive/localmachine/ore_deposit/carbon
	name = "coal deposit"
	icon_state = "deposit_coal"
	stored_ore = /obj/item/material/ore/carbon

/obj/structure/interactive/localmachine/ore_deposit/aluminum
	name = "aluminum deposit"
	color = "#C4C4C4"
	stored_ore = /obj/item/material/ore/aluminum

/obj/structure/interactive/localmachine/ore_deposit/plasma
	name = "phoron plasma deposit"
	icon_state = "deposit_phoron"
	stored_ore = /obj/item/material/ore/plasma