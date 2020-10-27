/obj/item/hand_teleporter
	name = "hand teleporter"
	desc = "What could possibly go wrong?"
	desc_extended = "A magical hand teleporter used by people trying to break the fucking game."

	rarity = RARITY_MYTHICAL
	value = 3000

	var/obj/item/powercell/battery = /obj/item/powercell/

	icon = 'icons/obj/item/hand_tele.dmi'
	icon_state = "inventory"

	var/teleport_cost = CELL_SIZE_BASIC

	weight = 2

/obj/item/hand_teleporter/Generate()

	if(ispath(battery))
		battery = new battery(src)
		INITIALIZE(battery)
		GENERATE(battery)
		FINALIZE(battery)
		update_sprite()

	return ..()

/obj/item/hand_teleporter/update_icon()

	icon_state = initial(icon_state)

	if(!battery)
		icon_state = "[icon_state]_open"
	else
		var/obj/item/powercell/battery = get_battery()
		if(battery.charge_current < teleport_cost)
			icon_state = "[icon_state]_no_charge"

/obj/item/hand_teleporter/get_battery()
	return battery

/obj/item/hand_teleporter/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("battery")
	return .

/obj/item/hand_teleporter/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("battery")
	update_sprite()
	return .

/obj/item/hand_teleporter/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(battery && is_inventory(object))
		var/obj/hud/inventory/I = object
		if(I.add_held_object(battery))
			caller.to_chat(span("notice","You remove \the [battery.name] from \the [src.name]."))
			battery.update_sprite()
			battery = null
		else
			caller.to_chat(span("notice","You can't seem to remove \the [battery.name] from \the [src.name]!"))
		update_sprite()
		return TRUE

	if(istype(object,/obj/item/powercell))
		var/obj/item/PC = object
		if(PC.size > SIZE_3) //Only fits size 3.
			caller.to_chat(span("warning","\The [PC.name] is too large to be put into \the [src.name]!"))
			return TRUE
		if(battery)
			caller.to_chat(span("notice","You replace \the [battery.name] in \the [src.name] with \the [object.name] in your hand."))
			battery.update_sprite()
			battery.drop_item(get_turf(caller))
		else
			caller.to_chat(span("notice","You add \the [PC.name] to \the [src.name]."))
		PC.drop_item(src)
		battery = PC
		update_sprite()
		return TRUE

	return ..()

/obj/item/hand_teleporter/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	var/obj/item/powercell/PC = get_battery()
	if(!PC || PC.charge_current < teleport_cost)
		caller.to_chat(span("warning","\The [src.name] beeps, indicating a lack of charge!"))
		return FALSE

	var/turf/simulated/T = get_turf(object)

	if(!istype(T))
		return TRUE

	if(!T.is_safe_teleport())
		return FALSE

	caller.force_move(T)
	PC.charge_current -= teleport_cost

	update_sprite()

	return TRUE