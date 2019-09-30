/obj/structure/interactive/localmachine/ore_deposit
	name = "ore deposit"
	desc = "MINECRAFT."
	icon = 'icons/obj/structure/ore.dmi'
	icon_state = "deposit"
	var/obj/item/ore/stored_ore //We don't need to spawn this yet.
	var/chance_delete = 0
	alpha = 200

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/localmachine/ore_deposit/New(var/desired_loc)
	if(chance_delete && prob(chance_delete))
		qdel(src)
		return FALSE

	return ..()

/obj/structure/interactive/localmachine/ore_deposit/clicked_on_by_object(caller,object,location,control,params)

	INTERACT_CHECK

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		if(A in disallowed_mobs)
			return TRUE
		var/list/callback_list = list()
		callback_list["deposit"] = src
		callback_list["ore"] = stored_ore
		callback_list["start_turf"] = get_turf(A)
		add_progress_bar(A,"mine_ore",SECONDS_TO_DECISECONDS(10),callback_list)

	return TRUE


/obj/structure/interactive/localmachine/ore_deposit/iron
	name = "iron deposit"
	color = "#B5634F"
	desired_light_color = "#B5634F"
	desired_light_power = 0.1
	stored_ore = /obj/item/ore/iron

/obj/structure/interactive/localmachine/ore_deposit/copper
	name = "copper deposit"
	color = "#E28446"
	desired_light_color = "#E28446"
	desired_light_power = 0.1
	stored_ore = /obj/item/ore/copper


/obj/structure/interactive/localmachine/ore_deposit/tin
	name = "tin deposit"
	color = "#E2E2E2"
	desired_light_color = "#E2E2E2"
	desired_light_power = 0.1
	stored_ore = /obj/item/ore/tin


/obj/structure/interactive/localmachine/ore_deposit/zinc
	name = "zinc deposit"
	color = "#E8E8EF"
	desired_light_color = "#E8E8EF"
	desired_light_power = 0.1
	stored_ore = /obj/item/ore/zinc


/obj/structure/interactive/localmachine/ore_deposit/gold
	name = "gold deposit"
	color = "#FFE74F"
	desired_light_color = "#FFE74F"
	desired_light_power = 0.5
	stored_ore = /obj/item/ore/gold

/obj/structure/interactive/localmachine/ore_deposit/silver
	name = "silver deposit"
	color = "#E5E5EA"
	desired_light_color = "#E5E5EA"
	desired_light_power = 0.5
	stored_ore = /obj/item/ore/silver

/obj/structure/interactive/localmachine/ore_deposit/carbon
	name = "carbon deposit"
	color = "#0A0A0A"
	desired_light_color = "#0A0A0A"
	desired_light_power = 0
	stored_ore = /obj/item/ore/carbon

/obj/structure/interactive/localmachine/ore_deposit/aluminum
	name = "aluminum deposit"
	color = "#C4C4C4"
	desired_light_color = "#C4C4C4"
	desired_light_power = 0.25
	stored_ore = /obj/item/ore/aluminum

/obj/structure/interactive/localmachine/ore_deposit/plasma
	name = "phoron plasma deposit"
	color = "#B200B6"
	desired_light_color = "#B200B6"
	desired_light_power = 0.5
	stored_ore = /obj/item/ore/plasma